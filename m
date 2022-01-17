Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD468490CAA
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jan 2022 17:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237811AbiAQQwL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jan 2022 11:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235348AbiAQQwK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jan 2022 11:52:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B548DC061574
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 08:52:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52582611B4
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jan 2022 16:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3C7C36AE3;
        Mon, 17 Jan 2022 16:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642438329;
        bh=jMh1rVTgCGgVZ4N5+L02vuz/9MFiPkBeMk0FthXgck0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TVZWdWnBhaEOXJUAmKlpS6F68qzrfEkckN8nL3zpcGiahaiwRa5j3qSAY5Tz7W7n5
         AmfWADzUraSyPwojR/DgDEfVPYTvWtTBCWWl2QM+4Jwbg0vqqyQybcXWfXwFnxgjq0
         dTJf7DxoXtn8oOGNbSNUOTXmCgL96osN47Whw9qsEJ7tLFIip/OlwiYXRuQRQBjSCZ
         tZugmDknL7p8EIpNBk9xs8k4/ngmNXRwiHxy3MFAvwhUGdIMAXm6m/zXo5vdOD41GY
         imFnrUvd19rgKY65Z/p/yLisL2HElsNu/xQ2/f28X0RUO1PqScu2qvyXNRbgAHCGFn
         UbM+QqAl/xHXQ==
Date:   Mon, 17 Jan 2022 16:52:06 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Anthony Ruhier <aruhier@mailbox.org>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: btrfs fi defrag hangs on small files, 100% CPU thread
Message-ID: <YeWetp7/1q/4bU1O@debian9.Home>
References: <0a269612-e43f-da22-c5bc-b34b1b56ebe8@mailbox.org>
 <YeVc0r7lLtns0Bch@debian9.Home>
 <fa7b6afd-9646-898c-7a0e-1536fc2f94b9@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa7b6afd-9646-898c-7a0e-1536fc2f94b9@mailbox.org>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jan 17, 2022 at 03:24:00PM +0100, Anthony Ruhier wrote:
