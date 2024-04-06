#!/bin/bash
function gestionarIncidencies() {
    run=true
    while $run; do
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
                continue
                ;;
            2)
                echo "Has seleccionat mostrar les incidències obertes"
                printIncidences "open"
                continue
                ;;
            3)
                echo "Has seleccionat mostrar les incidències en procés"
                printIncidences "progress"
                continue
                ;;
            4)
                echo "Has seleccionat mostrar les incidències tancades"
                printIncidences "closed"
                continue
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
                

                continue
                ;;
            6)
                echo "Has seleccionat canviar d'estat una incidència"
                continue
                ;;
            0)
                echo "Gràcies per utilitzar el sistema de gestió d'incidències"
                run=false
                ;;
            *)
                echo "Opció no vàlida. Si us plau, tria una opció vàlida."
                continue
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
    status=$(awk -F ';' '{print $3}' <<< "$line")
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
        elif [ "$linestatus" = "$status" ]; then 
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
            continue
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
