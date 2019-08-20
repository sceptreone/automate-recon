#----- usefull -------
install(){
sudo apt install $1
}

#easy access tmux
tlink(){
tmux attach-session $1 
}

tlist(){
tmux list-session
}

trimSubdomains(){
if [ $2 -eq "4" ]; then
	cat $1 | rev | awk -F. '{print $1"."$2"."$3"."$4}' | rev | sort -u 
elif [ $2 -eq "5" ]; then	
	cat $1 | rev | awk -F. '{print $1"."$2"."$3"."$4"."$5}' | rev | sort -u 
else 
	cat $1 | rev | awk -F. '{print $1"."$2"."$3}' | rev | sort -u 
fi
}

#----- subdomain -----
certspotter(){
curl -s https://certspotter.com/api/v0/certs\?domain\=$1 | jq '.[].dns_names[]' | sed 's/\"//g' | sed 's/\*\.//g' | sort -u | grep $1
} #h/t Michiel Prins

crtsh(){
curl -s https://crt.sh/?q=%.$1  | sed 's/<\/\?[^>]\+>//g' | sed 's/ //g' | grep $1
}

#Quick upload 
#----- uplaod ----
bupload(){
curl https://bashupload.com/$1 --data-binary @$1
}
