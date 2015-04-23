<html>
	<head>
		<title>phpBelfast Clockwork demo</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap-theme.min.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/js/bootstrap.min.js"></script>
	</head>
	<body>
		<div class="container">
            <div class="jumbotron" style="margin-top: 25px">
                <h1>phpBelfast Clockwork demo</h1>
            </div>
            <ul class="list-unstyled">
                @foreach($posts as $post)
                    <li>
                        <h3>{{ $post->title }}</h3>
                        <p>{{ $post->summary }}</p>
                        <p><strong>{{ $post->comments->count() }} comments</strong></p>
                        <hr>
                    </li>
                @endforeach
            </ul>
		</div>
	</body>
</html>
