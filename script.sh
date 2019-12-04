#!/bin/bash

compteur=1001

ecrireEntree() {
NOM=$(echo $1|tr '[:upper:]' '[:lower:]')
COMPTEUR=$2
PRENOM=$(echo $3|tr '[:upper:]' '[:lower:]')
#echo "$COMPTEUR"
MYUID=${PRENOM:0:3}${NOM:0:8}
#echo $MYUID
SSHA="{SSHA}"
echo "dn: uid=${MYUID},ou=etudiants,ou=personnes,dc=iutbeziers,dc=fr"
echo "objectClass: inetOrgPerson"
echo "objectClass: person"
echo "objectClass: organizationalPerson"
echo "objectClass: posixAccount"
echo "objectClass: shadowAccount"
echo "objectClass: top"
echo "cn: ${PRENOM}.${NOM}"
echo "sn: ${PRENOM}"
echo "givenName: ${NOM}"
echo "uid: ${MYUID}"
echo "uidNumber: ${COMPTEUR}"
echo "gidNumber: ${COMPTEUR}"
echo "homeDirectory: /home/${MYUID}"
echo "loginShell: /bin/bash"
echo "shadowExpire: 0"
echo "userPassword: ${SSHA}RWK9BASh/NsGzi0k4XLRm1Xt1DoEceJvtB1h1w=="
echo -e "mail: ${PRENOM}.${NOM}@iutbeziers.fr\n"
}

while read line
do
	arg1=$(echo "$line" | sed -r 's/ /;/g'| cut -d';' -f 2) 
	arg3=$(echo "$line" | sed -r 's/ /;/g'| cut -d';' -f 3)
	((compteur++))
	ecrireEntree $arg1 $compteur $arg3 >> Severan_mini_projet.ldif
done < liste_tous.csv

