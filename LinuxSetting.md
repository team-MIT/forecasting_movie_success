# Linux Install List




## 1. 설치  전 리눅스 세팅


- 사용 IP : 171(Master), 172(Slave01), 173(Slave02)
 - /etc/host 파일 수정 ( 모든 서버에 적용 )
````javascript
127.0.0.1 localhost
192.168.1.171 master
192.168.1.172 slave01
192.168.1.173 slave02
````
 - 우리가 사용할 계정은 'root'가 아닌 'hadoop'계정 ( 따라서 $useradd hadoop을 통해 생성한다. )
 - hadoop계정 내에서 모든 설치를 진행할 예정
 - hadoop이 모든 서버에 접근 가능하게 방화벽을 해제시켜주어야 한다.
````javascript
$ service iptables stop
$ chkconfig iptables off
````




## 2. 프로그램 설치

###  1) JDK_1.8.0_171 설치
  
- Hadoop/Spark 등 우리가 빅데이터를 다루기 위해 가장 기본적으로 필요한 것이 JAVA이다. jar파일을 이용해야 하기 때문이다.
 - 모든 Linux서버에 Java설치를 한다.( 하둡의 클러스터링으로 인해 모든 서버에 Java가 필요하다 )
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
     
     
     
     
 ###  2) Hadoop-2.7.3
 
- 모든 리눅스 서버에 Hadoop을 설치
 - Hadoop이 모든 Slave서버에 인증없이 접근 가능하게 하기 위해 ssh 인증키를 등록해야 한다.
 - $ hdfs dfsadmin -safemode leave 명령어를 통해 안전모드를 제거하자 ( 강제종료 및 비정상 종료 시 하둡이 자동으로 안전모드로 돌입 
 - hdfs명령은 환경변수 설정을 해주거나 ./hadoop/bin/hdfs를 이용하여 실행하자. 또, hadoop패키지 이름이 길기 때문에 $ ln명령을 사용하여 링크걸어주자 )
 
 - ##### - https://www.popit.kr/what-is-hadoop-yarn/  를 통해 yarn의 역할에 대한 이해도를 높혀보자
   
     
#### (0) .bashrc 환경변수 설정

````javascript

#Set HADOOP

export HADOOP_HOME=$HOME/hadoop-2.7.3
export HADOOP_CONF_DIR=$HOME/hadoop-2.7.3/etc/hadoop
export HADOOP_MAPRED_HOME=$HOME/hadoop-2.7.3
export HADOOP_COMMON_HOME=$HOME/hadoop-2.7.3
export HADOOP_HDFS_HOME=$HOME/hadoop-2.7.3
export YARN_HOME=$HOME/hadoop-2.7.3
export PATH=$PATH:$HOME/hadoop-2.7.3/bin
export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin

````
   
   
* SSH 인증키 등록(Master)
 * hadoop 계정 접속
 * $ssh-keygen -t rsa
 * 위의 명령으로 생성된 키는 /home/hadoop/.ssh/경로에 있다.
 * id_rsa 는 개인키 / id_rsa.pub 는 공개키 
    
  
    
####    (1) Master 서버 : .ssh 디렉터리 설정 
````javascript

  $ ssh-keygen -t rsa
  $ cd ~/.ssh/ 
  $ cp ./id_rsa.pub ./authorized_keys
  $ chmod 755 ~/.ssh
  $ chmod 644 ~/.ssh/autorized_keys
  $ ssh-add
Could not open a connection to your authentication agent.
  $ eval $(ssh-agent)
  $ ssh-add
  

    
  * Slave서버의 권한 변경
    * slave01/slave02의 hadoop 계정 접속
    * master서버가 slave01/slave02의 .ssh에 접근할 수 있도록 권한 설정
    * chmod 755 ~/.ssh
  
  
  * master -> slave01/slave02 ( 인증키  복사 ) 
    * master 접속
    * $ cd ~/.ssh/
    * $ scp ./authorized_keys hadoop@slave01:~/.ssh/  ( 인증키 복사 )
    * $ scp ./authorized_keys hadoop@slave01:~/.ssh/
    * $ ssh hadoop@master date
    * $ ssh hadoop@slave01 date
    * $ ssh hadoop@slave02 date ( 다른 컴퓨터들과 연결하는 작업이다. )
   
````








#### (2) hadoop 환경 설정 

##### /home/hadoop/hadoop/etc/hadoop/hadoop-env.sh
````javascript

 export JAVA_HOME=${JAVA_HOME}
 export HADOOP_CONF_DIR=${HADOOP_CONF_DIR:-"/etc/hadoop"}

````



   
   




