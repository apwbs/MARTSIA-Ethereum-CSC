import block_int
from decouple import config
import sqlite3

attribute_certifier_address = config('ATTRIBUTE_CERTIFIER_ADDRESS')
private_key = config('ATTRIBUTE_CERTIFIER_PRIVATEKEY')

attribute_certifier_address2 = config('ATTRIBUTE_CERTIFIER_ADDRESS2')
private_key2 = config('ATTRIBUTE_CERTIFIER_PRIVATEKEY2')

attribute_certifier_address3 = config('ATTRIBUTE_CERTIFIER_ADDRESS3')
private_key3 = config('ATTRIBUTE_CERTIFIER_PRIVATEKEY3')

manufacturer_address = config('DATAOWNER_MANUFACTURER_ADDRESS')
electronics_address = config('READER_ADDRESS_SUPPLIER1')
mechanics_address = config('READER_ADDRESS_SUPPLIER2')

user_address = manufacturer_address

process_instance_id_env = config('PROCESS_INSTANCE_ID')
process_instance_id = int(process_instance_id_env)

# Connection to SQLite3 attribute_certifier database
# conn = sqlite3.connect('files/attribute_certifier/attribute_certifier.db')
# x = conn.cursor()

# Connection to SQLite3 attribute_certifier2 database
conn = sqlite3.connect('files/attribute_certifier2/attribute_certifier2.db')
x = conn.cursor()

# Connection to SQLite3 attribute_certifier3 database
# conn = sqlite3.connect('files/attribute_certifier3/attribute_certifier3.db')
# x = conn.cursor()


def add_user():
    block_int.add_user(attribute_certifier_address2, private_key2, user_address)

    x.execute("INSERT OR IGNORE INTO users VALUES (?,?,?)", (str(process_instance_id), user_address, True))
    conn.commit()


if __name__ == "__main__":
    add_user()
