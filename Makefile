install:
	#install commands
	pip install --upgrade pip &&\
		pip install -r requirements.txt
format:
	#format code
	black *.py mylib/*.py 
lint:
	#flake8 or #pylint
	pylint --disable=R,C *.py mylib/*.py
test:
	#test
	python -m pytest -vv --cov=mylib --cov=main test_*.py
build:
	#build container
	docker build -t deploy-fastapi .
run:
		docker run -p 127.0.0.1:8080:8080 deploy-fastapi
deploy:
	#deploy
	aws ecr get-login-password --region ap-south-2 | docker login --username AWS --password-stdin 492901506671.dkr.ecr.ap-south-2.amazonaws.com
	docker build -t wiki .
	docker tag wiki:latest 492901506671.dkr.ecr.ap-south-2.amazonaws.com/wiki:latest
	docker push 492901506671.dkr.ecr.ap-south-2.amazonaws.com/wiki:latest
	
all: install lint test deploy