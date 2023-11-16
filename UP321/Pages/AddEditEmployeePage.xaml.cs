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
    /// Логика взаимодействия для AddEditEmployeePage.xaml
    /// </summary>
    public partial class AddEditEmployeePage : Page
    {
        public Employee employee;
        public AddEditEmployeePage(Employee _employee)
        {
            InitializeComponent();
            employee = _employee;
            this.DataContext = employee;

            if (employee != null && employee.Id_Employee > 0) IdTb.IsReadOnly = true;

            LecternCbx.ItemsSource = App.db.Lectern.ToList();
            LecternCbx.DisplayMemberPath = "Name_Lectern";

            PositionCbx.ItemsSource = App.db.Position.ToList();
            PositionCbx.DisplayMemberPath = "Position_Name";

            ChiefCbx.ItemsSource = App.db.Employee.ToList();
            ChiefCbx.DisplayMemberPath = "Surname";

            if (employee.Id_Employee > 0)
            {
                var bbb = App.db.Lectern.ToList().Where(x => x.Id_Lectern == employee.Id_Lectern).First();
                LecternCbx.SelectedIndex = LecternCbx.Items.IndexOf(bbb);
                var aaa = App.db.Position.ToList().Where(x => x.Id_Position == employee.Id_Position).First();
                PositionCbx.SelectedIndex = PositionCbx.Items.IndexOf(aaa);
                var ccc = App.db.Employee.ToList().Where(x => x.Id_Employee == employee.Id_Employee && x.Id_Employee == x.Chief).First();
                ChiefCbx.SelectedIndex = ChiefCbx.Items.IndexOf(ccc);
            }
        }

        private void SaveButt_Click(object sender, RoutedEventArgs e)
        {
            bool errors = false;
            var selectLectern = LecternCbx.SelectedItem as Lectern;
            var selectPosition = PositionCbx.SelectedItem as Position;
            if (selectLectern == null || selectPosition == null || IdTb.Text == "0" || FioTb.Text == "" || SalaryTb.Text == "")
            {
                errors = true;
                if (FioTb.Text == "кириешки") MessageBox.Show("какие нафиг кириешки?!");
                MessageBox.Show("ХУЙНЯ!!!");
            }
            try
            {
                if (int.Parse(SalaryTb.Text) < 0)
                {
                    errors = true;
                    MessageBox.Show("ХУЕТА!!!");
                }
            }
            catch (Exception ex)
            {
                errors = true;
                MessageBox.Show("Неправиьльный формат хуеты!!");
            }
        }
    }
}
