Return-Path: <linux-btrfs+bounces-11339-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD6BA2BA39
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2025 05:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 547501889691
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Feb 2025 04:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105C8233156;
	Fri,  7 Feb 2025 04:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OHHaIvfK";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="OHHaIvfK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32961233148
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Feb 2025 04:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738902397; cv=none; b=tzPgVgkxPCrU1kzXPOECyYnqmjIVgvBbw5XSWwEEpotFqrNOh8z/+n3DKE8Z9rLOrB1XVxn7S5Q4mFrGBV+o8lSIxqkY1GANMY30z0uu6ojw1Iz0fktz4AZmBWLsA4vBsl5kHvMGpPMVNYKUIRXOxja9RqQ9tIbURw4AxEZN/8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738902397; c=relaxed/simple;
	bh=/44N0L6l95gX7G73KoIJjBk6uj45p4KIvcT/ODKsFsU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYVgf4mTx1R74JB6qh9hIFFwnnrgk/TVVDnlDAM9EVEYmbbnsZfoxh6WBRU4AV4xx9bDlXVjU8kcEWx2bUjGUl3+843exZtRv+Sip+G5LRPXS0kHub1QgM8PUVpzSfxWo9I8MCteMqsisy1LuebeIg7KgeR6GS98au2r0DzHSqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OHHaIvfK; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=OHHaIvfK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 77C6C210F4
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Feb 2025 04:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738902393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SEYQLQ3j/r3RIrxbQy5h8TaPa5m97CBn/xhdSGeYwlM=;
	b=OHHaIvfKJk619X+C4YzLSI4QnKCtKRj9mBSuF+c8h219xY3D1koOP5JsEnSKKrszK3EeTY
	np/9yD7n1qD63D+6totJjvybhGvAciCRrdymGa2CHIqkEqPIGnKGmlAiElIOYSNB340o7B
	h/nHIt6hB4qi4/nQRKUELsLiR7IidAw=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=OHHaIvfK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738902393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SEYQLQ3j/r3RIrxbQy5h8TaPa5m97CBn/xhdSGeYwlM=;
	b=OHHaIvfKJk619X+C4YzLSI4QnKCtKRj9mBSuF+c8h219xY3D1koOP5JsEnSKKrszK3EeTY
	np/9yD7n1qD63D+6totJjvybhGvAciCRrdymGa2CHIqkEqPIGnKGmlAiElIOYSNB340o7B
	h/nHIt6hB4qi4/nQRKUELsLiR7IidAw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A19F713806
	for <linux-btrfs@vger.kernel.org>; Fri,  7 Feb 2025 04:26:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eKp6F3iLpWezCgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Fri, 07 Feb 2025 04:26:32 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH v2 5/8] btrfs: simplify btrfs_clear_buffer_dirty()
