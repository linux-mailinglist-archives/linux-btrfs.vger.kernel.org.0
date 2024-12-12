Return-Path: <linux-btrfs+bounces-10280-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8199EDF41
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 07:14:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D11B16700D
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 06:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD1018870F;
	Thu, 12 Dec 2024 06:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Hen4TnvF";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Hen4TnvF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1A2183CD9;
	Thu, 12 Dec 2024 06:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733984072; cv=none; b=j3wFZjmIIWtCO2YW/w/apnp9gDtMCUeMTPjmP4d+7VeQbagZQAa1bhEe0JDsCPT/jMg3l1n70JIFZBbZfEGkpXJbhhdkZW7h/ddQWNKuNQ8yJZiw9okt1umtPJBnSFwwSgVM8AxFCiz3aRNYWaTcpQJ2iI1CO1YQ/3sVsDnW55s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733984072; c=relaxed/simple;
	bh=02+77iaDO3YjjwDaWQHZMpwk1lqvcSUW4MGG6eiz01E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCn+75xM7OUYrgtFbXrqm9GWFVTE3FcRIYPekKJZ1OsC3NsD2eIUAe4rrdtOfODzfBegz0Y0xyN/2MGAdtUjl28cj7o42liDqtQDB6ygjnEsBCuew+GKg4zsvUD86bLSY0qddXoHQPFyguDg9wcx5xCnqZLguYD5GrscIYEH5mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Hen4TnvF; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Hen4TnvF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5ADC41F399;
	Thu, 12 Dec 2024 06:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733984068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=55YgzPUsaEAV8BmevnacOqFMdcvhmvIn7NZ7LXs53OI=;
	b=Hen4TnvFhvtNVG1qub0Dbm42rLcWW9dltCVNs42tO6Axk6zHn5wFf+n6GIQ9fUdbZQ7TSu
	pZ05NMKOLjA9eIaFWwehGvxbLVWc8zxHGpSIYzrVpidXwqB+NyL42osrP3Sr5m0JhGNMsZ
	FEKxPEeh2dvqL7wBlhzrdYD/2ClXyfA=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Hen4TnvF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733984068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=55YgzPUsaEAV8BmevnacOqFMdcvhmvIn7NZ7LXs53OI=;
	b=Hen4TnvFhvtNVG1qub0Dbm42rLcWW9dltCVNs42tO6Axk6zHn5wFf+n6GIQ9fUdbZQ7TSu
	pZ05NMKOLjA9eIaFWwehGvxbLVWc8zxHGpSIYzrVpidXwqB+NyL42osrP3Sr5m0JhGNMsZ
	FEKxPEeh2dvqL7wBlhzrdYD/2ClXyfA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48BDE13508;
	Thu, 12 Dec 2024 06:14:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8IkVAkN/Wme5VQAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 12 Dec 2024 06:14:27 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 4/9] btrfs: do proper folio cleanup when cow_file_range() failed
Date: Thu, 12 Dec 2024 16:43:58 +1030
Message-ID: <9f8aec2df9dfc39155d3b6f4448528675b97a955.1733983488.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733983488.git.wqu@suse.com>
References: <cover.1733983488.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5ADC41F399
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
When testing with COW fixup marked as BUG_ON() (this is involved with the
new pin_user_pages*() change, which should not result new out-of-band
dirty pages), I hit a crash triggered by the BUG_ON() from hitting COW
fixup path.

