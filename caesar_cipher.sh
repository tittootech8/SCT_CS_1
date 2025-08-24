#!/bin/bash

# Caesar Cipher Tool - Linux Bash Script Version
# A GUI-like encryption tool using dialog

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Check if dialog is installed
check_dependencies() {
    if ! command -v dialog &> /dev/null; then
        echo -e "${RED}Error: dialog is not installed.${NC}"
        echo -e "${YELLOW}Please install it with:${NC}"
        echo -e "  Ubuntu/Debian: sudo apt-get install dialog"
        echo -e "  Fedora/RHEL: sudo dnf install dialog"
        echo -e "  Arch: sudo pacman -S dialog"
        exit 1
    fi
}

# Caesar cipher encryption function
encrypt() {
    local text="$1"
    local shift="$2"
    local result=""
    
    for ((i=0; i<${#text}; i++)); do
        char="${text:$i:1}"
        if [[ "$char" =~ [a-zA-Z] ]]; then
            if [[ "$char" =~ [a-z] ]]; then
                base=97
            else
                base=65
            fi
            ascii=$(printf "%d" "'$char")
            new_ascii=$(( (ascii - base + shift) % 26 + base ))
            result+=$(printf "\\$(printf %03o $new_ascii)")
        else
            result+="$char"
        fi
    done
    
    echo "$result"
}

# Caesar cipher decryption function
decrypt() {
    local text="$1"
    local shift="$2"
    encrypt "$text" $((26 - shift % 26))
}

# Show welcome message with ASCII art
show_welcome() {
    clear
    echo -e "${PURPLE}"
    echo "╔══════════════════════════════════════════════════════════╗"
    echo "║                   CAESAR CIPHER TOOL                     ║"
    echo "║                 Linux Bash Edition                      ║"
    echo "╚══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo -e "${CYAN}🔐 Secure Message Encryption Tool${NC}"
    echo -e "${YELLOW}📱 Run on any Linux terminal${NC}"
    echo -e "${GREEN}✨ Simple and intuitive interface${NC}"
    echo ""
    echo -e "${BLUE}Press Enter to continue...${NC}"
    read -r
}

# Show about information
show_about() {
    dialog --backtitle "Caesar Cipher Tool" \
           --title "About This Tool" \
           --msgbox "\
🔐 Caesar Cipher Tool

Version: 1.0
Author: Security Tools Team
Platform: Linux Bash

Features:
- Encrypt messages with Caesar cipher
- Decrypt encoded messages
- Adjustable shift value (1-25)
- Simple text-based interface
- Secure and lightweight

The Caesar cipher is one of the oldest
encryption techniques, used by Julius Caesar
to protect military communications.

Note: This is for educational purposes only.
Not suitable for real security needs." 20 60
}

# Show instructions
show_instructions() {
    dialog --backtitle "Caesar Cipher Tool" \
           --title "How to Use" \
           --msgbox "\
📖 INSTRUCTIONS:

1. Choose 'Encrypt' or 'Decrypt' from main menu
2. Enter your message in the text box
3. Set the shift value (1-25)
4. View your encrypted/decrypted result
5. Copy the result as needed

🔧 TIPS:
- Default shift is 3 (classic Caesar cipher)
- Use the same shift value for encryption and decryption
- Only letters are encrypted, other characters remain unchanged
- The tool preserves case (uppercase/lowercase)" 18 60
}

# Main encryption function
do_encrypt() {
    local message=$(dialog --backtitle "Caesar Cipher Tool" \
                          --title "Encrypt Message" \
                          --inputbox "Enter message to encrypt:" 10 60 3>&1 1>&2 2>&3)
    
    if [ $? -ne 0 ]; then
        return
    fi
    
    local shift_val=$(dialog --backtitle "Caesar Cipher Tool" \
                           --title "Encryption Shift" \
                           --inputbox "Enter shift value (1-25):" 10 60 "3" 3>&1 1>&2 2>&3)
    
    if [ $? -ne 0 ]; then
        return
    fi
    
    # Validate shift value
    if ! [[ "$shift_val" =~ ^[0-9]+$ ]] || [ "$shift_val" -lt 1 ] || [ "$shift_val" -gt 25 ]; then
        dialog --backtitle "Caesar Cipher Tool" \
               --title "Error" \
               --msgbox "Invalid shift value! Please enter a number between 1 and 25." 10 60
        return
    fi
    
    local encrypted=$(encrypt "$message" "$shift_val")
    
    dialog --backtitle "Caesar Cipher Tool" \
           --title "Encryption Result" \
           --msgbox "🔒 Encrypted Message:\n\n$encrypted\n\nShift value: $shift_val\n\nPress Ctrl+C to copy" 15 60
}

# Main decryption function
do_decrypt() {
    local message=$(dialog --backtitle "Caesar Cipher Tool" \
                          --title "Decrypt Message" \
                          --inputbox "Enter message to decrypt:" 10 60 3>&1 1>&2 2>&3)
    
    if [ $? -ne 0 ]; then
        return
    fi
    
    local shift_val=$(dialog --backtitle "Caesar Cipher Tool" \
                           --title "Decryption Shift" \
                           --inputbox "Enter shift value (1-25):" 10 60 "3" 3>&1 1>&2 2>&3)
    
    if [ $? -ne 0 ]; then
        return
    fi
    
    # Validate shift value
    if ! [[ "$shift_val" =~ ^[0-9]+$ ]] || [ "$shift_val" -lt 1 ] || [ "$shift_val" -gt 25 ]; then
        dialog --backtitle "Caesar Cipher Tool" \
               --title "Error" \
               --msgbox "Invalid shift value! Please enter a number between 1 and 25." 10 60
        return
    fi
    
    local decrypted=$(decrypt "$message" "$shift_val")
    
    dialog --backtitle "Caesar Cipher Tool" \
           --title "Decryption Result" \
           --msgbox "🔓 Decrypted Message:\n\n$decrypted\n\nShift value: $shift_val\n\nPress Ctrl+C to copy" 15 60
}

# Quick encrypt function
quick_encrypt() {
    local message="$1"
    local shift_val=3
    encrypt "$message" "$shift_val"
}

# Quick decrypt function
quick_decrypt() {
    local message="$1"
    local shift_val=3
    decrypt "$message" "$shift_val"
}

# Main menu
main_menu() {
    while true; do
        choice=$(dialog --backtitle "Caesar Cipher Tool" \
                       --title "Main Menu" \
                       --menu "Choose an option:" 15 60 5 \
                       "1" "🔒 Encrypt Message" \
                       "2" "🔓 Decrypt Message" \
                       "3" "📖 Instructions" \
                       "4" "ℹ️ About" \
                       "5" "🚪 Exit" 3>&1 1>&2 2>&3)
        
        case $choice in
            1)
                do_encrypt
                ;;
            2)
                do_decrypt
                ;;
            3)
                show_instructions
                ;;
            4)
                show_about
                ;;
            5)
                clear
                echo -e "${GREEN}Thank you for using Caesar Cipher Tool!${NC}"
                echo -e "${BLUE}Goodbye! 👋${NC}"
                exit 0
                ;;
            *)
                clear
                echo -e "${RED}Exiting...${NC}"
                exit 0
                ;;
        esac
    done
}

