Return-Path: <linux-btrfs+bounces-15706-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EDDB136B0
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 10:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626D13BD029
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Jul 2025 08:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFFF24DCEF;
	Mon, 28 Jul 2025 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OpPll5KY";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OpPll5KY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34181248F57
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691322; cv=none; b=DU7+hcVNw7S/kfxm0sVIdMTb+1m4cu749nf1ZRnc2/XqD9d0WGzckLto4l7WjN3lDLryWJmXiEJVTUYjPdBgkYL60NN60zm0IOECq6eYFyYtr4+0SpQ7vvbVc0fVrxT/YGYg1npV57077kokB6n+VE3L3TQT0e4S8DO+/kMhQjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691322; c=relaxed/simple;
	bh=mjoB+Ovn2n8grfIzFyF9U8sXU4IypJjudgXMtqEGN6U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPoWPdVT8SrWB4XwfyK1xroM06tuAKsta1QQny0T5xX/2D6YBlEN6e3e7TAgDfIKp2d7lzx+yNVBre6wv+SIIE+eX6T0MnMR0ukEXfcsT72hx4UZ73zH/meDzdupXvaWgcheEnI44mb8NuBC2szwMQv9ULFxBTxl0roiBv8qed8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OpPll5KY; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OpPll5KY; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1885E1F788
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 08:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753691301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UwSWqssh1AcXtVbLQYk75lIBpac37omDa2jz/zUykRY=;
	b=OpPll5KYHGRldlUBGxiqwXEAbXAEfIfK5YVm5qIWAH/YOKO64FTG8+akUdMRkIh02F1DHs
	5+9JMHVzNlqEkfejnKyiZNjeGMBYjUQpAycmdk1rCxmvB4IQXsNg63VRlyW/3hcJzkSfM3
	K90uhOEW2UrdO65XFqCm+8ZHlTtPN8c=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=OpPll5KY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753691301; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UwSWqssh1AcXtVbLQYk75lIBpac37omDa2jz/zUykRY=;
	b=OpPll5KYHGRldlUBGxiqwXEAbXAEfIfK5YVm5qIWAH/YOKO64FTG8+akUdMRkIh02F1DHs
	5+9JMHVzNlqEkfejnKyiZNjeGMBYjUQpAycmdk1rCxmvB4IQXsNg63VRlyW/3hcJzkSfM3
	K90uhOEW2UrdO65XFqCm+8ZHlTtPN8c=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 564D7138A5
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 08:28:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kIaSBqQ0h2g0GwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 28 Jul 2025 08:28:20 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 4/4] btrfs: keep folios locked inside run_delalloc_nocow()
Date: Mon, 28 Jul 2025 17:57:57 +0930
Message-ID: <a5a3c2f37bbe0b32ffaa8a15a85515ab9f173a28.1753687685.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1753687685.git.wqu@suse.com>
References: <cover.1753687685.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 1885E1F788
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_EQ_ENVFROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Score: -3.01

[BUG]
There is a very low chance that DEBUG_WARN() inside
btrfs_writepage_cow_fixup() can be triggered when
CONFIG_BTRFS_EXPERIMENTAL is enabled.

This only happens after run_delalloc_nocow() failed.

Unfortunately I haven't hit it for a while thus no real world dmesg for
now.

[CAUSE]
There is a race window where after run_delalloc_nocow() failed, error
handling can race with writeback thread.

Before we hit run_delalloc_nocow(), there is an inode with the following
dirty pages: (4K page size, 4K block size, no large folio)

  0         4K          8K          12K          16K
  |/////////|///////////|///////////|////////////|

The inode also have NODATACOW flag, and the above dirty range will go
through different extents during run_delalloc_range():

  0         4K          8K          12K          16K
  |  NOCOW  |    COW    |    COW    |   NOCOW    |

The race happen like this:

    writeback thread A            |        writeback thread B
----------------------------------+--------------------------------------
Writeback for folio 0             |
run_delalloc_nocow()              |
|- nocow_one_range()              |
|  For range [0, 4K), ret = 0     |
|                                 |
|- fallback_to_cow()              |
|  For range [4K, 8K), ret = 0    |
|  Folio 4K *UNLOCKED*            |
|                                 | Writeback for folio 4K
|- fallback_to_cow()              | extent_writepage()
|  For range [8K, 12K), failure   | |- writepage_delalloc()
|				  | |
|- btrfs_cleanup_ordered_extents()| |
   |- btrfs_folio_clear_ordered() | |
   |  Folio 0 still locked, safe  | |
   |                              | |  Ordered extent already allocated.
   |                              | |  Nothing to do.
   |                              | |- extent_writepage_io()
   |                              |    |- btrfs_writepage_cow_fixup()
   |- btrfs_folio_clear_ordered() |    |
      Folio 4K hold by thread B,  |    |
      UNSAFE!                     |    |- btrfs_test_ordered()
                                  |    |  Cleared by thread A,
				  |    |
                                  |    |- DEBUG_WARN();

This is only possible after run_delalloc_nocow() failure, as
cow_file_range() will keep all folios and io tree range locked, until
everything is finished or after error handling.

The root cause is we allow fallback_to_cow() and nocow_one_range() to
unlock the folios after a successful run, so that during error handling
we're no longer safe to use btrfs_cleanup_ordered_extents() as the
folios are already unlocked.

[FIX]
- Make fallback_to_cow() and nocow_one_range() to keep folios locked
  after a successful run

  For fallback_to_cow() we can pass COW_FILE_RANGE_KEEP_LOCKED flag
  into cow_file_range().

  For nocow_one_range() we have to remove the PAGE_UNLOCK flag from
  extent_clear_unlock_delalloc().

