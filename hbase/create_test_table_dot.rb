# run by hbase-jruby this_file

include Java
import org.apache.hadoop.hbase.HBaseConfiguration
import org.apache.hadoop.hbase.client.HBaseAdmin
import org.apache.hadoop.hbase.HTableDescriptor
import org.apache.hadoop.hbase.HColumnDescriptor
import org.apache.hadoop.hbase.dot.DotConstants
import org.apache.hadoop.hbase.client.HTable
import org.apache.hadoop.hbase.client.Put
import org.apache.hadoop.hbase.util.Bytes

tableName = "test_dot"
conf = HBaseConfiguration.new
admin = HBaseAdmin.new(conf)
desc = HTableDescriptor.new(tableName)

cfdesc = HColumnDescriptor.new("cf1")

docName = "d1"

cfdesc.setValue("hbase.dot.columnfamily.doc.element", docName)
doc1 = "hbase.dot.columnfamily.doc.schema." + docName

doc1Schema = " {    \n" +
           " \"name\": \"d1\", \n" +
           " \"type\": \"record\",\n" +
           " \"fields\": [\n" +
           "   {\"name\": \"f1\", \"type\": \"bytes\"},\n" +
           "   {\"name\": \"f2\", \"type\": \"bytes\"} ]\n" +
           "}"
cfdesc.setValue(doc1, doc1Schema)

desc.addFamily(cfdesc)
desc.setValue("hbase.dot.enable","true")
desc.setValue("hbase.dot.type","ANALYTICAL")

admin.createTable(desc)

table = HTable.new(conf, tableName)
put = Put.new(Bytes.toBytes("row1"))

put.add(Bytes.toBytes("cf1"), Bytes.toBytes("d1.f1"), Bytes.toBytes("val1"))
put.add(Bytes.toBytes("cf1"), Bytes.toBytes("d1.f2"), Bytes.toBytes("val2"))

table.put(put)
table.close()

