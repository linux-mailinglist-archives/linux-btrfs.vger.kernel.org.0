Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C8A515CD9
	for <lists+linux-btrfs@lfdr.de>; Sat, 30 Apr 2022 14:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiD3MYa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 30 Apr 2022 08:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382640AbiD3MYW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 30 Apr 2022 08:24:22 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9448912E
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Apr 2022 05:20:59 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gh6so20055480ejb.0
        for <linux-btrfs@vger.kernel.org>; Sat, 30 Apr 2022 05:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=fl8OEGhL9V5+Dj8qlZ50w044OB9hyZt7nE/g3ADOYas=;
        b=M6JD9mfyBgjafmQ1/t6bCduaGtsrxhC1lqBb98BGFPOlmGjEUvr6QqqJ8X478/RPbx
         6IAOU9nT9h6Q1IzvWiGQknVGKg+SJJ7qyiodQmJb5V86/nmumHzJBEoUyu5TaU7s83r9
         I5gPgfNKc8YEtVXAUEE1MppvoE1NIddLEt7Q53DdsMXHazfhL6AFY/6jdii5/H9R+4SG
         DKAQlhighWNJL/3GFBzvWeH0GdMEfYFD4paatRQLEOO6JicCRDakNyshgsfSpB7qrP+6
         igvc8ty9GErzN0bPjr6fZ+ki53hSY3QVJ6pCVxhgXtC2a92frvYHX2B+Micmz+XvRUpS
         0Y2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=fl8OEGhL9V5+Dj8qlZ50w044OB9hyZt7nE/g3ADOYas=;
        b=sndXF2OlO7OAKtzI6HDTaeBUW6mv3zTYBQRHXXbjcA4O5ztyXEfPIYg6bA2QUUz3SU
         SxSd9GClyjFN22RGDNHFxqJzAQIggm6f+/DpRrpRJMqupkWsMYXQYezRYHHBEx0FCIVL
         NQw6OS73nKhk7GVrTMEEXAYbI12wBEax72hIM/kUuX/LjdBAul9UOPdeD4S3xOVBI891
         2SRGs7YMRvCA+sK/k1sjDppC6yJeI05CGY9FwVzA8rWjyAuN5FeK/QkPTnhb/YFOE/iD
         42isJtvyFuDCqEkO8pqGlpOSyZGRFFKkSGHPnGSVFB9NPnsltcf+rkdbmxEcv0FR8pXz
         LHSQ==
X-Gm-Message-State: AOAM533g+AoxfUZ2+lNRbt+GHDVTibQwHiwguuVT+xdCgEpe79xhQ9Pe
        jvFjn9OgtiLqJIke47vHWeVN2RoeevHSfQ9EsIU=
X-Google-Smtp-Source: ABdhPJwlSxtfqRMzJntLIQlysB1FbLrJPsYFCShG856qR9gWKTd03wT7Sj8DYNnHck5Q9krudwAvPBipeL+8TQv5M0s=
X-Received: by 2002:a17:906:1e94:b0:6b9:6fcc:53fd with SMTP id
 e20-20020a1709061e9400b006b96fcc53fdmr3707664ejj.450.1651321257689; Sat, 30
 Apr 2022 05:20:57 -0700 (PDT)
MIME-Version: 1.0
Sender: labaahoefa66@gmail.com
Received: by 2002:a55:8899:0:b0:172:55f2:3fd2 with HTTP; Sat, 30 Apr 2022
 05:20:56 -0700 (PDT)
From:   Kayla Manthey <sgtkaylamanthey5@gmail.com>
Date:   Sat, 30 Apr 2022 12:20:56 +0000
X-Google-Sender-Auth: wHYhNEH5uOODoy3crrqH9Hipuac
Message-ID: <CAO9QEHB4+=uurL4ceV5xnioCewzKqyyiA6aAA71oTv7inKfwyw@mail.gmail.com>
Subject: Ihre schnelle Antwort wird gut sein
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.9 required=5.0 tests=BAYES_99,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:62b listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 0.9988]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [labaahoefa66[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [labaahoefa66[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.4 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Einen sch=C3=B6nen Tag f=C3=BCr dich,

BETR.: GUTE NACHRICHTEN, DA SIE IHR GELD ZUERST ERHALTEN WERDEN
QUARTAL DES GESCH=C3=84FTSJAHRES 2022.

Ich schreibe Ihnen, um Sie dar=C3=BCber zu informieren, dass Ihr Name zu
den Beg=C3=BCnstigten geh=C3=B6rt, die dies tun werden
erhalten ihre Mittel in diesem ersten Quartal des Jahres 2022.

 Ich freue mich sehr, Ihnen mitteilen zu k=C3=B6nnen, dass die Beh=C3=B6rde=
n
endlich arrangiert haben
die Freigabe Ihrer l=C3=A4ngst =C3=BCberf=C3=A4lligen Zahlung in einer Weis=
e, die sein wird
akzeptabel und f=C3=B6rdern Sie Ihre Bem=C3=BChungen ohne jegliche Probleme=
.

Angesichts dieser guten Nachricht freue ich mich, Ihnen mitteilen zu
k=C3=B6nnen, dass Ihre Summe
Der Anspruch auf Zahlungsausgleich in H=C3=B6he von 4,5 Millionen US-Dollar
wurde gekl=C3=A4rt und
genehmigt, um Ihnen per Geldautomatenkarte freigegeben zu werden, ,

Sie m=C3=BCssen sich daher an dieses mich wenden und Ihre angeben
Bereitschaft, Ihr Geld zu erhalten, indem Sie Ihren vollst=C3=A4ndigen
Namen und Kontakt best=C3=A4tigen
Adresse, direkte Telefonnummer und eine Kopie Ihres F=C3=BChrerscheins bzw
Internationaler Pass zur Identifizierung.

Nach Erhalt Ihrer Antwort werde ich die Aufladung der Mittel beantragen
elektronisches Banksystem und bezahlt durch automatisierte
Zahlungssysteme (CHAPS
///Geldautomat f=C3=BCr nur 4.500.000,00 US-Dollar)

Bitte beachten Sie, dass ein Geldautomat (ATM) ein elektronisches Ger=C3=A4=
t ist
Bankgesch=C3=A4ft, das es Kunden erm=C3=B6glicht, grundlegende Transaktione=
n abzuschlie=C3=9Fen
ohne die Hilfe eines Filialvertreters oder Kassierers.

Mit Ihrer maximalen Zusammenarbeit wird eine schnelle Vorkehrung f=C3=BCr
die getroffen
Die ATM-Karte wird Ihnen innerhalb weniger Tage zugestellt.

Ich z=C3=A4hle auf Ihre schnelle Antwort,

Mit freundlichen Gr=C3=BC=C3=9Fen,


Herr Roderick Philip (Bill and Exchange Manager, TD Bank)
