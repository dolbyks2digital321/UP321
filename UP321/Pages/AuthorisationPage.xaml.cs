using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
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
    /// Interaction logic for AuthorisationPage.xaml
    /// </summary>
    public partial class AuthorisationPage : Page
    {
        public AuthorisationPage()
        {
            InitializeComponent();
            App.Role = "";
            App.User = 0;
        }

        private void EntryButt_Click(object sender, RoutedEventArgs e)
        {
            var studentList = App.db.Student.ToList();
            var teacherList = App.db.Employee.ToList();
            if (LoginTb.Text == "student" && PasswordTb.Password != "")
            {
                var list = studentList.Where(x => x.Id_Student == int.Parse(PasswordTb.Password)).ToList();
                if(list.Count() == 0)
                { MessageBox.Show("Неправильный логин или пароль"); return; }
                if (list.First().Id_Student == int.Parse(PasswordTb.Password))
                {
                    App.Role = "st";
                    App.User = int.Parse(PasswordTb.Password);
                    NavigationService.Navigate(new NavigationPage());
                }
            }
            else if (LoginTb.Text == "teacher" && PasswordTb.Password != "")
            {
                var list = teacherList.Where(x => x.Id_Employee == int.Parse(PasswordTb.Password)).ToList();
                if (list.Count() == 0)
                { MessageBox.Show("Неправильный логин или пароль"); return; }
                if (list.First().Id_Employee == int.Parse(PasswordTb.Password))
                {
                    App.Role = "tch";
                    App.User = int.Parse(PasswordTb.Password);
                    NavigationService.Navigate(new NavigationPage());
                }
            }
            else if (LoginTb.Text == "admin" && PasswordTb.Password != "")
            {
                var list = teacherList.Where(x => x.Chief == x.Id_Employee && x.Id_Employee == int.Parse(PasswordTb.Password)).ToList();
                if (list.Count() == 0)
                { MessageBox.Show("Неправильный логин или пароль"); return; }
                if (list.First().Id_Employee == int.Parse(PasswordTb.Password))
                {
                    App.Role = "adm";
                    App.User = int.Parse(PasswordTb.Password);
                    NavigationService.Navigate(new NavigationPage());
                }
            }
            else MessageBox.Show("Неправильный логин или пароль");
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            // Ссылка на XL таблицу
            string soucer_xl = "https://franx1024.github.io/Windows97/";
            // Создание переменной библиотеки QRCoder
            QRCoder.QRCodeGenerator qr = new QRCoder.QRCodeGenerator();
            // Присваеваем значиения
            QRCoder.QRCodeData data = qr.CreateQrCode(soucer_xl, QRCoder.QRCodeGenerator.ECCLevel.L);
            // переводим в Qr
            QRCoder.QRCode code = new QRCoder.QRCode(data);
            Bitmap bitmap = code.GetGraphic(100);
            /// Создание картинки
            using (MemoryStream memory = new MemoryStream())
            {
                bitmap.Save(memory, System.Drawing.Imaging.ImageFormat.Bmp);
                memory.Position = 0;
                BitmapImage bitmapimage = new BitmapImage();
                bitmapimage.BeginInit();
                bitmapimage.StreamSource = memory;
                bitmapimage.CacheOption = BitmapCacheOption.OnLoad;
                bitmapimage.EndInit();
                imageQr.Source = bitmapimage;
            }
        }
    }
}
