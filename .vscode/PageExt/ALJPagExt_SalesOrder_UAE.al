pageextension 63200 ALJPagExt_SalesOrder_UAE extends "Sales Order"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        addafter("Print Confirmation")
        {
            action("Print Packing List")
            {
                ApplicationArea = ALJUAE;
                Caption = 'Packing List';
                Image = Print;
                ToolTip = 'Print ALJ Packing List for the sales order';
                trigger OnAction()
                begin
                    Rec.SetRecFilter();
                    Report.Run(Report::ALJRep_SalesOrdPackingList_UAE, true, false, Rec);
                end;
            }
        }
        addafter("Print Confirmation_Promoted")
        {
            actionref("Print Packing List_Promoted"; "Print Packing List")
            {

            }
        }
    }

}