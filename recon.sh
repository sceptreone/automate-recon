#!/bin/bash

# Configure variables
declare domain=$1 threads=$2 trimlvl=$3

# Subdomains

subfind(){
~/go/bin/subfinder -d "${domain}" -t "${threads}" -o subfind.txt
}

crtsh(){
curl -s https://crt.sh/?q=%."${domain}"  | sed 's/<\/\?[^>]\+>//g' | sed 's/ //g' | grep "${domain}" > crtsh.txt
}

certspotter(){
curl -s https://certspotter.com/api/v0/certs\?domain\="${domain}" | jq '.[].dns_names[]' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u | grep "${domain}" > certspot.txt
} 

# Combine Subdomains and Sort
merge(){
cat *.txt | sort -u > all.txt
sed 's/*.//g' all.txt > allCleaned.txt
}

# Trim and find unique subdomains
trim(){
if [ "${trimlvl}" -eq "4" ]; then
	cat allCleaned.txt | rev | awk -F. '{print $1"."$2"."$3"."$4}' | rev | sort -u > trim4.txt
elif [ "${trimlvl}" -eq "5" ]; then	
	cat allCleaned.txt | rev | awk -F. '{print $1"."$2"."$3"."$4"."$5}' | rev | sort -u > trim5.txt
else 
	cat allCleaned.txt | rev | awk -F. '{print $1"."$2"."$3}' | rev | sort -u > trim3.txt
fi
}

# Alive host
alive(){
cat allCleaned.txt | ~/go/bin/httprobe > alive.txt
}

# Take Screenshots
screenshots(){
mkdir screenshots
~/go/bin/gowitness file --source=alive.txt --threads=${threads} -d screenshots
}

main()
{

	mkdir "${domain}" && cd "${domain}"
	echo "Starting Recon on ${domain}"
	echo "Threads consumed : ${threads}"
	echo "Trim Level : ${trimlvl}"

	echo "Subdomain scanning starting..."
	echo "Subfinder started..."
	subfind
	echo "Crtsh started..."
	crtsh 
	echo "Certspotter started..."
	certspotter

	echo "Merging and sorting domains..."
	merge

	echo "Trimming Recpie..."
	trim

	echo "Looking for zombie domains..."
	alive

	echo "Taking selfies of domains..."
	screenshots
}

main
