Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57AC9620E6E
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Nov 2022 12:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbiKHLR7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Nov 2022 06:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233791AbiKHLR6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Nov 2022 06:17:58 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3FF18382
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Nov 2022 03:17:56 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id i5so6856264ilc.12
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Nov 2022 03:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1oIX0Lu3jFWZXVxNPQntM2Fj3qbMNn8z1UsbYrWkRo=;
        b=b/nqwpiy3v4jYhITfns+ZxHNIOX1V2TbM7Yj7F2827mublcqyO5X+7RRPBjo94c+ND
         AD/zHunOPWIRGs4PmAnz6lyW/YipM7dzF5lcRRh3J6FvpnbzrWl1wTDLyBWjtsnImrKY
         jXmB8DFOapjeP3KM1/0lovNSDBGkRsS9OzP3qHztTmdX92sMJ3cVUZoR9df9OEf5Q3b2
         BpyNrns7KIxiDlS143hxih4e0jbig5fdNtBiK+8fA+mhK0DOKPbx2iZ5JTNtTj82fpTy
         PTSzQiaqw3kHQ7o2EcoFPMVZBgRYLo4I84W59bt94JOSyWeoor3fKeDQQY+7oKYjvpyj
         pu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o1oIX0Lu3jFWZXVxNPQntM2Fj3qbMNn8z1UsbYrWkRo=;
        b=IrPYRNdLoK8zCMKjAPTdTyEA8hoOXeNhToSe60lBfX6yNxyO4mrZyVldGfGoFeWhcl
         tKaXXBUtiKCZXJ+KnTEOJOYJPwv91P3lhNQHDuprxUPrrG3bf40MI03bU1qsgHZGmMcA
         5g4cyzb0xWuhaObrq0lBhM9e+n3W7rn/fo1NPRDNexSpNEJe+D7RA47FhuSDA/FySSCG
         16013nQZbrp5xy41TALDdKCId/zeIT8SsZyLTXULpA7e+RH6ER85vdHccEbJXCKgXQyN
         Ye0H+Zs71IMkme/0+e5RXRFwlkiLef0zR7KTFjyD2+2zvk3tBj09EBlBPXUQeWqCNObh
         QcoA==
X-Gm-Message-State: ACrzQf08NxBJsC0VmlQTTEDnt3xoRSFU73e3eOhbfRNXghZGvx7P28xz
        GdtPas4KXlxUtmP3wAihdiEUQqCE+r4SeT30wtE=
X-Google-Smtp-Source: AMsMyM6T0fJcR6X7G+COMC8/T5giP1hmkU8jH1E1E+Ut1X2g0GaE9ENYj+9SigWYypKmYWS9fhn3/+ivtrvB7E/ouPk=
X-Received: by 2002:a92:3405:0:b0:300:ef1f:91c5 with SMTP id
 b5-20020a923405000000b00300ef1f91c5mr11491640ila.317.1667906276336; Tue, 08
 Nov 2022 03:17:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6638:38a9:b0:375:4a9b:180d with HTTP; Tue, 8 Nov 2022
 03:17:55 -0800 (PST)
Reply-To: mrinvest1010@gmail.com
From:   "K. A. Mr. Kairi" <ctocik1@gmail.com>
Date:   Tue, 8 Nov 2022 03:17:55 -0800
Message-ID: <CAKfr4JVw5nELsy4=NtyqUNj9MohDMzSf4taL8P_8MBuBkA+sog@mail.gmail.com>
Subject: Re: My Response..
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:12a listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5011]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrinvest1010[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ctocik1[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ctocik1[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

-- 
Dear

How are you with your family, I have a serious client, whom will be
interested to invest in your country, I got your Details through the
Investment Network and world Global Business directory.

Let me know, If you are interested for more details.....

Regards,
Andrew
