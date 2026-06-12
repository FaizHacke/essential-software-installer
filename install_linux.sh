#!/bin/bash
# Essential Software Installer for Linux
# Supports: Ubuntu/Debian, Fedora, Arch Linux

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${CYAN}========================================${NC}"
echo -e "${CYAN}   Essential Software Installer for Linux${NC}"
echo -e "${CYAN}========================================${NC}"
echo ""

# Detect distribution
detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        DISTRO=$ID
    else
        echo -e "${RED}Cannot detect Linux distribution${NC}"
        exit 1
    fi
}

# Ubuntu/Debian installation
install_ubuntu() {
    echo -e "${GREEN}Detected Ubuntu/Debian system${NC}"
    echo -e "${YELLOW}Updating package lists...${NC}"
    sudo apt update
    
    echo -e "${YELLOW}Installing essential software...${NC}"
    
    # Core utilities
    sudo apt install -y firefox libreoffice vlc gimp git curl wget \
                        htop tmux flameshot filezilla bleachbit
    
    # Snap packages
    sudo snap install obs-studio
    sudo snap install code --classic
    sudo snap install discord
    sudo snap install telegram-desktop
    
    # Docker
    curl -fsSL https://get.docker.com | sudo sh
    sudo usermod -aG docker $USER
    
    # Timeshift
    sudo apt install -y timeshift
    
    # Stacer
    sudo add-apt-repository -y ppa:oguzhaninan/stacer
    sudo apt update
    sudo apt install -y stacer
}

# Fedora installation
install_fedora() {
    echo -e "${GREEN}Detected Fedora system${NC}"
    sudo dnf update -y
    
    sudo dnf install -y firefox libreoffice vlc gimp git curl wget \
                        htop tmux flameshot filezilla bleachbit timeshift
    
    # Flatpak packages
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install -y flathub com.obsproject.Studio
    flatpak install -y flathub com.visualstudio.code
    flatpak install -y flathub com.discordapp.Discord
    flatpak install -y flathub org.telegram.desktop
    
    # Docker
    sudo dnf install -y dnf-plugins-core
    sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
    sudo dnf install -y docker-ce docker-ce-cli containerd.io
    sudo systemctl start docker
    sudo usermod -aG docker $USER
}

# Arch Linux installation
install_arch() {
    echo -e "${GREEN}Detected Arch Linux system${NC}"
    
    sudo pacman -Syu --noconfirm
    
    sudo pacman -S --noconfirm firefox libreoffice-fresh vlc gimp git curl wget \
                              htop tmux flameshot filezilla bleachbit timeshift stacer \
                              docker discord telegram-desktop code obs-studio
    
    sudo systemctl enable --now docker
    sudo usermod -aG docker $USER
}

# Main installation
detect_distro

case $DISTRO in
    ubuntu|debian)
        install_ubuntu
        ;;
    fedora)
        install_fedora
        ;;
    arch|manjaro)
        install_arch
        ;;
    *)
        echo -e "${RED}Unsupported distribution: $DISTRO${NC}"
        echo -e "${YELLOW}Currently supported: Ubuntu, Debian, Fedora, Arch, Manjaro${NC}"
        exit 1
        ;;
esac

echo ""
echo -e "${CYAN}========================================${NC}"
echo -e "${GREEN}   Installation Complete!${NC}"
echo -e "${CYAN}========================================${NC}"
echo ""
echo -e "${YELLOW}IMPORTANT:${NC}"
echo -e "1. Log out and back in for Docker permissions to take effect"
echo -e "2. Some apps may appear in your application menu after restart"
echo ""
