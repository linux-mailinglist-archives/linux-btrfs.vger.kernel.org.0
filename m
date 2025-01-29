Return-Path: <linux-btrfs+bounces-11127-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44253A2183E
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 08:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 778C8188624B
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jan 2025 07:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522A519ADA2;
	Wed, 29 Jan 2025 07:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NkUi3+Z9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="NkUi3+Z9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D66198A19
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738136276; cv=none; b=s91aa7klTXSuNUU4T/2e78w405OfjrLp3fs2UWyAEcjmkoigJTKAzNOrfDJuumx8PC9oHL0Oio5SD3+BBptTcERyw31XASl1rZ9srZvuE66mjXwy5SMfuGZlHBut1L5Xd/S4EC9c1yxuZF5PMH/PiWHmvnPtTXqDUHpaofVVkLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738136276; c=relaxed/simple;
	bh=tde1NIlgQmjrN4/SOtJ2cNPmNWKtmmxvzIjPFumcdhY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gLiaOA9ReZVSRVAk0Nx4tRVwLc6Q8Vb3Lw82p6NxFn8l/xF5u1ghGtXu/PrHmeMm84eNDuTuKe4XM1SXwmmE9NxKck4uUlecopEmQDegF3cqNX9Gux9PO/G+9z9raa6DKeTkXVuG+Qv29ht6p6IHCFZT9F3dcjihJZyEeIWWBx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NkUi3+Z9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=NkUi3+Z9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8F6611F383
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738136272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VA93YXLcLnFnUC86DDdnTat/dLnu2KU6cdlG0SDewv0=;
	b=NkUi3+Z92V3SSrhHIWNYevJXGXaE7fIIYTvyfD19IKXtZZrgnzlJ/FlTm0kK6LZRPYVRB+
	Dyocb13VFDPL3e9rea6Aocv5/b0KnLzc1mLV30qCRN0UNdGcEd2d/lb0S8xTqVaWexOsSP
	fIhG0xwfUYOr4p09AlZKmqc1iWSGrbc=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=NkUi3+Z9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1738136272; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VA93YXLcLnFnUC86DDdnTat/dLnu2KU6cdlG0SDewv0=;
	b=NkUi3+Z92V3SSrhHIWNYevJXGXaE7fIIYTvyfD19IKXtZZrgnzlJ/FlTm0kK6LZRPYVRB+
	Dyocb13VFDPL3e9rea6Aocv5/b0KnLzc1mLV30qCRN0UNdGcEd2d/lb0S8xTqVaWexOsSP
	fIhG0xwfUYOr4p09AlZKmqc1iWSGrbc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA9E4137DB
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OGuFHc/amWdBKgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 29 Jan 2025 07:37:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/8] btrfs: extract metadata subpage detection into a dedicated helper
Date: Wed, 29 Jan 2025 18:07:17 +1030
Message-ID: <0d47f835257592281ba7819b78c8ab9f51d3177c.1738127135.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738127135.git.wqu@suse.com>
References: <cover.1738127135.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8F6611F383
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:mid,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Currently we have only one btrfs_is_subpage() to cover both data and
metadata.

But there is a special case for metadata:

- dummy extent buffer, sector size < PAGE_SIZE and node size >= PAGE_SIZE

In such case, btrfs_is_subpage() will return true for extent buffer
folio.

But that is not correct, and that's exactly why we have some open-coded
checks for functions like set_extent_buffer_uptodate() and
clear_extent_buffer_uptodate().

