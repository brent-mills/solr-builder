if [[ -z $Xmx ]]; then
	export Xmx="512m"
	echo "Defaulting Xmx to $Xmx"
else
	echo "Setting Xmx to $Xmx"
fi


if [[ -z $Xms ]]; then
	export Xms="512m"
	echo "Defaulting Xms to $Xms"
else
	echo "Setting Xms to $Xms"
fi

./link_data.sh

./bin/solr -f