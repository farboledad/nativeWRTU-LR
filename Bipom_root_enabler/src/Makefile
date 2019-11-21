all: bipom_root_enabler

DEBUG = -ggdb #-O0
#override LDFLAGS += -lpthread -lcg

%.o: %.c
	$(CC) $(CFLAGS) $(DEBUG) -fPIC -Wall -Werror -I. -std=gnu99 -c $(<) -o $(@)

bipom_root_enabler: bipom_root_enabler.o
	$(CC) $(CFLAGS) -o $(@) $(^) $(LDFLAGS)
	chmod 700 bipom_root_enabler

clean:
	rm -f bipom_root_enabler *.o

.PHONY: all clean
	
