Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1649B4BB7BF
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Feb 2022 12:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234420AbiBRLJ5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 18 Feb 2022 06:09:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbiBRLJ4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 18 Feb 2022 06:09:56 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36DB2AED93
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 03:09:39 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id s5so2633525oic.10
        for <linux-btrfs@vger.kernel.org>; Fri, 18 Feb 2022 03:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=cGpo5Yh5utdTpDQqBI/LX/u536u8QjsfQAnYz4rzKrg=;
        b=f8UXKX3b8wTGvsTj/6AwaRavrUCYCibe8X7HBXhn1tl6KMmA1YMeikN/2Pi36GKg4w
         1ZuvxZu3772ifEc0dcuZSpKFE5Hbq/dKH6R4iGxpXc3A5RUlKU22Mi+nq+u3gm8fpE3W
         jO6Adc9pfcGvEg0qDCDK+ZxlZ7GKBCV/Ak2JDAVZuH8G1byUMxEKaBE4jBz6UO7clkLn
         M2FUQf15/AYKlyckhxiptUVXa1HVN7CdddHaPn4CWe4HYVL95zvCI8QdSibKRQeRAc+9
         jrFU0IrIbvdL/68sg+MWrHTaCmjP3LBARj1qwXwb1Tx72dl7VHiq8dn7mjZKGcjNtLbA
         sZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=cGpo5Yh5utdTpDQqBI/LX/u536u8QjsfQAnYz4rzKrg=;
        b=op8AfNahZxaEHHk386mxlqUWU5WkIrkI65eiVhKU/MRuqEGI8VB/1RpZ2fs/PCr83Z
         V5ixDNdjf4VG4E5zO7EXmFnpDZMuELnCLKOjCdy2a0+tCjqSkCkjS2PSwrhHB10j7aAf
         ccAD4Bv3eKY5ISFyyX6bkCRdZJdRrpkkLyzt59soArjBnuVhSFgMl9Ay2MNKEuuN6Bid
         VIKY3D4jdHBqnh6g3t3c6xOHyES3SAItmfkLsAuurAdX50JE2Te7CdQFv95OUTtjcezL
         1+peksgdQIgNMRsOtj8dbA9DcXSD52zUFKUj+a4qh5Q5E6QDx0ZVmvQu/LeAsS6Boo5h
         daOg==
X-Gm-Message-State: AOAM531Ogb1ETIJ53APtd+bEZCjV9bkv2WZ95HpUu/20KZr9D95aK/LQ
        5j9gRdfMrX4PJ1tOmhtoQ/bfY/ZwMv9+xEO3vPA=
X-Google-Smtp-Source: ABdhPJw+Can2AU+2I/7MS8Womcbu9DCD/kQRF0DKJ+Hu4yv0U5p7aR1NrjrohPfM3lawwpTgHoFS/6yKoTkfIslESHc=
X-Received: by 2002:a05:6808:1883:b0:2ce:ec3b:fbe with SMTP id
 bi3-20020a056808188300b002ceec3b0fbemr4598310oib.307.1645182579200; Fri, 18
 Feb 2022 03:09:39 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:ed5:0:0:0:0:0 with HTTP; Fri, 18 Feb 2022 03:09:38 -0800 (PST)
