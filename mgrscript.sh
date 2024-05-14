#!/bin/bash
function gestionarIncidencies() {
   runGestionarIncidences=true
   while $runGestionarIncidences; do
       echo ""
       echo ""
       echo ""
       echo ""
       echo "-------------- Gestió d'Incidències --------------"
       echo "1. Mostrar totes les incidències"
       echo "2. Mostrar les incidències obertes"
       echo "3. Mostrar les incidències en procés"
       echo "4. Mostrar les incidències tancades"
       echo "5. Mostrar incidència completa"
       echo "6. Canviar d'estat una incidència"
       echo "0. Sortir"
       echo "--------------------------"
       read -p "Escull una opció: " opcio
       echo ""
       echo ""
       echo ""
       echo ""
       case $opcio in
           1)
               echo "Has seleccionat mostrar totes les incidències"
               printIncidences "all"
               runGestionarIncidences=false
               ;;
           2)
               echo "Has seleccionat mostrar les incidències obertes"
               printIncidences "open"
               runGestionarIncidences=false
               ;;
           3)
               echo "Has seleccionat mostrar les incidències en procés"
               printIncidences "progress"
               runGestionarIncidences=false
               ;;
           4)
               echo "Has seleccionat mostrar les incidències tancades"
               printIncidences "closed"
               runGestionarIncidences=false
               ;;
           5)
               echo "Has seleccionat mostrar incidència completa"
               echo "Introdueix la id de la incidencia que vols mostrar"
               read selectedId


               found=false


               while IFS= read -r line; do
               incidenceId=$(awk -F ';' '{print $NF}' <<< "$line")
               if [ "$incidenceId" = "$selectedId" ]; then
                   printFullIncidence "$line"
                   found=true;
               fi


               done < "$file"


               if [ "$found" = false ]; then
                   echo ""
                   echo "No incidence was found with id $selectedId"
                   echo ""
               fi
              


               runGestionarIncidences=false
               ;;
           6)
               echo "Introdueix la id de la incidencia que vols modificar"
               read id_canvi
               # validate incidence xists and if it does store its status
               found=false
               new_status=""
                   while IFS= read -r line; do
                   incidenceId=$(awk -F ';' '{print $NF}' <<< "$line")
                   if [ "$incidenceId" = "$id_canvi" ]; then
                       opcio=$(awk -F ';' '{print $3}' <<< "$line")
                       found=true;
                       case $opcio in
                           "open")
                               new_status="progress"
                               # update the status, create file tmp and if succes move it to the file location,
                               awk -v id="$id_canvi" -v new_status="$new_status" 'BEGIN{FS=OFS=";"} $NF == id {$3 = new_status; found=1} 1' "$file" > temp && mv temp "$file" 
                               echo "La incidencia amb id $id_canvi ha cambiat el seu status de $opcio a $new_status"
                               ;;
                           "progress")
                               new_status="closed"
                               # update the status, create file tmp and if succes move it to the file location,
                               awk -v id="$id_canvi" -v new_status="$new_status" 'BEGIN{FS=OFS=";"} $NF == id {$3 = new_status; found=1} 1' "$file" > temp && mv temp "$file" 
                               echo "La incidencia amb id $id_canvi ha cambiat el seu status de $opcio a $new_status"
                               ;;
                           *)
                               echo "Aquesta id no pot cambiar el seu estat ja"
                               ;;
                       esac
                   fi
               done < "$file"


               if [ "$found" = false ]; then
                   echo ""
                   echo "No s'ha trobat cap incidencia amb aquesta id $selectedId"
                   echo ""
               fi
               
            
               runGestionarIncidences=false
               ;;
           0)
               echo "Gràcies per utilitzar el sistema de gestió d'incidències"
               runGestionarIncidences=false
               ;;
           *)
               echo "Opció no vàlida. Si us plau, tria una opció vàlida."
               runGestionarIncidences=false
               ;;
       esac
      
   done
}


