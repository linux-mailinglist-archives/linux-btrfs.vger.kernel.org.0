Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B5A50C0EF
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Apr 2022 23:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiDVVKe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Apr 2022 17:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiDVVKb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Apr 2022 17:10:31 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C52341960
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Apr 2022 13:06:23 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id c1so2407932pfo.0
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Apr 2022 13:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hcmwjulI5d377uFeb7R0mLj1nolpg87YoX8x8oR0qE8=;
        b=CIxqaRET/Xf0C3oa5AhLQSlYye5gaUQvETH8Zu/q/QMAyqITs5ueByPdFuuIjnXUPX
         5w25aw5q8H7m+cW67+g7ve2Y9mF8IGHX/yYbgXBvFRgMwUvyP3IVa19kxK7371+UGFsH
         Fal3L8OSyGQNCCqHIgpzXhn/tezbZiHx92cBqQjO/NESPx2FnJMUggCFOAyI/Y7kBpSi
         MJpXAIDCLPoBKcJ611FSQoXClgBZP53vWKf0EI4M37y2idq2YewsLSxKs/kdqd7dyeit
         EsLSouk3lr2/4u7+NjejU8wsEQBUQMLrZLUjMhMXbdiqfOipihWPIQK1cDl49SqiS/Q4
         5/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hcmwjulI5d377uFeb7R0mLj1nolpg87YoX8x8oR0qE8=;
        b=N4OKV1WeLu2f3CSakqajNihkk6Zf7xlciYjn9oilOQUBcI0+8o6kNVsD2+ReDzGUVM
         gehYFYKzR7Bpd7C9uvdi+Iv5pAf6M0KH/8iEDHpw58SdDVxwtNckQunDQ38PDwtN5Jdj
         H3mgI0b+4s7A2AEkDVxmZ35/GaM3PCHc9BSAbSNCSQTmFtL41Hu/FOdQpnTmPtNlorma
         owXQczn8gjmSX9Zd8bkonCOZ4kP2CPaiX1C1oyVA519qEJ9dWk0QfTC3awExxkkRyizS
         pj1WjykswEDQxa/lYPmZ9Mzsgu5Kf3j2ayohQxigomV16Xhni5ruTZSBpM3UVKJeVENt
         2gog==
X-Gm-Message-State: AOAM532xZJ3qRkFdWxsRsFb9GsqYq2sHuPXTtMdepL/FVoV14pe5OLXU
        4IsQ6hvfUj8/JJ66mtAvmq6WCmVF9EsRrjv2bTRRF9l5HTM=
X-Google-Smtp-Source: ABdhPJz7dDQUT8MR6DEnHje06i7iKfHFztwn0bJdNVPHv/X4ADejDdrt1N8X4RzqPlto9NbbFwh/IYPbfbMgTBFX/nw=
X-Received: by 2002:a92:d6c9:0:b0:2c7:aba1:6231 with SMTP id
 z9-20020a92d6c9000000b002c7aba16231mr2433033ilp.206.1650656779532; Fri, 22
 Apr 2022 12:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220405195901.GC28707@merlins.org> <CAEzrpqe-tBN9iuDJPwf7cj7J8=d6gtr27LnTat9nZiA7iVERNQ@mail.gmail.com>
 <20220405200805.GD28707@merlins.org> <CAEzrpqf0Gz=UuJ83woXOsRvcdC7vhH-b2UphuG-1+dUOiRc2Kw@mail.gmail.com>
 <YkzWAZtf7rcY/d+7@hungrycats.org> <20220406000844.GK28707@merlins.org>
 <Ykzvoz47Rvknw7aH@hungrycats.org> <20220406040913.GE3307770@merlins.org>
 <Yk3W88Eyh0pSm9mQ@hungrycats.org> <20220406191317.GC14804@merlins.org> <20220422184850.GX13115@merlins.org>
