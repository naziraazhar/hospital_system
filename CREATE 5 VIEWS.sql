
--view 1
create view specialistAppointmentMgnmt (appointmentDate, appointmentTime, sstaffNo, sstaffName, sstaffPhoneNo, ipatientNo, lpatientNo)
as select a.appointmentDate,  a.appointmentTime,a.sstaffNo,s.sstaffName, s.sstaffPhoneNo, a.ipatientNo, a.lPatientNo
from specialistDoctor s, medicalDoctor m, appointment a
where a.sstaffNo=s.sstaffNo and a.sstaffNo is not null 
group by  a.appointmentDate,  a.appointmentTime,a.sstaffNo,s.sstaffName, s.sstaffPhoneNo, a.ipatientNo, a.lPatientNo;

DROP VIEW appointmentMgnmt

select * from specialistAppointmentMgnmt 

--view 2
create view insuranceCoveredLocalPatient(lpatientNo, lpatientName, Treatment, amountPaidByInsurance, insuranceName)
as select l.lpatientNo, l.lpatientName, t.TreatmentNo, i.amount, i.insuranceName
from localPatient l, treatment t, insurancePayment i
where l.lpatientNo=i.lPatientNo and l.lpatientNo=t.lPatientNo 
group by l.lpatientNo, l.lpatientName, t.TreatmentNo, i.amount, i.insuranceName;

DROP VIEW insuranceCoveredLocalPatient

select * from insuranceCoveredLocalPatient

--view 3
create view medDoctorLocalAppointment(staffNo, staffName, roomNo, appointmentDate, 
appointmentTime, localPatientNo, localPatientName, localPatientPhoneNo)
as select m.mstaffNo, m.mstaffName, m.roomNo,
a.appointmentDate, a.appointmentTime, 
l.lPatientNo, l.lPatientName, l.lpatientphoneNo
from appointment a, medicalDoctor m, localPatient l
where a.mstaffNo = m.mstaffNo and a.lpatientNo=l.lpatientNo
group by m.mstaffNo, m.mstaffName,  m.roomNo,
a.appointmentDate, a.appointmentTime, 
l.lPatientNo, l.lPatientName, l.lpatientphoneNo

DROP VIEW medDoctorLocalAppointment

select * from medDoctorLocalAppointment

--view 4 patient history
create view inPatientRecord(department, attendingDr, patientNo,patientName, 
treatmentNo, wardNo, bedNo, admitDate, dischargedDate, drugNo, quantity)
as select d.departmentName, m.mstaffName, l.lpatientNo, l.lpatientName, t.treatmentNo, 
td.wardNo, td.bedNo, td.admitDate, td.dischargedDate, td.drugNo, td.quantity
from department d, medicalDoctor m, localPatient l, treatment t, treatmentDetails td, appointment a
where td.treatmentNo = t.treatmentNo
	  AND l.lpatientNo=t.lpatientNo
	  AND a.lpatientNo = t.lpatientNo
	  AND m.mstaffNo=a.mStaffNo
	  AND m.departmentNo = d.departmentNo 
	  AND td.wardNo is not null
	  
group by d.departmentName, m.mstaffName, l.lpatientNo, l.lpatientName, t.treatmentNo, 
td.wardNo, td.bedNo, td.admitDate, td.dischargedDate, td.drugNo, td.quantity;

drop view inPatientRecord
select * from  inPatientRecord

--view 5
CREATE VIEW DoctorsPerDepartment AS
SELECT Department.departmentNo, Department.departmentName, 
COUNT(SpecialistDoctor.sstaffName) AS specialistCount, 
COUNT(MedicalDoctor.mstaffName) AS medicalCount
FROM Department
LEFT JOIN SpecialistDoctor ON Department.departmentNo = SpecialistDoctor.departmentNo
LEFT JOIN MedicalDoctor ON Department.departmentNo = MedicalDoctor.departmentNo
GROUP BY Department.departmentNo, Department.departmentName;

drop view DoctorsPerDepartment
select * from DoctorsPerDepartment;