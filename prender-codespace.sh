#!/bin/bash

# Verificar si se proporcionó un parámetro
if [ -z "$1" ]; then
  echo "⚠️  Error: Debes proporcionar el nombre visible del Codespace."
  echo "💡 Uso: $0 \"TU_DISPLAY_NAME\""
  exit 1
fi

# Asignar el primer parámetro a la variable
DISPLAY_NAME="$1"

# Comando que deseas ejecutar adentro
COMANDO='echo "Codespace prendido . . ."'

echo "Buscando el codespace: '$DISPLAY_NAME'..."

# Obtener el nombre real (name-xyz) usando tu comando
CODESPACE=$(gh codespace list --json name,displayName --jq ".[] | select(.displayName==\"$DISPLAY_NAME\") | .name")

# Verificar si se encontró el codespace
if [ -z "$CODESPACE" ]; then
  echo "❌ Error: No se encontró ningún codespace con el nombre '$DISPLAY_NAME'."
  exit 1
fi

echo "✅ Codespace encontrado: $CODESPACE"
echo "Conectando..."

# Ejecutar el comando a través de SSH
gh codespace ssh -c "$CODESPACE" -- $COMANDO
