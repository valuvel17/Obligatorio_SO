#include <stdio.h>     //para el print
#include <stdlib.h>    //funciones standard de c
#include <pthread.h>   //para manejar hilos
#include <semaphore.h> // para manejar semafotos

sem_t sem_ip_ed;
sem_t sem_m1_m2;
sem_t sem_f1_f2;
sem_t sem_ed_bd;
sem_t sem_ed_pa;
sem_t sem_m2_bigd;
sem_t sem_m2_pa;
sem_t sem_f2_rc;
sem_t sem_f2_cg;
sem_t sem_f2_ro;
sem_t sem_bd_bigd;
sem_t sem_bd_dw;
sem_t sem_bd_si;
sem_t sem_pa_aa;
sem_t sem_pa_ia;
sem_t sem_pa_is;
sem_t sem_pa_rc;
sem_t sem_pa_cg;
sem_t sem_pa_ro;
sem_t sem_rc_dw;
sem_t sem_rc_si;
sem_t sem_rc_so;
sem_t sem_si_cs;
sem_t sem_so_cs;
sem_t sem_so_sd;

void *imprimirIP(void *arg)
{
    printf("IP\n");
    sem_post(&sem_ip_ed); // Liberar dependencia de ED
}

void *imprimirM1(void *arg)
{
    printf("M1\n");
    sem_post(&sem_m1_m2); // Liberar dependencia de M2
}

void *imprimirF1(void *arg)
{
    printf("F1\n");
    sem_post(&sem_f1_f2); // Liberar dependencia de F2
}

void *imprimirED(void *arg)
{
    sem_wait(&sem_ip_ed); // Espera a que IP esté completada
    printf("ED\n");
    sem_post(&sem_ed_bd);
    sem_post(&sem_ed_pa);
    // Liberar dependencia de PA y BD
}

void *imprimirM2(void *arg)
{
    sem_wait(&sem_m1_m2); // Espera a que M1 esté completada
    printf("M2\n");
    sem_post(&sem_m2_bigd);
    sem_post(&sem_m2_pa);
    // Liberar dependencia de PA y BigData
}

void *imprimirF2(void *arg)
{
    sem_wait(&sem_f1_f2); // Espera a que F1 esté completada
    printf("F2\n");
    sem_post(&sem_f2_rc);
    sem_post(&sem_f2_cg);
    sem_post(&sem_f2_ro);
    // Liberar dependencia de RC y CG y RO
}

void *imprimirPA(void *arg)
{
    sem_wait(&sem_ed_pa); // Espera a que ED esté completada
    sem_wait(&sem_m2_pa); // Espera a que M2 esté completada
    printf("PA\n");
    sem_post(&sem_pa_aa);
    sem_post(&sem_pa_ia);
    sem_post(&sem_pa_is);
    sem_post(&sem_pa_rc);
    sem_post(&sem_pa_cg);
    sem_post(&sem_pa_ro);
    // Liberar dependencia de AA, IA, IS, RC, CG, RO
}

void *imprimirBD(void *arg)
{
    sem_wait(&sem_ed_bd); // Espera a que ED esté completada
    printf("BD\n");
    sem_post(&sem_bd_bigd);
    sem_post(&sem_bd_dw);
    sem_post(&sem_bd_si);
    // Liberar dependencia de SI, DW, BigData
}

void *imprimirRC(void *arg)
{
    sem_wait(&sem_pa_rc); // Espera a que PA esté completada
    sem_wait(&sem_f2_rc); // Espera a que F2 esté completada
    printf("RC\n");
    sem_post(&sem_rc_dw);
    sem_post(&sem_rc_si);
    sem_post(&sem_rc_so);
    // Liberar dependencia de SO, SI, DW
}

void *imprimirSO(void *arg)
{
    sem_wait(&sem_rc_so); // Espera a que RC esté completada
    printf("SO\n");
    sem_post(&sem_so_cs);
    sem_post(&sem_so_sd);
    // Liberar dependencia de SD y CS
}

void *imprimirIS(void *arg)
{
    sem_wait(&sem_pa_is); // Espera a que PA esté completada
    printf("IS\n");
}

void *imprimirSI(void *arg)
{
    sem_wait(&sem_rc_si); // Espera a que RC esté completada
    sem_wait(&sem_bd_si); // Espera a que BD esté completada
    printf("SI\n");
    sem_post(&sem_si_cs);
    // Liberar dependencia de CS
}

void *imprimirIA(void *arg)
{
    sem_wait(&sem_pa_ia); // Espera a que PA esté completada
    printf("IA\n");
}

void *imprimirCG(void *arg)
{
    sem_wait(&sem_pa_cg); // Espera a que PA esté completada
    sem_wait(&sem_f2_cg); // Espera a que F2 esté completada
    printf("CG\n");
}

void *imprimirDW(void *arg)
{
    sem_wait(&sem_bd_dw); // Espera a que BD esté completada
    sem_wait(&sem_rc_dw); // Espera a que RC esté completada
    printf("DW\n");
}

