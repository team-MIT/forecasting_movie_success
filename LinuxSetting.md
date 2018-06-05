# Linux Install List




## 1. 설치  전 리눅스 세팅

- Linux Version : CentOS 6.9

- 사용 IP : 171(Master), 172(Slave01), 173(Slave02)
 - /etc/hosts 파일 수정 ( 모든 서버에 아래 내용 적용 )
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
 - hdfs명령은 환경변수 설정을 해주거나 ./hadoop/bin/hdfs를 이용하여 실행하자. 또, hadoop패키지 이름이 길기 때문에 $ ln명령을 사용하여
 링크걸어주자 )
 
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
##### - yarn을 쓰는 이유 : https://www.popit.kr/what-is-hadoop-yarn/   


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
<!--     
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
        
-->        
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
$ yum -y install mysqld mysql-server
$ mysql mysql ( 이 명령어의 의미는 mysql이름을 가진 database로 접속하겠다는 의미이고, 접속계정은 hadoop@localhost가 된다.
  계정이나 호스트를 변경하고 싶다면 -h 나 -u를 통해서 명령어에 추가하면 된다. 첫 접속은 비밀번호를 필요로 하지 않기 때문에 
  $ mysql mysql명령을 통해 mysql데이터베이스로 접속한다. )

mysql> show database; ( mysql데이터베이스가 있는 것을 확인할 수 있다. )
mysql> use mysql;
mysql> select user , host , password from user;
+--------+---------------+-------------------------------------------+
| user   | host          | password                                  |
+--------+---------------+-------------------------------------------+
| root   | localhost     | ***************************************** |
| root   | master        |                                           |
| root   | 127.0.0.1     |                                           |
|        | localhost     |                                           |
|        | master        |                                           |
| root   | %             | ***************************************** |
| hadoop | %             | ***************************************** |
| hadoop | localhost     | ***************************************** |
| hadoop | 127.0.0.1     | ***************************************** |
| hadoop | 192.168.1.171 | ***************************************** |
| hadoop | 192.168.1.172 | ***************************************** |
| hadoop | 192.168.1.173 | ***************************************** |
+--------+---------------+-------------------------------------------+

( 위의 화면은 내가 접근 가능한 계정을 추가하고 비밀번호를 설정한 것임. 위의 과정을 아래 명령어를 통해 수행하자. )

mysql> grant all privileges on *.* to 'hadoop'@'localhost' identified by '사용할 비밀번호';
mysql> grant all privileges on *.* to 'hadoop'@'%' identified by '사용할 비밀번호';
mysql> grant all privileges on *.* to 'hadoop'@'192.168.171' identified by '사용할 비밀번호';
mysql> grant all privileges on *.* to 'hadoop'@'192.168.172' identified by '사용할 비밀번호';
mysql> grant all privileges on *.* to 'hadoop'@'192.168.173' identified by '사용할 비밀번호';
mysql> grant all privileges on *.* to 'hadoop'@'master' identified by '사용할 비밀번호';
mysql> flush privileges


( %가 모든 호스트를 뜻하지만 잘 먹히지 않는 것 같아 IP주소를 일일이 추가해줌. 위의 과정이 끝나면
$ service mysqld restart를 통해 설정적용 )

$ mysql mysql -p   ( p명령을 통해 비밀번호 입력하여 접속할 수 있다. )
password : ~~

( 비밀번호 입력 후, 잘 접속이 되면 적용이 완료된 것이다. )

mysql> create database hadoop;
mysql> use hadoop;
mysql> create table test_table(name varchar(50) , age int , addr varchat(255));
mysql> insert into test_table values( "LYB", 24 , "SEOUL");
mysql> insert into test_table values( "KJW", 27 , "BUSAN");
mysql> insert into test_table values( "YTW", 27 , "BUSAN");
mysql> insert into test_table values( "KMS", 28 , "DAEJUN");
mysql> insert into test_table values( "YMS", 30 , "KANGNAM");
mysql> select * from hadoop.test_table  ( hadoop이름의 database내의 test_table을 뜻함 )


-------------------------------------------------------------------------------


$ wget http://ftp.plusline.de/mysql/Downloads/Connector-J/mysql-connector-java-5.1.46.tar.gz
$ tar -xvf mysql-connector-java-5.1.46.tar.gz
$ cd mysql-connector-java-5.1.46
$ cp mysql-connector-java-5.1.46 ~/hadoop/lib
$ cp mysql-connector-java-5.1.46 ~/jdk1.8.0_171/jre/lib/ext
$ cp $ cp mysql-connector-java-5.1.46 ~/spark-2.3.0-bin-hadoop2.7/jars


