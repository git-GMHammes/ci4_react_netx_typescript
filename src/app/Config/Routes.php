<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
$routes->get('/', 'Home::index');

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
});