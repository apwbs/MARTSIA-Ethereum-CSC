import block_int
from decouple import config
import sqlite3

attribute_certifier_address = config('ATTRIBUTE_CERTIFIER_ADDRESS')
private_key = config('ATTRIBUTE_CERTIFIER_PRIVATEKEY')

attribute_certifier_address2 = config('ATTRIBUTE_CERTIFIER_ADDRESS2')
private_key2 = config('ATTRIBUTE_CERTIFIER_PRIVATEKEY2')

attribute_certifier_address3 = config('ATTRIBUTE_CERTIFIER_ADDRESS3')
private_key3 = config('ATTRIBUTE_CERTIFIER_PRIVATEKEY3')

authority1_address = config('AUTHORITY1_ADDRESS')
authority2_address = config('AUTHORITY2_ADDRESS')
authority3_address = config('AUTHORITY3_ADDRESS')
authority4_address = config('AUTHORITY4_ADDRESS')

authority_address = authority1_address

process_instance_id_env = config('PROCESS_INSTANCE_ID')
process_instance_id = int(process_instance_id_env)

# Connection to SQLite3 attribute_certifier database
conn = sqlite3.connect('files/attribute_certifier/attribute_certifier.db')
x = conn.cursor()

# Connection to SQLite3 attribute_certifier2 database
# conn = sqlite3.connect('files/attribute_certifier2/attribute_certifier2.db')
# x = conn.cursor()

# Connection to SQLite3 attribute_certifier3 database
# conn = sqlite3.connect('files/attribute_certifier3/attribute_certifier3.db')
# x = conn.cursor()


def add_authority():
    block_int.add_authority(attribute_certifier_address2, private_key2, authority_address)

    x.execute("INSERT OR IGNORE INTO authorities VALUES (?,?,?)", (str(process_instance_id), authority_address, True))
    conn.commit()


if __name__ == "__main__":
    add_authority()
