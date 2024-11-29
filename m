Return-Path: <linux-btrfs+bounces-9964-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76689DBF80
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2024 07:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BCF8B21997
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Nov 2024 06:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EFA1547D5;
	Fri, 29 Nov 2024 06:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="TtZ7ftPY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="t9bzd7i8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67397BA4B
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2024 06:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732861977; cv=none; b=icljKR4z+mwfn1LUTAvy/N5U5LGZYBfDnLeUzuUEy7KSg2j24G4Ci+UrdeYH3aD9gaCs9H8OqoU57wFLWsLllllLfxaGX3RD/RCMB6/Q5uw0AijrlzpU63UfP967jSCnuo8HsGuJY5dpq2yyJUrjFEYVgF6TJWyWgReFgup5idI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732861977; c=relaxed/simple;
	bh=UoBM7vhwcO0/Aw90290ZidXU8w5Il1aWUTnAnSmOuMg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=WCNRjPU694cPktbwjxRgwNJk7Qengmkf1VDtqLFMLvBLLSwPzfrZuaHCZ9pVbMe6bws3eFLUXS2AQFe4LV7xGr3sJGdd81Ueqy6jUSHksBY3hED42LCgBELJ57CQD8n24n+bEVadXCvG51ZAdi2dEVCCAyodo6rNn8BAprna/Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=TtZ7ftPY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=t9bzd7i8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 69BFA211A6
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2024 06:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732861972; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hpHUQpXxdoQ60ON/Wvg5ccYWl9fmJQTJlj+k529issE=;
	b=TtZ7ftPY1f4eJFqc2TQoQhyI8os24xvSiWFBGMvaJjsNDCBM4gn8OGQPGQx7/3G+xmmwO7
	lwM+iIfdhOank1tzuKeWu71Chpk9BjgXtmrPyku3gaSo0Nn8d1tH1iVmyU5ONOvARJ3deJ
	dqho66XCk3OcppnPsL8N1isxxi1hKLg=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=t9bzd7i8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1732861971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=hpHUQpXxdoQ60ON/Wvg5ccYWl9fmJQTJlj+k529issE=;
	b=t9bzd7i8fgY6JBbvduv0gv07k2N2dy8yOn8JRKXhJMMvYLEJfjFUYZgjjADEznFio0MgX3
	8tFuSAHIlt1YbBo086wu/c7FAoAEIoNWYfOh3BER+jGrgVQL3bJmUe6N9VKqBq9ipIEGzx
	F/OQt3BsJgZZWSXJzkfbUojvXGTLAQg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0D2A139AA
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2024 06:32:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b6s5GBJgSWfJHwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 29 Nov 2024 06:32:50 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC] btrfs: keep EXTENT_DELALLOC* flags when cow_file_range() failed
Date: Fri, 29 Nov 2024 17:02:28 +1030
Message-ID: <bd9263e9fb83ba977aff71b4d34e4435342f0a3a.1732861916.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 69BFA211A6
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
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
   But since we haven't yet submit any bio, all pages are still dirty.

- Function btrfs_reserve_extent() return with -ENOSPC
  Now we have to run error cleanup, which will clear all
  EXTENT_DELALLOC* flags for the range, now we have:

   0        16K        32K       48K       64K
   |////////|//////////////////////////////|
   |        |                              |

   Note that all pages are still dirty.

- Some time later, writeback are triggered again for the range [0, 64K)

- btrfs_run_delalloc_range() will do nothing because there is no
  EXTENT_DELALLOC flag.

- extent_writepage_io() find page 0 has no ordered flag
  Which falls into the COW fixup path, triggering the BUG_ON().

[FIX]
To be honest, I have no idea what's the proper way to handle an error
during btrfs_run_delalloc_range().

All existing handling are treating them like the IO is done, clearing
all the EXTENT_DELALLOC* flags and reserved qgroup space.

But we still leave all those page marked as dirty, and later writeback
may still try write those pages back.

So here I choose to treat them as untouched at all, keeping all the
EXTENT_DELALLOC* flags along with reserved data/qgroup space.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Reason for RFC:

I have no idea what's the proper way to handle
btrfs_run_delalloc_range() failure, but since we're trying to
deprecating the COW fixup, at least we need to keep the EXTENT_DELALLOC*
flags.

The other solution is to follow the iomap's handling, if map_blocks()
failed, just mark all folios in the range as clean, and keep the current
handling.

At least for now that indeed sounds way more reasonable.
---
 fs/btrfs/inode.c | 90 ++++++++++++++++++++++++++----------------------
 1 file changed, 48 insertions(+), 42 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9267861f8ab0..9d5a3ed95528 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1372,6 +1372,17 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
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
@@ -1477,20 +1488,13 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		btrfs_dec_block_group_reservations(fs_info, ins.objectid);
 
 		/*
-		 * We're not doing compressed IO, don't unlock the first page
-		 * (which the caller expects to stay locked), don't clear any
-		 * dirty bits and don't set any writeback bits
+		 * There used to be an extent_clear_unlock_delalloc() call.
+		 * But that will clear EXTENT_DELALLOC flag even if we error out
+		 * later, with the page still marked dirty.
 		 *
-		 * Do set the Ordered (Private2) bit so we know this page was
-		 * properly setup for writepage.
+		 * So here we intentionally do not unlock this range.
+		 * But only unlock the full range when everything go OK.
 		 */
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
@@ -1507,6 +1511,10 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 		if (ret)
 			goto out_unlock;
 	}
