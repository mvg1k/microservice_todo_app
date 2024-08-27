#!/bin/bash
set -e

CHARTS_DIR="./helm_charts_for_microservices"
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)
BOLD=$(tput bold)

tput smcup

show_main_menu() {
  clear
  echo "${BOLD}================= HELM CHART MANAGEMENT =================${RESET}"
  echo "Select an action:"
  echo "${GREEN}1. Install${RESET}"
  echo "${YELLOW}2. Upgrade${RESET}"
  echo "${RED}3. Uninstall${RESET}"
  echo "${YELLOW}0. Exit${RESET}"
  read -p "Enter your choice (1/2/3/0): " action
  case $action in
    1) select_environment "install" ;;
    2) select_environment "upgrade" ;;
    3) select_environment "uninstall" ;;
    0) exit 0 ;;
    *) echo "${RED}Invalid choice!${RESET}" ; sleep 2 ; show_main_menu ;;
  esac
}

select_environment() {
  action=$1
  clear
  echo "${BOLD}================= SELECT ENVIRONMENT =================${RESET}"
  echo "${YELLOW}1. Stage${RESET}"
  echo "${GREEN}2. Prod${RESET}"
  echo "${RED}0. Back${RESET}"
  read -p "Enter your choice (1/2/0): " env_choice
  case $env_choice in
    1) env="stage" ; confirm_environment ;;
    2) env="prod" ; confirm_environment ;;
    0) show_main_menu ;;
    *) echo "${RED}Invalid choice!${RESET}" ; sleep 2 ; select_environment $action ;;
  esac
}

confirm_environment() {
  clear
  echo "${BOLD}You selected $env environment.${RESET}"
  echo "${YELLOW}1. Yes, proceed${RESET}"
  echo "${RED}2. No, go back${RESET}"
  echo "${RED}3. Cancel${RESET}"
  read -p "Enter your choice (1/2/3): " confirm_choice
  case $confirm_choice in
    1) perform_action $action ;;
    2) select_environment $action ;;
    3) exit 0 ;;
    *) echo "${RED}Invalid choice!${RESET}" ; sleep 2 ; confirm_environment ;;
  esac
}

perform_action() {
  action=$1
  clear
  case $action in
    install) action_name="install" ;;
    upgrade) action_name="upgrade" ;;
    uninstall) action_name="uninstall" ;;
  esac
  echo "${BOLD}================= ${action_name^} HELM CHARTS =================${RESET}"
  
  for chart in redis users-api auth-api todos-api log-message-processor frontend zipkin; do
    chart_name="${chart}-${env}"
    echo "${BOLD}Processing $chart_name...${RESET}"
    
    if [ "$action" = "install" ]; then
      helm install $chart_name "$CHARTS_DIR/${chart}_helm" -f "$CHARTS_DIR/${chart}_helm/values-$env.yaml" -n $env
    elif [ "$action" = "upgrade" ]; then
      helm upgrade $chart_name "$CHARTS_DIR/${chart}_helm" -f "$CHARTS_DIR/${chart}_helm/values-$env.yaml" -n $env
    elif [ "$action" = "uninstall" ]; then
      helm uninstall $chart_name -n $env
    fi
    
    if [ $? -ne 0 ]; then
      echo "${RED}Failed to $action_name $chart_name!${RESET}"
      read -p "Press Enter to exit..."
      exit 1
    fi
  done
  
  echo "${GREEN}All charts successfully ${action_name}ed.${RESET}"
  read -p "Press Enter to exit..."
  show_main_menu
}

show_main_menu

