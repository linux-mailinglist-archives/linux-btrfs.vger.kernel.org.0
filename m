Return-Path: <linux-btrfs+bounces-10283-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DBC9EDF47
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 07:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E958F283AA3
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 06:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4AF18A6D2;
	Thu, 12 Dec 2024 06:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="c5ZJRval";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="fDSjfFRQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4DF1862BB;
	Thu, 12 Dec 2024 06:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733984074; cv=none; b=FBIXJvjRzSW72fYO2aMeVzYhcoTOb0/HkcGAmaKITbXN/sox7p2PnhcAv1CM2Ep9tyn5Hy9TtyKh/vYnDHAgcu4aUSycpwiJ0af58S2yF4tWkHA5D6P0a91BLd+prDED9nBCJlBnlUi5LyCUeJujKB8F5VAzaCNV5qEUVgfMmfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733984074; c=relaxed/simple;
	bh=L/B1UqrKtLeEH31dJGj7iBLnkJpLGHMf6YC0gi68d9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rr0i+r5EyLi24wSRtDQNeyYpzvadkjZB6xTNzwN97UtB7qtycgX+DIMlA4tm96JKN8iO5ad2z0CXJTMCf+SOS9iAYq2lECOXi9eUL17pMkf24pushkq+X00IE2sHVC0q1BwrvzgoYcgfqDPO/ORTARohdNm6LqGqFR3/x4uM7cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=c5ZJRval; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=fDSjfFRQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E9EC921180;
	Thu, 12 Dec 2024 06:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733984070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lXeGdSU6OhwA5DpFBJMCEl3HwPss6RFr0iGp4wg60dU=;
	b=c5ZJRvalO79WNUvg5Kni74pw4wZFlsQznO1OUd+8eODD/ASCx+98jmx7Ln84LNZMGYqUyw
	g/QAZjgiUtesUrt6ojHsbH3bDerLb6TYMjGNJ7SXhby7n9r5y259JpAQYFQcaLYGEXee+u
	Q7XUEtYlcJbDDpok7/602D9PIvqmns0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733984069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lXeGdSU6OhwA5DpFBJMCEl3HwPss6RFr0iGp4wg60dU=;
	b=fDSjfFRQuAJd9sGCgoV48Av4FfBEyolJ93OuW4upHjnhmgYIm1K4q9+88nyyYZ1It3YUj9
	HHKBttJOiM28AJE+DctQuaJNJu16RXWtkniPfWW1VfE5OALyircX0+FCDe8PYaxEAVtoxP
	4SAutlntGQqk4juX8doFC+5B189NYCY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7A7713508;
	Thu, 12 Dec 2024 06:14:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cOn5JER/Wme5VQAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 12 Dec 2024 06:14:28 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 5/9] btrfs: do proper folio cleanup when run_delalloc_nocow() failed
Date: Thu, 12 Dec 2024 16:43:59 +1030
Message-ID: <d3a8799772abd1efd309a61f695a1774a742bfb9.1733983488.git.wqu@suse.com>
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
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

