CREATE TABLE invoices (
  id SERIAL,
  total_amount decimal not null,
  generated_at timestamp not null,
  payed_at timestamp,
  medical_history_id integer not null,
  PRIMARY KEY (id)
);

ALTER TABLE invoices 
ADD CONSTRAINT medical_pkey 
FOREIGN KEY (medical_history_id) 
REFERENCES medical_histories (id);


CREATE TABLE medical_histories (
  id SERIAL,
  admitted_at timestamp not null,
  patient_id integer not null,
  status varchar(255) not null,
  PRIMARY KEY (id)
);

ALTER TABLE medical_histories
ADD CONSTRAINT patient_pkey
FOREIGN KEY (patient_id)
REFERENCES patients (id);

CREATE TABLE patients (
  id SERIAL,
  name varchar(255) not null,
  PRIMARY KEY (id)
);

