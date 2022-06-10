Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFA2546DAE
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jun 2022 21:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348889AbiFJTzY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jun 2022 15:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348855AbiFJTzW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jun 2022 15:55:22 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E346388
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 12:55:20 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id 19so87572iou.12
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 12:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Si10Hr0Nz/ZkrzFqVgzAMjS02Rx/6VFqTrYidzj2E44=;
        b=KIUToanaeOoIVvXbIzDVWhZ5yYu0tzy4iqPT6rvVigdR4/YqsA466lUKeXdP/xeoNe
         I2K9CCyvh0E27tXB1sGuUxHFKidRg6S4ldHgXgR8r3vqA9Rh2abQ/XtDvcYhtvn5sWQ0
         neKE+9xl+ABH0s+TWBoFNdeoYAQ5y7LVePj0AwZVB5BLKBMYspKg557RN2c+Dmm7zucY
         d9z7urU7eH15kivFoYqkIe4BbZJpp2I2v9/ZZyT1oWqOFc4/N3flW/sjJoUlufn/RO0+
         2Z5I2giuMti9nS+vVoQy5XaJkxfxXjIIog4XctfEkE37FcDhVAbidURgkDg7Ct66WYtT
         75xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Si10Hr0Nz/ZkrzFqVgzAMjS02Rx/6VFqTrYidzj2E44=;
        b=EfcPzeswjUu4khbm9RyUpjF/HnuJpEPb3OzW6PnN1N/U24tzSBeNmeKbHmckLFDNtX
         J5i8Qox+9m5wshZJHpBrxQvicOvg6dtp4QXcBp/mmDaiynqJzb+R9Zk77M6hAZN+m64d
         aVSar2ddyK75ixI+tKjlqKBZjaW7sSXGhZdk6UVg7zgLzOumId1R78kg6CGVOXguuyUi
         dGeOg20s7kfIu6iEW0ZFSmM59+3uTRxuKZIlnZVgtHSsoDFf0FeRfCDKpK3NDholJ8bn
         kpKKJD8Jxy/Tq2yaRDbRhnCrNr/VzapBxqIIaO9BLDzWRAPw424wxFwC5jGmNtnBUweh
         3mlA==
X-Gm-Message-State: AOAM530vnnXSZ+Ea95yiXWSIv0Ol/3CeS9VFVtDN91OECJbXZjRXrXAn
        M8MfnMWCjW1tqDzz8l2NNmRWHBkjzXLXddFMhb4gtuhi7Cc=
X-Google-Smtp-Source: ABdhPJw405e92W/0TVt9pxw1IytyCY84v1w1aH1uK1RSXkBMeyf1LjyPQLB6R8O7iiv285FaCkIYAjHfaxHbVmlYtzM=
X-Received: by 2002:a05:6602:3403:b0:669:6b82:209 with SMTP id
 n3-20020a056602340300b006696b820209mr11796457ioz.166.1654890919829; Fri, 10
 Jun 2022 12:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220608021245.GD22722@merlins.org> <CAEzrpqeFFiHjbQ+VQ7zy9ZbV1MgaMT-V4ovJhB9iOan8Ao-cXg@mail.gmail.com>
 <20220608213030.GG22722@merlins.org> <CAEzrpqdxCycEEAVqu-hykG-qdoEyBBFuc5buKS631XDciVrs7A@mail.gmail.com>
 <20220608213845.GH22722@merlins.org> <CAEzrpqejNj3qTtTJ7Godb0VMsxKt094vMw+iT4XR1B9aayO7Nw@mail.gmail.com>
 <20220609030128.GJ22722@merlins.org> <CAEzrpqfy-sf_xGMohK1EVgtP58tLTso6e7s9iyd3t5XnM3zjCg@mail.gmail.com>
 <20220609211511.GW1745079@merlins.org> <CAEzrpqfhUMDjkaJaa4ZugSuKOWpLyTVJ8nLu9nep5n_qzo-PiA@mail.gmail.com>
 <20220610191156.GB1664812@merlins.org>
