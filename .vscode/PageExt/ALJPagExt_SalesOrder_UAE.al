pageextension 63201 ALJPagExt_SalesOrder_UAE extends "Sales Order"
{
    layout
    {
        addafter("Shipping and Billing")
        {
            group(ALJ_Warranty)
            {
                Caption = 'Warranty';
                field("DBV Warranty Claim No."; Rec."DBV Warranty Claim No.")
                {
                    ApplicationArea = ALJUAE;
                }
                field("DBV Claim Serial No."; Rec."DBV Claim Serial No.")
                {
                    ApplicationArea = ALJUAE;
                }
            }
        }
    }
}