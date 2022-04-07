Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF1E4F80F0
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Apr 2022 15:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240165AbiDGNt1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 7 Apr 2022 09:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiDGNtZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 7 Apr 2022 09:49:25 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65ED299685
        for <linux-btrfs@vger.kernel.org>; Thu,  7 Apr 2022 06:47:23 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id a127so3682691vsa.3
        for <linux-btrfs@vger.kernel.org>; Thu, 07 Apr 2022 06:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=SUWQMmwZSct1NUq5pHL/uGOr0m/f9iWjJQkP63QJuAY=;
        b=aQvftbaInKs0sgdRp3fR7c+KuKWgjuyDLbbi2Xwrt53wMdA2LqrwSczR9b4HBQV9tl
         YLYwHeh+nD3kSq4sqZQSImBw8RiypTN74Q56H3UXDRhz+vtuZRbav+UvMu/0EyrOM3Hv
         1MW4QM4V4FWk4eQWeFpVDE94IJOHc26vGxxektGACRntnLRUngpZjE3OYu5X6Xi4byh9
         p/+dS38ZqZI46gpiqeh1zRej8PXIw30LrPqie308N0AntsJcPPzib9pTkae0yApMPW5F
         FKXxVOvJTUEmi5mKEVp5PwpJTlZ9uvK2/sOdy2h7BM1DYmw3gx72hXYaJDBRewTkFVxT
         8O8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=SUWQMmwZSct1NUq5pHL/uGOr0m/f9iWjJQkP63QJuAY=;
        b=YNAxnKcd+WfZe2UYDqRkSnxTvBuio1lSKYBotkTy5ustffLC/0QEd8PF1mqrUBPmS2
         V5pXRgqQ9YGYXFdwDZtU+/DWyPZlwups9E/OsEbegJmWucHAUR2WxIXoGW88ILX0W1/b
         IN4orAcJzsRfNM4l4oNgcxeBjpjWbo5T2HuoH7a4kHxGZq9JvJuOUN4iPfvaDHjetZUV
         pG/MgTnQ+Ib7wd3YFjA1BE85F8O2MMsl4PkXZrNtXqxhHW0o76MaF05z+4WPpYiVDpmr
         GXt+fyawqjinTodThQktBGeT9t72wSBS/++NLZbIKY+MEhufk6KXurQstcHxoQ0GXT8n
         ujyw==
X-Gm-Message-State: AOAM533r8A5vvKWGPWloxJ8IS53WgpCjfn1/5qPIro5oJigdaM9qvIla
        jzwSxJeogp/Kaag1ELH6qJ59mgnuxyJqjlpV2ok=
X-Google-Smtp-Source: ABdhPJwKIK0E1vGjDiPsrzrzja4vb+7xOmKEZaqZS5D0kyNRx8e38wuJOOZ9WbvAOobBhGea1NNvTi5Ndmkgw3Zlq8Y=
X-Received: by 2002:a05:6102:3592:b0:325:84f0:4b61 with SMTP id
 h18-20020a056102359200b0032584f04b61mr4607190vsu.12.1649339242503; Thu, 07
 Apr 2022 06:47:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:d718:0:0:0:0:0 with HTTP; Thu, 7 Apr 2022 06:47:21 -0700 (PDT)
Reply-To: jub47823@gmail.com
From:   Julian Bikram <woloumarceline@gmail.com>
Date:   Thu, 7 Apr 2022 13:47:21 +0000
Message-ID: <CAKM2rXtXVsRoxj2up5XYgh-zAi7a5k-_mK0GQkugy5aAJrjmYQ@mail.gmail.com>
Subject: Please can i have your attention
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e2e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4584]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [jub47823[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [woloumarceline[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
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

Dear ,


Please can I have your attention and possibly help me for humanity's
sake please. I am writing this message with a heavy heart filled with
sorrows and sadness.

Please if you can respond, i have an issue that i will be most
grateful if you could help me deal with it please.

Julian
