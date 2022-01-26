Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BABC49C9D2
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 13:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241387AbiAZMg5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 07:36:57 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48230 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241367AbiAZMg5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 07:36:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 064F8619F3
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jan 2022 12:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E19C340E3
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jan 2022 12:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643200616;
        bh=/U7JBcUPd4HQRlhX2ak5o7cyjfjtLuzLSoz4zPjlaB8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AqDeHNHVUEEEJgB3vQrsMVO8jdybv4yEqUtE2eQB4WmPjzAJLyQ3YjFpZfEJcA/4B
         1msJaUt30qRngbMLYFQWV7dRg/6HlkqRRFe+QI8wXd43zUaASObser3F7vCpD00cIT
         eXBQlF3yI1W9FpMCfrgC+duybug59aD5yzeJ2iGzNA99+h9Xc+8hhY+ld4Sf8/JJSv
         QMCAtleoAgmWzwbXC5fCJOIcK/GlSbw6S/Qo3Npf1wtug9UKM8cRu9Kglno9LEX84w
         NkquViELsUKIUgNhcIkquQ1Noj7P6lEo+OLik4mZa4o3w/YItAdB1h+PRBiPVQbS0y
         CVU4/rShHoHfA==
Received: by mail-qk1-f182.google.com with SMTP id s12so28104958qkg.6
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jan 2022 04:36:56 -0800 (PST)
X-Gm-Message-State: AOAM533ZHOASXzpB8B7VFaXgv9eI/71v/6TL9EjyRMz3VW55gAvkZIaJ
        MGeCaXuMMObHiOMfLaKT7yBotxWU1hpQyoY1sxg=
X-Google-Smtp-Source: ABdhPJzsYiSklpbL9cdLjQhFhAO3VZMcFeoWzmHuI4BJFMQ6Y8PneYuU+rcDMwQsxz+sItweZYNJ5yStaCYxEbcFoKE=
X-Received: by 2002:a37:63d1:: with SMTP id x200mr12265150qkb.120.1643200615359;
 Wed, 26 Jan 2022 04:36:55 -0800 (PST)
MIME-Version: 1.0
References: <20220126005850.14729-1-wqu@suse.com> <20220126005850.14729-2-wqu@suse.com>
 <YfEzNCybtrSufSvu@debian9.Home> <7e0ba10b-04f0-d7d4-1da0-01f455b2d55e@suse.com>
