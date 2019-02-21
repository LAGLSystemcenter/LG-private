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
        IF EVALUATE(CodeOption, Rec.Code) THEN;
    end;

    var
        CodeOption: Option " ", POPUP, OPRET;

}
