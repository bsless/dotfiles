#! /usr/bin/env bash

set -x

fonts_dir="${HOME}/.local/share/fonts"

if [ ! -d "${fonts_dir}" ] ; then
    mkdir -p "${fonts_dir}"
fi

### FIRA

dir_path="${fonts_dir}/fira-code"
mkdir -p "$dir_path"
for type in Bold Light Medium Regular Retina; do
    file_path="${dir_path}/FiraCode-${type}.ttf"
    file_url="https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-${type}.ttf?raw=true"
    wget -O "${file_path}" "${file_url}"
done

### SOURCE CODE PRO

base_url="https://github.com/adobe-fonts/source-code-pro/releases/download"
release="2.038R-ro%2F1.058R-it%2F1.018R-VAR"
files="OTF-source-code-pro-2.038R-ro-1.058R-it.zip TTF-source-code-pro-2.038R-ro-1.058R-it.zip VAR-source-code-var-1.018R.zip WOFF-source-code-pro-2.038R-ro-1.058R-it.zip WOFF2-source-code-pro-2.038R-ro-1.058R-it.zip"
dir_path="${fonts_dir}/source-code-pro"
mkdir -p "$dir_path"
for file in $files; do
    file_path="${dir_path}/${file}"
    file_url="${base_url}/${release}/$file"
    wget -O "${file_path}" "${file_url}"
    unzip "${file_path}" -d "${file_path%.*}"
    rm "$file_path"
done

### JET BAINS MONO

ver="2.221"
file="JetBrainsMono-${ver}.zip"
file_url="https://download.jetbrains.com/fonts/${file}"
file_path="${fonts_dir}/${file}"
wget -O "${file_path}" "${file_url}"
unzip "${file_path}" -d "${file_path%.*}"
rm "$file_path"

### Fantasque Sans Mono

ver="v1.8.0"
file="FantasqueSansMono-Normal.zip"
file_url="https://github.com/belluzj/fantasque-sans/releases/download/${ver}/${file}"
dir_path="${fonts_dir}/fantasque/${ver}"
mkdir -p "$dir_path"
file_path="${dir_path}/${file}"
wget -O "${file_path}" "${file_url}"
unzip "${file_path}" -d "${file_path%.*}"
rm "$file_path"

### COMIC NEUE

ver="2.51"
file="comic-neue-2.51.zip"
file_url="http://comicneue.com/$file"
dir_path="${fonts_dir}"
mkdir -p "$dir_path"
file_path="${dir_path}/${file}"
wget -O "${file_path}" "${file_url}"
unzip "${file_path}" -d "${file_path%.*}"
rm "$file_path"

rm -rf __MACOSX

fc-cache -vrf

set +x
