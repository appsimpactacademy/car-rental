# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "https://ga.jspm.io/npm:bootstrap@5.3.2/dist/js/bootstrap.esm.js"
pin "@popperjs/core", to: "https://ga.jspm.io/npm:@popperjs/core@2.11.8/lib/index.js"
pin 'coreui', to: 'https://cdn.jsdelivr.net/npm/@coreui/coreui@5.0.2/dist/js/coreui.esm.js'
pin 'coreui-icons', to: 'https://cdn.jsdelivr.net/npm/@coreui/icons@3.0.1/dist/cjs/index.min.js'
pin "glightbox", to: "https://cdn.skypack.dev/glightbox"
