using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;
using UP321.Components;

namespace UP321
{
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    public partial class App : Application
    {
        public static UP321WPFEntities db = new UP321WPFEntities();
        public static string Role = "";
        public static int User = 0;
    }
}
