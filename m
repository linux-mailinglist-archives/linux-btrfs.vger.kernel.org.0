Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0C641D905
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Sep 2021 13:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350587AbhI3LsR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Sep 2021 07:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350490AbhI3LsM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Sep 2021 07:48:12 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BB9DC06176A
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Sep 2021 04:46:30 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id l19so6878491vst.7
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Sep 2021 04:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=entgGEYUY4J7NJW2eYFzwJBGmMF5bhtO/1/tPBTmbZs=;
        b=R0bkvGS2ZdaZEhXfYTaqx+PBltVuDiYjpwpsNStdpuDUCbEEj7C2N1kpsQutn3R2S5
         Ex0dk8zDcXrITs5XUAZ/7LgrpXhX1DGz5/+3nanbKawszncGZnydNrgKhl3tHq9opoqj
         zZLnzi8WGyKcIdK5lk2Szs7Ox5cEzVSdjww2u8tcoWQTy29KFWpcozkVH9uXRI6XirP4
         yFGBfCzLswBBDJ4iH8k7warQJU6PBCu9DNHO0Tbo6EpzdBAGigOF9uDW4Al7ti50zJLh
         7KUZXoBag95UoOJpfdmONQIp+kWlNpzr1uZz/E69943kFP1Wlb+ui2QJZv82/kjV4/w1
         jFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=entgGEYUY4J7NJW2eYFzwJBGmMF5bhtO/1/tPBTmbZs=;
        b=AXz8Ou2boJM7OZTTFQEqNu+ohIhTCZcnY+JCVJzn4aLRO32McG7i0ioPQX6dCPcsbv
         E4qsSEacmSbwkGNWiZHVDY/cm0osxzjQCLoc1nxjJ0WUzOAdBNoM5AJyYHvnwO/sotXJ
         rQKjxVi1xXDSXQ8OMApFqb6sokyzHcUZTf41E+EvTkXl2FWPY1c4vBYwskwT6wr5vJ28
         gGVriixZyXMwHqWlQxm23UNk0DMg2+lNqjo1usk41+DGq52n/IQp5T/n8+lqDKEX3wel
         n59hbY15H2EnzmfWqP8liBKzH9rJpBLNC+3rkQIg0YDK8h/hWE0B2cX9kMA8HhPsY8Il
         SjdA==
X-Gm-Message-State: AOAM531uWyOWPRZsZUDnlIVmzU5cYE9aCNkA8giKVa30oA+p+XC3/zvx
        OXHEf1d6KSQYJZg0dyptCvQniCmm//P8R7/Mli4=
X-Google-Smtp-Source: ABdhPJwYXqAf5FNgmRpypmb7LDbEg3dpFFxUh4YLJ6PkdtZextgFBRZ0wHXzW73P96KDriFFt3ka7aYAz0EnCkc7pp8=
X-Received: by 2002:a05:6102:21ce:: with SMTP id r14mr4794189vsg.38.1633002389436;
 Thu, 30 Sep 2021 04:46:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:7345:0:0:0:0:0 with HTTP; Thu, 30 Sep 2021 04:46:28
 -0700 (PDT)
Reply-To: banqueatlantiquetogobranch@gmail.com
In-Reply-To: <CACMVZuo7Gdq6s8AXv0p9EosLzpTGnLK_XeLpg59BaOVih2bwBg@mail.gmail.com>
References: <CACMVZuo7Gdq6s8AXv0p9EosLzpTGnLK_XeLpg59BaOVih2bwBg@mail.gmail.com>
From:   "Mrs.Kristalina Georgieva" <mrfrankooboro@gmail.com>
Date:   Thu, 30 Sep 2021 13:46:28 +0200
Message-ID: <CACMVZuq4WgnkovPeFvqTjoE_XE=mJKe42cDvQX-vwKPXWMRO3Q@mail.gmail.com>
Subject: 30 /9/2021
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

