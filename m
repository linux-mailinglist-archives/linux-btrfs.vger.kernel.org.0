Return-Path: <linux-btrfs+bounces-11607-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6CAA3D493
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 10:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABC697A91B0
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 09:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2351EF091;
	Thu, 20 Feb 2025 09:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="r2jepcck";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="r2jepcck"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E17B1EDA1F
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 09:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043372; cv=none; b=g6hhVny8aR4u8XXgwSmHOCc3qKRBy8YBtznm2C985RSHSbNDI44Q6AUpoqYt5Vw7VPG+9G9EOvG02csCArEDMglqb8Nv2PhC7V5XgFCGN2e/mTYpkUeWr1IjZJ1/ka8tFDOJURcmvRVwAuvAcBTJskIfCDrmUYYNb7V7G0CECwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043372; c=relaxed/simple;
	bh=AypK8dIUAag4DLRVqRyzge6oLIoaFVW0pGxrTX/6GI4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtndGcFuJ36oy5ZvJVdNmOBynS6ZfqY7mK3qjJPyG0ji+01sidS82MIrJuQfqXXFDbOxjL/oTh3WF/CyEj9Ys8APwVhL2uH5iu/u5UVxqeo1HraRpUnq8F5Ft28KyOlRSgS06S47K/9W78BWSUyucXuYXiqzzUXq/HXadAVTUYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=r2jepcck; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=r2jepcck; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B00EA1F387
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 09:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740043367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uaBUSPIxDjyywgDkM1UdM4iIgex0DLMVOUwGrnaTv4Q=;
	b=r2jepcck1N52sHzWyKiMdoF1xqyh5BE69VZXEYYKdn8NwsCFDxkbBxS3SFh1WkqXYq7UwP
	3Y1Es5nwkwcCRtuRQh62G0eDlshbJfNMIepNZ9LUCwyi4HYePx7mzIbewjh7JT+BdQouAb
	4vT/aBzjDSDSZzgzLqoDMYbgfg5JdXk=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=r2jepcck
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740043367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uaBUSPIxDjyywgDkM1UdM4iIgex0DLMVOUwGrnaTv4Q=;
	b=r2jepcck1N52sHzWyKiMdoF1xqyh5BE69VZXEYYKdn8NwsCFDxkbBxS3SFh1WkqXYq7UwP
	3Y1Es5nwkwcCRtuRQh62G0eDlshbJfNMIepNZ9LUCwyi4HYePx7mzIbewjh7JT+BdQouAb
	4vT/aBzjDSDSZzgzLqoDMYbgfg5JdXk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A340913A85
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 09:22:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4N5BE2b0tmfBcgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 09:22:46 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/5] btrfs: prepare subpage.c for larger folios support
Date: Thu, 20 Feb 2025 19:52:22 +1030
Message-ID: <1399d0f444eb0dfcc391c430193ccd8649ff2c90.1740043233.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740043233.git.wqu@suse.com>
References: <cover.1740043233.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B00EA1F387
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

For the future of larger folio support, even if block size == page size,
we may still hit a larger folio and need to attach a subpage structure to
that larger folio.

In that case we can no longer assume we need to go subpage routine only
when block size < page size, but take folio size into the consideration.

Prepare for such future by:

