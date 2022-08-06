Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDC758B59C
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Aug 2022 14:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbiHFMop (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 6 Aug 2022 08:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiHFMoo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 6 Aug 2022 08:44:44 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87A8120B1
        for <linux-btrfs@vger.kernel.org>; Sat,  6 Aug 2022 05:44:43 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id 13so3379227plo.12
        for <linux-btrfs@vger.kernel.org>; Sat, 06 Aug 2022 05:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=vvtS89Fk2u1S3Szl4rrCs3KSXNS797GmNVbZS9fGKtQ=;
        b=Qo1hvAKNKbKGAWGuP0YYZsFXd8fOjNYPC4sdyPh0Evn+XUtdZieysidMMqrMNw1iDB
         KLEyFZICWue2kPVT4XDOXGhfoEjP7WdPziARua4dDnbA5oXMRHMZjVPzaEDnqsmjUswV
         Hno4tlsQQvIkVKXpC5/Cb+jVWgyKzWpkDh2euxDM1Ez+MvM67OufSxJvb7P5pDkbQFuA
         XUsSeKutyIXneYHzCen5t40ckeiswlkrzLj+vKpB8DgdUeX3Yj6UvDn/mUhHnww2xYNS
         JApjRzo9YmYzl3VC11FSDM2g7J211UwyJC64AqhSnXsrcxp+UqV66CdHY00t1WZ/rKEF
         llcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=vvtS89Fk2u1S3Szl4rrCs3KSXNS797GmNVbZS9fGKtQ=;
        b=kaAoNzAGaK/f/X2FASBsfiswGypdQjAfIIHEfvC9x7CJJ4EQ2RUcCXzB5Wlg3MVgYW
         Pv3yXyEH4joTusS3E3pz7H6P/kX2tGwicUzeRYfv5lXX7s/1cx6hGwyrTI457B1ziSze
         /98u+/rxeGmxnhE+72LPVPVtC+ktj2+L7mQmx/oDHFjaXm1z8qznHCX04IjuoqjTB5/T
         YcLJ2axxq9AsXRTof+xeiXSBs/xJbLDG52EnOyWwqGmdoMm5InwewmmGcMADioNb0ggH
         1OXN862x9cTkEHgUeYCApAhY08IhA6DlMY7z8Ml3wCYNwCIN5VWWLlDuqenW83X9MIpc
         l8/w==
X-Gm-Message-State: ACgBeo3gJAOgujvkIfCieseBJb2o+Vu5OKfGWHPYkKPeV3bJC6RK6+Mk
        cQ3L8/CxZ5TRM5vHojR9Vv+97gnrFEQCD/aev64=
X-Google-Smtp-Source: AA6agR7dahaci0GelMIdvptZdnLJIbZHB8Sc/k2+QkRPvTy8iso5psA4zftC3tmbC9wJdh8pd0LZxefPr7RKRKa0XBA=
X-Received: by 2002:a17:90b:1c85:b0:1f1:d78a:512b with SMTP id
 oo5-20020a17090b1c8500b001f1d78a512bmr20775176pjb.92.1659789882873; Sat, 06
 Aug 2022 05:44:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7022:6a5:b0:42:da81:5ab7 with HTTP; Sat, 6 Aug 2022
 05:44:41 -0700 (PDT)
Reply-To: cfc.ubagroup09@gmail.com
From:   Kristalina Georgieva <ubabankofafrica989@gmail.com>
Date:   Sat, 6 Aug 2022 05:44:41 -0700
Message-ID: <CAHwXt+z-5Q326inJ_6XRQxX5bTqq12yq=rUfhfgmUYA95ycoMQ@mail.gmail.com>
Subject: HEAD UUDISED
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,LOTTO_DEPT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Lugupeetud abisaaja!
Saatsin sulle selle kirja kuu aega tagasi, aga ma pole sinust midagi kuulnu=
d, ei
Olen kindel, et saite selle k=C3=A4tte ja sellep=C3=A4rast saatsin selle te=
ile uuesti.
Esiteks olen pr Kristalina Georgieva, tegevdirektor ja
Rahvusvahelise Valuutafondi president.

Tegelikult oleme l=C3=A4bi vaadanud k=C3=B5ik =C3=BCmbritsevad takistused j=
a probleemid
teie mittet=C3=A4ielik tehing ja teie suutmatus tasuda
=C3=BClekandetasud, mida v=C3=B5etakse teie vastu j=C3=A4rgmiste v=C3=B5ima=
luste eest
varasemate =C3=BClekannete kohta k=C3=BClastage kinnituse saamiseks meie sa=
iti 38
=C2=B0 53=E2=80=B256 =E2=80=B3 N 77 =C2=B0 2 =E2=80=B2 39 =E2=80=B3 W

Oleme direktorite n=C3=B5ukogu, Maailmapank ja Valuutafond
Washingtoni Rahvusvaheline (IMF) koos osakonnaga
Ameerika =C3=9Chendriikide riigikassa ja m=C3=B5ned teised uurimisasutused
asjakohane siin Ameerika =C3=9Chendriikides. on tellinud
meie Overseas Payment Remittance Unit, United Bank of
Africa Lome Togo, et v=C3=A4ljastada teile VISA kaart, kus $
1,5 miljonit teie fondist, et oma fondist rohkem v=C3=A4lja v=C3=B5tta.

Uurimise k=C3=A4igus avastasime koos
kardab, et teie makse on hilinenud korrumpeerunud ametnike poolt
pangast, kes =C3=BCritavad teie raha teie kontodele suunata
privaatne.

Ja t=C3=A4na anname teile teada, et teie raha on kaardile kantud
UBA panga VISA ja see on ka kohaletoimetamiseks valmis. N=C3=BC=C3=BCd
v=C3=B5tke =C3=BChendust UBA panga direktoriga, tema nimi on hr Tony
Elumelu, e-post: (cfc.ubagroup09@gmail.com)
et =C3=B6elda, kuidas ATM VISA kaarti k=C3=A4tte saada.

Lugupidamisega

Proua Kristalina Georgieva
