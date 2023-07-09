using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PRG_II_Asg
{
    class Cinema
    {
        public string  Name { get; set; }
        public int HallNo { get; set; }
        public int Capacity { get; set; }
        public Cinema() { }
        public Cinema(string n, int hn, int c)
        {
            Name = n;
            HallNo = hn;
            Capacity = c;
        }
        public override string ToString()
        {
            return "Name: " + Name + "\tHallNo: " + HallNo + "\tCapacity: " + Capacity;
        }
    }
}
