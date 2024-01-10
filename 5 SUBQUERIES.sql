
--query with aggregated

--1.
select insuranceName, count( insuranceName) as noOfInsuranceCompany
from insurancePayment
group By insuranceName

--2.
select typeOfPayment, count(typeOfPayment) as countPaymentMethod
from personalPayment
group By typeOfPayment

--3. 
select min(msalary) as min, max(msalary) as max, avg(msalary) as average
from MedicalDoctor

--subquery
--1.
select appointmentNo, appointmentDate, appointmentTime
from appointment
where lpatientNo=1032;

--2. 
select * from internationalPatient
where ipatientNo in (
 select ipatientNo from Appointment
	where mstaffNo in(
		select mstaffNo from MedicalDoctor
			where mstaffName='Haidar'))

select * from appointment
where lpatientNo in(
	select lpatientNo from insuranceCoveredLocalPatient
	where insuranceName='PruBSN')

select * from insuranceCoveredLocalPatient
select * from Department
select * from medDoctorLocalAppointment

select * from MedicalDoctor
where mstaffName='Haidar'

 select * from medDoctorLocalAppointment 
	where staffNo in(
		select mstaffNo from MedicalDoctor
			where departmentNo=113)

select * from Treatment
select * from appointment
--multitable query
--1.
select l.lpatientName as 'Patient Name', l.lpatientPhoneNo as 'Contact No.', i.amount as bill, i.insuranceName as 'Paid By'
from LocalPatient l, InsurancePayment i
where l.lpatientNo=i.lpatientNo;

--2. Query find the details of patients’ appointment schedule that have been set and their respective doctors.
SELECT a.appointmentDate, a.appointmentTime, a.ipatientNo, a.lpatientNo, m.mstaffNo, m.mstaffName, m.roomNo
FROM Appointment a, MedicalDoctor m
WHERE a.mstaffNo=m.mstaffNo

--3. 
SELECT l.lpatientNo as 'ID', l.lpatientName as 'Name', t.treatmentNo as 'Treatment ID', d.admitDate as 'Admit Date', d.dischargedDate as 'Disharge Date', d.bedNo as 'Bed No', d.wardNo as 'Ward No'
from LocalPatient l, Treatment t, TreatmentDetails d
where l.lpatientNo=t.lpatientNo and t.treatmentNo=d.treatmentNo and admitDate is not null


select appointmentNo, appointmentDate, appointmentTime
from appointment
where lpatientNo=1032;

select * from InsurancePayment

ALTER TABLE insurancePayment
alter column amount Decimal(9,2);


select insuranceName, sum(amount) as sum
from insurancePayment
group by insuranceName 
order by insuranceName

select * from Treatment

select AppointmentDate, count(mstaffNo) as 'No of attending Dr', count(sstaffNo) as 'No of attending specialist'
from Appointment
group by appointmentDate
order by appointmentDate


select * from inPatientRecord

--
select a.appointmentDate, d.*
from Appointment a, treatmentDetails d, Treatment t

select * from insuranceCoveredLocalPatient

SELECT l.lpatientNo as 'ID', l.lpatientName as 'Name',
t.treatmentNo as 'Treatment ID', 
d.drugNo as 'Drug No', d.quantity as 'Drug Quantity'
from LocalPatient l, Treatment t, TreatmentDetails d
where l.lpatientNo=t.lpatientNo and t.treatmentNo=d.treatmentNo and admitDate is null 


SELECT l.*, p.amount as 'Amount (RM)', p.typeOfPayment as 'Payment method'
FROM LocalPatient l  JOIN
		 PersonalPayment p ON p.lpatientNo=l.lpatientNo
