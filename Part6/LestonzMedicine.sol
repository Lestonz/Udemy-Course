// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract MedicineTrackingSystem {
    address public government;

    struct Medicine {
        string name;
        string info;
    }

    mapping(address => bool) public pharmacy;
    mapping(address => bool) public doctors;
    mapping(address => bool) public patients;

    mapping(uint => Medicine) private medicines;
    mapping(uint => uint) private medicineStock;

    mapping(address => mapping(uint => uint)) private amountOfMedicine; // amount of medicine for each patient

    modifier onlyGovernment() {
        require(msg.sender == government, "Only the Government can access it.");
        _;
    }
    
    modifier onlyPharmacy() {
        require(pharmacy[msg.sender] == true, "Only the Pharmacy can access it.");
        _;
    }

    modifier onlyDocktor() {
        require(doctors[msg.sender] == true, "Only the Doctor can access it.");
        _;
    }

    modifier onlyPatient() {
        require(patients[msg.sender] == true, "Only the Patient can access it.");
        _;
    }

    constructor() {
        government = msg.sender;
    }

    function addPharmacy(address _pharmacy) external onlyGovernment {
        pharmacy[_pharmacy] = true;
    }

    function addDoctor(address _doctor) external onlyGovernment {
        doctors[_doctor] = true;
    }

    function addPatient(address _patientAddress, uint _medicineId, uint _amount) external onlyDocktor {
        patients[_patientAddress] = true;
        amountOfMedicine[_patientAddress][_medicineId] = _amount;
    }

    function addMedicine(uint _medicineId, string memory _name, string memory _info, uint _amountOfStock) external onlyPharmacy {
        Medicine storage medicine = medicines[_medicineId];

        medicine.name = _name;
        medicine.info = _info;
        medicineStock[_medicineId] = _amountOfStock;
    }

    function takeMedicine(uint _medicineId, uint _amount) external onlyPatient {
        require(amountOfMedicine[msg.sender][_medicineId] > 0, "This medicine has already been taken before!" );
        require(medicineStock[_medicineId] >= _amount, "The specified amount of medicine is out of stock!" );

        medicineStock[_medicineId] -= _amount;
        amountOfMedicine[msg.sender][_medicineId] -= _amount;

    }

    function infoMedicine(uint _medicineId) external view returns(string memory, string memory, uint) {
        Medicine memory medicine = medicines[_medicineId];

        return (medicine.name, medicine.info, medicineStock[_medicineId]);
    }

    
}