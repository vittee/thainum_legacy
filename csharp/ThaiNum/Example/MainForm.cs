using System;
using System.Diagnostics;
using System.Windows.Forms;

using ThaiNum.Library;

namespace Example
{
    public partial class MainForm : Form
    {
        private ThaiNumConverter thaiNum = new ThaiNumConverter();

        public MainForm()
        {   
            InitializeComponent();
        }

        private void textBoxText_TextChanged(object sender, EventArgs e)
        {
            double d;

            if (Double.TryParse(textBoxText.Text, out d))
            {
                labelText.Text = thaiNum.Text(d);
            }
            else
            {
                labelText.Text = "N/A";
            }
           
        }

        private void textBoxBaht_TextChanged(object sender, EventArgs e)
        {
            double d;

            if (Double.TryParse(textBoxBaht.Text, out d))
            {
                Debug.WriteLine(d);
                labelBahtText.Text = thaiNum.BahtText(d);
            }
            else
            {
                labelBahtText.Text = "N/A";
            }
        }
    }
}
