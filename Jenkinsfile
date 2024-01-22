pipeline {
    agent any
    
    environment {
        ARTIFACTORY_URL = 'https://vrjorquerabackup.jfrog.io/artifactory'
        ARTIFACTORY_REPO = 'eva3-snapshot'
        ARTIFACTORY_TOKEN = 'eyJ2ZXIiOiIyIiwidHlwIjoiSldUIiwiYWxnIjoiUlMyNTYiLCJraWQiOiJHei1FNGVkaC1kdUNCa2Z5TFFPbnY0bjliWGlLdy0zTjkyeHE3NlY0V05RIn0.eyJzdWIiOiJqZmFjQDAxaG0xdDZ0bXo2NTM4MDRhNjF6ZHcxZ2E1L3VzZXJzL2NpYWRtaW4iLCJzY3AiOiJhcHBsaWVkLXBlcm1pc3Npb25zL2FkbWluIiwiYXVkIjoiKkAqIiwiaXNzIjoiamZmZUAwMWhtMXQ2dG16NjUzODA0YTYxemR3MWdhNSIsImlhdCI6MTcwNTM1MTEwMiwianRpIjoiYzk1OTg4M2QtMTRkMi00MjdjLTk5YzAtNDE5NmIwY2I3ZjYwIn0.ZnP2tMVX5Wsn68QCWjVaqtTLlnZGHFlHvELsDp6in9UEmBpGk0uvP0NXS54wJv8os0NnhqDadckLCc4j_jVdGB-cMaQAGESX5c-4Ham0S3cpsDNa60qW-ex-iDF-4TO18Y_iV38izmv5e0IVx9G6WL09qqkQfihpQLppA2tZ0k0bMdSQuTPePyvqG99VJsxG2zalHkKGHXLbbk1AjimrmFC9uW8bp_WoYxmqdSmDjQxzQ-6AMMP_jKDkpFosT4kXN1EPk8MJFCxXd4EOytbgGqKLzCx502jLCccPsKxO0B55AjykQvDP-26uVey9QLS7cF5o1dlVYlFStI9-1Te5rQ'
    }
    
    stages {
        stage('Checkout') {
            steps {
                // Clonar repositorio
                checkout scm
            }
        }
        
        stage('Build') {
            steps {
                // Compilar proyecto
                bat 'mvn clean install'
            }
        }
        
        stage('Generate WAR') {
            steps {
                // Generar archivo .WAR
                bat 'mvn package'
            }
        }

        stage('Publish to Artifactory') {
            steps {
                script {
                    def authHeader = "Authorization: Bearer ${ARTIFACTORY_TOKEN}"
                    def uploadSpec = '{ "files": [ { "pattern": "target/*.war", "target": "' + ARTIFACTORY_REPO + '/" } ] }'
                    def uploadUrl = "${ARTIFACTORY_URL}/${ARTIFACTORY_REPO}"
                    
                    bat """
                        echo ${uploadSpec} > uploadSpec.json
                        curl -X PUT -H "${authHeader}" -H "Content-Type: application/json" -d @uploadSpec.json "${uploadUrl}"
                    """
                }
            }
        }
    }
}
