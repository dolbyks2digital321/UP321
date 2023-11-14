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
    /// Interaction logic for ExamPage.xaml
    /// </summary>
    public partial class ExamPage : Page
    {
        public ExamPage()
        {
            InitializeComponent();
            ExamList.ItemsSource = App.db.Exam.ToList();
            if (App.Role == "st")
            {
                AddButt.Visibility = Visibility.Collapsed;
                DeleteButt.Visibility = Visibility.Collapsed;
                RedactButt.Visibility = Visibility.Collapsed;
            }
        }
    }
}
