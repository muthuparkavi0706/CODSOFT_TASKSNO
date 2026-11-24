// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StudentCertificateVerification {
    address public owner;
    // Structure to store certificate details
    struct Certificate {
        string studentName;
        string certificateId;
        string courseName;
        string issueDate;
        bool exists;
    }
    mapping(string => Certificate) private certificates;

    mapping(address => bool) public admins;

    event CertificateIssued(
        string certificateId,
        string studentName
    );

    constructor() {
        owner = msg.sender;
        admins[msg.sender] = true;
    }

    modifier onlyAdmin() {
        require(admins[msg.sender], "Not authorized");
        _;
    }

    // Add or remove an administrator
    function setAdmin(
        address _admin,
        bool _status
    ) public {

        require(
            msg.sender == owner,
            "Only owner can manage admins"
        );
        require(
            _admin != address(0),
            "Invalid address"
        );
        admins[_admin] = _status;
    }

    // Register a student certificate
    function issueCertificate(
        string memory _studentName,
        string memory _certificateId,
        string memory _courseName,
        string memory _issueDate
    ) public onlyAdmin {

        require(
            bytes(_studentName).length > 0,
            "Enter student name"
        );

        require(
            bytes(_certificateId).length > 0,
            "Enter certificate ID"
        );
        require(
            bytes(_courseName).length > 0,
            "Enter course name"
        );
        require(
            bytes(_issueDate).length > 0,
            "Enter issue date"
        );

        require(
            !certificates[_certificateId].exists,
            "Certificate ID already registered"
        );

        certificates[_certificateId] = Certificate(
            _studentName,
            _certificateId,
            _courseName,
            _issueDate,
            true
        );

        emit CertificateIssued(
            _certificateId,
            _studentName
        );
    }

    // Verify certificate using cID
    function verifyCertificate(
        string memory _certificateId
    )
        public
        view
        returns (
            bool,
            string memory,
            string memory,
            string memory,
            string memory
        )
    {
        Certificate memory cert =
            certificates[_certificateId];

        if (!cert.exists) {
            return (false, "", "", "", "");
        }
        return (
            true,
            cert.studentName,
            cert.certificateId,
            cert.courseName,
            cert.issueDate
        );
    }
}
