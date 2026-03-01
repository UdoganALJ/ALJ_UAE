reportextension 63200 ALJRepExt_WrkshTaxInv_UAE extends "Tax Invoice Copy ALJUAE"
{
    dataset
    {
        add("Workshop Header")
        {
            column(Payment_Method_Code; "Payment Method Code")
            {

            }
        }
    }
    rendering
    {
        layout("ALJ Workshop Tax Invoice")
        {
            Type = RDLC;
            LayoutFile = './.vscode/ReportLayouts/PostedWorkshopInvoice/ALJRepLay_WorkshopTaxInvoice_UAE.rdl';
            Caption = 'ALJ Workshop Tax Invoice';
            Summary = 'ALJ Workshop Tax Invoice';
        }
    }

    labels
    {
        PaymentMethodLbl = 'Payment Method:';
    }
}