-------------------------------------------------------------------------------

위의 과정이 끝나면 #HOME/spark/conf/slaves파일을 수정한다 ( slaves파일은 반드시 master서버에서만 있어야 한다. )
slave01
slave02


-------------------------------------------------------------------------------

<< spark의 executor가 slave01,slave02에 있으므로, 실제 mysql에 접근될 곳은 slave01,slave02이다. 따라서, 적재할 서버의 설정과 table은 
모두 슬레이브 서버에서 설정하고 생성해주어야 한다. >>

$ sudo vi /etc/my.cnf


[mysqld]
datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock
user=mysql
collation-server=utf8_unicode_ci
init-connect='SET NAMES utf8'
character-set-server=utf8

[client]
default-character-set=utf8

[mysql]
default-character-set=utf8


# Disabling symbolic-links is recommended to prevent assorted security risks
#symbolic-links=0

[mysqld_safe]
log-error=/var/log/mysqld.log
pid-file=/var/run/mysqld/mysqld.pid


위의 설정을 통해 utf8로 변경해주어야 데이터 적재 시, 한글이 깨지지 않는 것을 볼 수 있다.


$ mysql hadoop -p
password : ___________

mysql> alter database hadoop default character set utf8;

mysql> show variables like 'c%'

+--------------------------+----------------------------+
| Variable_name            | Value                      |
+--------------------------+----------------------------+
| character_set_client     | utf8                       |
| character_set_connection | utf8                       |
| character_set_database   | utf8                       |
| character_set_filesystem | binary                     |
| character_set_results    | utf8                       |
| character_set_server     | utf8                       |
| character_set_system     | utf8                       |
| character_sets_dir       | /usr/share/mysql/charsets/ |
| collation_connection     | utf8_general_ci            |
| collation_database       | utf8_general_ci            |
| collation_server         | utf8_unicode_ci            |
| completion_type          | 0                          |
| concurrent_insert        | 1                          |
| connect_timeout          | 10                         |
+--------------------------+----------------------------+

mysql> status;

Connection id:		9
Current database:	hadoop
Current user:		root@localhost
SSL:			Not in use
Current pager:		stdout
Using outfile:		''
Using delimiter:	;
Server version:		5.1.73 Source distribution
Protocol version:	10
Connection:		Localhost via UNIX socket
Server characterset:	utf8
Db     characterset:	utf8
Client characterset:	utf8
Conn.  characterset:	utf8
UNIX socket:		/var/lib/mysql/mysql.sock
Uptime:			9 min 26 sec


<<<< utf8로 인코딩 설정이 되었는지 확인해보자 >>>>


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
## 클라이언트 응용프로그램에서 직접 변경하면 안된다.
spark.driver.memory             2g
spark.sql.catalogImplementation in-memory

# History Set
spark.history.provider            org.apache.spark.deploy.history.FsHistoryProvider
spark.history.fs.logDirectory     hdfs://master:9000/spark-logs
spark.history.fs.update.interval  10s
spark.history.ui.port             18080


spark.executor.instances                2
spark.executor.extraJavaOptions         -Dlog4j.configuration=file:///home/hadoop/spark/conf/log4j.properties
spark.executor.memory           1g

````


#### (3) start-all.sh 수정 ( spark )
##### - 우리는 이미 하둡의 start-all.sh를 사용하고 있기 때문에 스파크의 start-all.sh명령을 사용하기 위해서는
#####   해당 경로로 가서 실행해야 한다.
##### - 따라서, spark/sbin/start-all.sh 와 stop-all.sh의 내용을 복사하여 ~/hadoop/sbin/start-all.sh와 stop.sh하단에 붙여넣자.

````javascript
# ===================================================start-all.sh===========================================================

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


# ===================================================stop-all.sh===========================================================

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


#### (5) mysql과 spark의 연동 확인

````javascript

