import tkinter as tk
from tkinter import ttk, messagebox, simpledialog
import psycopg2
from datetime import datetime
import threading


class DatabaseGUI:
    def __init__(self, root):
        self.root = root
        self.root.title("Medical Center Management System")
        self.root.geometry("1200x800")
        self.root.configure(bg='#f0f0f0')

        # Database connection parameters
        self.db_params = {
            'host': 'localhost',
            'database': 'Level4Final',  # יש לשנות לשם בסיס הנתונים שלכם
            'user': 'postgres',  # יש לשנות לשם המשתמש שלכם
            'password': 'postgres',  # יש לשנות לסיסמה שלכם
            'port': '5433'
        }

        self.connection = None
        self.create_login_screen()

    def connect_to_db(self):
        """התחברות לבסיס הנתונים"""
        try:
            self.connection = psycopg2.connect(**self.db_params)
            return True
        except Exception as e:
            messagebox.showerror("Database Error", f"Failed to connect to database: {str(e)}")
            return False

    def create_login_screen(self):
        """יצירת מסך כניסה"""
        self.clear_screen()

        # Main frame
        main_frame = tk.Frame(self.root, bg='#2c3e50', padx=50, pady=50)
        main_frame.pack(fill=tk.BOTH, expand=True)

        # Title
        title_label = tk.Label(main_frame, text="Medical Center Management System",
                               font=('Arial', 24, 'bold'), fg='white', bg='#2c3e50')
        title_label.pack(pady=30)

        # Login form
        login_frame = tk.Frame(main_frame, bg='white', padx=30, pady=30, relief=tk.RAISED, bd=2)
        login_frame.pack(pady=50)

        tk.Label(login_frame, text="Database Host:", font=('Arial', 12)).grid(row=0, column=0, sticky='e', padx=10,
                                                                              pady=10)
        self.host_entry = tk.Entry(login_frame, font=('Arial', 12), width=20)
        self.host_entry.insert(0, 'localhost')
        self.host_entry.grid(row=0, column=1, padx=10, pady=10)

        tk.Label(login_frame, text="Database Name:", font=('Arial', 12)).grid(row=1, column=0, sticky='e', padx=10,
                                                                              pady=10)
        self.db_entry = tk.Entry(login_frame, font=('Arial', 12), width=20)
        self.db_entry.grid(row=1, column=1, padx=10, pady=10)

        tk.Label(login_frame, text="Username:", font=('Arial', 12)).grid(row=2, column=0, sticky='e', padx=10, pady=10)
        self.user_entry = tk.Entry(login_frame, font=('Arial', 12), width=20)
        self.user_entry.grid(row=2, column=1, padx=10, pady=10)

        tk.Label(login_frame, text="Password:", font=('Arial', 12)).grid(row=3, column=0, sticky='e', padx=10, pady=10)
        self.pass_entry = tk.Entry(login_frame, font=('Arial', 12), width=20, show='*')
        self.pass_entry.grid(row=3, column=1, padx=10, pady=10)

        login_btn = tk.Button(login_frame, text="Connect", font=('Arial', 12, 'bold'),
                              bg='#3498db', fg='white', padx=20, pady=10, command=self.login)
        login_btn.grid(row=4, column=0, columnspan=2, pady=20)

    def login(self):
        """פונקציית כניסה למערכת"""
        self.db_params['host'] = self.host_entry.get()
        self.db_params['database'] = self.db_entry.get()
        self.db_params['user'] = self.user_entry.get()
        self.db_params['password'] = self.pass_entry.get()

        if self.connect_to_db():
            self.create_main_menu()

    def clear_screen(self):
        """ניקוי המסך"""
        for widget in self.root.winfo_children():
            widget.destroy()

    def create_main_menu(self):
        """יצירת התפריט הראשי"""
        self.clear_screen()

        # Header
        header_frame = tk.Frame(self.root, bg='#34495e', height=80)
        header_frame.pack(fill=tk.X)
        header_frame.pack_propagate(False)

        title_label = tk.Label(header_frame, text="Medical Center Management System",
                               font=('Arial', 20, 'bold'), fg='white', bg='#34495e')
        title_label.pack(pady=20)

        # Main content
        content_frame = tk.Frame(self.root, bg='#ecf0f1')
        content_frame.pack(fill=tk.BOTH, expand=True, padx=20, pady=20)

        # Buttons grid
        buttons_frame = tk.Frame(content_frame, bg='#ecf0f1')
        buttons_frame.pack(expand=True)

        # Define menu buttons
        buttons = [
            ("Person Management", self.person_management, '#e74c3c'),
            ("Volunteer Management", self.volunteer_management, '#f39c12'),
            ("Patient Management", self.patient_management, '#27ae60'),
            ("Project Management", self.project_management, '#8e44ad'),
            ("Reports & Queries", self.reports_queries, '#3498db'),
            ("Exit", self.root.quit, '#95a5a6')
        ]

        # Create buttons in 2x3 grid
        for i, (text, command, color) in enumerate(buttons):
            btn = tk.Button(buttons_frame, text=text, font=('Arial', 14, 'bold'),
                            bg=color, fg='white', width=20, height=3,
                            command=command, relief=tk.RAISED, bd=3)
            btn.grid(row=i // 2, column=i % 2, padx=20, pady=20)

    def person_management(self):
        """ניהול אנשים - CRUD operations"""
        self.clear_screen()
        self.create_crud_screen("Person", "person", [
            ("ID", "id"),
            ("First Name", "first_name"),
            ("Last Name", "last_name"),
            ("Gender", "gender"),
            ("Birth Date", "birth_date"),
            ("Address", "address"),
            ("Phone", "phone_number"),
            ("Email", "email_address")
        ])

    def volunteer_management(self):
        """ניהול מתנדבים"""
        self.clear_screen()
        self.create_crud_screen("Volunteer", "volunteer", [
            ("Volunteer ID", "volunteer_id"),
            ("Skill", "skill"),
            ("Volunteer Type ID", "volunteer_type_id"),
            ("Manager ID", "manager_id")
        ])

    def patient_management(self):
        """ניהול מטופלים"""
        self.clear_screen()
        self.create_crud_screen("Patient", "patient", [
            ("Patient ID", "patient_id")
        ])

    def project_management(self):
        """ניהול פרויקטים"""
        self.clear_screen()
        self.create_crud_screen("Project", "project", [
            ("Project ID", "project_id"),
            ("Project Name", "project_name"),
            ("Description", "description"),
            ("Start Date", "start_date"),
            ("End Date", "end_date"),
            ("Manager ID", "manager_id")
        ])

    def create_crud_screen(self, entity_name, table_name, fields):
        """יצירת מסך CRUD כללי"""
        # Header
        header_frame = tk.Frame(self.root, bg='#2c3e50')
        header_frame.pack(fill=tk.X, pady=(0, 20))

        tk.Label(header_frame, text=f"{entity_name} Management",
                 font=('Arial', 18, 'bold'), fg='white', bg='#2c3e50').pack(pady=15)

        back_btn = tk.Button(header_frame, text="← Back to Main Menu",
                             command=self.create_main_menu, bg='#e74c3c', fg='white')
        back_btn.pack(anchor='ne', padx=20, pady=5)

        # Main container
        main_container = tk.Frame(self.root)
        main_container.pack(fill=tk.BOTH, expand=True, padx=20)

        # Left panel - Form
        form_frame = tk.LabelFrame(main_container, text=f"Add/Edit {entity_name}",
                                   font=('Arial', 12, 'bold'), padx=20, pady=20)
        form_frame.pack(side=tk.LEFT, fill=tk.Y, padx=(0, 10))

        # Create form fields
        self.form_vars = {}
        for i, (label, field_name) in enumerate(fields):
            tk.Label(form_frame, text=f"{label}:", font=('Arial', 10)).grid(row=i, column=0, sticky='e', padx=5, pady=5)
            var = tk.StringVar()
            entry = tk.Entry(form_frame, textvariable=var, font=('Arial', 10), width=20)
            entry.grid(row=i, column=1, padx=5, pady=5)
            self.form_vars[field_name] = var

        # Buttons
        btn_frame = tk.Frame(form_frame)
        btn_frame.grid(row=len(fields), column=0, columnspan=2, pady=20)

        tk.Button(btn_frame, text="Add", bg='#27ae60', fg='white',
                  command=lambda: self.add_record(table_name, fields)).pack(side=tk.LEFT, padx=5)
        tk.Button(btn_frame, text="Update", bg='#f39c12', fg='white',
                  command=lambda: self.update_record(table_name, fields)).pack(side=tk.LEFT, padx=5)
        tk.Button(btn_frame, text="Delete", bg='#e74c3c', fg='white',
                  command=lambda: self.delete_record(table_name, fields[0][1])).pack(side=tk.LEFT, padx=5)
        tk.Button(btn_frame, text="Clear", bg='#95a5a6', fg='white',
                  command=self.clear_form).pack(side=tk.LEFT, padx=5)

        # Right panel - Data display
        data_frame = tk.LabelFrame(main_container, text=f"{entity_name} List",
                                   font=('Arial', 12, 'bold'))
        data_frame.pack(side=tk.RIGHT, fill=tk.BOTH, expand=True)

        # Treeview for data display
        columns = [field[1] for field in fields]
        self.tree = ttk.Treeview(data_frame, columns=columns, show='headings', height=20)

        # Configure columns
        for col in columns:
            self.tree.heading(col, text=col.replace('_', ' ').title())
            self.tree.column(col, width=100)

        # Scrollbar
        scrollbar = ttk.Scrollbar(data_frame, orient=tk.VERTICAL, command=self.tree.yview)
        self.tree.configure(yscrollcommand=scrollbar.set)

        self.tree.pack(side=tk.LEFT, fill=tk.BOTH, expand=True, padx=10, pady=10)
        scrollbar.pack(side=tk.RIGHT, fill=tk.Y, pady=10)

        # Bind double-click to load data into form
        self.tree.bind('<Double-1>', lambda e: self.load_selected_record())

        # Load initial data
        self.refresh_data(table_name, fields)

    def add_record(self, table_name, fields):
        """הוספת רשומה חדשה"""
        try:
            cursor = self.connection.cursor()

            # Build INSERT query
            columns = [field[1] for field in fields]
            values = [self.form_vars[field[1]].get() for field in fields]

            # Remove empty values for auto-increment fields
            non_empty_columns = []
            non_empty_values = []
            for col, val in zip(columns, values):
                if val.strip():  # Only include non-empty values
                    non_empty_columns.append(col)
                    non_empty_values.append(val)

            placeholders = ', '.join(['%s'] * len(non_empty_values))
            query = f"INSERT INTO {table_name} ({', '.join(non_empty_columns)}) VALUES ({placeholders})"

            cursor.execute(query, non_empty_values)
            self.connection.commit()

            messagebox.showinfo("Success", "Record added successfully!")
            self.clear_form()
            self.refresh_data(table_name, fields)

        except Exception as e:
            messagebox.showerror("Error", f"Failed to add record: {str(e)}")
            self.connection.rollback()

    def update_record(self, table_name, fields):
        """עדכון רשומה"""
        try:
            cursor = self.connection.cursor()

            # Get primary key (first field)
            pk_field = fields[0][1]
            pk_value = self.form_vars[pk_field].get()

            if not pk_value:
                messagebox.showwarning("Warning", "Please select a record to update")
                return

            # Build UPDATE query
            set_clauses = []
            values = []
            for field in fields[1:]:  # Skip primary key
                field_name = field[1]
                value = self.form_vars[field_name].get()
                if value:  # Only update non-empty fields
                    set_clauses.append(f"{field_name} = %s")
                    values.append(value)

            if not set_clauses:
                messagebox.showwarning("Warning", "No fields to update")
                return

            values.append(pk_value)  # Add primary key value at the end
            query = f"UPDATE {table_name} SET {', '.join(set_clauses)} WHERE {pk_field} = %s"

            cursor.execute(query, values)
            self.connection.commit()

            messagebox.showinfo("Success", "Record updated successfully!")
            self.refresh_data(table_name, fields)

        except Exception as e:
            messagebox.showerror("Error", f"Failed to update record: {str(e)}")
            self.connection.rollback()

    def delete_record(self, table_name, pk_field):
        """מחיקת רשומה"""
        try:
            pk_value = self.form_vars[pk_field].get()

            if not pk_value:
                messagebox.showwarning("Warning", "Please select a record to delete")
                return

            if messagebox.askyesno("Confirm Delete", "Are you sure you want to delete this record?"):
                cursor = self.connection.cursor()
                query = f"DELETE FROM {table_name} WHERE {pk_field} = %s"
                cursor.execute(query, (pk_value,))
                self.connection.commit()

                messagebox.showinfo("Success", "Record deleted successfully!")
                self.clear_form()
                self.refresh_data(table_name, self.current_fields)

        except Exception as e:
            messagebox.showerror("Error", f"Failed to delete record: {str(e)}")
            self.connection.rollback()

    def clear_form(self):
        """ניקוי הטופס"""
        for var in self.form_vars.values():
            var.set("")

    def load_selected_record(self):
        """טעינת הרשומה הנבחרת לטופס"""
        selection = self.tree.selection()
        if selection:
            item = self.tree.item(selection[0])
            values = item['values']

            # Load values into form
            field_names = list(self.form_vars.keys())
            for i, value in enumerate(values):
                if i < len(field_names):
                    self.form_vars[field_names[i]].set(str(value))

    def refresh_data(self, table_name, fields):
        """רענון הנתונים בטבלה"""
        self.current_fields = fields  # Store for delete function
        try:
            cursor = self.connection.cursor()
            query = f"SELECT * FROM {table_name} ORDER BY {fields[0][1]}"
            cursor.execute(query)
            records = cursor.fetchall()

            # Clear existing data
            for item in self.tree.get_children():
                self.tree.delete(item)

            # Insert new data
            for record in records:
                self.tree.insert('', 'end', values=record)

        except Exception as e:
            messagebox.showerror("Error", f"Failed to refresh data: {str(e)}")

    def reports_queries(self):
        """מסך דוחות ושאילתות"""
        self.clear_screen()

        # Header
        header_frame = tk.Frame(self.root, bg='#2c3e50')
        header_frame.pack(fill=tk.X, pady=(0, 20))

        tk.Label(header_frame, text="Reports & Queries",
                 font=('Arial', 18, 'bold'), fg='white', bg='#2c3e50').pack(pady=15)

        back_btn = tk.Button(header_frame, text="← Back to Main Menu",
                             command=self.create_main_menu, bg='#e74c3c', fg='white')
        back_btn.pack(anchor='ne', padx=20, pady=5)

        # Main content
        content_frame = tk.Frame(self.root)
        content_frame.pack(fill=tk.BOTH, expand=True, padx=20)

        # Left panel - Query buttons
        query_frame = tk.LabelFrame(content_frame, text="Available Queries & Procedures",
                                    font=('Arial', 12, 'bold'), padx=20, pady=20)
        query_frame.pack(side=tk.LEFT, fill=tk.Y, padx=(0, 10))

        # Query buttons
        queries = [
            ("Volunteers by Type", self.query_volunteers_by_type),
            ("Patients with Equipment", self.query_patients_equipment),
            ("Active Projects", self.query_active_projects),
            ("Volunteer Training Report", self.procedure_volunteer_training),
            ("Patient Statistics", self.procedure_patient_stats)
        ]

        for i, (text, command) in enumerate(queries):
            btn = tk.Button(query_frame, text=text, font=('Arial', 10),
                            bg='#3498db', fg='white', width=25, height=2,
                            command=command)
            btn.pack(pady=10, padx=5)

        # Right panel - Results display
        results_frame = tk.LabelFrame(content_frame, text="Query Results",
                                      font=('Arial', 12, 'bold'))
        results_frame.pack(side=tk.RIGHT, fill=tk.BOTH, expand=True)

        # Results text area with scrollbar
        text_frame = tk.Frame(results_frame)
        text_frame.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)

        self.results_text = tk.Text(text_frame, font=('Courier', 10), wrap=tk.WORD)
        results_scrollbar = tk.Scrollbar(text_frame, orient=tk.VERTICAL, command=self.results_text.yview)
        self.results_text.configure(yscrollcommand=results_scrollbar.set)

        self.results_text.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        results_scrollbar.pack(side=tk.RIGHT, fill=tk.Y)

    def query_volunteers_by_type(self):
        """שאילתה: מתנדבים לפי סוג"""
        try:
            cursor = self.connection.cursor()
            query = """
            SELECT vt.type_name, COUNT(v.volunteer_id) as volunteer_count,
                   STRING_AGG(CONCAT(p.first_name, ' ', p.last_name), ', ') as volunteers
            FROM volunteerType vt
            LEFT JOIN volunteer v ON vt.volunteer_type_id = v.volunteer_type_id
            LEFT JOIN person p ON v.volunteer_id = p.id
            GROUP BY vt.volunteer_type_id, vt.type_name
            ORDER BY volunteer_count DESC
            """
            cursor.execute(query)
            results = cursor.fetchall()

            output = "VOLUNTEERS BY TYPE REPORT\n"
            output += "=" * 50 + "\n\n"

            for row in results:
                output += f"Type: {row[0]}\n"
                output += f"Count: {row[1]}\n"
                output += f"Volunteers: {row[2] if row[2] else 'None'}\n"
                output += "-" * 30 + "\n"

            self.display_results(output)

        except Exception as e:
            messagebox.showerror("Error", f"Query failed: {str(e)}")

    def query_patients_equipment(self):
        """שאילתה: מטופלים עם ציוד רפואי"""
        try:
            cursor = self.connection.cursor()
            query = """
            SELECT CONCAT(p.first_name, ' ', p.last_name) as patient_name,
                   me.equipment_name, ue.treatment_type, me.status
            FROM patient pat
            JOIN person p ON pat.patient_id = p.id
            JOIN useEquipment ue ON pat.patient_id = ue.patient_id
            JOIN medicalEquipment me ON ue.equipment_id = me.equipment_id
            ORDER BY patient_name, me.equipment_name
            """
            cursor.execute(query)
            results = cursor.fetchall()

            output = "PATIENTS WITH MEDICAL EQUIPMENT\n"
            output += "=" * 50 + "\n\n"

            for row in results:
                output += f"Patient: {row[0]}\n"
                output += f"Equipment: {row[1]}\n"
                output += f"Treatment Type: {row[2]}\n"
                output += f"Status: {row[3]}\n"
                output += "-" * 30 + "\n"

            self.display_results(output)

        except Exception as e:
            messagebox.showerror("Error", f"Query failed: {str(e)}")

    def query_active_projects(self):
        """שאילתה: פרויקטים פעילים"""
        try:
            cursor = self.connection.cursor()
            query = """
            SELECT proj.project_name, proj.description, 
                   proj.start_date, proj.end_date,
                   CONCAT(p.first_name, ' ', p.last_name) as manager_name,
                   COUNT(vp.volunteer_id) as volunteer_count
            FROM project proj
            JOIN worker w ON proj.manager_id = w.worker_id
            JOIN person p ON w.worker_id = p.id
            LEFT JOIN volunteerProject vp ON proj.project_id = vp.project_id
            WHERE proj.end_date >= CURRENT_DATE OR proj.end_date IS NULL
            GROUP BY proj.project_id, proj.project_name, proj.description, 
                     proj.start_date, proj.end_date, p.first_name, p.last_name
            ORDER BY proj.start_date DESC
            """
            cursor.execute(query)
            results = cursor.fetchall()

            output = "ACTIVE PROJECTS REPORT\n"
            output += "=" * 50 + "\n\n"

            for row in results:
                output += f"Project: {row[0]}\n"
                output += f"Description: {row[1]}\n"
                output += f"Start Date: {row[2]}\n"
                output += f"End Date: {row[3] if row[3] else 'Ongoing'}\n"
                output += f"Manager: {row[4]}\n"
                output += f"Volunteers: {row[5]}\n"
                output += "-" * 30 + "\n"

            self.display_results(output)

        except Exception as e:
            messagebox.showerror("Error", f"Query failed: {str(e)}")

    def procedure_volunteer_training(self):
        """פרוצדורה: דוח הכשרות מתנדבים"""
        try:
            cursor = self.connection.cursor()

            # Create a simple procedure simulation
            query = """
            SELECT CONCAT(p.first_name, ' ', p.last_name) as volunteer_name,
                   t.training_name, t.training_date, t.description
            FROM volunteer v
            JOIN person p ON v.volunteer_id = p.id
            JOIN volunteerTraining vt ON v.volunteer_id = vt.volunteer_id
            JOIN training t ON vt.training_id = t.training_id
            ORDER BY t.training_date DESC, volunteer_name
            """
            cursor.execute(query)
            results = cursor.fetchall()

            output = "VOLUNTEER TRAINING REPORT\n"
            output += "=" * 50 + "\n\n"

            current_training = ""
            for row in results:
                if current_training != row[1]:
                    current_training = row[1]
                    output += f"\nTRAINING: {row[1]}\n"
                    output += f"Date: {row[2]}\n"
                    output += f"Description: {row[3]}\n"
                    output += "Participants:\n"

                output += f"  - {row[0]}\n"

            self.display_results(output)

        except Exception as e:
            messagebox.showerror("Error", f"Procedure failed: {str(e)}")

    def procedure_patient_stats(self):
        """פרוצדורה: סטטיסטיקות מטופלים"""
        try:
            cursor = self.connection.cursor()

            # Multiple queries for comprehensive statistics
            queries = [
                ("Total Patients", "SELECT COUNT(*) FROM patient"),
                ("Patients by Gender", """
                    SELECT p.gender, COUNT(*) 
                    FROM patient pat 
                    JOIN person p ON pat.patient_id = p.id 
                    GROUP BY p.gender
                """),
                ("Patients with Medical Records", """
                    SELECT COUNT(*) 
                    FROM patient pat 
                    JOIN medicalRecord mr ON pat.patient_id = mr.patient_id
                """)
            ]

            output = "PATIENT STATISTICS REPORT\n"
            output += "=" * 50 + "\n\n"

            for title, query in queries:
                cursor.execute(query)
                results = cursor.fetchall()

                output += f"{title}:\n"
                for row in results:
                    if len(row) == 1:
                        output += f"  {row[0]}\n"
                    else:
                        output += f"  {row[0]}: {row[1]}\n"
                output += "\n"

            self.display_results(output)

        except Exception as e:
            messagebox.showerror("Error", f"Statistics procedure failed: {str(e)}")

    def display_results(self, text):
        """הצגת תוצאות השאילתה"""
        self.results_text.delete(1.0, tk.END)
        self.results_text.insert(1.0, text)


def main():
    root = tk.Tk()
    app = DatabaseGUI(root)
    root.mainloop()


if __name__ == "__main__":
    main()