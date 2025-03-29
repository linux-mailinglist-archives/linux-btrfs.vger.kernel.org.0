Return-Path: <linux-btrfs+bounces-12675-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 552C7A7556E
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Mar 2025 10:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4338D1892EEA
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Mar 2025 09:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E5B1A9B34;
	Sat, 29 Mar 2025 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bJM41r5M";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="bJM41r5M"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8987E18CC1D
	for <linux-btrfs@vger.kernel.org>; Sat, 29 Mar 2025 09:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743240028; cv=none; b=EQy8w1Zq5aWCEH30DuKdR/Q0/5ZKEUjo3vXdY0Q3hyV5wN/lsyeOdkRKxNU3zuiPogY9sh22BWRPO1+yJ/rBPk8gzPDQsm/VOh1EwxcpmKLMhXD4zbS/+5GV7n6biejtsUNKr1o1nSpT2cZYI8ZMtkXTEavsVyNrXqG2nA7T9cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743240028; c=relaxed/simple;
	bh=Drr5ardnu6hbLTAQmtcq+ncPIjVrBwbE9xiUcAHK5bQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUh7PZOloPr2btGqH3Y8tg1Ur8I2MNsBSVeDIfgTKMcehyusZKB1HEndoMCmWxl1SzmZoEE6qGpu6he2tzuXkMzqzjPjpiCspMZWR1ogttXg9IGyDGr8Q7/c8Fi0JFJyCyURauoQgAUI9L2BnJq2c+QMoYoILs0Y98DNNjTT9Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bJM41r5M; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=bJM41r5M; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D0B5121210
	for <linux-btrfs@vger.kernel.org>; Sat, 29 Mar 2025 09:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743240009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Zp0xLTG8zm1YmgSnBtk6UBdGyTY0kj8y1qJYyz7qBk=;
	b=bJM41r5MlxMyhjkyE1QNC/52zD3Nf84CUji/mmtb0trVLaZfPP3WF1aorXrOZKI7geWV6z
	6t+HyAiSPzoIAkio2xJYUxSqbSmHJANd9/tdCmH32kvtA8cBen3gmrJhl85XRclK401hTY
	2jT5bJyhpv/7kY6vUp+K9p03haKYZU0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=bJM41r5M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1743240009; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Zp0xLTG8zm1YmgSnBtk6UBdGyTY0kj8y1qJYyz7qBk=;
	b=bJM41r5MlxMyhjkyE1QNC/52zD3Nf84CUji/mmtb0trVLaZfPP3WF1aorXrOZKI7geWV6z
	6t+HyAiSPzoIAkio2xJYUxSqbSmHJANd9/tdCmH32kvtA8cBen3gmrJhl85XRclK401hTY
	2jT5bJyhpv/7kY6vUp+K9p03haKYZU0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15F1C13A41
	for <linux-btrfs@vger.kernel.org>; Sat, 29 Mar 2025 09:20:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2LhQMki752cCEQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 29 Mar 2025 09:20:08 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 5/5] btrfs: prepare btrfs_punch_hole_lock_range() for large data folios
Date: Sat, 29 Mar 2025 19:49:40 +1030
Message-ID: <86cc5b6bd21e489ea6838b01bb0948c0a19b2cb5.1743239672.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1743239672.git.wqu@suse.com>
References: <cover.1743239672.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D0B5121210
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

The function btrfs_punch_hole_lock_range() needs to make sure there is
no other folio in the range, thus it goes with filemap_range_has_page(),
which works pretty fine.

But if we have large folios, under the following case
filemap_range_has_page() will always return true, forcing
btrfs_punch_hole_lock_range() to do a very time consuming busy loop:

        start                            end
        |                                |
  |//|//|//|//|  |  |  |  |  |  |  |  |//|//|
   \         /                         \   /
    Folio A                            Folio B

In above case, folio A and B contain our start/end indexes, and there
are no other folios in the range.
Thus we do not need to retry inside btrfs_punch_hole_lock_range().

To prepare for large data folios, introduce a helper,
check_range_has_page(), which will:

- Shrink the search range towards page boundaries
  If the rounded down end (exclusive, otherwise it can underflow when @end
  is inside the folio at file offset 0) is no larger than the rounded up
  start, it means the range contains no other pages other than the ones
  covering @start and @end.

  Can return false directly in that case.

