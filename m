Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADD04F0111
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Apr 2022 13:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354635AbiDBL3W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 Apr 2022 07:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352517AbiDBL3W (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 2 Apr 2022 07:29:22 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C4E1A6E52
        for <linux-btrfs@vger.kernel.org>; Sat,  2 Apr 2022 04:27:29 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id v206so4968614vsv.2
        for <linux-btrfs@vger.kernel.org>; Sat, 02 Apr 2022 04:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=SUWQMmwZSct1NUq5pHL/uGOr0m/f9iWjJQkP63QJuAY=;
        b=pDVvahDJK+F34gvvKTC4EonMsJxfKNBPuVbURWwpzqzXo4vhpmwnThKnxX0dNHs8vd
         wr0dPWMDvUtvlIdU8nq2/m6zjLFhmknCHkFIULi7hCjgbWQWm59cAjeZcowY1LHRgY12
         n/7WCC2bmg1946Ck51kBREPeSjgDb4mEkSnLEdgtDfMssTK0x2ZSAg37Z23HHveK8kss
         nc2WedJ969bOG+YvwCar7DnAfu+uokP9s15hgKazMsT9V676XAcszY7j1r1EPWtFH4R4
         Dv1FXs9HtZY06zqtM0USWiBg1ue3p6+fE0nhGYPT5H+4jse8Qw4s8FaqHeKMKD/x0HqA
         9PfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=SUWQMmwZSct1NUq5pHL/uGOr0m/f9iWjJQkP63QJuAY=;
        b=aI3hDN1cMHKHcu4XCbmJ1ioCEStmUbVYnAsSc7fHUj2P00440IzxJoXN7UWwn+XY+y
         yT3qIWgNnx8mUnhZvjLbVL4t301U0AMn8HmHdMOyVSfeUr6+vD4ZFFvhFrbupavibAto
         NkNRzhYjVq6T1DKV/W1SiWjHeToa3/xURgmXojEvSHnh6IVw9am5VAE1Q4/xrF/oySYk
         1WvZkl+kgM3LaBQfMzsYVfbuLOwsAQ3sYheOv1m+PrhwcPCmWfnchaCDb6Z0I4UCCHmV
         8GBxlbA7sgHgvMrSHCkAKN5LdfaXKtQCR8PyL8cmkD0GmizP3IQlju22eZQpCcjNvJoe
         g0XA==
X-Gm-Message-State: AOAM533aaDaljxiFAMy4Y1H7a7KmwMjA61DEoOAKzWIsAEHk1XVpvc8p
        CoG/8ULn6Vca9l9QJTOeQ51tdk3V+3M9JdKrX8Q=
X-Google-Smtp-Source: ABdhPJzcSl/9sHH31Zd+WDFsBcDuyiBrJ4wJ5vImqnK6hSFEsHpm09H0LZGEKe25r/wS6CJHUOtBeK6l+B6cl/WoLY0=
X-Received: by 2002:a05:6102:f11:b0:325:a45b:e59a with SMTP id
 v17-20020a0561020f1100b00325a45be59amr4653239vss.12.1648898849055; Sat, 02
 Apr 2022 04:27:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:be31:0:b0:2a3:ca36:224f with HTTP; Sat, 2 Apr 2022
 04:27:28 -0700 (PDT)
Reply-To: jub47823@gmail.com
From:   julianbikarm <ellagbete100@gmail.com>
Date:   Sat, 2 Apr 2022 11:27:28 +0000
Message-ID: <CAAGhSLJe1dP=mr7KOQSadwUbvSZ4NB5eW6zN+y-mqJwUnFuLoA@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e2f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4694]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ellagbete100[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ellagbete100[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [jub47823[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dear ,


Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.

Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Julian
