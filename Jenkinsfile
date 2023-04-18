def imagetag='latest'
pipeline{
    agent none
    stages{
        stage('execute shell script')
    {
        agent {label 'docker-ubuntu'}

        steps{
            // Execute a shell script to get the latest docker image tag of apache/cloudstack-simulator
            sh 'chmod 777 $WORKSPACE/docker.sh'
        script{
            imagetag = sh  (script:  "$WORKSPACE/docker.sh apache/cloudstack-simulator | jq -r '.tags[0]' " , returnStdout: true ).trim()
         
            
        }
           echo "${imagetag}"
        
        }
            
        }
        stage ('pull the docker image')
        {
            agent {label 'docker-ubuntu'}
             steps{
               sh "docker run --name simulator -p 8081:5050 -v /tmp:/tmp -d apache/cloudstack-simulator:$imagetag"
               
                
             
               
            }
        }
        
       stage ('wait for management server to come up')
       {
           agent {label 'docker-ubuntu'}
           steps{
            echo 'Waiting 5 minutes for management server to come up'
            sh 'sleep 300' 
           }
        }
        
       stage ('Deploy the datacenter')
         {
            agent {label 'docker-ubuntu'}
             steps{
                 
               sh 'docker exec -t simulator python /root/tools/marvin/marvin/deployDataCenter.py -i /root/setup/dev/advanced.cfg'
       
            }
        }
        
        stage ('run the smoke tests')
       {
            agent {label 'docker-ubuntu'}
             steps{
                 
               sh 'docker exec -t simulator  nosetests -v --with-marvin   --marvin-config=setup/dev/advanced.cfg   --with-xunit   --xunit-file=xunit.xml   -a tags=advanced,required_hardware=false   --zone=Sandbox-simulator   --hypervisor=simulator    test/integration/smoke/test_vm_life_cycle.py'
               

             
               
            }
        }
    
        stage ('stop and remove the container')
         {
            aagent {label 'docker-ubuntu'}
             steps{
                 
               sh 'docker stop simulator'
               sh 'docker rm simulator'
               

             
               
            }
        }
        
    }
}
