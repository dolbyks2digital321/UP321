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
            StudentsListView.Items.Clear();
            StudentsListView.ItemsSource = App.db.Student.ToList().Where(x => x.IsDeleted != Convert.ToBoolean(1));
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
            StudentsListView.ItemsSource = App.db.Student.ToList().Where(x => x.IsDeleted != Convert.ToBoolean(1));
        }
            
    }
}
