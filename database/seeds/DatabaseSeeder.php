<?php

use Illuminate\Database\Seeder;
use Illuminate\Database\Eloquent\Model;

class DatabaseSeeder extends Seeder {

	/**
	 * Run the database seeds.
	 *
	 * @return void
	 */
	public function run()
	{
		Model::unguard();

		$postId = \DB::table('posts')->insertGetId([
			'title' => 'Lorem ipsum dolor sit amet',
			'summary' => 'Pro habeo doming denique no, mundi lucilius singulis eum te. At usu labore disputationi. Usu veri denique id. Utroque percipit cu pri. Pro no quidam propriae recteque.'
		]);

		\DB::table('comments')->insert([
			'post_id' => $postId,
			'content' => 'Nibh probo ridens te duo. Ne amet utinam vim. Quo accumsan salutatus in. Ne sensibus senserit has, debet inimicus id sea. Aliquid corrumpit pro ut, cu vim elitr everti habemus.'
		]);

		\DB::table('comments')->insert([
			'post_id' => $postId,
			'content' => 'Ex enim laoreet eam, vim alterum civibus in. Facer voluptaria qui et, altera ancillae pertinax ea sed. Vis aliquam utroque eu, vis eligendi sapientem ad. Qui idque contentiones definitionem ex. Mea no oblique deleniti. Eu vis brute reprimique.'
		]);

		\DB::table('comments')->insert([
			'post_id' => $postId,
			'content' => 'In ius eleifend accusamus. No assum sanctus labores usu, ut appetere expetenda rationibus vim. In has iuvaret maluisset efficiantur, ea quo bonorum minimum. Eu vel saepe iudicabit. Ad dolor utroque accumsan vim, eu mel sale consulatu molestiae.'
		]);

		\DB::table('posts')->insert([
			'title' => 'Ne quo ignota pericula laboramus',
			'summary' => 'Te euismod intellegat duo, cibo reformidans cum eu, sumo percipit at mea. Utinam numquam verterem ne vis, vel ex habeo moderatius, sumo nonumy nemore vel eu.'
		]);

		\DB::table('posts')->insert([
			'title' => 'Cu vel justo saepe facilisis, vis eu duis ridens',
			'summary' => 'Te usu suas numquam voluptaria, mei primis accusam eu. Nam cu augue suscipit petentium, vim epicurei corrumpit no, in elit antiopam mea. Nec velit constituam ut, at sit veniam populo elaboraret, harum quando fastidii mel et. Cetero perfecto vix in, sit quem iuvaret nusquam ne.'
		]);

		// $this->call('UserTableSeeder');
	}

}
