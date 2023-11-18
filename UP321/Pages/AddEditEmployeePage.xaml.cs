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
        public Employee employee; public string WhatToDo;
        public AddEditEmployeePage(Employee _employee, string _WhatToDo)
        {
            WhatToDo = _WhatToDo; InitializeComponent();
            employee = _employee; this.DataContext = employee;
            int OriginalID = employee.Id_Employee; IdTb.MaxLength = 3;
            if (employee != null && employee.Id_Employee > 0) IdTb.IsReadOnly = true;
            LecternCbx.ItemsSource = App.db.Lectern.ToList();
            LecternCbx.DisplayMemberPath = "Name_Lectern";
            PositionCbx.ItemsSource = App.db.Position.ToList(); PositionCbx.DisplayMemberPath = "Position_Name";
            ChiefCbx.ItemsSource = App.db.Employee.ToList().Where(x => x.Id_Employee == x.Chief);
            ChiefCbx.DisplayMemberPath = "Surname";
            DegreeCbx.ItemsSource = App.db.Degree.ToList(); DegreeCbx.DisplayMemberPath = "Degree1";
            if (employee.Id_Employee > 0)
            {
                var bbb = App.db.Lectern.ToList().Where(x => x.Id_Lectern == employee.Id_Lectern).First();
                LecternCbx.SelectedIndex = LecternCbx.Items.IndexOf(bbb); var aaa = App.db.Position.ToList().Where(x => x.Id_Position == employee.Id_Position).First();
                PositionCbx.SelectedIndex = PositionCbx.Items.IndexOf(aaa); var ccc = App.db.Employee.ToList().Where(x => x.Chief == employee.Chief).First();
                ChiefCbx.SelectedIndex = ChiefCbx.Items.IndexOf(ccc); if (employee.Id_degree != null)
                {
                    var ddd = App.db.Degree.ToList().Where(x => x.Id_degree == employee.Id_degree).First();
                    DegreeCbx.SelectedIndex = DegreeCbx.Items.IndexOf(ddd);
                }
            }
        }
        private void SaveButt_Click(object sender, RoutedEventArgs e)
        {
            bool errors = false; var selectLectern = LecternCbx.SelectedItem as Lectern;
            var selectPosition = PositionCbx.SelectedItem as Position; var selectChief = ChiefCbx.SelectedItem as Employee;
            var selectDegree = DegreeCbx.SelectedItem as Degree; if (selectLectern == null || selectPosition == null || IdTb.Text == "0" || FioTb.Text == "" || SalaryTb.Text == "" || selectChief == null)
            {
                errors = true; if (FioTb.Text == "кириешки") MessageBox.Show("какие нафиг кириешки?!");
                MessageBox.Show("Заполните обязательные данные!");
            }
            if (IdTb.Text.Length < 3)
            {
                errors = true;
                MessageBox.Show("Длина таб.номера должна быть 3 символа!");
            }
            if (App.db.Employee.Any(x => x.Id_Employee == employee.Id_Employee) && WhatToDo == "add")
            {
                errors = true;
                MessageBox.Show("Такой таб.номер уже есть!");
            }
            if (!errors)
            {
                if (WhatToDo == "add")
                {
                    if (employee.Stage != null)
                    {
                        App.db.Employee.Add(new Employee()
                        {
                            Stage = int.Parse(StageTb.Text),
                        });
                    }
                    if (selectDegree != null)
                    {
                        App.db.Employee.Add(new Employee()
                        {
                            Id_degree = selectDegree.Id_degree
                        });
                    }
                    App.db.Employee.Add(new Employee()
                    {
                        Id_Employee = employee.Id_Employee,
                        Id_Lectern = selectLectern.Id_Lectern,
                        Surname = FioTb.Text,
                        Id_Position = selectPosition.Id_Position,
                        Salary = decimal.Parse(SalaryTb.Text),
                        Chief = selectChief.Id_Employee,
                        IsDeleted = Convert.ToBoolean(0)
                    });
                }
                if (selectDegree != null) employee.Id_degree = selectDegree.Id_degree;
                employee.Id_Lectern = selectLectern.Id_Lectern;
                employee.Id_Position = selectPosition.Id_Position;
                employee.Chief = selectChief.Id_Employee;
                MessageBox.Show("Сохранено!");
                App.db.SaveChanges();
                NavigationService.Navigate(new EmployeeListPage());
            }
        }
        private void SalaryTb_PreviewTextInput(object sender, TextCompositionEventArgs e)
        {
            if (!char.IsDigit(e.Text, 0))
            {
                e.Handled = true;
            }
        }
    }
}

