CREATE database pratica1;

CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,   
    nome VARCHAR(100) NOT NULL,                   
    email VARCHAR(100) NOT NULL UNIQUE,           
    telefone VARCHAR(15)                         
);


CREATE TABLE Colaboradores (
    id_colaborador INT PRIMARY KEY AUTO_INCREMENT, 
    nome VARCHAR(100) NOT NULL,                     
    email VARCHAR(100) NOT NULL UNIQUE              
);


CREATE TABLE Chamados (
    id_chamado INT PRIMARY KEY AUTO_INCREMENT,      
    id_cliente INT NOT NULL,                       
    descricao TEXT NOT NULL,                        
    criticidade ENUM('baixa', 'média', 'alta') NOT NULL, 
    status ENUM('aberto', 'em andamento', 'resolvido') DEFAULT 'aberto',
    data_abertura DATETIME DEFAULT CURRENT_TIMESTAMP, 
    id_colaborador INT,                            
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente) ON DELETE CASCADE, 
    FOREIGN KEY (id_colaborador) REFERENCES Colaboradores(id_colaborador) ON DELETE SET NULL 
);


CREATE TABLE Historico_Chamados (
    id_historico INT PRIMARY KEY AUTO_INCREMENT,      
    id_chamado INT NOT NULL,                           
    id_colaborador INT,                               
    status_anterior ENUM('aberto', 'em andamento', 'resolvido'),
    status_novo ENUM('aberto', 'em andamento', 'resolvido'),
    data_alteracao DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_chamado) REFERENCES Chamados(id_chamado) ON DELETE CASCADE, 
    FOREIGN KEY (id_colaborador) REFERENCES Colaboradores(id_colaborador) ON DELETE SET NULL 
);


SELECT 
    c.nome AS cliente_nome,
    ch.descricao,
    ch.criticidade,
    ch.status,
    ch.data_abertura,
    col.nome AS colaborador_nome
FROM 
    Chamados ch
JOIN 
    Clientes c ON ch.id_cliente = c.id_cliente
LEFT JOIN 
    Colaboradores col ON ch.id_colaborador = col.id_colaborador
WHERE 
    ch.status = 'aberto' AND
    ch.criticidade = 'alta' AND
    col.nome LIKE '%João%';


SELECT 
    ch.id_chamado,
    ch.descricao,
    ch.criticidade,
    ch.status,
    ch.data_abertura
FROM 
    Chamados ch
WHERE 
    ch.id_cliente = 1; 