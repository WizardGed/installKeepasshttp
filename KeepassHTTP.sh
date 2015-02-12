#!/usr/bin/env sh

#
# (C) Copyright 2015 Andrew Lawrence DeMarsh (andrew.dema@gmail.com).
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Contributors:
#     -
#

OS=`lsb_release -si`
UID=`id -u`

# Did we execute this as root?
if [ $UID != "0" ]; then
	echo "This script must be run as root. Did you leave out sudo?"
	exit 1
fi

# I have only included Debian and Ubuntu as these were the only Distro's I had access to at the time.
# Contact me or submit a pull request to have me add your distro and dependancies to the script.

echo "Updating package list and installing required dependancies."

if [ $OS = 'Ubuntu' ]; then
	apt-get update && apt-get install -y mono-complete
fi

if [ $OS = 'Debian' ]; then
	apt-get update && apt-get install -y libmono-system-runtime-serialization4.0-cil libmono-posix2.0-cil
fi

# You need to create the plugins folder as it most likely will not exist

echo 'Creating the /usr/lib/keepass2/plugins directory'
mkdir -p /usr/lib/keepass2/plugins

echo 'Changing directories to the /usr/lib/keepass2/plugins directory'
cd  /usr/lib/keepass2/plugins

echo 'Downloading KeepassHttp'

# I have found that the plgx file works best on the systems I have tested but have left the 2 dll files commented out in case you're a massochist.

# wget https://github.com/pfn/keepasshttp/blob/master/mono/KeePassHttp.dll 2>/dev/null || curl -O  https://github.com/pfn/keepasshttp/blob/master/mono/KeePassHttp.dll
# wget https://github.com/pfn/keepasshttp/blob/master/mono/Newtonsoft.Json.dll 2>/dev/null || curl -O  https://github.com/pfn/keepasshttp/blob/master/mono/Newtonsoft.Json.dll

wget https://github.com/pfn/keepasshttp/raw/master/KeePassHttp.plgx 2>/dev/null || curl -O https://github.com/pfn/keepasshttp/raw/master/KeePassHttp.plgx

echo 'Changing permissions of downloaded file to allow reading and execution by anyone'

# remember to uncomment the top 2 and comment out the final chmod command if you are using the dll's

# chmod 644 KeePassHttp.dll
# chmod 644 Newtonsoft.Json.dll
chmod 644 KeePassHttp.plgx

echo 'Installation complete, restart KeePass Immediately'

exit 0