- Use folio_size() instead of PAGE_SIZE
- Make btrfs_alloc_subpage() to handle different folio sizes
- Make btrfs_is_subpage() to do the check based on the folio

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 17 +++++++++--------
 fs/btrfs/inode.c     |  2 +-
 fs/btrfs/subpage.c   | 36 ++++++++++++++++++------------------
 fs/btrfs/subpage.h   | 24 +++++++++---------------
 4 files changed, 37 insertions(+), 42 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index c023ea514f64..e1efb6419601 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -432,7 +432,7 @@ static void end_folio_read(struct folio *folio, bool uptodate, u64 start, u32 le
 	else
 		btrfs_folio_clear_uptodate(fs_info, folio, start, len);
 
-	if (!btrfs_is_subpage(fs_info, folio->mapping))
+	if (!btrfs_is_subpage(fs_info, folio))
 		folio_unlock(folio);
 	else
 		btrfs_folio_end_lock(fs_info, folio, start, len);
@@ -488,7 +488,7 @@ static void end_bbio_data_write(struct btrfs_bio *bbio)
 static void begin_folio_read(struct btrfs_fs_info *fs_info, struct folio *folio)
 {
 	ASSERT(folio_test_locked(folio));
-	if (!btrfs_is_subpage(fs_info, folio->mapping))
+	if (!btrfs_is_subpage(fs_info, folio))
 		return;
 
 	ASSERT(folio_test_private(folio));
@@ -870,7 +870,7 @@ int set_folio_extent_mapped(struct folio *folio)
 
 	fs_info = folio_to_fs_info(folio);
 
-	if (btrfs_is_subpage(fs_info, folio->mapping))
+	if (btrfs_is_subpage(fs_info, folio))
 		return btrfs_attach_subpage(fs_info, folio, BTRFS_SUBPAGE_DATA);
 
 	folio_attach_private(folio, (void *)EXTENT_FOLIO_PRIVATE);
@@ -887,7 +887,7 @@ void clear_folio_extent_mapped(struct folio *folio)
 		return;
 
 	fs_info = folio_to_fs_info(folio);
-	if (btrfs_is_subpage(fs_info, folio->mapping))
+	if (btrfs_is_subpage(fs_info, folio))
 		return btrfs_detach_subpage(fs_info, folio, BTRFS_SUBPAGE_DATA);
 
 	folio_detach_private(folio);
@@ -1329,7 +1329,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 {
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(&inode->vfs_inode);
 	struct writeback_control *wbc = bio_ctrl->wbc;
-	const bool is_subpage = btrfs_is_subpage(fs_info, folio->mapping);
+	const bool is_subpage = btrfs_is_subpage(fs_info, folio);
 	const u64 page_start = folio_pos(folio);
 	const u64 page_end = page_start + folio_size(folio) - 1;
 	const unsigned int blocks_per_folio = btrfs_blocks_per_folio(fs_info, folio);
@@ -1357,7 +1357,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 	int bit;
 
 	/* Save the dirty bitmap as our submission bitmap will be a subset of it. */
-	if (btrfs_is_subpage(fs_info, inode->vfs_inode.i_mapping)) {
+	if (is_subpage) {
 		ASSERT(blocks_per_folio > 1);
 		btrfs_get_subpage_dirty_bitmap(fs_info, folio, &bio_ctrl->submit_bitmap);
 	} else {
@@ -2387,7 +2387,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
 			 * regular submission.
 			 */
 			if (wbc->sync_mode != WB_SYNC_NONE ||
-			    btrfs_is_subpage(inode_to_fs_info(inode), mapping)) {
+			    btrfs_is_subpage(inode_to_fs_info(inode), folio)) {
 				if (folio_test_writeback(folio))
 					submit_write_bio(bio_ctrl, 0);
 				folio_wait_writeback(folio);
@@ -3245,7 +3245,8 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	 * manually if we exit earlier.
 	 */
 	if (btrfs_meta_is_subpage(fs_info)) {
-		prealloc = btrfs_alloc_subpage(fs_info, BTRFS_SUBPAGE_METADATA);
+		prealloc = btrfs_alloc_subpage(fs_info, PAGE_SIZE,
+					       BTRFS_SUBPAGE_METADATA);
 		if (IS_ERR(prealloc)) {
 			ret = PTR_ERR(prealloc);
 			goto out;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 7796e81dbb9d..3af74f3c5d75 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7246,7 +7246,7 @@ static void wait_subpage_spinlock(struct folio *folio)
 	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
 	struct btrfs_subpage *subpage;
 
-	if (!btrfs_is_subpage(fs_info, folio->mapping))
+	if (!btrfs_is_subpage(fs_info, folio))
 		return;
 
 	ASSERT(folio_test_private(folio) && folio_get_private(folio));
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 4d7600e14286..afaa1f381a74 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -84,10 +84,10 @@ int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
 		return 0;
 	if (type == BTRFS_SUBPAGE_METADATA && !btrfs_meta_is_subpage(fs_info))
 		return 0;
-	if (type == BTRFS_SUBPAGE_DATA && !btrfs_is_subpage(fs_info, folio->mapping))
+	if (type == BTRFS_SUBPAGE_DATA && !btrfs_is_subpage(fs_info, folio))
 		return 0;
 
-	subpage = btrfs_alloc_subpage(fs_info, type);
+	subpage = btrfs_alloc_subpage(fs_info, folio_size(folio), type);
 	if (IS_ERR(subpage))
 		return  PTR_ERR(subpage);
 
@@ -105,7 +105,7 @@ void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info, struct folio *fol
 		return;
 	if (type == BTRFS_SUBPAGE_METADATA && !btrfs_meta_is_subpage(fs_info))
 		return;
-	if (type == BTRFS_SUBPAGE_DATA && !btrfs_is_subpage(fs_info, folio->mapping))
+	if (type == BTRFS_SUBPAGE_DATA && !btrfs_is_subpage(fs_info, folio))
 		return;
 
 	subpage = folio_detach_private(folio);
@@ -114,16 +114,16 @@ void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info, struct folio *fol
 }
 
 struct btrfs_subpage *btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
-					  enum btrfs_subpage_type type)
+					  size_t fsize, enum btrfs_subpage_type type)
 {
 	struct btrfs_subpage *ret;
 	unsigned int real_size;
 
-	ASSERT(fs_info->sectorsize < PAGE_SIZE);
+	ASSERT(fs_info->sectorsize < fsize);
 
 	real_size = struct_size(ret, bitmaps,
 			BITS_TO_LONGS(btrfs_bitmap_nr_max *
-				      (PAGE_SIZE >> fs_info->sectorsize_bits)));
+				      (fsize >> fs_info->sectorsize_bits)));
 	ret = kzalloc(real_size, GFP_NOFS);
 	if (!ret)
 		return ERR_PTR(-ENOMEM);
@@ -195,7 +195,7 @@ static void btrfs_subpage_assert(const struct btrfs_fs_info *fs_info,
 	 */
 	if (folio->mapping)
 		ASSERT(folio_pos(folio) <= start &&
-		       start + len <= folio_pos(folio) + PAGE_SIZE);
+		       start + len <= folio_pos(folio) + folio_size(folio));
 }
 
 #define subpage_calc_start_bit(fs_info, folio, name, start, len)	\
@@ -224,7 +224,7 @@ static void btrfs_subpage_clamp_range(struct folio *folio, u64 *start, u32 *len)
 	if (folio_pos(folio) >= orig_start + orig_len)
 		*len = 0;
 	else
-		*len = min_t(u64, folio_pos(folio) + PAGE_SIZE,
+		*len = min_t(u64, folio_pos(folio) + folio_size(folio),
 			     orig_start + orig_len) - *start;
 }
 
@@ -287,7 +287,7 @@ void btrfs_folio_end_lock(const struct btrfs_fs_info *fs_info,
 
 	ASSERT(folio_test_locked(folio));
 
-	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, folio->mapping)) {
+	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, folio)) {
 		folio_unlock(folio);
 		return;
 	}
@@ -321,7 +321,7 @@ void btrfs_folio_end_lock_bitmap(const struct btrfs_fs_info *fs_info,
 	int cleared = 0;
 	int bit;
 
-	if (!btrfs_is_subpage(fs_info, folio->mapping)) {
+	if (!btrfs_is_subpage(fs_info, folio)) {
 		folio_unlock(folio);
 		return;
 	}
@@ -573,7 +573,7 @@ void btrfs_folio_set_##name(const struct btrfs_fs_info *fs_info,	\
 			    struct folio *folio, u64 start, u32 len)	\
 {									\
 	if (unlikely(!fs_info) ||					\
-	    !btrfs_is_subpage(fs_info, folio->mapping)) {		\
+	    !btrfs_is_subpage(fs_info, folio)) {			\
 		folio_set_func(folio);					\
 		return;							\
 	}								\
@@ -583,7 +583,7 @@ void btrfs_folio_clear_##name(const struct btrfs_fs_info *fs_info,	\
 			      struct folio *folio, u64 start, u32 len)	\
 {									\
 	if (unlikely(!fs_info) ||					\
-	    !btrfs_is_subpage(fs_info, folio->mapping)) {		\
+	    !btrfs_is_subpage(fs_info, folio)) {			\
 		folio_clear_func(folio);				\
 		return;							\
 	}								\
@@ -593,7 +593,7 @@ bool btrfs_folio_test_##name(const struct btrfs_fs_info *fs_info,	\
 			     struct folio *folio, u64 start, u32 len)	\
 {									\
 	if (unlikely(!fs_info) ||					\
-	    !btrfs_is_subpage(fs_info, folio->mapping))			\
+	    !btrfs_is_subpage(fs_info, folio))				\
 		return folio_test_func(folio);				\
 	return btrfs_subpage_test_##name(fs_info, folio, start, len);	\
 }									\
@@ -601,7 +601,7 @@ void btrfs_folio_clamp_set_##name(const struct btrfs_fs_info *fs_info,	\
 				  struct folio *folio, u64 start, u32 len) \
 {									\
 	if (unlikely(!fs_info) ||					\
-	    !btrfs_is_subpage(fs_info, folio->mapping)) {		\
+	    !btrfs_is_subpage(fs_info, folio)) {			\
 		folio_set_func(folio);					\
 		return;							\
 	}								\
@@ -612,7 +612,7 @@ void btrfs_folio_clamp_clear_##name(const struct btrfs_fs_info *fs_info, \
 				    struct folio *folio, u64 start, u32 len) \
 {									\
 	if (unlikely(!fs_info) ||					\
-	    !btrfs_is_subpage(fs_info, folio->mapping)) {		\
+	    !btrfs_is_subpage(fs_info, folio)) {			\
 		folio_clear_func(folio);				\
 		return;							\
 	}								\
@@ -623,7 +623,7 @@ bool btrfs_folio_clamp_test_##name(const struct btrfs_fs_info *fs_info,	\
 				   struct folio *folio, u64 start, u32 len) \
 {									\
 	if (unlikely(!fs_info) ||					\
-	    !btrfs_is_subpage(fs_info, folio->mapping))			\
+	    !btrfs_is_subpage(fs_info, folio))				\
 		return folio_test_func(folio);				\
 	btrfs_subpage_clamp_range(folio, &start, &len);			\
 	return btrfs_subpage_test_##name(fs_info, folio, start, len);	\
