# run by hbase-jruby this_file

include Java
import org.apache.hadoop.hbase.HBaseConfiguration
import org.apache.hadoop.hbase.client.HBaseAdmin
import org.apache.hadoop.hbase.HTableDescriptor
import org.apache.hadoop.hbase.HColumnDescriptor
import org.apache.hadoop.hbase.dot.DotConstants
import org.apache.hadoop.hbase.client.HTable
import org.apache.hadoop.hbase.client.Put
import org.apache.hadoop.hbase.client.Result
import org.apache.hadoop.hbase.client.ResultScanner
import org.apache.hadoop.hbase.client.Scan
import org.apache.hadoop.hbase.filter.ColumnPrefixFilter
import org.apache.hadoop.hbase.util.Bytes

tableName = "test_dot"
conf = HBaseConfiguration.new
admin = HBaseAdmin.new(conf)

table = HTable.new(conf, tableName)

filter = ColumnPrefixFilter.new("d1.f")
scan = Scan.new()
scan.setFilter(filter)
scanner = table.getScanner(scan)
result = scanner.next()
System.out.println(result.list().size())
table.close()

