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
    /// Interaction logic for EmployeeListPage.xaml
    /// </summary>
    public partial class EmployeeListPage : Page
    {
        public EmployeeListPage()
        {
            InitializeComponent(); Refresh();
        }
        private void DeleteButt_Click(object sender, RoutedEventArgs e)
        {
            var emp = (Employee)EmpListView.SelectedItem; emp.IsDeleted = Convert.ToBoolean(1);
            Refresh(); 
            App.db.SaveChanges();
        }
        public void Refresh()
        {
            IEnumerable<Employee> empsort = App.db.Employee;

            if (SortCB.SelectedIndex == 1) empsort = empsort.OrderBy(x => x.Lectern.Name_Lectern);
            if (SortCB.SelectedIndex == 2) empsort = empsort.OrderBy(x => x.Surname);
            if (SortCB.SelectedIndex == 3) empsort = empsort.OrderBy(x => x.Salary);
            if (SortCB.SelectedIndex == 4) empsort = empsort.OrderBy(x => x.Stage);

            if (OrderSortCB.SelectedIndex != 0)
            {
                if (OrderSortCB.SelectedIndex == 1) empsort = empsort.Where(x => x.Employee2.Surname == x.Surname);
                if (OrderSortCB.SelectedIndex == 2) empsort = empsort.Where(x => x.Employee2.Surname != x.Surname);
            }
            if (SearchTbx.Text != null)
            {
                empsort = empsort.Where(x => x.Surname.ToLower().Contains(SearchTbx.Text.ToLower()));
            }

            EmpListView.ItemsSource = empsort.ToList().Where(x => x.IsDeleted != Convert.ToBoolean(1));
        }
        private void AddButt_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new AddEditEmployeePage(new Employee(), "add"));
        }
        private void RedactButt_Click(object sender, RoutedEventArgs e)
        {
            var emp = (Employee)EmpListView.SelectedItem; if (emp == null) MessageBox.Show("Для редактирования выберите данные!");
            else NavigationService.Navigate(new AddEditEmployeePage(emp, "redact"));
        }

        private void SortCB_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Refresh();
        }

        private void OrderSortCB_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            Refresh();
        }

        private void SearchTbx_TextChanged(object sender, TextChangedEventArgs e)
        {
            Refresh();
        }
    }
}
