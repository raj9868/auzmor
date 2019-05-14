**Ruby on Rails 5.2.2**

**Ruby 2.3.1**

**Installation**
- Install above version on ruby and ROR
- Install redis
- Install postgres

**Runing Code**
- Run redis-server
- Go to code folder and run bundle install to install all gems
- once all gems installed run server "rails s -p 3004"

**APIs**

- **/api/inbound/sms**

API: http://101.53.152.130:3004/api/inbound/sms

header: 

{
    "Content-Type" => "application/json",
    "username" => "azr3",
    "password" => "9LLV6I4ZWI"
}

body: 

{
    "from": "61871112946",
    "to": "61871112901",
    "text": "STOP\n"
}


curl :

curl -X POST \
  http://101.53.152.130:3004/api/inbound/sms -H 'Content-Type: application/json' -H 'Postman-Token: 14f51171-478a-4380-85af-311eab96a12e' -H 'cache-control: no-cache' -H 'password: 9LLV6I4ZWI' -H 'username: azr3' -d '{
	"from": "61871112946",
	"to": "61871112901",
	"text": "STOP\n"
}'

- **/api/outbound/sms**

API: http://101.53.152.130:3004/api/outbound/sms

header: 

{
    "Content-Type" => "application/json",
    "username" => "azr3",
    "password" => "9LLV6I4ZWI"
}

body: 

{
    "from": "61871112946",
    "to": "61871112901",
    "text": "STOP\n"
}


curl :

curl -X POST \
  http://101.53.152.130:3004/api/outbound/sms -H 'Content-Type: application/json' -H 'Postman-Token: 14f51171-478a-4380-85af-311eab96a12e' -H 'cache-control: no-cache' -H 'password: 9LLV6I4ZWI' -H 'username: azr3' -d '{
	"from": "61871112946",
	"to": "61871112901",
	"text": "STOP\n"
}'


