Return-Path: <linux-btrfs+bounces-10895-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9CDBA08606
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 04:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1365B3A9ED9
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jan 2025 03:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D142066CB;
	Fri, 10 Jan 2025 03:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="d/6bMcVg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="d/6bMcVg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2632E2063FB
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 03:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736479943; cv=none; b=XsoDxx2kmxGy66DaYqWejtmHjlwzTF9I5+J/Mm9b8WtEGo2JNupxHhNoDu3GI4ZIEbH066FZDYqlBnnywFlcjUM/VFdmdhdgwvU8b8qE/h+0xf1djq9+NM/rlTI+iGp/oULl1Z6DUU/dTCS4p2vpiFY0327OcL9rqHi3jP3cZuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736479943; c=relaxed/simple;
	bh=kpTCGnn/2whTqe17Imth1/AeER/W+YiTitVy40gON6Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARo98s5akUPTjrprFx/+lmm4dmP4ZdYUDnzm7YBJ2YmYMYLF24OoUuG2zVpFJGt3MqEk96dOaxFR8Mj78hbZ57hf7nmQo/NoGs41EpJtyMmhG5cvoO8Y/H4LOKnv7qcz1jA/E+gEwxHkD/nGuX/HWtw9nF67d8PIsi19e0VlHsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=d/6bMcVg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=d/6bMcVg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 75E4421169
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 03:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736479939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=svRqWGI5XZJJ+1o3VDaUyxQGHxpfTLjBy+yTF274+gE=;
	b=d/6bMcVgy+pQF6BocwnrN97lP32UB3KT/5hWP6U3Kwx1/N1r+5VF9GeD6tJvf9FRC1wS2j
	1JKL6OJPn7LvOvKe0uuHZnbxwmG6CemKZjAKGh8JYbqjgIT+XNn+NfGba1YyrV6pJDkHJN
	Ac63QaTWQBwZ8O4fWJkjKRIhfLuUT0Q=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1736479939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=svRqWGI5XZJJ+1o3VDaUyxQGHxpfTLjBy+yTF274+gE=;
	b=d/6bMcVgy+pQF6BocwnrN97lP32UB3KT/5hWP6U3Kwx1/N1r+5VF9GeD6tJvf9FRC1wS2j
	1JKL6OJPn7LvOvKe0uuHZnbxwmG6CemKZjAKGh8JYbqjgIT+XNn+NfGba1YyrV6pJDkHJN
	Ac63QaTWQBwZ8O4fWJkjKRIhfLuUT0Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1B2C1397D
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 03:32:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4EDMHMKUgGe0NQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Jan 2025 03:32:18 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v3 10/10] btrfs: move ordered extent cleanup to where they are allocated
Date: Fri, 10 Jan 2025 14:01:41 +1030
Message-ID: <194696d75e87010d4c2ed7e5b536d7d2cfe59652.1736479224.git.wqu@suse.com>
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

The ordered extent cleanup is hard to grasp because it doesn't follow
the common pattern that the cleanup happens where ordered extent get
allocated.

E.g. run_delalloc_nocow() and cow_file_range() allocate one or more
ordered extents, but if any error is hit, the cleanup is done inside
btrfs_run_delalloc_range().

Change the pattern to who-allocates-who-cleanup behavior, and update the
comment of involved functions to make it explicit on the ordered extents
cleanup behavior.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 03d76579878c..d884b0ff0b9b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1273,10 +1273,10 @@ u64 btrfs_get_extent_allocation_hint(struct btrfs_inode *inode, u64 start,
  * - Else all pages except for @locked_folio are unlocked.
  *
  * When a failure happens in the second or later iteration of the
- * while-loop, the ordered extents created in previous iterations are kept
- * intact. So, the caller must clean them up by calling
- * btrfs_cleanup_ordered_extents(). See btrfs_run_delalloc_range() for
- * example.
+ * while-loop, the ordered extents created in previous iterations will be
+ * cleaned up.
+ * So if cow_file_range() returned error, there will be no ordered extents
+ * created.
  */
 static noinline int cow_file_range(struct btrfs_inode *inode,
 				   struct folio *locked_folio, u64 start,
@@ -1489,9 +1489,7 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
 	/*
 	 * For the range (1). We have already instantiated the ordered extents
-	 * for this region. They are cleaned up by
-	 * btrfs_cleanup_ordered_extents() in e.g,
-	 * btrfs_run_delalloc_range().
+	 * for this region, and need to be cleaned up.
 	 * EXTENT_DELALLOC_NEW | EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV
 	 * are also handled by the cleanup function.
 	 *
@@ -1505,6 +1503,8 @@ static noinline int cow_file_range(struct btrfs_inode *inode,
 
 		if (!locked_folio)
 			mapping_set_error(inode->vfs_inode.i_mapping, ret);
+
+		btrfs_cleanup_ordered_extents(inode, orig_start, start - orig_start);
 		extent_clear_unlock_delalloc(inode, orig_start, start - 1,
 					     locked_folio, NULL, clear_bits, page_ops);
 	}
@@ -1981,6 +1981,9 @@ static void cleanup_dirty_folios(struct btrfs_inode *inode,
  *
  * If no cow copies or snapshots exist, we write directly to the existing
  * blocks on disk
+ *
+ * If error is hit, any ordered extent created inside the range will be
+ * properly cleaned up.
  */
 static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 				       struct folio *locked_folio,
@@ -2250,9 +2253,8 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	 *
 	 *    For range [start, cur_offset) the folios are already unlocked (except
 	 *    @locked_folio), EXTENT_DELALLOC already removed.
-	 *    Only need to clear the dirty flag as they will never be submitted.
-	 *    Ordered extent and extent maps are handled by
-	 *    btrfs_mark_ordered_io_finished() inside run_delalloc_range().
+	 *    Need to finish the ordered extents and their extent maps, then
+	 *    clear the dirty flag as they will never to submitted.
 	 *
 	 * 2) Failed with error from fallback_to_cow()
 	 *    start         cur_offset  cow_end    end
@@ -2265,10 +2267,13 @@ static noinline int run_delalloc_nocow(struct btrfs_inode *inode,
 	 *    Thus we should not call extent_clear_unlock_delalloc() on range
 	 *    [cur_offset, cow_end), as the folios are already unlocked.
 	 *
-	 * So clear the folio dirty flags for [start, cur_offset) first.
+	 * So clear the folio dirty flags for [start, cur_offset) and finish
+	 * the ordered extents.
 	 */
-	if (cur_offset > start)
+	if (cur_offset > start) {
+		btrfs_cleanup_ordered_extents(inode, start, cur_offset - start);
 		cleanup_dirty_folios(inode, locked_folio, start, cur_offset - 1, ret);
+	}
 
 	/*
 	 * If an error happened while a COW region is outstanding, cur_offset
@@ -2333,7 +2338,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_fol
 
 	if (should_nocow(inode, start, end)) {
 		ret = run_delalloc_nocow(inode, locked_folio, start, end);
-		goto out;
+		return ret;
 	}
 
 	if (btrfs_inode_can_compress(inode) &&
@@ -2347,10 +2352,6 @@ int btrfs_run_delalloc_range(struct btrfs_inode *inode, struct folio *locked_fol
 	else
 		ret = cow_file_range(inode, locked_folio, start, end, NULL,
 				     false, false);
-
-out:
-	if (ret < 0)
-		btrfs_cleanup_ordered_extents(inode, start, end - start + 1);
 	return ret;
 }
 
-- 
2.47.1


