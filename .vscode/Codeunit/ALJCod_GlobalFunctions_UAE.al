codeunit 63203 ALJCod_GlobalFunctions_UAE
{
    Permissions = tabledata "Sales Invoice Line" = rimd;
    internal procedure UpdateSalesInvLineHsCode(var pSalesInvLine: Record "Sales Invoice Line")
    var
        lItem: Record Item;
    begin
        if pSalesInvLine.FindSet() then begin
            repeat
                lItem.Reset();
                lItem.SetLoadFields("Tariff No.");
                lItem.ReadIsolation := IsolationLevel::ReadUncommitted;
                if lItem.Get(pSalesInvLine."No.") then begin
                    pSalesInvLine."HS Code ALJUAE" := lItem."Tariff No.";
                    pSalesInvLine.Modify();
                end;
            until pSalesInvLine.Next() = 0;
        end;
    end;
}