#!/usr/bin/env bash

# ============================================
# VSP Porto - Simulation Runner
# Package: Multi-Cloud IaC (Terraform Infrastructure)
# ============================================

set -e

# Colors
BLUE='\033[0;34m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

# Configuration
PACKAGE_NAME="iac"
PACKAGE_TITLE="MULTI-CLOUD IAC"
PACKAGE_DESC="Terraform Infrastructure Orchestration"
WEB_PORT=3002
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Parse arguments
AUTO_OPEN=false
FORCE_RECREATE=false

while [[ $# -gt 0 ]]; do
  case $1 in
    --open|-o)
      AUTO_OPEN=true
      shift
      ;;
    --force|-f)
      FORCE_RECREATE=true
      shift
      ;;
    --help|-h)
      echo "Usage: ./simulate.sh [--open] [--force] [--help]"
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

echo -e "${BLUE}"
cat << "BANNER"
   ╔═╗╔╦╗╔═╗╦ ╦╔═╗╔═╗╔═╗╔╗╔
   ╚═╗ ║ ║ ╦║ ║║ ╦║ ║║ ║║║║
   ╚═╝ ╩ ╚═╝╚═╝╚═╝╚═╝╚═╝╝╚╝
    
   IaC - Multi-Cloud Infrastructure Simulation
BANNER
echo -e "${NC}"

echo -e "${CYAN}${PACKAGE_DESC}${NC}"
echo -e ""

# Check prerequisites
echo -e "${YELLOW}>> Checking prerequisites...${NC}"

if ! command -v docker &> /dev/null; then
    echo -e "${RED}✗ Docker not found${NC}"
    exit 1
fi
echo -e "${GREEN}✓\${NC} Docker"

if ! docker info &> /dev/null; then
    echo -e "${RED}✗ Docker is not running${NC}"
    exit 1
fi
echo -e "${GREEN}✓\${NC} Docker is running"

# Check for existing containers
if docker compose -p vsp-${PACKAGE_NAME} ps &> /dev/null; then
    if [ "$FORCE_RECREATE" = true ]; then
        echo -e "${YELLOW}>> Recreating containers...${NC}"
        docker compose -p vsp-${PACKAGE_NAME} down
    else
        echo -e "${YELLOW}>> Simulation already running. Use --force to restart.${NC}"
        echo -e "${GREEN}✔ Access URLs:${NC}"
        echo -e "   🌐 Web UI:       http://localhost:${WEB_PORT}"
        exit 0
    fi
fi

echo -e "${YELLOW}>> Starting ${PACKAGE_NAME} simulation...${NC}"

if [ ! -f "$PROJECT_DIR/docker-compose.yml" ]; then
    echo -e "${RED}✗ docker-compose.yml not found${NC}"
    exit 1
fi

docker compose -p vsp-${PACKAGE_NAME} up -d

echo -e "${YELLOW}>> Waiting for services to be ready...${NC}"

MAX_WAIT=60
COUNTER=0

while [ $COUNTER -lt $MAX_WAIT ]; do
    if curl -sf --max-time 2 "http://localhost:${WEB_PORT}" > /dev/null 2>&1; then
        echo -e "${GREEN}✓\${NC} Web UI is ready"
        break
    fi
    sleep 2
    COUNTER=$((COUNTER + 2))
    printf "."
done
echo ""

# Auto-open browser
if [ "$AUTO_OPEN" = true ]; then
    echo -e "${YELLOW}>> Opening browser...${NC}"
    sleep 2
    if command -v xdg-open &> /dev/null; then
        xdg-open "http://localhost:${WEB_PORT}" &>/dev/null || true
    elif command -v open &> /dev/null; then
        open "http://localhost:${WEB_PORT}" &>/dev/null || true
    fi
fi

echo -e ""
echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}✔ ${PACKAGE_TITLE} Simulation Started Successfully!${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
echo -e ""
echo -e "  ${PACKAGE_DESC}"
echo -e ""
echo -e "  Access URLs:"
echo -e "    🌐 Terraform Dashboard: ${CYAN}http://localhost:${WEB_PORT}${NC}"
echo -e ""
echo -e "  Terraform Commands:"
echo -e "    docker exec -it vsp-${PACKAGE_NAME}-terraform sh"
echo -e "    terraform init"
echo -e "    terraform plan"
echo -e "    terraform apply"
echo -e ""
echo -e "  Commands:"
echo -e "    View logs:  ${YELLOW}docker compose -p vsp-${PACKAGE_NAME} logs -f${NC}"
echo -e "    Stop:        ${YELLOW}docker compose -p vsp-${PACKAGE_NAME} down${NC}"
echo -e ""
echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
echo -e ""
