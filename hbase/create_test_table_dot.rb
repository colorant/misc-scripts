# run by hbase-jruby this_file

include Java
import org.apache.hadoop.hbase.HBaseConfiguration
import org.apache.hadoop.hbase.client.HBaseAdmin
import org.apache.hadoop.hbase.HTableDescriptor
import org.apache.hadoop.hbase.HColumnDescriptor

conf = HBaseConfiguration.new
admin = HBaseAdmin.new(conf)
desc = HTableDescriptor.new("test_dot")
desc.addFamily(cfdesc)
desc.setValue("hbase.dot.enable","true")
desc.setValue("hbase.dot.type","ANALYTICAL")
desc.setValue("hbase.dot.column.schema",
        "cf1:d1:{\"name\": \"d1\", \"type\": \"record\",
            \"fields\":[{\"name\": \"f1\", \"type\": \"bytes\"}, {\"name\":\“f2\",\"type\":\"bytes\"}]
         }"
);

cfdesc = HColumnDescriptor.new("cf1")

admin.createTable(desc)

