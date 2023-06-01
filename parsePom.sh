tagName="artifactId"
#grep -o "<$tagName[^>]*>[^<]*</$tagName>" pom.xml | sed -E 's/<artifactId>(.*)<\/artifactId>/\1/'
#grep -o "<$tagName[^>]*>[^<]*</$tagName>" pom.xml | sed -E 's/<$tagName>(.*)<\/$tagName>/\1/'
#grep -o "<$tagName[^>]*>[^<]*</$tagName>" pom.xml

folder=pom

fileList=($(ls $folder -1))
for j in ${!fileList[@]}; do
	filePath=$folder/${fileList[j]}
	# dependency tag column number array
	startArray=($(cat $filePath | grep -n '<dependency>' | awk -F ':' '{print $1}'))
	endArray=($(cat $filePath | grep -n '</dependency>' | awk -F ':' '{print $1}'))

	for i in ${!startArray[@]}; do
	  #division=$(cat pom.xml | head -${endArray[i]} | tail -`expr ${endArray[i]} - ${startArray[i]} + 1`)
	  #artifactId=$(cat $division | grep -o "<artifactId[^>]*>[^<]*</artifactId>" | sed -E 's/<artifactId>(.*)<\/artifactId>/\1/')
	  #version=$(cat $division | grep -o "<version[^>]*>[^<]*</version>" | sed -E 's/<version>(.*)<\/version>/\1/')
	  #roupId=$(cat $division | grep -o "<groupId[^>]*>[^<]*</groupId>" | sed -E 's/<groupId>(.*)<\/groupId>/\1/')

	  artifactId=" "
	  version=" "
	  groupId=" "
	  artifactId=$(cat $filePath | head -${endArray[i]} | tail -`expr ${endArray[i]} - ${startArray[i]} + 1` | grep -o "<artifactId[^>]*>[^<]*</artifactId>" | sed -E 's/<artifactId>(.*)<\/artifactId>/\1/')
	  version=$(cat $filePath | head -${endArray[i]} | tail -`expr ${endArray[i]} - ${startArray[i]} + 1` | grep -o "<version[^>]*>[^<]*</version>" | sed -E 's/<version>(.*)<\/version>/\1/')
	  groupId=$(cat $filePath | head -${endArray[i]} | tail -`expr ${endArray[i]} - ${startArray[i]} + 1` | grep -o "<groupId[^>]*>[^<]*</groupId>" | sed -E 's/<groupId>(.*)<\/groupId>/\1/')

	 echo -e "${fileList[j]},$artifactId,$version,$groupId" >> csv/pom.csv

	  #echo -e "$artifactId\t$version\t$groupId"
	  #echo -e "$artifactId,$version,$groupId"
	done
done


