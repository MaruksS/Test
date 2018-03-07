Vides sagatavošana testa lapas izmantošanai

Vides sagatavošanas soļi:
1. Ieinstalēt Nginx web serveri (vai izmantot citu)
2. Ieinstalēt PHP (izmantota versija 7.0.25)
3. Ieinstalēt MySQL datubāzi
4. Atļaut web serverim izmantot PHP .
 To var panākt izmainot failu, kas atrodas  /etc/nginx/sites-available/default (izmantojot Nginx serveri).
Atverot failu ir jāpievieno index.php server sadaļā. 
Ka arī noņemt komentāru no daļas, kas apstrāda php pieprasījumus. Beigās šīm failam jāizskatās tā:


server {
	listen 80 default_server;
	listen [::]:80 default_server;
	root /var/www/html;

	index index.php index.html index.htm index.nginx-debian.html;
	location / {
		try_files $uri $uri/ =404;
	}
	location ~ \.php$ {
		include snippets/fastcgi-php.conf;
		fastcgi_pass unix:/run/php/php7.0-fpm.sock;
	}
	location ~ /\.ht {
		deny all;
	}
}


5. Ievietot testa lapas failus /var/www/html/test  mapē. 
6. connection.php failā ir nepieciešams noradīt mysql lietotāja vārdu un paroli lai piekļūtu tai
7. Piekļūt lapai caur http://localhost/test


