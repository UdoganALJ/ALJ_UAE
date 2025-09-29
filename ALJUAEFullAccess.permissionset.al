namespace ALJUAE;

permissionset 63200 ALJUAEFullAccess
{
    Caption = 'ALJ UAE Full Access';
    Assignable = true;
    Permissions = codeunit ALJCod_EnableALJExtension_UAE = X,
        codeunit ALJCod_ExtensionInst_UAE = X;
}