#!/usr/bin/env bash

#                                     __
#                                    / _|
#   __ _ _   _ _ __ ___  _ __ __ _  | |_ ___  ___ ___
#  / _` | | | | '__/ _ \| '__/ _` | |  _/ _ \/ __/ __|
# | (_| | |_| | | | (_) | | | (_| | | || (_) \__ \__ \
#  \__,_|\__,_|_|  \___/|_|  \__,_| |_| \___/|___/___/
#
# Copyright (C) 2019 Aurora Free Open Source Software.
#
# This file is part of the Aurora Free Open Source Software. This
# organization promote free and open source software that you can
# redistribute and/or modify under the terms of the GNU Lesser General
# Public License Version 3 as published by the Free Software Foundation or
# (at your option) any later version approved by the Aurora Free Open Source
# Software Organization. The license is available in the package root path
# as 'LICENSE' file. Please review the following information to ensure the
# GNU Lesser General Public License version 3 requirements will be met:
# https://www.gnu.org/licenses/lgpl.html .
#
# Alternatively, this file may be used under the terms of the GNU General
# Public License version 3 or later as published by the Free Software
# Foundation. Please review the following information to ensure the GNU
# General Public License requirements will be met:
# http://www.gnu.org/licenses/gpl-3.0.html.
#
# NOTE: All products, services or anything associated to trademarks and
# service marks used or referenced on this file are the property of their
# respective companies/owners or its subsidiaries. Other names and brands
# may be claimed as the property of others.
#
# For more info about intellectual property visit: aurorafoss.org or
# directly send an email to: contact (at) aurorafoss.org .

# Greetings
echo -e "\e[95m-->\e[0m \e[1mWelcome to dots linux installation script\e[0m"

# Default variable values
if [ -z ${DOTS_HOSTNAME+x} ]; then
	DOTS_HOSTNAME=undefined
fi

if [ -z ${DOTS_VERBOSE+x} ]; then
	DOTS_VERBOSE=0
fi

if [ -z ${DOTS_NOCONFIRM+x} ]; then
	DOTS_NOCONFIRM=0
elif [[ "$DOTS_NOCONFIRM" == "1" || "$DOTS_NOCONFIRM" == "true" ]]; then
	echo -e "\e[93m==>\e[0m \e[1mnoconfirm option detected!\e[0m" 1>&2
else
	echo -e "\e[91m==>\e[0m \e[1mUnknown value for \e[34m\$DOTS_NOCONFIRM\e[0m" 1>&2
	exit 1
fi

if [ -z ${DOTS_ALLOWERROR+x} ]; then
	DOTS_ALLOWERROR=0
fi

# Check for $DOTS_ENTRYPOINT or first argument is present
if [ -z ${DOTS_ENTRYPOINT+x} ]; then
	if [ "$2" != "" ]; then
		echo -e "\e[91m==>\e[0m \e[1mToo many arguments.\e[0m" 1>&2
		exit 1
	fi

	if [ "$1" != "" ]; then
		DOTS_ENTRYPOINT="$@"
	else
		echo -e "\e[91m==>\e[0m \e[1mPlease specify the \e[34m\$DOTS_ENTRYPOINT\e[0m \e[1mor pass it as argument.\e[0m" 1>&2
		exit 1
	fi
fi

# Check for root permissions
if [ `id -u` -ne 0 ]; then
	echo -e "\e[91m==>\e[0m \e[1mThis script must be run as root\e[0m" 1>&2
	exit 1
fi

# Detect distro
echo -e "\e[92m-->\e[0m \e[1mDetecting the linux distribution\e[0m"

if [ `uname -n` == "archiso" ]; then
	echo -e "\e[92m-->\e[0m \e[1mArch linux detected!\e[0m"
else
	echo -e "\e[91m==>\e[0m \e[1mUnknown linux distro!\e[0m" 1>&2
	exit 1
fi