#### (3) Master(NameNode설정) : /home/hadoop/hadoop/etc/hadoop/hdfs-site.xml 
##### - 데이터 저장 경로 변경
##### - hdfs-site.xml 파일은 HDFS에서 사용할 환경 정보를 설정.
- Nadenode : Master서버 / Datanode : Slave서버 설치
 - /home/hadoop/hadoop-2.7.3/hdfs/namenode2와 datanode2는 각 Master와 Slave에 만들어준 디렉터리


````javascript

<configuration>
        <property>
                <name>dfs.replication</name>
                <value>2</value>
        </property>
        <property>
                <name>dfs.permissions</name>
                <value>false</value>
        </property>
        <property>
                <name>dfs.permissions.enabled</name>
                <value>false</value>
        </property>
        <property>
                <name>dfs.permissions.superusergroup</name>
                <value>supergroup</value>
        </property>
        <property>
                <name>dfs.namenode.name.dir</name>
                <value>/home/hadoop/hadoop-2.7.3/hdfs/namenode2</value>
        </property>
</configuration>

````








#### (4) Slave (DataNode설정) : /home/hadoop/hadoop/etc/hadoop/hdfs-site.xml 
##### - 데이터 저장 경로 변경
##### - hdfs-site.xml 파일은 HDFS에서 사용할 환경 정보를 설정.
````javascript

<configuration>
        <property>
                <name>dfs.replication</name>
                <value>2</value>
        </property>
        <property>
                <name>dfs.permissions</name>
                <value>false</value>
        </property>
        <property>
                <name>dfs.permissions.enabled</name>
                <value>false</value>
        </property>
        <property>
                <name>dfs.permissions.superusergroup</name>
                <value>supergroup</value>
        </property>
        <property>
                <name>dfs.datanode.data.dir</name>
                <value>/home/hadoop/hadoop-2.7.3/hdfs/datanode2</value>
        </property>
</configuration>

````









#### (5) Yarn 설정 : /home/hadoop/hadoop/etc/hadoop/yarn-site.xml 
##### - default설정을 하는게 맞지만 mapred-site.xml에서 yarn을 선택했기 때문.


````javascript

<configuration>          

     <!--Yarn Scheduler를 위한 NodeManager , ResourceManager 설정  -->

        <property>
                <name>yarn.nodemanager.aux-services</name>
                <value>mapreduce_shuffle</value>
        </property>
        <property>  
                <name>yarn.nodemanager.aux-services.mapreduce.shuffle.class</name>
                <value>org.apache.hadoop.mapred.ShuffleHandler</value>
        </property>
        <property>
                <name>yarn.resourcemanager.resource-tracker.address</name>
                <value>master:8025</value>
        </property>
        <property>
                <name>yarn.resourcemanager.scheduler.address</name>
                <value>master:8030</value>
        </property>
        <property>
                <name>yarn.resourcemanager.address</name>
                <value>master:8050</value>
        </property>
        
     <!-- Yarn의   최대 용량 할당 및  동적 메모리 할당 차단 -->
       <property>
                <name>yarn.scheduler.maximum-allocation-mb</name>
                <value>40960</value>
        </property>
        <property>
                <name>yarn.nodemanager.pmem-check-enabled</name>
                <value>false</value>
        </property>
        <property>
                <name>yarn.nodemanager.vmem-check-enabled</name>
                <value>false</value>
        </property>
</configuration>

````








#### (6) Master서버 지정 : /home/hadoop/hadoop/etc/hadoop/core-site.xml 

##### - core-site.xml 파일은 HDFS와 맵리듀스에서 공통적으로 사용할 환경정보 설정
##### - 로그파일, 네트워크 튜닝, I/O 튜닝, 파일 시스템 튜닝, 압축 등 하부 시스템 설정파일

````javascript

<configuration>
        <property>
                <name>hadoop.tmp.dir</name>
                <value>/home/hadoop/hadoop-2.7.3/tmp</value>
        </property>
        <property>
                <name>fs.default.name</name>
                <value>hdfs://master:9000</value>
                <description>juwon</description>
        </property>
</configuration>

````








#### (7) 맵리듀스에서 사용할 환경정보 설정 : /home/hadoop/hadoop/etc/hadoop/mapred-site.xml 


````javascript

<configuration>
        <property>
                <name>mapreduce.framework.name</name>
                <value>yarn</value>
        </property>
        <property>
                <name>mapreduce.jobhistory.address</name>
                <value>master:10020</value>
                <description>Host and Port for Job History Server(default 0.0.0.0:10020) </description>
        </property>
</configuration>

````