V=C3=A1=C5=BEen=C3=BD vlastn=C3=ADk e -mailu / pr=C3=ADjemca fondu,
Som pani Kristalina Georgieva, v=C3=BDkonn=C3=A1 riadite=C4=BEka a preziden=
tka
Medzin=C3=A1rodn=C3=A9ho menov=C3=A9ho fondu. Skuto=C4=8Dne sme presk=C3=BA=
mali v=C5=A1etky prek=C3=A1=C5=BEky
a probl=C3=A9my, ktor=C3=A9 sprev=C3=A1dzali va=C5=A1u ne=C3=BApln=C3=BA tr=
ansakciu a va=C5=A1u
neschopnos=C5=A5 vyrovna=C5=A5 sa s poplatkami za prevody =C3=BA=C4=8Dtovan=
=C3=BDmi za minul=C3=A9
mo=C5=BEnosti prevodu, nav=C5=A1t=C3=ADvte na=C5=A1e potvrdenie. strana 38 =
=C2=B0 53'56 "N 77 =C2=B0
2" 39 =E2=80=B3 F.

Predstavenstvo Svetov=C3=A1 banka a Medzin=C3=A1rodn=C3=BD menov=C3=BD fond=
 (MMF)
Washington DC v spolupr=C3=A1ci s ministerstvom financi=C3=AD USA a niektor=
=C3=BDmi
=C4=8Fal=C5=A1=C3=ADmi relevantn=C3=BDmi vy=C5=A1etrovac=C3=ADmi agent=C3=
=BArami v USA nariadili na=C5=A1ej
zahrani=C4=8Dnej prevodnej jednotke BANQUE ATLANTIQUE INTERNATIONAL TOGO
previes=C5=A5 kompenza=C4=8Dn=C3=BD fond v hodnote =E2=82=AC 761 000,00 na =
hlavn=C3=BA kartu
bankomatu a odo=C5=A1leme v=C3=A1m.

Po=C4=8Das n=C3=A1=C5=A1ho vy=C5=A1etrovania sme s hr=C3=B4zou zistili, =C5=
=BEe v=C3=A1=C5=A1 fond zbyto=C4=8Dne
zdr=C5=BEiavali skorumpovan=C3=AD =C3=BAradn=C3=ADci b=C3=A1nk, ktor=C3=AD =
sa pok=C3=BA=C5=A1ali presmerova=C5=A5
va=C5=A1e prostriedky na svoje s=C3=BAkromn=C3=A9 =E2=80=8B=E2=80=8B=C3=BA=
=C4=8Dty kv=C3=B4li svojim sebeck=C3=BDm
z=C3=A1ujmom. Dnes by sme v=C3=A1s chceli informova=C5=A5, =C5=BEe v=C3=A1=
=C5=A1 fond bol ulo=C5=BEen=C3=BD v
BANQUEATLANTIQUE INTERNATIONAL TOGO je pripraven=C3=A9 aj na doru=C4=8Denie=
,
teraz kontaktujte prof. Susana Robinsona, riadite=C4=BEa zahrani=C4=8Dn=C3=
=BDch
poukazov, BANQUE ATLANTIQUE INTERNATIONAL TOGO, e-mail:
banqueatlantiquetogobranch@gmail.com, po=C5=A1lite jej nasleduj=C3=BAce
inform=C3=A1cie, aby mohla previes=C5=A5 v=C3=A1=C5=A1 celkov=C3=BD kompenz=
a=C4=8Dn=C3=BD fond v hodnote
761 000,00 EUR do bankomatu Master Card a po=C5=A1leme v=C3=A1m ju bez
akejko=C4=BEvek chyby alebo oneskorenia.

(1) Va=C5=A1e =C3=BApln=C3=A9 meno ........................................=
...
(2) Va=C5=A1a dom=C3=A1ca adresa ..............................
(3) K=C3=B3pia v=C3=A1=C5=A1ho ob=C4=8Dianskeho preukazu alebo pasu .......=
....
(4) Va=C5=A1a krajina ...........................................
(5) PS=C4=8C =E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=
=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6=E2=80=A6.
(6) Va=C5=A1e s=C3=BAkromn=C3=A9 =E2=80=8B=E2=80=8Btelef=C3=B3nne =C4=8D=C3=
=ADslo ........................

S pozdravom
Pani Kristalina Georgieva
Gener=C3=A1lny riadite=C4=BE a prezident Medzin=C3=A1rodn=C3=A9ho menov=C3=
=A9ho fondu.
