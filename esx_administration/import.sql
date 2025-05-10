CREATE TABLE `epyi_administration` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `type` VARCHAR(10),
    `date_unix` BIGINT,
    `data` LONGTEXT,
    `owner` VARCHAR(99)
);