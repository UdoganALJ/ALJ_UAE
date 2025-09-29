page 63200 ALJPag_VehicleStockMgt_UAE
{
    PageType = List;
    ApplicationArea = ALJUAE;
    UsageCategory = Lists;
    SourceTable = ALJTab_VehicleStockMgt_UAE;
    Editable = false;
    Caption = 'ALJ Vehicle Stock Management';
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                ShowCaption = false;

                field("Vehicle No."; Rec."Vehicle No.")
                {
                    ToolTip = 'Specifies the value of the VIN Number field.', Comment = '%';
                }
                field("Vehicle Model"; Rec."Vehicle Model")
                {
                    ToolTip = 'Specifies the value of the Vehicle Model field.', Comment = '%';
                }
                field("VIN Number"; Rec."VIN Number")
                {
                    ToolTip = 'Specifies the value of the VIN field.', Comment = '%';
                }
                field("Vehicle Location"; Rec."Vehicle Location")
                {
                    ToolTip = 'Specifies the value of the Vehicle Location field.', Comment = '%';
                }
                field(Color; Rec.Color)
                {
                    ToolTip = 'Specifies the value of the Color field.', Comment = '%';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ToolTip = 'Specifies the value of the Unit Cost field.', Comment = '%';
                }
                field("PO Date"; Rec."PO Date")
                {
                    ToolTip = 'Specifies the value of the PO Date field.', Comment = '%';
                }
                field("PO Number"; Rec."PO Number")
                {
                    ToolTip = 'Specifies the value of the PO Number field.', Comment = '%';
                }
                field("Model Year"; Rec."Model Year")
                {
                    ToolTip = 'Specifies the value of the Model Year field.', Comment = '%';
                }
                field("Arrival Date"; Rec."Arrival Date")
                {
                    ToolTip = 'Specifies the value of the Arrival Date field.', Comment = '%';
                }
                field("Freight Price"; Rec."Freight Price")
                {
                    ToolTip = 'Specifies the value of the Freight Price field.', Comment = '%';
                }
                field("CFR Price"; Rec."CFR Price")
                {
                    ToolTip = 'Specifies the value of the CFR Price field.', Comment = '%';
                }
                field("Stock Status"; Rec."Stock Status")
                {
                    ToolTip = 'Specifies the value of the Stock Status field.', Comment = '%';
                }
                field("Stock Age Days"; Rec."Stock Age Days")
                {
                    ToolTip = 'Specifies the value of the Stock Age(Days) field.', Comment = '%';
                }
                field("Stock Age Months"; Rec."Stock Age Months")
                {
                    ToolTip = 'Specifies the value of the Stock Age(Months) field.', Comment = '%';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.', Comment = '%';
                }
                field("Date of Sales"; Rec."Date of Sales")
                {
                    ToolTip = 'Specifies the value of the Date of Sales field.', Comment = '%';
                }
                field("Delivery Status OEM"; Rec."Delivery Status OEM")
                {
                    ToolTip = 'Specifies the value of the Delivery Status OEM field.', Comment = '%';
                }
                field("Is Demo Vehicle"; Rec."Is Demo Vehicle")
                {
                    ToolTip = 'Specifies the value of the Is Demo Vehicle field.', Comment = '%';
                }
                field("Is Sold"; Rec."Is Sold")
                {
                    ToolTip = 'Specifies the value of the Is Sold field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(CalcStock)
            {
                ApplicationArea = All;
                Caption = 'Calculate';
                Image = Calculate;
                ToolTip = 'Removes existing records and calculates from scratch';
                trigger OnAction()
                begin
                    Rec.CalcStockMgt();
                end;
            }
        }
        area(Promoted)
        {
            actionref(CalcStock_Promoted; CalcStock)
            {

            }
        }
    }

}