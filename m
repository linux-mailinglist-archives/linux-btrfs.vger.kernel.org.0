Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE4949DFF1
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Jan 2022 11:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbiA0K6p (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jan 2022 05:58:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41842 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiA0K6o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jan 2022 05:58:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 975D3B821EE
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jan 2022 10:58:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34C2C340E4;
        Thu, 27 Jan 2022 10:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643281122;
        bh=xQ/UtutQgHZyuZ7IKCiqSBZL5XCRlkojVERUKxI3pfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=opZHiDZIplO7gSBPe+fJ7kpDaWAr9l4TZ2AvW7jcNV8po3esL0QVEYNJZTR7IbA90
         zh1wzXLWpPMeuFVkBPhXgC0zZp9AAMB3YpzNkRBqZGw62zGLKzolRbSz3R/jxbeDl3
         WHLHAHL/gYHDTb9s62/JjdYUcgPiKrTV3m+jdpTURwl2SMAkZhcWYqnYbAtwXn1gvS
         Zd7n6B+Osj9SwWzk7SutTyu/0pZ6uYA2FdA17Ef4p25ZWyleYYVPIdNOZuXWnjDDYq
         7cIlZHUHJBcM+QitjCuA95ygyV14n6YEeNu0Ugn01Cuc2Z2yULI3D903Sn9U2rT44C
         1vBMANWCZUQYg==
Date:   Thu, 27 Jan 2022 10:58:39 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/3] btrfs: defrag: use extent_thresh to replace the
 hardcoded size limit
Message-ID: <YfJ63+NCoXexTB8j@debian9.Home>
References: <20220126005850.14729-1-wqu@suse.com>
 <20220126005850.14729-2-wqu@suse.com>
 <YfEzNCybtrSufSvu@debian9.Home>
 <7e0ba10b-04f0-d7d4-1da0-01f455b2d55e@suse.com>
 <CAL3q7H4RJTxZ-SebRPhyQRPUUaSr0fHvaTm1o1qu18wTuKYOZg@mail.gmail.com>
 <dc25f2ec-1afc-8cb4-8a01-6416602d45a4@gmx.com>
 <CAL3q7H7mnWnYsYM2t8tTpjS7jwJejN9t2HfSHxNjX2G89mfEDQ@mail.gmail.com>
 <23a2d582-16ce-61f6-60a7-87389e03df40@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23a2d582-16ce-61f6-60a7-87389e03df40@gmx.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 27, 2022 at 07:57:32AM +0800, Qu Wenruo wrote:
