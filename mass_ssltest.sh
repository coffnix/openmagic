#!/bin/bash
# Feito por coffnix



crunch() {
        while read FOO ; do
              echo $FOO
        done
        }

LISTA_IPS="/opt/openmagic/lista_ips.txt"




for i in $@
do
case $i in

--status)
echo -e "processos executados:\n"
ps auxw|grep $0|egrep -v 'grep|status'
exit 1

;;

--all)

if [ ! -e "${LISTA_IPS}" ] ; then
       echo -e "\n\033[1;31mPor favor, Adicione um arquivo de listas de IPs.\033[m\017\nex: $LISTA_IPS\n"
       exit;
fi

{
while read IP;do

	{
	while [ 1 ]; do python ssltest.py ${IP} >> dump-${IP}.log 2> /dev/null; done
	} &

done < ${LISTA_IPS}
} &

exit 1
;;

--kill)

ps auxw|grep $0|crunch|cut -d" " -f2| xargs kill -9

exit 1
;;

*)                                                                                                                                                          
echo -e "\nOPÇÃO INVÁLIDA: Por favor, escolha entre --all ou --kill ou --status.\n\n"

;;

esac done

echo -e "\nPor favor, escolha entre --all ou --kill ou --status.\n\n"
