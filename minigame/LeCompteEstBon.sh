#!/usr/bin/env bash
## ETNA PROJECT, 11/10/2024 by moulin_e
## Le compte est bon
## File description:
##      Mini-jeu réalisé en Bash pour l'Etna, projet de soutenance.

nombreCible=$((1 + $RANDOM % 100))

chiffresRandom=()

i=0
while [ $i -lt 5 ]; do
    chiffresRandom+=($((1 + $RANDOM % 20)))
    i=$((i + 1))
done

numbers="[$(
    IFS=,
    echo "${chiffresRandom[*]}"
)]"

count=0
result=0
previousResult=0

echo -e "\e[1mPrêt à jouer ?? \e[0m 
Le nombre a atteindre est le :\e[31m $nombreCible \e[0m 
"

while [[ $count -le 4 ]]; do

    echo -n "coup n°$(($count + 1)) : vos nombres : $numbers"
    if [[ $count -gt 0 ]]; then
        echo -n ", resultat : $previousResult"
    fi
    echo ""
    read -p "entrez votre opération : " a

    if [[ -z "$a" || ! "$a" =~ ^[[:space:]]*[-+]?[0-9]+([[:space:]]*[-+*/][[:space:]]*[-+]?[0-9]+)*[[:space:]]*$ ]]; then
        echo "Opération invalide. Réessayez."
        continue
    fi

    validNumbers="${chiffresRandom[*]} $previousResult"

    usedNumbers=$(echo "$a" | grep -oE '[0-9]+' | tr '\n' ' ')

    for number in $usedNumbers; do
        if ! [[ $validNumbers =~ $number ]]; then
            echo "Vous devez utiliser uniquement les chiffres fournis : $validNumbers."
            continue 2 # Continuer la boucle principale
        fi
    done

    result=$(echo "$a" | bc 2>/dev/null)

    if [[ $result -eq $nombreCible ]]; then
        echo "Le compte est bon ! vous avez trouvé $nombreCible en $(($count + 1)) coups."
        break
    else
        echo ""Essayez encore ! vous avez trouvé $result au lieu de $nombreCible coups.""
    fi
    previousResult=$result
    count=$((count + 1))

done

if [[ $count -gt 4 ]]; then
    echo "Game over"
fi