- Unlock folios if everything is fine in run_delalloc_nocow()

- Use extent_clear_unlock_delalloc() to handle range [@start,
  @cur_offset) inside run_delalloc_nocow()
  Since folios are still locked, we do not need
  cleanup_dirty_folios() to do the cleanup.

  extent_clear_unlock_delalloc() with "PAGE_START_WRIBACK |
  PAGE_END_WRITEBACK" will clear the dirty flags.

- Remove cleanup_dirty_folios()

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 73 +++++++++++++++---------------------------------
 1 file changed, 22 insertions(+), 51 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 1466f4356826..902a1d03d20e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1772,9 +1772,15 @@ static int fallback_to_cow(struct btrfs_inode *inode,
 	 * Don't try to create inline extents, as a mix of inline extent that
 	 * is written out and unlocked directly and a normal NOCOW extent
 	 * doesn't work.
+	 *
+	 * And here we do not unlock the folio after a successful run.
+	 * The folios will be unlocked after everything is finished, or by error handling.
+	 *
+	 * This is to ensure error handling won't need to clear dirty/ordered flags without
+	 * a locked folio, which can race with writeback.
 	 */
 	ret = cow_file_range(inode, locked_folio, start, end, NULL,
-			     COW_FILE_RANGE_NO_INLINE);
+			     COW_FILE_RANGE_NO_INLINE | COW_FILE_RANGE_KEEP_LOCKED);
 	ASSERT(ret != 1);
 	return ret;
 }
@@ -1917,53 +1923,6 @@ static int can_nocow_file_extent(struct btrfs_path *path,
 	return ret < 0 ? ret : can_nocow;
 }
 
-/*
- * Cleanup the dirty folios which will never be submitted due to error.
- *
- * When running a delalloc range, we may need to split the ranges (due to
- * fragmentation or NOCOW). If we hit an error in the later part, we will error
- * out and previously successfully executed range will never be submitted, thus
- * we have to cleanup those folios by clearing their dirty flag, starting and
- * finishing the writeback.
- */
-static void cleanup_dirty_folios(struct btrfs_inode *inode,
-				 struct folio *locked_folio,
-				 u64 start, u64 end, int error)
-{
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
-	struct address_space *mapping = inode->vfs_inode.i_mapping;
-	pgoff_t start_index = start >> PAGE_SHIFT;
-	pgoff_t end_index = end >> PAGE_SHIFT;
-	u32 len;
-
-	ASSERT(end + 1 - start < U32_MAX);
-	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
-	       IS_ALIGNED(end + 1, fs_info->sectorsize));
-	len = end + 1 - start;
-
-	/*
-	 * Handle the locked folio first.
-	 * The btrfs_folio_clamp_*() helpers can handle range out of the folio case.
-	 */
-	btrfs_folio_clamp_finish_io(fs_info, locked_folio, start, len);
-
-	for (pgoff_t index = start_index; index <= end_index; index++) {
-		struct folio *folio;
-
-		/* Already handled at the beginning. */
-		if (index == locked_folio->index)
-			continue;
-		folio = __filemap_get_folio(mapping, index, FGP_LOCK, GFP_NOFS);
-		/* Cache already dropped, no need to do any cleanup. */
-		if (IS_ERR(folio))
-			continue;
-		btrfs_folio_clamp_finish_io(fs_info, locked_folio, start, len);
-		folio_unlock(folio);
-		folio_put(folio);
-	}
-	mapping_set_error(mapping, error);
-}
-
 static int nocow_one_range(struct btrfs_inode *inode, struct folio *locked_folio,
 			   struct extent_state **cached,
 			   struct can_nocow_file_extent_args *nocow_args,
@@ -2013,7 +1972,7 @@ static int nocow_one_range(struct btrfs_inode *inode, struct folio *locked_folio
 	extent_clear_unlock_delalloc(inode, file_pos, end, locked_folio, cached,
 				     EXTENT_LOCKED | EXTENT_DELALLOC |
 				     EXTENT_CLEAR_DATA_RESV,
-				     PAGE_UNLOCK | PAGE_SET_ORDERED);
+				     PAGE_SET_ORDERED);
 	return ret;
 error:
 	btrfs_cleanup_ordered_extents(inode, file_pos, len);
@@ -2247,6 +2206,14 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 		cow_start = (u64)-1;
 	}
 
+	/*
+	 * Everything is finished without an error, can unlock the folios now.
+	 *
+	 * No need to touch the io tree range nor set folio ordered flag, as
+	 * fallback_to_cow() and nocow_one_range() have already handled them.
+	 */
+	extent_clear_unlock_delalloc(inode, start, end, locked_folio, NULL, 0, PAGE_UNLOCK);
+
 	btrfs_free_path(path);
 	return 0;
 
@@ -2305,9 +2272,13 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	}
 
 	if (oe_cleanup_len) {
+		const u64 oe_cleanup_end = oe_cleanup_start + oe_cleanup_len - 1;
 		btrfs_cleanup_ordered_extents(inode, oe_cleanup_start, oe_cleanup_len);
-		cleanup_dirty_folios(inode, locked_folio, oe_cleanup_start,
-				     oe_cleanup_start + oe_cleanup_len - 1, ret);
+		extent_clear_unlock_delalloc(inode, oe_cleanup_start, oe_cleanup_end,
+					     locked_folio, NULL,
+					     EXTENT_LOCKED | EXTENT_DELALLOC,
+					     PAGE_UNLOCK | PAGE_START_WRITEBACK |
+					     PAGE_END_WRITEBACK);
 	}
 
 	if (untouched_len) {
-- 
2.50.1


