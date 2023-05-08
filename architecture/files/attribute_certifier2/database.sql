CREATE TABLE user_attributes (
    process_instance TEXT,
    ipfs_file_link_hash TEXT,
    user_attributes_file TEXT,
    primary key (process_instance)
);

CREATE TABLE authorities (
    process_instance TEXT,
    authority_address TEXT,
    authority_status_vote BOOL,
    primary key (process_instance, authority_address)
);
