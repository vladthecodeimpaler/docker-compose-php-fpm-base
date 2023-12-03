#! /usr/bin/bash
# text colors
yellow_prefix="\033[33m"
yellow_suffix="\033[00m"
green_bg_prefix="\e[1;42m"
green_bg_suffix="\e[0m"

# wrap the string "WARNING" with the prefix and suffix
echo -e "${yellow_prefix}Enter Version (leave blank for latest):${yellow_suffix}"
read version

echo -e "${green_bg_prefix}Installing...${green_bg_suffix}"
if [ -z "$version" ]; then
  composer create-project laravel/laravel l-temp
else
  composer create-project laravel/laravel=$version l-temp
fi

echo -e "${green_bg_prefix}Cleaning Up...${green_bg_suffix}"
mv l-temp/* l-temp/.[!.]* . && rmdir l-temp && rm ./laravel.sh
echo -e "${green_bg_prefix}Done${green_bg_suffix}"
