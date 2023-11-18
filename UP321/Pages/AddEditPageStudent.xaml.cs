using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using UP321.Components;

namespace UP321.Pages
{
    /// <summary>
    /// Логика взаимодействия для AddEditPageStudent.xaml
    /// </summary>
    public partial class AddEditPageStudent : Page
    {
        public Student student;
        public string WhatToDo;
        public AddEditPageStudent(Student _student, string _whatToDo)
        {
            InitializeComponent();
            student = _student;
            WhatToDo = _whatToDo;
            this.DataContext = student;
            IdTb.MaxLength = 5;
            if (student != null && student.Id_Student > 0) IdTb.IsReadOnly = true;
            SpecCbx.ItemsSource = App.db.Specs.ToList();
            SpecCbx.DisplayMemberPath = "Direction";

            if (student.Id_Student > 0)
            {
                var sss = App.db.Specs.ToList().Where(x => x.Id_Spec == student.Id_Spec).First();
                SpecCbx.SelectedIndex = SpecCbx.Items.IndexOf(sss);
            }
        }

        private void SaveButt_Click(object sender, RoutedEventArgs e)
        {
            bool errors = false;
            var selectSpec = SpecCbx.SelectedItem as Specs;
            if (selectSpec == null || IdTb.Text == "0" || FioTb.Text == "")
            {
                errors = true;
                MessageBox.Show("Заполните обязательные данные!");
            }
            if (IdTb.Text.Length < 5)
            {
                errors = true;
                MessageBox.Show("Длина таб.номера должна быть 5 символа!");
            }
            if (App.db.Student.Any(x => x.Id_Student == student.Id_Student) && WhatToDo == "add")
            {
                errors = true;
                MessageBox.Show("Такой таб.номер уже есть!");
            }
            if (!errors)
            {
                if (WhatToDo == "add")
                {
                    App.db.Student.Add(new Student()
                    {
                        Id_Student = student.Id_Student,
                        Surname_Student = student.Surname_Student,
                        Id_Spec = selectSpec.Id_Spec,
                        IsDeleted = Convert.ToBoolean(0)
                    });
                }
                else student.Id_Spec = selectSpec.Id_Spec;
                MessageBox.Show("Сохранено!");
                App.db.SaveChanges();
                NavigationService.Navigate(new StudentList());
            }
        }

        private void IdTb_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            if (!char.IsDigit(e.Text, 0))
            {
                e.Handled = true;
            }
        }
    }
}
