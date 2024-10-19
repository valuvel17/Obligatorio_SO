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
    echo "¿Desea Registrar un Usuario? (Y/N)"
    read resp
    while ! [[ "$resp" == "Y" || "$resp" == "y" || "$resp" == "N" || "$resp" == "n" ]]; do
        echo "Seleccione opción válida"
        read resp
    done
    if [[ "$resp" == "N" || "$resp" == "n" ]]; then
        return
    fi
    clear
    echo "Pantalla de Registro de Usuarios"

    # Solicitar el nombre
    echo -n "Ingrese nombre: "
    read nomU
    while [ -z "$nomU" ]; do
        echo -ne "\033[F\033[K" # Borra la línea anterior
        echo "El nombre no puede estar vacío. Inténtalo de nuevo."
        echo -n "Ingrese nombre: "
        read nomU
    done

    # Solicitar la contraseña
    echo -n "Ingrese contraseña: "
    read contraU # -s para ocultar la entrada de la contraseña
    while [ -z "$contraU" ]; do
        echo -ne "\033[F\033[K" # Borra la línea anterior

        echo "La contraseña no puede estar vacía. Inténtalo de nuevo."
        echo -n "Ingrese contraseña: "
        read contraU # Volver a solicitar
    done

    # Solicitar la cédula
    echo -n "Ingrese cédula: "
    read ciU
    while ! [[ "$ciU" =~ ^[0-9]+$ ]]; do
        echo -ne "\033[F\033[K" # Borra la línea anterior
        echo "La cédula solo puede contener números. Inténtalo de nuevo."
        echo -n "Ingrese cédula: "
        read ciU
    done

    # Solicitar el teléfono
    echo -n "Ingrese teléfono: "
    read telU
    while ! [[ "$telU" =~ ^[0-9]+$ ]]; do
        echo -ne "\033[F\033[K" # Borra la línea anterior
        echo "El teléfono solo puede contener números. Inténtalo de nuevo."
        echo -n "Ingrese teléfono: "
        read telU
    done

    # Solicitar la fecha de nacimiento
    echo -n "Ingrese fecha de nacimiento (DD/MM/YYYY): "
    read fecNacU
    while [ -z "$fecNacU" ]; do
        echo -ne "\033[F\033[K" # Borra la línea anterior

        echo "La fecha de nacimiento no puede estar vacía. Inténtalo de nuevo."
        echo -n "Ingrese fecha de nacimiento (DD/MM/YYYY): "
        read fecNacU
    done

    # Solicitar el rol
    echo -n "Ingrese rol A-(administrador) C-(cliente): "
    read rolU
    while ! [[ "$rolU" == "A" || "$rolU" == "a" || "$rolU" == "C" || "$rolU" == "c" ]]; do
        echo -ne "\033[F\033[K" # Borra la línea anterior

        echo -n "Seleccione rol válido A-(administrador) C-(cliente): "
        read rolU
        clear
    done

    echo "Datos a Agregar:"
    echo "Nombre: $nomU"
    echo "Contrasena: " $contraU
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
                echo "Cedula: $ciU Contrasena: $contraU" >>registro_admin.txt
                echo "Datos - $nomU - $telU - $fecNacU" >>registro_admin.txt
                echo "Se ha registrado a $nomU como Administrador correctamente"
                sleep 1
                clear
            else
                echo "Cedula: $ciU Contrasena: $contraU" >>registro_cliente.txt
                echo "Datos - $nomU - $telU - $fecNacU" >>registro_cliente.txt
                echo "Se ha registrado a $nomU como Cliente correctamente"
                sleep 1
                clear
                return
            fi
        else
            echo "Usuario ya existente"
            echo "Volver a intentar..."
            sleep 1.5
            registrarUsuario
        fi
    else
        registrarUsuario
    fi
}

