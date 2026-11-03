USE lava_jato;

-- =========================================================
-- ETAPA 04 - SQL DAS CONSULTAS
-- Execute depois de create_tables.sql e insert_data.sql.
-- 4 consultas novas:
--   1 anti-join, 1 full outer join (emulado), 2 com subconsultas.
-- =========================================================

-- Consulta 01 — Anti Join (esquerda)
-- Justificativa:
-- Lista funcionarios que ainda nao participaram de nenhum atendimento
-- (nao aparecem na tabela associativa REALIZA).
SELECT
    f.id_funcionario,
    f.nome,
    f.cargo
FROM funcionario f
LEFT JOIN realiza r
    ON r.id_funcionario = f.id_funcionario
WHERE r.id_atendimento IS NULL
ORDER BY f.nome;

-- Consulta 02 — Full Outer Join (emulado no MySQL com UNION)
-- Justificativa:
-- O MySQL nao possui FULL OUTER JOIN nativo.
-- A uniao de LEFT JOIN com RIGHT JOIN cobre:
--   - clientes com e sem veiculo
--   - veiculos associados a clientes
-- Assim a consulta mostra o relacionamento completo cliente/veiculo.
SELECT
    c.id_cliente,
    c.nome AS cliente,
    v.placa,
    v.modelo,
    'cliente_com_ou_sem_veiculo' AS origem
FROM cliente c
LEFT JOIN veiculo v
    ON v.id_cliente = c.id_cliente

UNION

SELECT
    c.id_cliente,
    c.nome AS cliente,
    v.placa,
    v.modelo,
    'veiculo_com_cliente' AS origem
FROM cliente c
RIGHT JOIN veiculo v
    ON v.id_cliente = c.id_cliente
ORDER BY id_cliente, placa;

-- Consulta 03 — Subconsulta 1
-- Justificativa:
-- Compara cada avaliacao com a media geral de notas (subconsulta escalar).
SELECT
    c.id_cliente,
    c.nome,
    av.nota,
    av.comentarios,
    av.data
FROM avaliacao av
JOIN cliente c
    ON c.id_cliente = av.id_cliente
WHERE av.nota > (
    SELECT AVG(av2.nota)
    FROM avaliacao av2
)
ORDER BY av.nota DESC, c.nome;

-- Consulta 04 — Subconsulta 2
-- Justificativa:
-- Lista servicos cujo preco esta acima da media do catalogo
-- e que ja foram executados em pelo menos um atendimento finalizado.
SELECT
    s.id_servico,
    s.nome_servico,
    s.preco,
    (
        SELECT COUNT(*)
        FROM atendimento a
        WHERE a.id_servico = s.id_servico
          AND a.status = 'finalizado'
    ) AS total_finalizados
FROM servico s
WHERE s.preco > (
    SELECT AVG(s2.preco)
    FROM servico s2
)
ORDER BY s.preco DESC, s.nome_servico;
