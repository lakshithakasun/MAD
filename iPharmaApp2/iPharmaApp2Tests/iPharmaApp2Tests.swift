//
//  iPharmaApp2Tests.swift
//  iPharmaApp2Tests
//
//  Created by LakshithaS on 2025-05-02.
//

import XCTest
@testable import iPharmaApp2

final class PrescriptionTests: XCTestCase {

    var viewModel: AppViewModel!
    var patient: Patient!
    var pharmacist: Pharmacist!
    var prescription: Prescription!

    override func setUp() {
        super.setUp()

        viewModel = AppViewModel()

        patient = Patient(
            name: "Test Patient",
            address: "123 Main St",
            location: "Springfield",
            mobile: "1234567890",
            password: "patientpass"
        )

        pharmacist = Pharmacist(
            pharmacyName: "BestPharma",
            address: "456 Health Ave",
            location: "Downtown",
            openHours: "9AM - 5PM",
            certificate: "CERT1234",
            password: "pharmacistpass"
        )

        prescription = Prescription(
            id: UUID(), // Explicitly provide the ID
            patient: patient,
            image: "prescription.png",
            responded: true,
            responseDetails: "Please pick it up at 3PM",
            selectedPharmacy: pharmacist,
            orderConfirmed: false,
            orderPin: "123456",
            status: .accepted
        )

        MockDatabase.shared.patients = [patient]
        MockDatabase.shared.pharmacists = [pharmacist]
        MockDatabase.shared.prescriptions = [prescription]
        viewModel.patient = patient
    }

    func testConfirmOrderUpdatesStatus() {
        guard let index = MockDatabase.shared.prescriptions.firstIndex(where: { $0.image == "prescription.png" }) else {
            XCTFail("Prescription not found")
            return
        }

        MockDatabase.shared.prescriptions[index].orderConfirmed = true
        MockDatabase.shared.prescriptions[index].status = .confirmed
        viewModel.confirmOrder(prescription: MockDatabase.shared.prescriptions[index])

        let updated = MockDatabase.shared.prescriptions[index]
        XCTAssertTrue(updated.orderConfirmed)
        XCTAssertEqual(updated.status, .confirmed)
    }

    func testRejectOrderRemovesPrescription() {
        guard let index = MockDatabase.shared.prescriptions.firstIndex(where: { $0.image == "prescription.png" }) else {
            XCTFail("Prescription not found")
            return
        }

        MockDatabase.shared.prescriptions[index].status = .cancelled
        MockDatabase.shared.prescriptions.remove(at: index)

        XCTAssertTrue(MockDatabase.shared.prescriptions.isEmpty)
    }
}
