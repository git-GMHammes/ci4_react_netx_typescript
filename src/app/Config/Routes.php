<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
// $routes->get('/', 'Home::index');
$routes->addRedirect('/', '/home');
$routes->get('/home', 'Home::index');

# www/index.php/habilidade/anonymous/(:any)
$routes->group('habilidade', function ($routes) {
    # www/index.php/habilidade/anonymous/(:any)
    $routes->group('anonymous', function ($routes) {
        # www/index.php/habilidade/anonymous/api/(:any)
        $routes->group('api', function ($routes) {
            # www/index.php/habilidade/anonymous/api/obsolete/(:any)
            $routes->get('obsolete', 'SecurityMonitoring\ApiController::foolishness');
            $routes->get('obsolete/(:segment)', 'SecurityMonitoring\ApiController::foolishness/$1');
            $routes->get('obsolete/(:any)', 'SecurityMonitoring\ApiController::foolishness/$1');
            $routes->post('obsolete', 'SecurityMonitoring\ApiController::foolishness');
            $routes->post('obsolete/(:any)', 'SecurityMonitoring\ApiController::foolishness/$1');
        });
    });
    # www/index.php/habilidade/anonymous/(:any)
    $routes->group('vigilancia', function ($routes) {
        # www/index.php/habilidade/vigilancia/api/(:any)
        $routes->group('api', function ($routes) {
            # www/index.php/habilidade/vigilancia/api/salvar/(:any)
            $routes->get('salvar', 'SecurityMonitoring\ApiController::create_update');
            $routes->get('salvar/(:segment)', 'SecurityMonitoring\ApiController::create_update/$1');
            $routes->get('salvar/(:any)', 'SecurityMonitoring\ApiController::create_update/$1');
            $routes->post('salvar', 'SecurityMonitoring\ApiController::create_update');
            $routes->post('salvar/(:any)', 'SecurityMonitoring\ApiController::create_update/$1');
        });
    });
    # www/index.php/habilidade/gerenciamento/(:any)
    $routes->group('gerenciamento', function ($routes) {
        # www/index.php/habilidade/gerenciamento/usuario/(:any)
        $routes->group('usuario', function ($routes) {
            # www/index.php/habilidade/vigilancia/api/(:any)
            $routes->group('api', function ($routes) {
                # www/index.php/habilidade/gerenciamento/usuario/api/salvar/(:any)
                $routes->get('login', 'AccountManagement\ApiController::AccountLogin');
                $routes->get('login/(:segment)', 'AccountManagement\ApiController::AccountLogin/$1');
                $routes->get('login/(:any)', 'AccountManagement\ApiController::AccountLogin/$1');
                $routes->post('login', 'AccountManagement\ApiController::AccountLogin');
                $routes->post('login/(:any)', 'AccountManagement\ApiController::AccountLogin/$1');
            });
        });
    });
    # www/index.php/habilidade/usuario/(:any)
    $routes->group('usuario', function ($routes) {
        # www/index.php/habilidade/usuario/api/(:any)
        $routes->group('api', function ($routes) {
            # www/index.php/habilidade/usuario/api/salvar/(:any)
            $routes->get('salvar', 'AccountManagement\ApiController::create_update');
            $routes->get('salvar/(:segment)', 'AccountManagement\ApiController::create_update/$1');
            $routes->get('salvar/(:any)', 'AccountManagement\ApiController::create_update/$1');
            $routes->post('salvar', 'AccountManagement\ApiController::create_update');
            $routes->post('salvar/(:any)', 'AccountManagement\ApiController::create_update/$1');
            # www/index.php/habilidade/usuario/api/listar/(:any)
            $routes->get('listar', 'AccountManagement\ApiController::dbRead');
            $routes->get('listar/(:segment)', 'AccountManagement\ApiController::dbRead/$1');
            $routes->get('listar/(:any)', 'AccountManagement\ApiController::dbRead/$1');
            $routes->post('listar', 'AccountManagement\ApiController::dbRead');
            $routes->post('listar/(:any)', 'AccountManagement\ApiController::dbRead/$1');
        });
    });
});