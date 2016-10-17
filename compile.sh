cd /Users/solohin/Sites/data5_github;

git pull;
git add .;
git commit -m "$1" ;
git push ;

echo "#####################################";
echo "### PUSH SOURCE COMPLETE          ###";
echo "#####################################";

spress site:build;

echo "#####################################";
echo "### BUILD COMPLETE                ###";
echo "#####################################";

rm -rf /Users/solohin/Sites/data5_github_pages/*;
cp -R /Users/solohin/Sites/data5_github/build/* /Users/solohin/Sites/data5_github_pages;
cd /Users/solohin/Sites/data5_github_pages/;
git pull;
git add .;
git commit -m "$1" ;
git push ;

echo "#####################################";
echo "### PUSH HTML COMPLETE            ###";
echo "#####################################";

cd /Users/solohin/Sites/data5_github;
