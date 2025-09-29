pageextension 63203 ALJPagExt_SalesOrderList_UAE extends "Sales Order List"
{
    layout
    {
        addafter(Status)
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