Reply-To: tonyelumelu5501@gmail.com
From:   POST OFFICE <postofficetogo2@gmail.com>
Date:   Fri, 18 Feb 2022 12:09:38 +0100
Message-ID: <CAMPPJo2ix3sN3aQL_8GAXfqW66bfiT8RtBPeaPZhXxnjyws4Eg@mail.gmail.com>
Subject: =?UTF-8?Q?I_nderuar_pronar_i_post=C3=ABs_elektronike?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,MIXED_ES,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:235 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [postofficetogo2[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [tonyelumelu5501[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [postofficetogo2[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.7 MIXED_ES Too many es are not es
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Mir=C3=ABsevini n=C3=AB e-mailin zyrtar t=C3=AB I.M.F. Znj. DREJTOR. KRISTA=
LINA
GEORGIEVA. RAPORTI YN=C3=8B: UBT (UNION BANK OF TOGOLESE)

Dita e mir=C3=AB: I dashur pronar i emailit!

Jua d=C3=ABrgova k=C3=ABt=C3=AB let=C3=ABr nj=C3=AB muaj m=C3=AB par=C3=AB,=
 por nuk mora vesh nga ju, nuk
jam i sigurt n=C3=ABse e keni marr=C3=AB. Dhe prandaj e them s=C3=ABrish: S=
=C3=AB pari,
un=C3=AB jam zonja Kristalina Georgieva, Drejtoresh=C3=AB Menaxhuese dhe
Presidente e Fondit Monetar Nd=C3=ABrkomb=C3=ABtar.

N=C3=AB fakt, ne kemi shqyrtuar t=C3=AB gjitha pengesat dhe =C3=A7=C3=ABsht=
jet q=C3=AB lidhen
me transaksionin tuaj jo t=C3=AB plot=C3=AB dhe paaft=C3=ABsin=C3=AB tuaj p=
=C3=ABr t=C3=AB
p=C3=ABrmbushur tarifat e transferimit t=C3=AB ngarkuara nga opsionet e
m=C3=ABparshme t=C3=AB transferimit, shihni faqen ton=C3=AB t=C3=AB interne=
tit p=C3=ABr
konfirmimin tuaj 38 =C2=B0 53=E2=80=B256 =E2=80=B3 N 77 =C2=B0 2 =E2=80=B2 =
39 =E2=80=B3 W

Ne, Bordi i Drejtor=C3=ABve, Banka Bot=C3=ABrore dhe Fondi Monetar Nd=C3=AB=
rkomb=C3=ABtar
(FMN) Uashington, D.C., n=C3=AB bashk=C3=ABpunim me Departamentin e Thesari=
t t=C3=AB
SHBA-s=C3=AB dhe disa agjenci t=C3=AB tjera relevante k=C3=ABrkimore k=C3=
=ABtu n=C3=AB Shtetet
e Bashkuara. ka urdh=C3=ABruar Nj=C3=ABsin=C3=AB ton=C3=AB t=C3=AB d=C3=ABr=
gesave t=C3=AB pagesave t=C3=AB
huaja, Banka e Bashkuar e Afrik=C3=ABs Lome Togo, t'ju l=C3=ABshoj=C3=AB nj=
=C3=AB kart=C3=AB
VISA n=C3=AB t=C3=AB cil=C3=ABn fondi juaj do t=C3=AB d=C3=ABrgohet (1.2 mi=
lion dollar=C3=AB) USD
p=C3=ABr t=C3=ABrheqje t=C3=AB m=C3=ABvonshme nga fondi juaj.

Gjat=C3=AB rrjedh=C3=ABs s=C3=AB hetimit ton=C3=AB, ne zbuluam me shqet=C3=
=ABsimin ton=C3=AB se
pagesa jon=C3=AB u vonua n=C3=AB m=C3=ABnyr=C3=AB t=C3=AB panevojshme nga z=
yrtar=C3=AB t=C3=AB korruptuar
t=C3=AB Bank=C3=ABs q=C3=AB p=C3=ABrpiqeshin t=C3=AB devijonin fondet e tyr=
e n=C3=AB llogarit=C3=AB e
tyre private.

Dhe sot ju njoftojm=C3=AB se fondi juaj =C3=ABsht=C3=AB kredituar n=C3=AB k=
art=C3=ABn VISA nga
UBA Bank dhe =C3=ABsht=C3=AB gjithashtu gati p=C3=ABr t'u dor=C3=ABzuar. Ta=
ni kontaktoni
Drejtorin dhe Drejtorin e P=C3=ABrgjithsh=C3=ABm t=C3=AB Bank=C3=ABs UBA. E=
mri i tij =C3=ABsht=C3=AB
Z. Tony Elumelu,

Ju lutemi kontaktoni menj=C3=ABher=C3=AB Z. Tony Elumelu, DREJTORIN E BANKA=
VE T=C3=8B
BASHKUARA P=C3=8BR AFRIK=C3=8BN, sepse KARTA juaj VISA e ATM-s=C3=AB tani =
=C3=ABsht=C3=AB
miratuar p=C3=ABr t'u dor=C3=ABzuar.

Adresa e E-mail: (tonyelumelu5501@gmail.com)
WhatsApp Tel: +228 91889773

Ju lutemi d=C3=ABrgoni atij informacionin e m=C3=ABposht=C3=ABm p=C3=ABr do=
r=C3=ABzimin e
kart=C3=ABs suaj t=C3=AB akredituar Atm Visa n=C3=AB adres=C3=ABn tuaj.

1. Emri i plot=C3=AB:

2. Mbiemri:

3. Komb=C3=ABsia:

4. Adresa juaj e sht=C3=ABpis=C3=AB:

5. Numri i telefonit:

6. ID-ja ose pasaporta juaj N0:

Un=C3=AB jam n=C3=AB pritje t=C3=AB konfirmimit t=C3=AB t=C3=AB dh=C3=ABnav=
e tuaja personale, k=C3=ABshtu
q=C3=AB ne do t=C3=AB vazhdojm=C3=AB me d=C3=ABrgimin e nj=C3=AB sh=C3=ABrb=
imi korrier p=C3=ABr t=C3=AB
d=C3=ABrguar kart=C3=ABn tuaj ATM n=C3=AB adres=C3=ABn tuaj t=C3=AB sht=C3=
=ABpis=C3=AB n=C3=AB vendin tuaj.

Me p=C3=ABrsh=C3=ABndetje

Znj. KRISTALINA GEORGIEVA
(FMN) president.