[BUG]
With CONFIG_DEBUG_VM set, test case generic/476 has some chance to crash
with the following VM_BUG_ON_FOLIO():

 BTRFS error (device dm-3): cow_file_range failed, start 1146880 end 1253375 len 106496 ret -28
 BTRFS error (device dm-3): run_delalloc_nocow failed, start 1146880 end 1253375 len 106496 ret -28
 page: refcount:4 mapcount:0 mapping:00000000592787cc index:0x12 pfn:0x10664
 aops:btrfs_aops [btrfs] ino:101 dentry name(?):"f1774"
 flags: 0x2fffff80004028(uptodate|lru|private|node=0|zone=2|lastcpupid=0xfffff)
 page dumped because: VM_BUG_ON_FOLIO(!folio_test_locked(folio))
 ------------[ cut here ]------------
 kernel BUG at mm/page-writeback.c:2992!
 Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
 CPU: 2 UID: 0 PID: 3943513 Comm: kworker/u24:15 Tainted: G           OE      6.12.0-rc7-custom+ #87
 Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
 Hardware name: QEMU KVM Virtual Machine, BIOS unknown 2/2/2022
 Workqueue: events_unbound btrfs_async_reclaim_data_space [btrfs]
 pc : folio_clear_dirty_for_io+0x128/0x258
 lr : folio_clear_dirty_for_io+0x128/0x258
 Call trace:
  folio_clear_dirty_for_io+0x128/0x258
  btrfs_folio_clamp_clear_dirty+0x80/0xd0 [btrfs]
  __process_folios_contig+0x154/0x268 [btrfs]
  extent_clear_unlock_delalloc+0x5c/0x80 [btrfs]
  run_delalloc_nocow+0x5f8/0x760 [btrfs]
  btrfs_run_delalloc_range+0xa8/0x220 [btrfs]
  writepage_delalloc+0x230/0x4c8 [btrfs]
  extent_writepage+0xb8/0x358 [btrfs]
  extent_write_cache_pages+0x21c/0x4e8 [btrfs]
  btrfs_writepages+0x94/0x150 [btrfs]
  do_writepages+0x74/0x190
  filemap_fdatawrite_wbc+0x88/0xc8
  start_delalloc_inodes+0x178/0x3a8 [btrfs]
  btrfs_start_delalloc_roots+0x174/0x280 [btrfs]
  shrink_delalloc+0x114/0x280 [btrfs]
  flush_space+0x250/0x2f8 [btrfs]
  btrfs_async_reclaim_data_space+0x180/0x228 [btrfs]
  process_one_work+0x164/0x408
  worker_thread+0x25c/0x388
  kthread+0x100/0x118
  ret_from_fork+0x10/0x20
 Code: 910a8021 a90363f7 a9046bf9 94012379 (d4210000)
 ---[ end trace 0000000000000000 ]---

[CAUSE]
The first two lines of extra debug messages show the problem is caused
by the error handling of run_delalloc_nocow().

E.g. we have the following dirtied range (4K blocksize 4K page size):

    0                 16K                  32K
    |//////////////////////////////////////|
    |  Pre-allocated  |

And the range [0, 16K) has a preallocated extent.

- Enter run_delalloc_nocow() for range [0, 16K)
  Which found range [0, 16K) is preallocated, can do the proper NOCOW
  write.

- Enter fallback_to_fow() for range [16K, 32K)
  Since the range [16K, 32K) is not backed by preallocated extent, we
  have to go COW.

- cow_file_range() failed for range [16K, 32K)
  So cow_file_range() will do the clean up by clearing folio dirty,
  unlock the folios.

  Now the folios in range [16K, 32K) is unlocked.

- Enter extent_clear_unlock_delalloc() from run_delalloc_nocow()
  Which is called with PAGE_START_WRITEBACK to start page writeback.
  But folios can only be marked writeback when it's properly locked,
  thus this triggered the VM_BUG_ON_FOLIO().

Furthermore there is another hidden but common bug that
run_delalloc_nocow() is not clearing the folio dirty flags in its error
handling path.
This is the common bug shared between run_delalloc_nocow() and
cow_file_range().

[FIX]
- Clear folio dirty for range [@start, @cur_offset)
  Introduce a helper, cleanup_dirty_folios(), which
  will find and lock the folio in the range, clear the dirty flag and
  start/end the writeback, with the extra handling for the
  @locked_folio.

- Introduce a helper to record the last failed COW range end
  This is to trace which range we should skip, to avoid double
  unlocking.

- Skip the failed COW range for the error handling

Cc: stable@vger.kernel.org
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 93 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 86 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 19c88b7d0363..bae8aceb3eae 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1961,6 +1961,48 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 	return ret < 0 ? ret : can_nocow;
 }
 
