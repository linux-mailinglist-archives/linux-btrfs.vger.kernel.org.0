Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF8D6C3790
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 18:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCURCV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 13:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCURCU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 13:02:20 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D215829E2D
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 10:02:13 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id q30so4496859oiw.13
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 10:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679418133;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D3Zieg6iKLLprOskvl4Oe4qVSYRFzcX9T3MvIVJqTx8=;
        b=T/FQgWxQUYI+KeGiq9vOlqiMeJ6zq1xHceV6P+Yt3Kc39OSPTVhEthcNCdPEYdls0L
         nzlkMqEWaU219MuKXfwZVVbtMNaF0SKiZAtcSte3jKu96ewzACBxL8EcQi8ybfDCfDSj
         zzJdqLS5w+N7ytIT1EImC6UBKlnJt28A0JWluPssWTYT2bdUqdM3f08HYnAP4nZDdTfT
         ruSDCTFLi5mPArrLosKt8jIZI8fk6kSWS4h69dVfDaAGGPN/T0ZB206tSnUiejJCjQWf
         odvcmTFxUSvSBa0NHog57YQqECR+fxFu80YqwXhUrA9EKWhda1PzvbenC9zQMwmv2U36
         QL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679418133;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D3Zieg6iKLLprOskvl4Oe4qVSYRFzcX9T3MvIVJqTx8=;
        b=qv+BpttYuYNIh5s1qUlxaG88OYEX8Z76RL3UQLYk9r6MgHVZ0UWFewrkfMzim44tMT
         XmKBtcrSRdUZdHvW00juUhJGtVL6zo3X2US5vR72DHnKGwyeMt4vO8Olg/k+fCtYMbgw
         ThfzaJz3khZMWZywsB8i1FSZ9ezVgKfAeAW40bOUOxm5XcF0Dz4KhAWIYNPWE5cg0LCO
         XQv3RURdgsjj4TPa/tZfVYA9FrIxzwBmBa1ALXVavn8WlyuKGa48cCkAQBVtzebbk1I3
         NDKK/TkGJIJyWm/gGHS78SNqKYRQU4NlpbJhCo8MUxfi0BucsE93k5blKyOLvfBfHVNB
         rcgw==
X-Gm-Message-State: AO0yUKUiCjs6jrVz6LyDfPG/J68erdNTG34uUeF/Vundfa1OrAjupQoI
        vUo1IlMDcS++CmhO5nWmkTAGtnNRdceK5K29RZ0=
X-Google-Smtp-Source: AK7set/zNfcxhZrjbb4iJSOgLfYSIUN+tqsuUETAgMKvSIXhNvo6P5I4RoZKc0tG82AvPOuay4Z6AEqSfeui3++oR8E=
X-Received: by 2002:aca:1a0c:0:b0:386:9b6f:f300 with SMTP id
 a12-20020aca1a0c000000b003869b6ff300mr889583oia.5.1679418133123; Tue, 21 Mar
 2023 10:02:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:91a:b0:110:6f3a:441d with HTTP; Tue, 21 Mar 2023
 10:02:12 -0700 (PDT)
From:   Majid Khaleed1 <majidkhaleed498@gmail.com>
Date:   Tue, 21 Mar 2023 10:02:12 -0700
Message-ID: <CA+iBonmP0XWr+2fopNONRttAiDJowV9sX5HnQhqrU+k7cqVDzg@mail.gmail.com>
Subject: Quest for a reliable partner
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.9 required=5.0 tests=ADVANCE_FEE_4_NEW,BAYES_99,
        BAYES_999,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:241 listed in]
        [list.dnswl.org]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [majidkhaleed498[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [majidkhaleed498[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.2 ADVANCE_FEE_4_NEW Appears to be advance fee fraud (Nigerian
        *      419)
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Greetings Dear,

My name is Mr Majid Khaleed, I work with an oil and gas Company here
in United State.
I need your honest cooperation to partner with me to invest in your
company or in any other viable business opportunity in your country under
mutual interest benefits. Our partnership will be legally endorsed,
Please I will also like to know the laws as it concerns foreign investors
like me.

I look forward to your cordial response.

Best Regards,
Mr Majid Khaleed
