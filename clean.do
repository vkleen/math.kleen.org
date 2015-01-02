find -name '*.html' -not -path './nginx/*' -not -path './htdocs/*' -delete
find -name '*.md' -not -path './posts/*' -not -name 'about.md' -delete
rm tex -rf