# Linux Install List
--------------------

### 1. 설치  전 리눅스 세팅

  - 우리가 사용할 계정은 'root'가 아닌 'hadoop'계정
  - hadoop계정 내에서 모든 설치를 진행할 예정


### 2. 프로그램 설치

#####  1) JDK_1.8.0_171 설치
  
  - Hadoop/Spark 등 우리가 빅데이터를 다루기 위해 가장 기본적으로 필요한 것이 JAVA이다. jar파일을 이용해야 하기 때문이다.
  
  - JDK 설치 경로 : /home/hadoop
     
  - 환경변수 설정 : /home/hadoop/.bashrc 
 
 ````javascript
 
 # Set JAVA_HOME
export JAVA_HOME=$HOME/jdk1.8.0_171
export PATH=$HOME/jdk1.8.0_171/bin:$PATH
export JRE_HOME=$HOME/jdk1.8.0_171/jre
export PATH=$PATH:$HOME/jdk1.8.0_171/jre/bin
export CLASSPATH="."

 ````
     
 
