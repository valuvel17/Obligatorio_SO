#------------------------------FUNCIONES-----------------------------------------------------------------------------#
cargando() {
    puntos=""
    for i in {1..3}; do
        echo -ne "Cargando$puntos\r" 
        sleep 0.3 
        puntos+="."  
    done
}

registrarUsuario() {
    echo "Desea Registrarse (Y/N)"
    read resp 
    while ! [[ "$resp" == "Y" || "$resp" == "y" || "$resp" == "N" || "$resp" == "n" ]]; do
        echo "Seleccione opción válida"
        read resp
    done
    if [[ "$resp" == "N" || "$resp" == "n" ]]; then
        return 
    fi
    clear
	echo "Pantalla de Registro"

    echo -n "Ingrese nombre:"
    read nomU
	echo -ne "\033[F\033[K" 
    echo -n "Ingrese contraseña:"
    read contraU
	echo -ne "\033[F\033[K" 
    echo -n "Ingrese cedula:"
    read ciU
	echo -ne "\033[F\033[K" 
    echo -n "Ingrese telefono:"
    read telU
	echo -ne "\033[F\033[K" 
    echo -n "Ingrese fecha de nacimiento:"
    read fecNacU
	echo -ne "\033[F\033[K" 
    echo -n "Ingrese rol A-(administrador) C-(cliente)"
    read rolU
	echo -ne "\033[F\033[K" 
    while ! [[ "$rolU" == "A" || "$rolU" == "a" || "$rolU" == "C" || "$rolU" == "c" ]]; do
        echo -n "Rol inexistente. Seleccione rol válido: A-(administrador) C-(cliente): "
        read rolU
		echo -ne "\033[F\033[K" 
    done

    echo "Datos a Agregar:"
    echo "Nombre: $nomU"
    if [[ "$rolU" == "A" || "$rolU" == "a" ]]; then 
        echo "Rol: Administrador"
    else 
        echo "Rol: Cliente"
    fi
    echo "Cedula: $ciU"
    echo "Telefono: $telU"
    echo "Fecha de nacimiento: $fecNacU"
    echo ""

    echo "¿Desea agregar estos datos (Y/N)?"
    read respuesta
    while ! [[ "$respuesta" == "Y" || "$respuesta" == "y" || "$respuesta" == "N" || "$respuesta" == "n" ]]; do
        echo "Seleccione opción válida"
        read respuesta
    done
	sleep 0.5
    clear
	cargando
    if [[ "$respuesta" == "Y" || "$respuesta" == "y" ]]; then
        ciEnAdmin=$(grep "Cedula: $ciU" "registro_admin.txt")
        ciEnCliente=$(grep "Cedula: $ciU" "registro_cliente.txt")

        if [[ -z "$ciEnAdmin" && -z "$ciEnCliente" ]]; then
            if [[ "$rolU" == "A" || "$rolU" == "a" ]]; then
                echo "Cedula: $ciU Contrasena: $contraU" >> registro_admin.txt
                echo "Datos - $nomU - $telU - $fecNacU" >> registro_admin.txt
                echo "Se ha registrado a $nomU como Administrador correctamente"
                sleep 4
                clear
            else 
                echo "Cedula: $ciU Contrasena: $contraU" >> registro_cliente.txt
                echo "Datos - $nomU - $telU - $fecNacU" >> registro_cliente.txt
                echo "Se ha registrado a $nomU como Cliente correctamente"
                sleep 4
                clear
                return 
            fi
        else
            echo "Usuario ya existente"
            echo "Volver a intentar..."
            sleep 2
            registrarUsuario
        fi
    else 
        registrarUsuario
    fi
}