registrarMascota() {
    clear
    echo "¿Desea Registrar una Mascota? (Y/N)"
    read resp
    while ! [[ "$resp" == "Y" || "$resp" == "y" || "$resp" == "N" || "$resp" == "n" ]]; do
        echo "Seleccione opción válida"
        read resp
    done
    if [[ "$resp" == "N" || "$resp" == "n" ]]; then
        clear
        return
    fi
    clear
    cargando
    echo "Pantalla de Registro de Mascotas. (No se aceptan campos vacios)"

    echo -n "Ingrese numero identificador:"
    num=0
    read num
    echo -ne "\033[F\033[K"
    while ! [[ "$num" =~ ^[1-9][0-9]*$ ]] || grep -q "Datos: - $num" "registro_mascota.txt"; do
        if ! [[ "$num" =~ ^[1-9][0-9]*$ ]]; then
            echo "El numero debe ser positivo y no debe comenzar en 0"
            echo -n "Ingrese numero identificador:"
            read num
            echo -ne "\033[F\033[K"
            echo -ne "\033[F\033[K"
            echo -ne "\033[F\033[K"
        else
            echo "El numero ingresado esta utilizado"
            echo -n "Ingrese un nuevo numero identificador:"
            read num
            echo -ne "\033[F\033[K"
            echo -ne "\033[F\033[K"
            echo -ne "\033[F\033[K"
        fi
    done

    echo -n "Ingrese el tipo de mascota:"
    read tipo
    echo -ne "\033[F\033[K"
    echo -n "Ingrese el nombre:"
    read nom
    echo -ne "\033[F\033[K"
    echo -n "Ingrese el sexo:"
    read sexo
    echo -ne "\033[F\033[K"
    echo -n "Ingrese edad (Años):"
    read edad
    echo -ne "\033[F\033[K"
    contador=0
    while ! [[ "$edad" =~ ^[1-9][0-9]*$ && $edad > 0 ]]; do
        contador=$((contador + 1))
        if ! [[ "$edad" =~ ^[1-9][0-9]*$ ]]; then
            echo "La edad debe ser un numero positivo y no debe comenzar en 0"
            echo -n "Ingrese edad:"
            read edad
        elif [[ "$edad" -le 1 ]]; then
            echo "La mascota debe tener más de 1 año"
            echo -n "Ingrese edad:"
            read edad
        fi
    done

    if [ "$contador" -gt 0 ]; then
        echo "contador0"
    fi

    if [ -z "$nom" ] || [ -z "$num" ] || [ -z "$tipo" ] || [ -z "$sexo" ] || [ -z "$edad" ]; then
        echo "Hubieron datos vacios, volver a intentar (Y/N) : "
        read r
        if [[ "$r" == "Y" || "$r" == "y" ]]; then
            registrarMascota
        elif [ "$r" == "X" || "$r" == "x" ]; then
            funcionAdmin
        fi
    else
        echo -n "Ingrese descripcion: "
        read desc
        echo -ne "\033[F\033[K"
        echo -n "Ingrese fecha de ingreso (dd/mm/yyyy): "
        read fec
        echo -ne "\033[F\033[K"
        cargando
        echo "Datos a Agregar:"
        echo ""
        echo "Nombre: $nom"
        echo "Numero Identificador: $num"
        echo "Tipo: $tipo"
        echo "Sexo: $sexo"
        echo "Edad: $edad"
        echo "Descripcion: $desc"
        echo "Fecha de Ingreso: $fec"
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
            echo "Datos: - $num - $tipo - $nom - $sexo - $edad - $desc - $fec " >>registro_mascota.txt
            echo "Mascota registrada correctamente"
        else
            echo "Volver a intentar (y) o salir (x) : "
            read r
            if [[ "$r" == "Y" || "$r" == "y" ]]; then
                registrarMascota
            elif [ "$r" == "X" || "$r" == "x" ]; then
                funcionAdmin
            fi
        fi
    fi
}

listarMascotas(){
    clear
    if [ ! -s "registro_mascota.txt" ]; then
        echo "No hay mascotas registradas."
    else
        echo "Mascotas disponibles para adopción:"
        while IFS= read linea; do
            echo "$linea"
        done < "registro_mascota.txt"
    fi
    echo "Presione cualquier tecla para continuar..."
    read
    clear
}

adoptarMascota(){
    clear
    if [ ! -s "registro_mascota.txt" ]; then
        echo "No hay mascotas para adoptar"
        echo "Presione cualquier tecla para continuar..."
        read
        clear
    else
        echo "Mascotas disponibles para adopción:"
        while IFS= read -r linea; do
            # Extraer el ID y el nombre de cada línea
            id=$(echo "$linea" | awk -F " - " '{print $2}')
            nombre=$(echo "$linea" | awk -F " - " '{print $4}')
            echo "ID: $id - Nombre: $nombre"
        done < "registro_mascota.txt"
        echo ""
        echo "Ingrese el número de la mascota que va a adoptar:"
        read numAdopcion
        
        # Verificar si el número de mascota existe en el archivo
        mascota=$(grep "Datos: - $numAdopcion" "registro_mascota.txt")
        if [ -z "$mascota" ]; then
            clear
            echo "El ID no corresponde a ninguna mascota"
            echo "Presione cualquier tecla"
            read
            adoptarMascota
        else
            clear
            echo -n "Ingrese fecha de adopcion (dd/mm/yyyy): "
            read fecha
            echo "Usted ha adoptado la mascota con ID $numAdopcion exitosamente!"
            echo 
            echo "$mascota - Fecha de adopción: $fecha" >> adopciones.txt
            grep -v "Datos: - $numAdopcion" "registro_mascota.txt" > temp.txt && mv temp.txt registro_mascota.txt
        fi
        echo "Presione cualquier tecla para continuar..."
        read
        clear
    fi
}