This BUG_ON() happens just after a failed btrfs_run_delalloc_range():

 BTRFS error (device dm-2): failed to run delalloc range, root 348 ino 405 folio 65536 submit_bitmap 6-15 start 90112 len 106496: -28
 ------------[ cut here ]------------
 kernel BUG at fs/btrfs/extent_io.c:1444!
 Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
 CPU: 0 UID: 0 PID: 434621 Comm: kworker/u24:8 Tainted: G           OE      6.12.0-rc7-custom+ #86
 Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
 Workqueue: events_unbound btrfs_async_reclaim_data_space [btrfs]
 pc : extent_writepage_io+0x2d4/0x308 [btrfs]
 lr : extent_writepage_io+0x2d4/0x308 [btrfs]
 Call trace:
  extent_writepage_io+0x2d4/0x308 [btrfs]
  extent_writepage+0x218/0x330 [btrfs]
  extent_write_cache_pages+0x1d4/0x4b0 [btrfs]
  btrfs_writepages+0x94/0x150 [btrfs]
  do_writepages+0x74/0x190
  filemap_fdatawrite_wbc+0x88/0xc8
  start_delalloc_inodes+0x180/0x3b0 [btrfs]
  btrfs_start_delalloc_roots+0x174/0x280 [btrfs]
  shrink_delalloc+0x114/0x280 [btrfs]
  flush_space+0x250/0x2f8 [btrfs]
  btrfs_async_reclaim_data_space+0x180/0x228 [btrfs]
  process_one_work+0x164/0x408
  worker_thread+0x25c/0x388
  kthread+0x100/0x118
  ret_from_fork+0x10/0x20
 Code: aa1403e1 9402f3ef aa1403e0 9402f36f (d4210000)
 ---[ end trace 0000000000000000 ]---

[CAUSE]
That failure is mostly from cow_file_range(), where we can hit -ENOSPC.

Although the -ENOSPC is already a bug related to our space reservation
code, let's just focus on the error handling.

For example, we have the following dirty range [0, 64K) of an inode,
with 4K sector size and 4K page size:

   0        16K        32K       48K       64K
   |///////////////////////////////////////|
   |#######################################|

Where |///| means page are still dirty, and |###| means the extent io
tree has EXTENT_DELALLOC flag.

- Enter extent_writepage() for page 0

- Enter btrfs_run_delalloc_range() for range [0, 64K)

- Enter cow_file_range() for range [0, 64K)

- Function btrfs_reserve_extent() only reserved one 16K extent
  So we created extent map and ordered extent for range [0, 16K)

   0        16K        32K       48K       64K
   |////////|//////////////////////////////|
   |<- OE ->|##############################|

   And range [0, 16K) has its delalloc flag cleared.
   But since we haven't yet submit any bio, involved 4 pages are still
   dirty.

- Function btrfs_reserve_extent() return with -ENOSPC
  Now we have to run error cleanup, which will clear all
  EXTENT_DELALLOC* flags and clear the dirty flags for the remaining
  ranges:

   0        16K        32K       48K       64K
   |////////|                              |
   |        |                              |

  Note that range [0, 16K) still has their pages dirty.

- Some time later, writeback are triggered again for the range [0, 16K)
  since the page range still have dirty flags.

- btrfs_run_delalloc_range() will do nothing because there is no
  EXTENT_DELALLOC flag.

- extent_writepage_io() find page 0 has no ordered flag
  Which falls into the COW fixup path, triggering the BUG_ON().

Unfortunately this error handling bug dates back to the introduction of btrfs.
Thankfully with the abuse of cow fixup, at least it won't crash the
kernel.

[FIX]
Instead of immediately unlock the extent and folios, we keep the extent
and folios locked until either erroring out or the whole delalloc range
finished.

When the whole delalloc range finished without error, we just unlock the
whole range with PAGE_SET_ORDERED (and PAGE_UNLOCK for !keep_locked
cases), with EXTENT_DELALLOC and EXTENT_LOCKED cleared.
And those involved folios will be properly submitted, with their dirty
flags cleared during submission.

For the error path, it will be a little more complex:

- The range with ordered extent allocated (range (1))
  We only clear the EXTENT_DELALLOC and EXTENT_LOCKED, as the remaining
  flags are cleaned up by
  btrfs_mark_ordered_io_finished()->btrfs_finish_one_ordered().

  For folios we finish the IO (clear dirty, start writeback and
  immediately finish the writeback) and unlock the folios.

- The range with reserved extent but no ordered extent (range(2))
- The range we never touched (range(3))
  For both range (2) and range(3) the behavior is not changed.

Now even if cow_file_range() failed halfway with some successfully
reserved extents/ordered extents, we will keep all folios clean, so
there will be no future writeback triggered on them.

Cc: stable@vger.kernel.org
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 65 ++++++++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 33 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 5ba8d044757b..19c88b7d0363 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1364,6 +1364,17 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
 	alloc_hint = btrfs_get_extent_allocation_hint(inode, start, num_bytes);
 
