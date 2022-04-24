Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68E750D3D1
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Apr 2022 19:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiDXRNL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Apr 2022 13:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiDXRM6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Apr 2022 13:12:58 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DA7D44
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Apr 2022 10:09:57 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id r11so8030684ila.1
        for <linux-btrfs@vger.kernel.org>; Sun, 24 Apr 2022 10:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=art9MNJHnGWx/Kh/2IGeTHtK57EqyoMzPbFXDBOHtzs=;
        b=5bsF3mXdNWhRqwjwszeU6tXolTl9DKV7DGsCXSaa3JAUhhAcphrHhlGqM0gl4STGc6
         D7nKLtUQazRPGWMKgAHHnBZncWlio/nMwIVJMsAcvK9VN52dDiUjpZgvcaK6BNvCDEO9
         FXCcuAO6xBi9ENWiv3mdhI4cO/LPDQcnQzYH01LySOTo43r6RUawCsohrHYWZHrHIH0/
         h8h1OwmX4ryJ7Dkhq7nKg5FeAFJWvpRKHQnsz+GichaMY2RrLiSmSBa+kCt7yNY1Gub9
         8Y3cvx+zSi5FE6mLLnjYAjPs8C4Yj88rA9/VqGJWUGtgziT1SeKze6HR6abdrXL2UYum
         ePqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=art9MNJHnGWx/Kh/2IGeTHtK57EqyoMzPbFXDBOHtzs=;
        b=l7EPp5dhTGsdl2LQsF8Z6Luo4nWf3qqazh5w5emM7fSq69/DKv1drUl8L8i+0hq9l6
         T6jmJRXfcDz2ekc3jAp81enwxUb5X9L5vhX4uuL1HN011KdtjCI8QimifHicizLecDvS
         EQsOkSeVWA3tFI/ijap1WppDg5jDRUd5ukEEY26v9SQcU9u8RkBnItKlpAxUkPP3RRbM
         bb5qziXMPGQWrmT6WR3+m+Uryc9HkYRmNEHBaf9AJHfcptAEAWVDzge3UE1gI1KGBwFR
         3F/vnSAyxFnLeDcr9UeDI/BtmoJhKRIKiyZpcf7EHSSjVVk6Y3iiSvkoC8tm5/pJ6qRa
         EDqQ==
X-Gm-Message-State: AOAM531gvJCU56gnU3C3xo4zykPz4+hnBPRILviMQCc92DnRLsWkXDdF
        vYjQ1BTXBcA7xunI+DKTkENau4bWyMX2dkO6lSJL10C9nyo=
X-Google-Smtp-Source: ABdhPJz993I3VbN+b/yvnXVlWJyDXmufX7w7ukJNFC293ZVQpl4RLhpR2jmqTaRK6VWurpuCIzJKm/1eJh6S3RQaa8M=
X-Received: by 2002:a92:d6c9:0:b0:2c7:aba1:6231 with SMTP id
 z9-20020a92d6c9000000b002c7aba16231mr4977807ilp.206.1650820196389; Sun, 24
 Apr 2022 10:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <Ykzvoz47Rvknw7aH@hungrycats.org> <20220406040913.GE3307770@merlins.org>
 <Yk3W88Eyh0pSm9mQ@hungrycats.org> <20220406191317.GC14804@merlins.org>
 <20220422184850.GX13115@merlins.org> <CAEzrpqfhCHL=pWXvQK9rYftQFe+Z6CyQPwRYxgCaX1w6JaqOTA@mail.gmail.com>
 <20220422200115.GV11868@merlins.org> <20220423201225.GZ13115@merlins.org>
 <CAEzrpqeo4U4SXH7LVz_Yx8ydX5BiqzFNJmAhQv1jCpjOessjHA@mail.gmail.com>
 <CAEzrpqdHAS2E1iuoSFVX-A-T-vsMoCo6CoW0ebw42vkCjqpMPw@mail.gmail.com> <20220424162450.GY11868@merlins.org>
In-Reply-To: <20220424162450.GY11868@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Sun, 24 Apr 2022 13:09:45 -0400
Message-ID: <CAEzrpqe6gwpF9k=Gj4=aCzkj-kW5GrZNueNnfoL8ZAAnMvwbng@mail.gmail.com>
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