function gestionarServeisAdmin() {
   runServeiFTP=true
   while $runServeiFTP; do
       echo ""
       echo ""
       echo ""
       echo ""
       echo "-------------- Resoldre Servei FTP --------------"
       echo "1. Afegir usuari per al servidor FTP"
       echo "2. Esborrar usuari per al servidor FTP"
       echo "3. Iniciar servidor FTP"
       echo "4. Aturar servidor FTP"
       echo "5. Reinciar servidor FTP"
       echo "6. Coneixer estat servidor FTP"
       echo "7. Editar web amb visual studio code"
       echo "8. Iniciar servidor web"
       echo "9. Aturar servidor web"
       echo "10. Reinciar servidor web"
       echo "11. Coneixer estat servidor web"
       echo "12. Resoldre permisos pagina web"
       echo "13. Verificat si esta creada la pagina web"
       echo "0. Sortir"
       echo "--------------------------"
       read -p "Escull una opció: " opcio
       echo ""
       echo ""
       echo ""
       echo ""
       case $opcio in
           1)
              
               runServeiFTP=false
               ;;
           2)
             
               runServeiFTP=false
               ;;
           3)
               sudo systemctl start vsftpd
               ;;
           4)
               sudo systemctl stop vsftpd
               ;;
           5)
               sudo systemctl restart vsftpd
              
               ;;
           6)
               sudo systemctl status vsftpd
              
               ;;
           7)
             
              
               ;;
           8)
               sudo systemctl start apache2
              
               ;;
           9)
               sudo systemctl stop apache2
              
               ;;
           10)
               sudo systemctl restart apache2
              
               ;;
           11)
              sudo systemctl status apache2
              
               ;;
           12)
             
               runServeiFTP=false
              
               ;;
           13)
             
               runServeiFTP=false
              
               ;;
           0)
               runServeiFTP=false
               ;;
           *)
               runServeiFTP=false
               ;;
       esac
      
   done
}


function gestionarServeiWeb() {
   runServeiWeb=true
   while $runServeiWeb; do
       echo ""
       echo ""
       echo ""
       echo ""
       echo "-------------- Resoldre Servei Web --------------"
       echo "1. Afegir pagnes web"
       echo "2. Iniciar servidor web"
       echo "3. Aturar servidor web"
       echo "4. Reinciar servidor web"
       echo "5. Coneixer estat servidor web"
       echo "6. Resoldre Problemes acces servidor"
       echo "7. Modificar pagina web"
       echo "0. Sortir"
       echo "------------------------------------------------"
       read -p "Escull una opció: " opcio
       echo ""
       echo ""
       echo ""
       echo ""
       case $opcio in
           1)
              
               runServeiWeb=false
               ;;
           2)
             
               runServeiWeb=false
               ;;
           3)
             
               runServeiWeb=false
               ;;
           4)
              
               runServeiWeb=false
               ;;
           5)
             
               runServeiWeb=false
               ;;
           6)
               runServeiWeb=false
               ;;
           7)
               runServeiWeb=false
               ;;
           0)
               runServeiWeb=false
               ;;
           *)
               runServeiWeb=false
               ;;
       esac
      
   done
}


function continue(){
   echo "press enter to continue to the menu"
   read foo
}


function printIncidence(){
  
   errorMsg=$(awk -F ';' '{print $4}' <<< "$1")
   status=$(awk -F ';' '{print $3}' <<< "$1")
   date=$(awk -F ';' '{print $7}' <<< "$1")
   id=$(awk -F ';' '{print $8}' <<< "$1")


   echo "| $id | $status | $date | $errorMsg "
}


function printItem(){
   name=$1
   index=$2
   line=$3


   value=$(awk -F ';' '{print $'$index'}' <<< "$line")


   echo "| $name = $value"
}
function printFullIncidence(){
   echo "---------------- Mostrar incidencia completa de la id: $id ----------------------"
   echo ""
   printItem "id" 8 "$line"
   printItem "status" 3 "$line"
   printItem "resolverAdmin" 1 "$line"
   printItem "adminMessage" 2 "$line"
   printItem "errorMsg" 4 "$line"
   printItem "email" 5 "$line"
   printItem "description" 6 "$line"
   printItem "date" 7 "$line"
   echo ""
   echo "---------------------------------------------------------------------------------"
}


function printIncidences(){


   echo "---------------- Mostrar incidencias pel status: $1 ----------------------"
   echo "| id | status | fecha | mensage de error"
   echo ""
   while IFS= read -r line; do
       linestatus=$(awk -F ';' '{print $3}' <<< "$line")
       if [ "$1" = "all" ]; then
           printIncidence "$line" "all"
       elif [ "$linestatus" = "$1" ]; then
           printIncidence "$line" ""
       fi
      
      
   done < "$file"
   echo ""
   echo "-------------------------------------------------------------------------------"
   echo ""
}


file="incidencies.txt"


runmain=true


while $runmain; do
   echo ""
   echo ""
   echo ""
   echo ""
   echo "----- Menú Principal -----"
   echo "1. Gestionar incidències"
   echo "2. Resoldre incidència"
   echo "0. Sortir"
   echo "---------------------------"
   read -p "Selecciona una opció: " opcio
   echo ""
   echo ""
   echo ""
   echo ""
   case $opcio in
       1)
           echo "Has seleccionat gestionar incidències."
           gestionarIncidencies
           ;;
       2)
           echo "Has seleccionat resoldre incidència."
           gestionarServeisAdmin
           ;;
       0)
           echo "Adéu!"
           runmain=false 
           ;;
       *)
           echo "Opció invàlida. Si us plau, tria una opció vàlida."
           continue
           ;;
   esac
done





