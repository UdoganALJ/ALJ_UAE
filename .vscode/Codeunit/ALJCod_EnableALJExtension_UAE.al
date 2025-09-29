codeunit 63201 ALJCod_EnableALJExtension_UAE
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Application Area Mgmt.", OnGetEssentialExperienceAppAreas, '', false, false)]
    local procedure "Application Area Mgmt._OnGetEssentialExperienceAppAreas"(var TempApplicationAreaSetup: Record "Application Area Setup" temporary)
    begin
        TempApplicationAreaSetup.ALJUAE := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Application Area Mgmt.", OnValidateApplicationAreas, '', false, false)]
    local procedure "Application Area Mgmt._OnValidateApplicationAreas"(ExperienceTierSetup: Record "Experience Tier Setup"; TempApplicationAreaSetup: Record "Application Area Setup" temporary)
    begin
        if ExperienceTierSetup.Basic then if TempApplicationAreaSetup.ALJUAE then Error('ALJ Application Area should be part of Essential in order for the ALJ extension to work.');
    end;

    internal procedure IsALJApplicationAreaEnabled(): Boolean
    var
        ApplicationAreaSetup: Record "Application Area Setup";
        ApplicationAreaMgtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if ApplicationAreaMgtFacade.GetApplicationAreaSetupRecFromCompany(ApplicationAreaSetup, CompanyName) then exit(ApplicationAreaSetup.ALJUAE);
    end;

    internal procedure EnableALJExtension()
    var
        ApplicationAreaMgtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        ApplicationAreaMgtFacade.RefreshExperienceTierCurrentCompany();
    end;
}