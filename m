Return-Path: <linux-btrfs+bounces-15644-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D386B0F10E
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jul 2025 13:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E5E21C262C1
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Jul 2025 11:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63252E4277;
	Wed, 23 Jul 2025 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sa/g300/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="sa/g300/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76E427A124
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Jul 2025 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753269701; cv=none; b=IgEJDZM3jxqnSR9+QkxGAVKyh2t8vetNKsNywyCiLtq7kXRXQsTRNU9nv4A4+3zAZmOHzoAaYrD6kk+w68M72AxJd+p3IOnAOFpoqr9V6R+G8aLrIn77ElsuR0OeaL8APU0TCLWOnvop27pE3NaZ6dTZmLWdKIp541gTZxftu5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753269701; c=relaxed/simple;
	bh=wMEqFWbdfdXHeeem9fg3Cz0vEXNohaoslSlF0o/0zlU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSkJKkodHxgZaiqgMU5V1w7OW4sEnac9u64/4aNoERIU68PFLze21Y2PRR35AXZ3ZOAx7swZoB2h38du3Xvtw6Sgd+Jrm7StBsnB0j8xS+IeID4YWGVtHeBZ19YHsCwXto3rwev3hBrfDgKToFEqnIqYyRDUwJbfqxqgJcerXmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sa/g300/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=sa/g300/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 30F70218F0
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Jul 2025 11:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753269692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aeLiqd+qdcMdutux41QuuUoiH10sx4torkn66Xb+tMI=;
	b=sa/g300/00/NdZKafqcJV7WPTgxOHQi7u+dYjNAkJLxqWTOz5NFcJPgYvR59S5O2BslBeT
	SN//G5N2/h+nklwhJq641+F0lvA9hZaXAB4PtjDmKAvNJNOQl+t+mjtCHwVHj08O+RiLsT
	l2uZNBCfMLcZ+EJTpuIcuVpm1kg442o=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="sa/g300/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1753269692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aeLiqd+qdcMdutux41QuuUoiH10sx4torkn66Xb+tMI=;
	b=sa/g300/00/NdZKafqcJV7WPTgxOHQi7u+dYjNAkJLxqWTOz5NFcJPgYvR59S5O2BslBeT
	SN//G5N2/h+nklwhJq641+F0lvA9hZaXAB4PtjDmKAvNJNOQl+t+mjtCHwVHj08O+RiLsT
	l2uZNBCfMLcZ+EJTpuIcuVpm1kg442o=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5BEBE13302
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Jul 2025 11:21:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GPVoB7vFgGhaeAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 23 Jul 2025 11:21:31 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs: keep folios locked inside run_delalloc_nocow()
Date: Wed, 23 Jul 2025 20:51:24 +0930
Message-ID: <d54602261267d1a213c81f78b23e96b08c1d10ac.1753269601.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753269601.git.wqu@suse.com>
References: <cover.1753269601.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 30F70218F0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

  For fallback_to_cow() we can just pass COW_FILE_RANGE_KEEP_LOCKED flag
  for cow_file_range().

  For nocow_one_range() we have need to remove the PAGE_UNLOCK flag.

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
 fs/btrfs/inode.c | 70 ++++++++++++++----------------------------------
 1 file changed, 20 insertions(+), 50 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3f2f3c6024ba..cbbfda5682a8 100644
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
@@ -2241,6 +2200,14 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
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
 
@@ -2288,7 +2255,10 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 
 	if (cur_offset > start) {
 		btrfs_cleanup_ordered_extents(inode, start, cur_offset - start);
-		cleanup_dirty_folios(inode, locked_folio, start, cur_offset - 1, ret);
+		extent_clear_unlock_delalloc(inode, start, cur_offset - 1, locked_folio, NULL,
+					     EXTENT_LOCKED | EXTENT_DELALLOC,
+					     PAGE_UNLOCK | PAGE_START_WRITEBACK |
+					     PAGE_END_WRITEBACK);
 	}
 
 	/*
-- 
2.50.0


