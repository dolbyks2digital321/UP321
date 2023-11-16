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

namespace UP321.Pages
{
    /// <summary>
    /// Interaction logic for NavigationPage.xaml
    /// </summary>
    public partial class NavigationPage : Page
    {
        public NavigationPage()
        {
            InitializeComponent();
            if (App.Role == "st")
            {
                EmpButt.Visibility= Visibility.Collapsed;
                StudButt.Visibility = Visibility.Collapsed;
                DiscButt.Visibility = Visibility.Collapsed;
            }

            if (App.Role == "tch") EmpButt.Visibility= Visibility.Collapsed;
        }

        private void StudButt_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new StudentList());
        }

        private void ExamButt_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new ExamPage());
        }

        private void EmpButt_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new EmployeeListPage());
        }

        private void DiscButt_Click(object sender, RoutedEventArgs e)
        {
            NavigationService.Navigate(new SubjectListPage());
        }
    }
}
