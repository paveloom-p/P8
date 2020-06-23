ECHO/OFF

CREAT/TAB result_H.tbl
COPY/TT var.tbl :data      result_H.tbl :data
COPY/TT var.tbl :magnitude result_H.tbl :magn_var

COPY/TT st1.tbl :magnitude result_H.tbl :magn_st1
COPY/TT st2.tbl :magnitude result_H.tbl :magn_st2

COMPUTE/TABLE result_H :delta1 = :magn_st1 - 7.80
COMPUTE/TABLE result_H :delta2 = :magn_st2 - 8.01
COMPUTE/TABLE result_H :delta = ( :delta1 + :delta2 ) / 2

COMPUTE/TABLE result_H :vis_mag = :magn_var - :delta
COMPUTE/TABLE result_H :vis_st1 = :magn_st1 - :delta
COMPUTE/TABLE result_H :vis_st2 = :magn_st2 - :delta