registarAdmin() {
    echo "Sin administradores."
    sleep 1
    echo "Se registrara un Administrador con los siguientes datos: "
    echo "Nombre: admin"
    echo "Contrasena: admin"
    echo "Cedula: 12345678"
    echo "Telefono: 123456789"
    echo "Fecha de nacimiento: 00/00/0000"
    echo ""

    echo "Cedula: 12345678 Contrasena: admin" >>registro_admin.txt
    echo "Datos - admin - 123456789 - 00/00/0000" >>registro_admin.txt
    echo "Presione cualquier tecla para continuar"
    read
    clear
}

funcionAdmin() {
    nombre=$1
    valida="true"
    while [ "$valida" = "true" ]; do
        echo "Se ingresó como Administrador."
        echo "Bienvenido/a $nombre!"
        echo "Seleccione Opción:"
        echo "1- Registrar Usuario"
        echo "2- Registrar Mascota"
        echo "3- Listar mascotas disponibles para adopción"
        echo "4- Salir"
        read respuesta
        if [ "$respuesta" = "1" ]; then
            registrarUsuario
        elif [ "$respuesta" = "2" ]; then
            registrarMascota
        elif [ "$respuesta" = "3" ]; then
            listarMascotas
        elif [ "$respuesta" = "4" ]; then
            valida="false"
        else
            echo "Número inválido. Seleccione una opción correcta."
        fi
        clear
    done
}

funcionCliente() {
    clear
    nombre=$1
    echo "Se ingresó como Cliente."
    echo "Bienvenido/a $nombre!"
    valida="true"
    while [ "$valida" = "true" ]; do
        echo "Seleccione Opción:"
        echo "1- Listar mascotas disponibles para adopción"
        echo "2- Adoptar mascota"
        echo "3- Salir"
        read respuesta
        if [ "$respuesta" = "1" ]; then
            listarMascotas
        elif [ "$respuesta" = "2" ]; then
            adoptarMascota
        elif [ "$respuesta" = "3" ]; then
            valida="false"
        else
            clear
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
while [ "$acceder" = "true" ]; do
    clear
    cargando
    echo "Inicio de Sesion."
    echo -n "Ingrese cédula: "
    read ci
    echo -ne "\033[F\033[K"

    while [ -z "$ci" ]; do
        echo "Cédula inválida, ingrese cédula: "
        read ci
        echo -ne "\033[F\033[K"
    done

    sleep 0.3
    echo "Ingrese contraseña: "
    read contra
    while [ -z "$contra" ]; do
        echo "Ingrese contraseña valida (no vacia) : "
        read -s contra
    done

    echo -ne "\033[F\033[K"
    clear
    cargando

    # Obtener la contraseña y nombre de administrador
    contraValidaA=$(grep "Cedula: $ci Contrasena: " "registro_admin.txt" | awk -F " Contrasena: " '{print $2}')
    nombreAdmin=$(grep -A 1 "Cedula: $ci" "registro_admin.txt" | awk -F " - " '{print $2}' | xargs)

    # Obtener la contraseña y nombre de cliente
    contraValidaC=$(grep "Cedula: $ci Contrasena: " "registro_cliente.txt" | awk -F " Contrasena: " '{print $2}')
    nombreCliente=$(grep -A 1 "Cedula: $ci" "registro_cliente.txt" | awk -F " - " '{print $2}' | xargs)

    if [[ -z "$contraValidaA" && -z "$contraValidaC" ]] || [[ "$contraValidaA" != "$contra" && "$contraValidaC" != "$contra" ]]; then
        clear
        echo "Credenciales incorrectas."
        sleep 0.5
    fi

    if [ "$contraValidaA" = "$contra" ]; then
        funcionAdmin $nombreAdmin
        clear
        cargando
        sleep 0.5
        clear
    fi

    if [ "$contraValidaC" = "$contra" ]; then
        funcionCliente $nombreCliente
        clear
        cargando
        sleep 0.5
        clear
    fi

    echo "Y: Salir - N: Volver a Iniciar Sesion"
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
