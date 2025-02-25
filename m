Return-Path: <linux-btrfs+bounces-11784-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC04A44817
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 18:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 362DD1887E5C
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Feb 2025 17:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5450820764C;
	Tue, 25 Feb 2025 17:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EccgC+Eu";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EccgC+Eu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941041A2567
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Feb 2025 17:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504300; cv=none; b=SrDqTczzcDxRNpB57/0q8LRht5RniZUNRwnQI7nhU0V084BtF9dt34AZtleWXcK556ChMsx6+SuGU8eMwVhErJJv1YLVl6a3ISXMbtHboLlvEFlbh89kXvx8K9eOVmoCdDbsHszogXigTr4vjf8v6zAoLRGJ8y9/yuCic4oj2Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504300; c=relaxed/simple;
	bh=5qduEVX53W3gY/zjO+az6P8zji3RXBZf3Rffxu6DoVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nZlQsOIcgRTkCQyM1KDPaHMy9wXxGTk5rjmEG/0p3DHh81pvIyj8/LO7f9Pdb7scaS+zHZ2L5Ev0TuGKAKU3vcozvouVM+ald7HafMCbTGtTgdfwppx1pGNSHVaMMkjY1H2iHx3R5PSD1OpJOHMpjxPjqccqW+pYxhX48VzGbzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EccgC+Eu; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EccgC+Eu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 674482116F;
	Tue, 25 Feb 2025 17:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740504290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iQeLG9/vx+e5TAxjkyE2ZSNREryuhbIgnh5o/62Twvo=;
	b=EccgC+Eu9YqMJY6/9BmVekLvP+smGKtvIdaohFPLl+peOgMkiqw7xcQFpCVVK83iHssoL2
	b09ka89Oh6pvFxIbHIVjcLpjjAI7Lc2gnLu5xkI1xL6MiT5kLN4UfDmFpisxuliTZkbqlv
	N+cZk+/j7US6nqTmqQwQXh+BT6odSyM=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=EccgC+Eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740504290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iQeLG9/vx+e5TAxjkyE2ZSNREryuhbIgnh5o/62Twvo=;
	b=EccgC+Eu9YqMJY6/9BmVekLvP+smGKtvIdaohFPLl+peOgMkiqw7xcQFpCVVK83iHssoL2
	b09ka89Oh6pvFxIbHIVjcLpjjAI7Lc2gnLu5xkI1xL6MiT5kLN4UfDmFpisxuliTZkbqlv
	N+cZk+/j7US6nqTmqQwQXh+BT6odSyM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6050A13332;
	Tue, 25 Feb 2025 17:24:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ie6AF+L8vWcOTwAAD6G6ig
	(envelope-from <dsterba@suse.com>); Tue, 25 Feb 2025 17:24:50 +0000
From: David Sterba <dsterba@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH 2/2] btrfs: use num_extent_folios() in for loop bounds
Date: Tue, 25 Feb 2025 18:24:46 +0100
Message-ID: <51cf9a85e6a053090ce046012548d67f5e088a3d.1740503982.git.dsterba@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1740503982.git.dsterba@suse.com>
References: <cover.1740503982.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 674482116F
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

As the helper num_extent_folios() is now __pure, we can use it in for
loop without storing its value in a variable explicitly, the compiler
will do this for us.

The effects on btrfs.ko is -200 bytes and there are stack space savings
too:

btrfs_clone_extent_buffer                               -8 (32 -> 24)
btrfs_clear_buffer_dirty                                -8 (48 -> 40)
clear_extent_buffer_uptodate                            -8 (40 -> 32)
set_extent_buffer_dirty                                 -8 (32 -> 24)
write_one_eb                                            -8 (88 -> 80)
set_extent_buffer_uptodate                              -8 (40 -> 32)
read_extent_buffer_pages_nowait                        -16 (64 -> 48)
find_extent_buffer                                      -8 (32 -> 24)

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/disk-io.c   |  3 +--
 fs/btrfs/extent_io.c | 48 +++++++++++++++++---------------------------
 2 files changed, 19 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index a799216aa264..91c7da1ced7d 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -182,13 +182,12 @@ static int btrfs_repair_eb_io_failure(const struct extent_buffer *eb,
 				      int mirror_num)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
-	int num_folios = num_extent_folios(eb);
 	int ret = 0;
 
 	if (sb_rdonly(fs_info->sb))
 		return -EROFS;
 