On Sun, Apr 24, 2022 at 12:24 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Sun, Apr 24, 2022 at 12:20:42PM -0400, Josef Bacik wrote:
> > On Sat, Apr 23, 2022 at 4:53 PM Josef Bacik <josef@toxicpanda.com> wrote:
> > >
> > > On Sat, Apr 23, 2022 at 4:12 PM Marc MERLIN <marc@merlins.org> wrote:
> > > >
> > > > On Fri, Apr 22, 2022 at 01:01:15PM -0700, Marc MERLIN wrote:
> > > > > > Now if we get to Monday and it's still running I can take a crack at
> > > > > > making it faster.  I was hoping it would only take a day or two, but
> > > > > > we're balancing me trying to make it better and possibly fucking it up
> > > > > > with letting it take the rest of our lives but be correct.  Thanks,
> > > > >
> > > > > Makes sense. I don't need faster, and it may not be able to go faster
> > > > > anyway, it's a lot of data. Just wanted to make sure the output and
> > > > > relative slow results were expected.
> > > >
> > > > Looking at the output, is there any way I can figure out if it's at 5%
> > > > or 80% completion?
> > > >
> > > > tree backref 238026752 parent 236814336 not found in extent tree
> > > > backpointer mismatch on [238026752 16384]
> > > > adding new tree backref on start 238026752 len 16384 parent 236814336 root 236814336
> > > > Repaired extent references for 238026752
> > > > ref mismatch on [238043136 16384] extent item 0, found 1
> > > > tree backref 238043136 parent 236814336 not found in extent tree
> > > > backpointer mismatch on [238043136 16384]
> > > > adding new tree backref on start 238043136 len 16384 parent 236814336 root 236814336
> > > > Repaired extent references for 238043136
> > > > ref mismatch on [238059520 16384] extent item 0, found 1
> > > > tree backref 238059520 parent 236814336 not found in extent tree
> > > > backpointer mismatch on [238059520 16384]
> > > > adding new tree backref on start 238059520 len 16384 parent 236814336 root 236814336
> > > >
> > >
> > > Hmm I don't know, that's byte 227, but you're in fs trees now, so
> > > hopefully soon?  I've got some free time, let me rewrite this to be
> > > less stupid and see if I can get it done before your thing finishes,
> > > and I'll add some sort of progress indicator.  Thanks,
> > >
> >
> > Alright you can kill the command, pull my tree, then run
> >
> > btrfs rescue init-extent-tree <blah>
>
> Thanks. Tried the new version
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue init-extent-tree /dev/mapper/dshelf1
> FS_INFO IS 0x55bf50e98bc0
> checksum verify failed on 15645878108160 wanted 0x1beaa67b found 0x27edb2c4
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x55bf50e98bc0
> Walking all our trees and pinning down the currently accessible blocks
> checksum verify failed on 11651824091136 wanted 0x6d411825 found 0x3cf07c9d
> checksum verify failed on 606126080 wanted 0x8e0fb704 found 0xfc183188
> checksum verify failed on 15645807640576 wanted 0xe97841cd found 0x4fa14858
> checksum verify failed on 364863324160 wanted 0x741855d8 found 0x5aec3f82
> (...)
> checksum verify failed on 13577821011968 wanted 0x9a29aff5 found
> 0x2cdff391
> checksum verify failed on 15645781196800 wanted 0xef669b11 found
> 0x46985a93
> Clearing the extent root and re-init'ing the block groups
> processed 1556480 of 0 possible bytes
> parent transid verify failed on 58736640 wanted 1619007 found 1619009
> processed 16384 of 0 possible bytesparent transid verify failed on 58736640 wanted 1619007 found 1619009
> parent transid verify failed on 58736640 wanted 1619007 found 1619009
> processed 32768 of 0 possible bytesparent transid verify failed on 58736640 wanted 1619007 found 1619009
> parent transid verify failed on 58736640 wanted 1619007 found 1619009
> parent transid verify failed on 58753024 wanted 1619007 found 1619009
> parent transid verify failed on 58753024 wanted 1619007 found 1619009
> processed 49152 of 0 possible bytesparent transid verify failed on 58736640 wanted 1619007 found 1619009
> parent transid verify failed on 58736640 wanted 1619007 found 1619009
> parent transid verify failed on 58736640 wanted 1619007 found 1619009
> parent transid verify failed on 58736640 wanted 1619007 found 1619009
> parent transid verify failed on 58736640 wanted 1619007 found 1619009
> parent transid verify failed on 58736640 wanted 1619007 found 1619009
> parent transid verify failed on 58736640 wanted 1619007 found 1619009
> parent transid verify failed on 58736640 wanted 1619007 found 1619009
> parent transid verify failed on 58736640 wanted 1619007 found 1619009
> parent transid verify failed on 58736640 wanted 1619007 found 1619009
> parent transid verify failed on 58736640 wanted 1619007 found 1619009
> parent transid verify failed on 58736640 wanted 1619007 found 1619009
> parent transid verify failed on 58736640 wanted 1619007 found 1619009
> parent transid verify failed on 58736640 wanted 1619007 found 1619009
> parent transid verify failed on 58736640 wanted 1619007 found 1619009
> parent transid verify failed on 58736640 wanted 1619007 found 1619009
> corrupt leaf: root=2 block=58736640 physical=1140867072 slot=107, bad
> key order, prev (169143697408 192 1073741824) current (12582912 192
> 8388608)
> kernel-shared/extent-tree.c:1287: btrfs_inc_extent_ref: BUG_ON `err`
> triggered, value -1
> ./btrfs(+0x29683)[0x55bf4fea1683]
> ./btrfs(btrfs_inc_extent_ref+0x522)[0x55bf4fea3061]
> ./btrfs(+0x8ba18)[0x55bf4ff03a18]
> ./btrfs(+0x8bb27)[0x55bf4ff03b27]
> ./btrfs(+0x8bd8f)[0x55bf4ff03d8f]
> ./btrfs(btrfs_init_extent_tree+0x226)[0x55bf4ff04092]
> ./btrfs(+0x83931)[0x55bf4fefb931]
> ./btrfs(handle_command_group+0x49)[0x55bf4fe9017b]
> ./btrfs(main+0x94)[0x55bf4fe90275]
> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xcd)[0x7faebe73a7fd]
> ./btrfs(_start+0x2a)[0x55bf4fe8fe1a]
> Aborted

Argh you still have bogus stuff for some reason, maybe it's because of
cancelling the rescue.  Re-run btrfs rescue tree-recover, and do it a
couple of times to make sure it's stopped complaining.  If it does
complain after the first run please let me know, it really should fix
everything the first go around.  If it's not then I need to try and
reproduce that locally and figure out wtf it's doing.  Once
tree-recover runs cleanly you can run btrfs rescue init-extent-tree,
then hopefully you'll be good to go.  Thanks,

Josef
