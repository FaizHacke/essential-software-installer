#!/usr/bin/env python3
# GUI Installer for Essential Software
# Requires: Python 3.6+ and tkinter

import tkinter as tk
from tkinter import ttk, messagebox
import subprocess
import platform
import threading

class SoftwareInstaller:
    def __init__(self, root):
        self.root = root
        self.root.title("Essential Software Installer")
        self.root.geometry("600x500")
        
        # Check OS
        self.os_type = platform.system()
        
        # Create UI
        self.create_widgets()
        self.load_software_list()
    
    def create_widgets(self):
        # Title
        title = tk.Label(self.root, text="Essential Software Installer", 
                        font=("Arial", 16, "bold"))
        title.pack(pady=10)
        
        # OS Label
        os_label = tk.Label(self.root, text=f"Operating System: {self.os_type}",
                           font=("Arial", 10))
        os_label.pack()
        
        # Separator
        ttk.Separator(self.root, orient='horizontal').pack(fill='x', pady=10)
        
        # Software list frame
        frame = tk.Frame(self.root)
        frame.pack(fill='both', expand=True, padx=20, pady=10)
        
        # Scrollbar
        scrollbar = tk.Scrollbar(frame)
        scrollbar.pack(side='right', fill='y')
        
        # Listbox with checkboxes
        self.listbox = tk.Listbox(frame, selectmode='multiple',
                                  yscrollcommand=scrollbar.set)
        self.listbox.pack(side='left', fill='both', expand=True)
        scrollbar.config(command=self.listbox.yview)
        
        # Buttons
        button_frame = tk.Frame(self.root)
        button_frame.pack(pady=10)
        
        install_btn = tk.Button(button_frame, text="Install Selected",
                                command=self.install_selected,
                                bg='green', fg='white', padx=20)
        install_btn.pack(side='left', padx=5)
        
        select_all_btn = tk.Button(button_frame, text="Select All",
                                   command=self.select_all)
        select_all_btn.pack(side='left', padx=5)
        
        clear_btn = tk.Button(button_frame, text="Clear All",
                              command=self.clear_all)
        clear_btn.pack(side='left', padx=5)
        
        # Progress bar
        self.progress = ttk.Progressbar(self.root, mode='indeterminate')
        self.progress.pack(fill='x', padx=20, pady=10)
        
        # Status label
        self.status_label = tk.Label(self.root, text="Ready", fg='blue')
        self.status_label.pack(pady=5)
    
    def load_software_list(self):
        if self.os_type == "Windows":
            software = [
                "Microsoft PowerToys", "Everything", "7-Zip", "Firefox",
                "Discord", "Git", "Visual Studio Code", "VLC Media Player",
                "GIMP", "LibreOffice", "Bitwarden"
            ]
        else:  # Linux
            software = [
                "Firefox", "LibreOffice", "VLC", "GIMP", "Git",
                "VS Code", "Docker", "Timeshift", "htop", "tmux"
            ]
        
        for app in software:
            self.listbox.insert(tk.END, app)
    
    def select_all(self):
        self.listbox.select_set(0, tk.END)
    
    def clear_all(self):
        self.listbox.selection_clear(0, tk.END)
    
    def install_selected(self):
        selected = [self.listbox.get(i) for i in self.listbox.curselection()]
        
        if not selected:
            messagebox.showwarning("No Selection", "Please select software to install")
            return
        
        # Run installation in separate thread
        thread = threading.Thread(target=self.run_installation, args=(selected,))
        thread.start()
    
    def run_installation(self, selected):
        self.progress.start()
        self.status_label.config(text="Installing...", fg='orange')
        
        # Here you would call your actual installation scripts
        # For now, just simulate
        import time
        for app in selected:
            self.status_label.config(text=f"Installing {app}...")
            time.sleep(1)  # Simulate installation
        
        self.progress.stop()
        self.status_label.config(text="Installation Complete!", fg='green')
        messagebox.showinfo("Success", "Selected software has been installed!")

if __name__ == "__main__":
    root = tk.Tk()
    app = SoftwareInstaller(root)
    root.mainloop()
