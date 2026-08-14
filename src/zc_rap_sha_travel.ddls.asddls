@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZRAP_SHA_TRAVEL',
  semanticKey: [ 'TravelID' ]
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_RAP_SHA_TRAVEL
  provider contract transactional_query
  as projection on ZR_RAP_SHA_TRAVEL
  association [1..1] to ZR_RAP_SHA_TRAVEL as _BaseEntity on $projection.TravelID = _BaseEntity.TravelID
{

  key TravelID as TravelID,
  travel_uuid as travel_uuid,
  
  @ObjectModel.text.element: [ 'AgencyName' ]
  AgencyID,
  _Agency.Name as AgencyName,
  
  CustomerID,
  _Customer.FirstName as CustomerName,      //this will be visible only when you give this field in metadata extension as well
  
  BeginDate,
  EndDate,
  @Semantics: {
    amount.currencyCode: 'CurrencyCode'
  }
  BookingFee,
  @Semantics: {
    amount.currencyCode: 'CurrencyCode'
  }
  TotalPrice,
  @Consumption: {
    valueHelpDefinition: [ {
      entity.element: 'Currency', 
      entity.name: 'I_CurrencyStdVH', 
      useForValidation: true
    } ]
  }
  CurrencyCode,
  Description,
  OverallStatus,
  
  @Semantics.largeObject: {
                mimeType: 'MimeType',
                fileName: 'FileName',
                acceptableMimeTypes: [ 'image/png', 'image/jpeg' ],
                contentDispositionPreference: #ATTACHMENT
                }
  Attachment,

  MimeType,
  FileName,
  @Semantics: {
    user.createdBy: true
  }
  CreatedBy,
  @Semantics: {
    systemDateTime.createdAt: true
  }
  CreatedAt,
  @Semantics: {
    user.localInstanceLastChangedBy: true
  }
  LocalLastChangedBy,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  LocalLastChangedAt,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  LastChangedAt,
  _BaseEntity
}