In-Reply-To: <7e0ba10b-04f0-d7d4-1da0-01f455b2d55e@suse.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 26 Jan 2022 12:36:19 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4RJTxZ-SebRPhyQRPUUaSr0fHvaTm1o1qu18wTuKYOZg@mail.gmail.com>
Message-ID: <CAL3q7H4RJTxZ-SebRPhyQRPUUaSr0fHvaTm1o1qu18wTuKYOZg@mail.gmail.com>
Subject: Re: [PATCH 2/3] btrfs: defrag: use extent_thresh to replace the
 hardcoded size limit
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 26, 2022 at 12:26 PM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> On 2022/1/26 19:40, Filipe Manana wrote:
> > On Wed, Jan 26, 2022 at 08:58:49AM +0800, Qu Wenruo wrote:
> >> In defrag_lookup_extent() we use hardcoded extent size threshold, SZ_128K,
> >> other than @extent_thresh in btrfs_defrag_file().
> >>
> >> This can lead to some inconsistent behavior, especially the default
> >> extent size threshold is 256K.
> >>
> >> Fix this by passing @extent_thresh into defrag_check_next_extent() and
> >> use that value.
> >>
> >> Also, since the extent_thresh check should be applied to all extents,
> >> not only physically adjacent extents, move the threshold check into a
> >> dedicate if ().
> >>
> >> Signed-off-by: Qu Wenruo <wqu@suse.com>
> >> ---
> >>   fs/btrfs/ioctl.c | 12 +++++++-----
> >>   1 file changed, 7 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> >> index 0d8bfc716e6b..2911df12fc48 100644
> >> --- a/fs/btrfs/ioctl.c
> >> +++ b/fs/btrfs/ioctl.c
> >> @@ -1050,7 +1050,7 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
> >>   }
> >>
> >>   static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
> >> -                                 bool locked)
> >> +                                 u32 extent_thresh, bool locked)
> >>   {
> >>      struct extent_map *next;
> >>      bool ret = false;
> >> @@ -1066,9 +1066,11 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
> >>      /* Preallocated */
> >>      if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
> >>              goto out;
> >> -    /* Physically adjacent and large enough */
> >> -    if ((em->block_start + em->block_len == next->block_start) &&
> >> -        (em->block_len > SZ_128K && next->block_len > SZ_128K))
> >> +    /* Extent is already large enough */
> >> +    if (next->len >= extent_thresh)
> >> +            goto out;
> >
> > So this will trigger unnecessary rewrites of compressed extents.
> > The SZ_128K is there to deal with compressed extents, it has nothing to
> > do with the threshold passed to the ioctl.
>
> Then there is still something wrong.
>
> The original check will only reject it when both conditions are met.
>
> So based on your script, I can still find a way to defrag the extents,
> with or without this modification:

Right, without the intermediary write to file "baz", this patchset
brings a regression in regards to
compressed extents - when they are adjacent, which is typically the
case when doing large writes,
as they'll create multiple extents covering consecutive 128K ranges.

With the write to file "baz", as I pasted it, it happens before and
after the patchset.

>
>         mkfs.btrfs -f $DEV
>         mount -o compress $DEV $MNT
>
>         xfs_io -f -c "pwrite -S 0xab 0 128K" $MNT/file1
>         sync
>         xfs_io -f -c "pwrite -S 0xab 0 128K" $MNT/file2
>         sync
>         xfs_io -f -c "pwrite -S 0xab 128K 128K" $MNT/file1
>         sync
>
>         echo "=== file1 before defrag ==="
>         xfs_io -f -c "fiemap -v" $MNT/file1
>         echo "=== file1 after defrag ==="
>         btrfs fi defrag $MNT/file1
>         sync
>         xfs_io -f -c "fiemap -v" $MNT/file1
>
> The output looks like this:
>
> === before ===
> /mnt/btrfs/file1:
>   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>     0: [0..255]:        26624..26879       256   0x8
>     1: [256..511]:      26640..26895       256   0x9
> === after ===
> /mnt/btrfs/file1:
>   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
>     0: [0..255]:        26648..26903       256   0x8
>     1: [256..511]:      26656..26911       256   0x9
>
> No matter if the patch is applied, the result is the same.

Yes, explained above.

>
> So thank you very much for finding another case we're not handling well...
>
>
> BTW, if the check is want to reject adjacent non-compressed extent, the
> original one is still incorrect, we can have extents smaller than 128K
> and is still uncompressed.
>
> So what we really want is to reject physically adjacent, non-compressed
> extents?

We want to avoid doing work that does nothing.
If 2 consecutive extents are compressed and at least one is already
128K, then it's a waste of time, IO and CPU.

And that's a fairly common scenario. Do a one megabyte write for
example, then after writeback we end up with several 128K extents with
compression.
In that case defrag should do nothing for the whole range.


>
> Thanks,
> Qu
> >
> > After applying this patchset, if you run a trivial test like this:
> >
> >     #!/bin/bash
> >
> >     DEV=/dev/sdj
> >     MNT=/mnt/sdj
> >
> >     mkfs.btrfs -f $DEV
> >     mount -o compress $DEV $MNT
> >
> >     xfs_io -f -c "pwrite -S 0xab 0 128K" $MNT/foobar
> >     sync
> >     # Write to some other file so that the next extent for foobar
> >     # is not contiguous with the first extent.
> >     xfs_io -f -c "pwrite 0 128K" $MNT/baz
> >     sync
> >     xfs_io -f -c "pwrite -S 0xcd 128K 128K" $MNT/foobar
> >     sync
> >
> >     echo -e "\n\nTree after creating file:\n\n"
> >     btrfs inspect-internal dump-tree -t 5 $DEV
> >
> >     btrfs filesystem defragment $MNT/foobar
> >     sync
> >
> >     echo -e "\n\nTree after defrag:\n\n"
> >     btrfs inspect-internal dump-tree -t 5 $DEV
> >
> >     umount $MNT
> >
> > It will result in rewriting the two 128K compressed extents:
> >
> > (...)
> > Tree after write and sync:
> >
> > btrfs-progs v5.12.1
> > fs tree key (FS_TREE ROOT_ITEM 0)
> > (...)
> >       item 7 key (257 INODE_REF 256) itemoff 15797 itemsize 16
> >               index 2 namelen 6 name: foobar
> >       item 8 key (257 EXTENT_DATA 0) itemoff 15744 itemsize 53
> >               generation 6 type 1 (regular)
> >               extent data disk byte 13631488 nr 4096
> >               extent data offset 0 nr 131072 ram 131072
> >               extent compression 1 (zlib)
> >       item 9 key (257 EXTENT_DATA 131072) itemoff 15691 itemsize 53
> >               generation 8 type 1 (regular)
> >               extent data disk byte 14163968 nr 4096
> >               extent data offset 0 nr 131072 ram 131072
> >               extent compression 1 (zlib)
> > (...)
> >
> > Tree after defrag:
> >
> > btrfs-progs v5.12.1
> > fs tree key (FS_TREE ROOT_ITEM 0)
> > (...)
> >       item 7 key (257 INODE_REF 256) itemoff 15797 itemsize 16
> >               index 2 namelen 6 name: foobar
> >       item 8 key (257 EXTENT_DATA 0) itemoff 15744 itemsize 53
> >               generation 9 type 1 (regular)
> >               extent data disk byte 14430208 nr 4096
> >               extent data offset 0 nr 131072 ram 131072
> >               extent compression 1 (zlib)
> >       item 9 key (257 EXTENT_DATA 131072) itemoff 15691 itemsize 53
> >               generation 9 type 1 (regular)
> >               extent data disk byte 13635584 nr 4096
> >               extent data offset 0 nr 131072 ram 131072
> >               extent compression 1 (zlib)
> >
> > In other words, a waste of IO and CPU time.
> >
> > So it needs to check if we are dealing with compressed extents, and
> > if so, skip either of them has a size of SZ_128K (and changelog updated).
> >
> > Thanks.
> >
> >> +    /* Physically adjacent */
> >> +    if ((em->block_start + em->block_len == next->block_start))
> >>              goto out;
> >>      ret = true;
> >>   out:
> >> @@ -1231,7 +1233,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
> >>                      goto next;
> >>
> >>              next_mergeable = defrag_check_next_extent(&inode->vfs_inode, em,
> >> -                                                      locked);
> >> +                                                      extent_thresh, locked);
> >>              if (!next_mergeable) {
> >>                      struct defrag_target_range *last;
> >>
> >> --
> >> 2.34.1
> >>
> >
>
