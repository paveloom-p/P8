ECHO/OFF

CREAT/TAB result_J.tbl
COPY/TT var.tbl :data      result_J.tbl :data
COPY/TT var.tbl :magnitude result_J.tbl :magn_var

COPY/TT st1.tbl :magnitude result_J.tbl :magn_st1
COPY/TT st2.tbl :magnitude result_J.tbl :magn_st2

COMPUTE/TABLE result_J :delta1 = :magn_st1 - 8.71
COMPUTE/TABLE result_J :delta2 = :magn_st2 - 10.31
COMPUTE/TABLE result_J :delta = ( :delta1 + :delta2 ) / 2

COMPUTE/TABLE result_J :vis_mag = :magn_var + :delta
COMPUTE/TABLE result_J :vis_st1 = :magn_st1 + :delta
COMPUTE/TABLE result_J :vis_st2 = :magn_st2 + :delta