In-Reply-To: <20220422184850.GX13115@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Fri, 22 Apr 2022 15:46:08 -0400
Message-ID: <CAEzrpqfhCHL=pWXvQK9rYftQFe+Z6CyQPwRYxgCaX1w6JaqOTA@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 22, 2022 at 2:48 PM Marc MERLIN <marc@merlins.org> wrote:
>
> Back on list, Josef made a lot of changes to btrfs-progs for me (thanks
> Josef)
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs rescue tree-recover /dev/mapper/dshelf1
> FS_INFO IS 0x55c6d219bbc0
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x55c6d219bbc0
> Checking root 2
> Checking root 4
> Checking root 5
> Checking root 7
> Checking root 9
> Checking root 11221
> Checking root 11222
> Checking root 11223
>
> After that ./btrfs check --init-extent-tree /dev/mapper/dshelf1 has been
> running more for than 48H now
>
> Starting repair.
> Opening filesystem to check...
> checksum verify failed on 15645878108160 found 00000027 wanted 0000001B
> checksum verify failed on 11821979287552 found 000000A9 wanted FFFFFFFB
> checksum verify failed on 11822142046208 found 000000AC wanted FFFFFFC4
> (...)
> checksum verify failed on 13577821011968 wanted 0x9a29aff5 found 0x2cdff391
> checksum verify failed on 15645781196800 wanted 0xef669b11 found 0x46985a93
> Failed to find [13576823668736, 168, 16384]
> btrfs unable to find ref byte nr 13577801809920 parent 0 root 1  owner 0 offset 0
> path->slots[0]: 134 path->nodes[0]:
> leaf 49709056 items 169 free space 7975 generation 1602090 owner EXTENT_TREE
> leaf 49709056 flags 0x0() backref revision 1
> fs uuid 96539b8c-ccc9-47bf-9e6c-29305890941e
> chunk uuid 7257b24b-3702-41e5-8b61-6f6ea524255a
>         item 0 key (13400696422400 BLOCK_GROUP_ITEM 1073741824) itemoff 16259 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
>         item 1 key (13401770164224 BLOCK_GROUP_ITEM 1073741824) itemoff 16235 itemsize 24
>                 block group used 0 chunk_objectid 256 flags DATA|single
> (...)
> Chunk[256, 228, 15365845286912] stripe[1, 14785462665216] is not found in dev extent
> Chunk[256, 228, 15366919028736] stripe[1, 14786536407040] is not found in dev extent
> Device extent[1, 11503033909248, 1073741824] didn't find the relative chunk.
> Device extent[1, 11595375706112, 1073741824] didn't find the relative chunk.
> Device extent[1, 11596449447936, 1073741824] didn't find the relative chunk.
> Device extent[1, 11597523189760, 1073741824] didn't find the relative chunk.
> Device extent[1, 11598596931584, 1073741824] didn't find the relative chunk.
> (...)
> Device extent[1, 11422503272448, 1073741824] didn't find the relative chunk.
> Device extent[1, 10616123162624, 1073741824] didn't find the relative chunk.
> ref mismatch on [12582912 4096] extent item 0, found 1
> data backref 12582912 root 11223 owner 260 offset 131072 num_refs 0 not found in extent tree
> incorrect local backref count on 12582912 root 11223 owner 260 offset 131072 found 1 wanted 0 back 0x5604b40697a0
> backpointer mismatch on [12582912 4096]
> adding new data backref on 12582912 root 11223 owner 260 offset 131072 found 1
> Repaired extent references for 12582912
> ref mismatch on [12587008 4096] extent item 0, found 1
> data backref 12587008 root 11223 owner 261 offset 20480 num_refs 0 not found in extent tree
> incorrect local backref count on 12587008 root 11223 owner 261 offset 20480 found 1 wanted 0 back 0x5604b4069a00
> backpointer mismatch on [12587008 4096]
> adding new data backref on 12587008 root 11223 owner 261 offset 20480 found 1
> Repaired extent references for 12587008
> ref mismatch on [12591104 4096] extent item 0, found 1
> (...)
> incorrect local backref count on 20963328 parent 33718272 owner 0 offset 0 found 1 wanted 0 back 0x56043bdf6d80
> backpointer mismatch on [20963328 4096]
> adding new data backref on 20963328 parent 33718272 owner 0 offset 0 found 1
> Repaired extent references for 20963328
> ref mismatch on [20967424 4096] extent item 0, found 1
> data backref 20967424 parent 33718272 owner 0 offset 0 num_refs 0 not found in extent tree
> incorrect local backref count on 20967424 parent 33718272 owner 0 offset 0 found 1 wanted 0 back 0x56043bdf6fe0
> backpointer mismatch on [20967424 4096]
> adding new data backref on 20967424 parent 33718272 owner 0 offset 0 found 1
> Repaired extent references for 20967424
> ref mismatch on [20971520 16384] extent item 0, found 1
> tree backref 20971520 root 3 not found in extent tree
> backpointer mismatch on [20971520 16384]
> adding new tree backref on start 20971520 len 16384 parent 0 root 3
> Repaired extent references for 20971520
> ref mismatch on [20987904 16384] extent item 0, found 1
> tree backref 20987904 root 3 not found in extent tree
> backpointer mismatch on [20987904 16384]
> adding new tree backref on start 20987904 len 16384 parent 0 root 3
> Repaired extent references for 20987904
> ref mismatch on [21004288 16384] extent item 0, found 1
> tree backref 21004288 root 3 not found in extent tree
> (..)
> adding new tree backref on start 44531712 len 16384 parent 50872320 root 50872320
> Repaired extent references for 44531712
> ref mismatch on [44548096 16384] extent item 0, found 1
> tree backref 44548096 parent 47398912 not found in extent tree
> backpointer mismatch on [44548096 16384]
> adding new tree backref on start 44548096 len 16384 parent 47398912 root 47398912
> Repaired extent references for 44548096
> ref mismatch on [44564480 16384] extent item 0, found 1
> tree backref 44564480 root 7 not found in extent tree
> backpointer mismatch on [44564480 16384]
> adding new tree backref on start 44564480 len 16384 parent 0 root 7
> Repaired extent references for 44564480
> ref mismatch on [44580864 16384] extent item 0, found 1
> tree backref 44580864 root 7 not found in extent tree
> backpointer mismatch on [44580864 16384]
> adding new tree backref on start 44580864 len 16384 parent 0 root 7
> Repaired extent references for 44580864
> ref mismatch on [44597248 16384] extent item 0, found 1
> tree backref 44597248 root 7 not found in extent tree
> backpointer mismatch on [44597248 16384]
> adding new tree backref on start 44597248 len 16384 parent 0 root 7
> Repaired extent references for 44597248
> ref mismatch on [44613632 16384] extent item 0, found 1
> tree backref 44613632 parent 47398912 not found in extent tree
> backpointer mismatch on [44613632 16384]
> adding new tree backref on start 44613632 len 16384 parent 47398912 root 47398912
> Repaired extent references for 44613632
> ref mismatch on [44630016 16384] extent item 0, found 1
> tree backref 44630016 parent 47398912 not found in extent tree
> backpointer mismatch on [44630016 16384]
> adding new tree backref on start 44630016 len 16384 parent 47398912 root 47398912
> (...)
>
> gargamel:/var/local/src# grep -c 'adding new tree backref on start' checkrepair1
> 9026
>
> It's been running for close to 3 days, and I'm a bit confused that it's repairing so
> many things when it wast just a minute's worth of potential corruption.
>
> Do I keep running for many more days to see where this goes, or at this point
> 73,860 lines of output is not a bad sign and I should look at restoring from backup?
>

We're doing the --init-extent-tree thing, which deletes the whole
extent tree and rebuilds it.  This isn't the fast path, 3 days is
super shitty tho.  I don't want to stop it and try and make it faster
because once it's done you should just be golden.  It looks scary, but
that's because it just clears the extent tree and then lets the normal
repair thing do its thing, so it yells loudly about all the messed up
references and then fixes it.

Now if we get to Monday and it's still running I can take a crack at
making it faster.  I was hoping it would only take a day or two, but
we're balancing me trying to make it better and possibly fucking it up
with letting it take the rest of our lives but be correct.  Thanks,

Josef
