#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <libcg/cg_general.h>

int main (int argc, char *argv[])
{
	cg_status_t ret;
	int status = EXIT_FAILURE;
	char *password = NULL;
	password = strdup("CG_master_bipom123");
	int option = FALSE;

	if ( argc == 2 ){
		if ( atoi(argv[1]) == 1 ){
			option = TRUE;
		}
	}
	
	if (option == TRUE){
		printf("Enabling root access\n");
	}
	else{
		printf("Disabling root access\n");
	}

	if ((ret = cg_init("Bipom_root_enabler")) != CG_STATUS_OK) {
		cg_system_log(CG_LOG_ERR, "cg_init failed with status %d", ret);
		exit(status);
	}

	if ((ret = cg_set_dev_mode(option, CG_DEV_ROOT_ACCESS, password)) != CG_STATUS_OK) {
		cg_system_log(CG_LOG_ERR, "cg_set_dev_mode failed with status %d", ret);
		goto error;
	}

	status = EXIT_SUCCESS;
error:
	cg_deinit();
	exit(status);
}

