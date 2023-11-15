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
            if (exam.Date_Exam == null ) DatePck.SelectedDate = exam.DateExam;
            DatePck.DisplayDateStart = new DateTime(2014, 01, 01);

            MarkTb.MaxLength = 1;

            SubjectCb.ItemsSource = App.db.Subject.ToList();
            SubjectCb.DisplayMemberPath = "Name_Subject";

            StudentCb.ItemsSource = App.db.Student.ToList();
            StudentCb.DisplayMemberPath = "Surname_Student";
            
            TeacherCb.ItemsSource = App.db.Employee.ToList();
            TeacherCb.DisplayMemberPath = "Surname";

            if (exam.Id_Exam > 0)
            {
                var bbb = App.db.Student.ToList().Where(x => x.Id_Student == exam.Id_Student).First();
                StudentCb.SelectedIndex = StudentCb.Items.IndexOf(bbb);
                var aaa = App.db.Subject.ToList().Where(x => x.Id_Subject == exam.Id_Subject).First();
                SubjectCb.SelectedIndex = SubjectCb.Items.IndexOf(aaa);
                var ccc = App.db.Employee.ToList().Where(x => x.Id_Employee == exam.Id_Employee).First();
                TeacherCb.SelectedIndex = TeacherCb.Items.IndexOf(ccc);
            }
        }

        private void SaveButt_Click(object sender, RoutedEventArgs e)
        {
            bool errors = false;
            //if (string.IsNullOrEmpty(AuditoryTb.Text) || SubjectCb.SelectedIndex == 0 || StudentCb.SelectedIndex == 0 || TeacherCb.SelectedIndex == 0)
            //{
            //    MessageBox.Show("Заполните данные!");
            //}
            if (MarkTb.Text == "" || char.IsDigit(char.Parse(MarkTb.Text)))
            {
                if (int.Parse(MarkTb.Text) > 5 || int.Parse(MarkTb.Text) < 1)
                {
                    MessageBox.Show("Неправильный формат оценки!");
                    errors = true;
                }
            }
            else
            { MessageBox.Show("Неправильный формат оценки!"); errors = true; }

            if (exam.Id_Exam == 0)
            {
                if (App.db.Exam.Any(x => x.Date_Exam == exam.Date_Exam && x.Id_Student == exam.Id_Student && x.Id_Subject == exam.Id_Subject))
                {
                    MessageBox.Show("Повторение!!1!");
                    errors = true;
                }
                else
                {
                    App.db.Exam.Add(exam);
                }
            }
            if (!errors)
            {
                App.db.SaveChanges();
                MessageBox.Show("Сохранено!");
            }
        }
    }
}
