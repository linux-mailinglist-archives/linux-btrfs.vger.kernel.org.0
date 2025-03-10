Return-Path: <linux-btrfs+bounces-12126-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AFAA58D00
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 08:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E4D3AA154
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 07:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBE3221541;
	Mon, 10 Mar 2025 07:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MnoMJHMP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MnoMJHMP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58382206B7
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 07:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741592191; cv=none; b=idL3uSmnOrkvNReNj2Mn5u5yzGJzXuRRQtckqmm7oC730uCaycY2I2zNdZsWY5kWQlLbw98O5dNgvV/hmUFkxSPBzdBwMmSv5vU2IPjrlhFhV+eoIo4DrOzKtU52fYsaLrHppAl3f8adOPyv4RtpSyIjJyzTklQ3AjYQCpGwgFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741592191; c=relaxed/simple;
	bh=H1g3tNOY8eplRnzBmfd+w0u7EHi488ZOUTe2sfHaook=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDeXnaU1Gr/B5lqF9FoFQmy1xx9ZHMpGW+IFj8VHsxgxMq2kAlXA7faYfQLExYzpdsb9orovqXuBegbbYjdEpMI/u0nz+4K30jICiHSQEBBaEseCmTthHtdxqNlBz2ypJQAfrn0BX6y89FqHifn5KKcXTwe6gPuEvA9ONyqFFOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MnoMJHMP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MnoMJHMP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 89A281F445
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 07:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741592182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZrIRJet+Bllj3F7DbtbsTKCKsO/g5DHNoq0ovgLXZgU=;
	b=MnoMJHMPp8dwYCwOgsfg0hABxTU1VXc1LH0+n4yk8iWcB0LzWlPZ5gPXTm/7/rfS2ihGXh
	iWcBsGeuGqHo6pR6CalT+ln/tXeGmf8zTvu0YXL+kS93cXFGClQvOKrhgT5cDhOvALT8Lr
	B3T4vnvBgj6q91DLwddFYus+yYGGLyM=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=MnoMJHMP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741592182; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZrIRJet+Bllj3F7DbtbsTKCKsO/g5DHNoq0ovgLXZgU=;
	b=MnoMJHMPp8dwYCwOgsfg0hABxTU1VXc1LH0+n4yk8iWcB0LzWlPZ5gPXTm/7/rfS2ihGXh
	iWcBsGeuGqHo6pR6CalT+ln/tXeGmf8zTvu0YXL+kS93cXFGClQvOKrhgT5cDhOvALT8Lr
	B3T4vnvBgj6q91DLwddFYus+yYGGLyM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDEB413A70
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 07:36:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KMQ6H3WWzmfpMAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 07:36:21 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 1/6] btrfs: subpage: make btrfs_is_subpage() check against a folio
Date: Mon, 10 Mar 2025 18:05:57 +1030
Message-ID: <574505287e817a69b060ce056fbfdaf8cf81b7c5.1741591823.git.wqu@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741591823.git.wqu@suse.com>
References: <cover.1741591823.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 89A281F445
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

To support larger data folios, we can no longer assume every filemap
folio is page sized.

So btrfs_is_subpage() check must be done against a folio.

