USE lava_jato;

-- =========================================================
-- ETAPA 04 - SQL DAS VISOES
-- Execute depois de create_tables.sql e insert_data.sql.
-- =========================================================

-- View 01
-- Justificativa semantica:
-- Centraliza o acompanhamento operacional dos atendimentos finalizados.
-- Reune cliente, veiculo, servico e funcionario responsavel em um unico
-- resultado pronto para gestao do lava jato.
-- Estrutura: 5 joins + where.
DROP VIEW IF EXISTS vw_atendimentos_finalizados_detalhados;

CREATE VIEW vw_atendimentos_finalizados_detalhados AS
SELECT
    a.id_atendimento,
    a.data,
    a.hora,
    c.nome AS cliente,
    v.placa,
    v.modelo,
    s.nome_servico,
    f.nome AS funcionario_responsavel,
    a.status
FROM atendimento a
JOIN cliente c
    ON c.id_cliente = a.id_cliente_veiculo
JOIN veiculo v
    ON v.placa = a.placa_veiculo
   AND v.id_cliente = a.id_cliente_veiculo
JOIN servico s
    ON s.id_servico = a.id_servico
JOIN realiza r
    ON r.id_atendimento = a.id_atendimento
JOIN funcionario f
    ON f.id_funcionario = r.id_funcionario
WHERE a.status = 'finalizado';

-- View 02
-- Justificativa semantica:
-- Destaca avaliacoes acima da media, mostrando o contexto completo:
-- cliente, atendimento avaliado, servico executado e veiculo lavado.
-- Ajuda a identificar quais servicos/veiculos geram melhor satisfacao.
-- Estrutura: 4 joins + subconsulta + where.
DROP VIEW IF EXISTS vw_clientes_com_boas_avaliacoes;

CREATE VIEW vw_clientes_com_boas_avaliacoes AS
SELECT
    c.id_cliente,
    c.nome,
    a.id_atendimento,
    a.data AS data_atendimento,
    s.nome_servico,
    v.placa,
    v.modelo,
    av.nota,
    av.comentarios,
    av.data AS data_avaliacao
FROM cliente c
JOIN avaliacao av
    ON av.id_cliente = c.id_cliente
JOIN atendimento a
    ON a.id_atendimento = av.id_atendimento
JOIN servico s
    ON s.id_servico = a.id_servico
JOIN veiculo v
    ON v.placa = a.placa_veiculo
   AND v.id_cliente = a.id_cliente_veiculo
WHERE av.nota >= (
    SELECT AVG(av2.nota)
    FROM avaliacao av2
);

-- Consultas simples para visualizar as views criadas.
SELECT * FROM vw_atendimentos_finalizados_detalhados;
SELECT * FROM vw_clientes_com_boas_avaliacoes;
