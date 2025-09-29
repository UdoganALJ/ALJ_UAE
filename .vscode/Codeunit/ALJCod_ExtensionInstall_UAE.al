codeunit 63200 ALJCod_ExtensionInst_UAE
{
    Subtype = Install;
    trigger OnInstallAppPerCompany()
    var
        AppInfo: ModuleInfo;
    begin
        if AppInfo.DataVersion = Version.Create(0, 0, 0, 0) then begin
            HandleFreshInstall();
        end;
    end;

    local procedure HandleFreshInstall()
    var
        EnableALJExt: Codeunit ALJCod_EnableALJExtension_UAE;
    begin
        if EnableALJExt.IsALJApplicationAreaEnabled() then exit;
        EnableALJExt.EnableALJExtension();
    end;
}