Date: Fri,  7 Feb 2025 14:56:04 +1030
Message-ID: <9e9b6d235df230f8aba1523e06c54611b093a872.1738902149.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738902149.git.wqu@suse.com>
References: <cover.1738902149.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 77C6C210F4
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[suse.com:email,suse.com:dkim,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_ONE(0.00)[1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

The function btrfs_clear_buffer_dirty() is called on dirty extent buffer
that will not be written back.

The function will call btree_clear_folio_dirty() to clear the folio
dirty flag and also clear PAGECACHE_TAG_DIRTY flag.

And we split the subpage and regular handlings, as for subpage cases we
should only clear PAGECACHE_TAG_DIRTY if the last dirty extent buffer in
the page is cleared.

So here we can simplify the function by:

- Use the newly introduced btrfs_meta_folio_clear_and_test_dirty() helper
  The helper will return true if we cleared the folio dirty flag.
  With that we can use the same helper for both subpage and regular
  cases.

- Rename btree_clear_folio_dirty() to btree_clear_folio_dirty_tag()
  As we move the folio dirty clearing in the btrfs_clear_buffer_dirty().

- Call btrfs_meta_folio_clear_and_test_dirty() to clear the dirty flags
  for both regular and subpage metadata cases

- Only call btree_clear_folio_dirty_tag() when the folio is no longer
  dirty

- Update the comment inside set_extent_buffer_dirty()
  As there is no separate clear_subpage_extent_buffer_dirty() anymore.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 36 ++++++++++--------------------------
 fs/btrfs/subpage.c   | 23 +++++++++++++++++++++++
 fs/btrfs/subpage.h   |  2 ++
 3 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index dbf4fb1fc2d1..354dd2522531 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3337,11 +3337,10 @@ void free_extent_buffer_stale(struct extent_buffer *eb)
 	release_extent_buffer(eb);
 }
 
-static void btree_clear_folio_dirty(struct folio *folio)
+static void btree_clear_folio_dirty_tag(struct folio *folio)
 {
-	ASSERT(folio_test_dirty(folio));
+	ASSERT(!folio_test_dirty(folio));
 	ASSERT(folio_test_locked(folio));
-	folio_clear_dirty_for_io(folio);
 	xa_lock_irq(&folio->mapping->i_pages);
 	if (!folio_test_dirty(folio))
 		__xa_clear_mark(&folio->mapping->i_pages,
@@ -3349,26 +3348,11 @@ static void btree_clear_folio_dirty(struct folio *folio)
 	xa_unlock_irq(&folio->mapping->i_pages);
 }
 
-static void clear_subpage_extent_buffer_dirty(const struct extent_buffer *eb)
-{
-	struct btrfs_fs_info *fs_info = eb->fs_info;
-	struct folio *folio = eb->folios[0];
-	bool last;
-
-	/* btree_clear_folio_dirty() needs page locked. */
-	folio_lock(folio);
-	last = btrfs_subpage_clear_and_test_dirty(fs_info, folio, eb->start, eb->len);
-	if (last)
-		btree_clear_folio_dirty(folio);
-	folio_unlock(folio);
-	WARN_ON(atomic_read(&eb->refs) == 0);
-}
-
 void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 			      struct extent_buffer *eb)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
-	int num_folios;
+	const int num_folios = num_extent_folios(eb);
 
 	btrfs_assert_tree_write_locked(eb);
 
@@ -3395,17 +3379,17 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 	percpu_counter_add_batch(&fs_info->dirty_metadata_bytes, -eb->len,
 				 fs_info->dirty_metadata_batch);
 
-	if (btrfs_meta_is_subpage(fs_info))
-		return clear_subpage_extent_buffer_dirty(eb);
-
-	num_folios = num_extent_folios(eb);
 	for (int i = 0; i < num_folios; i++) {
 		struct folio *folio = eb->folios[i];
+		bool last;
 
 		if (!folio_test_dirty(folio))
 			continue;
 		folio_lock(folio);
-		btree_clear_folio_dirty(folio);
+		last = btrfs_meta_folio_clear_and_test_dirty(fs_info, folio,
+							     eb->start, eb->len);
+		if (last)
+			btree_clear_folio_dirty_tag(folio);
 		folio_unlock(folio);
 	}
 	WARN_ON(atomic_read(&eb->refs) == 0);
@@ -3430,12 +3414,12 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
 
 		/*
 		 * For subpage case, we can have other extent buffers in the
-		 * same page, and in clear_subpage_extent_buffer_dirty() we
+		 * same page, and in clear_extent_buffer_dirty() we
 		 * have to clear page dirty without subpage lock held.
 		 * This can cause race where our page gets dirty cleared after
 		 * we just set it.
 		 *
-		 * Thankfully, clear_subpage_extent_buffer_dirty() has locked
+		 * Thankfully, clear_extent_buffer_dirty() has locked
 		 * its page for other reasons, we can use page lock to prevent
 		 * the above race.
 		 */
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 07c87da400ec..f74941a64d50 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -782,6 +782,29 @@ void btrfs_folio_set_lock(const struct btrfs_fs_info *fs_info,
 	spin_unlock_irqrestore(&subpage->lock, flags);
 }
 
+/*
+ * Clear the dirty flag for the folio.
+ *
+ * If the resulted folio is no longer dirty, return true. Otherwise return false.
+ */
+bool btrfs_meta_folio_clear_and_test_dirty(const struct btrfs_fs_info *fs_info,
+					   struct folio *folio, u64 start, u32 len)
+{
+	bool last;
+
+	if (!btrfs_meta_is_subpage(fs_info)) {
+		folio_clear_dirty_for_io(folio);
+		return true;
+	}
+
+	last = btrfs_subpage_clear_and_test_dirty(fs_info, folio, start, len);
+	if (last) {
+		folio_clear_dirty_for_io(folio);
+		return true;
+	}
+	return false;
+}
+
 void __cold btrfs_subpage_dump_bitmap(const struct btrfs_fs_info *fs_info,
 				      struct folio *folio, u64 start, u32 len)
 {
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 0c68c45d3f62..44f884dcc264 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -186,6 +186,8 @@ bool btrfs_subpage_clear_and_test_dirty(const struct btrfs_fs_info *fs_info,
 
 void btrfs_folio_assert_not_dirty(const struct btrfs_fs_info *fs_info,
 				  struct folio *folio, u64 start, u32 len);
+bool btrfs_meta_folio_clear_and_test_dirty(const struct btrfs_fs_info *fs_info,
+					   struct folio *folio, u64 start, u32 len);
 void btrfs_get_subpage_dirty_bitmap(struct btrfs_fs_info *fs_info,
 				    struct folio *folio,
 				    unsigned long *ret_bitmap);
-- 
2.48.1


