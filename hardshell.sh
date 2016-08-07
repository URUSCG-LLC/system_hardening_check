#!/bin/bash
#########################################################################
# Script:	hardshell.sh
# Author:	Richard Jackson
# Email:	rjackson@uruscorporation.com
# Created Time:	Sun Aug  7 07:12:42 EDT 2016
#########################################################################
#USAGE:
#./hardshell.sh "arg1,arg2,arg3" "arg2"

#SSH Server config file.
__sshconf='/etc/ssh/sshd_config'
#Check SSH config for security.
__parachk=( 'PermitEmptyPasswords' 'PasswordAuthentication' )
for p in ${__parachk[*]};
do
	__getpara=`grep ^${p} ${__sshconf} | awk '{print $2}'`
	case ${__getpara} in
		yes) printf "\033[35mParameter ${p}\033[0m -- \033[31mis not secure!\033[0m [ \"${p}\": \"${__getpara}\" ]\n";;
		no) printf "\033[35mParameter ${p}\033[0m -- \033[32mis secure\033[0m [ \"${p}\": \"${__getpara}\" ]\n";;
	esac
done

__runningFail2Ban=(`pgrep fail2ban`)

case ${#__runningFail2Ban[*]} in
	0) printf "\033[31mNot running, fail2ban!!!\033[0m\n"
	read -p "Do you want to install Fail2Ban? " __choice
		case ${__choice} in
			y|yes|Y|y) apt -y install fail2ban;;
			*) printf "Exiting, HardShell script check...\n";;
		esac
	;;
	*) printf "\033[32mRunning\033[0m, \033[32mfail2ban\033[0m...\033[0m\n"
	printf "Check configuration to ensure all settings are correct.['/etc/fail2ban/jail.conf']\n"
	;;
esac
