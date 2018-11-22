import java.sql.*;
import java.util.Scanner;
import java.io.FileNotFoundException;
import java.io.File;
import java.util.Random;

public class JDBC {
    public static void main(String args[]) throws FileNotFoundException{
        try{
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection conn = DriverManager.getConnection("jdbc:oracle:thin:@acadoradbprd01.dpu.depaul.edu:1521:ACADPRD0", "<USERNAME>", "<PW>");
            Statement state = conn.createStatement();

            String dropTable = "DROP TABLE part";

            String createTable = "create table part ( p_partkey     integer     not null, p_name        varchar(22) not null, p_mfgr        varchar(6)     not null, p_category    varchar(7)     not null, p_brand1      varchar(9)     not null, p_color       varchar(11) not null, p_type        varchar(25) not null, p_size        integer     not null, p_container   varchar(10)    not null )";

            try{
                state.executeUpdate(dropTable);
                System.out.println("Table dropped!");
            }
            catch(Exception e){
                System.out.println("Drop table failed: \n" + e);
            }

            try{
                state.executeUpdate(createTable);
                System.out.println("Table created!");
            }
            catch(Exception e){
                System.out.println("Create Table failed: \n" + e);
            }

            String alter = "alter table part" +
                    "  add primary key (p_partkey)";
            state.executeUpdate(alter);

            String ins = "INSERT INTO part VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement insPart = conn.prepareStatement(ins);

            int i = 0, p_partk, p_size, randomInt;
            String p_name, p_mfgr, p_category, p_brand1, p_color, p_type, p_container;
            Random rand = new Random();

            String fileName = "part.tbl";
            @SuppressWarnings("resource")
            Scanner read = new Scanner(new File(fileName));
            int k = 0, iter = 0;
            int[] ids = new int[20];


            while(i < 20 && read.hasNext()){
                String line = read.nextLine();
                rand = new Random();
                randomInt = rand.nextInt(9999) + 1;
                // inserts 20 random items in table
                if(randomInt % 2 == 0) {
                    String[] lineArr = new String[]{"", "", "", "", "", "", "", "", ""};
                    for (int j = 0; j < line.length(); j++) {
                        if (line.charAt(j) == '|') {
                            k++;
                        } else {
                            lineArr[k] += line.charAt(j);
                        }
                    }
                    p_partk = Integer.parseInt(lineArr[0]);
                    ids[iter] = p_partk;
                    iter++;
                    p_name = lineArr[1];
                    p_mfgr = lineArr[2];
                    p_category = lineArr[3];
                    p_brand1 = lineArr[4];
                    p_color = lineArr[5];
                    p_type = lineArr[6];
                    p_size = Integer.parseInt(lineArr[7]);
                    p_container = lineArr[8];

                    insPart.setInt(1, p_partk);
                    insPart.setString(2, p_name);
                    insPart.setString(3, p_mfgr);
                    insPart.setString(4, p_category);
                    insPart.setString(5, p_brand1);
                    insPart.setString(6, p_color);
                    insPart.setString(7, p_type);
                    insPart.setInt(8, p_size);
                    insPart.setString(9, p_container);
                    insPart.executeUpdate();
                    k = 0;
                    i++;
                }
            }

            // drop the ids from table
            for(int j = 0; j < ids.length; j++){
                String del = "DELETE FROM part WHERE p_partkey = '";
                del += ids[j] +"'";
                state.executeUpdate(del);
            }

            ResultSet result = state.executeQuery("SELECT * FROM part");

            // User Input
            System.out.println("Enter p_partkey: ");
            @SuppressWarnings("resource")
            Scanner ppk = new Scanner(System.in);
            p_partk = ppk.nextInt();

            System.out.println("Enter part name: ");
            @SuppressWarnings("resource")
            Scanner pn = new Scanner(System.in);
            p_name = pn.next();

            System.out.println("Enter p_mfgr: ");
            @SuppressWarnings("resource")
            Scanner pm = new Scanner(System.in);
            p_mfgr = pm.next();

            System.out.println("Enter part category: ");
            @SuppressWarnings("resource")
            Scanner pcat = new Scanner(System.in);
            p_category = pcat.next();

            System.out.println("Enter part brand: ");
            @SuppressWarnings("resource")
            Scanner pb = new Scanner(System.in);
            p_brand1 = pb.next();

            System.out.println("Enter part color: ");
            @SuppressWarnings("resource")
            Scanner pcol = new Scanner(System.in);
            p_color = pcol.next();

            System.out.println("Enter part type: ");
            @SuppressWarnings("resource")
            Scanner pt = new Scanner(System.in);
            p_type = pt.next();

            System.out.println("Enter part size: ");
            @SuppressWarnings("resource")
            Scanner ps = new Scanner(System.in);
            p_size = ps.nextInt();

            System.out.println("Enter part container: ");
            @SuppressWarnings("resource")
            Scanner pcon = new Scanner(System.in);
            p_container = pcon.next();

            insPart.setInt(1, p_partk);
            insPart.setString(2, p_name);
            insPart.setString(3, p_mfgr);
            insPart.setString(4, p_category);
            insPart.setString(5, p_brand1);
            insPart.setString(6, p_color);
            insPart.setString(7, p_type);
            insPart.setInt(8, p_size);
            insPart.setString(9, p_container);
            insPart.executeUpdate();


            while(result.next()){
                System.out.println(result.getInt(1) + " " + result.getString(2) + " " + result.getString(3) + " " + result.getString(4) + " " + result.getString(5) + " " + result.getString(6) + " " + result.getString(7) + " " + result.getInt(8) + " " + result.getString(9) + " " );
            }

            conn.close();
        }
        catch(Exception e){
            System.out.println(e);
        }

    }
}
