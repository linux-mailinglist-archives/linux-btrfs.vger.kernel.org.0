Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2AD5BB81A
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Sep 2022 14:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiIQMEb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Sep 2022 08:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiIQMEU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Sep 2022 08:04:20 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFC239BB4
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Sep 2022 05:04:17 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id e35-20020a9d01a6000000b0065798eb8754so7553666ote.2
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Sep 2022 05:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=YrZzsr76o+8cdLFX9duugjxnFaPrysczJIfNK8qi1Go=;
        b=VDe23Dd1g7NWJStszN+Q9I/jYEFUIDXUWFjPcelth/mADAdIhc4WKd6SbVekkE85M4
         GHx+mKbJoK6MD9M1nUUqz4RyRFYo+CQo3+MAUwPO9B2WmX1g3ziwV4fqDGXpDRmj3ehV
         Ccu3AW76z9AqSa3gzDBFEdblrvG4H/pJMvL1xd5NIU0wj9Wh3TXb0aHl5ljuUEqRVyAk
         g1n2c6gZFGm7BRimL9kQzOAgRcqcwAJjnPHYAPVk4Wo5C/5a2Ocwz2yJpUpPJq9q7C+K
         17yDWwA4idiCJDAZO45Cam8K99zmdRXoADinovu/H9iXfEQc/9S6dX9m5Q6dGIoaIFka
         9NJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=YrZzsr76o+8cdLFX9duugjxnFaPrysczJIfNK8qi1Go=;
        b=nGdpkGmOsSHfgl3uW2nsVNuQO5/83CZni2Yabi8qLGTzLHcoA9qumuqQ+TjewUufvc
         NgO1aJ/07vfnG/G9D4Znr35xP9TibSY//FLNeOrvjj0YjOejuCINJvihYatAt23PlxqS
         ynRMdgc+2zYeW0fUEji9umaEGPgSNZ+Su0ayWydKs8PnxKevSNvS7qcOsoOOpw7871v8
         3+LKopdBTBn+oCz1mrXosZ/yqKWWxp7ANcYHh9T8DdRZWg9QM4+SFSglUzAsPo5CTluE
         1Hgy43cSQNQVJWTS8sb0z2ToURSE69Koloi8KcYTZDCft6I1NPiuOTMaPFD3XdVMnupQ
         UUjw==
X-Gm-Message-State: ACrzQf00znZ1vslYUtC0LbWWzqtLQXyt724GqGWx3ublmsUkjd3dF57d
        +Ob86R1AAsz6TWr9cjDO0kFfM6zF1c2NPu9Xlj8=
X-Google-Smtp-Source: AMsMyM5yPtgxcvoHBsWl+I87mct0+/MZvdreroyMsHYL7QNRY2S9cNp0cYH6P8yp9kKpjT1NTMzGcpgLkOKdeFcYqaw=
X-Received: by 2002:a9d:53c6:0:b0:63f:832a:f710 with SMTP id
 i6-20020a9d53c6000000b0063f832af710mr4157072oth.211.1663416256327; Sat, 17
 Sep 2022 05:04:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6808:1b27:0:0:0:0 with HTTP; Sat, 17 Sep 2022 05:04:15
 -0700 (PDT)
Reply-To: abraaahammorrison1980@gmail.com
From:   Abraham Morrison <drjameswilliams1924@gmail.com>
Date:   Sat, 17 Sep 2022 05:04:15 -0700
Message-ID: <CAPBADDEGoVKLKgbi6Q0xng2+iwoxRX5LorkpSCaz00ssOf=wHA@mail.gmail.com>
Subject: Good day!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:330 listed in]
        [list.dnswl.org]
        * -0.0 BAYES_20 BODY: Bayes spam probability is 5 to 20%
        *      [score: 0.1204]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [drjameswilliams1924[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [drjameswilliams1924[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [abraaahammorrison1980[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.5 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Uppm=C3=A4rksamhet sn=C3=A4lla,

Jag =C3=A4r Mr Abraham Morrison, hur m=C3=A5r du, jag hoppas att du m=C3=A5=
r bra och
frisk? Detta f=C3=B6r att informera dig om att jag har slutf=C3=B6rt
transaktionen framg=C3=A5ngsrikt med hj=C3=A4lp av en ny partner fr=C3=A5n =
Indien och
nu har fonden =C3=B6verf=C3=B6rts till Indien till den nya partnerns bankko=
nto.

Samtidigt har jag beslutat att kompensera dig med summan av $500
000.00 (endast femhundratusen amerikanska dollar) p=C3=A5 grund av dina
tidigare anstr=C3=A4ngningar, =C3=A4ven om du gjorde mig besviken. Men jag =
=C3=A4r
=C3=A4nd=C3=A5 v=C3=A4ldigt glad f=C3=B6r att transaktionen avslutades utan=
 problem och
det =C3=A4r anledningen till att jag har beslutat att kompensera dig med
summan av $500 000,00 s=C3=A5 att du kommer att dela gl=C3=A4djen med mig.

Jag r=C3=A5der dig att kontakta min sekreterare f=C3=B6r ett bankomatkort p=
=C3=A5
$500 000,00, som jag beh=C3=B6ll =C3=A5t dig. Kontakta henne nu utan dr=C3=
=B6jsm=C3=A5l.

Namn: Linda Koffi
E-post: koffilinda785@gmail.com


V=C3=A4nligen bekr=C3=A4fta f=C3=B6r henne f=C3=B6ljande information nedan:

Ditt fullst=C3=A4ndiga namn:........
Din adress:..........
Ditt land:..........
Din =C3=A5lder:.........
Ditt yrke:..........
Ditt mobilnummer:...........
Ditt pass eller k=C3=B6rkort:.........

Observera att om du inte har skickat till henne ovanst=C3=A5ende
information helt, kommer hon inte att l=C3=A4mna ut bankomatkortet till dig
eftersom hon m=C3=A5ste vara s=C3=A4ker p=C3=A5 att det =C3=A4r du. Be henn=
e skicka den
totala summan av ($500 000,00) bankomatkort, som jag beh=C3=B6ll =C3=A5t di=
g.

V=C3=A4nliga h=C3=A4lsningar,

Herr Abraham Morrison
