#!/bin/bash

# Verificar que se haya pasado al menos un argumento
if [ "$#" -lt 1 ]; then
    echo "Uso: $0 <comando> [parametros...]"
    exit 1
fi

# Obtener el nombre del comando a ejecutar (el primer argumento)
nombre_comando=$(basename "$1")

# Obtener el comando completo a ejecutar
comando="$@"

# Obtener información del entorno para simular el prompt personalizado
usuario=$(whoami)
hostname=$(hostname)
directorio_actual=$(pwd)

# Colores ANSI
verde="\e[32m"
azul="\e[34m"
blanco="\e[0m"

# Nombre del archivo de salida (comienza con el nombre del comando y un timestamp para que sea único)
archivo_salida="${nombre_comando}_resultado_$(date +'%Y%m%d_%H%M%S').txt"

# Crear el contenido del "prompt" simulado con colores
prompt="${verde}┌──(${azul}${usuario}${verde}㉿${azul}${hostname}${verde})-[${azul}${directorio_actual}${verde}]
└─${blanco}$ ${comando}"

# Escribir el comando ejecutado en el archivo de salida con colores
echo -e "$prompt" > "$archivo_salida"

# Ejecutar el comando y guardar la salida en el archivo de salida
$comando >> "$archivo_salida" 2>&1

# Informar al usuario del archivo generado
echo "El resultado se ha guardado en el archivo: $archivo_salida"
