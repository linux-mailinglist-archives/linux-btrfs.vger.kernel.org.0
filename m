Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C5258B065
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Aug 2022 21:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241140AbiHET06 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 5 Aug 2022 15:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiHET05 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 5 Aug 2022 15:26:57 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A006474
        for <linux-btrfs@vger.kernel.org>; Fri,  5 Aug 2022 12:26:55 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id a89so4557499edf.5
        for <linux-btrfs@vger.kernel.org>; Fri, 05 Aug 2022 12:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=povr1txL26eqMnkUjTm+jj17d69s1kYQK+s7dzPhhhE=;
        b=Fsba0cKrRbNYec8j65a+mPYBBR9dV5ZsTkTVp9L8RJudF43KqoKDuoB2UPC3rQ+sg4
         /bqCRzVL9uTYwm2COfIty5gSaDGzNS3pDRT6p2JBsa74K9v6J0wCGkfjGzJd/OKizEh5
         WtTf/ZiMdh4WDe38xapwQCes30QUwSdgXSTy6fg7qrAcbWbZumG1lImsZ3YXFuvy6+6V
         W5B5UIf8sHKnmgDBtAx3W364sbEqOBArOeEhEu4pDGk+nWM5c0DC7/WVuLJj8b4NTMhv
         98J5SVB4EhxBmMDonmRPNhVEHHhn7i3MgXKF+ePVaWfy9uXcAjp7AaArTHY3FGMfqJOJ
         6UgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=povr1txL26eqMnkUjTm+jj17d69s1kYQK+s7dzPhhhE=;
        b=ZNtMUHqj/etPMhTHV+aKeTUS78aEpb476F2Jmz5jKpE67FdXDExLVQGpod5bt65wsm
         a9Xo9Zoew23wFeS+ux55/kENg/T+mHUM4BgMnddntdXjH+Zk9LFViLIR0ks2oz8eW1Xl
         JtayOoIMvohdZMlfGKn2Mg+72aSTNeFJpJVyYKI2SCNGIHUlrlBaRzxJ/rkD+XPN8wv6
         a3Lrx8DL1fHeW47vmsBE0p0W4G/1G66i7pAIujS8JvcYOiMzX409GrRZ9L/y1TWMNFji
         8WWPc9MFcKM6z3lM/RRbnw5CAGFACR0dU4GDdpnNk+/kj6oGG2XSRo1B1mRgLXjtimfU
         YIwg==
X-Gm-Message-State: ACgBeo1EkTtx17JVu2oNabxxIFvdQ4asnLPmdNn2izVbjnGIyT1RMdSI
        cHiwDb+AtgfWIEDoX/RkUB/YYvHadRLqoVH07XBSZEoN
X-Google-Smtp-Source: AA6agR5bj9TtXJSGPOKrU/jw7R1ECNPGiHKhdU79LVLdxMXXT8y6iv7Zm2xVB4U/ezyD1vN4BPvoLuiL9b6O8i3z5oc=
X-Received: by 2002:a05:6402:5106:b0:440:3693:e67b with SMTP id
 m6-20020a056402510600b004403693e67bmr2970865edd.226.1659727614010; Fri, 05
 Aug 2022 12:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAHs_hg1NTbSsoev93y0Sx6NguVKndR+d410yZzbMhii2ipaBcQ@mail.gmail.com>
 <CAO1Y9wo_HcouRuOa8b7+2bXwZJOHNiy9PsxcYxsQAZ8ggvTxzw@mail.gmail.com>
 <CAHs_hg3_KFLSC+kMpT+cbKuhUCJqwaYWcWL7R7Q1xT9_-xWvvw@mail.gmail.com> <CAO1Y9wo=5d4seXt0PxHNTvtJt=LDa_8FoK0YQETrX-nG8n35qw@mail.gmail.com>
In-Reply-To: <CAO1Y9wo=5d4seXt0PxHNTvtJt=LDa_8FoK0YQETrX-nG8n35qw@mail.gmail.com>
From:   Martin <mbakiev@gmail.com>
Date:   Fri, 5 Aug 2022 13:26:17 -0600
Message-ID: <CAHs_hg12AqGUiisiAEkST_9wtx+d-W8AZiGws4kc4zKSj9d6FA@mail.gmail.com>
Subject: Re: Balance fails with csum errors, but scrub passes without errors
To:     Thiago Ramon <thiagoramon@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Thanks for that info, Thiago! It was very helpful.

Turns out there was only 1 corrupted file on the FS, and after
deleting it and restoring from backup, the balance finished without
any more issues.
I'm going to run another scrub just in case, but everything looks normal now.

Still kind of a mystery of what went wrong such that the scrub
couldn't catch, but the balance did.

On Wed, Aug 3, 2022 at 5:13 PM Thiago Ramon <thiagoramon@gmail.com> wrote:
>
> Had to dig a bit through my IRC logs. The command is:
> btrfs ins log -o $((block_group_start + offset)) /mountpoint
>
> Eg. from your logs:
>   [Wed Aug  3 12:13:26 2022] BTRFS info (device sdn): relocating block
> group 103549454516224 flags data|raid6
>   [Wed Aug  3 12:13:45 2022] BTRFS warning (device sdn): csum failed
> root -9 ino 257 off 6809305088 csum 0x26262de7 expected csum
> 0x0473ecb8 mirror 1
>
> You'd do:
> btrfs ins log -o $((103549454516224 + 6809305088)) /mountpoint
>
> It'll say which files are the problem. Chances are there are a lot of
> files, and starting the balance after each one might be a bit too much
> trouble, which is why I suggest scanning all files first. But if you
> got lucky and it's very few files, just doing it with the balance
> should be fine.
>
> On Wed, Aug 3, 2022 at 7:03 PM Martin <mbakiev@gmail.com> wrote:
> >
> > > I've had similar issues. There's 2 general cases which you need to
> > > find and correct: actual csum errors on file data, and csum errors
> > > outside the file data (AFAIK only on compressed files).
> > > The first one is easier to spot by reading all files in the FS and
> > > logging anything that throws an IO error. Just running a find and
> > > cat'ing the files to /dev/null should do and list all errors, though
> > > you might prefer to use something more sophisticated to log and resume
> > > if you encounter any problems while doing it (might stumble on some
> > > kernel BUG while doing it).
> > > After you found all the actually damaged files and dealt with them
> > > (ddrescue or just deleting them), you are left with pretty much trying
> > > to balance, getting an error, finding the responsible file from the
> > > offset on the error message (it's the offset inside the block group
> > > being currently relocated) and then just defragging the file should be
> > > enough to clear the error. Then just resume the balance and continue
> > > on to the next one...
> >
> > Do you have more information on how to figure out which files are
> > affected from the log error messages there?
> > Reading all the files first seems unnecessary if I can just use the
> > block group/offset to figure out the damaged files.
> > Using `find . -inum 257` points me to a file, but the entire file
> > reads just fine, so I suspect that's incorrect and has something to do
> > with the "root -9" part of the error message.
