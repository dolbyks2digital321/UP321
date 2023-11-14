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
    /// Interaction logic for AuthorisationPage.xaml
    /// </summary>
    public partial class AuthorisationPage : Page
    {
        public AuthorisationPage()
        {
            InitializeComponent();
        }

        private void EntryButt_Click(object sender, RoutedEventArgs e)
        {
            if (PasswordTb.Password == "111")
            {
                App.Role = "st";
                NavigationService.Navigate(new NavigationPage());
            }
            else if (PasswordTb.Password == "222")
            {
                App.Role = "tch";
                NavigationService.Navigate(new NavigationPage());
            }

        }
    }
}
