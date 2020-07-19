# CLOUD-TASK-4


I have used my own created ami for WORDPRESS AND MYSQL .

[Setup  Procedure](https://github.com/raghav1674/INSTALL-CONFIGURE-WP-MYSQL-SERVER/blob/master/README.md)

## Perform task-3 with an additional feature to be added that is NAT Gateway to provide the internet access to instances running in the private subnet.

[Main.tf](https://github.com/raghav1674/CLOUD-TASK-4/blob/master/main.tf)

[Variable.tf](https://github.com/raghav1674/CLOUD-TASK-4/blob/master/variable.tf)


>SUBMODULES:


 [VPC.tf](https://github.com/raghav1674/CLOUD-TASK-4/blob/master/aws/vpc.tf)

 [Subnets.tf](https://github.com/raghav1674/CLOUD-TASK-4/blob/master/aws/subnets.tf)

 [EC2.tf](https://github.com/raghav1674/CLOUD-TASK-4/blob/master/aws/ec2.tf)

## Performing the following steps:

### 1.  Write an Infrastructure as code using terraform, which automatically create a VPC.


<img src="https://github.com/raghav1674/CLOUD-TASK-4/blob/master/snaps/vpc_aws.PNG">




### 2.  In that VPC we have to create 2 subnets:



    1.   public  subnet [ Accessible for Public World! ] 
    2.   private subnet [ Restricted for Public World! ]
    
  <img src="https://github.com/raghav1674/CLOUD-TASK-4/blob/master/snaps/subnet_aws.PNG">
    
    
### 3. Create a public facing internet gateway for connect our VPC/Network to the internet world and attach this gateway to our VPC.

<img src="https://github.com/raghav1674/CLOUD-TASK-4/blob/master/snaps/igw_aws.PNG">

### 4. Create  a routing table for Internet gateway so that instance can connect to outside world, update and associate it with public subnet.

<img src="https://github.com/raghav1674/CLOUD-TASK-4/blob/master/snaps/route_table_aws.PNG">

### 5.  Create a NAT gateway for connect our VPC/Network to the internet world  and attach this gateway to our VPC in the public network
         NOTE: NAT GATEWAY SHOULD BE CREATED IN THE PUBLIC SUBNET.
<img src="https://github.com/raghav1674/CLOUD-TASK-4/blob/master/snaps/nat_gateway.PNG">

### 6.  Update the routing table of the private subnet, so that to access the internet it uses the nat gateway created in the public subnet

<img src="https://github.com/raghav1674/CLOUD-TASK-4/blob/master/snaps/task_4_routes.PNG">
### 7.  Launch an ec2 instance which has Wordpress setup already having the security group allowing  port 80 sothat our client can connect to our wordpress site. 
### 8.  Launch an ec2 instance which has MYSQL setup already with security group allowing  port 3306 in private subnet so that our wordpress vm can connect with the same.
         
         Also attach the key to instance for further login into it.
    
  <img src="https://github.com/raghav1674/CLOUD-TASK-4/blob/master/snaps/security_groups.PNG">
         
### BASTION HOST:

A bastion host is a special-purpose computer on a network specifically designed and configured to withstand attacks. The computer generally hosts a single application, for example a proxy server, and all other services are removed or limited to reduce the threat to the computer.

<img src="https://github.com/raghav1674/CLOUD-TASK-4/blob/master/snaps/bositon_login.PNG">
        
        
    For Login we need to have key in the bastion host instance.
        
 <img src="https://github.com/raghav1674/CLOUD-TASK-4/blob/master/snaps/bositon_transfered_key.PNG">
 
 
 <img src="https://github.com/raghav1674/CLOUD-TASK-4/blob/master/snaps/bositon_success.PNG"    height="600">

        
### CREATING THE DATABASE FOR WORDPRESS AND THEN INSTALLATION OF WORDPRESS:

<img src="https://github.com/raghav1674/CLOUD-TASK-4/blob/master/snaps/database-created_user_forwp.PNG" >

<img src="https://github.com/raghav1674/CLOUD-TASK-4/blob/master/snaps/ALL_wp_sql_conn.PNG" >


<img src="https://github.com/raghav1674/CLOUD-TASK-4/blob/master/snaps/wordpress_connect.PNG" >

<img src="https://github.com/raghav1674/CLOUD-TASK-4/blob/master/snaps/wp_setup_done.PNG" >

<img src="https://github.com/raghav1674/CLOUD-TASK-4/blob/master/snaps/wordpress_set.PNG" >




<img src="https://github.com/raghav1674/CLOUD-TASK-4/blob/master/snaps/13_wp-sql.PNG" >

As we have enabled NAT Gateway so now SNATting can be done for mysql instance but DNAT not allowed.

<img src="https://github.com/raghav1674/CLOUD-TASK-4/blob/master/snaps/mysql_can_ping_to_google.PNG" >

#### WE CAN DESTROY THE WHOLE INFRASTRUCTURE USING ONE SINGLE COMMAND:

>terraform destroy

<img src="https://github.com/raghav1674/CLOUD-TASK-4/blob/master/snaps/type_yes_for_destory.PNG" >


<img src="https://github.com/raghav1674/CLOUD-TASK-4/blob/master/snaps/all_destroyed.PNG" >


<img src="https://github.com/raghav1674/CLOUD-TASK-4/blob/master/snaps/all_task_4_ec2_done_3.PNG" >


Note: Wordpress instance has to be part of public subnet so that our client can connect our site. 
mysql instance has to be part of private  subnet so that outside world can't connect to it.
Don't forgot to add auto ip assign and auto dns name assignment option to be enabled.


