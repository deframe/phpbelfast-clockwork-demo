<?php namespace App\Http\Controllers;

use App\Post;

class WelcomeController extends Controller {

	public function index()
	{
		$posts = Post::all();

		return view('welcome')->with(compact('posts'));
	}

}
