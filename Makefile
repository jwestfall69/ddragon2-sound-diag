OBJS = obj/ddragon2_sound_diag.o \
       obj/error_addresses.o \
       obj/interrupt_handlers.o \
       obj/interrupt_vectors.o \
       obj/psub.o \
       obj/ram_tests.o

INC = include/ddragon2.inc include/error_addresses.inc

VASM = vasmz80_oldstyle
VASM_FLAGS = -Fvobj -chklabels -Iinclude -quiet
VLINK = vlink
VLINK_FLAGS = -brawbin1 -Tddragon2_sound_diag.ld
OUTPUT_DIR = bin
OBJ_DIR = obj
MKDIR = mkdir

$(OUTPUT_DIR)/ddragon2-sound-diag.bin: $(OBJ_DIR) $(OUTPUT_DIR) $(OBJS)
	$(VLINK) $(VLINK_FLAGS) -o $(OUTPUT_DIR)/ddragon2-sound-diag.bin $(OBJS)
	@echo
	@ls -l $(OUTPUT_DIR)/ddragon2-sound-diag.bin

$(OBJ_DIR)/%.o: %.asm $(INCS)
	$(VASM) $(VASM_FLAGS) -o $@ $<

$(OUTPUT_DIR):
	$(MKDIR) $(OUTPUT_DIR)

$(OBJ_DIR):
	$(MKDIR) -p $(OBJ_DIR)

clean:
	rm -f $(OUTPUT_DIR)/ddragon2-sound-diag.bin $(OBJ_DIR)/*.o