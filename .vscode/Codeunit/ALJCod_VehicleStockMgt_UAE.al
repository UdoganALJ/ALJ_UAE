codeunit 63202 ALJCod_VehicleStockMgt_UAE
{
    trigger OnRun()
    var
        lVehicleStockMgt: Record ALJTab_VehicleStockMgt_UAE;
    begin
        if lVehicleStockMgt.FindSet() then begin
            lVehicleStockMgt.DeleteAll();
        end;
        CalcVehicleStockMgt();
    end;

    local procedure CalcVehicleStockMgt()
    var
        lVehicle: Record "DBV Vehicle";
        lStockMgt: Record ALJTAB_VehicleStockMgt_UAE;
        lVehiclePO: Record "Purchase Header";
        lValueEntry: Record "Value Entry";
        lStockAgeDays: Integer;
        lStockAgeMonths: Integer;
    begin
        lVehicle.SetAutoCalcFields("Customer Name");
        if lVehicle.FindSet() then begin
            repeat
                lStockMgt.Init();
                lStockMgt.Validate("Vehicle No.", lVehicle."No.");//Validates all other vehicle fields on table level
                GetVehiclePO(lVehicle, lVehiclePO);
                lStockMgt.Validate("PO Number", lVehiclePO."No.");
                lStockMgt.Validate("PO Date", lVehiclePO."Order Date");
                GetVehiclePurchValueEntries(lVehicle."No.", lValueEntry);
                lStockMgt.Validate("Unit Cost", GetVehicleCostsFromValueEntries(1, lValueEntry));
                lStockMgt.Validate("Freight Price", GetVehicleCostsFromValueEntries(2, lValueEntry));
                lStockMgt.Validate("CFR Price", GetVehicleCostsFromValueEntries(3, lValueEntry));
                CalculateVehicleStockAge(lVehicle, lStockAgeDays, lStockAgeMonths);
                lStockMgt.Validate("Stock Age Days", lStockAgeDays);
                lStockMgt.Validate("Stock Age Months", lStockAgeMonths);
                lStockMgt.Insert();
            until lVehicle.Next() = 0;
        end;
    end;

    local procedure GetVehiclePO(pVehicle: Record "DBV Vehicle"; pVehiclePO: Record "Purchase Header")
    var
        lPurchLine: Record "Purchase Line";
    begin
        lPurchLine.SetRange("Document Type", lPurchLine."Document Type"::Order);
        lPurchLine.SetRange("DBV Vehicle No.", pVehicle."No.");
        lPurchLine.SetLoadFields("Document Type", "Document No.", "DBV Vehicle No.", "Quantity Received");
        lPurchLine.ReadIsolation := IsolationLevel::ReadUncommitted;
        if lPurchLine.FindLast() then begin
            pVehiclePO := lPurchLine.GetPurchHeader();
        end;
    end;


    [TryFunction]
    local procedure GetVehiclePurchValueEntries(pVehicleNo: Code[20]; var pValueEntry: Record "Value Entry")
    var
        lItemLedEntry: Record "Item Ledger Entry";
    begin
        lItemLedEntry.SetRange("Entry Type", lItemLedEntry."Entry Type"::Purchase);
        lItemLedEntry.SetRange("DBV Vehicle No.", pVehicleNo);
        lItemLedEntry.ReadIsolation := IsolationLevel::ReadUncommitted;
        if lItemLedEntry.FindLast() then begin
            pValueEntry.Reset();
            pValueEntry.SetRange("Item Ledger Entry No.", lItemLedEntry."Entry No.");
            pValueEntry.FindSet();
        end;
    end;

    local procedure GetVehicleCostsFromValueEntries(pCalculatingVal: Option Initial,Freight,Cfr; var pValueEntry: Record "Value Entry"): Decimal
    var
        lCostOut: Decimal;
    begin
        if pValueEntry.FindSet() then begin
            pValueEntry.SetRange("Item Ledger Entry Type", pValueEntry."Item Ledger Entry Type"::Purchase);
            pValueEntry.SetRange("Entry Type", pValueEntry."Entry Type"::"Direct Cost");
            case pCalculatingVal of
                pCalculatingVal::Initial:
                    begin
                        pValueEntry.SetRange("Item Charge No.", '');
                        pValueEntry.SetRange("Invoiced Quantity", 1);
                        if pValueEntry.FindLast() then
                            lCostOut := pValueEntry."Cost per Unit (ACY)";
                    end;
                pCalculatingVal::Freight:
                    begin
                        pValueEntry.SetRange("Item Charge No.", 'FREIGHT-NV');
                        pValueEntry.SetRange("Valued Quantity", 1);
                        if pValueEntry.FindLast() then
                            lCostOut := pValueEntry."Cost per Unit (ACY)";
                    end;
                pCalculatingVal::Cfr:
                    begin
                        if pValueEntry.FindSet() then begin
                            pValueEntry.CalcSums("Cost per Unit (ACY)");
                            lCostOut := pValueEntry."Cost per Unit (ACY)";
                        end;
                    end;
            end;
        end;
        exit(lCostOut);

    end;

    local procedure CalculateVehicleStockAge(pVehicle: Record "DBV Vehicle"; pNoOfDays: Integer; pNoOfMonths: Integer)
    begin
        if pVehicle."Acceptance Date" <> 0D then begin
            pNoOfMonths := CalcFullMonthsBetweenDates(pVehicle."Acceptance Date", Today);
            pNoOfDays := Abs(pVehicle."Acceptance Date" - Today);

        end;
    end;

    local procedure CalcFullMonthsBetweenDates(FromDate: Date; ToDate: Date): Integer
    var
        FullMonths: Integer;
        LeftOverDays: Integer;
    begin
        FullMonths := (Date2DMY(ToDate, 3) - Date2DMY(FromDate, 3)) * 12 + Date2DMY(ToDate, 2) - Date2DMY(FromDate, 2) - 1;

        if Date2DMY(ToDate, 1) = Date2DMY(CalcDate('<CM>', ToDate), 1) then
            FullMonths += 1
        else
            LeftOverDays := Date2DMY(ToDate, 1);

        if Date2DMY(FromDate, 1) - LeftOverDays <= 1 then
            FullMonths += 1;

        exit(FullMonths);
    end;
}