CLASS LHC_ZR_RAP_SHA_TRAVEL DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ZrRapShaTravel
        RESULT result,



      earlynumbering_create FOR NUMBERING
            IMPORTING entities FOR CREATE ZrRapShaTravel.


ENDCLASS.

CLASS LHC_ZR_RAP_SHA_TRAVEL IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.


  METHOD earlynumbering_create.

  if entities is NOT INITIAL.

    check entities[ 1 ]-TravelID is INITIAL.

  else.
    exit.
  endif.


  try.

  "with the help of number range object
  cl_numberrange_runtime=>number_get(
    EXPORTING
        nr_range_nr = '01'
        object      = '/DMO/TRV_M'
        quantity    = 1
    IMPORTING
        number      = data(lv_next_avail_number)
        returncode  = data(lv_rc)
        returned_quantity = data(lv_rq)
  ).

  catch cx_nr_object_not_found.
  catch cx_number_ranges.

  ENDTRY.

  loop at entities into data(ls_entity).

  ls_entity-%key-TravelID = lv_next_avail_number.    "key fields are there in %key

    APPEND value #( %cid = ls_entity-%cid
                    %is_draft = ls_entity-%is_draft
                    %key = ls_entity-%key ) to mapped-zrrapshatravel.

  endloop.



*  "direct from db table
*
*  "select the highest number from active DB
*
*  select max( travel_id ) from zrap_sha_travel into @data(lv_active_max).
*
*
*  "select the highest from draft table
*  select max( travelid ) from zrap_sha_trvel_d into @data(lv_draft_max).
*
*  "identify the highest occupied number
*
*
*  data(lv_max) = cond #( when lv_active_max > lv_draft_max then lv_active_max
*                         else lv_draft_max ).
*
*  "set the primary key
*  DATA(lv_sha) = conv int2( lv_max + 1 ).
*
*  loop at entities into data(ls_entity).
*
*  ls_entity-%key-TravelID = lv_sha.
*
*    APPEND value #( %cid = ls_entity-%cid
*                    %is_draft = ls_entity-%is_draft
*                    %key = ls_entity-%key ) to mapped-zrrapshatravel.
*
*  endloop.
*
*
*
*
*
 ENDMETHOD.

ENDCLASS.
