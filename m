Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD7B4E6F98
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Mar 2022 09:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355745AbiCYIur (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Mar 2022 04:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352728AbiCYIur (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Mar 2022 04:50:47 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8167853A4A
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 01:49:13 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a30so1921337ljq.13
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Mar 2022 01:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=8YEVwsc9MadawAcLHO3G9CfSrn5Ex698wnXtSUPecl0=;
        b=Ut3pEoj6sWwttd873ZMMd2gIKGuYvF3rvRLjoKz7MQxucNLTPbYHtZVeykeRKtjgbV
         XREID4zarok0o4xykcp5TSFCKxZzPI4PXMyOYw68Xwsr8NShOMqxS2j32A1RfZETzPXX
         yL12YXwk+1jnZ+4KtKoPL/MkidE+gfHJhstJW60r/R8TQ0p88SLEHPlpomRjyl70fvjl
         jy3VcTnCzxC5aBDaXc70yL+8hJ52MXyPg4z/GR7F2H25TJubFQEAiJFEq5fKvXdSVdUb
         rL8ju5DV/0dD/l62V2EPe47zbebopykd/GMwwR9NEb6rw1GAEOyeakfLU9WL9otZX7gz
         X7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=8YEVwsc9MadawAcLHO3G9CfSrn5Ex698wnXtSUPecl0=;
        b=yF2NuTWpKhG5cWFGzZyPPnEKiLP44Q/5tinDbolRxZa9yTVe5afSiWbkEDCWU8Fr/I
         8fRKI2OQhHvHoRXyVkrpUtEi4u7IP4sT9PXjZZEKmc6NQX7irD38W7oLeIuItdiiVj7T
         tkUYSHAGjST5aculonBKtg0qinjXM2ketpUaf0CNDmu3IeWadRUY6wX1qk3WVflB0OWL
         u4gEcgoevMUjN3jYdJPxAHSW4ja7JyyksSJ5QW6W9xjdEp6d7+Ru+8oMWQJJ+Y+Teqwq
         fMZglKf/13/BpIhbTAvChtK1768QcDGGFpwEi9s7iEYnbxhHTpA7UlyCLFFUxsXbIDlR
         Nl1Q==
X-Gm-Message-State: AOAM533QH5ZQlMUUQ6ZlUR3pgMzCUpDdPR8LzI+mDcHQ8wRDXOZjumVS
        GTHPainNNdT3X5rBFQRGE7LXqf1ptBDy0jev9Rc=
X-Google-Smtp-Source: ABdhPJzk21zwlQIM1IqevxeB+DRJRV4eAjmeLLLcdeOaVEFIRJXfN+9aFkmRelZJ2uSMkZ3sPJQoJ+zACXid4GS2g+U=
X-Received: by 2002:a05:651c:a0e:b0:249:90c8:453d with SMTP id
 k14-20020a05651c0a0e00b0024990c8453dmr7188078ljq.399.1648198151928; Fri, 25
 Mar 2022 01:49:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9a:45cb:0:b0:1a5:ccd8:68b4 with HTTP; Fri, 25 Mar 2022
 01:49:11 -0700 (PDT)
Reply-To: rw7017415@gmail.com
From:   "Richard K. Wilson" <barrs.richardwilliamskone@gmail.com>
Date:   Fri, 25 Mar 2022 08:49:11 +0000
Message-ID: <CABK2ONSr-d6ph9YTdxvjAx-=1vdCZ-9YWXR=hfgmOTUWv7ZAaQ@mail.gmail.com>
Subject: Deposit
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:241 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4286]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [barrs.richardwilliamskone[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [rw7017415[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
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

I am contacting you to assist retrieve his huge deposit Mr. Alexander
left in the bank before its get confiscated by the bank. Get back to
me for more detail's

Barr's Richard K. Wilson
