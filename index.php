<?php
if (isset($_SERVER['HTTP_HOST']) && $_SERVER['HTTP_HOST'] === 'habilidade.com') {
    //https://habilidade.com/ci4_react_netx_typescript/src/public
    $baseURL = $_SERVER['REQUEST_SCHEME'] . '://' . $_SERVER['HTTP_HOST'] . '/ci4_react_netx_typescript/src/public';
} else {
    $baseURL = $_SERVER['REQUEST_SCHEME'] . '://' . $_SERVER['HTTP_HOST'] . '/src/public';
}
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="refresh" content="2; URL=<?= $baseURL; ?>" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <h3>Redirect...</h3>
</body>

</html>