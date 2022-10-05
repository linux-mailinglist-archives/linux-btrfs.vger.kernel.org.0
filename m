Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8515F58C5
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Oct 2022 19:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiJERB5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Oct 2022 13:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiJERBq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Oct 2022 13:01:46 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5970F399F8
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Oct 2022 10:01:44 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id w70so4105443oie.2
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Oct 2022 10:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vivCtzkQG7g0eBcE/Fz1UBJxj1jskVP2YhF+Htxj5+U=;
        b=Vo/C4V0+564cqbZja7clrDFSjRAwmM+20vApLbKeJRjAw7lfQzEAi5IJt8I6JNgmTy
         LcXUW3EB5NQo6xyxVR3Yome27UYvYHljZXIJfvM+TAPTAs0fNgbyFJwTQMTTnj/MN2q2
         8JmabOUYHE3Y36yEOvJAy/741W0bI2IWAzAr94yrLWvokGcd6aW4CmUXJnOqm2gKvi5L
         1/YQ6TflihTr/ruLSQWdMLVnWZuvPwHe45BzvcWn3+VQ/nG4wGuVnOT/NdgATnzoqL+p
         uOuUn1zPsraDygJWtX7LUwxvhQJPYWJYG158J3fsHY1askN5F/su9ZciGfSikKBIxgnR
         t0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vivCtzkQG7g0eBcE/Fz1UBJxj1jskVP2YhF+Htxj5+U=;
        b=uDYET/snn/yclA19HeF6Q0eFTIeooMDtB9pPf+/1Q0INQ38qsP76H1m9dFLWivYIKF
         YZZxODdKAfXkYbULY9+ytNGfkokLWoaF84OBmqPjaDJOGwIydVSlssO0hnBqL3qWZ7xK
         gREgslA0p0/AgaWQxAVgHtat89cUOoKBoBeGp+fQFBVfMW9huW47PCa/6borEsENo7Fe
         wyycFgYxNlKJqhN7mP2NwOguV0+5WhBXFnwiO2YGn2kKUh1pHqXJfg1oQRuYwmU8A94c
         ttgAB+5AFs2Zen+XQVKzrpCiOzXP06HuNCy26+yBjT0v6MamLniw8PtpmSo4iTCd+ssB
         Lt0A==
X-Gm-Message-State: ACrzQf3iqySObM1Zk7n7UlmpdYBju4c6eJ/P75BIQjYzqHm9SEaM2r2I
        vCQWucNmy1pnU0PBy+1d+XcpCNFmItLJBhn43f8=
X-Google-Smtp-Source: AMsMyM4QH0uVfcLuPstzuDoer3fdzjxAhNLa8f4tO+Th7LeIWomiy0jG/+J5P20swNQb/k4pL1Q1KjRar95wziz8SzU=
X-Received: by 2002:a54:4010:0:b0:34d:8c4d:cbe6 with SMTP id
 x16-20020a544010000000b0034d8c4dcbe6mr382075oie.48.1664989302913; Wed, 05 Oct
 2022 10:01:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6808:bd1:0:0:0:0 with HTTP; Wed, 5 Oct 2022 10:01:42
 -0700 (PDT)
Reply-To: timdulla46@gmail.com
From:   MR NAMARA <adiljude1245@gmail.com>
Date:   Wed, 5 Oct 2022 10:01:42 -0700
Message-ID: <CAOfoY9Ms5yttprnaT4kzyfLmh2m2RhwHnbs4Bb96SBBNcLKAQw@mail.gmail.com>
Subject: =?UTF-8?B?TllFUlRFUyBEw41KIEZSSVNTw41Uw4lT?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:241 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [adiljude1245[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [adiljude1245[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [timdulla46[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LOTTORI NYEREM=C3=89NYD=C3=8DJ.,,

Az =C3=96n e-mail c=C3=ADme 2 600 000 milli=C3=B3 doll=C3=A1rt nyert a Fire=
 Lotto
Company-n=C3=A1l. L=C3=A9pjen kapcsolatba Edward Raymond =C3=BCgyv=C3=A9dde=
l az itt
tal=C3=A1lhat=C3=B3 e-mail c=C3=ADm=C3=A9n (=C2=A0 =C2=A0mveronesi21@gmail.=
com=C2=A0=C2=A0=C2=A0 =C2=A0), =C3=A9s k=C3=A9rje a
nyerem=C3=A9nyalapot az al=C3=A1bbiak szerint. teljes neved, orsz=C3=A1god.=
 az
otthoni c=C3=ADm=C3=A9t =C3=A9s a telefonsz=C3=A1m=C3=A1t. ezek az adatok s=
z=C3=BCks=C3=A9gesek a
sz=C3=A1ll=C3=ADt=C3=A1shoz.

=C3=9Cdv=C3=B6zlettel..
Bacia Namara =C3=BAr