+	/*
+	 * We're not doing compressed IO, don't unlock the first page
+	 * (which the caller expects to stay locked), don't clear any
+	 * dirty bits and don't set any writeback bits
+	 *
+	 * Do set the Ordered (Private2) bit so we know this page was
+	 * properly setup for writepage.
+	 */
+	page_ops = (keep_locked ? 0 : PAGE_UNLOCK);
+	page_ops |= PAGE_SET_ORDERED;
+
 	/*
 	 * Relocation relies on the relocated extents to have exactly the same
 	 * size as the original extents. Normally writeback for relocation data
@@ -1423,6 +1434,10 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		file_extent.offset = 0;
 		file_extent.compression = BTRFS_COMPRESS_NONE;
 
+		/*
+		 * Locked range will be released either during error clean up or
+		 * after the whole range is finished.
+		 */
 		lock_extent(&inode->io_tree, start, start + cur_alloc_size - 1,
 			    &cached);
 
@@ -1468,21 +1483,6 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
 		btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 
-		/*
-		 * We're not doing compressed IO, don't unlock the first page
-		 * (which the caller expects to stay locked), don't clear any
-		 * dirty bits and don't set any writeback bits
-		 *
-		 * Do set the Ordered flag so we know this page was
-		 * properly setup for writepage.
-		 */
-		page_ops = (keep_locked ? 0 : PAGE_UNLOCK);
-		page_ops |= PAGE_SET_ORDERED;
-
-		extent_clear_unlock_delalloc(inode, start, start + cur_alloc_size - 1,
-					     locked_folio, &cached,
-					     EXTENT_LOCKED | EXTENT_DELALLOC,
-					     page_ops);
 		if (num_bytes < cur_alloc_size)
 			num_bytes = 0;
 		else
@@ -1499,6 +1499,9 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		if (ret)
 			goto out_unlock;
 	}
+	extent_clear_unlock_delalloc(inode, orig_start, end, locked_folio, &cached,
+				     EXTENT_LOCKED | EXTENT_DELALLOC,
+				     page_ops);
 done:
 	if (done_offset)
 		*done_offset = end;
@@ -1519,35 +1522,31 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	 * We process each region below.
 	 */
 
-	clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
-		EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV;
-	page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK;
-
 	/*
 	 * For the range (1). We have already instantiated the ordered extents
 	 * for this region. They are cleaned up by
 	 * btrfs_cleanup_ordered_extents() in e.g,
-	 * btrfs_run_delalloc_range(). EXTENT_LOCKED | EXTENT_DELALLOC are
-	 * already cleared in the above loop. And, EXTENT_DELALLOC_NEW |
-	 * EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV are handled by the cleanup
-	 * function.
+	 * btrfs_run_delalloc_range().
+	 * EXTENT_DELALLOC_NEW | EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV
+	 * are also handled by the cleanup function.
 	 *
-	 * However, in case of @keep_locked, we still need to unlock the pages
-	 * (except @locked_folio) to ensure all the pages are unlocked.
+	 * So here we only clear EXTENT_LOCKED and EXTENT_DELALLOC flag,
+	 * and finish the writeback of the involved folios, which will be
+	 * never submitted.
 	 */
-	if (keep_locked && orig_start < start) {
+	if (orig_start < start) {
+		clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC;
+		page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK;
+
 		if (!locked_folio)
 			mapping_set_error(inode->vfs_inode.i_mapping, ret);
 		extent_clear_unlock_delalloc(inode, orig_start, start - 1,
-					     locked_folio, NULL, 0, page_ops);
+					     locked_folio, NULL, clear_bits, page_ops);
 	}
 
-	/*
-	 * At this point we're unlocked, we want to make sure we're only
-	 * clearing these flags under the extent lock, so lock the rest of the
-	 * range and clear everything up.
-	 */
-	lock_extent(&inode->io_tree, start, end, NULL);
+	clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
+		EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV;
+	page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK;
 
 	/*
 	 * For the range (2). If we reserved an extent for our delalloc range
-- 
2.47.1