void *imprimirSD(void *arg)
{
    sem_wait(&sem_so_sd); // Espera a que SO esté completada
    printf("SD\n");
}

void *imprimirBIGD(void *arg)
{
    sem_wait(&sem_bd_bigd); // Espera a que BD esté completada
    sem_wait(&sem_m2_bigd); // Espera a que M2 esté completada
    printf("BIGD\n");
}

void *imprimirRO(void *arg)
{
    sem_wait(&sem_f2_ro); // Espera a que F2 esté completada
    sem_wait(&sem_pa_ro); // Espera a que PA esté completada
    printf("RO\n");
}

void *imprimirAA(void *arg)
{
    sem_wait(&sem_pa_aa); // Espera a que PA esté completada
    printf("AA\n");
}

void *imprimirCS(void *arg)
{
    sem_wait(&sem_si_cs); // Espera a que SI esté completada
    sem_wait(&sem_so_cs); // Espera a que SO esté completada
    printf("CS\n");
}

int main(int argc, char *argv[])
{
    /* -------------------------- Inicializo semaforos -------------------------- */

    sem_init(&sem_ip_ed, 0, 0);
    sem_init(&sem_m1_m2, 0, 0);
    sem_init(&sem_f1_f2, 0, 0);
    sem_init(&sem_ed_bd, 0, 0);
    sem_init(&sem_ed_pa, 0, 0);
    sem_init(&sem_m2_bigd, 0, 0);
    sem_init(&sem_m2_pa, 0, 0);
    sem_init(&sem_f2_rc, 0, 0);
    sem_init(&sem_f2_cg, 0, 0);
    sem_init(&sem_f2_ro, 0, 0);
    sem_init(&sem_bd_bigd, 0, 0);
    sem_init(&sem_bd_dw, 0, 0);
    sem_init(&sem_bd_si, 0, 0);
    sem_init(&sem_pa_aa, 0, 0);
    sem_init(&sem_pa_ia, 0, 0);
    sem_init(&sem_pa_is, 0, 0);
    sem_init(&sem_pa_rc, 0, 0);
    sem_init(&sem_pa_cg, 0, 0);
    sem_init(&sem_pa_ro, 0, 0);
    sem_init(&sem_rc_dw, 0, 0);
    sem_init(&sem_rc_si, 0, 0);
    sem_init(&sem_rc_so, 0, 0);
    sem_init(&sem_si_cs, 0, 0);
    sem_init(&sem_so_cs, 0, 0);
    sem_init(&sem_so_sd, 0, 0);

    /* -------------------------------------------------------------------------- */
    /* ---------------------------- Creacion de hilos --------------------------- */
    pthread_t t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15, t16, t17, t18, t19, t20; // voy a crear 20 hilos
    pthread_attr_t attr;
    pthread_attr_init(&attr);
    pthread_create(&t1, &attr, imprimirIP, NULL);
    pthread_create(&t2, &attr, imprimirM1, NULL);
    pthread_create(&t3, &attr, imprimirF1, NULL);
    pthread_create(&t4, &attr, imprimirED, NULL);
    pthread_create(&t5, &attr, imprimirM2, NULL);
    pthread_create(&t6, &attr, imprimirF2, NULL);
    pthread_create(&t7, &attr, imprimirBD, NULL);
    pthread_create(&t8, &attr, imprimirPA, NULL);
    pthread_create(&t9, &attr, imprimirBIGD, NULL);
    pthread_create(&t10, &attr, imprimirSD, NULL);
    pthread_create(&t11, &attr, imprimirAA, NULL);
    pthread_create(&t12, &attr, imprimirIA, NULL);
    pthread_create(&t13, &attr, imprimirIS, NULL);
    pthread_create(&t14, &attr, imprimirRC, NULL);
    pthread_create(&t15, &attr, imprimirCG, NULL);
    pthread_create(&t16, &attr, imprimirRO, NULL);
    pthread_create(&t17, &attr, imprimirDW, NULL);
    pthread_create(&t18, &attr, imprimirSI, NULL);
    pthread_create(&t19, &attr, imprimirSO, NULL);
    pthread_create(&t20, &attr, imprimirCS, NULL);
    /* -------------------------------------------------------------------------- */
    /* ----- Espero a que terminen todos los hilos para terminar el programa ---- */
    pthread_join(t1, NULL);
    pthread_join(t2, NULL);
    pthread_join(t3, NULL);
    pthread_join(t4, NULL);
    pthread_join(t5, NULL);
    pthread_join(t6, NULL);
    pthread_join(t7, NULL);
    pthread_join(t8, NULL);
    pthread_join(t9, NULL);
    pthread_join(t10, NULL);
    pthread_join(t11, NULL);
    pthread_join(t12, NULL);
    pthread_join(t13, NULL);
    pthread_join(t14, NULL);
    pthread_join(t15, NULL);
    pthread_join(t16, NULL);
    pthread_join(t17, NULL);
    pthread_join(t18, NULL);
    pthread_join(t19, NULL);
    pthread_join(t20, NULL);

    /* -------------------------------------------------------------------------- */
    return 0;
}