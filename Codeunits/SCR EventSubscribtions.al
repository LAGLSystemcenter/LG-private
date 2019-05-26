codeunit 50206 "SCR Event subscribtion"
{
    [EventSubscriber(ObjectType::table, 36, 'OnAfterValidateEvent', 'Sell-to Customer No.', true, true)]
    local procedure OnCustomerValidate(Rec: Record "Sales Header");
    begin
        // Show pop-up
        IF Rec."No." <> '' THEN 
          ShowPopup(rec);
    end;
   
    local procedure ShowPopup(Var SalesHeader: Record "Sales Header");
    var
        CommentLine: Record "Comment Line";
        Tekst: Text;
        SalesLine: Record "Sales Line";
        LastLineNo: Integer;
    begin
        CommentLine.SETRANGE("Table Name", 1);
        CommentLine.SETRANGE("No.", SalesHeader."Sell-to Customer No.");
        CommentLine.SETRANGE(Code, 'POPUP');
        IF CommentLine.FINDSET THEN BEGIN
            REPEAT
                Tekst += CommentLine.Comment + '\';
            UNTIL CommentLine.NEXT = 0;
            MESSAGE(Tekst);
        END;

        CommentLine.SETRANGE(Code, 'OPRET');
        IF CommentLine.FINDSET THEN BEGIN
            SalesLine."Document Type" := SalesHeader."Document Type";
            SalesLine."Document No." := SalesHeader."No.";
            IF SalesLine.FINDLAST THEN
                LastLineNo := SalesLine."Line No."
            ELSE
                LastLineNo := 10000;
            REPEAT
                LastLineNo += 10000;
                SalesLine.RESET;
                SalesLine.INIT;
                SalesLine."Document Type" := SalesHeader."Document Type";
                SalesLine."Document No." := SalesHeader."No.";
                SalesLine."Line No." := LastLineNo;
                SalesLine.Description := CommentLine.Comment;
                SalesLine.INSERT;
            UNTIL CommentLine.NEXT = 0;
        END;
    end;
}