+static void cleanup_dirty_folios(struct btrfs_inode *inode,
+				 struct folio *locked_folio,
+				 u64 start, u64 end, int error)
+{
+	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	struct address_space *mapping = inode->vfs_inode.i_mapping;
+	pgoff_t start_index = start >> PAGE_SHIFT;
+	pgoff_t end_index = end >> PAGE_SHIFT;
+	u32 len;
+
+	ASSERT(end + 1 - start < U32_MAX);
+	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
+	       IS_ALIGNED(end + 1, fs_info->sectorsize));
+	len = end + 1 - start;
+
+	/*
+	 * Handle the locked folio first.
+	 * btrfs_folio_clamp_*() helpers can handle range out of the folio case.
+	 */
+	btrfs_folio_clamp_clear_dirty(fs_info, locked_folio, start, len);
+	btrfs_folio_clamp_set_writeback(fs_info, locked_folio, start, len);
+	btrfs_folio_clamp_clear_writeback(fs_info, locked_folio, start, len);
+
+	for (pgoff_t index = start_index; index <= end_index; index++) {
+		struct folio *folio;
+
+		/* Already handled at the beginning. */
+		if (index == locked_folio->index)
+			continue;
+		folio = __filemap_get_folio(mapping, index, FGP_LOCK, GFP_NOFS);
+		/* Cache already dropped, no need to do any cleanup. */
+		if (IS_ERR(folio))
+			continue;
+		btrfs_folio_clamp_clear_dirty(fs_info, folio, start, len);
+		btrfs_folio_clamp_set_writeback(fs_info, folio, start, len);
+		btrfs_folio_clamp_clear_writeback(fs_info, folio, start, len);
+		folio_unlock(folio);
+		folio_put(folio);
+	}
+	mapping_set_error(mapping, error);
+}
+
 /*
  * when nowcow writeback call back.  This checks for snapshots or COW copies
  * of the extents that exist in the file, and COWs the file as required.
@@ -1976,6 +2018,11 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	struct btrfs_root *root = inode->root;
 	struct btrfs_path *path;
 	u64 cow_start = (u64)-1;
+	/*
+	 * If not 0, represents the inclusive end of the last fallback_to_cow()
+	 * range. Only for error handling.
+	 */
+	u64 cow_end = 0;
 	u64 cur_offset = start;
 	int ret;
 	bool check_prev = true;
@@ -2136,6 +2183,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 					      found_key.offset - 1);
 			cow_start = (u64)-1;
 			if (ret) {
+				cow_end = found_key.offset - 1;
 				btrfs_dec_nocow_writers(nocow_bg);
 				goto error;
 			}
@@ -2209,11 +2257,12 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		cow_start = cur_offset;
 
 	if (cow_start != (u64)-1) {
-		cur_offset = end;
 		ret = fallback_to_cow(inode, locked_folio, cow_start, end);
 		cow_start = (u64)-1;
-		if (ret)
+		if (ret) {
+			cow_end = end;
 			goto error;
+		}
 	}
 
 	btrfs_free_path(path);
@@ -2221,12 +2270,42 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 
 error:
 	/*
-	 * If an error happened while a COW region is outstanding, cur_offset
-	 * needs to be reset to cow_start to ensure the COW region is unlocked
-	 * as well.
+	 * There are several error cases:
+	 *
+	 * 1) Failed without falling back to COW
+	 *    start         cur_start              end
+	 *    |/////////////|                      |
+	 *
+	 *    For range [start, cur_start) the folios are already unlocked (except
+	 *    @locked_folio), EXTENT_DELALLOC already removed.
+	 *    Only need to clear the dirty flag as they will never be submitted.
+	 *    Ordered extent and extent maps are handled by
+	 *    btrfs_mark_ordered_io_finished() inside run_delalloc_range().
+	 *
+	 * 2) Failed with error from fallback_to_cow()
+	 *    start         cur_start   cow_end    end
+	 *    |/////////////|-----------|          |
+	 *
+	 *    For range [start, cur_start) it's the same as case 1).
+	 *    But for range [cur_start, cow_end), the folios have dirty flag
+	 *    cleared and unlocked, EXTENT_DEALLLOC cleared.
+	 *    There may or may not be any ordered extents/extent maps allocated.
+	 *
+	 *    We should not call extent_clear_unlock_delalloc() on range [cur_start,
+	 *    cow_end), as the folios are already unlocked.
+	 *
+	 * So clear the folio dirty flags for [start, cur_offset) first.
 	 */
-	if (cow_start != (u64)-1)
-		cur_offset = cow_start;
+	if (cur_offset > start)
+		cleanup_dirty_folios(inode, locked_folio, start, cur_offset - 1, ret);
+
+	/*
+	 * If an error happened while a COW region is outstanding, cur_offset
+	 * needs to be reset to @cow_end + 1 to skip the COW range, as
+	 * cow_file_range() will do the proper cleanup at error.
+	 */
+	if (cow_end)
+		cur_offset = cow_end + 1;
 
 	/*
 	 * We need to lock the extent here because we're clearing DELALLOC and
-- 
2.47.1


