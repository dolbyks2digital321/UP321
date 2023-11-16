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
            SubjectList.ItemsSource = App.db.Subject.ToList().Where(x => x.IsDeleted != Convert.ToBoolean(1));
        }
    }
}
