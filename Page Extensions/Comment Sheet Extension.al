pageextension 50206 "SCR Comment Sheet Extension" extends "Comment Sheet"
{
    layout
    {
        addlast(Control1)
        {
            field(CodeOption; "Codeoption")
            {
                Caption = 'Valg';                

                trigger OnValidate();
                begin
                    Rec.Code := FORMAT(CodeOption);
                end;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        EVALUATE(CodeOption, Rec.Code);
    end;

    var
        CodeOption: Option " ", POPUP, OPRET;

}
