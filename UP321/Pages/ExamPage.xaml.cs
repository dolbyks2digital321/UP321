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
    /// Interaction logic for ExamPage.xaml
    /// </summary>
    public partial class ExamPage : Page
    {
        public ExamPage()
        {
            InitializeComponent();
            Refresh();
            if (App.Role == "st")
            {
                AddButt.Visibility = Visibility.Collapsed;
                DeleteButt.Visibility = Visibility.Collapsed;
                RedactButt.Visibility = Visibility.Collapsed;
            }
        }

        private void DeleteButt_Click(object sender, RoutedEventArgs e)
        {
            var exam = (Exam)ExamList.SelectedItem;
            exam.IsDeleted = Convert.ToBoolean(1);
            Refresh();
            App.db.SaveChanges();
        }

        public void Refresh()
        {
            IEnumerable<Exam> examsort = App.db.Exam;
            if (SortCB.SelectedIndex == 1) examsort = examsort.OrderByDescending(x => x.Date_Exam);
            if (SortCB.SelectedIndex == 2) examsort = examsort.OrderBy(x => x.Date_Exam);

            if (MarkSortCB.SelectedIndex != 0)
            {
                if (MarkSortCB.SelectedIndex == 1) examsort = examsort.Where(x => x.Mark == 5);
                else if (MarkSortCB.SelectedIndex == 2) examsort = examsort.Where(x => x.Mark == 4);
                else if (MarkSortCB.SelectedIndex == 3) examsort = examsort.Where(x => x.Mark == 3);
                else if (MarkSortCB.SelectedIndex == 4) examsort = examsort.Where(x => x.Mark == 2);
                else if (MarkSortCB.SelectedIndex == 5) examsort = examsort.Where(x => x.Mark == 1);
            }
            if (SearchTbx.Text != null)
            {
                examsort = examsort.Where(x => x.Student.Surname_Student.ToLower().Contains(SearchTbx.Text.ToLower()) || x.Subject.Name_Subject.ToLower().Contains(SearchTbx.Text.ToLower()) || x.Employee.Surname.ToLower().Contains(SearchTbx.Text.ToLower()));
            }

            if (App.Role == "st")
                ExamList.ItemsSource = examsort.Where(x => x.IsDeleted != Convert.ToBoolean(1) && x.Id_Student == App.User);
            else
            ExamList.ItemsSource = examsort.ToList().Where(x => x.IsDeleted != Convert.ToBoolean(1));

            
        }

        private void RedactButt_Click(object sender, RoutedEventArgs e)
        {
            var exam = (Exam)ExamList.SelectedItem;
            if (exam == null) MessageBox.Show("Для редактирования выберите данные!");
            else NavigationService.Navigate(new AddEditPageExam(exam));
        }

        private void AddButt_Click(object sender, RoutedEventArgs e)
        {
            var exam = new Exam();
            NavigationService.Navigate(new AddEditPageExam(exam));
        }

        private void SortCB_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Refresh();
        }

        private void MarkSortCB_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Refresh();
        }

        private void SearchTbx_TextChanged(object sender, TextChangedEventArgs e)
        {
            Refresh();
        }
    }
}