- Grab all the folios inside the range

- Skip any large folios that cover the start and end indexes

- If any other folios are found return true

- Otherwise return false

This new helper is going to handle both large folios and regular ones.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 69 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index a7afc55bab2a..bd0bb7aea99d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2159,11 +2159,29 @@ static int find_first_non_hole(struct btrfs_inode *inode, u64 *start, u64 *len)
 	return ret;
 }
 
-static void btrfs_punch_hole_lock_range(struct inode *inode,
-					const u64 lockstart,
-					const u64 lockend,
-					struct extent_state **cached_state)
+/*
+ * The helper to check if there is no folio in the range.
+ *
+ * We can not utilized filemap_range_has_page() in a filemap with large folios
+ * as we can hit the following false positive:
+ *
+ *        start                            end
+ *        |                                |
+ *  |//|//|//|//|  |  |  |  |  |  |  |  |//|//|
+ *   \         /                         \   /
+ *    Folio A                            Folio B
+ *
+ * That large folio A and B cover the start and end indexes.
+ * In that case filemap_range_has_page() will always return true, but the above
+ * case is fine for btrfs_punch_hole_lock_range() usage.
+ *
+ * So here we only ensure that no other folios is in the range, excluding the
+ * head/tail large folio.
+ */
+static bool check_range_has_page(struct inode *inode, u64 start, u64 end)
 {
+	struct folio_batch fbatch;
+	bool ret = false;
 	/*
 	 * For subpage case, if the range is not at page boundary, we could
 	 * have pages at the leading/tailing part of the range.
@@ -2174,17 +2192,47 @@ static void btrfs_punch_hole_lock_range(struct inode *inode,
 	 *
 	 * And do not decrease page_lockend right now, as it can be 0.
 	 */
-	const u64 page_lockstart = round_up(lockstart, PAGE_SIZE);
-	const u64 page_lockend = round_down(lockend + 1, PAGE_SIZE);
+	const u64 page_lockstart = round_up(start, PAGE_SIZE);
+	const u64 page_lockend = round_down(end+ 1, PAGE_SIZE);
+	const pgoff_t start_index = page_lockstart >> PAGE_SHIFT;
+	const pgoff_t end_index = (page_lockend - 1) >> PAGE_SHIFT;
+	pgoff_t tmp = start_index;
+	int found_folios;
 
+	/* The same page or adjacent pages. */
+	if (page_lockend <= page_lockstart)
+		return false;
+
+	folio_batch_init(&fbatch);
+	found_folios = filemap_get_folios(inode->i_mapping, &tmp, end_index,
+					  &fbatch);
+	for (int i = 0; i < found_folios; i++) {
+		struct folio *folio = fbatch.folios[i];
+
+		/* A large folio begins before the start. Not a target. */
+		if (folio->index < start_index)
+			continue;
+		/* A large folio extends beyond the end. Not a target. */
+		if (folio->index + folio_nr_pages(folio) > end_index)
+			continue;
+		/* A folio doesn't cover the head/tail index. Found a target. */
+		ret = true;
+		break;
+	}
+	folio_batch_release(&fbatch);
+	return ret;
+}
+
+static void btrfs_punch_hole_lock_range(struct inode *inode,
+					const u64 lockstart,
+					const u64 lockend,
+					struct extent_state **cached_state)
+{
 	while (1) {
 		truncate_pagecache_range(inode, lockstart, lockend);
 
 		lock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
 			    cached_state);
-		/* The same page or adjacent pages. */
-		if (page_lockend <= page_lockstart)
-			break;
 		/*
 		 * We can't have ordered extents in the range, nor dirty/writeback
 		 * pages, because we have locked the inode's VFS lock in exclusive
@@ -2195,8 +2243,7 @@ static void btrfs_punch_hole_lock_range(struct inode *inode,
 		 * locking the range check if we have pages in the range, and if
 		 * we do, unlock the range and retry.
 		 */
-		if (!filemap_range_has_page(inode->i_mapping, page_lockstart,
-					    page_lockend - 1))
+		if (!check_range_has_page(inode, lockstart, lockend))
 			break;
 
 		unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
-- 
2.49.0


