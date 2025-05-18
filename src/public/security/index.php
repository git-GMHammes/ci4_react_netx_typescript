<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Security</title>
</head>

<body style="background-color: black; color: white;">
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