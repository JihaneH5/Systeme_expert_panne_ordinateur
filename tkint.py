# -*- coding: utf-8 -*-
"""
Interface Simple pour le Système Expert de Diagnostic PC
"""

from tkinter import *
from tkinter import ttk, scrolledtext, messagebox
from pyswip import Prolog

# ================= INITIALISATION PROLOG =================
prolog = Prolog()
try:
    prolog.consult("diagnostic_pc.pl")
    print("✓ Prolog chargé")
except Exception as e:
    print(f"✗ Erreur: {e}")

# ================= SYMPTÔMES =================
SYMPTOMES = {
    "DÉMARRAGE": [
        ("ordinateur_ne_demarre_pas", "L'ordinateur ne démarre pas"),
        ("aucun_bruit_ventilateur", "Aucun bruit de ventilateur"),
        ("aucune_led_allumee", "Aucune LED allumée"),
        ("ecran_noir_demarrage", "Écran noir au démarrage"),
        ("demarrage_lent", "Démarrage très lent"),
    ],
    
    "TEMPÉRATURE": [
        ("ordinateur_tres_chaud", "Ordinateur très chaud"),
        ("surchauffe", "Surchauffe"),
        ("bruit_ventilateur_anormal", "Bruit ventilateur anormal"),
        ("arrets_inopines", "Arrêts inopinés"),
    ],
    
    "PERFORMANCE": [
        ("systeme_tres_lent", "Système très lent"),
        ("ralentissements_frequents", "Ralentissements fréquents"),
        ("blocages_frequents", "Blocages fréquents"),
        ("programmes_plantent", "Programmes plantent"),
    ],
    
    "DISQUE": [
        ("bruits_cliquetis", "Bruits de cliquetis"),
        ("espace_disque_faible", "Disque presque plein"),
        ("fichiers_inaccessibles", "Fichiers inaccessibles"),
    ],
    
    "ÉCRANS BLEUS": [
        ("ecran_bleu_mort", "Écrans bleus (BSOD)"),
        ("erreur_fichiers_systeme", "Erreurs système"),
    ],
    
    "AFFICHAGE": [
        ("pixels_morts", "Pixels morts"),
        ("couleurs_deformees", "Couleurs déformées"),
        ("artefacts_visuels", "Artefacts visuels"),
    ],
    
    "RÉSEAU": [
        ("pas_de_connexion_internet", "Pas d'Internet"),
        ("wifi_non_detecte", "WiFi non détecté"),
    ],
    
    "AUDIO": [
        ("pas_de_son", "Pas de son"),
        ("son_deforme", "Son déformé"),
    ],
    
    "VIRUS": [
        ("fenetres_pub_intempestives", "Pubs intempestives"),
        ("programmes_inconnus", "Programmes inconnus"),
    ],
}

