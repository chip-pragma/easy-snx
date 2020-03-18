#! /usr/bin/env bash


function _check_root() {
  if [ $EUID -ne 0 ]; then
    echo 'Run as root is required'
    exit 1
  fi
  return 0
}


function _apt() {
	dpkg --add-architecture i386
	apt -y update
	apt -y install libstdc++5:i386 libx11-6:i386 libpam0g:i386
}


function _snx() {
	local snx_script="${1}"
	
	echo 'Installation SNX...'
	eval "./${snx_script}"
}


function _main() {
	local snx_script="${1}"

	_check_root
	_apt
	_snx ${snx_script}
}


_main "${1}"