registarAdmin() {
    echo "Sin administradores."
    sleep 0.5
    echo "Registre administrador"
    sleep 0.5
    clear 
    echo "Pantalla de Registro"
    
    echo -n "Ingrese nombre: "
    read nom
    echo -ne "\033[F\033[K" 
    
    echo -n "Ingrese contraseña: "
    read contra
    echo -ne "\033[F\033[K"  
    
    echo -n "Ingrese cédula: "
    read ci
    echo -ne "\033[F\033[K"  


    echo -n "Ingrese teléfono: "
    read tel
    echo -ne "\033[F\033[K"  
    
    
    echo -n "Ingrese fecha de nacimiento: "
    read fecNac
    echo -ne "\033[F\033[K"  
    clear

    echo "Cedula: $ci Contrasena: $contra" >> registro_admin.txt
    echo "Datos - $nom - $tel - $fecNac" >> registro_admin.txt
    cargando
    echo "Se ha registrado a $nom como Administrador correctamente"
    sleep 1
    clear
}


funcionAdmin() {
	nombre=$1
	echo "Se ingresó como Administrador."
	echo "Bienvenido/a $nombre!"
    valida="true"
    while [ "$valida" = "true" ]; do
        echo "Seleccione Opción:"
        echo "1- Registrar Usuario"
        echo "2- Listar mascotas disponibles para adopción"    
        echo "3- Adoptar mascota"
        echo "4- Salir"
        read respuesta
        if [ "$respuesta" = "1" ]; then
            registrarUsuario
        elif [ "$respuesta" = "2" ]; then
            echo "Listando mascotas disponibles..."
        elif [ "$respuesta" = "3" ]; then
            echo "Proceso de adopción..."
        elif [ "$respuesta" = "4" ]; then
            valida="false"
        else 
            echo "Número inválido. Seleccione una opción correcta."
        fi
    done
}

#---------------------------------------------------------------------------------------------------------------------#

if ! [ -s registro_admin.txt ]; then
    clear
    registarAdmin
fi 
acceder="true"
ci=""
contra=""
clear
cargando
while [ "$acceder" = "true" ]; do
    clear
    echo "Ingrese cédula: "
    read ci
    while [ -z "$ci" ]; do
        echo "Cédula inválida, ingrese cédula: "
        read ci
    done
    
    sleep 0.3
    clear
    echo "Ingrese contraseña: "
    read contra
    sleep 0.3
	clear
	cargando
    # Obtener la contraseña y nombre de administrador
    contraValidaA=$(grep "Cedula: $ci Contrasena: " "registro_admin.txt" | awk -F " Contrasena: " '{print $2}')
    nombreAdmin=$(grep -A 1 "Cedula: $ci" "registro_admin.txt" | awk -F " - " '{print $2}' | xargs)
    
    # Obtener la contraseña y nombre de cliente
    contraValidaC=$(grep "Cedula: $ci Contrasena: " "registro_cliente.txt" | awk -F " Contrasena: " '{print $2}')
    nombreCliente=$(grep -A 1 "Cedula: $ci" "registro_cliente.txt" | awk -F " - " '{print $2}' | xargs)

    if [[ -z "$contraValidaA" && -z "$contraValidaC" ]] || [[ "$contraValidaA" != "$contra" && "$contraValidaC" != "$contra" ]]; then
        echo "Credenciales incorrectas. Vuelva a intentar."
        sleep 1
    fi
    
    if [ "$contraValidaA" = "$contra" ]; then
        funcionAdmin $nombreAdmin
        clear
        echo "Saliendo..."
        sleep 0.5
        clear            
    fi
    
    if [ "$contraValidaC" = "$contra" ]; then
		cargando
        echo "Se ingresó como Cliente."
        echo "Bienvenido $nombreCliente!"
        wait 2
        clear
        echo "Saliendo..."
        sleep 0.5
        clear    
    fi

    echo "¿Desea salir? (Y/N)"
    read respuesta
    while ! [[ "$respuesta" == "Y" || "$respuesta" == "y" || "$respuesta" == "N" || "$respuesta" == "n" ]]; do
        echo "Seleccione opción válida"
        read respuesta
    done
    if [[ "$respuesta" == "Y" || "$respuesta" == "y" ]]; then
        acceder="false"
    fi 
done
clear
