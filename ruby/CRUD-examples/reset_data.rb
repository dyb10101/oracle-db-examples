# code Sample from the tutorial at https://learncodeshare.net/2016/08/26/basic-crud-operations-using-ruby-oci8/
# The following resets the data to the initial state for the tutorial.

# Query all rows
require 'oci8'
connectString = ENV['DB_CONNECT'] # The environment variable for the connect string: DB_CONNECT=user/password@database
printf connectString
con = OCI8.new(connectString)

# Delete rows
cursor = con.parse("delete from lcs_pets")
cursor.exec

# Reset Identity Coulmn
cursor = con.parse("alter table lcs_pets modify id generated BY DEFAULT as identity (START WITH 3)")
cursor.exec

# Delete rows
cursor = con.parse("delete from lcs_people")
cursor.exec

# Reset Identity Coulmn
cursor = con.parse("alter table lcs_people modify id generated BY DEFAULT as identity (START WITH 3)")
cursor.exec

# Insert default people rows
cursor = con.parse("INSERT INTO lcs_people(id, name, age, notes) VALUES (:id, :name, :age, :notes)")
cursor.max_array_size = 2
cursor.bind_param_array(:id, [1, 2])
cursor.bind_param_array(:name, ["Bob", "Kim"])
cursor.bind_param_array(:age, [35, 27])
cursor.bind_param_array(:notes, ["I like dogs", "I like birds"])
people_row_count = cursor.exec_array
printf " %d people rows inserted\n", people_row_count

# Insert default pet rows
cursor = con.parse("INSERT INTO lcs_pets(id, name, owner, type) VALUES (:id, :name, :owner, :type)")
cursor.max_array_size = 2
cursor.bind_param_array(:id, [1, 2])
cursor.bind_param_array(:name, ["Duke", "Pepe"])
cursor.bind_param_array(:owner, [1, 2])
cursor.bind_param_array(:type, ["dog", "bird"])
pet_row_count = cursor.exec_array
printf " %d pet rows inserted\n", pet_row_count

con.commit
