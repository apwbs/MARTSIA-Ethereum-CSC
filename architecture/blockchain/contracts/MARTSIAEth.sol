// SPDX-License-Identifier: CC-BY-SA-4.0
pragma solidity >=0.5.0 <0.9.0;

contract MARTSIAEth {
    uint256 public AUTH = 0;
    uint256 public AUTHDESTRUCTION = 0;
    address payable public address_to_pay;
    address[3] public attributeCertifiers = [
        0x612aA51D11ad3a1318d3298F49F655818Ca4D173,
        0x768E74a09b2e20Fb617e7aa60c8B1578Ece388ad,
        0xf603Bb80Bc03dA039FCD7c8f6A34105f36E51592
    ];
    mapping(address => bool) public attributeCertifiersAppr;
    mapping(address => bool) public attributeCertifiersDest;

    struct authorityList {
        bool certifier_check_vote;
    }
    mapping(address => mapping(address => authorityList)) authoritiesAddresses;

    struct authorityCertifiedList {
        uint64 number_of_certifications;
        bool value;
    }
    mapping(address => authorityCertifiedList) authoritiesCertified;

    function addAuthority(address authority) public Majority {
        for (uint256 j = 0; j < attributeCertifiers.length; j++) {
            if (msg.sender == attributeCertifiers[j] && authoritiesAddresses[authority][msg.sender].certifier_check_vote == false) {
                authoritiesAddresses[authority][msg.sender].certifier_check_vote = true;
                authoritiesCertified[authority].number_of_certifications += 1;
            }
        }
        if (authoritiesCertified[authority].number_of_certifications > 1) {
            authoritiesCertified[authority].value = true;
        } else {
            authoritiesCertified[authority].value = false;
        }
    }

    struct authorityListR {
        bool certifier_check_vote;
    }
    mapping(address => mapping(address => authorityList)) authoritiesAddressesR;

    struct authorityCertifiedListR {
        uint64 number_of_certifications;
        bool value;
    }
    mapping(address => authorityCertifiedList) authoritiesCertifiedR;

    function removeAuthority(address authority) public Majority {
        for (uint256 j = 0; j < attributeCertifiers.length; j++) {
            if (msg.sender == attributeCertifiers[j] && authoritiesAddressesR[authority][msg.sender].certifier_check_vote == false) {
                authoritiesAddressesR[authority][msg.sender].certifier_check_vote = true;
                authoritiesCertifiedR[authority].number_of_certifications -= 1;
            }
        }
        if (authoritiesCertifiedR[authority].number_of_certifications < 2) {
            authoritiesCertifiedR[authority].value = false;
        } else {
            authoritiesCertifiedR[authority].value = true;
        }
    }

    function getAuthority(address _address) public view returns (bool) {
        return authoritiesCertified[_address].value;
    }
 
    modifier Authority(address authority) {
        require(
            authoritiesCertified[authority].value == true,
            "Not (at least for now or not anymore) an authority! You shall not pass!"
        );
        _;
    }

    struct UsersList {
        bool certifier_check_vote;
    }
    mapping(address => mapping(address => UsersList)) usersAddresses;

    struct userCertifiedList {
        uint64 number_of_certifications;
        bool value;
    }
    mapping(address => userCertifiedList) usersCertified;

    function addUser(address user) public Majority {
        for (uint256 j = 0; j < attributeCertifiers.length; j++) {
            if (msg.sender == attributeCertifiers[j] && usersAddresses[user][msg.sender].certifier_check_vote == false) {
                usersAddresses[user][msg.sender].certifier_check_vote = true;
                usersCertified[user].number_of_certifications += 1;
            }
        }
        if (usersCertified[user].number_of_certifications > 1) {
            usersCertified[user].value = true;
        } else {
            usersCertified[user].value = false;
        }
    }

    struct UsersListR {
        bool certifier_check_vote;
    }
    mapping(address => mapping(address => UsersListR)) usersAddressesR;

    struct userCertifiedListR {
        uint64 number_of_certifications;
        bool value;
    }
    mapping(address => userCertifiedListR) usersCertifiedR;

    function removeUser(address user) public Majority {
        for (uint256 j = 0; j < attributeCertifiers.length; j++) {
            if (msg.sender == attributeCertifiers[j] && usersAddressesR[user][msg.sender].certifier_check_vote == false) {
                usersAddressesR[user][msg.sender].certifier_check_vote = true;
                usersCertifiedR[user].number_of_certifications -= 1;
            }
        }
        if (usersCertifiedR[user].number_of_certifications < 2) {
            usersCertifiedR[user].value = false;
        } else {
            usersCertifiedR[user].value = true;
        }
    }

    function getUser(address user) public view returns (bool) {
        return usersCertified[user].value;
    }
 
    modifier User(address user) {
        require(
            usersCertified[user].value == true,
            "Not (at least for now or not anymore) a user! You shall not pass!"
        );
        _;
    }

    constructor() payable {
        address_to_pay = payable(msg.sender);
    }

    function updateMajorityCount() public {
        for (uint256 j = 0; j < attributeCertifiers.length; j++) {
            if (msg.sender == attributeCertifiers[j]) {
                if (attributeCertifiersAppr[msg.sender] != true) {
                    AUTH = AUTH + 1;
                    attributeCertifiersAppr[msg.sender] = true;
                }   
            }
        }
    }

    modifier Majority() {
        require(
            AUTH > ((uint256(attributeCertifiers.length) * 2) / 3),
            "No action possible without the majority"
        );
        _;
    }

    struct authoritiesNames {
        bytes32 hashPart1;
        bytes32 hashPart2;
    }
    mapping(uint64 => mapping(address => authoritiesNames)) authoritiesName;

    struct firstElementHashed {
        bytes32 hashPart1;
        bytes32 hashPart2;
    }
    mapping(uint64 => mapping(address => firstElementHashed)) firstGHashed;

    struct secondElementHashed {
        bytes32 hashPart1;
        bytes32 hashPart2;
    }
    mapping(uint64 => mapping(address => secondElementHashed)) secondGHashed;

    struct firstElement {
        bytes32 hashPart1;
        bytes32 hashPart2;
        bytes32 hashPart3;
    }
    mapping(uint64 => mapping(address => firstElement)) firstG;

    struct secondElement {
        bytes32 hashPart1;
        bytes32 hashPart2;
        bytes32 hashPart3;
    }
    mapping(uint64 => mapping(address => secondElement)) secondG;

    struct publicParameters {
        bytes32 hashPart1;
        bytes32 hashPart2;
    }
    mapping(uint64 => mapping(address => publicParameters)) parameters;

    struct publicKey {
        bytes32 hashPart1;
        bytes32 hashPart2;
    }
    mapping(uint64 => mapping(address => publicKey)) publicKeys;

    struct publicKeyReaders {
        bytes32 hashPart1;
        bytes32 hashPart2;
    }
    mapping(address => publicKeyReaders) publicKeysReaders;

    struct IPFSCiphertext {
        address sender;
        bytes32 hashPart1;
        bytes32 hashPart2;
    }
    mapping(uint64 => IPFSCiphertext) allLinks;

    struct userAttributes {
        bytes32 hashPart1;
        bytes32 hashPart2;
    }
    mapping(uint64 => userAttributes) allUsers;

    function setAuthoritiesNames(uint64 _instanceID, bytes32 _hash1, bytes32 _hash2) public Majority Authority(msg.sender) {
        authoritiesName[_instanceID][msg.sender].hashPart1 = _hash1;
        authoritiesName[_instanceID][msg.sender].hashPart2 = _hash2;
    }

    function getAuthoritiesNames(address _address, uint64 _instanceID) public view Majority returns (bytes memory) {
        bytes32 p1 = authoritiesName[_instanceID][_address].hashPart1;
        bytes32 p2 = authoritiesName[_instanceID][_address].hashPart2;
        bytes memory joined = new bytes(64);
        assembly {
            mstore(add(joined, 32), p1)
            mstore(add(joined, 64), p2)
        }
        return joined;
    }

    function setElementHashed(uint64 _instanceID, bytes32 _hash1, bytes32 _hash2, bytes32 _hash3, bytes32 _hash4) public Majority Authority(msg.sender) {
        firstGHashed[_instanceID][msg.sender].hashPart1 = _hash1;
        firstGHashed[_instanceID][msg.sender].hashPart2 = _hash2;
        secondGHashed[_instanceID][msg.sender].hashPart1 = _hash3;
        secondGHashed[_instanceID][msg.sender].hashPart2 = _hash4;
    }

    function getElementHashed(address _address, uint64 _instanceID) public view Majority returns (bytes memory, bytes memory) {
        bytes32 p1 = firstGHashed[_instanceID][_address].hashPart1;
        bytes32 p2 = firstGHashed[_instanceID][_address].hashPart2;
        bytes32 p3 = secondGHashed[_instanceID][_address].hashPart1;
        bytes32 p4 = secondGHashed[_instanceID][_address].hashPart2;
        bytes memory joined = new bytes(64);
        assembly {
            mstore(add(joined, 32), p1)
            mstore(add(joined, 64), p2)
        }
        bytes memory joinedsec = new bytes(64);
        assembly {
            mstore(add(joinedsec, 32), p3)
            mstore(add(joinedsec, 64), p4)
        }
        return (joined, joinedsec);
    }

    function setElement(uint64 _instanceID, bytes32 _hash1, bytes32 _hash2, bytes32 _hash3, bytes32 _hash4, bytes32 _hash5, bytes32 _hash6) public Majority Authority(msg.sender) {
        firstG[_instanceID][msg.sender].hashPart1 = _hash1;
        firstG[_instanceID][msg.sender].hashPart2 = _hash2;
        firstG[_instanceID][msg.sender].hashPart3 = _hash3;
        secondG[_instanceID][msg.sender].hashPart1 = _hash4;
        secondG[_instanceID][msg.sender].hashPart2 = _hash5;
        secondG[_instanceID][msg.sender].hashPart3 = _hash6;
    }

    function getElement(address _address, uint64 _instanceID) public view Majority returns (bytes memory, bytes32, bytes memory, bytes32) {
        bytes32 p1 = firstG[_instanceID][_address].hashPart1;
        bytes32 p2 = firstG[_instanceID][_address].hashPart2;
        bytes32 p3 = firstG[_instanceID][_address].hashPart3;
        bytes32 p4 = secondG[_instanceID][_address].hashPart1;
        bytes32 p5 = secondG[_instanceID][_address].hashPart2;
        bytes32 p6 = secondG[_instanceID][_address].hashPart3;
        bytes memory joined = new bytes(64);
        assembly {
            mstore(add(joined, 32), p1)
            mstore(add(joined, 64), p2)
        }
        bytes memory joinedsec = new bytes(64);
        assembly {
            mstore(add(joinedsec, 32), p4)
            mstore(add(joinedsec, 64), p5)
        }
        return (joined, p3, joinedsec, p6);
    }

    function setPublicParameters(uint64 _instanceID, bytes32 _hash1, bytes32 _hash2) public Majority Authority(msg.sender) {
        parameters[_instanceID][msg.sender].hashPart1 = _hash1;
        parameters[_instanceID][msg.sender].hashPart2 = _hash2;
    }

    function getPublicParameters(address _address, uint64 _instanceID) public view Majority returns (bytes memory) {
        bytes32 p1 = parameters[_instanceID][_address].hashPart1;
        bytes32 p2 = parameters[_instanceID][_address].hashPart2;
        bytes memory joined = new bytes(64);
        assembly {
            mstore(add(joined, 32), p1)
            mstore(add(joined, 64), p2)
        }
        return joined;
    }

    function setPublicKey(uint64 _instanceID, bytes32 _hash1, bytes32 _hash2) public Majority Authority(msg.sender) {
        publicKeys[_instanceID][msg.sender].hashPart1 = _hash1;
        publicKeys[_instanceID][msg.sender].hashPart2 = _hash2;
    }

    function getPublicKey(address _address, uint64 _instanceID) public view Majority returns (bytes memory) {
        bytes32 p2 = publicKeys[_instanceID][_address].hashPart1;
        bytes32 p3 = publicKeys[_instanceID][_address].hashPart2;
        bytes memory joined = new bytes(64);
        assembly {
            mstore(add(joined, 32), p2)
            mstore(add(joined, 64), p3)
        }
        return (joined);
    }

    function setPublicKeyReaders(bytes32 _hash1, bytes32 _hash2) public Majority User(msg.sender) {
        publicKeysReaders[msg.sender].hashPart1 = _hash1;
        publicKeysReaders[msg.sender].hashPart2 = _hash2;
    }

    function getPublicKeyReaders(address _address) public view Majority returns (bytes memory) {
        bytes32 p2 = publicKeysReaders[_address].hashPart1;
        bytes32 p3 = publicKeysReaders[_address].hashPart2;
        bytes memory joined = new bytes(64);
        assembly {
            mstore(add(joined, 32), p2)
            mstore(add(joined, 64), p3)
        }
        return (joined);
    }

    function setIPFSLink( uint64 _messageID, bytes32 _hash1, bytes32 _hash2) public Majority User(msg.sender) {
        allLinks[_messageID].sender = msg.sender;
        allLinks[_messageID].hashPart1 = _hash1;
        allLinks[_messageID].hashPart2 = _hash2;
    }

    function getIPFSLink(uint64 _messageID) public view Majority returns (address, bytes memory) {
        address sender = allLinks[_messageID].sender;
        bytes32 p1 = allLinks[_messageID].hashPart1;
        bytes32 p2 = allLinks[_messageID].hashPart2;
        bytes memory joined = new bytes(64);
        assembly {
            mstore(add(joined, 32), p1)
            mstore(add(joined, 64), p2)
        }
        return (sender, joined);
    }

    function setUserAttributes(uint64 _instanceID, bytes32 _hash1, bytes32 _hash2) public Majority {
        for (uint256 j = 0; j < attributeCertifiers.length; j++) {
            if (msg.sender == attributeCertifiers[j]) {
                allUsers[_instanceID].hashPart1 = _hash1;
                allUsers[_instanceID].hashPart2 = _hash2;
            }
        }
    }

    function getUserAttributes(uint64 _instanceID) public view Majority returns (bytes memory) {
        bytes32 p1 = allUsers[_instanceID].hashPart1;
        bytes32 p2 = allUsers[_instanceID].hashPart2;
        bytes memory joined = new bytes(64);
        assembly {
            mstore(add(joined, 32), p1)
            mstore(add(joined, 64), p2)
        }
        return joined;
    }

    function dissolve() public {
        for (uint256 j = 0; j < attributeCertifiers.length; j++) {
            if (msg.sender == attributeCertifiers[j]) {
                if (attributeCertifiersDest[msg.sender] != true) {
                    AUTHDESTRUCTION = AUTHDESTRUCTION + 1;
                    attributeCertifiersDest[msg.sender] = true;
                }
            }
        }
        if (AUTHDESTRUCTION > 1) {
            selfdestruct(address_to_pay);
        }
    }
}
