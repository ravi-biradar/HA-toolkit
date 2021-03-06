#!/bin/bash
#
# $Id: appdservice-root.sh 3.12 2017-03-07 17:04:25 cmayer $
#
# shell wrapper around service for service changes - designed to run as root
#
# Copyright 2016 AppDynamics, Inc
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#
export PATH=/bin:/usr/bin:/sbin:/usr/sbin

function usage {
	echo usage: "$0 [appdcontroller|appdcontroller-db|appdynamics-machine-agent start|stop|status]"
	exit 1
}

if [ $# -ne 2 ] ; then
	usage
fi

case $1 in
	appdcontroller|appdcontroller-db|appdynamics-machine-agent)
		service=$1
		;;
	*)
		usage
		;;
esac

case $2 in
	start|stop|status)
		action=$2
		;;
	*)
		usage
		;;
esac

if [ -f NO_MACHINE_AGENT -a "$service" == appdynamics-machine-agent ] ; then
       exit 0
fi

/sbin/service $service $action
exit 0
