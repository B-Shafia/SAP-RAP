CLASS zcl_eml_demo_sha DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_eml_demo_sha IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


  "******Creating with EML*******

  TYPES : tt_create TYPE TABLE FOR CREATE zr_rap_sha_travel.

  DATA(lt_create_data) = VALUE tt_create( (
    %cid          = 'abc-001'    "mandatory to pass  only for create not for read/update. This is for RAP framework identification
    %is_draft     = if_abap_behv=>mk-off   "direct to active table
    TravelID      = '000006'               "manually providing ID
    AgencyID      = '070015'
    CustomerID    = '000001'
    Description   = 'First Test Trip'
    OverallStatus = 'O'
    %control-TravelID      = if_abap_behv=>mk-on
    %control-AgencyID      = if_abap_behv=>mk-on
    %control-CustomerID    = if_abap_behv=>mk-on
    %control-Description   = if_abap_behv=>mk-on
    %control-OverallStatus = if_abap_behv=>mk-on
    )
    (
    %cid          = 'abc-002'    "mandatory to pass
    %is_draft     = if_abap_behv=>mk-off   "direct to active table
    TravelID      = '000008'               "manually providing ID
    AgencyID      = '070015'
    CustomerID    = '000001'
    Description   = 'First Test Trip'
    OverallStatus = 'O'
    %control-TravelID      = if_abap_behv=>mk-on
    %control-AgencyID      = if_abap_behv=>mk-on
    %control-CustomerID    = if_abap_behv=>mk-on
    %control-Description   = if_abap_behv=>mk-on
    %control-OverallStatus = if_abap_behv=>mk-on

    ) ).


    "execute the create  "syntax same for create/ update/ delete (all 3 comes under Modify)
    MODIFY ENTITIES OF  zr_rap_sha_travel
        ENTITY ZrRapShaTravel
        CREATE FROM lt_create_data
        MAPPED DATA(lt_mapped)
        FAILED DATA(lt_failed)
        REPORTED DATA(lt_reported).



  "Check for errors and commit
  IF lt_failed IS INITIAL.

    COMMIT ENTITIES.       "you don't want this in beh. definition class but here in independent class, it is required

  ELSE.

  LOOP AT lt_reported-zrrapshatravel INTO DATA(ls_msg).
    OUT->write( ls_msg-%msg ).
  ENDLOOP.
  ENDIF.


******Reading with EML*******
*  "read operation,
*  "reading the data from table with the help of BO
*
*  READ ENTITIES OF zr_rap_sha_travel   "CDS name (BO name)
*    ENTITY ZrRapShaTravel               "entity (ctrl +space gives this)
*        FIELDS ( AgencyID CustomerID Description FileName ) "which fields
*        WITH VALUE #( ( TravelID = '2' %is_draft = if_abap_behv=>mk-on ) )  "put is_draft '00' "on when fetch data in draft
*        RESULT DATA(lt_travel_data)     "data will go in this
*        FAILED DATA(lt_failed_info)     " if no data found then it will show here
*        REPORTED DATA(lt_reported_msg).  "error message goes in this
*
*
*   "checking the impact:
*
*   IF lt_travel_data IS NOT INITIAL.
*
*   OUT->write( lt_travel_data ).  "display the data
*
*   ELSE.
*
*   OUT->WRITE( lt_reported_msg-zrrapshatravel ).  "display error message
*   OUT->WRITE( value #( lt_reported_msg-zrrapshatravel[ 1 ]-%msg optional ) ).
*
*   ENDIF.


  ENDMETHOD.
ENDCLASS.
