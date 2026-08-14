@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption CDS for read only travel'
@Metadata.ignorePropagatedAnnotations: false
@VDM.viewType: #CONSUMPTION
@UI.headerInfo: {
    typeName: 'Travel',
    typeNamePlural: 'Travels'
    
}
@Search.searchable: true    //HANA or text search (mostly for character datatype)

define view entity zc_travel_sha as select from ZI_TRAVEL_SHA
{

    

    @UI.facet: [{ label: 'General Information for Travel ID',
                   id: 'GeneralInfo',
                   purpose: #STANDARD,
                   position: 10,
                   type: #IDENTIFICATION_REFERENCE }]
                   
    @UI.lineItem: [{position: 10 }]
    @UI.identification: [{ position: 10, label: 'Travel ID' }]
    @UI.selectionField: [{ position: 10 }]
    key TravelId,
    
    @UI.lineItem: [{position: 20, label: 'Agency Id' }]
    @UI.identification: [{position: 20, label: 'Agency Id' }]
    @UI.selectionField: [{ position: 20 }]
    AgencyId,
    
    @UI.lineItem: [{position: 30, label: 'Customer Id' }]
    @UI.identification: [{position: 30, label: 'Customer Id' }]
    @UI.selectionField: [{ position: 30 }]
    CustomerId,
    
    @UI.lineItem: [{position: 40, label: 'Begin Date' }]
    @UI.identification: [{position: 40, label: 'Begin Date' }]
    @UI.selectionField: [{ position: 40 }]
    BeginDate,
    @UI.lineItem: [{position: 50, label: 'End Date' }]
    EndDate,   
    @Semantics.amount.currencyCode: 'CurrencyCode'
    @UI.lineItem: [{position: 60, label: 'Booking fee' }]
    BookingFee,
    @UI.lineItem: [{position: 70, label: 'Currency Code' }]
    CurrencyCode,
    @UI.lineItem: [{position: 80, label: 'Description' }]
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.8
    Description,
    @UI.lineItem: [{position: 90, label: 'Status' }]
    @Search.defaultSearchElement: true
    Status
}
