CLASS zcl_dg_zrap_sha_travel DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES : if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_dg_zrap_sha_travel IMPLEMENTATION.

method if_oo_adt_classrun~main.

data: it_sha_travel type table of zrap_sha_travel.

select * from /dmo/travel INTO CORRESPONDING FIELDS OF table @it_sha_travel UP TO 100 ROWS.

INSERT zrap_sha_travel FROM TABLE @it_sha_travel.

IF sy-subrc eq 0.

    out->write(

        EXPORTING
            data  = 'data successfully inserted'
    ).

ENDIF.

endmethod.

ENDCLASS.