In-Reply-To: <20220610191156.GB1664812@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Fri, 10 Jun 2022 15:55:09 -0400
Message-ID: <CAEzrpqfEj3c5wodYzibBXg34NxtXmQCB60=MtD+Nic2PN8i5bQ@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 10, 2022 at 3:11 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Fri, Jun 10, 2022 at 02:47:54PM -0400, Josef Bacik wrote:
> > Sorry I keep going back and forth on how to deal with this.  I've
> > pushed some code, you can run btrfs check --repair again and then try
> > again.  Thanks,
>
> Thanks, lots of output, not sure how much you want.
>
> For one:
> Device extent[1, 14803716276224, 1073741824] didn't find the relative chunk.
> Device extent[1, 14804790018048, 1073741824] didn't find the relative chunk.
> Device extent[1, 14805863759872, 1073741824] didn't find the relative chunk.
> Device extent[1, 14806937501696, 1073741824] didn't find the relative chunk.
> Device extent[1, 14808011243520, 1073741824] didn't find the relative chunk.
> super bytes used 21916233728 mismatches actual used 21916332032
> Block group[20971520, 8388608] (flags = 34) didn't find the relative chunk.
> Dev extent's total-byte(1396938113024) is not equal to byte-used(14599692746752) in dev[1, 216, 1]
> kernel-shared/extent-tree.c:2479: alloc_reserved_tree_block: Warning: assertion `1` failed, value 1
> ./btrfs(btrfs_run_delayed_refs+0x707)[0x5577947c927b]
> ./btrfs(btrfs_commit_transaction+0x3b)[0x5577947d7fb5]
> ./btrfs(repair_dev_item_bytes_used+0x6f)[0x5577948340d7]
> ./btrfs(+0x7d90b)[0x55779481690b]
> ./btrfs(+0x80193)[0x557794819193]
> ./btrfs(main+0x94)[0x5577947b1275]
> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xcd)[0x7f51c74847fd]
> ./btrfs(_start+0x2a)[0x5577947b0e1a]
> kernel-shared/extent-tree.c:2479: alloc_reserved_tree_block: Warning: assertion `1` failed, value 1
> ./btrfs(btrfs_run_delayed_refs+0x707)[0x5577947c927b]
> ./btrfs(btrfs_commit_transaction+0x3b)[0x5577947d7fb5]
> ./btrfs(repair_dev_item_bytes_used+0x6f)[0x5577948340d7]
> ./btrfs(+0x7d90b)[0x55779481690b]
> ./btrfs(+0x80193)[0x557794819193]
> ./btrfs(main+0x94)[0x5577947b1275]
> /lib/x86_64-linux-gnu/libc.so.6(__libc_start_main+0xcd)[0x7f51c74847fd]
> ./btrfs(_start+0x2a)[0x5577947b0e1a]
> WARNING: reserved space leaked, transid=2608372 flag=0x2 bytes_reserved=32768
> [3/7] checking free space cache
> [4/7] checking fs roots
> root 161199 inode 54987 errors 1000, some csum missing
> WARNING: reserved space leaked, transid=2608373 flag=0x2 bytes_reserved=32768
> root 161199 inode 54988 errors 1100, file extent discount, some csum missing
> Found file extent holes:
>         start: 0, len: 1572864
> WARNING: reserved space leaked, transid=2608374 flag=0x2 bytes_reserved=32768
> root 161199 inode 54989 errors 3500, file extent discount, nbytes wrong, some csum missing, link count wrong
> Found file extent holes:
>         start: 16252928, len: 91824128
>         unresolved ref dir 54974 index 16 namelen 18 name foo
>
> (...)
>
> Found file extent holes:
>         start: 197263360, len: 399777792
> root 164629 inode 73086 errors 1000, some csum missing
> WARNING: reserved space leaked, transid=2608425 flag=0x2 bytes_reserved=32768
> root 164629 inode 73094 errors 3500, file extent discount, nbytes wrong, some csum missing, link count wrong
> Found file extent holes:
>         start: 0, len: 524288
>         unresolved ref dir 74963 index 32 namelen 56 name file filetype 0 errors 3
> , no dir item, no dir index
> WARNING: reserved space leaked, transid=2608426 flag=0x2 bytes_reserved=32768
> root 164629 inode 73097 errors 3500, file extent discount, nbytes wrong, some csum missing, link count wrong
> Found file extent holes:
>         start: 0, len: 524288
>         unresolved ref dir 74963 index 36 namelen 56 name file filetype 0 errors 3
> , no dir item, no dir index
> root 164629 inode 73099 errors 1000, some csum missing
> root 164629 inode 73100 errors 1000, some csum missing
>         unresolved ref dir 791 index 0 namelen 25 name file filetype 1 errors 6, no dir index, no inode ref
>         unresolved ref dir 3676 index 0 namelen 62 name file filetype 1 erro
> rs 6, no dir index, no inode ref
> ERROR: errors found in fs roots
> WARNING: reserved space leaked, flag=0x2 bytes_reserved=32768
> nt
>
>
> deleting dev extent
> deleting dev extent
> deleting dev extent
> deleting dev extent
> deleting dev extent
> reset devid 1 bytes_used to 1396938113024
> No device size related problem found
> cache and super generation don't match, space cache will be invalidated
> found 43832565760 bytes used, error(s) found
> total csum bytes: 0
> total tree bytes: 17694720
> total fs tree bytes: 13598720
> total extent tree bytes: 1212416
> btree space waste bytes: 5081349
> file data blocks allocated: 73458024448
>  referenced 73454837760
>
> After that check without repair still reports the same errors and mount still fails
>
> [4035459.256276] BTRFS info (device dm-1): disk space caching is enabled
> [4035459.276458] BTRFS info (device dm-1): has skinny extents
> [4035459.357797] BTRFS error (device dm-1): chunk 20971520 has missing dev extent, have 0 expect 2
> [4035459.385928] BTRFS error (device dm-1): failed to verify dev extents against chunks: -117
> [4035459.413170] BTRFS error (device dm-1): open_ctree failed

Gaahhh ok I see what I've been fucking up.  I had it in my head that
system chunks only exist in the super block, but they are both in the
super block so we can bootstrap the fs, _and_ in the chunk tree so we
don't confuse fsck.  This works out for the progs (and to a certain
extent the kernel) because it always has to read it from the super
block in order to mount, but it falls down in fsck (and in the kernel
like the above) when we don't find the same chunk in the chunk tree.

Soooooo I've fixed my idiocy and moved the code around.  Unfortunately
my last fix deleted the stripes from the sys array, so we need to get
those back.  So once again run

btrfs rescue recover-chunks <device>
btrfs rescue init-extent-tree <device>
btrfs check --repair <device>

and then it should be good to go as far as the chunks and the device
extents and everything.  Thanks,

Josef
