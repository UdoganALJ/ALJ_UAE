namespace ALJUAE;

permissionset 63200 ALJUAEFullAccess
{
    Caption = 'ALJ UAE Full Access';
    Assignable = true;
    Permissions = codeunit ALJCod_EnableALJExtension_UAE = X,
        codeunit ALJCod_ExtensionInst_UAE = X,
        tabledata ALJTab_VehicleStockMgt_UAE = RIMD,
        table ALJTab_VehicleStockMgt_UAE = X,
        codeunit ALJCod_VehicleStockMgt_UAE = X,
        page ALJPag_VehicleStockMgt_UAE = X;
}