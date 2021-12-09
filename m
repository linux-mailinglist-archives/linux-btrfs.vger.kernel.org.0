Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECCE46F372
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Dec 2021 19:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhLIS5D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Dec 2021 13:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhLIS47 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 9 Dec 2021 13:56:59 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77A0C0617A2
        for <linux-btrfs@vger.kernel.org>; Thu,  9 Dec 2021 10:53:25 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso7161428otj.11
        for <linux-btrfs@vger.kernel.org>; Thu, 09 Dec 2021 10:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=80HWnHPWJlbwBoph1SQxVteq6hb4x4YiCtS4rhN7W3w=;
        b=UunRr2pt99avIJf0ecqDwbmL1I50AF9VmbHxlcaZzEiRfOdB3gZn5FAkKxX+ZQwN8S
         f24s5UoHYH4xRDpzp08oOxYsU/VjSxDtBzvkFdG0Z24cHX6ZGYDcyXk93wYDiMB5GOep
         PJmXEnbgGUj8pxFnZzKn+pT6NMRUFvN79KfGnf/aWKMKuEzUuykj3kJi6v5tjgsfWIH9
         KLR6KIzm4TCfUAh94hgixJQIZhwd8Q6HWltQKuWClZBcRvQ/BQTpNCPDO90+fb1j/5zM
         fUv5oDZWafqVYpB3KugRm6qBitz8Sth27qN3uJdM0MK5iTYPKfrOemgg+XzKkl2Oeu57
         oTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=80HWnHPWJlbwBoph1SQxVteq6hb4x4YiCtS4rhN7W3w=;
        b=dRII183eG0g4XNWqRzAbsofvVPW6NjDi2aPS7MvIasqVAU36jsVm81+dMT05RQdAXy
         QbWf1yHHwcAziOk+6Zhn2LN6vD/nljtoC9G3zCV6zPEgjFoweU8yTm0gv6tvWvZg7EBN
         LyfBL/gtx+rWHj9EvVUs4YYtgtv/kpwfs6cWIe9mbBqWIPMGtl0tSq1PJ+FprVEuP70X
         2ku5fQwjiEOhSy5YMTYVgvvum5YoN2kI6HUx9j/ktzJN5OYQNaHnbGsXsXy0mVYuQXOV
         +bpBfKVnNDECn462K+POohZkduVCgPfHqZYq95eQPHCC9jaJtO6pIJn5tdYeqJCXw21+
         pqxQ==
X-Gm-Message-State: AOAM530H1BgkeLzqXpCBfI8FWaP2xm3vWIh1mIdTZDrPXPD56yDYp/na
        XSns3TgktpwA8pGFzWSinQJrZ5446vK5jgn9zSk=
X-Google-Smtp-Source: ABdhPJyfjZGxMSO7FMTVlhzAsEb07GNlskuxs4OHSISmZsqLnLK51B/LYAjDBFThG+Uq3Ome5PUMROH9It7mOrfDl3Y=
X-Received: by 2002:a05:6830:4392:: with SMTP id s18mr7268153otv.168.1639076005198;
 Thu, 09 Dec 2021 10:53:25 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4a:1dc7:0:0:0:0:0 with HTTP; Thu, 9 Dec 2021 10:53:24 -0800 (PST)
Reply-To: msbelinaya892@gmail.com
From:   msbelinaya <davidparkens234@gmail.com>
Date:   Thu, 9 Dec 2021 18:53:24 +0000
Message-ID: <CA+7aL4P3TOOcrBdAY=t2BJvodS2fPLQQ28uW=9-QTJLfesTYRg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ich biete meine Freundschaft an und glaube, dass Sie mich mit gutem
Herzen annehmen werden. Ich wurde gedr=C3=A4ngt, Sie zu kontaktieren und zu
sehen, wie wir uns am besten unterst=C3=BCtzen k=C3=B6nnen. Ich bin Frau Ko=
djovi
Hegbor aus der T=C3=BCrkei und ich arbeite als Operations Division Manager
bei der StandardBNP Bank Limited T=C3=BCrkei. Ich glaube, es ist Gottes
Wille, dass ich Ihnen jetzt begegnen werde. Ich habe ein wichtiges
gesch=C3=A4ftliches Gespr=C3=A4ch, das ich mit Ihnen teilen m=C3=B6chte, vo=
n dem ich
glaube, dass es Sie interessiert, da es mit Ihrem Nachnamen
zusammenh=C3=A4ngt und Sie davon profitieren wird.

 Im Jahr 2006 er=C3=B6ffnete ein B=C3=BCrger Ihres Landes bei meiner Bank e=
