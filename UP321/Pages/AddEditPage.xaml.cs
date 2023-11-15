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
    /// Логика взаимодействия для AddEditPage.xaml
    /// </summary>
    public partial class AddEditPage : Page
    {
        public Exam exam;
        public AddEditPage(Exam _exam)
        {
            InitializeComponent();
            exam = _exam;
            this.DataContext = exam;
            

            SubjectCb.ItemsSource = App.db.Subject.ToList();
            SubjectCb.DisplayMemberPath = "Name_Subject";
            var aaa = App.db.Subject.ToList().Where(x => x.Id_Subject == exam.Id_Subject).First();
            SubjectCb.SelectedIndex = SubjectCb.Items.IndexOf(aaa);

            StudentCb.ItemsSource = App.db.Student.ToList();
            StudentCb.DisplayMemberPath = "Surname_Student";
            var bbb = App.db.Student.ToList().Where(x => x.Id_Student == exam.Id_Student).First();
            StudentCb.SelectedIndex = StudentCb.Items.IndexOf(bbb);

            TeacherCb.ItemsSource = App.db.Employee.ToList();
            TeacherCb.DisplayMemberPath = "Surname";
            var ccc = App.db.Employee.ToList().Where(x => x.Id_Employee == exam.Id_Employee).First();
            TeacherCb.SelectedIndex = TeacherCb.Items.IndexOf(ccc);
        }

        private void SaveButt_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrEmpty(AuditoryTb.Text) || SubjectCb.SelectedIndex == 0 || StudentCb.SelectedIndex == 0 || TeacherCb.SelectedIndex == 0 || string.IsNullOrEmpty(DatePck.Text))
            {
                MessageBox.Show("Заполните данные!");
            }
        }
    }
}
