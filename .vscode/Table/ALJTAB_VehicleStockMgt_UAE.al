table 63200 ALJTab_VehicleStockMgt_UAE
{
    DataClassification = CustomerContent;
    Caption = 'ALJ Vehicle Stock Management';

    fields
    {
        field(1; "Vehicle No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'VIN Number';
            TableRelation = "DBV Vehicle";
            trigger OnValidate()
            begin
                ValidateVehicleFields();
            end;
        }
        field(2; "PO Number"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'PO Number';
        }
        field(3; "PO Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'PO Date';
        }
        field(4; "Vehicle Model"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Vehicle Model';
        }
        field(5; "Color"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Color';
        }
        field(6; "Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Cost';

        }
        field(7; "Arrival Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Arrival Date';
        }
        field(8; "Delivery Status OEM"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Delivery Status OEM';

        }
        field(9; "Model Year"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Model Year';
        }
        field(10; "Stock Status"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Stock Status';
        }
        field(11; "Vehicle Location"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Vehicle Location';
        }
        field(12; "Freight Price"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Freight Price';
        }
        field(13; "CFR Price"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'CFR Price';
        }
        field(14; "Stock Age Days"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Stock Age(Days)';
        }
        field(15; "Stock Age Months"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Stock Age(Months)';
        }
        field(16; "Customer Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer Name';
        }
        field(17; "Is Sold"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Is Sold';
        }
        field(18; "Is Demo Vehicle"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Is Demo Vehicle';
        }
        field(19; "Date of Sales"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Date of Sales';
        }
        field(20; "VIN Number"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'VIN';
            TableRelation = "DBV Vehicle".VIN;
        }

    }

    keys
    {
        key(PK; "Vehicle No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    local procedure ValidateVehicleFields()
    var
        lVehicle: Record "DBV Vehicle";
    begin
        lVehicle.SetAutoCalcFields("Customer Name", "Vehicle Status (Cust) Descr.", "Vehicle Status (Log) Descr.");
        lVehicle.SetLoadFields(VIN, Description, "Color Description Real", "Acceptance Date", "Model Year", "Vehicle Status (Cust) Descr.", "Vehicle Location", "Customer Name", "Test Drive Vehicle", "Dealer Delivery Date");
        lVehicle.ReadIsolation := IsolationLevel::ReadUncommitted;
        lVehicle.Get(Rec."Vehicle No.");
        Rec.Validate("VIN Number", lVehicle.VIN);
        Rec.Validate("Vehicle Model", lVehicle.Description);
        Rec.Validate(Color, lVehicle."Color Description Real");
        Rec.Validate("Arrival Date", lVehicle."Acceptance Date");
        Rec.Validate("Model Year", lVehicle."Model Year");
        Rec.Validate("Stock Status", lVehicle."Vehicle Status (Cust) Descr.");
        Rec.Validate("Delivery Status OEM", lVehicle."Vehicle Status (Log) Descr.");
        Rec.Validate("Vehicle Location", lVehicle."Vehicle Location");
        Rec.Validate("Customer Name", lVehicle."Customer Name");
        Rec.Validate("Is Demo Vehicle", lVehicle."Test Drive Vehicle");
        Rec.Validate("Date of Sales", lVehicle."Dealer Delivery Date");

    end;

    internal procedure CalcStockMgt()
    var
        lStockMgtCU: Codeunit ALJCod_VehicleStockMgt_UAE;
    begin
        lStockMgtCU.Run();
    end;

}