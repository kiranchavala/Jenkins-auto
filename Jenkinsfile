pipeline {
  agent { dockerfile true }
  stages {
    stage('Test') {
      steps {
        sh '''
          python --version
          git --version
          curl --version
          python /root/tools/marvin/marvin/deployDataCenter.py -i /root/setup/dev/advanced.cfg
          
        '''
      }
    }
  }
}
