Return-Path: <linux-btrfs+bounces-10886-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA40EA085FB
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 04:32:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B67077A3FC2
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 03:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B081FC114;
	Fri, 10 Jan 2025 03:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qqamK4co";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="J63222ZA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29C82A1BA;
	Fri, 10 Jan 2025 03:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736479930; cv=none; b=GacN/YJEONuBy7Wsnn8aKSz1qQr1VKC8jO8JIZsnCosv+IC/Mj+maW7kVbJDM8GTsNu8BWESmwUpVc1miFnoZ498AKWLUjSJV4+b4IemridmWTxV+g4VRHKPAYRuGC/Mcm60wqd2RPZgSB1GIlTWmZL1FWQ4E1PFzASmN24IUcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736479930; c=relaxed/simple;
	bh=WFkeR74EoAUrFhsKzCpAA7T5Paq7CM/EV/x135deFLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I36Jzf1E3M0WgW7VJ7eYQjteY1RHuMULGG8ecS/q74274LUznO6qaNYdxsevRmJEVdBl0KR+DXdaQHGisj9Ql4KnRAgy3YR6G4SiMibHFqeBxs5NNYxExXPyGNRWs+Yro00HCcb8AZ4PHXpjfKYVnARtcNxI0tm0lG73AetD8pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qqamK4co; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=J63222ZA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F203F2116D;
	Fri, 10 Jan 2025 03:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736479926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=heANMzqcQDAUGwLpsviST8JUin+5D7B4kIo77drr0mc=;
	b=qqamK4cokjCmFqFNTdl3nsF0NmmM7SKnftKonySNuSV3A0kEKL4SdIA4naEGfuQBzJgumb
	VKg+l/VacTXiaIzqZaJAG7tKXitP9AkGuSguN3bdGTpgw71nIb4aqQfB74xYUIc+ZXIkaQ
	qBNivRb2UBHjdI/qOePS/UEpEGIQ3H4=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736479925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=heANMzqcQDAUGwLpsviST8JUin+5D7B4kIo77drr0mc=;
	b=J63222ZAJg+HgQLlXRtRerSRD1TvNsPY/EtWP9OXUKAvm/MfQbcCgBAk07huJeAxCHN3OZ
	CqrL61Rznqp7DqA21P/WEhHNuJa1vVpo8Izsohfdqg+KHIMIkaK8LsUTnzZ8ctuShS5BTJ
	az7Qf0/BZ08TFZA/5sx36BrbhFZjmcU=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B51541397D;
	Fri, 10 Jan 2025 03:32:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ENyWHbSUgGe0NQAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 10 Jan 2025 03:32:04 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org,
	Boris Burkov <boris@bur.io>
