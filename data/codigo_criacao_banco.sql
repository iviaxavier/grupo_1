CREATE DATABASE HairMatch;

USE HairMatch;

CREATE TABLE Usuario (
    ID_Usuario INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    CPF VARCHAR(14) NOT NULL UNIQUE,
    Telefone VARCHAR(20) NULL,
    Idade INT NULL,
    Endereco TEXT NULL,
    Senha VARCHAR(255) NOT NULL,
    ID_Plano INT NOT NULL,
    FOREIGN KEY (ID_Plano) REFERENCES Plano(ID_Plano) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Perfil_Capilar (
    ID_Perfil_Capilar INT AUTO_INCREMENT PRIMARY KEY,
    ID_Usuario INT NOT NULL UNIQUE,
    Tipo_de_Cabelo VARCHAR(100) NULL,
    Descricao_da_Curvatura VARCHAR(255) NULL,
    Curvatura VARCHAR(50) NULL,
    Estado_do_Cabelo VARCHAR(255) NULL,
    Objetivo VARCHAR(255) NULL,
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Salao (
    ID_Salao INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Endereco VARCHAR(255) NOT NULL,
    Telefone VARCHAR(20) NULL,
    Especialidades TEXT NULL,
    Nota DECIMAL(3, 2) DEFAULT 0.00
);

CREATE TABLE Profissional (
    ID_Profissional INT AUTO_INCREMENT PRIMARY KEY,
    ID_Salao INT NOT NULL,
    Nome VARCHAR(255) NOT NULL,
    Especialidade VARCHAR(255) NULL,
    Telefone VARCHAR(20) NULL,
    FOREIGN KEY (ID_Salao) REFERENCES Salao(ID_Salao) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Servico (
    ID_Servico INT AUTO_INCREMENT PRIMARY KEY,
    ID_Salao INT NOT NULL,
    ID_Profissional INT NULL,
    Nome VARCHAR(255) NOT NULL,
    Descricao TEXT NULL,
    Preco DECIMAL(10, 2) NOT NULL,
    Tipo_Servico VARCHAR(100) NULL,
    FOREIGN KEY (ID_Salao) REFERENCES Salao(ID_Salao) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ID_Profissional) REFERENCES Profissional(ID_Profissional) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Agendamento (
    ID_Agendamento INT AUTO_INCREMENT PRIMARY KEY,
    ID_Usuario INT NOT NULL,
    ID_Salao INT NOT NULL,
    ID_Profissional INT NULL,
    ID_Servico INT NOT NULL,
    Data DATE NOT NULL,
    Hora TIME NOT NULL,
    Status VARCHAR(50) NOT NULL DEFAULT 'Agendado',
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ID_Salao) REFERENCES Salao(ID_Salao) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ID_Profissional) REFERENCES Profissional(ID_Profissional) ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (ID_Servico) REFERENCES Servico(ID_Servico) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Avaliacao (
    ID_Avaliacao INT AUTO_INCREMENT PRIMARY KEY,
    ID_Usuario INT NOT NULL,
    ID_Salao INT NOT NULL,
    Nota INT NOT NULL CHECK (Nota >= 1 AND Nota <= 5),
    Comentario TEXT NULL,
    Data_Avaliacao DATE NOT NULL,
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ID_Salao) REFERENCES Salao(ID_Salao) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Cronograma_Capilar (
    ID_Cronograma INT AUTO_INCREMENT PRIMARY KEY,
    ID_Usuario INT NOT NULL,
    ID_Perfil_Capilar INT NOT NULL,
    Data DATE NOT NULL,
    Meu_Cuidado TEXT NULL,
    Produto_Sugerido VARCHAR(255) NULL,
    Recomendacoes TEXT NULL,
    FOREIGN KEY (ID_Usuario) REFERENCES Usuario(ID_Usuario) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ID_Perfil_Capilar) REFERENCES Perfil_Capilar(ID_Perfil_Capilar) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Plano (
    ID_Plano INT AUTO_INCREMENT PRIMARY KEY,
    Tipo VARCHAR(50) NOT NULL,
    Duracao INT NULL,
    Beneficios TEXT NULL,
    Valor DECIMAL(10, 2) NOT NULL
);