@@ -704,7 +704,7 @@ void btrfs_folio_assert_not_dirty(const struct btrfs_fs_info *fs_info,
 	if (!IS_ENABLED(CONFIG_BTRFS_ASSERT))
 		return;
 
-	if (!btrfs_is_subpage(fs_info, folio->mapping)) {
+	if (!btrfs_is_subpage(fs_info, folio)) {
 		ASSERT(!folio_test_dirty(folio));
 		return;
 	}
@@ -739,7 +739,7 @@ void btrfs_folio_set_lock(const struct btrfs_fs_info *fs_info,
 	int ret;
 
 	ASSERT(folio_test_locked(folio));
-	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, folio->mapping))
+	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, folio))
 		return;
 
 	subpage = folio_get_private(folio);
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index e10a1d308f32..f8d1efa1a227 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -84,27 +84,21 @@ static inline bool btrfs_meta_is_subpage(const struct btrfs_fs_info *fs_info)
 {
 	return fs_info->nodesize < PAGE_SIZE;
 }
-static inline bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info,
-				    struct address_space *mapping)
-{
-	if (mapping && mapping->host)
-		ASSERT(is_data_inode(BTRFS_I(mapping->host)));
-	return fs_info->sectorsize < PAGE_SIZE;
-}
 #else
 static inline bool btrfs_meta_is_subpage(const struct btrfs_fs_info *fs_info)
 {
 	return false;
 }
-static inline bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info,
-				    struct address_space *mapping)
-{
-	if (mapping && mapping->host)
-		ASSERT(is_data_inode(BTRFS_I(mapping->host)));
-	return false;
-}
 #endif
 
+static inline bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info,
+				    struct folio *folio)
+{
+	if (folio_mapped(folio) && folio->mapping && folio->mapping->host)
+		ASSERT(is_data_inode(BTRFS_I(folio->mapping->host)));
+	return fs_info->sectorsize < folio_size(folio);
+}
+
 int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
 			 struct folio *folio, enum btrfs_subpage_type type);
 void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info, struct folio *folio,
@@ -112,7 +106,7 @@ void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info, struct folio *fol
 
 /* Allocate additional data where page represents more than one sector */
 struct btrfs_subpage *btrfs_alloc_subpage(const struct btrfs_fs_info *fs_info,
-					  enum btrfs_subpage_type type);
+					  size_t fsize, enum btrfs_subpage_type type);
 void btrfs_free_subpage(struct btrfs_subpage *subpage);
 
 void btrfs_folio_inc_eb_refs(const struct btrfs_fs_info *fs_info, struct folio *folio);
-- 
2.48.1


