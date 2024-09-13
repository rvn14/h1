<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="ddr.css">
</head>

<body>

    <form id="form1" method="POST" action="register.php">
        <div>
        <label for="id" >ID</label>
        <input id="input" type="text" name="id" placeholder="id"><br>
        <span id="span1"></span>

        </div>

        <div>
        <label for="name" >Name</label>
        <input id="input" type="int" name="name" placeholder="name"><br>
        <span id="span1"></span>
        </div>

        <div>
        <label for="age">Age</label>
        <input id="input" type="text" name="age" placeholder="age"><br>
        <span id="span1"></span>
        
        </div>

        <div>
        <label for="email">Email</label>
        <input id="input" type="text" name="email" placeholder="email"><br>
        <span id="span1"></span>
        </div>

        <div>
        <button id="button1" type="submit" name="submit">Register</button>
        </div>

    </form>

</body>

</html>