+	extent_clear_unlock_delalloc(inode, orig_start, end,
+				     locked_folio, &cached,
+				     EXTENT_LOCKED | EXTENT_DELALLOC,
+				     page_ops);
 done:
 	if (done_offset)
 		*done_offset = end;
@@ -1525,38 +1533,42 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	 * `- orig_start  `- start  `- start + cur_alloc_size  `- end
 	 *
 	 * We process each region below.
+	 *
+	 *
+	 * For the EXTENT_* flags, we should only unlock them and do not touch
+	 * the EXTENT_DELALLOC* flags.
+	 *
+	 * All pages in above ranges (1)(2)(3) are not submitted thus they are
+	 * still dirty and may be rewritten back later.
+	 * Thus they should still be treated as EXTENT_DEALLOC, or no new
+	 * delalloc range will be run.
+	 * In that case we will fall back to the to-be-deprecated COW fixup
+	 * path.
+	 *
+	 * The same applies to the reserved bytes and qgroup space.
 	 */
-
-	clear_bits = EXTENT_LOCKED | EXTENT_DELALLOC | EXTENT_DELALLOC_NEW |
-		EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV;
-	page_ops = PAGE_UNLOCK | PAGE_START_WRITEBACK | PAGE_END_WRITEBACK;
+	clear_bits = EXTENT_LOCKED;
+	page_ops = PAGE_UNLOCK;
 
 	/*
 	 * For the range (1). We have already instantiated the ordered extents
-	 * for this region. They are cleaned up by
+	 * for this region. Ordered extents are cleaned up by
 	 * btrfs_cleanup_ordered_extents() in e.g,
-	 * btrfs_run_delalloc_range(). EXTENT_LOCKED | EXTENT_DELALLOC are
-	 * already cleared in the above loop. And, EXTENT_DELALLOC_NEW |
-	 * EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV are handled by the cleanup
-	 * function.
-	 *
-	 * However, in case of @keep_locked, we still need to unlock the pages
-	 * (except @locked_folio) to ensure all the pages are unlocked.
+	 * btrfs_run_delalloc_range(), which will also free the reserved extents.
 	 */
-	if (keep_locked && orig_start < start) {
+	if (orig_start < start) {
+		unlock_extent(&inode->io_tree, orig_start, start - 1, NULL);
 		if (!locked_folio)
 			mapping_set_error(inode->vfs_inode.i_mapping, ret);
-		extent_clear_unlock_delalloc(inode, orig_start, start - 1,
-					     locked_folio, NULL, 0, page_ops);
+		/*
+		 * However, in case of @keep_locked, we still need to unlock the pages
+		 * (except @locked_folio) to ensure all the pages are unlocked.
+		 */
+		if (keep_locked)
+			extent_clear_unlock_delalloc(inode, orig_start, start - 1,
+						     locked_folio, NULL, 0, page_ops);
 	}
 
-	/*
-	 * At this point we're unlocked, we want to make sure we're only
-	 * clearing these flags under the extent lock, so lock the rest of the
-	 * range and clear everything up.
-	 */
-	lock_extent(&inode->io_tree, start, end, NULL);
-
 	/*
 	 * For the range (2). If we reserved an extent for our delalloc range
 	 * (or a subrange) and failed to create the respective ordered extent,
@@ -1567,13 +1579,11 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	 * to decrement again the data space_info's bytes_may_use counter,
 	 * therefore we do not pass it the flag EXTENT_CLEAR_DATA_RESV.
 	 */
-	if (cur_alloc_size) {
+	if (cur_alloc_size)
 		extent_clear_unlock_delalloc(inode, start,
 					     start + cur_alloc_size - 1,
 					     locked_folio, &cached, clear_bits,
 					     page_ops);
-		btrfs_qgroup_free_data(inode, NULL, start, cur_alloc_size, NULL);
-	}
 
 	/*
 	 * For the range (3). We never touched the region. In addition to the
@@ -1581,14 +1591,10 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 	 * space_info's bytes_may_use counter, reserved in
 	 * btrfs_check_data_free_space().
 	 */
-	if (start + cur_alloc_size < end) {
-		clear_bits |= EXTENT_CLEAR_DATA_RESV;
+	if (start + cur_alloc_size < end)
 		extent_clear_unlock_delalloc(inode, start + cur_alloc_size,
 					     end, locked_folio,
 					     &cached, clear_bits, page_ops);
-		btrfs_qgroup_free_data(inode, NULL, start + cur_alloc_size,
-				       end - start - cur_alloc_size + 1, NULL);
-	}
 	return ret;
 }
 
-- 
2.47.0


