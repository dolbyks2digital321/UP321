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
    /// Логика взаимодействия для AddEditPageExam.xaml
    /// </summary>
    public partial class AddEditPageExam : Page
    {
        public Exam exam;
        public AddEditPageExam(Exam _exam)
        {
            InitializeComponent();
            exam = _exam;
            this.DataContext = exam;
            DatePck.DisplayDateStart = new DateTime(2014, 01, 01);

            MarkTb.MaxLength = 1;

            SubjectCb.ItemsSource = App.db.Subject.ToList().Where(x => x.IsDeleted == Convert.ToBoolean(0));
            SubjectCb.DisplayMemberPath = "Name_Subject";

            StudentCb.ItemsSource = App.db.Student.ToList().Where(x => x.IsDeleted == Convert.ToBoolean(0));
            StudentCb.DisplayMemberPath = "Surname_Student";

            TeacherCb.ItemsSource = App.db.Employee.ToList().Where(x => x.IsDeleted == Convert.ToBoolean(0));
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
            if (exam.Id_Exam == 0)
            {
                exam.Date_Exam = DateTime.Now;
            }
        }

        private void SaveButt_Click(object sender, RoutedEventArgs e)
        {
            bool errors = false;
            var selectStudent = StudentCb.SelectedItem as Student;
            var selectTeacher = TeacherCb.SelectedItem as Employee;
            var selectSubject = SubjectCb.SelectedItem as Subject;
            if (string.IsNullOrEmpty(AuditoryTb.Text) || selectStudent == null || selectTeacher == null || selectSubject == null)
            {
                MessageBox.Show("Заполните данные!");
                errors = true;
            }
            if ((MarkTb.Text == "" || char.IsDigit(char.Parse(MarkTb.Text))) && !errors)
            {
                if (int.Parse(MarkTb.Text) > 5 || int.Parse(MarkTb.Text)
       < 1)
                {
                    MessageBox.Show("Неправильный формат оценки!");
                    errors = true;
                }
            }
            else
            { MessageBox.Show("Неправильный формат оценки!"); errors = true; }

            if (exam.Id_Exam == 0 && !errors)
            {
                if (App.db.Exam.Any(x => x.Date_Exam == exam.Date_Exam && x.Id_Student == exam.Id_Student && x.Id_Subject == exam.Id_Subject))
                {
                    MessageBox.Show("Повторение!!1!");
                    errors = true;
                }
                else
                {

                    App.db.Exam.Add(new Exam()
                    {
                        Date_Exam = exam.Date_Exam,
                        Id_Subject = selectSubject.Id_Subject,
                        Id_Student = selectStudent.Id_Student,
                        Id_Employee = selectTeacher.Id_Employee,
                        Auditory = exam.Auditory,
                        Mark = exam.Mark,
                        IsDeleted = Convert.ToBoolean(0),
                    });
                }
            }
            if (!errors)
            {
                exam.Id_Subject = selectSubject.Id_Subject;
                exam.Id_Student = selectStudent.Id_Student;
                exam.Id_Employee = selectTeacher.Id_Employee;
                App.db.SaveChanges();
                MessageBox.Show("Сохранено!");
                NavigationService.Navigate(new ExamPage());
            }
        }
    }
}