> Thanks for the answer.
> 
> I had the exact same issue as in the thread you've linked, and have some
> monitoring and graphs that showed that btrfs-cleaner did constant writes
> during 12 hours just after I upgraded to linux 5.16. Weirdly enough, the
> issue almost disappeared after I did a btrfs balance by filtering on 10%
> usage of data.
> But that's why I initially disabled autodefrag, what has lead to discovering
> this bug as I switched to manual defragmentation (which, in the end, makes
> more sense anyway with my setup).
> 
> I tried this patch, but sadly it doesn't help for the initial issue. I
> cannot say for the bug in the other thread, as the problem with
> btrfs-cleaner disappeared (I can still see some writes from it, but it so
> rare that I cannot say if it's normal or not).

Ok, reading better your first mail, I see there's the case of the 1 byte
file, which is possibly not the cause from the autodefrag causing the
excessive IO problem.

For the 1 byte file problem, I've just sent a fix:

https://patchwork.kernel.org/project/linux-btrfs/patch/bcbfce0ff7e21bbfed2484b1457e560edf78020d.1642436805.git.fdmanana@suse.com/

It's actually trivial to trigger.

Can you check if it also fixes your problem with autodefrag?

If not, then try the following (after applying the 1 file fix):

https://pastebin.com/raw/EbEfk1tF

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index a5bd6926f7ff..db795e226cca 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1191,6 +1191,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 				  u64 newer_than, bool do_compress,
 				  bool locked, struct list_head *target_list)
 {
+	const u32 min_thresh = extent_thresh / 2;
 	u64 cur = start;
 	int ret = 0;
 
@@ -1198,6 +1199,7 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 		struct extent_map *em;
 		struct defrag_target_range *new;
 		bool next_mergeable = true;
+		u64 range_start;
 		u64 range_len;
 
 		em = defrag_lookup_extent(&inode->vfs_inode, cur, locked);
@@ -1213,6 +1215,24 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 		if (em->generation < newer_than)
 			goto next;
 
+		/*
+		 * Our start offset might be in the middle of an existing extent
+		 * map, so take that into account.
+		 */
+		range_len = em->len - (cur - em->start);
+
+		/*
+		 * If there's already a good range for delalloc within the range
+		 * covered by the extent map, skip it, otherwise we can end up
+		 * doing on the same IO range for a long time when using auto
+		 * defrag.
+		 */
+		range_start = cur;
+		if (count_range_bits(&inode->io_tree, &range_start,
+				     range_start + range_len - 1, min_thresh,
+				     EXTENT_DELALLOC, 1) >= min_thresh)
+			goto next;
+
 		/*
 		 * For do_compress case, we want to compress all valid file
 		 * extents, thus no @extent_thresh or mergeable check.
@@ -1220,8 +1240,8 @@ static int defrag_collect_targets(struct btrfs_inode *inode,
 		if (do_compress)
 			goto add;
 
-		/* Skip too large extent */
-		if (em->len >= extent_thresh)
+		/* Skip large enough ranges. */
+		if (range_len >= extent_thresh)
 			goto next;
 
 		next_mergeable = defrag_check_next_extent(&inode->vfs_inode, em,


Thanks.


> 
> Thanks,
> Anthony
> 
> Le 17/01/2022 à 13:10, Filipe Manana a écrit :
> > On Sun, Jan 16, 2022 at 08:15:37PM +0100, Anthony Ruhier wrote:
> > > Hi,
> > > Since I upgraded from linux 5.15 to 5.16, `btrfs filesystem defrag -t128K`
> > > hangs on small files (~1 byte) and triggers what it seems to be a loop in
> > > the kernel. It results in one CPU thread running being used at 100%. I
> > > cannot kill the process, and rebooting is blocked by btrfs.
> > > It is a copy of the bughttps://bugzilla.kernel.org/show_bug.cgi?id=215498
> > > 
> > > Rebooting to linux 5.15 shows no issue. I have no issue to run a defrag on
> > > bigger files (I filter out files smaller than 3.9KB).
> > > 
> > > I had a conversation on #btrfs on IRC, so here's what we debugged:
> > > 
> > > I can replicate the issue by copying a file impacted by this bug, by using
> > > `cp --reflink=never`. I attached one of the impacted files to this bug,
> > > named README.md.
> > > 
> > > Someone told me that it could be a bug due to the inline extent. So we tried
> > > to check that.
> > > 
> > > filefrag shows that the file Readme.md is 1 inline extent. I tried to create
> > > a new file with random text, of 18 bytes (slightly bigger than the other
> > > file), that is also 1 inline extent. This file doesn't trigger the bug and
> > > has no issue to be defragmented.
> > > 
> > > I tried to mount my system with `max_inline=0`, created a copy of README.md.
> > > `filefrag` shows me that the new file is now 1 extent, not inline. This new
> > > file also triggers the bug, so it doesn't seem to be due to the inline
> > > extent.
> > > 
> > > Someone asked me to provide the output of a perf top when the defrag is
> > > stuck:
> > > 
> > >      28.70%  [kernel]          [k] generic_bin_search
> > >      14.90%  [kernel]          [k] free_extent_buffer
> > >      13.17%  [kernel]          [k] btrfs_search_slot
> > >      12.63%  [kernel]          [k] btrfs_root_node
> > >       8.33%  [kernel]          [k] btrfs_get_64
> > >       3.88%  [kernel]          [k] __down_read_common.llvm
> > >       3.00%  [kernel]          [k] up_read
> > >       2.63%  [kernel]          [k] read_block_for_search
> > >       2.40%  [kernel]          [k] read_extent_buffer
> > >       1.38%  [kernel]          [k] memset_erms
> > >       1.11%  [kernel]          [k] find_extent_buffer
> > >       0.69%  [kernel]          [k] kmem_cache_free
> > >       0.69%  [kernel]          [k] memcpy_erms
> > >       0.57%  [kernel]          [k] kmem_cache_alloc
> > >       0.45%  [kernel]          [k] radix_tree_lookup
> > > 
> > > I can reproduce the bug on 2 different machines, running 2 different linux
> > > distributions (Arch and Gentoo) with 2 different kernel configs.
> > > This kernel is compiled with clang, the other with GCC.
> > > 
> > > Kernel version: 5.16.0
> > > Mount options:
> > >      Machine 1:
> > > rw,noatime,compress-force=zstd:2,ssd,discard=async,space_cache=v2,autodefrag
> > >      Machine 2: rw,noatime,compress-force=zstd:3,nossd,space_cache=v2
> > > 
> > > When the error happens, no message is shown in dmesg.
> > This is very likely the same issue as reported at this thread:
> > 
> > https://lore.kernel.org/linux-btrfs/YeVawBBE3r6hVhgs@debian9.Home/T/#ma1c8a9848c9b7e4edb471f7be184599d38e288bb
> > 
> > Are you able to test the patch posted there?
> > 
> > Thanks.
> > 
> > > Thanks,
> > > Anthony Ruhier
> > > 





