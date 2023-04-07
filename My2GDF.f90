PROGRAM Main
    IMPLICIT NONE
    character(100) :: jobFile = 'Job-1.inp'    ! default jobfile
    character(100) :: targetFile = 'module.gdf'! default targetfile
    INTEGER nPre, nNodes, nElements, i, j, k, l
    REAL :: translate                         ! max z coordinate
    REAL, DIMENSION(:, :),allocatable :: x
    INTEGER, DIMENSION(:, :),allocatable :: p
    CHARACTER(len=10) :: string = ' '
    CHARACTER(len=6) :: TIME = ' ' ! FOR TIME

    ! get possible filename input variable
    IF ( command_argument_count() .GT. 0 ) THEN
        IF (command_argument_count() .EQ. 2) THEN
            call get_command_argument(1, jobFile)
            call get_command_argument(2, targetFile)
        ELSE
            ERROR STOP 'WRONG INPUT VARIABLE'
        END IF
    END IF

    nPre = 0
    nNodes = 0
    nElements = 0

    ! get number of lines of pre nodes, number of nodes and number of elements
    open(unit=1, file=jobFile, action='read', status='old')
    DO WHILE(string .NE. '*Node')
        READ(1, *) string
        nPre = nPre + 1
    END DO
    DO WHILE(string .NE. '*Element')
        READ(1, *) string
        nNodes = nNodes + 1
    END DO
    DO WHILE(string .NE. '*End')
        READ(1, *) string
        nElements = nElements + 1
    END DO
    close(1)
    nNodes = nNodes - 1
    nElements = nElements - 1
    
    ! read coordinates and elements
    k = 0
    allocate(x(3, nNodes), p(4, nElements))
    open(unit=1, file=jobFile, action='read', status='old')
    DO i = 1, nPre
        READ(1, *)
    END DO
    DO i = 1, nNodes
        READ(1, *) k, (x(j, i), j = 1,3)
    END DO
    IF (k .NE. nNodes) ERROR STOP 'Wrong in reading nodes!'
    READ(1, *)
    DO i = 1, nElements
        READ(1, *) k, (p(j, i), j = 1,4)
    END DO
    IF (k .NE. nElements) ERROR STOP 'Wrong in reading elements!'
    close(1)

    ! write to target file
    translate = maxval(x(3, :))
    open(1, file = targetFile, action='write')
    call date_and_time(string, TIME)
    WRITE(1, *)   'GDF file Abaqus2GDF.exe by Duanxu from SJTU   ', string, time
    WRITE(1, *) 1, 9.80665000
    WRITE(1, *) 0,            0
    WRITE(1, *) nElements
    DO i = 1, nElements
        DO j = 1, 4
            k = p(j, i)
            WRITE(1, *) (x(l, k), l=1,2), x(3, k) - translate
        END DO
    END DO
    close(1)
END PROGRAM Main