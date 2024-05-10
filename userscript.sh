#!/bin/bash

items=(1 "Servei Caigut" 2 "Pagina No Obre" 2 "Error en la pagina" 4 "Altre")
incidenceType=""
email=""
desc=""

# Seleccionar el tipo de incidencia
while choice=$(dialog --title "Incidence creation" \
                 --menu "Whats the incidence type error" 12 40 3 "${items[@]}" \
                 2>&1 >/dev/tty)
do
    case $choice in
        1) incidenceType="Servei Caigut"; break;;
        2) incidenceType="Pagina No Obre"; break;;
        3) incidenceType="Error en la pagina"; break;;
        4) incidenceType="Altre"; break;;
        *) break;; 
    esac
done
clear 

# Obtener el correo electrónico
while true
do
    user_input=$(dialog --title "Incidence creation" \
        --inputbox "add your email" 8 40 \
        3>&1 1>&2 2>&3 3>&-)

    # Validar longitud mínima
    if [ ${#user_input} -gt 1 ]; then
        email="$user_input"
        break
    else
        dialog --msgbox "Email must be at least 2 characters long." 8 40
    fi
done
clear

# Obtener la descripción
while true
do
    user_input_desc=$(dialog --title "Incidence creation" \
        --inputbox "add your description" 8 40 \
        3>&1 1>&2 2>&3 3>&-)

    # Validar longitud mínima
    if [ ${#user_input_desc} -gt 1 ]; then
        desc="$user_input_desc"
        break
    else
        dialog --msgbox "Description must be at least 2 characters long." 8 40
    fi
done
clear


current_month_year=$(date +"%Y-%m")
datafile="incidencies.txt"
# calulate the item id
id=1
while IFS= read -r line; do
    data+=("$line")
    id=$(awk -F ';' '{print $NF}' <<< "$line")
done < "$datafile"
id=$(expr $id + 1)
# Guardar los datos en data.txt
data=(";;open;$incidenceType;$email;$desc;$current_month_year;$id")
echo "$data" >> incidencies.txt
