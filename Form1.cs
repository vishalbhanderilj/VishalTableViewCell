using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySql.Data.MySqlClient;

namespace VishalFly
{
    public partial class Form1 : Form
    {
        //string cs1 = @"server=127.0.0.1;port=3306;database=vishal;user id=root;password=D2z1D04**;";
        public MySqlConnection conn = new MySqlConnection(@"server=127.0.0.1;port=3306;database=vishal;user id=root;password=D2z1D04**;");
       // public MySqlConnection conn = new MySqlConnection(cs1);
        MySqlCommand cmd;
        MySqlDataAdapter adapt;
        public int Id = 0;
        string gender1 = "";
        string gender4 = "";
        public Form1()
        {
            InitializeComponent();
            display_data();
            comboBox1.Text="--Select--";
        }
        //function for insert data into table
        private void insert_Data()
        {
            //string bg = ""; 
            ///bg = comboBox1.SelectedValue.ToString();
            try
            {

                

                string Insert_Query = "insert into vishaldata(Firstname,Middlename,Lastname,Gender,Dateofbirth,Address,Bloodgroup) values (@firstname,@middlename,@lastname,@gender,@dateofbirth,@address,@bloodgroup)";
                cmd = new MySqlCommand(Insert_Query, conn);
                conn.Open();
                cmd.Parameters.AddWithValue("@firstname", txt_Firstname.Text);
                cmd.Parameters.AddWithValue("@middlename", txt_Middlename.Text);
                cmd.Parameters.AddWithValue("@lastname", txt_Lastname.Text);
                cmd.Parameters.AddWithValue("@gender", gender1);
                cmd.Parameters.AddWithValue("@dateofbirth", dateTimePicker1.Value.Date);
                cmd.Parameters.AddWithValue("@address", txtrich_Address.Text);
                cmd.Parameters.AddWithValue("@bloodgroup", comboBox1.Text);
                cmd.ExecuteNonQuery();
                conn.Close();
                MessageBox.Show("Insert Record Successfully");
                ClearData();
                display_data();
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

        }
        private void ClearData()
        {
            txt_Firstname.Text = "";
            txt_Middlename.Text = "";
            txt_Lastname.Text = "";
            gender1 = "";
            radio_Male.Checked = false;
            radio_Female.Checked = false;
            dateTimePicker1.Value = DateTime.Today;
            txtrich_Address.Text = "";
            comboBox1.Text = "--Select--";
        }

        private void validate()
        {
            if(txt_Firstname.Text != "") {
                if(txt_Middlename.Text != ""){
                    if(txt_Lastname.Text != ""){
                        if(radio_Male.Checked == true || radio_Female.Checked == true){
                            if (txt_Middlename.Text != ""){
                                if(comboBox1.SelectedValue != ""){
                                    insert_Data();
                                }
                                else
                                {
                                    MessageBox.Show("Please Select Your Blood Group");
                                }
                            }
                            else
                            {
                                MessageBox.Show("Please Enter Your Address");
                            }
                        }
                        else
                        {
                            MessageBox.Show("Please Select Your Gender");
                        }
                    }
                    else
                    {
                        MessageBox.Show("Please Enter Your Last Name");
                    }
                }
                else
                {
                    MessageBox.Show("Please Enter Your Middle Name");
                }
            }
            else
            {
                MessageBox.Show("Please Enter Your First Name");
            }


        }
        private void display_data()
        {
            conn.Open();
            DataTable dt = new DataTable();
            string Select_Query = "select * from vishaldata";
            adapt = new MySqlDataAdapter(Select_Query, conn);
            adapt.Fill(dt);
            dataGridView1.DataSource = dt;
            conn.Close();

            
        }
        private void update_data1()
        {
            
            if(txt_Firstname.Text != "" && txt_Middlename.Text != "" && txt_Lastname.Text != "")
            {
                string Update_Query1 = ("update vishaldata set Firstname=@firstname,Middlename=@middlename,Lastname=@lastname,Gender=@gender,Dateofbirth=@dateodbirth,Address=@address,Bloodgroup=@bloodgroup where Id=@id");

                cmd = new MySqlCommand(Update_Query1, conn);
                conn.Open();
                cmd.Parameters.AddWithValue("@id", Id);
                cmd.Parameters.AddWithValue("@firstname", txt_Firstname.Text);
                cmd.Parameters.AddWithValue("@middlename", txt_Middlename.Text);
                cmd.Parameters.AddWithValue("@lastname", txt_Lastname.Text);
                cmd.Parameters.AddWithValue("@gender", gender4);
                cmd.Parameters.AddWithValue("@dateofbirth", dateTimePicker1.Value.Date);
                //cmd.Parameters.AddWithValue("")
                cmd.Parameters.AddWithValue("@address", txtrich_Address.Text);
                cmd.Parameters.AddWithValue("@bloodgroup", comboBox1.Text);
                cmd.ExecuteNonQuery();
                MessageBox.Show("Record Updated Successfully");
                conn.Close();
                display_data();
                ClearData();       
                


            }
            else
            {
                MessageBox.Show("Provide valid data");
            }
        }

        private void update_data()
        {
            
            try
            {
                if (txt_Firstname.Text != "" && txt_Middlename.Text != "" && txt_Lastname.Text != "" && (radio_Male.Checked == true || radio_Female.Checked == true) && txtrich_Address.Text != "" /*&& comboBox1.Text != "--Select--"*/)
                {
                    //string Update_Query = ("update vishaldata set Firstname=@firstname,Middlename=@middlename,Lastname=@lastname,Gender=@gender,Dateofbirth=@dateofbirth,Address=@adress,Bloodgroup=@bloodgroup where Id=@id");
                    cmd = new MySqlCommand("update vishaldata set Firstname=@firstname,Middlename=@middlename,Lastname=@lastname,Gender=@gender,Dateofbirth=@dateofbirth,Address=@adress,Bloodgroup=@bloodgroup where Id=@id", conn);
                    conn.Open();
                    cmd.Parameters.AddWithValue("@id", Id);
                    cmd.Parameters.AddWithValue("@firstname", txt_Firstname.Text);
                    cmd.Parameters.AddWithValue("@middlename", txt_Middlename.Text);
                    cmd.Parameters.AddWithValue("@lastname", txt_Lastname.Text);
                    cmd.Parameters.AddWithValue("@gender", gender4);
                    cmd.Parameters.AddWithValue("@dateofbirth", dateTimePicker1.Value.Date);
                    cmd.Parameters.AddWithValue("@address", txtrich_Address.Text);
                    cmd.Parameters.AddWithValue("@bloodgroup", comboBox1.Text);
                    cmd.ExecuteNonQuery();
                    conn.Close();
                    MessageBox.Show("Update Record Successfully");
                    ClearData();
                    display_data();


                }
                else
                {
                    MessageBox.Show("Please Inser All Record");
                }

            }
            catch(MySqlException ex)
            {
                MessageBox.Show(ex.Message);
            }
            

        }
        private void delete_data()
        {
            try
            {
                if (Id != 0)
                {
                    string Delete_Query = ("delete from vishaldata where Id=@id");
                    cmd = new MySqlCommand(Delete_Query, conn);
                    conn.Open();
                    cmd.Parameters.AddWithValue("@id", Id);
                    cmd.ExecuteNonQuery();
                    conn.Close();
                    MessageBox.Show("Delete Record Successfully");
                    display_data();
                    ClearData();
                }
            }
            catch(Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

        }
        private void btn_Insert_Click(object sender, EventArgs e)
        {
            if(radio_Male.Checked == true)
            {
                gender1 = radio_Male.Text;
            }
            else
            {
                gender1 = radio_Female.Text;
            }
            validate();
        }

        private void dataGridView1_RowHeaderMouseClick(object sender, DataGridViewCellMouseEventArgs e)
        {
            string gender2 = "";
            string dob = "";
            Id = Convert.ToInt32(dataGridView1.Rows[e.RowIndex].Cells[0].Value.ToString());
            txt_Firstname.Text = dataGridView1.Rows[e.RowIndex].Cells[1].Value.ToString();
            txt_Middlename.Text = dataGridView1.Rows[e.RowIndex].Cells[2].Value.ToString();
            txt_Lastname.Text = dataGridView1.Rows[e.RowIndex].Cells[3].Value.ToString();
            gender2 = dataGridView1.Rows[e.RowIndex].Cells[4].Value.ToString();
            if (gender2 == "Male" || gender2 == "male")
            {
                radio_Male.Checked = true;
            }
            else
            {
                radio_Female.Checked = true;
            }
            dob = dataGridView1.Rows[e.RowIndex].Cells[5].Value.ToString();
            dateTimePicker1.Value = DateTime.Parse(dob);
            //DateTime time = DateTime.Parse(dob);
            txtrich_Address.Text = dataGridView1.Rows[e.RowIndex].Cells[6].Value.ToString();
            comboBox1.Text = dataGridView1.Rows[e.RowIndex].Cells[7].Value.ToString();
        }

        private void btn_Update_Click(object sender, EventArgs e)
        {
            //string gender4 = "";
            if (radio_Male.Checked == true)
            {
                gender4 = radio_Male.Text;
            }
            else
            {
                gender4 = radio_Female.Text;
            }
            update_data();
        }

        private void btn_Delete_Click(object sender, EventArgs e)
        {
            
            
           delete_data();  
            
            
        }
    }
}
