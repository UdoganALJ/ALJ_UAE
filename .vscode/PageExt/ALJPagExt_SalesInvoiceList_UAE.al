pageextension 63202 ALJPagExt_SalesInvoiceList_UAE extends "Sales Invoice List"
{
    layout
    {
        addafter("Due Date")
        {
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