create table BOOKCATEGORY
(bookcat char(2),
description varchar(100) not null,
constraint pk_bcategory primary key (bookcat)
)

create table publisher
(publisherID smallint primary key,
name varchar(50) not null
)

create table book
(isbn char(10) primary key,
title varchar(200) not null,
yearpublish char(4) not null,
publisherID smallint null foreign key references publisher(publisherID),
bookcat char(2) null,
constraint fk_book_bookcat foreign key (bookcat) references BOOKCATEGORY(bookcat)
)