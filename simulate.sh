#!/usr/bin/env bash

set -e

BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}"
cat << "BANNER"
   ╔═╗╔╦╗╔═╗╦ ╦╔═╗╔═╗╔═╗╔╗╔
   ╚═╗ ║ ║ ╦║ ║║ ╦║ ║║ ║║║║
   ╚═╝ ╩ ╚═╝╚═╝╚═╝╚═╝╚═╝╝╚╝
   
   IaC - Multi-Cloud Infrastructure Simulation
BANNER
echo -e "${NC}"

SIM_DIR="/tmp/vsp-iac"
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${YELLOW}>> Initializing IaC in ${SIM_DIR}...${NC}"

rm -rf "$SIM_DIR"
mkdir -p "$SIM_DIR"
cp -r "$PROJECT_DIR"/* "$SIM_DIR/"
cd "$SIM_DIR"

echo -e ">> Building Docker images..."
if command -v docker-compose &> /dev/null; then
    docker-compose -p vsp-iac up -d
else
    docker compose -p vsp-iac up -d
fi

echo -e "\n${GREEN}✔ IaC Successfully Simulated!${NC}"
echo -e "================================================================================="
echo -e "🌍 ${BLUE}Web UI${NC}:  http://localhost:3002"
echo -e "🔧 ${BLUE}Terraform${NC}: Run 'docker exec vsp_iac_terraform terraform init'"
echo -e ""
echo -e "🛑 To teardown: cd $SIM_DIR && docker compose -p vsp-iac down"
echo -e "================================================================================="
