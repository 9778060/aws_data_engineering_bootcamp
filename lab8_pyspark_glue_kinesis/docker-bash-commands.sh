aws ecr get-login-password \
        --region us-east-1 | docker login \
        --username AWS \
        --password-stdin {...}.dkr.ecr.us-east-1.amazonaws.com

docker build -t mobile-signal-app .

docker run -p 8501:8501 -v ${HOME}/.aws:/root/.aws mobile-signal-app

docker tag mobile-signal-app:latest {...}.dkr.ecr.us-east-1.amazonaws.com/streamlit-app:mobile-signal-app

docker push {...}.dkr.ecr.us-east-1.amazonaws.com/streamlit-app:mobile-signal-app