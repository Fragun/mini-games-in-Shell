#!/usr/bin/env bash
## ETNA PROJECT, 11/10/2024 by moulin_e
## Le juste Prix
## File description:
##      Jeu en Bash -- Etna
##

nombreCible=0
count=0
numberUser=0
countMax=0

while true; do
    echo -n "Choisissez la difficulté, tapez 1 [1-100] en 7coups, tapez 2 [1-200]en 10coups, tapez 3 [1-500] en 12 coups, tapez 4 [1-5000] en 14 coups : "
    read level

    # Vérification de l'entrée utilisateur
    if [[ -z $level || ! $level =~ ^[0-9]+$ || $level -gt 4 || $level -lt 1 ]]; then
        echo "Veuillez entrer un nombre valide entre 1 et 4."
    else if [[ $level -eq 1 ]]; then
            nombreCible=$((1 + $RANDOM % 100)) 
            countMax=6
        elif [[ $level -eq 2 ]]; then
            nombreCible=$((1 + $RANDOM % 200)) 
            countMax=9
        elif [[ $level -eq 3 ]]; then 
            nombreCible=$((1 + $RANDOM % 500)) 
            countMax=11
        elif [[ $level -eq 4 ]]; then
            nombreCible=$((1 + $RANDOM % 5000)) 
            countMax=14
        fi
        break 
    fi
done

echo "Trouvez Le juste prix !"

while [[ $numberUser -ne $nombreCible ]]; do

    echo -n "coup n° $(($count + 1)) :"

    read numberUser
    if [[ -z $numberUser || ! $numberUser =~ ^[0-9]+$ ]]; then
        echo "Veuillez entrer une valeur numérique"
        continue
    fi
    count=$((count + 1))
    if [[ $count -gt $countMax ]]; then
        echo "Dommage vous n'avez pas réussi en - de $(($count)) coups"

        break
    fi
    
    if [[ $numberUser -gt $nombreCible ]]; then
        echo "trop haut!"

    elif [[ $numberUser -lt $nombreCible ]]; then
        echo "trop bas !"

    else
        echo "Félicitation ! vous avez trouvé le juste prix $((nombreCible)) en $(($count)) coups"
    fi

done
