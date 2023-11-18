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
using System.Xml.Linq;
using UP321.Components;

namespace UP321.Pages
{
    /// <summary>
    /// Логика взаимодействия для SubjectListPage.xaml
    /// </summary>
    public partial class SubjectListPage : Page
    {
        public SubjectListPage()
        {
            InitializeComponent();
            Refresh();
        }

        private void DeleteButt_Click(object sender, RoutedEventArgs e)
        {
            var subject = (Subject)SubjectList.SelectedItem;
            subject.IsDeleted = Convert.ToBoolean(1);
            Refresh();
            App.db.SaveChanges();
        }

        public void Refresh()
        {
            IEnumerable<Subject> subsort = App.db.Subject;
            if (SortCB.SelectedIndex == 1) subsort = subsort.OrderBy(x => x.Name_Subject);
            if (SortCB.SelectedIndex == 2) subsort = subsort.OrderByDescending(x => x.Name_Subject);

            if (LecSortCB.SelectedIndex != 0)
            {
                if (LecSortCB.SelectedIndex == 1) subsort = subsort.Where(x => x.Id_Lectern == "вм");
                else if (LecSortCB.SelectedIndex == 2) subsort = subsort.Where(x => x.Id_Lectern == "ис");
                else if (LecSortCB.SelectedIndex == 3) subsort = subsort.Where(x => x.Id_Lectern == "мм");
                else if (LecSortCB.SelectedIndex == 4) subsort = subsort.Where(x => x.Id_Lectern == "оф");
                else if (LecSortCB.SelectedIndex == 5) subsort = subsort.Where(x => x.Id_Lectern == "пи");
                else if (LecSortCB.SelectedIndex == 6) subsort = subsort.Where(x => x.Id_Lectern == "эф");
            }
            if (SearchTbx.Text != null)
            {
                subsort = subsort.Where(x => x.Name_Subject.ToLower().Contains(SearchTbx.Text.ToLower()));
            }

            SubjectList.ItemsSource = subsort.ToList().Where(x => x.IsDeleted != Convert.ToBoolean(1));  
        }

        private void SortCB_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Refresh();
        }

        private void LecSortCB_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Refresh();
        }

        private void SearchTbx_TextChanged(object sender, TextChangedEventArgs e)
        {
            Refresh();
        }

        private void AddButt_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new AddEditSubjectPage(new Subject(), "add"));
        }

        private void RedactButt_Click(object sender, RoutedEventArgs e)
        {
            var subject = (Subject)SubjectList.SelectedItem;
            NavigationService.Navigate(new AddEditSubjectPage(subject, "redact"));
        }
    }
}
