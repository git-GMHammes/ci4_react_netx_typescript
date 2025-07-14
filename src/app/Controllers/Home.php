<?php

namespace App\Controllers;

class Home extends BaseController
{
    public function index(): string
    {
        $setView = [
            'get_page_title' => 'Next JS / React & Flutter',
            'get_base_url' => base_url(),
        ];
        return view('welcome_message2', $setView);
    }
}
