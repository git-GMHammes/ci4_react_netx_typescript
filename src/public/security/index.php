<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Security</title>
</head>

<body style="background-color: black; color: white;">
    <?php
    $dataBaseConfig1 = [
        'servidor' => 'mysql02-farm1.kinghost.net',
        'username' => 'habilida07_add4',
        'password' => 'Mi5tEri0',
        'database' => 'habilidade07',
        'DBDriver' => 'MySQLi',
        'port' => 3306,
    ];

    $dataBaseConfig2 = [
        'servidor' => encodeToBase64('mysql02-farm1.kinghost.net'),
        'username' => encodeToBase64('habilida07_add4'),
        'password' => encodeToBase64('Mi5tEri0'),
        'database' => encodeToBase64('habilidade07'),
        'DBDriver' => encodeToBase64('MySQLi'),
        'port' => encodeToBase64(3306),
    ];
    function encodeToBase64(string $data): string
    {
        return base64_encode($data);
    }
    function decodeFromBase64(string $base64Data)
    {
        return base64_decode($base64Data);
    }
    ?>
    <pre>
    <?php
    print_r($dataBaseConfig1);
    ?>
    </pre>
    <pre>
    <?php
    print_r($dataBaseConfig2);
    ?>
    </pre>
    <hr/>
    <?php
    echo encodeToBase64('Mi5tEri0@2022');
    ?>
    <hr/>
    <?php

    /**
     * Função que retorna o timestamp atual em formato MD5 e convertido para maiúsculas
     * 
     * @return string Timestamp em MD5 e em letras maiúsculas
     */
    function getTimestampMd5Uppercase()
    {
        $timestamp = time();
        $randomLetter = chr(rand(65, 90));
        $randomNumber = rand(0, 9);
        $timestamp = $timestamp . $randomLetter . $randomNumber;
        $md5Timestamp = md5($timestamp);
        $uppercaseResult = strtoupper($md5Timestamp);
        return $uppercaseResult;
    }
    ?>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
    <pre>
        <?= getTimestampMd5Uppercase(); ?>
    </pre>
</body>

</html>