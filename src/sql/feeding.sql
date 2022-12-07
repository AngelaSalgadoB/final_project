
-- VIOLENCE TYPE
INSERT
    IGNORE INTO violence(violence_type)
VALUES ('physical'), ('psychological'), ('sexual'), ('economical'), ('symbolical'), ('domestical');

-- VIOLENCE MODALITY
INSERT
    IGNORE INTO modality(modality_type)
VALUES ('institutional'), ('labour'), ('media'), (
        'against reproductive freedom'
    ), ('obstetric'), ('others');

-- CALLS
INSERT INTO
    calls (
        id,
        call_date,
        id_localization,
        victim_gender,
        victim_age,
        aggressor_gender,
        link
    ) (
        SELECT
            staging.id,
            STR_TO_DATE(fecha, "%Y-%m-%d"),
            localization.id,
            genero_persONa_en_situaciON_de_violencia,
            edad,
            genero_de_la_persONa_agresora,
            vinculo_cON_la_persONa_agresora
        FROM staging
            JOIN localization ON localization.region_name = staging.prov_residencia_persONa_en_situaciON_violencia
        WHERE NOT EXISTS (
                SELECT c.id
                FROM
                    calls c,
                    staging stg
                WHERE
                    c.id = stg.id
                LIMIT 1
            )
    );

-- CALLS_VIOLENCE
INSERT INTO
    calls_violence(call_id, violence_id) (
        SELECT
            staging.id AS call_id,
            violence.id AS violence_id
        FROM
            staging,
            violence
        WHERE ( (
                    staging.tipo_de_violencia_fisica = 'si'
                    AND violence.violence_type = 'physical'
                )
                OR (
                    staging.tipo_de_violencia_psicologica = 'si'
                    AND violence.violence_type = 'psychological'
                )
                OR (
                    staging.tipo_de_violencia_sexual = 'si'
                    AND violence.violence_type = 'sexual'
                )
                OR (
                    staging.tipo_de_violencia_ecONomica_y_patrimONial = 'si'
                    AND violence.violence_type = 'ecONomical'
                )
                OR (
                    staging.tipo_de_violencia_simbolica = 'si'
                    AND violence.violence_type = 'symbolical'
                )
                OR (
                    staging.tipo_de_violencia_domestica = 'si'
                    AND violence.violence_type = 'domestical'
                )
            )
            AND NOT EXISTS (
                SELECT *
                FROM
                    calls_violence cv2,
                    staging stg2,
                    violence v2
                WHERE
                    cv2.call_id = stg2.id
                    AND cv2.violence_id = v2.id
                LIMIT 1
            )
    );

-- CALLS_MODALITY
INSERT INTO
    calls_modality(call_id, modality_id) (
        SELECT
            staging.id AS call_id,
            modality.id AS modality_id
        FROM
            staging,
            modality
        WHERE ( (
                    staging.modalidad_de_violencia_instituciONal = 'si'
                    AND modality.modality_type = 'institutiONal'
                )
                OR (
                    staging.modalidad_de_violencia_laboral = 'si'
                    AND modality.modality_type = 'labour'
                )
                OR (
                    staging.modalidad_violencia_cONtra_libertad_reproductiva = 'si'
                    AND modality.modality_type = 'against reproductive freedom'
                )
                OR (
                    staging.modalidad_de_violencia_obstetrica = 'si'
                    AND modality.modality_type = 'obstetric'
                )
                OR (
                    staging.modalidad_de_violencia_mediatica = 'si'
                    AND modality.modality_type = 'media'
                )
                OR (
                    staging.modalidad_de_violencia_otrAS = 'si'
                    AND modality.modality_type = 'others'
                )
            )
            AND NOT EXISTS (
                SELECT *
                FROM
                    calls_modality cm,
                    staging stg,
                    modality m
                WHERE
                    cm.call_id = stg.id
                    AND cm.modality_id = m.id
                LIMIT 1
            )
    );