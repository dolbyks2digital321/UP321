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
            if (App.Role == "st")
                ExamList.ItemsSource = App.db.Exam.ToList().Where(x => x.IsDeleted != Convert.ToBoolean(1) && x.Id_Student == App.User);
            else
            ExamList.ItemsSource = App.db.Exam.ToList().Where(x => x.IsDeleted != Convert.ToBoolean(1));
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
    }
}
