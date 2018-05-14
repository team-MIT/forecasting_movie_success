# Linux Install List
--------------------

### 1. 설치  전 리눅스 세팅

  - 사용 IP : 171(Master), 172(Slave01), 173(Slave02)
  - 우리가 사용할 계정은 'root'가 아닌 'hadoop'계정
  - hadoop계정 내에서 모든 설치를 진행할 예정


### 2. 프로그램 설치

#####  1) JDK_1.8.0_171 설치
  
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
     
 #####  2) Hadoop-2.7.3
 
   - 모든 리눅스 서버에 Hadoop을 설치
   
   - Nadenode : Master서버 / Datanode : Slave서버 설치
   
   -/home/hadoop/hadoop-2.7.3/hdfs/namenode2와 datanode2는 각 Master와 Slave에 만들어준 디렉터리
   
#### < Master(NameNode설정) : /home/hadoop/hadoop/etc/hadoop/hdfs-site.xml >

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

### < Slave (DataNode설정) : /home/hadoop/hadoop/etc/hadoop/hdfs-site.xml >
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


### < Yarn 설정 : /home/hadoop/hadoop/etc/hadoop/yarn-site.xml >


````javascript
<configuration>          

     #Yarn Scheduler를 위한 NodeManager 

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

#####  2) JDK_1.8.0_171 설치
  
  - Hadoop/Spark 등 우리가 빅데이터를 다루기 위해 가장 기본적으로 필요한 것이 JAVA이다. jar파일을 이용해야 하기 때문이다.
  
  - 모든 Linux서버에 Java설치를 한다.( 하둡의 클러스터링으로 인해 모든 서버에 Java가 필요하다 )
 
  - JDK 설치 경로 : /home/hadoop
     
  - 환경변수 설정 : /home/hadoop/.bashrc 

