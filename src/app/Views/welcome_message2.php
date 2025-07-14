<?php
$get_base_url = $get_base_url ? $get_base_url : 'localhost';
$get_page_title = $get_page_title ? $get_page_title : 'React';
?>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8" />
    <title><?= $get_page_title ?></title>
    <!-- Bootstrap 5.3.3 CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>
    <div id="root" data-base-url="<?= $get_base_url ?>"
        data-img-next="<?= $get_base_url . 'assets/img/geral/next_js.jpg' ?>"
        data-img-react="<?= $get_base_url . 'assets/img/geral/react_js.png' ?>"
        data-img-flutter="<?= $get_base_url . 'assets/img/geral/flutter.png' ?>" data-title="<?= $get_page_title ?>"
        data-iframe-nextjs="<?= $get_base_url . 'observer/react' ?>"
        data-iframe-flutter="<?= $get_base_url . 'observer/flutter' ?>">
    </div>

    <!-- React 18 CDN -->
    <script src="https://cdn.jsdelivr.net/npm/react@18/umd/react.development.js" crossorigin></script>
    <script src="https://cdn.jsdelivr.net/npm/react-dom@18/umd/react-dom.development.js" crossorigin></script>
    <!-- Babel Standalone CDN -->
    <script src="https://cdn.jsdelivr.net/npm/@babel/standalone@7.23.9/babel.min.js"></script>
    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script type="text/babel">

        function App() {
            // Pegando os parâmetros do root div
            const rootDiv = document.getElementById('root');
            const imgNext = rootDiv.getAttribute('data-img-next');
            const imgReact = rootDiv.getAttribute('data-img-react');
            const imgFlutter = rootDiv.getAttribute('data-img-flutter');
            const titlePage = rootDiv.getAttribute('data-title');
            const iframeNextJS = rootDiv.getAttribute('data-iframe-nextjs');
            const iframeFlutter = rootDiv.getAttribute('data-iframe-flutter');

            return (
                <div className="container py-5">
                    <h1 className="mb-4 text-center">{titlePage}</h1>
                    <div className="row">

                        {/* Next JS */}
                        <div className="col-md-4 mb-4">
                            <div className="card h-100 shadow-sm">
                                <img src={imgNext} className="card-img-top" alt="Card 1" />
                                <div className="card-body">
                                    <h5 className="card-title">Next JS</h5>
                                    <div className="d-flex justify-content-center mb-2">
                                        <div className="p-2">
                                            <button
                                                type="button"
                                                className="btn btn-outline-primary mb-4"
                                                data-bs-toggle="modal"
                                                data-bs-target="#staticNext"
                                            >
                                                Next JS
                                            </button>
                                            <div
                                                className="modal fade"
                                                id="staticNext"
                                                data-bs-backdrop="static"
                                                data-bs-keyboard="false"
                                                tabIndex="-1"
                                                aria-labelledby="staticNextLabel"
                                                aria-hidden="true"
                                            >
                                                <div className="modal-dialog modal-xl">
                                                    <div className="modal-content">
                                                        <div className="modal-header">
                                                            <h1 className="modal-title fs-5" id="staticNextLabel">
                                                                Modal Next JS
                                                            </h1>
                                                            <button
                                                                type="button"
                                                                className="btn-close"
                                                                data-bs-dismiss="modal"
                                                                aria-label="Close"
                                                            ></button>
                                                        </div>
                                                        <div className="modal-body">
                                                            Next JS.<br />
                                                            <div className="iframe-container mt-4">
                                                                <iframe
                                                                    src={iframeNextJS}
                                                                    frameBorder="0"
                                                                    allowFullScreen
                                                                    className="w-100 border-0"
                                                                    style={{ minHeight: '400px' }}
                                                                >
                                                                </iframe>
                                                            </div>
                                                        </div>
                                                        <div className="modal-footer">
                                                            <button
                                                                type="button"
                                                                className="btn btn-secondary"
                                                                data-bs-dismiss="modal"
                                                            >
                                                                Fechar
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            {/* FIM Modal */}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        {/* React */}
                        <div className="col-md-4 mb-4">
                            <div className="card h-100 shadow-sm">
                                <img src={imgReact} className="card-img-top" alt="Card 2" />
                                <div className="card-body">
                                    <h5 className="card-title">React JS</h5>
                                    <div className="d-flex justify-content-center mb-2">
                                        <div className="p-2">
                                            <button
                                                type="button"
                                                className="btn btn-outline-primary"
                                                data-bs-toggle="modal"
                                                data-bs-target="#staticReact"
                                            >
                                                React JS
                                            </button>
                                            <div
                                                className="modal fade"
                                                id="staticReact"
                                                data-bs-backdrop="static"
                                                data-bs-keyboard="false"
                                                tabIndex="-1"
                                                aria-labelledby="staticReactLabel"
                                                aria-hidden="true"
                                            >
                                                <div className="modal-dialog modal-xl">
                                                    <div className="modal-content">
                                                        <div className="modal-header">
                                                            <h1 className="modal-title fs-5" id="staticReactLabel">
                                                                Modal React JS
                                                            </h1>
                                                            <button
                                                                type="button"
                                                                className="btn-close"
                                                                data-bs-dismiss="modal"
                                                                aria-label="Close"
                                                            ></button>
                                                        </div>
                                                        <div className="modal-body">
                                                            Este é o modal do React JS.<br />
                                                            <img src={imgReact} className="img-fluid mt-3" alt="React JS" />
                                                        </div>
                                                        <div className="modal-footer">
                                                            <button
                                                                type="button"
                                                                className="btn btn-secondary"
                                                                data-bs-dismiss="modal"
                                                            >
                                                                Fechar
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            {/* FIM Modal */}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        {/* Flutter */}
                        <div className="col-md-4 mb-4">
                            <div className="card h-100 shadow-sm">
                                <img src={imgFlutter} className="card-img-top" alt="Card 3" />
                                <div className="card-body">
                                    <h5 className="card-title">Flutter</h5>
                                    <div className="d-flex justify-content-center mb-2">
                                        <div className="p-2">
                                            <button
                                                type="button"
                                                className="btn btn-outline-primary"
                                                data-bs-toggle="modal"
                                                data-bs-target="#staticFlutter"
                                            >
                                                Flutter
                                            </button>
                                            <div
                                                className="modal fade"
                                                id="staticFlutter"
                                                data-bs-backdrop="static"
                                                data-bs-keyboard="false"
                                                tabIndex="-1"
                                                aria-labelledby="staticFlutterLabel"
                                                aria-hidden="true"
                                            >
                                                <div className="modal-dialog modal-xl">
                                                    <div className="modal-content">
                                                        <div className="modal-header">
                                                            <h1 className="modal-title fs-5" id="staticFlutterLabel">
                                                                Modal Flutter
                                                            </h1>
                                                            <button
                                                                type="button"
                                                                className="btn-close"
                                                                data-bs-dismiss="modal"
                                                                aria-label="Close"
                                                            ></button>
                                                        </div>
                                                        <div className="modal-body">
                                                            Flutter.<br />
                                                            <div className="iframe-container mt-4">
                                                                <iframe
                                                                    src={iframeFlutter}
                                                                    frameBorder="0"
                                                                    allowFullScreen
                                                                    className="w-100 border-0"
                                                                    style={{ minHeight: '400px' }}
                                                                >
                                                                </iframe>
                                                            </div>
                                                        </div>
                                                        <div className="modal-footer">
                                                            <button
                                                                type="button"
                                                                className="btn btn-secondary"
                                                                data-bs-dismiss="modal"
                                                            >
                                                                Fechar
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            {/* FIM Modal */}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            );
        }

        const root = ReactDOM.createRoot(document.getElementById('root'));
        root.render(<App />);

    </script>
</body>

</html>