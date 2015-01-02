find -name '*.html' -not -path './nginx/*' -not -path './htdocs/*' -delete
find -name '*.md' -not -path './posts/*' -delete
rm tex -rf