Subject: [PATCH v3 01/10] btrfs: fix double accounting race when btrfs_run_delalloc_range() failed
Date: Fri, 10 Jan 2025 14:01:32 +1030
Message-ID: <d8010f41cb800b3362c70af8984cf9b7d75580a1.1736479224.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1736479224.git.wqu@suse.com>
References: <cover.1736479224.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
When running btrfs with block size (4K) smaller than page size (64K,
aarch64), there is a very high chance to crash the kernel at
generic/750, with the following messages:
(before the call traces, there are 3 extra debug messages added)

 BTRFS warning (device dm-3): read-write for sector size 4096 with page size 65536 is experimental
 BTRFS info (device dm-3): checking UUID tree
 hrtimer: interrupt took 5451385 ns
 BTRFS error (device dm-3): cow_file_range failed, root=4957 inode=257 start=1605632 len=69632: -28
 BTRFS error (device dm-3): run_delalloc_nocow failed, root=4957 inode=257 start=1605632 len=69632: -28
 BTRFS error (device dm-3): failed to run delalloc range, root=4957 ino=257 folio=1572864 submit_bitmap=8-15 start=1605632 len=69632: -28
 ------------[ cut here ]------------
 WARNING: CPU: 2 PID: 3020984 at ordered-data.c:360 can_finish_ordered_extent+0x370/0x3b8 [btrfs]
 CPU: 2 UID: 0 PID: 3020984 Comm: kworker/u24:1 Tainted: G           OE      6.13.0-rc1-custom+ #89
 Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
 Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
 Workqueue: events_unbound btrfs_async_reclaim_data_space [btrfs]
 pc : can_finish_ordered_extent+0x370/0x3b8 [btrfs]
 lr : can_finish_ordered_extent+0x1ec/0x3b8 [btrfs]
 Call trace:
  can_finish_ordered_extent+0x370/0x3b8 [btrfs] (P)
  can_finish_ordered_extent+0x1ec/0x3b8 [btrfs] (L)
  btrfs_mark_ordered_io_finished+0x130/0x2b8 [btrfs]
  extent_writepage+0x10c/0x3b8 [btrfs]
  extent_write_cache_pages+0x21c/0x4e8 [btrfs]
  btrfs_writepages+0x94/0x160 [btrfs]
  do_writepages+0x74/0x190
  filemap_fdatawrite_wbc+0x74/0xa0
  start_delalloc_inodes+0x17c/0x3b0 [btrfs]
  btrfs_start_delalloc_roots+0x17c/0x288 [btrfs]
  shrink_delalloc+0x11c/0x280 [btrfs]
  flush_space+0x288/0x328 [btrfs]
  btrfs_async_reclaim_data_space+0x180/0x228 [btrfs]
  process_one_work+0x228/0x680
  worker_thread+0x1bc/0x360
  kthread+0x100/0x118
  ret_from_fork+0x10/0x20
 ---[ end trace 0000000000000000 ]---
 BTRFS critical (device dm-3): bad ordered extent accounting, root=4957 ino=257 OE offset=1605632 OE len=16384 to_dec=16384 left=0
 BTRFS critical (device dm-3): bad ordered extent accounting, root=4957 ino=257 OE offset=1622016 OE len=12288 to_dec=12288 left=0
 Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
 BTRFS critical (device dm-3): bad ordered extent accounting, root=4957 ino=257 OE offset=1634304 OE len=8192 to_dec=4096 left=0
 CPU: 1 UID: 0 PID: 3286940 Comm: kworker/u24:3 Tainted: G        W  OE      6.13.0-rc1-custom+ #89
 Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
 Workqueue:  btrfs_work_helper [btrfs] (btrfs-endio-write)
 pstate: 404000c5 (nZcv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
 pc : process_one_work+0x110/0x680
 lr : worker_thread+0x1bc/0x360
 Call trace:
  process_one_work+0x110/0x680 (P)
  worker_thread+0x1bc/0x360 (L)
  worker_thread+0x1bc/0x360
  kthread+0x100/0x118
  ret_from_fork+0x10/0x20
 Code: f84086a1 f9000fe1 53041c21 b9003361 (f9400661)
 ---[ end trace 0000000000000000 ]---
 Kernel panic - not syncing: Oops: Fatal exception
 SMP: stopping secondary CPUs
 SMP: failed to stop secondary CPUs 2-3
 Dumping ftrace buffer:
    (ftrace buffer empty)
 Kernel Offset: 0x275bb9540000 from 0xffff800080000000
 PHYS_OFFSET: 0xffff8fbba0000000
 CPU features: 0x100,00000070,00801250,8201720b

[CAUSE]
The above warning is triggered immediately after the delalloc range
failure, this happens in the following sequence:

- Range [1568K, 1636K) is dirty

   1536K  1568K     1600K    1636K  1664K
   |      |/////////|////////|      |

  Where 1536K, 1600K and 1664K are page boundaries (64K page size)

- Enter extent_writepage() for page 1536K

- Enter run_delalloc_nocow() with locked page 1536K and range
  [1568K, 1636K)
  This is due to the inode has preallocated extents.

- Enter cow_file_range() with locked page 1536K and range
  [1568K, 1636K)

- btrfs_reserve_extent() only reserved two extents
  The main loop of cow_file_range() only reserved two data extents,

  Now we have:

   1536K  1568K        1600K    1636K  1664K
   |      |<-->|<--->|/|///////|      |
               1584K  1596K
  Range [1568K, 1596K) has ordered extent reserved.

- btrfs_reserve_extent() failed inside cow_file_range() for file offset
  1596K
  This is already a bug in our space reservation code, but for now let's
  focus on the error handling path.

  Now cow_file_range() returned -ENOSPC.

- btrfs_run_delalloc_range() do error cleanup <<< ROOT CAUSE
  Call btrfs_cleanup_ordered_extents() with locked folio 1536K and range
  [1568K, 1636K)

  Function btrfs_cleanup_ordered_extents() normally needs to skip the
  ranges inside the folio, as it will normally be cleaned up by
  extent_writepage().

  Such split error handling is already problematic in the first place.

  What's worse is the folio range skipping itself, which is not taking
  subpage cases into consideration at all, it will only skip the range
  if the page start >= the range start.
  In our case, the page start < the range start, since for subpage cases
  we can have delalloc ranges inside the folio but not covering the
  folio.

  So it doesn't skip the page range at all.
  This means all the ordered extents, both [1568K, 1584K) and
  [1584K, 1596K) will be marked as IOERR.

  And those two ordered extents have no more pending ios, it is marked
  finished, and *QUEUED* to be deleted from the io tree.

- extent_writepage() do error cleanup
  Call btrfs_mark_ordered_io_finished() for the range [1536K, 1600K).

  Although ranges [1568K, 1584K) and [1584K, 1596K) are finished, the
  deletion from io tree is async, it may or may not happen at this
  timing.

  If the ranges are not yet removed, we will do double cleaning on those
  ranges, triggers the above ordered extent warnings.

In theory there are other bugs, like the cleanup in extent_writepage()
can cause double accounting on ranges that are submitted async
(compression for example).

But that's much harder to trigger because normally we do not mix regular
and compression delalloc ranges.

[FIX]
The folio range split is already buggy and not subpage compatible, it's
introduced a long time ago where subpage support is not even considered.

So instead of splitting the ordered extents cleanup into the folio range
and out of folio range, do all the cleanup inside writepage_delalloc().

- Pass @NULL as locked_folio for btrfs_cleanup_ordered_extents() in
  btrfs_run_delalloc_range()

- Skip the btrfs_cleanup_ordered_extents() if writepage_delalloc()
  failed

  So all ordered extents are only cleaned up by
  btrfs_run_delalloc_range().

- Handle the ranges that already have ordered extents allocated
  If part of the folio already has ordered extent allocated, and
  btrfs_run_delalloc_range() failed, we also need to cleanup that range.

Now we have a concentrated error handling for ordered extents during
btrfs_run_delalloc_range().

Cc: stable@vger.kernel.org # 5.15+
Fixes: d1051d6ebf8e ("btrfs: Fix error handling in btrfs_cleanup_ordered_extents")
Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 57 ++++++++++++++++++++++++++++++++++++--------
 fs/btrfs/inode.c     |  2 +-
 2 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 9725ff7f274d..d1e263f56171 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1144,12 +1144,17 @@ static bool find_next_delalloc_bitmap(struct folio *folio,
 /*
  * helper for extent_writepage(), doing all of the delayed allocation setup.
  *
- * This returns 1 if btrfs_run_delalloc_range function did all the work required
- * to write the page (copy into inline extent).  In this case the IO has
- * been started and the page is already unlocked.
+ * Return >0 if all the dirty blocks are submitted async (compression) or inlined.
+ * The @folio should no longer be touched (treat it as already unlocked).
  *
- * This returns 0 if all went well (page still locked)
- * This returns < 0 if there were errors (page still locked)
+ * Return 0 if there is still dirty block that needs to be submitted through
+ * extent_writepage_io().
+ * bio_ctrl->submit_bitmap will indicate which blocks of the folio should be
+ * submitted, and @folio is still kept locked.
+ *
+ * Return <0 if there is any error hit.
+ * Any allocated ordered extent range covering this folio will be marked
+ * finished (IOERR), and @folio is still kept locked.
  */
 static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 						 struct folio *folio,
@@ -1167,6 +1172,16 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 	 * last delalloc end.
 	 */
 	u64 last_delalloc_end = 0;
+	/*
+	 * The range end (exclusive) of the last successfully finished delalloc
+	 * range.
+	 * Any range covered by ordered extent must either be manually marked
+	 * finished (error handling), or has IO submitted (and finish the
+	 * ordered extent normally).
+	 *
+	 * This records where our ordered extent cleanup should start.
+	 */
+	u64 last_finished_delalloc_end = page_start;
 	u64 delalloc_start = page_start;
 	u64 delalloc_end = page_end;
 	u64 delalloc_to_write = 0;
@@ -1235,11 +1250,19 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 			found_len = last_delalloc_end + 1 - found_start;
 
 		if (ret >= 0) {
+			/*
+			 * Some delalloc range may be created by previous folios.
+			 * Thus we still need to clean those range up during error
+			 * handling.
+			 */
+			last_finished_delalloc_end = found_start;
 			/* No errors hit so far, run the current delalloc range. */
 			ret = btrfs_run_delalloc_range(inode, folio,
 						       found_start,
 						       found_start + found_len - 1,
 						       wbc);
+			if (ret >= 0)
+				last_finished_delalloc_end = found_start + found_len;
 		} else {
 			/*
 			 * We've hit an error during previous delalloc range,
@@ -1274,8 +1297,22 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 
 		delalloc_start = found_start + found_len;
 	}
-	if (ret < 0)
+	/*
+	 * It's possible we have some ordered extents created before we hit
+	 * an error, cleanup non-async successfully created delalloc ranges.
+	 */
+	if (unlikely(ret < 0)) {
+		unsigned int bitmap_size = min(
+			(last_finished_delalloc_end - page_start) >>
+			fs_info->sectorsize_bits,
+			fs_info->sectors_per_page);
+
+		for_each_set_bit(bit, &bio_ctrl->submit_bitmap, bitmap_size)
+			btrfs_mark_ordered_io_finished(inode, folio,
+				page_start + (bit << fs_info->sectorsize_bits),
+				fs_info->sectorsize, false);
 		return ret;
+	}
 out:
 	if (last_delalloc_end)
 		delalloc_end = last_delalloc_end;
@@ -1509,13 +1546,13 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 
 	bio_ctrl->wbc->nr_to_write--;
 
-done:
-	if (ret) {
+	if (ret)
 		btrfs_mark_ordered_io_finished(BTRFS_I(inode), folio,
 					       page_start, PAGE_SIZE, !ret);
-		mapping_set_error(folio->mapping, ret);
-	}
 
+done:
+	if (ret < 0)
+		mapping_set_error(folio->mapping, ret);
 	/*
 	 * Only unlock ranges that are submitted. As there can be some async
 	 * submitted ranges inside the folio.
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8a173a24ac05..0a15473655ed 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2302,7 +2302,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_fol
 
 out:
 	if (ret < 0)
-		btrfs_cleanup_ordered_extents(inode, locked_folio, start,
+		btrfs_cleanup_ordered_extents(inode, NULL, start,
 					      end - start + 1);
 	return ret;
 }
-- 
2.47.1