> 
> 
> On 2022/1/26 21:37, Filipe Manana wrote:
> > On Wed, Jan 26, 2022 at 1:00 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > > 
> > > 
> > > 
> > > On 2022/1/26 20:36, Filipe Manana wrote:
> > > > On Wed, Jan 26, 2022 at 12:26 PM Qu Wenruo <wqu@suse.com> wrote:
> > > > > 
> > > > > 
> > > > > 
> > > > > On 2022/1/26 19:40, Filipe Manana wrote:
> > > > > > On Wed, Jan 26, 2022 at 08:58:49AM +0800, Qu Wenruo wrote:
> > > > > > > In defrag_lookup_extent() we use hardcoded extent size threshold, SZ_128K,
> > > > > > > other than @extent_thresh in btrfs_defrag_file().
> > > > > > > 
> > > > > > > This can lead to some inconsistent behavior, especially the default
> > > > > > > extent size threshold is 256K.
> > > > > > > 
> > > > > > > Fix this by passing @extent_thresh into defrag_check_next_extent() and
> > > > > > > use that value.
> > > > > > > 
> > > > > > > Also, since the extent_thresh check should be applied to all extents,
> > > > > > > not only physically adjacent extents, move the threshold check into a
> > > > > > > dedicate if ().
> > > > > > > 
> > > > > > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > > > > > > ---
> > > > > > >     fs/btrfs/ioctl.c | 12 +++++++-----
> > > > > > >     1 file changed, 7 insertions(+), 5 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > > > > > > index 0d8bfc716e6b..2911df12fc48 100644
> > > > > > > --- a/fs/btrfs/ioctl.c
> > > > > > > +++ b/fs/btrfs/ioctl.c
> > > > > > > @@ -1050,7 +1050,7 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
> > > > > > >     }
> > > > > > > 
> > > > > > >     static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
> > > > > > > -                                 bool locked)
> > > > > > > +                                 u32 extent_thresh, bool locked)
> > > > > > >     {
> > > > > > >        struct extent_map *next;
> > > > > > >        bool ret = false;
> > > > > > > @@ -1066,9 +1066,11 @@ static bool defrag_check_next_extent(struct inode *inode, struct extent_map *em,
> > > > > > >        /* Preallocated */
> > > > > > >        if (test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
> > > > > > >                goto out;
> > > > > > > -    /* Physically adjacent and large enough */
> > > > > > > -    if ((em->block_start + em->block_len == next->block_start) &&
> > > > > > > -        (em->block_len > SZ_128K && next->block_len > SZ_128K))
> > > > > > > +    /* Extent is already large enough */
> > > > > > > +    if (next->len >= extent_thresh)
> > > > > > > +            goto out;
> > > > > > 
> > > > > > So this will trigger unnecessary rewrites of compressed extents.
> > > > > > The SZ_128K is there to deal with compressed extents, it has nothing to
> > > > > > do with the threshold passed to the ioctl.
> > > > > 
> > > > > Then there is still something wrong.
> > > > > 
> > > > > The original check will only reject it when both conditions are met.
> > > > > 
> > > > > So based on your script, I can still find a way to defrag the extents,
> > > > > with or without this modification:
> > > > 
> > > > Right, without the intermediary write to file "baz", this patchset
> > > > brings a regression in regards to
> > > > compressed extents - when they are adjacent, which is typically the
> > > > case when doing large writes,
> > > > as they'll create multiple extents covering consecutive 128K ranges.
> > > > 
> > > > With the write to file "baz", as I pasted it, it happens before and
> > > > after the patchset.
> > > > 
> > > > > 
> > > > >           mkfs.btrfs -f $DEV
> > > > >           mount -o compress $DEV $MNT
> > > > > 
> > > > >           xfs_io -f -c "pwrite -S 0xab 0 128K" $MNT/file1
> > > > >           sync
> > > > >           xfs_io -f -c "pwrite -S 0xab 0 128K" $MNT/file2
> > > > >           sync
> > > > >           xfs_io -f -c "pwrite -S 0xab 128K 128K" $MNT/file1
> > > > >           sync
> > > > > 
> > > > >           echo "=== file1 before defrag ==="
> > > > >           xfs_io -f -c "fiemap -v" $MNT/file1
> > > > >           echo "=== file1 after defrag ==="
> > > > >           btrfs fi defrag $MNT/file1
> > > > >           sync
> > > > >           xfs_io -f -c "fiemap -v" $MNT/file1
> > > > > 
> > > > > The output looks like this:
> > > > > 
> > > > > === before ===
> > > > > /mnt/btrfs/file1:
> > > > >     EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
> > > > >       0: [0..255]:        26624..26879       256   0x8
> > > > >       1: [256..511]:      26640..26895       256   0x9
> > > > > === after ===
> > > > > /mnt/btrfs/file1:
> > > > >     EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
> > > > >       0: [0..255]:        26648..26903       256   0x8
> > > > >       1: [256..511]:      26656..26911       256   0x9
> > > > > 
> > > > > No matter if the patch is applied, the result is the same.
> > > > 
> > > > Yes, explained above.
> > > > 
> > > > > 
> > > > > So thank you very much for finding another case we're not handling well...
> > > > > 
> > > > > 
> > > > > BTW, if the check is want to reject adjacent non-compressed extent, the
> > > > > original one is still incorrect, we can have extents smaller than 128K
> > > > > and is still uncompressed.
> > > > > 
> > > > > So what we really want is to reject physically adjacent, non-compressed
> > > > > extents?
> > > > 
> > > > We want to avoid doing work that does nothing.
> > > > If 2 consecutive extents are compressed and at least one is already
> > > > 128K, then it's a waste of time, IO and CPU.
> > > 
> > > So can we define the behavior like this?
> > > 
> > >    If the extent is already at its max capacity (compressed 128K,
> > >     non-compressed 128M), we don't defrag it.
> > 
> > My previous suggestion was: if one of the extents is compressed and
> > its size is 128K, don't include it for defrag.
> 
> Yep, your previous one can handling it well, I'd just want to add the
> similar check for uncompressed one (which may be too rare to hit though)
> 
> > 
> > There's probably other cases to think about: 1 compressed extent
> > representing 100K of data, followed by another compressed extent
> > representing 64K of data for example.
> > In that case using both for defrag will still result in 2 extents, 1
> > for 128K of data and another for 36K of data - still not worth it to
> > defrag them, we end up with 2 extents, just different sizes.
> 
> Yes, that's also a factor to consider.
> 
> And with the target list we can determine how many compressed extents it
> would result.
> The missing piece is the number of the original extents.
> 
> I think this would be a target for later optimization.

Sure. Don't forget about possibly less common cases like having a mix
of compressed extents, smaller than 128K followed with non-compressed
extents, with sizes like in that above example, where after defrag
we would still end up with 2 extents, just of different sizes.

It's certainly possible after cloning from a compressed file to one
without compression and vice-versa.

> 
> > 
> > At the very least we should not regress on what we did not defrag before:
> > 
> > 2 extents with physically contiguous ranges, representing 128K of data
> > each, both compressed.
> 
> Although the original code is not really working as it's doing block_len
> > SZ_128K, while our maximum compressed extent size is exactly 128K.
> 
> I'll fix the problem first with better check and comments.

Sounds fine.

Thanks.

> 
> Thanks,
> Qu
> 
> > 
> > Which is a very common case.
> > 
> > Thanks.
> > 
> > > 
> > > This also means, we need to do the same check in
> > > defrag_collect_targets() to avoid defragging such extent.
> > > 
> > > Thanks,
> > > Qu
> > > 
> > > 
> > > > 
> > > > And that's a fairly common scenario. Do a one megabyte write for
> > > > example, then after writeback we end up with several 128K extents with
> > > > compression.
> > > > In that case defrag should do nothing for the whole range.
> > > > 
> > > > 
> > > > > 
> > > > > Thanks,
> > > > > Qu
> > > > > > 
> > > > > > After applying this patchset, if you run a trivial test like this:
> > > > > > 
> > > > > >       #!/bin/bash
> > > > > > 
> > > > > >       DEV=/dev/sdj
> > > > > >       MNT=/mnt/sdj
> > > > > > 
> > > > > >       mkfs.btrfs -f $DEV
> > > > > >       mount -o compress $DEV $MNT
> > > > > > 
> > > > > >       xfs_io -f -c "pwrite -S 0xab 0 128K" $MNT/foobar
> > > > > >       sync
> > > > > >       # Write to some other file so that the next extent for foobar
> > > > > >       # is not contiguous with the first extent.
> > > > > >       xfs_io -f -c "pwrite 0 128K" $MNT/baz
> > > > > >       sync
> > > > > >       xfs_io -f -c "pwrite -S 0xcd 128K 128K" $MNT/foobar
> > > > > >       sync
> > > > > > 
> > > > > >       echo -e "\n\nTree after creating file:\n\n"
> > > > > >       btrfs inspect-internal dump-tree -t 5 $DEV
> > > > > > 
> > > > > >       btrfs filesystem defragment $MNT/foobar
> > > > > >       sync
> > > > > > 
> > > > > >       echo -e "\n\nTree after defrag:\n\n"
> > > > > >       btrfs inspect-internal dump-tree -t 5 $DEV
> > > > > > 
> > > > > >       umount $MNT
> > > > > > 
> > > > > > It will result in rewriting the two 128K compressed extents:
> > > > > > 
> > > > > > (...)
> > > > > > Tree after write and sync:
> > > > > > 
> > > > > > btrfs-progs v5.12.1
> > > > > > fs tree key (FS_TREE ROOT_ITEM 0)
> > > > > > (...)
> > > > > >         item 7 key (257 INODE_REF 256) itemoff 15797 itemsize 16
> > > > > >                 index 2 namelen 6 name: foobar
> > > > > >         item 8 key (257 EXTENT_DATA 0) itemoff 15744 itemsize 53
> > > > > >                 generation 6 type 1 (regular)
> > > > > >                 extent data disk byte 13631488 nr 4096
> > > > > >                 extent data offset 0 nr 131072 ram 131072
> > > > > >                 extent compression 1 (zlib)
> > > > > >         item 9 key (257 EXTENT_DATA 131072) itemoff 15691 itemsize 53
> > > > > >                 generation 8 type 1 (regular)
> > > > > >                 extent data disk byte 14163968 nr 4096
> > > > > >                 extent data offset 0 nr 131072 ram 131072
> > > > > >                 extent compression 1 (zlib)
> > > > > > (...)
> > > > > > 
> > > > > > Tree after defrag:
> > > > > > 
> > > > > > btrfs-progs v5.12.1
> > > > > > fs tree key (FS_TREE ROOT_ITEM 0)
> > > > > > (...)
> > > > > >         item 7 key (257 INODE_REF 256) itemoff 15797 itemsize 16
> > > > > >                 index 2 namelen 6 name: foobar
> > > > > >         item 8 key (257 EXTENT_DATA 0) itemoff 15744 itemsize 53
> > > > > >                 generation 9 type 1 (regular)
> > > > > >                 extent data disk byte 14430208 nr 4096
> > > > > >                 extent data offset 0 nr 131072 ram 131072
> > > > > >                 extent compression 1 (zlib)
> > > > > >         item 9 key (257 EXTENT_DATA 131072) itemoff 15691 itemsize 53
> > > > > >                 generation 9 type 1 (regular)
> > > > > >                 extent data disk byte 13635584 nr 4096
> > > > > >                 extent data offset 0 nr 131072 ram 131072
> > > > > >                 extent compression 1 (zlib)
> > > > > > 
> > > > > > In other words, a waste of IO and CPU time.
> > > > > > 
> > > > > > So it needs to check if we are dealing with compressed extents, and
> > > > > > if so, skip either of them has a size of SZ_128K (and changelog updated).
> > > > > > 
> > > > > > Thanks.
> > > > > > 
> > > > > > > +    /* Physically adjacent */
> > > > > > > +    if ((em->block_start + em->block_len == next->block_start))
> > > > > > >                goto out;
> > > > > > >        ret = true;
> > > > > > >     out:
> > > > > > > @@ -1231,7 +1233,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
> > > > > > >                        goto next;
> > > > > > > 
> > > > > > >                next_mergeable = defrag_check_next_extent(&inode->vfs_inode, em,
> > > > > > > -                                                      locked);
> > > > > > > +                                                      extent_thresh, locked);
> > > > > > >                if (!next_mergeable) {
> > > > > > >                        struct defrag_target_range *last;
> > > > > > > 
> > > > > > > --
> > > > > > > 2.34.1
> > > > > > > 
> > > > > > 
> > > > > 