#### (8) 하둡의 Master와 Slave 설정 알리기
##### - /home/hadoop/hadoop/etc/hadoop/slaves와 masters 파일 추가 ( 모든 서버에 있어야 함 , masters파일은 master서버에만 있어도 될 듯)
````javascript
<masters>
master

<slaves>
slave01
slave02
````

#### (9) 하둡을 시작하기 전 작업
- $ hdfs namenode -format
 - $ start-all.sh  ( 이 명령을 실행했을 때 비밀번호 입력이 없다면, ssh적용이 잘 된 것 )
 - $ jps 명령을 통해 Namenode와 Datanode가 Master / Slave01,02에 잘 분배되어졌는지 확인할 것



***

### 3) Spark-2.3.0

- 모든 서버에 spark  설치
 - spark를 사용하는 이유는 in-memory 특징으로 인해 hive나 hadoop보다 빠른 장점이 있으며, Mapreduce의 복잡한 코드를 짧게 줄일 수 있다.
 - 스파크의 주요 데이터 추상화 객체(DataFrame)이 RDD로 변환하는 데 있어서 편리하다.
 - Python을 사용할 수 있는 장점이 있다.

#### (0) spark 설치 및 mysql 설치
- http://spark.apache.org/downloads.html

```javascript
$ tar -zxf spark-버전-bin-hadoop2.6.tgz
$ sudo mkdir -p /home/hadoop/spark
$ ln -s /home/hadoop/spark/ spark-1.6.0-bin-hadoop2.6 ( 심볼릭 링크 걸기 )
$ cp ~/spark/conf/log4j.properties.template ~/spark/conf/log4j.properties
$ vi ~/spark/conf/log4j.properties
  =>  INFO를 ERROR로 바꾸어주면 INFO정보는 나오지 않는다.
  
-------------------------------------------------------------------------------

$ wget http://ftp.plusline.de/mysql/Downloads/Connector-J/mysql-connector-java-5.1.46.tar.gz
$ tar -xvf mysql-connector-java-5.1.46.tar.gz
$ cd mysql-connector-java-5.1.46.tar.gz

이 디렉터리 내부에 있는 .jar파일을 /home/hadoop/hadoop/lib , /home/hadoop/spark/jars , /home/hadoop/jdk1.8.0_171/jre/lib/ext에 복사

````



#### (1) spark-env.sh 수정

##### - /home/hadoop/spark/conf/spark-env.sh
##### - spark-env.sh.template를 spark-env.sh로 복사 후 아래 코드로 

````javascript
export JAVA_HOME=$HOME/jdk1.8.0_171

export HADOOP_HOME=$HOME/hadoop-2.7.3
export HADOOP_CONF_DIR=$HOME/hadoop-2.7.3/etc/hadoop

export YARN_CONF_DIR=$HOME/hadoop-2.7.3/etc/hadoop

export SPARK_HOME=$HOME/spark-2.3.0-bin-hadoop2.7
export SPARK_CONF_DIR=$HOME/spark-2.3.0-bin-hadoop2.7/conf
export SPARK_MASTER_HOST=192.168.1.171
export SPARK_DAEMON_CLASSPATH="$SPARK_HOME/jars/mysql-connector-java-5.1.46.jar"

export SPARK_EXECUTOR_INSTANCE=5
export SPARK_EXECUTOR_MEMORY=4g
export SPARK_DRIVER_MEMORY=2g


````


#### (2) spark-defaults.conf 수정

##### - /home/hadoop/spark/conf/spark-defaults.conf
##### - 클러스터모드를 사용해야 하므로 설정내용도 달라야 한다.

````javascript

## 클러스터 매니저가 접속할 마스터 서버 URI
spark.master                    spark://master:7077
## Spark 이벤트를 기록할지의 여부, 응용 프로그램이 완료된 후 웹 UI를 재구성하는 데 유용
spark.eventLog.enabled          true
spark.eventLog.dir              file:///home/hadoop/spark/sparkEventLog
## 네트워크를 통해 전송되거나 직렬화 된 형식으로 캐시되어야 하는 객체를 직렬화하는 데 사용할 클래스
spark.serializer                org.apache.spark.serializer.KryoSerializer
## 드라이버 프로세스, 즉 SparkContext가 초기화되는 곳에 사용할 메모리 크기
## 클라이언트 응용프로그램에서 직접 변경하면ㅇ ㅏㄴ된다.
spark.driver.memory             2g

#YARN SET
spark.yarn.am.memory            1g
spark.executor.instances                2
spark.executor.extraJavaOptions         -Dlog4j.configuration=file:///home/hadoop/spark/conf/log4j.properties

````


#### (3) start-all.sh 수정 ( spark )
##### - 우리는 이미 하둡의 start-all.sh를 사용하고 있기 때문에 스파크의 start-all.sh명령을 사용하기 위해서는 해당 경로로 가서 실행해야 한다.
##### - 따라서, spark/sbin/start-all.sh 와 stop-all.sh의 내용을 복사하여 ~/hadoop/sbin/start-all.sh와 stop.sh하단에 붙여넣자.

````javascript
# ======================start-all.sh===========================

# Start all hadoop daemons.  Run this on master node.

echo "This script is Deprecated. Instead use start-dfs.sh and start-yarn.sh"

bin=`dirname "${BASH_SOURCE-$0}"`
bin=`cd "$bin"; pwd`

DEFAULT_LIBEXEC_DIR="$bin"/../libexec
HADOOP_LIBEXEC_DIR=${HADOOP_LIBEXEC_DIR:-$DEFAULT_LIBEXEC_DIR}
. $HADOOP_LIBEXEC_DIR/hadoop-config.sh

# start hdfs daemons if hdfs is present
if [ -f "${HADOOP_HDFS_HOME}"/sbin/start-dfs.sh ]; then
  "${HADOOP_HDFS_HOME}"/sbin/start-dfs.sh --config $HADOOP_CONF_DIR
fi

# start yarn daemons if yarn is present
if [ -f "${HADOOP_YARN_HOME}"/sbin/start-yarn.sh ]; then
  "${HADOOP_YARN_HOME}"/sbin/start-yarn.sh --config $HADOOP_CONF_DIR
fi

# Start all spark daemons.
# Starts the master on this node.
# Starts a worker on each node specified in conf/slaves

if [ -z "${SPARK_HOME}" ]; then
  export SPARK_HOME="$(cd "`dirname "$0"`"/..; pwd)"
fi

# Load the Spark configuration
. "${SPARK_HOME}/sbin/spark-config.sh"

# Start Master
"${SPARK_HOME}/sbin"/start-master.sh

# Start Workers
"${SPARK_HOME}/sbin"/start-slaves.sh

# ======================stop-all.sh===========================

# Stop all hadoop daemons.  Run this on master node.

echo "This script is Deprecated. Instead use stop-dfs.sh and stop-yarn.sh"

bin=`dirname "${BASH_SOURCE-$0}"`
bin=`cd "$bin"; pwd`

DEFAULT_LIBEXEC_DIR="$bin"/../libexec
HADOOP_LIBEXEC_DIR=${HADOOP_LIBEXEC_DIR:-$DEFAULT_LIBEXEC_DIR}
. $HADOOP_LIBEXEC_DIR/hadoop-config.sh

# stop hdfs daemons if hdfs is present
if [ -f "${HADOOP_HDFS_HOME}"/sbin/stop-dfs.sh ]; then
  "${HADOOP_HDFS_HOME}"/sbin/stop-dfs.sh --config $HADOOP_CONF_DIR
fi

# stop yarn daemons if yarn is present
if [ -f "${HADOOP_HDFS_HOME}"/sbin/stop-yarn.sh ]; then
  "${HADOOP_HDFS_HOME}"/sbin/stop-yarn.sh --config $HADOOP_CONF_DIR
fi


# Stop all spark daemons.
# Run this on the master node.

if [ -z "${SPARK_HOME}" ]; then
  export SPARK_HOME="$(cd "`dirname "$0"`"/..; pwd)"
fi

# Load the Spark configuration
. "${SPARK_HOME}/sbin/spark-config.sh"

# Stop the slaves, then the master
"${SPARK_HOME}/sbin"/stop-slaves.sh
"${SPARK_HOME}/sbin"/stop-master.sh


if [ "$1" == "--wait" ]
then
  printf "Waiting for workers to shut down..."
  while true
  do
    running=`${SPARK_HOME}/sbin/slaves.sh ps -ef | grep -v grep | grep deploy.worker.Worker`
    if [ -z "$running" ]
    then
      printf "\nAll workers successfully shut down.\n"
      break
    else
      printf "."
      sleep 10
    fi
  done
fi



````

#### (4) 환경변수 설정
##### - $~/.bashrc
````javascript
#Set SPARK_HOME
export SPARK_HOME=$HOME/spark
export PATH=$PATH:$SPARK_HOME/bin
export LD_LIBRARY_PATH=/home/hadoop/hadoop/lib/native:$LD_LIBRARY_PATH
#export SPARK_MAJOR_VERSION=2
export PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.4-src.zip:$PYTHONPATH
export PATH=$SPARK_HOME/python:$PATH
````

