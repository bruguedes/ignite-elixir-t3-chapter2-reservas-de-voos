# ignite-elixir-t3-chapter2-reservas-de-voos
Desafio: Reservas de voos - Ignite Trilha Elixir - Turma 03 - Chapter II


# 💻 Sobre o desafio

Nesse desafio, você deverá criar uma aplicação de reserva de voos, onde haverá o cadastro de usuários e o cadastro de reservas para um usuário.

A struct do usuário deverá possuir os seguintes campos:

```elixir
%User{
	id: id,
	name: name,
	email: email,
	cpf: cpf
}
```

A struct da reserva deverá possuir os seguintes campos:

```elixir
%Booking{
	id: id,
	data_completa: data_completa,
	cidade_origem: cidade_origem,
	cidade_destino: cidade_destino,
	id_usuario: id_usuario
}
```
