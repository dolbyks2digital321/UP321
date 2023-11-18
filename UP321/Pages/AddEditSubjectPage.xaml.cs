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
    /// Логика взаимодействия для AddEditSubjectPage.xaml      
    /// </summary>
    public partial class AddEditSubjectPage : Page
    {
        public Subject subject;
        public string WhatToDo;
        public AddEditSubjectPage(Subject _subject, string _WhatToDo)
        {
            InitializeComponent();
            subject = _subject;
            WhatToDo = _WhatToDo;
            this.DataContext = subject;
            IdTb.MaxLength = 3;
            if (subject != null && subject.Id_Subject > 0) IdTb.IsReadOnly = true;
            LecCbx.ItemsSource = App.db.Lectern.ToList();
            LecCbx.DisplayMemberPath = "Name_Lectern";

            if (subject.Id_Subject > 0)
            {
                var sss = App.db.Lectern.ToList().Where(x => x.Id_Lectern == subject.Id_Lectern).First();
                LecCbx.SelectedIndex = LecCbx.Items.IndexOf(sss);
            }
        }

        private void SaveButt_Click(object sender, RoutedEventArgs e)
        {
            bool errors = false;
            var selectLec = LecCbx.SelectedItem as Lectern;
            if (selectLec == null || IdTb.Text == "0" || NameTb.Text == "" || SizeTb.Text == "")
            {
                errors = true;
                MessageBox.Show("Заполните обязательные данные!");
            }
            if (IdTb.Text.Length < 3)
            {
                errors = true;
                MessageBox.Show("Длина таб.номера должна быть 3 символа!");
            }
            if (App.db.Subject.Any(x => x.Id_Subject == subject.Id_Subject) && WhatToDo == "add")
            {
                errors = true;
                MessageBox.Show("Такой таб.номер уже есть!");
            }

            if (!errors)
            {
                if (WhatToDo == "add")
                {
                    App.db.Subject.Add(new Subject()
                    {
                        Id_Subject = int.Parse(IdTb.Text),
                        Name_Subject = NameTb.Text,
                        Cize_Subject = int.Parse(SizeTb.Text),
                        Id_Lectern = selectLec.Id_Lectern,
                        IsDeleted = Convert.ToBoolean(0)
                    });
                }
                else subject.Id_Lectern = selectLec.Id_Lectern;
                MessageBox.Show("Сохранено!");
                App.db.SaveChanges();
                NavigationService.Navigate(new SubjectListPage());
            }
        }
    }
}
