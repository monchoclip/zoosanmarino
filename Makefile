.PHONY: up down open logs restart rebuild build-angular

up: build-angular
	docker-compose up -d --build
	@echo "⏳ Esperando que los servicios estén listos..."
	@sleep 10
	@$(MAKE) open

down:
	docker-compose down

rebuild: down build-angular
	docker-compose up -d --build
	@$(MAKE) open

restart:
	docker-compose restart
	@$(MAKE) open

logs:
	docker-compose logs -f

open:
	@echo "🌐 Abriendo navegador..."
	@open http://localhost:4200
	@open http://localhost:4200/api/weatherforecast

build-angular:
	@echo "🛠️ Compilando Angular en frontend..."
	cd frontend && npm install && npm run build -- --configuration=production
