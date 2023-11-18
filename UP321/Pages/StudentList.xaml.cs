using System;
using System.Collections.Generic;
using System.ComponentModel;
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
    /// Interaction logic for StudentList.xaml
    /// </summary>
    public partial class StudentList : Page
    {
        public StudentList()
        {
            InitializeComponent();
            Refresh();
        }

        private void DeleteButt_Click(object sender, RoutedEventArgs e)
        {
            var student = (Student)StudentsListView.SelectedItem;
            student.IsDeleted = Convert.ToBoolean(1);
            Refresh();
            App.db.SaveChanges();
        }

        public void Refresh()
        {
            IEnumerable<Student> studlist = App.db.Student;

            if (SortCB.SelectedIndex == 1) studlist = studlist.OrderBy(x => x.Surname_Student);
            if (SortCB.SelectedIndex == 2) studlist = studlist.OrderByDescending(x => x.Surname_Student);

            if (SpecSortCB.SelectedIndex != 0)
            {
                if (SpecSortCB.SelectedIndex == 1) studlist = studlist.Where(x => x.Specs.Direction == "Прикладная математика");
                else if (SpecSortCB.SelectedIndex == 2) studlist = studlist.Where(x => x.Specs.Direction == "Информационные системы и технологии");
                else if (SpecSortCB.SelectedIndex == 3) studlist = studlist.Where(x => x.Specs.Direction == "Прикладная информатика");
                else if (SpecSortCB.SelectedIndex == 4) studlist = studlist.Where(x => x.Specs.Direction == "Ядерные физика и технологии");
                else if (SpecSortCB.SelectedIndex == 5) studlist = studlist.Where(x => x.Specs.Direction == "Бизнес-информатика");
            }
            if (SearchTbx.Text != null)
            {
                studlist = studlist.Where(x => x.Surname_Student.ToLower().Contains(SearchTbx.Text.ToLower()) || x.Specs.Direction.ToLower().Contains(SearchTbx.Text.ToLower()));
            }

            StudentsListView.ItemsSource = studlist.ToList().Where(x => x.IsDeleted != Convert.ToBoolean(1));
        }

        private void SortCB_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Refresh();
        }

        private void SpecSortCB_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Refresh();
        }

        private void SearchTbx_TextChanged(object sender, TextChangedEventArgs e)
        {
            Refresh();
        }

        private void AddButt_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new AddEditPageStudent(new Student(), "add"));
        }

        private void RedactButt_Click(object sender, RoutedEventArgs e)
        {
            var student = (Student)StudentsListView.SelectedItem;
            NavigationService.Navigate(new AddEditPageStudent(student, "redact"));
        }
    }
}