$ cd ~/spark/jars
$ pyspark --jars mysql-connector-java-5.1.46.jar
Python 2.6.6 (r266:84292, Aug 18 2016, 15:13:37) 
[GCC 4.4.7 20120313 (Red Hat 4.4.7-17)] on linux2
Type "help", "copyright", "credits" or "license" for more information.
Welcome to
      ____              __
     / __/__  ___ _____/ /__
    _\ \/ _ \/ _ `/ __/  '_/
   /__ / .__/\_,_/_/ /_/\_\   version 2.3.0
      /_/

Using Python version 2.6.6 (r266:84292, Aug 18 2016 15:13:37)
SparkSession available as 'spark'.

>>> df = sqlContext.read.format("jdbc").options(url="jdbc:mysql://localhost:3306/hadoop",driver="com.mysql.jdbc.Driver"\
,dbtable="test_table",user="root",password="우리비밀번호").load();

>>> df.show();
+------+------+-------------+
| name | age  | addr        |
+------+------+-------------+
| KJW  |   27 | SEOUL       |
| LYB  |   24 | GANGNAM     |
| YTW  |   27 | INCHEON     |
| YTW  |   28 | NOWON       |
| KMS  |   28 | NOWON       |
| YMS  |   30 | DONGINCHEON |
+------+------+-------------+

>>> df.registerTempTable("KJW");
>>> sqlContext.sql("select * from test_table where age <28").show();
+----+---+-------+
|name|age|   addr|
+----+---+-------+
| KJW| 27|  SEOUL|
| LYB| 24|GANGNAM|
| YTW| 27|INCHEON|
+----+---+-------+


````

#### (5) hdfs에 있는 대용량 txt을 가져와서 테이블형태로 삽입 후, 쿼리문 날려보기
 ##### * 중요한 Point
 - user의 접근권한을 grant를 사용하여 변경해주어야 한다.
 - slave01,slave02에 대용량 txt를 담을 테이블이 있어야 함 ( 칼럼명과 칼럼 타입이 일치해야 함 )
 - utf8적용이 되어있지 않으면 ????가 뜰 것이다.
  

````javascript
1) hdfs의 대용량 txt파일을 DataFrame으로 변환

$ pyspark
 >>> df=sqlContext.read.format('com.databricks.spark.csv').options(header='true',encoding='utf-8', delimiter=';').load('file:///home/hadoop/spark/examples/src/main/resources/people.csv')

2) DataFrame을 Mysql테이블에 적재

>>> df_props={'user':'root', 'password':'123456','driver':'com.mysql.jdbc.Driver'}
df.write.jdbc(url='jdbc:mysql://localhost:3306/hadoop', table='movie',mode='append', properties=df_props)

3) DataFrame

>>> jdbcDF=spark.read\
.format(“jdbc”)\
.option(“url”,”jdbc:msyql://localhost”)\
.option(“dbtable”,”hadoop.movie4”)\
.option(“user”,”hadoop”)\
.option(“password”,”123456”)\
.load()

4) Spark 내에서 SQL 쿼리문 작성해보기
>>> jdbcDF.createOrReplaceTempView(“movie”)
>>> director=spark.sql(“SELECT director from movie”)

5) 생성한 DataFrame을 하둡에 적재하기
>>> director.write.csv("/test")

6) 하둡에서 적재 확인하기.
$ hdfs dfs -ls /test
-rw-r--r--   2 hadoop supergroup          0 2018-05-17 00:32 /test/_SUCCESS
-rw-r--r--   2 hadoop supergroup      80134 2018-05-17 00:32 /test/part-00000-8cab6db5-24f0-4cfb-bec7-2cfc0ccdd0aa-c000.csv
````




### 4) Redis

#### (1) redis-3.0.3 설치

````javascript
$ wget http://download.redis.io/releases/redis-3.0.3.tar.gz
$ tar -xvf redis-3.0.3.tar.gz
$ rm -rf redis-3.0.3.tar.gz
$ cd redis-3.0.3
$ vi tests/integration/replication-psync.tcl
after 100으로 되어있는 것을 after 500으로 바꾼다.
$ make 
$ make install
$ make test
==> test error없이 잘 설치된 것임.

---------------------------------------redis-ml관련 ln인데 설치안할거면 아래명령은 실행안해도됨.--------------------------------------------
$ sudo yum -y install libatlas-base-dev
$ sudo yum install -y atlas-devel atlas-static
$ ln -s /usr/lib64/atlas/libatlas.a /usr/lib64/libatlas.a
$ ln -s /usr/lib64/atlas/libatlas.so /usr/lib64/libcblas.a

$ git clone https://github.com/RedisLabsModules/redis-ml.git
$ cd redis-ml/src
$ make

$ redis-server --loadmodule /path/to/redis-ml/src/redis-ml.so
````

#### (2)jedis / jedis-ml / spark-jedis-ml 설치


##### maven 설치
````javascript
$ cd /usr/local/src
$ wget http://www-us.apache.org/dist/maven/maven-3/3.5.3/binaries/apache-maven-3.5.3-bin.tar.gz
$ tar -xvf apache-maven-3.5.3-bin.tar.gz
$ rm -rf apache-maven-3.5.3-bin.tar.gz
$ mv ./apache-maven-3.5.3 ./apache-maven

$ cd /etc/profile.d/
$ vi maven.sh

# Apache Maven Environment Variables
# MAVEN_HOME for Maven 1 - M2_HOME for Maven 2
export M2_HOME=/usr/local/src/apache-maven
export PATH=${M2_HOME}/bin:${PATH}

$ chmod +x maven.sh
$ source /etc/profile.d/maven.sh
$ mvn --version
위의 mvn 명령이 먹히는지 확인해보자.

````




#### jedis설치
````javascript
#get and build jedis
$ cd ~
$ git clone https://github.com/xetorthio/jedis.git
$ cd jedis
$ mvn package -Dmaven.test.skip=true
위의 결과로 /home/hadoop/jedis/target/jedis-3.0.0-SNAPSHOT.jar가 생성되어있을 것이다.

````

#### (3) Redis more properly

````javascript
$ sudo mkdir /etc/redis
$ sudo mkdir /var/redis

$ cd $HOME/redis
$ utils/redis_init_script /etc/init.d/redis_6379
$ sudo vi /etc/init.d/redis_6379
$ sudo cp redis.conf /etc/redis/6379.conf

Create a directory inside /var/redis that will work as data and working directory for this Redis instance:
$ sudo mkdir /var/redis/6379

Set the pidfile to /var/run/redis_6379.pid (modify the port if needed):
$ vi /var/run/redis_6379.pid
 2852
 
Log Check:
$ vi /var/log/redis_6379.log

      1 2852:M 02 Jun 01:32:07.290 * Increased maximum number of open files         to 10032 (it was originally set to 1024).
      2                 _._                                                         
      3            _.-``__ ''-._                                                    
      4       _.-``    `.  `_.  ''-._           Redis 3.0.3 (00000000/0) 64         bit
      5   .-`` .-```.  ```\/    _.,_ ''-._                                          
      6  (    '      ,       .-`  | `,    )     Running in standalone mode
      7  |`-._`-...-` __...-.``-._|'` _.-'|     Port: 6379
      8  |    `-._   `._    /     _.-'    |     PID: 2852
      9   `-._    `-._  `-./  _.-'    _.-'                                          
     10  |`-._`-._    `-.__.-'    _.-'_.-'|                                         
     11  |    `-._`-._        _.-'_.-'    |           http://redis.io               
     12   `-._    `-._`-.__.-'_.-'    _.-'                                          
     13  |`-._`-._    `-.__.-'    _.-'_.-'|                                         
     14  |    `-._`-._        _.-'_.-'    |                                         
     15   `-._    `-._`-.__.-'_.-'    _.-'                                          
     16       `-._    `-.__.-'    _.-'                                              
     17           `-._        _.-'                                                  
     18               `-.__.-'                                                      
     19 
     20 2852:M 02 Jun 01:32:07.291 # Server started, Redis version 3.0.3
     
Finally add the new Redis init script to all the default runlevels using the following command:
$ sudo update-rc.d redis_6379 defaults


You are done! Now you can try running your instance with:
$ sudo /etc/init.d/redis_6379 start

````

#### (4) Spark Shell에서 Redis 연결하기

````javascript
$ spark-shell —jars spark-redis/target/spark-redis-0.3.2-jar-with-dependencies.jar, jedis/target/jedis-3.0.0-SNAPSHOT.jar --master local

$scala> import com.redislabs.provider.redis._
import com.redislabs.provider.redis._

$scala> val redisServerDnsAddress = "REDIS_ADDRESS"
redisServerDnsAddress: String = REDIS_ADDRESS

$scala> val redisPortNumber = 6379
redisPortNumber: Int = 6379

$scala> val redisPassword = "REDIS_PASSWORD"
redisPassword: String = REDIS_PASSWORD

$scala> val redisConfig = new RedisConfig(new RedisEndpoint(redisServerDnsAddress, redisPortNumber, redisPassword))
redisConfig: com.redislabs.provider.redis.RedisConfig = com.redislabs.provider.redis.RedisConfig@758d4aa9

````
