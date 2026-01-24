pageextension 63200 ALJPagExt_SalesInvSubform_UAE extends "Posted Sales Invoice Subform"
{
    actions
    {
        addlast("&Line")
        {
            action(AljUpdateHsCode)
            {
                ApplicationArea = ALJUAE;
                Caption = 'Update HS Codes';
                Image = UpdateDescription;
                trigger OnAction()
                var
                    lAljGlobaFunc: Codeunit ALJCod_GlobalFunctions_UAE;
                    lSalesInvLine: Record "Sales Invoice Line";
                begin
                    lSalesInvLine.SetRange("Document No.", Rec."Document No.");
                    if lSalesInvLine.FindSet() then begin
                        lAljGlobaFunc.UpdateSalesInvLineHsCode(lSalesInvLine);
                    end;
                end;
            }
        }
    }
}