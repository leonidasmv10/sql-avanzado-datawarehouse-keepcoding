create table alumnos (
    alumno_id serial primary key,
    nombre varchar(50) not null,
    apellido varchar(50) not null,
    email varchar(100) unique not null,
    fecha_nacimiento date,
    teléfono varchar(15)
);

create table bootcamps (
    bootcamp_id serial primary key,
    nombre varchar(100) not null,
    descripción text,
    duración int check (duración > 0),
    fecha_inicio date,
    fecha_fin date
);

create table modulos (
    modulo_id serial primary key,
    nombre varchar(100) not null,
    descripción text,
    duración int check (duración > 0),
    bootcamp_id int references bootcamps(bootcamp_id) on delete cascade
);

create table profesores (
    profesor_id serial primary key,
    nombre varchar(50) not null,
    apellido varchar(50) not null,
    email varchar(100) unique not null,
    especialidad varchar(100)
);

create table inscripciones (
    inscripción_id serial primary key,
    alumno_id int references alumnos(alumno_id) on delete cascade,
    bootcamp_id int references bootcamps(bootcamp_id) on delete cascade,
    fecha_inscripción date not null,
    estado varchar(20) check (estado in ('activo', 'finalizado', 'cancelado'))
);

create table clases (
    clase_id serial primary key,
    profesor_id int references profesores(profesor_id) on delete
    set
        null,
        modulo_id int references modulos(modulo_id) on delete cascade,
        fecha_clase date
);