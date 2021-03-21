#!/bin/bash
wget \
     --recursive \
     --span-hosts \
     --adjust-extension \
     --compression=auto \
     -e robots=off \
     --convert-links -Duploads-ssl.webflow.com,webflow.io \
     --directory-prefix=download_from_webflow/ https://siyu-portfolio.webflow.io/404

mv download_from_webflow/siyu-portfolio.webflow.io/*  download_from_webflow/
rm -r download_from_webflow/siyu-portfolio.webflow.io

mv download_from_webflow/uploads-ssl.webflow.com/603c54506a6e6f2e48a72066/ download_from_webflow/assets/

rm -r download_from_webflow/uploads-ssl.webflow.com

path_old='../uploads-ssl.webflow.com/603c54506a6e6f2e48a72066/'
path_new='assets/'

grep -rli $path_old download_from_webflow/ | xargs -I@ sed -i '' "s%$path_old%$path_new%g"  @
 
weflow_badge_css='.w-webflow-badge,.w-webflow-badge.*vertical-align:middle !important}'
new_weflow_badge_css='.w-webflow-badge,.w-webflow-badge *{display:none;}.w-webflow-badge{display:none;}.w-webflow-badge>img{display:none;}'

grep -rli $weflow_badge_css download_from_webflow/assets/css| xargs -I@ sed -i '' "s%$weflow_badge_css%$new_weflow_badge_css%g"  @

find download_from_webflow/ -type f \( -iname \*.html -o -iname \*.js -o -iname \*.css \) | xargs -I@ js-beautify @ -o @

wget \
     --adjust-extension \
     --compression=auto \
     -e robots=off \
     --directory-prefix=download_from_webflow/ http://siyu-portfolio.webflow.io/sitemap.xml


webflow_address='https://siyu-portfolio.webflow.io'
my_address='https://www.siyu-liu.com'
sed -i '' "s%$webflow_address%$my_address%g"  download_from_webflow/sitemap.xml

