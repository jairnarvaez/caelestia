#!/bin/bash
#
# workspace-move.sh — Navega entre workspaces en Hyprland con animaciones
#
# Uso:
#   workspace-move.sh [DIRECCIÓN]
#
# DIRECCIÓN:
#   left    - Mover al workspace de la izquierda
#   right   - Mover al workspace de la derecha
#   up      - Mover al workspace superior
#   down    - Mover al workspace inferior
#
# Ejemplo:
#   workspace-move.sh left
#
# Descripción:
#   Este script permite moverse entre workspaces organizados en una cuadrícula
#   de 3x3 (workspaces 1–9) aplicando animaciones personalizadas según la
#   dirección. Se basa en el comando 'hyprctl' de Hyprland.
#
#   Estructura del grid:
#        1   2   3
#        4   5   6
#        7   8   9
#

ANIM_SLIDE="workspaces,1,1,slide"
ANIM_VERT="workspaces,1,1,default,slidevert"

if [[ -z "$1" || "$1" == "--help" || "$1" == "-h" ]]; then
  grep '^#' "$0" | sed 's/^#\s\{0,1\}//'
  exit 0
fi

CUR=$(hyprctl activeworkspace -j | jq -r '.id')

case "$1" in
  left)
    hyprctl keyword animation "$ANIM_SLIDE"
    case "$CUR" in
      2|3|5|6|8|9) hyprctl dispatch workspace $((CUR-1)) ;;
      *) exit 0 ;;
    esac
    ;;
  right)
    hyprctl keyword animation "$ANIM_SLIDE"
    case "$CUR" in
      1|2|4|5|7|8) hyprctl dispatch workspace $((CUR+1)) ;;
      *) exit 0 ;;
    esac
    ;;
  up)
    hyprctl keyword animation "$ANIM_VERT"
    case "$CUR" in
      4|5|6|7|8|9) hyprctl dispatch workspace $((CUR-3)) ;;
      *) exit 0 ;;
    esac
    ;;
  down)
    hyprctl keyword animation "$ANIM_VERT"
    case "$CUR" in
      1|2|3|4|5|6) hyprctl dispatch workspace $((CUR+3)) ;;
      *) exit 0 ;;
    esac
    ;;
  *)
    echo "Error: Dirección no válida. Usa --help para ver las opciones."
    exit 1
    ;;
esac