in
36-monatiges Nicht-Residentenkonto im Wert von =C2=A3 8.400.000,00. Das
Ablaufdatum f=C3=BCr diese Hinterlegungsvereinbarung war der 16. Januar
2009. Leider starb er bei einem t=C3=B6dlichen Erdbeben am 12. Mai 2008 in
Sichuan, China, bei dem auf einer Gesch=C3=A4ftsreise mindestens 68.000
Menschen ums Leben kamen.

Die Gesch=C3=A4ftsleitung meiner Bank hat noch nichts von seinem Tod
geh=C3=B6rt, ich wusste davon, weil er mein Freund war und ich sein
Kontoverwalter war, als das Konto vor meiner Bef=C3=B6rderung er=C3=B6ffnet
wurde. Aber Sir
 hat bei der Kontoer=C3=B6ffnung die n=C3=A4chsten Angeh=C3=B6rigen / Erben=
 nicht
erw=C3=A4hnt und er war nicht verheiratet oder hatte keine Kinder. Letzte
Woche bat mich meine Bankdirektion, Anweisungen zu geben, was mit
seinem Geld zu tun sei, wenn der Vertrag verl=C3=A4ngert werden sollte.

Ich wei=C3=9F, dass dies passieren wird, und deshalb habe ich nach einem
Mittel gesucht, mit der Situation umzugehen, denn wenn meine
Bankdirektoren wissen, dass sie tot sind und keinen Erben haben,
nehmen sie das Geld f=C3=BCr ihren pers=C3=B6nlichen Gebrauch, also tue ich=
 es
nicht Ich m=C3=B6chte nicht, dass so etwas passiert. Da habe ich deinen
Nachnamen gesehen, habe mich gefreut und suche nun deine Mitarbeit, um
dich als n=C3=A4chster Angeh=C3=B6riger / Erbe des Kontos zu pr=C3=A4sentie=
ren, da du
den gleichen Nachnamen wie er hast und meine Bankzentrale das Konto
freigeben wird f=C3=BCr dich. Es besteht kein Risiko; die Transaktion wird
im Rahmen einer legitimen Vereinbarung durchgef=C3=BChrt, die Sie vor
Rechtsverletzungen sch=C3=BCtzt.

Es ist besser f=C3=BCr uns, das Geld zu beanspruchen, als es den
Bankdirektoren zu =C3=BCberlassen, sie sind bereits reich. Ich bin kein
gieriger Mensch, also schlage ich vor, dass wir das Geld gleichm=C3=A4=C3=
=9Fig
aufteilen, 50/50% auf beide Parteien. Mein Anteil wird mir helfen,
mein eigenes Unternehmen zu gr=C3=BCnden und den Erl=C3=B6s f=C3=BCr wohlt=
=C3=A4tige
Zwecke zu verwenden, was mein Traum war.

Bitte teilen Sie mir Ihre Meinung zu meinem Vorschlag mit, ich brauche
wirklich Ihre Hilfe bei dieser Transaktion. Ich habe dich auserw=C3=A4hlt,
mir zu helfen, nicht aus eigener Kraft, mein Lieber, sondern bei Gott,
ich wollte, dass du wei=C3=9Ft, dass ich mir die Zeit genommen habe, f=C3=
=BCr
diese Nachricht zu beten, bevor ich dich jemals kontaktiert habe, um
deine Meinung mitzuteilen und bitte zu behandeln diese Informationen
als STRENG GEHEIM. Nach Erhalt Ihrer Antwort ausschlie=C3=9Flich =C3=BCber =
meine
pers=C3=B6nliche E-Mail-Adresse msbelinaya892@gmail.com
gibt Ihnen Details zur Transaktion. Und eine Kopie der
Einlagenbescheinigung des Fonds und der Gr=C3=BCndungsurkunde der
Gesellschaft, die den Fonds gegr=C3=BCndet hat.
Gott segne in Erwartung Ihrer dringenden Antwort
Mit freundlichen Gr=C3=BC=C3=9Fen
Frau. Kodjovi Hegbor
msbelinaya892@gmail.coma
