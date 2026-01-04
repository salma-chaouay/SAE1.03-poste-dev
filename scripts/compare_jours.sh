#!/bin/bash

# compare_jours.sh
# But : comparer deux fichiers de logs et afficher les lignes uniques à chaque fichier.
# Usage : ./compare_jours.sh auth_jour1.log auth_jour2.log

# Vérification des paramètres
if [ "$#" -ne 2 ]; then
    echo "Usage : $0 fichier1 fichier2"
    exit 1
fi

FICHIER1="$1"
FICHIER2="$2"

# Vérification que les fichiers existent
if [ ! -f "$FICHIER1" ]; then
    echo "Erreur : $FICHIER1 n'existe pas"
    exit 1
fi

if [ ! -f "$FICHIER2" ]; then
    echo "Erreur : $FICHIER2 n'existe pas"
    exit 1
fi

# Trier les fichiers pour préparer la comparaison
sort "$FICHIER1" > fichier1_tri.log
sort "$FICHIER2" > fichier2_tri.log

# Comparer les fichiers triés et afficher uniquement les différences
# comm -23 : lignes présentes uniquement dans fichier1
# comm -13 : lignes présentes uniquement dans fichier2
echo "=== Lignes présentes uniquement dans $FICHIER1 ==="
comm -23 fichier1_tri.log fichier2_tri.log

echo "=== Lignes présentes uniquement dans $FICHIER2 ==="
comm -13 fichier1_tri.log fichier2_tri.log

# Supprimer les fichiers temporaires
rm fichier1_tri.log fichier2_tri.log

echo "Comparaison terminée."
