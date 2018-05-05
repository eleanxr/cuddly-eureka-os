.section ".text.startup"

.global _start
.global _get_stack_pointer
.global _exception_table
.global _enable_interrupts

_start:
    // Set up the exception vector table (ARM AR architecture 1.8.1 table B1-3
    ldr pc, _reset_h
    ldr pc, _undefined_instruction_vector_h
    ldr pc, _software_interrupt_vector_h
    ldr pc, _prefetch_abort_vector_h
    ldr pc, _data_abort_vector_h
    ldr pc, _unused_handler_h
    ldr pc, _interrupt_vector_h
    ldr pc, _fast_interrupt_vector_h

// Create a table to control the interrupt vector table addresses.
// If we didn't do this, the compiler would generate its own and
// we wouldn't be able to move the table to 0x0 on startup.
_reset_h:                        .word _reset_
_undefined_instruction_vector_h: .word undefined_instruction_vector
_software_interrupt_vector_h:    .word software_interrupt_vector
_prefetch_abort_vector_h:        .word prefetch_abort_vector
_data_abort_vector_h:            .word data_abort_vector
_unused_handler_h:               .word _reset_
_interrupt_vector_h:             .word interrupt_vector
_fast_interrupt_vector_h:        .word fast_interrupt_vector

_reset_:
    // Copy the vector table to the active table at 0x0000
    mov r0, #0x8000 // Load startup address into r0
    mov r1, #0x0000 // Load base vector table address into r1
    // Load the values from the vector table (at 0x8000 start) into r2-r9
    // Since we are using a table of constant addresses (the *_h labels, this
    // copies those addresses into r2-r9
    ldmia r0!,{r2, r3, r4, r5, r6, r7, r8, r9}
    // Store the vector table constant addresses in r2-r9 into 0x0
    stmia r1!,{r2, r3, r4, r5, r6, r7, r8, r9}
    // Now, r0 -> _reset_h. Load the handler addresses into r2-r9 from that
    // table to get the actual vector table addresses..
    ldmia r0!,{r2, r3, r4, r5, r6, r7, r8, r9}
    // Store the real vector table addresses to 0x0
    stmia r1!,{r2, r3, r4, r5, r6, r7, r8, r9}

    // Load the startup address into the sp (stack pointer)
    // register. On the ARM processor, this is 0x8000
    // ldr sp, =0x8000
    // Give ourselves 64MB of heap space before we start the stack.
    mov sp, #(64 * 1024 * 1024)
    // The rest of the startup function is in C. Run it.
    bl _cstartup

_inf_loop:
    b _inf_loop

_get_stack_pointer:
    // return the stack pointer
    str sp, [sp]
    ldr r0, [sp]
    // Return
    mov pc, lr

// Code to enable interrupts.
// See Section A1.1.3 of the ARM reference manual
// and A2.5 of the same for CPSR register information.
_enable_interrupts:
    mrs r0, cpsr
    bic r0, r0, #0x80
    msr cpsr_c, r0
    mov pc, lr
