program readPipe

    implicit none
    
    integer:: i,io,iostat,stat
    character(len=20):: compressor
    character(len=100):: instruction
    
    call get_command_argument(number=1, value=compressor, status=stat)
    
    select case(compressor)
      case('pigz')
        instruction = "( cat data.gz | pigz -dc > NamedP2; echo \x4 > NamedP2 ) &"
      case('gzip')
        instruction = "( cat data.gz | gzip -dc > NamedP2; echo \x4 > NamedP2 ) &"
      case('lz4c')
        instruction = "( cat data.lz4 | lz4c -dc > NamedP2; echo \x4 > NamedP2 ) &"
      case('lzop')
        instruction = "( cat data.lzo | lzop -dc > NamedP2; echo \x4 > NamedP2 ) &"
      case default
        instruction = "( cat data > NamedP2; echo \x4 > NamedP2 ) &"
    end select

    !write(*,*) instruction


    call system("rm -f NamedP2; mkfifo NamedP2")
    call system(instruction)

    open(11,file="NamedP2",iostat=iostat)
    do
      read(11,*,iostat=io) i
      if(io/=0) then
        close(11)
        exit
      end if
      !write(*,*) i
    end do
    
    
    call system("rm -f NamedP2")
    close(11)
    
end program readPipe