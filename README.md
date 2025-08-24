# SCT_CS_1# 🔐 Caesar Cipher Tool (Bash Edition)

A **lightweight, dialog-based Caesar Cipher encryption & decryption tool** built in **pure Bash**.  
It brings a simple yet professional **text-based GUI** for one of the oldest cryptographic algorithms.

---

## ✨ Features
- 🔒 **Encrypt** and 🔓 **Decrypt** messages  
- 🎛 Adjustable **shift values** (1–25)  
- 🎨 **Colorful terminal UI** with `dialog`  
- ⚡ **Quick CLI mode** for instant encryption/decryption  
- 💻 Runs on **any Linux terminal**  
- 📚 Great for learning **classical cryptography**  

---

## 📦 Installation
step 1:Make sure you have **Bash** and **dialog** installed.  
```bash
# Ubuntu / Debian
sudo apt-get install dialog -y

# Fedora / RHEL
sudo dnf install dialog -y

# Arch Linux
sudo pacman -S dialog

Step 2:
 Clone the repository:
   ```bash
   git clone https://github.com/your-username/caesar-cipher-tool.git
   cd caesar-cipher-tool

Give execution permission to the script:
   ```bash
   chmod +x caesar_cipher_tool.sh
Run the tool:
   ```bash
   ./caesar_cipher_tool.sh
