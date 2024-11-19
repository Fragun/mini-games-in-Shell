#!/usr/bin/env bash
## ETNA PROJECT, 11/10/2024 by moulin_e
## Le compte est bon
## File description:
##      Mini-jeu réalisé en Bash pour l'Etna, projet de soutenance.

## 1.Générer un nombre aléatoire entre 1 et 100
numberTarget=$((1 + $RANDOM % 100))

## 2. générer 5 nombres compris entre 1 et 20 aléatoirement et montrer à l'utilisateur
randomNumbers=()
i=0
while [ $i -lt 5 ]; do
    randomNumbers+=($((1 + $RANDOM % 20)))
    i=$((i + 1))  # Correction ici
done

# Convertir le tableau en une chaîne de nombres
numbers="[$(IFS=,; echo "${randomNumbers[*]}")]"

# Créer une chaîne contenant uniquement les nombres disponibles pour la vérification
validNumbers="${randomNumbers[@]}"

## 3. Permettre à l'utilisateur de saisir des opérations
count=0
result=0
previousResult=0

echo -e "\e[1mPrêt à jouer ?? \e[0m 
Le nombre a atteindre est le :\e[31m $numberTarget \e[0m 
"

while [[ $count -le 4 ]]; do
    echo -n "coup n°$(($count + 1)) : vos nombres : $numbers"
    if [[ $count -gt 0 ]]; then
        echo -n ", resultat : $previousResult"
    fi
    echo "" 
    read -p "entrez votre opération : " a

    # Vérifier si l'entrée est valide (expression mathématique)
    if [[ -z "$a" || ! "$a" =~ ^[[:space:]]*[-+]?[0-9]+([[:space:]]*[-+*/][[:space:]]*[-+]?[0-9]+)*[[:space:]]*$ ]]; then
        echo "Opération invalide. Essayez une autre."
        continue 
    fi

    # Vérifier que seuls les nombres valides sont utilisés
    for number in ${randomNumbers[@]}; do
        a=${a//"$number"/} # Supprime chaque nombre valide de l'expression
    done

    # Si l'expression contient encore des caractères (non des espaces ou opérations), c'est invalide
    if [[ -n "${a//[[:space:]]/}" ]]; then
        echo "Vous devez utiliser uniquement les chiffres fournis : ${validNumbers}."
        continue
    fi

    # Calculer le résultat
    result=$(echo "$a" | bc 2>/dev/null)

    if [[ $result -eq $numberTarget ]]; then
        echo "Le compte est bon ! vous avez trouvé $numberTarget en $(($count + 1)) coups."
        break
    else
        echo "Essayez encore ! vous avez trouvé $result au lieu de $numberTarget coups."
    fi
    previousResult=$result
    count=$((count + 1))

done

if [[ $count -gt 4 ]]; then
    echo "Game over"
fi
