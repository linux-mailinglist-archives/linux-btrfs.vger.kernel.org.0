Return-Path: <linux-btrfs+bounces-10068-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF859E4D42
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 06:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A796118811E7
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2024 05:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4741957FF;
	Thu,  5 Dec 2024 05:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eimmyjPi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="eimmyjPi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0782119;
	Thu,  5 Dec 2024 05:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733376523; cv=none; b=hyVAa8jY3cL5v7Sn1kGB7NWTbYSLf//geeIaN38gByH9RfK0aodrtPgkgw2L17AVehkYCwEj6qlBifrO8V3d3sk8WN1KXV8n+LBhgyB8lPbUHb8/TxNOfCqK+nslpD4yOpfPU+3PmzPfqtjMiNXYFajQXnTtpGaAxxleypAeN+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733376523; c=relaxed/simple;
	bh=/8UCSQl4pxiOSyBrqZRO0JFw+PLPL/+5R8AiwObp7Kk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EJjOdosdK5rUeA/a7ajrwPHaWVYMjMIsWF7przNfFmU7sagQHTDFgmdC3/25SqBtsc9Itp/BH9We8U6ze2G9UPTz3+OBmFSgPC0M5Rr1MJkyNriy8VfFQpwhxLh0TFxprCujFV4tzhGbJLtUbW+KJ0VkCG0o5xE2ZNA/aeBjYiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eimmyjPi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=eimmyjPi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A27742111F;
	Thu,  5 Dec 2024 05:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733376517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gS4WkCanRrJZdqbSeB+qrWdvDzi21iRvN1vq1p+0zik=;
	b=eimmyjPi2EI8U36th4Bb1p56J0bTuGS/Q+wAO7qSZchpMhvBB+xnkBPBJsJR69W4zrwZMP
	GV6PMlODa0npSOvKy5HXidBEemNJSZ08DS8e8y7jgjqT8ASm2IB3mjdyqjdeHxscvlE4ZM
	yXGNRfVnMzXm2hFlxOkyPFG6EWusehM=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1733376517; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=gS4WkCanRrJZdqbSeB+qrWdvDzi21iRvN1vq1p+0zik=;
	b=eimmyjPi2EI8U36th4Bb1p56J0bTuGS/Q+wAO7qSZchpMhvBB+xnkBPBJsJR69W4zrwZMP
	GV6PMlODa0npSOvKy5HXidBEemNJSZ08DS8e8y7jgjqT8ASm2IB3mjdyqjdeHxscvlE4ZM
	yXGNRfVnMzXm2hFlxOkyPFG6EWusehM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D04213479;
	Thu,  5 Dec 2024 05:28:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8KfXDgQ6UWd1QAAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 05 Dec 2024 05:28:36 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v3] btrfs: do proper folio cleanup when run_delalloc_nocow() failed
Date: Thu,  5 Dec 2024 15:58:18 +1030
Message-ID: <f8510096bab7e36a4cc0a6e5d2cae4616410b98c.1733374184.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.995];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

[BUG]
There are at least two problems when run_delalloc_nocow() hits some
error and has to go cleanup routine:

- It doesn't clear the folio dirty flags of any successfully ran range
  This breaks the regular error handling protocol for folio writeback,
  which should clear the dirty flag of the failed range.
  This clean up protocol is adapted by both iomap and btrfs (if the error
  happened at the very beginning of the whole delalloc range).

- It can start writeback/unlock folios which is already unlocked
  This is done by calling extent_clear_unlock_delalloc() with
  PAGE_START_WRITEBACK or PAGE_UNLOCK flag.
  This will trigger the VM_BUG_ON() for folio_start_writeback(), which
  requires the folio to be locked.

[CAUSE]
The problem of not clearing the folio dirty flag is a common bug, shared
between cow_file_range() and run_delalloc_nocow().
We just need to clear the folio dirty flags according to the @cur_offset
cursor.

For the extent_clear_unlock_delalloc() on unlocked folios, it's because
the double error handling, one from cow_file_range() (inside
fallback_to_cow()), one from run_delalloc_nocow() itself.

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
Changelog:
v3:
- Fix the double error handling on the COW range
  Which can lead to VM_BUG_ON() for extent_clear_unlock_delalloc(), as
  the folio is already unlocked by the error handling inside
  cow_file_range().

- Update the commit message to explain the bug better

- Add a comment inside the error handling explaining the error patterns

v2:
- Fix the incorrect @cur_offset assignment to @end
  The @end is not aligned to sector size, nor @cur_offset should be
  updated before fallback_to_cow() succeeded.

- Add one extra ASSERT() to make sure the range is properly aligned
---
 fs/btrfs/inode.c | 93 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 86 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 9517fb2df649..069599b025a6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1969,6 +1969,48 @@ static int can_nocow_file_extent(struct btrfs_path *path,
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
@@ -1984,6 +2026,11 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
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
@@ -2144,6 +2191,7 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 					      found_key.offset - 1);
 			cow_start = (u64)-1;
 			if (ret) {
+				cow_end = found_key.offset - 1;
 				btrfs_dec_nocow_writers(nocow_bg);
 				goto error;
 			}
@@ -2217,11 +2265,12 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
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
@@ -2229,12 +2278,42 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 
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


