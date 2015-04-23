<!DOCTYPE html>
<html lang="en">
    <head>
        <title>31interactive VM Admin</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
    </head>
    <body style="margin-top: 25px; font-size: 16px">
        <div class="container">
            <div class="row">
                <div class="col-xs-12">
                    <div class="jumbotron" style="background: linear-gradient(#ddd, #fff)">
                        <h1>31interactive VM Admin</h1>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12 col-sm-10 col-sm-offset-1">
                    <p>The following tools are available for managing and viewing the status of this virtual machine:</p>
                    <ul style="font-size: 20px; margin-top: 20px">
                        <li><a href="./phpMyAdmin">phpMyAdmin</a></li>
                        <li><a href="./phpinfo">phpinfo()</a></li>
                        <li><a href="http://<?= $_SERVER['HTTP_HOST'] ?>:8025">Mailhog</a></li>
                        <li><a href="./apc">APC control panel</a></li>
                    </ul>
                    <hr style="margin: 30px 0 30px 0">
                    <p>To shell into this VM type <code>ssh <?= $_SERVER['HTTP_HOST'] ?></code> at a command prompt or within your SSH client and use username: <strong>vagrant</strong>, password: <strong>vagrant</strong>. If you need to use <em>sudo</em>, the root password is also <strong>vagrant</strong>.</p>
                    <hr style="margin: 30px 0 30px 0">
                    <p>The MySQL root user has been set up as username: <strong>root</strong>, password: <strong>root</strong>.</p>
                </div>
            </div>
        </div>
    </body>
</html>