Thankfully for metadata folios, we have the full control and ensure a
larger folio will not be larger than nodesize, so
btrfs_meta_is_subpage() doesn't need this change.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 14 +++++++-------
 fs/btrfs/inode.c     |  2 +-
 fs/btrfs/subpage.c   | 24 ++++++++++++------------
 fs/btrfs/subpage.h   | 12 ++++++------
 4 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index a78ff093ea37..d2a7472f28b6 100644
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
@@ -1331,7 +1331,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 {
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(&inode->vfs_inode);
 	struct writeback_control *wbc = bio_ctrl->wbc;
-	const bool is_subpage = btrfs_is_subpage(fs_info, folio->mapping);
+	const bool is_subpage = btrfs_is_subpage(fs_info, folio);
 	const u64 page_start = folio_pos(folio);
 	const u64 page_end = page_start + folio_size(folio) - 1;
 	const unsigned int blocks_per_folio = btrfs_blocks_per_folio(fs_info, folio);
@@ -1359,7 +1359,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 	int bit;
 
 	/* Save the dirty bitmap as our submission bitmap will be a subset of it. */
-	if (btrfs_is_subpage(fs_info, inode->vfs_inode.i_mapping)) {
+	if (btrfs_is_subpage(fs_info, folio)) {
 		ASSERT(blocks_per_folio > 1);
 		btrfs_get_subpage_dirty_bitmap(fs_info, folio, &bio_ctrl->submit_bitmap);
 	} else {
@@ -2411,7 +2411,7 @@ static int extent_write_cache_pages(struct address_space *mapping,
 			 * regular submission.
 			 */
 			if (wbc->sync_mode != WB_SYNC_NONE ||
-			    btrfs_is_subpage(inode_to_fs_info(inode), mapping)) {
+			    btrfs_is_subpage(inode_to_fs_info(inode), folio)) {
 				if (folio_test_writeback(folio))
 					submit_write_bio(bio_ctrl, 0);
 				folio_wait_writeback(folio);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e7e6accbaf6c..1af72f77f820 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7283,7 +7283,7 @@ static void wait_subpage_spinlock(struct folio *folio)
 	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
 	struct btrfs_subpage *subpage;
 
-	if (!btrfs_is_subpage(fs_info, folio->mapping))
+	if (!btrfs_is_subpage(fs_info, folio))
 		return;
 
 	ASSERT(folio_test_private(folio) && folio_get_private(folio));
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index d7e70525f4fb..1392b4eaa1f9 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -83,7 +83,7 @@ int btrfs_attach_subpage(const struct btrfs_fs_info *fs_info,
 		return 0;
 	if (type == BTRFS_SUBPAGE_METADATA && !btrfs_meta_is_subpage(fs_info))
 		return 0;
-	if (type == BTRFS_SUBPAGE_DATA && !btrfs_is_subpage(fs_info, folio->mapping))
+	if (type == BTRFS_SUBPAGE_DATA && !btrfs_is_subpage(fs_info, folio))
 		return 0;
 
 	subpage = btrfs_alloc_subpage(fs_info, type);
@@ -104,7 +104,7 @@ void btrfs_detach_subpage(const struct btrfs_fs_info *fs_info, struct folio *fol
 		return;
 	if (type == BTRFS_SUBPAGE_METADATA && !btrfs_meta_is_subpage(fs_info))
 		return;
-	if (type == BTRFS_SUBPAGE_DATA && !btrfs_is_subpage(fs_info, folio->mapping))
+	if (type == BTRFS_SUBPAGE_DATA && !btrfs_is_subpage(fs_info, folio))
 		return;
 
 	subpage = folio_detach_private(folio);
@@ -286,7 +286,7 @@ void btrfs_folio_end_lock(const struct btrfs_fs_info *fs_info,
 
 	ASSERT(folio_test_locked(folio));
 
-	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, folio->mapping)) {
+	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, folio)) {
 		folio_unlock(folio);
 		return;
 	}
@@ -320,7 +320,7 @@ void btrfs_folio_end_lock_bitmap(const struct btrfs_fs_info *fs_info,
 	int cleared = 0;
 	int bit;
 
-	if (!btrfs_is_subpage(fs_info, folio->mapping)) {
+	if (!btrfs_is_subpage(fs_info, folio)) {
 		folio_unlock(folio);
 		return;
 	}
@@ -572,7 +572,7 @@ void btrfs_folio_set_##name(const struct btrfs_fs_info *fs_info,	\
 			    struct folio *folio, u64 start, u32 len)	\
 {									\
 	if (unlikely(!fs_info) ||					\
-	    !btrfs_is_subpage(fs_info, folio->mapping)) {		\
+	    !btrfs_is_subpage(fs_info, folio)) {			\
 		folio_set_func(folio);					\
 		return;							\
 	}								\
@@ -582,7 +582,7 @@ void btrfs_folio_clear_##name(const struct btrfs_fs_info *fs_info,	\
 			      struct folio *folio, u64 start, u32 len)	\
 {									\
 	if (unlikely(!fs_info) ||					\
-	    !btrfs_is_subpage(fs_info, folio->mapping)) {		\
+	    !btrfs_is_subpage(fs_info, folio)) {			\
 		folio_clear_func(folio);				\
 		return;							\
 	}								\
@@ -592,7 +592,7 @@ bool btrfs_folio_test_##name(const struct btrfs_fs_info *fs_info,	\
 			     struct folio *folio, u64 start, u32 len)	\
 {									\
 	if (unlikely(!fs_info) ||					\
-	    !btrfs_is_subpage(fs_info, folio->mapping))			\
+	    !btrfs_is_subpage(fs_info, folio))				\
 		return folio_test_func(folio);				\
 	return btrfs_subpage_test_##name(fs_info, folio, start, len);	\
 }									\
@@ -600,7 +600,7 @@ void btrfs_folio_clamp_set_##name(const struct btrfs_fs_info *fs_info,	\
 				  struct folio *folio, u64 start, u32 len) \
 {									\
 	if (unlikely(!fs_info) ||					\
-	    !btrfs_is_subpage(fs_info, folio->mapping)) {		\
+	    !btrfs_is_subpage(fs_info, folio)) {			\
 		folio_set_func(folio);					\
 		return;							\
 	}								\
@@ -611,7 +611,7 @@ void btrfs_folio_clamp_clear_##name(const struct btrfs_fs_info *fs_info, \
 				    struct folio *folio, u64 start, u32 len) \
 {									\
 	if (unlikely(!fs_info) ||					\
-	    !btrfs_is_subpage(fs_info, folio->mapping)) {		\
+	    !btrfs_is_subpage(fs_info, folio)) {			\
 		folio_clear_func(folio);				\
 		return;							\
 	}								\
@@ -622,7 +622,7 @@ bool btrfs_folio_clamp_test_##name(const struct btrfs_fs_info *fs_info,	\
 				   struct folio *folio, u64 start, u32 len) \
 {									\
 	if (unlikely(!fs_info) ||					\
-	    !btrfs_is_subpage(fs_info, folio->mapping))			\
+	    !btrfs_is_subpage(fs_info, folio))				\
 		return folio_test_func(folio);				\
 	btrfs_subpage_clamp_range(folio, &start, &len);			\
 	return btrfs_subpage_test_##name(fs_info, folio, start, len);	\
@@ -700,7 +700,7 @@ void btrfs_folio_assert_not_dirty(const struct btrfs_fs_info *fs_info,
 	if (!IS_ENABLED(CONFIG_BTRFS_ASSERT))
 		return;
 
-	if (!btrfs_is_subpage(fs_info, folio->mapping)) {
+	if (!btrfs_is_subpage(fs_info, folio)) {
 		ASSERT(!folio_test_dirty(folio));
 		return;
 	}
@@ -735,7 +735,7 @@ void btrfs_folio_set_lock(const struct btrfs_fs_info *fs_info,
 	int ret;
 
 	ASSERT(folio_test_locked(folio));
-	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, folio->mapping))
+	if (unlikely(!fs_info) || !btrfs_is_subpage(fs_info, folio))
 		return;
 
 	subpage = folio_get_private(folio);
diff --git a/fs/btrfs/subpage.h b/fs/btrfs/subpage.h
index 9d1ad6c7c6bd..baa23258e7fa 100644
--- a/fs/btrfs/subpage.h
+++ b/fs/btrfs/subpage.h
@@ -85,10 +85,10 @@ static inline bool btrfs_meta_is_subpage(const struct btrfs_fs_info *fs_info)
 	return fs_info->nodesize < PAGE_SIZE;
 }
 static inline bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info,
-				    struct address_space *mapping)
+				    struct folio *folio)
 {
-	if (mapping && mapping->host)
-		ASSERT(is_data_inode(BTRFS_I(mapping->host)));
+	if (folio->mapping && folio->mapping->host)
+		ASSERT(is_data_inode(BTRFS_I(folio->mapping->host)));
 	return fs_info->sectorsize < PAGE_SIZE;
 }
 #else
@@ -97,10 +97,10 @@ static inline bool btrfs_meta_is_subpage(const struct btrfs_fs_info *fs_info)
 	return false;
 }
 static inline bool btrfs_is_subpage(const struct btrfs_fs_info *fs_info,
-				    struct address_space *mapping)
+				    struct folio *folio)
 {
-	if (mapping && mapping->host)
-		ASSERT(is_data_inode(BTRFS_I(mapping->host)));
+	if (folio->mapping && folio->mapping->host)
+		ASSERT(is_data_inode(BTRFS_I(folio->mapping->host)));
 	return false;
 }
 #endif
-- 
2.48.1


