Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8695F50D4C9
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Apr 2022 21:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237541AbiDXTUr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Apr 2022 15:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236155AbiDXTUq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Apr 2022 15:20:46 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD5533EA7
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Apr 2022 12:17:45 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id y11so8146277ilp.4
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Apr 2022 12:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GctGZ6ThaiqnKel9yHKeyAZzN8lbJKQY1kbUWCWcDfo=;
        b=wK+FIYuMFfbJeSAbV4z3fKuMZsXsnXP6Mfn7raJEb8swkQyCuAWaoEXpzzo88lGxBc
         2Ve+f1jl+TfCLvnyJQl3E7U5Rs8alA9moEwzHzOZjFEt+gHDOqiJMKAkt4Bu0NfknCGs
         bKv1DHhVq8cK+2+LGlmTxdNsoWQdp6UOwapWMrrpmfBxb+iGjO/z4VLTwKnsZQCzEUFg
         20ok7gEbZ25Pp8l5IGCuJlNJUF49Ho4FSMh4pYKvrD1QXXUaeNXCnjQEQlOHoXI0cRJL
         doGMYzNGSQr8KbU0P9U82PRTNz4lIEwGopjrV9mcMzDp3CmbCQPB9rZrRYeomxAvka8E
         jy1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GctGZ6ThaiqnKel9yHKeyAZzN8lbJKQY1kbUWCWcDfo=;
        b=2FFkg6uu8zRtLqKX4Pot4ZvXP/eTvPCw1j6GJXFRLK56JiePiXJ8rEqAsSxSMMqrtp
         UG/XTYALDFS6OWDJTc6EHabGOwWuznq8tElsep8/P6ug0iXBCdRl7+E+lT2fbSMzMuzO
         sTPjNwrnUo2PWnnasswr/Y/5sX7rnxqKFZpYTcWAzk7/S2AkA4MQjqSiuFMMbXhp4rUe
         Udxjh7wEdqDkQpnFBLsFAzG891T2jAHgGRMgleE4MWdklQOA2aHX4QfZGjzzw4fdySiK
         ofPldbsaQB63PnaXIKntMUlDBSxhowSTM4jsiCGLZtfBgyM91FMMkyaEeQbh4sFZAwzs
         bGcg==
X-Gm-Message-State: AOAM531tKq+5KLo5lVeDCfw3NWFwy595M+Rwh9jAsHvRSLeubpOH4nEo
        HyN2Q5xHLG4DKjBqJ9ksC0/Vsl++h4PEwU+X4OSPzUPSi9U=
X-Google-Smtp-Source: ABdhPJz4BOo95E8EonUFusYAsCrI5c6pb491hY51WrE6UUcGoTGnF6rCpcyswisFhEcokTBVwszih6CM+Pu5TlnNpng=
X-Received: by 2002:a05:6e02:1746:b0:2cc:d914:594f with SMTP id
 y6-20020a056e02174600b002ccd914594fmr5978947ill.6.1650827864713; Sun, 24 Apr
 2022 12:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <Yk3W88Eyh0pSm9mQ@hungrycats.org> <20220406191317.GC14804@merlins.org>
 <20220422184850.GX13115@merlins.org> <CAEzrpqfhCHL=pWXvQK9rYftQFe+Z6CyQPwRYxgCaX1w6JaqOTA@mail.gmail.com>
 <20220422200115.GV11868@merlins.org> <20220423201225.GZ13115@merlins.org>
 <CAEzrpqeo4U4SXH7LVz_Yx8ydX5BiqzFNJmAhQv1jCpjOessjHA@mail.gmail.com>
 <CAEzrpqdHAS2E1iuoSFVX-A-T-vsMoCo6CoW0ebw42vkCjqpMPw@mail.gmail.com>
 <20220424162450.GY11868@merlins.org> <CAEzrpqe6gwpF9k=Gj4=aCzkj-kW5GrZNueNnfoL8ZAAnMvwbng@mail.gmail.com>
 <20220424184341.GA1523521@merlins.org>
In-Reply-To: <20220424184341.GA1523521@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 24 Apr 2022 15:17:33 -0400
Message-ID: <CAEzrpqeUJwtkMAUaxEd-qARe1aEZBx-v1-G_WY7vPr5MNL+3TQ@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Apr 24, 2022 at 2:43 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, Apr 24, 2022 at 01:09:45PM -0400, Josef Bacik wrote:
> > Argh you still have bogus stuff for some reason, maybe it's because of
> > cancelling the rescue.  Re-run btrfs rescue tree-recover, and do it a
> > couple of times to make sure it's stopped complaining.  If it does
> > complain after the first run please let me know, it really should fix
> > everything the first go around.  If it's not then I need to try and
> > reproduce that locally and figure out wtf it's doing.  Once
> > tree-recover runs cleanly you can run btrfs rescue init-extent-tree,
> > then hopefully you'll be good to go.  Thanks,
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
> FS_INFO IS 0x555a360efbc0
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x555a360efbc0
> Checking root 2
> Checking root 4
> Checking root 5
> Checking root 7
> Checking root 9
> Checking root 11221
> Checking root 11222
> Checking root 11223
> Checking root 11224
> Checking root 159785
> Checking root 159787
> Checking root 160494
> Checking root 160496
> Checking root 161197
> Checking root 161199
> Checking root 162628
> Checking root 162632
> Checking root 162645
> Checking root 163298
> Checking root 163302
> Checking root 163303
> Checking root 163316
> Checking root 163318
> Checking root 163916
> Checking root 163920
> Checking root 163921
> Checking root 164620
> Checking root 164624
> Checking root 164633
> Checking root 165098
> Checking root 165100
> Checking root 165198
> Checking root 165200
> Checking root 165294
> Checking root 165298
> Checking root 165299
> Checking root 18446744073709551607
> Tree recovery finished, you can run check now
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue init-extent-tree /dev/mapper/dshelf1
> FS_INFO IS 0x56080e544bc0
> checksum verify failed on 15645878108160 wanted 0x1beaa67b found 0x27edb2c4

Ok this is sort of maddening, IDK how we'll trip over this broken
block here, but not with tree-recover.  Can you repull, build, and
then run init-extent-tree.  As soon as you see the JOSEF message you
can kill it and send me the output, I need to figure out wtf is going
on here.  Thanks,

Josef
