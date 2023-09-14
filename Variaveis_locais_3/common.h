#ifndef COMMON_H

#define COMMON_H

struct guid_s {

  unsigned int   part1; // 4 

  unsigned short part2; // 2

  unsigned short part3; // 2

  unsigned char  part4[8]; // 8

}; // 16 bytes

typedef struct guid_s guid_t;


struct rfid_object_s {

  char   enabled; // 1 byte

  guid_t id; // 16 bytes

  short  pin; // 2 bytes

}; // 24 bytes

typedef struct rfid_object_s rfid_object_t;

void init_obj(rfid_object_t *obj, int base);
void init_pins(short pins[2][3]);

int compare_guid(guid_t *id1, guid_t *id2);
int find(guid_t *id);

#endif