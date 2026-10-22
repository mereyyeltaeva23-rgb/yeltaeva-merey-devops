pipeline {
    agent any

    // Task 19 — Jenkins environment variables
    environment {
        STUDENT_NAME    = 'Merey'
        STUDENT_SURNAME = 'Yeltaeva'
        STUDENT_GROUP   = 'IT2-2301'
        STUDENT_ID      = '37603'
        IMAGE_NAME      = 'yeltaeva-merey-devops'
        CONTAINER_NAME  = 'yeltaeva-merey-container'
    }

    stages {
        stage('Checkout') {
            steps {
                // Download the source code from GitHub
                checkout scm
                echo "Student: ${STUDENT_NAME} ${STUDENT_SURNAME}"
                echo "Group: ${STUDENT_GROUP}"
                echo "Student ID: ${STUDENT_ID}"
                sh 'echo "Git commit used by Jenkins:" && git log -1 --oneline'
            }
        }

        stage('Build') {
            steps {
                // Prepare the project: make the script executable and run it
                sh 'chmod +x scripts/*.sh'
                sh './scripts/Yeltaeva_Merey_system.sh'
            }
        }

        stage('Test') {
            steps {
                sh '''
                    echo "Checking required files..."
                    test -f Yeltaeva_Merey_info.txt        && echo "OK: student info file exists"
                    test -f Dockerfile         && echo "OK: Dockerfile exists"
                    test -f docker-compose.yml && echo "OK: docker-compose.yml exists"
                    grep -q "Student ID: $STUDENT_ID" Yeltaeva_Merey_info.txt && echo "OK: Student ID is correct"
                    bash -n scripts/Yeltaeva_Merey_system.sh && echo "OK: bash script syntax is valid"
                    echo "All tests passed"
                '''
            }
        }

        stage('Docker Build') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$BUILD_NUMBER -t $IMAGE_NAME:latest .'
                sh 'docker images | grep $IMAGE_NAME'
            }
        }

        stage('Docker Run') {
            steps {
                sh '''
                    docker rm -f $CONTAINER_NAME 2>/dev/null || true
                    docker run -d --name $CONTAINER_NAME \
                        -e STUDENT_NAME=$STUDENT_NAME \
                        -e STUDENT_SURNAME=$STUDENT_SURNAME \
                        -e STUDENT_GROUP=$STUDENT_GROUP \
                        -e STUDENT_ID=$STUDENT_ID \
                        $IMAGE_NAME:latest
                    sleep 3
                    docker ps --filter name=$CONTAINER_NAME
                    echo "----- Container logs -----"
                    docker logs $CONTAINER_NAME
                    test "$(docker inspect -f '{{.State.Running}}' $CONTAINER_NAME)" = "true"
                '''
            }
        }
    }

    post {
        success { echo "Pipeline for ${STUDENT_SURNAME} ${STUDENT_NAME} finished successfully!" }
        failure { echo 'Pipeline failed — check the stage marked in red.' }
    }
}
