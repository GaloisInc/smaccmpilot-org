--------------------------------------------------------------------------------
{-# LANGUAGE OverloadedStrings #-}
import           Control.Applicative ((<$>))
import           Data.Monoid         (mappend, mconcat)
import           Hakyll
import           System.FilePath     (dropFileName)

import           Sidebar
--------------------------------------------------------------------------------

-- Sitemap is used to generate the navbars
sitemap :: PageTree
sitemap = Tree "/" "Home"
  [ (Page "index.html" "Overview")
  , (Tree "software"   "Software"  softwarepages)
  , (Tree "hardware"   "Hardware"  hardwarepages)
  , (Page "media.html" "Media")
  , (Page "about.html" "About")
  ]
  where
  hardwarepages =
    [ Page "index.html"            "Overview"
    , Page "iris.html"             "Iris+ add-ons"
    , Group "Debugging"
      [ Page "blackmagic.html"       "Debugger"
      ]
    , Group "Sensors"
      [ Page "calibration.html"      "Calibration"
      ]
    , Group "Modifications"
      [ Page "lidar_and_sonar_mounting.html"             "Lidar and PX4Flow"
      , Page "tk1_daughterboard.html"             "TK1 daughterboard"
      , Page "pixycam.html"             "Pixy Cam"
      ]
    , Group "Controllers"
      [ Page "rc-controller.html"    "Radio Control"
      , Page "rc-controller-examples.html"    "Supported Radio Controllers"
      , Page "xbox.html"    "Gamepad Control"
      ]
    ]
  softwarepages =
    [ Page "index.html"           "Introduction"
    , Page "properties.html"      "Properties and Evidence"
    , Group "Development"
      [ Page "build.html"             "Building"
      , Page "loading.html"           "Loading"
      , Page "standalone.html"        "Stand-alone flight setup"
      , Page "demo.html"              "Demo flight setup"
      , Page "preflight.html"         "Flight preparation"
      ]
    , Group "Ground Control Software"
      [ Page "gcs-overview.html"      "Overview"
      ]
    , Group "Communications Security"
      [ Page "commsec-overview.html" "Overview"
      ]
    , Group "Examples"
      [ Page "demo_script.html" "Demo flight"
      , Page "attack_details.html" "Attack description"
      ]
    ]

standardPandocPagesSubdir d = do
    match (fromGlob ("pages/" ++ d ++ "*.md")) $ do
        route   $ gsubRoute "pages/"  (const "") `composeRoutes`
                  setExtension "html"
        compile $ pandocCompiler >>= (templated "templates/standard.html")

config :: Configuration
config = defaultConfiguration { deployCommand = deploy }
  where
  path = "/srv/www/smaccmpilot.org/public_html/"
  server = "scholomance.galois.com"
  deploy = "scp -r _site/* " ++ server ++  ":" ++ path
    -- scp sets the group wrong, we need to change all of the items
    -- we own to group smaccm, supressing errors for the items we do not own
    ++ " && ssh " ++ server ++  " chgrp -R -f smaccm "  ++  path
    ++ " ;  ssh " ++ server ++  " chmod -R -f g+w "  ++  path
    ++ " ;  exit 0"

main :: IO ()
main = hakyllWith config $ do

    match "images/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "artifacts/*" $ do
        route   idRoute
        compile copyFileCompiler

    match "css/*" $ do
        route   idRoute
        compile compressCssCompiler

    match "bootstrap/css/*" $ do
        route   $ gsubRoute "bootstrap/" (const "")
        compile compressCssCompiler

    match "bootstrap/js/*.js" $ do
        route   $ gsubRoute "bootstrap/" (const "")
        compile copyFileCompiler

    match "jquery/*.js" $ do
        route   $ gsubRoute "jquery/" (const "js/")
        compile copyFileCompiler

    match "bootstrap/img/*" $ do
        route   $ gsubRoute "bootstrap/" (const "")
        compile copyFileCompiler

    match "pages/index.md" $ do
        route   $ gsubRoute "pages/"  (const "") `composeRoutes`
                  setExtension "html"
        compile $ pandocCompiler >>= (templated "templates/frontpage.html")

    match "templates/*" $ compile templateCompiler

    standardPandocPagesSubdir ""
    standardPandocPagesSubdir "hardware/"
    standardPandocPagesSubdir "software/"


navbar :: FilePath -> String
navbar currentpath = unlines $
  [ "<ul class=\"nav\"> "
  , entry "/index.html"           "Home"
  , entry "http://ivorylang.org" "Languages"
  , entry "/software/index.html"  "Software"
  , entry "/hardware/index.html"  "Hardware"
  , entry "/media.html"         "Media"
  , entry "/about.html"           "About"
  , "</ul>"
  ]
  where
  entry path desc =
    "<li" ++ (emphif path) ++ "><a href=\"" ++ path ++ "\">" ++
    desc ++ "</a></li> "
  emphif path = if under path then " class=\"active\" " else ""
  under path | rootdir path = path == currentpath
             | otherwise    = dropFileName path == dropFileName currentpath
  rootdir path = dropFileName path == "/"

templated :: Identifier -> Item String -> Compiler (Item String)
templated t input = loadAndApplyTemplate t ctx input >>= relativizeUrls
  where
  ctx :: Context String
  ctx = mconcat
    [ field "navbar"    $ \item -> return (navbar (itemFilePath item))
    , field "sidebar"   $ \item -> return (sidebarHTML sitemap item)
    , field "directory" $ \item -> return (itemDirectory item)
    , field "filepath"  $ \item -> return (itemFilePath item)
    , constField "copyright" "<p>&copy; Galois Inc. 2017</p>"
    , defaultContext
    ]