Just extract the metadata specific checks into a helper, and replace
those call sites.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 28 ++++++++++++++--------------
 fs/btrfs/subpage.c   |  4 ++--
 fs/btrfs/subpage.h   | 19 ++++++++++++++++++-
 3 files changed, 34 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1c50d6db454c..6b9fe7ea3ffb 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -837,7 +837,7 @@ static int attach_extent_buffer_folio(struct extent_buffer *eb,
 	if (folio->mapping)
 		lockdep_assert_held(&folio->mapping->i_private_lock);
 
-	if (fs_info->nodesize >= PAGE_SIZE) {
+	if (!btrfs_meta_is_subpage(fs_info)) {
 		if (!folio_test_private(folio))
 			folio_attach_private(folio, eb);
 		else
@@ -1785,7 +1785,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 	wbc_init_bio(wbc, &bbio->bio);
 	bbio->inode = BTRFS_I(eb->fs_info->btree_inode);
 	bbio->file_offset = eb->start;
-	if (fs_info->nodesize < PAGE_SIZE) {
+	if (btrfs_meta_is_subpage(fs_info)) {
 		struct folio *folio = eb->folios[0];
 		bool ret;
 
@@ -1927,7 +1927,7 @@ static int submit_eb_page(struct folio *folio, struct btrfs_eb_write_context *ct
 	if (!folio_test_private(folio))
 		return 0;
 
-	if (folio_to_fs_info(folio)->nodesize < PAGE_SIZE)
+	if (btrfs_meta_is_subpage(folio_to_fs_info(folio)))
 		return submit_eb_subpage(folio, wbc);
 
 	spin_lock(&mapping->i_private_lock);
@@ -2578,7 +2578,7 @@ static void detach_extent_buffer_folio(const struct extent_buffer *eb, struct fo
 		return;
 	}
 
-	if (fs_info->nodesize >= PAGE_SIZE) {
+	if (!btrfs_meta_is_subpage(fs_info)) {
 		/*
 		 * We do this since we'll remove the pages after we've
 		 * removed the eb from the radix tree, so we could race
@@ -2882,7 +2882,7 @@ static struct extent_buffer *grab_extent_buffer(struct btrfs_fs_info *fs_info,
 	 * don't try to insert two ebs for the same bytenr.  So here we always
 	 * return NULL and just continue.
 	 */
-	if (fs_info->nodesize < PAGE_SIZE)
+	if (btrfs_meta_is_subpage(fs_info))
 		return NULL;
 
 	/* Page not yet attached to an extent buffer */
@@ -2985,7 +2985,7 @@ static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
 
 finish:
 	spin_lock(&mapping->i_private_lock);
-	if (existing_folio && fs_info->nodesize < PAGE_SIZE) {
+	if (existing_folio && btrfs_meta_is_subpage(fs_info)) {
 		/* We're going to reuse the existing page, can drop our folio now. */
 		__free_page(folio_page(eb->folios[i], 0));
 		eb->folios[i] = existing_folio;
@@ -3076,7 +3076,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	 * The memory will be freed by attach_extent_buffer_page() or freed
 	 * manually if we exit earlier.
 	 */
-	if (fs_info->nodesize < PAGE_SIZE) {
+	if (btrfs_meta_is_subpage(fs_info)) {
 		prealloc = btrfs_alloc_subpage(fs_info, BTRFS_SUBPAGE_METADATA);
 		if (IS_ERR(prealloc)) {
 			ret = PTR_ERR(prealloc);
@@ -3377,7 +3377,7 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 	percpu_counter_add_batch(&fs_info->dirty_metadata_bytes, -eb->len,
 				 fs_info->dirty_metadata_batch);
 
-	if (eb->fs_info->nodesize < PAGE_SIZE)
+	if (btrfs_meta_is_subpage(fs_info))
 		return clear_subpage_extent_buffer_dirty(eb);
 
 	num_folios = num_extent_folios(eb);
@@ -3408,7 +3408,7 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
 	WARN_ON(test_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &eb->bflags));
 
 	if (!was_dirty) {
-		bool subpage = eb->fs_info->nodesize < PAGE_SIZE;
+		bool subpage = btrfs_meta_is_subpage(eb->fs_info);
 
 		/*
 		 * For subpage case, we can have other extent buffers in the
@@ -3454,7 +3454,7 @@ void clear_extent_buffer_uptodate(struct extent_buffer *eb)
 		 * This is special handling for metadata subpage, as regular
 		 * btrfs_is_subpage() can not handle cloned/dummy metadata.
 		 */
-		if (fs_info->nodesize >= PAGE_SIZE)
+		if (!btrfs_meta_is_subpage(fs_info))
 			folio_clear_uptodate(folio);
 		else
 			btrfs_subpage_clear_uptodate(fs_info, folio,
@@ -3475,7 +3475,7 @@ void set_extent_buffer_uptodate(struct extent_buffer *eb)
 		 * This is special handling for metadata subpage, as regular
 		 * btrfs_is_subpage() can not handle cloned/dummy metadata.
 		 */
-		if (fs_info->nodesize >= PAGE_SIZE)
+		if (!btrfs_meta_is_subpage(fs_info))
 			folio_mark_uptodate(folio);
 		else
 			btrfs_subpage_set_uptodate(fs_info, folio,
@@ -3565,7 +3565,7 @@ int read_extent_buffer_pages_nowait(struct extent_buffer *eb, int mirror_num,
 	bbio->inode = BTRFS_I(eb->fs_info->btree_inode);
 	bbio->file_offset = eb->start;
 	memcpy(&bbio->parent_check, check, sizeof(*check));
-	if (eb->fs_info->nodesize < PAGE_SIZE) {
+	if (btrfs_meta_is_subpage(eb->fs_info)) {
 		ret = bio_add_folio(&bbio->bio, eb->folios[0], eb->len,
 				    eb->start - folio_pos(eb->folios[0]));
 		ASSERT(ret);
@@ -3766,7 +3766,7 @@ static void assert_eb_folio_uptodate(const struct extent_buffer *eb, int i)
 	if (test_bit(EXTENT_BUFFER_WRITE_ERR, &eb->bflags))
 		return;
 
-	if (fs_info->nodesize < PAGE_SIZE) {
+	if (btrfs_meta_is_subpage(fs_info)) {
 		folio = eb->folios[0];
 		ASSERT(i == 0);
 		if (WARN_ON(!btrfs_subpage_test_uptodate(fs_info, folio,
@@ -4252,7 +4252,7 @@ int try_release_extent_buffer(struct folio *folio)
 {
 	struct extent_buffer *eb;
 
-	if (folio_to_fs_info(folio)->nodesize < PAGE_SIZE)
+	if (btrfs_meta_is_subpage(folio_to_fs_info(folio)))
 		return try_release_subpage_extent_buffer(folio);
 
 	/*
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 42a3410b2539..5638715c3ee6 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -169,7 +169,7 @@ void btrfs_folio_inc_eb_refs(const struct btrfs_fs_info *fs_info, struct folio *
 {
 	struct btrfs_subpage *subpage;
 
-	if (!btrfs_is_subpage(fs_info, folio->mapping))
+	if (!btrfs_meta_is_subpage(fs_info))
 		return;
 
 	ASSERT(folio_test_private(folio) && folio->mapping);
@@ -183,7 +183,7 @@ void btrfs_folio_dec_eb_refs(const struct btrfs_fs_info *fs_info, struct folio *
 {
 	struct btrfs_subpage *subpage;
 
-	if (!btrfs_is_subpage(fs_info, folio->mapping))
+	if (!btrfs_meta_is_subpage(fs_info))
 		return;
 
 	ASSERT(folio_test_private(folio) && folio->mapping);
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 44fff1f4eac4..8093baf69636 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -6,10 +6,10 @@
 #include <linux/spinlock.h>
 #include <linux/atomic.h>
 #include <linux/sizes.h>
+#include "fs.h"
 
 struct address_space;
 struct folio;
-struct btrfs_fs_info;
 
 /*
  * Extra info for subpapge bitmap.
@@ -70,8 +70,25 @@ enum btrfs_subpage_type {
 };
 
 #if PAGE_SIZE > SZ_4K
+/*
+ * For metadata it's more complex, as we can have dummy extent buffers, where
+ * folios have no mapping to determine the owning inode.
+ *
+ * Thankfully we only need to check if node size is smaller than page size.
+ * Even with larger folio support, we will only allocate a folio as large as
+ * node size.
+ * Thus if nodesize < PAGE_SIZE, we know metadata needs need to subpage routine.
+ */
+static inline bool btrfs_meta_is_subpage(const struct btrfs_fs_info *fs_info)
+{
+	return fs_info->nodesize < PAGE_SIZE;
+}
 bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info, struct address_space *mapping);
 #else
+static inline bool btrfs_meta_is_subpage(const struct btrfs_fs_info *fs_info)
+{
+	return false;
+}
 static inline bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info,
 				    struct address_space *mapping)
 {
-- 
2.48.1


