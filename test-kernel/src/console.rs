use core::fmt::{self, Write};
use crate::sbi::{console_getchar, console_putchar};

struct Stdout;

impl Write for Stdout {
    fn write_str(&mut self, s: &str) -> fmt::Result {
        for c in s.chars() {
            if c == '\n'{
                console_putchar('\r' as usize);
            }
            console_putchar(c as usize);
        }
        Ok(())
    }
}

pub fn print(args: fmt::Arguments) {
    Stdout.write_fmt(args).unwrap();
}

#[macro_export]
macro_rules! print {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::print(format_args!($fmt $(, $($arg)+)?));
    }
}

#[macro_export]
macro_rules! println {
    ($fmt: literal $(, $($arg: tt)+)?) => {
        $crate::console::print(format_args!(concat!($fmt, "\n") $(, $($arg)+)?))
    }
}

pub fn read_char(){
    println!("[test-kernel] input a char");
    loop{
        let c = console_getchar();
        println!("GetChar: [{}]\r",c as u8 as char);
        
    }
    
}