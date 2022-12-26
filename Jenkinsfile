pipeline {
    agent any
    stages {
         stage('Docker Build test image') {
            when {
                branch 'dev'
            }
            steps {
                sh 'docker build -t film-api-tests-image -f Dockerfile-Tests .'
            }
        }

        stage('Run tests') {
            when {
                branch 'dev'
            }
            steps {
                sh 'docker run -d --tty --network=host --name film-api-tests-container film-api-tests-image'
                sh 'docker exec -d film-api-tests-container sh -c "pytest -v --junitxml=result.xml"'
                sh 'rm -f result.xml'
                sh 'docker cp film-api-tests-container:/films_api/result.xml .'
                junit 'result.xml'
                archiveArtifacts artifacts: 'result.xml'
            }
        }
    }

    post {
        always {
            script {
                sh 'docker stop film-api-tests-container'
                sh 'docker rm film-api-tests-container'
                sh 'docker rmi film-api-tests-image'
            }
        }
    }
}

