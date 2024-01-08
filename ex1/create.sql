create table country(
	country varchar not null, 
	countrycode char(3) primary key,
	region varchar check(
		region='South Asia' or 
		region='Europe and Central Asia' or 
		region='Middle East and North Africa' or 
		region='Sub-Saharan Africa' or 
		region='Latin America and Caribbean' or
		region='East Asia and Pacific' or
		region='North America'),
	incomegroup varchar check(
		incomegroup='Low income' or 
		incomegroup='Upper middle income' or 
		incomegroup='Lower middle income' or 
		incomegroup='High income')
);

create table university(
	iau_id1 varchar primary key, 
	eng_name varchar not null, 
	orig_name varchar not null, 
	foundedyr smallint not null, 
	private01 bit not null, 
	latitude float, 
	longitude float, 
	phd_granting bit not null, 
	divisions int check(divisions >= 0), 
	specialized bit not null,
	countrycode char(3) not null,
	foreign key(countrycode) references country(countrycode)
);

create table closed_university(
	iau_id1 varchar not null,
	yrclosed smallint not null,
	foreign key(iau_id1) references university(iau_id1)
);

create table estimated_in(
	iau_id1 varchar not null,
	year smallint not null,
	students5_estimated int check(students5_estimated >= 0),
	foreign key(iau_id1) references university(iau_id1),
	unique(year, iau_id1)
);