# ================= CLASSE PRINCIPALE =================
class DiagnosticApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Diagnostic PC - Système Expert")
        self.root.geometry("900x650")
        self.root.configure(bg="#ecf0f1")
        
        self.vars = {}
        self.creer_interface()
    
    def creer_interface(self):
        # EN-TÊTE
        header = Frame(self.root, bg="#2c3e50", height=80)
        header.pack(fill=X)
        header.pack_propagate(False)
        
        Label(
            header,
            text=" DIAGNOSTIC PC",
            font=("Arial", 18, "bold"),
            bg="#2c3e50",
            fg="white"
        ).pack(pady=20)
        
        # INSTRUCTIONS
        Label(
            self.root,
            text="Cochez les symptômes observés",
            font=("Arial", 11),
            bg="#ecf0f1"
        ).pack(pady=10)
        
        # ZONE SYMPTÔMES
        main = Frame(self.root, bg="#ecf0f1")
        main.pack(fill=BOTH, expand=True, padx=10, pady=10)
        
        canvas = Canvas(main, bg="#ecf0f1", highlightthickness=0)
        scrollbar = Scrollbar(main, orient=VERTICAL, command=canvas.yview)
        frame = Frame(canvas, bg="#ecf0f1")
        
        frame.bind(
            "<Configure>",
            lambda e: canvas.configure(scrollregion=canvas.bbox("all"))
        )
        
        canvas.create_window((0, 0), window=frame, anchor="nw")
        canvas.configure(yscrollcommand=scrollbar.set)
        
        # CRÉER LES CATÉGORIES
        for categorie, symptomes in SYMPTOMES.items():
            # Container
            container = Frame(frame, bg="#ecf0f1")
            container.pack(fill=X, pady=3)
            
            # Bouton titre
            btn_frame = Frame(container, bg="white", relief=RAISED, bd=1)
            btn_frame.pack(fill=X)
            
            # Frame symptômes
            symp_frame = Frame(container, bg="#f8f9fa", relief=SUNKEN, bd=1)
            
            # Variable d'état
            is_open = [False]
            
            def make_toggle(sf, btn, cat):
                def toggle():
                    if is_open[0]:
                        sf.pack_forget()
                        btn.config(text=f"▶  {cat}")
                        is_open[0] = False
                    else:
                        sf.pack(fill=X, padx=10, pady=(0, 5))
                        btn.config(text=f"▼  {cat}")
                        is_open[0] = True
                return toggle
            
            btn = Button(
                btn_frame,
                text=f"▶  {categorie}",
                font=("Arial", 10, "bold"),
                bg="white",
                fg="#2c3e50",
                anchor="w",
                relief=FLAT,
                cursor="hand2",
                padx=10,
                pady=8,
                command=make_toggle(symp_frame, None, categorie)
            )
            btn.pack(fill=X)
            btn.config(command=make_toggle(symp_frame, btn, categorie))
            
            # Checkboxes
            for code, desc in symptomes:
                var = BooleanVar()
                Checkbutton(
                    symp_frame,
                    text=desc,
                    variable=var,
                    font=("Arial", 9),
                    bg="#f8f9fa",
                    anchor="w",
                    padx=20,
                    pady=3
                ).pack(fill=X)
                self.vars[code] = var
        
        canvas.pack(side=LEFT, fill=BOTH, expand=True)
        scrollbar.pack(side=RIGHT, fill=Y)
        
        # SCROLL AVEC PAVÉ TACTILE / MOLETTE
        def scroll_molette(event):
            canvas.yview_scroll(int(-1*(event.delta/120)), "units")
        
        def scroll_linux(event):
            if event.num == 4:
                canvas.yview_scroll(-1, "units")
            elif event.num == 5:
                canvas.yview_scroll(1, "units")
        
        # Windows et MacOS
        canvas.bind_all("<MouseWheel>", scroll_molette)
        # Linux
        canvas.bind_all("<Button-4>", scroll_linux)
        canvas.bind_all("<Button-5>", scroll_linux)
        
        # BOUTONS
        btn_frame = Frame(self.root, bg="#ecf0f1", height=70)
        btn_frame.pack(fill=X, padx=10, pady=5)
        btn_frame.pack_propagate(False)
        
        Button(
            btn_frame,
            text="🔍 DIAGNOSTIQUER",
            font=("Arial", 12, "bold"),
            bg="#27ae60",
            fg="white",
            cursor="hand2",
            command=self.diagnostiquer,
            width=18,
            height=2
        ).pack(side=LEFT, padx=10, pady=15)
        
        Button(
            btn_frame,
            text="🔄 RÉINITIALISER",
            font=("Arial", 12, "bold"),
            bg="#e74c3c",
            fg="white",
            cursor="hand2",
            command=self.reinitialiser,
            width=18,
            height=2
        ).pack(side=LEFT, padx=10, pady=15)
    
    def diagnostiquer(self):
        # Réinitialiser Prolog
        list(prolog.query("reset_diagnostic"))
        
        # Collecter symptômes
        symptomes = []
        for code, var in self.vars.items():
            if var.get():
                symptomes.append(code)
                list(prolog.query(f"set_symptome({code})"))
        
        if not symptomes:
            messagebox.showwarning(
                "Aucun symptôme",
                "Veuillez sélectionner au moins un symptôme."
            )
            return
        
        # Diagnostic
        try:
            resultats = list(prolog.query("run_diagnostic(P, S)"))
            self.afficher_resultat(resultats, symptomes)
        except Exception as e:
            messagebox.showerror("Erreur", f"Erreur Prolog:\n{str(e)}")
    
    def afficher_resultat(self, resultats, symptomes):
        # Fenêtre résultat
        win = Toplevel(self.root)
        win.title("Résultat du Diagnostic")
        win.geometry("750x600")
        win.configure(bg="#ecf0f1")
        
        # En-tête
        header = Frame(win, bg="#27ae60", height=70)
        header.pack(fill=X)
        header.pack_propagate(False)
        
        Label(
            header,
            text="📋 DIAGNOSTIC",
            font=("Arial", 16, "bold"),
            bg="#27ae60",
            fg="white"
        ).pack(pady=20)
        
        # Zone texte
        text = scrolledtext.ScrolledText(
            win,
            font=("Courier New", 10),
            bg="white",
            wrap=WORD,
            padx=15,
            pady=15
        )
        text.pack(fill=BOTH, expand=True, padx=15, pady=15)
        
        # Afficher
        if resultats:
            panne = resultats[0]['P']
            solution = resultats[0]['S']
            
            text.insert(END, "=" * 70 + "\n")
            text.insert(END, f"PANNE: {panne}\n")
            text.insert(END, "=" * 70 + "\n\n")
            text.insert(END, solution + "\n\n")
            text.insert(END, "-" * 70 + "\n")
            text.insert(END, f"Symptômes analysés: {len(symptomes)}\n")
            text.insert(END, "-" * 70 + "\n")
            for i, s in enumerate(symptomes, 1):
                text.insert(END, f"{i}. {s}\n")
        else:
            text.insert(END, "Aucun diagnostic trouvé")
        
        text.config(state=DISABLED)
        
        # Bouton
        Button(
            win,
            text="Fermer",
            font=("Arial", 11, "bold"),
            bg="#95a5a6",
            fg="white",
            command=win.destroy,
            width=15
        ).pack(pady=10)
    
    def reinitialiser(self):
        for var in self.vars.values():
            var.set(False)
        messagebox.showinfo("Réinitialisation", "Symptômes désélectionnés")

# ================= LANCEMENT =================
if __name__ == "__main__":
    root = Tk()
    app = DiagnosticApp(root)
    root.mainloop()