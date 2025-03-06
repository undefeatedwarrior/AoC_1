CLASS zaoc_ra_data_builder DEFINITION
 PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS fill_transaction_data.
    METHODS fill_master_data.
    METHODS flush.
ENDCLASS.



CLASS zaoc_ra_DATA_BUILDER IMPLEMENTATION.



  METHOD fill_master_data.
    DATA : lt_bp   TYPE TABLE OF zaoc_ra_bp,
           lt_prod TYPE TABLE OF zaoc_ra_product.

    APPEND VALUE #(
                    bp_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
                    bp_role = '01'
                    company_name = 'TACUM'
                    street = 'Victoria Street'
                    city = 'Kolkatta'
                    country = 'IN'
                    region = 'APJ'
                    )
                    TO lt_bp.
    APPEND VALUE #(
                    bp_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
                    bp_role = '01'
                    company_name = 'SAP'
                    street = 'Rosvelt Street Road'
                    city = 'Walldorf'
                    country = 'DE'
                    region = 'EMEA'
                    )
                    TO lt_bp.
    APPEND VALUE #(
                    bp_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
                    bp_role = '01'
                    company_name = 'Asia High tech'
                    street = '1-7-2 Otemachi'
                    city = 'Tokyo'
                    country = 'JP'
                    region = 'APJ'
                    )
                    TO lt_bp.
    APPEND VALUE #(
                    bp_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
                    bp_role = '01'
                    company_name = 'AVANTEL'
                    street = 'Bosque de Duraznos'
                    city = 'Maxico'
                    country = 'MX'
                    region = 'NA'
                    )
                    TO lt_bp.
    APPEND VALUE #(
                    bp_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
                    bp_role = '01'
                    company_name = 'Pear Computing Services'
                    street = 'Dunwoody Xing'
                    city = 'Atlanta, Georgia'
                    country = 'US'
                    region = 'NA'
                    )
                    TO lt_bp.
    APPEND VALUE #(
                    bp_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
                    bp_role = '01'
                    company_name = 'PicoBit'
                    street = 'Fith Avenue'
                    city = 'New York City'
                    country = 'US'
                    region = 'NA'
                    )
                    TO lt_bp.
    APPEND VALUE #(
                    bp_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
                    bp_role = '01'
                    company_name = 'TACUM'
                    street = 'Victoria Street'
                    city = 'Kolkatta'
                    country = 'IN'
                    region = 'APJ'
                    )
                    TO lt_bp.
    APPEND VALUE #(
                    bp_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
                    bp_role = '01'
                    company_name = 'Indian IT Trading Company'
                    street = 'Nariman Point'
                    city = 'Mumbai'
                    country = 'IN'
                    region = 'APJ'
                    )
                    TO lt_bp.

    APPEND VALUE #(
                     product_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
                     name = 'Blaster Extreme'
                     category = 'Speakers'
                     price = 1500
                     currency = 'INR'
                     discount = 3
                     )
                     TO lt_prod.
    APPEND VALUE #(
                    product_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
                    name = 'Sound Booster'
                    category = 'Speakers'
                    price = 2500
                    currency = 'INR'
                    discount = 2
                    )
                    TO lt_prod.
    APPEND VALUE #(
                    product_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
                    name = 'Smart Office'
                    category = 'Software'
                    price = 1540
                    currency = 'INR'
                    discount = 32
                    )
                    TO lt_prod.
    APPEND VALUE #(
                    product_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
                    name = 'Smart Design'
                    category = 'Software'
                    price = 2400
                    currency = 'INR'
                    discount = 12
                    )
                    TO lt_prod.
    APPEND VALUE #(
                    product_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
                    name = 'Transcend Carry pocket'
                    category = 'PCs'
                    price = 14000
                    currency = 'INR'
                    discount = 7
                    )
                    TO lt_prod.
    APPEND VALUE #(
                    product_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32( )
                    name = 'Gaming Monster Pro'
                    category = 'PCs'
                    price = 15500
                    currency = 'INR'
                    discount = 8
                    )
                    TO lt_prod.

    INSERT zaoc_ra_bp FROM TABLE @lt_bp.
    INSERT zaoc_ra_product FROM TABLE @lt_prod.
  ENDMETHOD.


  METHOD fill_transaction_data.
    DATA : o_rand    TYPE REF TO cl_abap_random_int,
           n         TYPE i,
           seed      TYPE i,
           lv_date   TYPE timestamp,
           lv_ord_id TYPE zats_xx_dte_id,
           lt_so     TYPE TABLE OF zaoc_ra_so_hdr,
           lt_so_i   TYPE TABLE OF zaoc_ra_so_item.

    seed = cl_abap_random=>seed( ).
    cl_abap_random_int=>create(
      EXPORTING
        seed = seed
        min  = 1
        max  = 7
      RECEIVING
        prng = o_rand
    ).
    GET TIME STAMP FIELD lv_date.

    SELECT * FROM zaoc_ra_bp INTO TABLE @DATA(lt_bpa).
    SELECT * FROM zaoc_ra_product INTO TABLE @DATA(lt_prod).

    DO 50 TIMES.
      lv_ord_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32(  ).
      n = o_rand->get_next( ).
      READ TABLE lt_bpa INTO DATA(ls_bp) INDEX n.
      APPEND VALUE #(
              order_id = lv_ord_id
              order_no = sy-index
              buyer = ls_bp-bp_id
              gross_amount = 10 * n
              currency_code = 'EUR'
              created_by = sy-uname
              created_on = lv_date
              changed_by = sy-uname
              changed_on = lv_date
       ) TO lt_so.
      DO 2 TIMES.
        READ TABLE lt_prod INTO DATA(ls_prod) INDEX n.
        APPEND VALUE #(
            item_id = cl_uuid_factory=>create_system_uuid( )->create_uuid_c32(  )
            order_id = lv_ord_id
            product = ls_prod-product_id
            qty =  n
            uom = 'EA'
            amount =  n * ls_prod-price
            currency = ls_prod-currency
     ) TO lt_so_i.

      ENDDO.
    ENDDO.

    INSERT zaoc_ra_so_hdr FROM TABLE @lt_so.
    INSERT zaoc_ra_so_item FROM TABLE @lt_so_i.

  ENDMETHOD.


  METHOD flush.
    DELETE FROM : zaoc_ra_bp, zaoc_ra_product, zaoc_ra_so_hdr, zaoc_ra_so_item.
  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.
    flush( ).
    fill_master_data( ).
    fill_transaction_data(  ).
    out->write(
      EXPORTING
        data   = 'processing is completed successfully!'
*        name   =
*      RECEIVING
*        output =
    ).
  ENDMETHOD.
ENDCLASS.
