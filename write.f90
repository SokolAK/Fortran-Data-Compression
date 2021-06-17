program writePipe

    implicit none
    
    integer:: i,iostat,stat
    character(len=100):: instruction
    character(len=40):: instruction0
    character(len=20):: compressor, filename, lengthChar
    character(len=2):: level
    integer(kind=4):: length

    call get_command_argument(number=1, value=lengthChar, status=stat)
    call get_command_argument(number=2, value=compressor, status=stat)
    call get_command_argument(number=3, value=level, status=stat)
    read (lengthChar, '(I20)') length
    
    instruction0 = "cat NamedP1 | " // compressor // " " // level

    select case(compressor)
    case('pigz')
        filename = "data.gz"
    case('gzip')
        filename = "data.gz"
    case('lz4c')
        filename = "data.lz4"
    case('lzop')
        filename = "data.lzo"
    case default
        filename = "data"
        instruction0 = "cat NamedP1"
    end select

    instruction = instruction0 // " > " // filename // " &"
    !write(*,*) instruction


    call system("rm -f NamedP1; mkfifo NamedP1")
    call system(instruction)

    open(11,file="NamedP1",iostat=iostat)
    do i=1,length
        write(11,*) i
    end do  
    ! do i=1,200
    !   do j=i,200
    !     write(11,*)i,j,j*i
    !   end do
    ! end do

    call system("rm -f NamedP1")
    close(11)
    !close(11,iostat=iostat,status='DELETE') 

    instruction =  "echo -n 'Archive size: '; ls -lh " // filename // " | gawk '{print $5}'"
    call system(instruction)
    
end program writePipe