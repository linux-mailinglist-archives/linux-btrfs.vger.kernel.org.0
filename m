Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234AB7344D0
	for <lists+linux-btrfs@lfdr.de>; Sun, 18 Jun 2023 05:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjFRDeq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Jun 2023 23:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjFRDeo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Jun 2023 23:34:44 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7841E4C
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Jun 2023 20:34:43 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-55e41318185so178323eaf.1
        for <linux-btrfs@vger.kernel.org>; Sat, 17 Jun 2023 20:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687059283; x=1689651283;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wWTmMQSsiLodfdKu7C8lcuyX7WesZia949PML8BXbEI=;
        b=OtgLRtPllh3KDqzqNkqOxvsXSvSSXHDpxV5kDngJMLEbQEU9XnzIKFQjqy29iEU2nz
         EPn3fG7gpTQvoQ/pP+dvWLXpF4hDnM2VJGFHIduapzx1ik4KfScwkrj+wSPjVMItBTLf
         sMNvDk53IVTwNox43sp/m/V/LEOVKgaLOJhSZwvj5R7sxPpQDzaXaGRh4K8NY49w2Nfs
         IRB8MmupyUliJ9qLJgtyEkkeXwIVbQSwx8NnkMOdxNP/4JFF/2dEVq7UulxzqfMauN8W
         6PknazULb6qu461Xk042bGcTvss/tYX4PP43bT3M0x/e6doC35rBJPC7ruBXKYOsEV8c
         /r6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687059283; x=1689651283;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWTmMQSsiLodfdKu7C8lcuyX7WesZia949PML8BXbEI=;
        b=ki7mmlyclsmgsu5G2642rRN7nIky+H0ww0qHTX83cPBdU4nv+TKGXFdzdk8ycpwE1s
         UiwnxoiAyIg1Hbv4pnLnRyx7jF3z3wF3yUbyXR1SoNW/rjHhFu/xbnIry25kclx2568V
         AX43zJRxBO3kTq1FgecD4hMzDEisRhA5x0SuRVSLYS5i3iSkk5SQac/zYRoE4Sg5B9vF
         DU8e9vsfsEEcLbhD1N/dS2EGzZXseO9aV89PZJlogwmldF7Fs3s0TP6i04v5aOJwjHGv
         cH+Y/+4+TcVtXqLmOY0EsC060dCmtvCo+pkvxcVmnG45pyLc41XhY6cUcdaE9AHEBU7e
         0Qxg==
X-Gm-Message-State: AC+VfDxLE9/aHQXVaMwdPxWP/Gq5Oj6BqVaUsuahTE6qEy9xbYnQdjYD
        sWqj1EFM0j27jBiDT1pOziS1swIb35+c1DcZHWs=
X-Google-Smtp-Source: ACHHUZ7a4dNypGX/aJqQ1WulH57GCGDIykIQMmkdHAPooAyMoVqEX+NAA4iLdv7a+ywATf0I8koMN2k7YbyMisbp8P0=
X-Received: by 2002:a4a:c90d:0:b0:555:5106:c483 with SMTP id
 v13-20020a4ac90d000000b005555106c483mr3777727ooq.6.1687059282952; Sat, 17 Jun
 2023 20:34:42 -0700 (PDT)
MIME-Version: 1.0
Sender: hubertinecoul@gmail.com
Received: by 2002:ac9:5b55:0:b0:4d9:6a76:96b3 with HTTP; Sat, 17 Jun 2023
 20:34:42 -0700 (PDT)
From:   "Mrs. Ruth Roberto" <robertoruth48@gmail.com>
Date:   Sat, 17 Jun 2023 19:34:42 -0800
X-Google-Sender-Auth: EBgydHfYtTc1Bwz0jVUFv5mDDyg
Message-ID: <CAAEzwMkozf_mGGa_63FrQi4KDieW4NzGNnVpQPYBnJanzu9mtw@mail.gmail.com>
Subject: I trust in God
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        MONEY_FRAUD_3,NA_DOLLARS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear,
It is true we do not know each other before but please bear with me,
I=E2=80=99m writing you this mail from a Hospital bed. My name is Mrs.
Ruth Roberto. I am a widow and very sick now. I am suffering from
Endometrial Cancer which my doctor has confirmed that I will not
survive it because of some damages. Now because of the condition of my
health I have decided to donate out my late husband hard earn money
the sum of ($3, 500,000.00) Three Million, Five Hundred Thousand Us
Dollars on Charity Purpose through your help.if you are interested get
back for more details.
Mrs. Ruth Roberto
