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
    email=$(awk -F ';' '{print $5}' <<< "$1")
    description=$(awk -F ';' '{print $6}' <<< "$1")
    date=$(awk -F ';' '{print $6}' <<< "$1")
    date=$(awk -F ';' '{print $7}' <<< "$1")

    if [ "$2" = "all" ]; then
        echo "||"
    elif [ "$linestatus" = "$status" ]; then 
        printIncidence $line ""
    fi
}

function printIncidences(){
    status="$1"

    echo "---------------- Mostrar incidencias pel status: $status ----------------------"
    while IFS= read -r line; do
        linestatus=$(awk -F ';' '{print $3}' <<< "$line")
        if [ "$status" = "all" ]; then
            printIncidence $line "all"
        elif [ "$linestatus" = "$status" ]; then 
            printIncidence $line ""
        fi
        
        
    done < "$file"

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