# Command line usage
show_usage() {
    echo -e "${GREEN}Caesar Cipher Tool - Usage:${NC}"
    echo -e "  ${YELLOW}./caesar_cipher_tool.sh${NC}          - Interactive mode"
    echo -e "  ${YELLOW}./caesar_cipher_tool.sh encrypt TEXT${NC} - Quick encrypt (shift=3)"
    echo -e "  ${YELLOW}./caesar_cipher_tool.sh decrypt TEXT${NC} - Quick decrypt (shift=3)"
    echo -e "  ${YELLOW}./caesar_cipher_tool.sh help${NC}       - Show this help"
}

# Make script executable
make_executable() {
    chmod +x "$0"
    echo -e "${GREEN}Script is now executable!${NC}"
}

# Main execution
main() {
    check_dependencies
    
    case "$1" in
        encrypt)
            if [ -z "$2" ]; then
                echo -e "${RED}Error: No text provided for encryption${NC}"
                show_usage
                exit 1
            fi
            result=$(quick_encrypt "$2")
            echo -e "${GREEN}Encrypted:${NC} $result"
            ;;
        decrypt)
            if [ -z "$2" ]; then
                echo -e "${RED}Error: No text provided for decryption${NC}"
                show_usage
                exit 1
            fi
            result=$(quick_decrypt "$2")
            echo -e "${GREEN}Decrypted:${NC} $result"
            ;;
        help|--help|-h)
            show_usage
            ;;
        *)
            show_welcome
            main_menu
            ;;
    esac
}

# Run main function with all arguments
main "$@"