-	for (int i = 0; i < num_folios; i++) {
+	for (int i = 0; i < num_extent_folios(eb); i++) {
 		struct folio *folio = eb->folios[i];
 		u64 start = max_t(u64, eb->start, folio_pos(folio));
 		u64 end = min_t(u64, eb->start + eb->len,
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 7b0aa332aedc..7fa4ce5d9ead 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1788,7 +1788,6 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct btrfs_bio *bbio;
-	const int num_folios = num_extent_folios(eb);
 
 	prepare_eb_write(eb);
 
@@ -1800,7 +1799,7 @@ static noinline_for_stack void write_one_eb(struct extent_buffer *eb,
 	wbc_init_bio(wbc, &bbio->bio);
 	bbio->inode = BTRFS_I(eb->fs_info->btree_inode);
 	bbio->file_offset = eb->start;
-	for (int i = 0; i < num_folios; i++) {
+	for (int i = 0; i < num_extent_folios(eb); i++) {
 		struct folio *folio = eb->folios[i];
 		u64 range_start = max_t(u64, eb->start, folio_pos(folio));
 		u32 range_len = min_t(u64, folio_pos(folio) + folio_size(folio),
@@ -2677,7 +2676,6 @@ __alloc_extent_buffer(struct btrfs_fs_info *fs_info, u64 start,
 struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 {
 	struct extent_buffer *new;
-	int num_folios = num_extent_folios(src);
 	int ret;
 
 	new = __alloc_extent_buffer(src->fs_info, src->start, src->len);
@@ -2697,7 +2695,7 @@ struct extent_buffer *btrfs_clone_extent_buffer(const struct extent_buffer *src)
 		return NULL;
 	}
 
-	for (int i = 0; i < num_folios; i++) {
+	for (int i = 0; i < num_extent_folios(src); i++) {
 		struct folio *folio = new->folios[i];
 
 		ret = attach_extent_buffer_folio(new, folio, NULL);
@@ -2717,7 +2715,6 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 						  u64 start, unsigned long len)
 {
 	struct extent_buffer *eb;
-	int num_folios = 0;
 	int ret;
 
 	eb = __alloc_extent_buffer(fs_info, start, len);
@@ -2726,13 +2723,12 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 
 	ret = alloc_eb_folio_array(eb, false);
 	if (ret)
-		goto err;
+		goto out;
 
-	num_folios = num_extent_folios(eb);
-	for (int i = 0; i < num_folios; i++) {
+	for (int i = 0; i < num_extent_folios(eb); i++) {
 		ret = attach_extent_buffer_folio(eb, eb->folios[i], NULL);
 		if (ret < 0)
-			goto err;
+			goto out_detach;
 	}
 
 	set_extent_buffer_uptodate(eb);
@@ -2740,13 +2736,15 @@ struct extent_buffer *__alloc_dummy_extent_buffer(struct btrfs_fs_info *fs_info,
 	set_bit(EXTENT_BUFFER_UNMAPPED, &eb->bflags);
 
 	return eb;
-err:
-	for (int i = 0; i < num_folios; i++) {
+
+out_detach:
+	for (int i = 0; i < num_extent_folios(eb); i++) {
 		if (eb->folios[i]) {
 			detach_extent_buffer_folio(eb, eb->folios[i]);
 			folio_put(eb->folios[i]);
 		}
 	}
+out:
 	kmem_cache_free(extent_buffer_cache, eb);
 	return NULL;
 }
@@ -2795,11 +2793,9 @@ static void check_buffer_tree_ref(struct extent_buffer *eb)
 
 static void mark_extent_buffer_accessed(struct extent_buffer *eb)
 {
-	int num_folios= num_extent_folios(eb);
-
 	check_buffer_tree_ref(eb);
 
-	for (int i = 0; i < num_folios; i++)
+	for (int i = 0; i < num_extent_folios(eb); i++)
 		folio_mark_accessed(eb->folios[i]);
 }
 
@@ -3032,7 +3028,6 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 					  u64 start, u64 owner_root, int level)
 {
 	unsigned long len = fs_info->nodesize;
-	int num_folios;
 	int attached = 0;
 	struct extent_buffer *eb;
 	struct extent_buffer *existing_eb = NULL;
@@ -3096,9 +3091,8 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 		goto out;
 	}
 
-	num_folios = num_extent_folios(eb);
 	/* Attach all pages to the filemap. */
-	for (int i = 0; i < num_folios; i++) {
+	for (int i = 0; i < num_extent_folios(eb); i++) {
 		struct folio *folio;
 
 		ret = attach_eb_folio_to_filemap(eb, i, prealloc, &existing_eb);
@@ -3192,7 +3186,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 	 * btree_release_folio will correctly detect that a page belongs to a
 	 * live buffer and won't free them prematurely.
 	 */
-	for (int i = 0; i < num_folios; i++)
+	for (int i = 0; i < num_extent_folios(eb); i++)
 		folio_unlock(eb->folios[i]);
 	return eb;
 
@@ -3338,7 +3332,6 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 			      struct extent_buffer *eb)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
-	const int num_folios = num_extent_folios(eb);
 
 	btrfs_assert_tree_write_locked(eb);
 
@@ -3365,7 +3358,7 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 	percpu_counter_add_batch(&fs_info->dirty_metadata_bytes, -eb->len,
 				 fs_info->dirty_metadata_batch);
 
-	for (int i = 0; i < num_folios; i++) {
+	for (int i = 0; i < num_extent_folios(eb); i++) {
 		struct folio *folio = eb->folios[i];
 		bool last;
 
@@ -3383,14 +3376,12 @@ void btrfs_clear_buffer_dirty(struct btrfs_trans_handle *trans,
 
 void set_extent_buffer_dirty(struct extent_buffer *eb)
 {
-	int num_folios;
 	bool was_dirty;
 
 	check_buffer_tree_ref(eb);
 
 	was_dirty = test_and_set_bit(EXTENT_BUFFER_DIRTY, &eb->bflags);
 
-	num_folios = num_extent_folios(eb);
 	WARN_ON(atomic_read(&eb->refs) == 0);
 	WARN_ON(!test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags));
 	WARN_ON(test_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &eb->bflags));
@@ -3411,7 +3402,7 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
 		 */
 		if (subpage)
 			folio_lock(eb->folios[0]);
-		for (int i = 0; i < num_folios; i++)
+		for (int i = 0; i < num_extent_folios(eb); i++)
 			btrfs_meta_folio_set_dirty(eb->fs_info, eb->folios[i],
 						   eb->start, eb->len);
 		if (subpage)
@@ -3421,7 +3412,7 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
 					 eb->fs_info->dirty_metadata_batch);
 	}
 #ifdef CONFIG_BTRFS_DEBUG
-	for (int i = 0; i < num_folios; i++)
+	for (int i = 0; i < num_extent_folios(eb); i++)
 		ASSERT(folio_test_dirty(eb->folios[i]));
 #endif
 }
@@ -3429,10 +3420,9 @@ void set_extent_buffer_dirty(struct extent_buffer *eb)
 void clear_extent_buffer_uptodate(struct extent_buffer *eb)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
-	int num_folios = num_extent_folios(eb);
 
 	clear_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
-	for (int i = 0; i < num_folios; i++) {
+	for (int i = 0; i < num_extent_folios(eb); i++) {
 		struct folio *folio = eb->folios[i];
 
 		if (!folio)
@@ -3445,10 +3435,9 @@ void clear_extent_buffer_uptodate(struct extent_buffer *eb)
 void set_extent_buffer_uptodate(struct extent_buffer *eb)
 {
 	struct btrfs_fs_info *fs_info = eb->fs_info;
-	int num_folios = num_extent_folios(eb);
 
 	set_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags);
-	for (int i = 0; i < num_folios; i++) {
+	for (int i = 0; i < num_extent_folios(eb); i++) {
 		struct folio *folio = eb->folios[i];
 
 		btrfs_meta_folio_set_uptodate(fs_info, folio, eb->start, eb->len);
@@ -3496,7 +3485,6 @@ static void end_bbio_meta_read(struct btrfs_bio *bbio)
 int read_extent_buffer_pages_nowait(struct extent_buffer *eb, int mirror_num,
 				    const struct btrfs_tree_parent_check *check)
 {
-	const int num_folios = num_extent_folios(eb);
 	struct btrfs_bio *bbio;
 
 	if (test_bit(EXTENT_BUFFER_UPTODATE, &eb->bflags))
@@ -3537,7 +3525,7 @@ int read_extent_buffer_pages_nowait(struct extent_buffer *eb, int mirror_num,
 	bbio->inode = BTRFS_I(eb->fs_info->btree_inode);
 	bbio->file_offset = eb->start;
 	memcpy(&bbio->parent_check, check, sizeof(*check));
-	for (int i = 0; i < num_folios; i++) {
+	for (int i = 0; i < num_extent_folios(eb); i++) {
 		struct folio *folio = eb->folios[i];
 		u64 range_start = max_t(u64, eb->start, folio_pos(folio));
 		u32 range_len = min_t(u64, folio_pos(folio) + folio_size(folio),
-- 
2.47.1


