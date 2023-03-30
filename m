Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BD36D0891
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 16:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjC3Oog (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Mar 2023 10:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjC3Oof (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Mar 2023 10:44:35 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3DD7DB2
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Mar 2023 07:44:33 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id d2so16426435vso.9
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Mar 2023 07:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680187472;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0xBUyvWuzTb0qrB6q5ePkKRCEZHCNkbSAlpe58GArxk=;
        b=AgU/0vWEMxrDgQiCk3vLMPUasei8K5SKG2TCD2cHZuRTrXdfUrXM/XxNTm1m8LXz44
         p9ySTgfysjdUCYwpfjKtbRlg+hkT7SbC9QJiUNoykjuVokalzm72D1GPv61efTF2zaVx
         u9E8PbyjEZvPlvbEhaV8An2MOuiDeOBxOVB5rmhmJ5pDEZAWyKp+dT7hfJdkEXJA0ddO
         u28DIBnPSgbLw+Jt3Cdg4P5TqQLYfbVNYBAu73oxBIbxjd1ZtPLDpT5UpMIFD8att/qZ
         YDbXVaiXOwaeUI9t0V4I22GYA16GZPAbSx8SNZWNCwluKW7CMysV4X5uPdxzwzL/aCZf
         9G7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680187472;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0xBUyvWuzTb0qrB6q5ePkKRCEZHCNkbSAlpe58GArxk=;
        b=4y/swLUKl5lwf0COju4glZge+RtRTp65bYciSc4hz0+uqBnDh+BYqzfXEZMAXtKoYV
         fxKz79Q48iIcEUBPjlMnZqU5NSHSog0F2w/HvbB8bHClMAY+pnWnuzt3OHashvdHFqID
         Pt2rc/FNioNcO23SRQE3uOhCPWwHp+dylDcrpV/oiHfIoObVhyQwpzL8mwRAUtqzlhH4
         ljKAB+BXkiMtFdqoBmjrelRPlr3+i39tnq38ITK1D4ESx7ReN6Vb88oryn2nrAHwKRQF
         8DhJpx8rY+E2IOcsUpk+bp0gcJy4kKAerZppY1p1cJ+l6xlx7qVMFS0ZEfa3L6alMvtD
         jukA==
X-Gm-Message-State: AAQBX9e1oZJal93Xn7iGA7vipqd5lv07t0wcweOzcAcockg1oxYwOvGh
        eL/NyWGZkTHmOLutL6wf4C80550NxrQ1YK2UTbk=
X-Google-Smtp-Source: AKy350bS75cPAEsOIpqBe1grn0NYOfgJF/KNkJ0kWWmwMNIrNfvLqwwEy2CxcadiMuxjEt6DS+ctcvwRcUcYoEyHInw=
X-Received: by 2002:a05:6102:471d:b0:426:7730:1a4b with SMTP id
 ei29-20020a056102471d00b0042677301a4bmr14106779vsb.0.1680187472330; Thu, 30
 Mar 2023 07:44:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:b7d0:0:b0:3b7:b2aa:2c8 with HTTP; Thu, 30 Mar 2023
 07:44:32 -0700 (PDT)
Reply-To: abrahammorrison443@gmail.com
From:   Abraham Morrison <raymonddonal8@gmail.com>
Date:   Thu, 30 Mar 2023 07:44:32 -0700
Message-ID: <CAFBdM37ugSNFzFv6wC-kwor=UjotgvNu_jz-m4OWSUUx3btXKg@mail.gmail.com>
Subject: Good day!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Prosz=C4=99 o uwag=C4=99,

Jestem pan Abraham Morrison, jak si=C4=99 masz, mam nadziej=C4=99, =C5=BCe =
wszystko w
porz=C4=85dku i jeste=C5=9B zdrowy? Uprzejmie informuj=C4=99, =C5=BCe pomy=
=C5=9Blnie
sfinalizowa=C5=82em transakcj=C4=99 z pomoc=C4=85 nowego partnera z Indii i=
 teraz
=C5=9Brodki zosta=C5=82y przelane do Indii na konto bankowe nowego partnera=
.

W mi=C4=99dzyczasie zdecydowa=C5=82em si=C4=99 zrekompensowa=C4=87 ci sum=
=C4=99 500 000,00 $
(tylko pi=C4=99=C4=87set tysi=C4=99cy dolar=C3=B3w ameryka=C5=84skich) za t=
woje wcze=C5=9Bniejsze
wysi=C5=82ki, chocia=C5=BC rozczarowa=C5=82e=C5=9B mnie na linii. Niemniej =
jednak bardzo
si=C4=99 ciesz=C4=99 z pomy=C5=9Blnego zako=C5=84czenia transakcji bez =C5=
=BCadnych problem=C3=B3w i
dlatego zdecydowa=C5=82em si=C4=99 zrekompensowa=C4=87 Ci sum=C4=99 500 000=
,00 $, aby=C5=9B
m=C3=B3g=C5=82 dzieli=C4=87 ze mn=C4=85 rado=C5=9B=C4=87.

Radz=C4=99 skontaktowa=C4=87 si=C4=99 z moj=C4=85 sekretark=C4=85 w sprawie=
 karty bankomatowej
na 500 000,00 $, kt=C3=B3r=C4=85 zatrzyma=C5=82em dla ciebie. Skontaktuj si=
=C4=99 z ni=C4=85
teraz bez zw=C5=82oki.

Imi=C4=99 i nazwisko: Linda Koffi
E-mail: koffilinda785@gmail.com

Uprzejmie potwierd=C5=BA jej poni=C5=BCsze informacje:

Twoje pe=C5=82ne imi=C4=99:........
Tw=C3=B3j adres:..........
Tw=C3=B3j kraj:..........
Tw=C3=B3j wiek:.........
Tw=C3=B3j zaw=C3=B3d:..........
Tw=C3=B3j numer telefonu kom=C3=B3rkowego: .........
Tw=C3=B3j paszport lub prawo jazdy: .........

Pami=C4=99taj, =C5=BCe je=C5=9Bli nie przes=C5=82a=C5=82e=C5=9B jej w ca=C5=
=82o=C5=9Bci powy=C5=BCszych informacji,
nie wyda Ci karty bankomatowej, bo musi mie=C4=87 pewno=C5=9B=C4=87, =C5=BC=
e to Ty. Popro=C5=9B
j=C4=85, aby przes=C5=82a=C5=82a ci =C5=82=C4=85czn=C4=85 sum=C4=99 (500 00=
0,00 $) karty bankomatowej,
kt=C3=B3r=C4=85 dla ciebie zatrzyma=C5=82em.

Z wyrazami szacunku,

Pan Abraham Morrison
