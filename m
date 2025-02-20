Return-Path: <linux-btrfs+bounces-11610-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 618F0A3D4A5
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 10:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37FF3BDAC7
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Feb 2025 09:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43531EE031;
	Thu, 20 Feb 2025 09:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jYTOrGLP";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jYTOrGLP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE861EF0B6
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740043385; cv=none; b=Zb7LvAxEn41lqroWA+rK8GekSVdYlilx/P0IZudAt2E5eZ/SangFPoy0hn6C1MascGpVjClcJErBEEoRpRXR8hnTI4c0rph71SPIaRVXnLiGOaq8NBhDHQSTqzQZ+n+wndXuxux85LvJSyVPbU+YpLlg9koEMaZ0n2Q1cn2oN4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740043385; c=relaxed/simple;
	bh=PW9v7w1wVtAwxUJk9h/O5PWHlh5L7JWyUB0OwLRb/l4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WZ2by3faxGABvmw66pDp/8+potl/ENnbrNno/qU9C290THx1nh+hKdzmWenPuOHjvPm+wTMKWamROB0Jo0SKKSKNijHdwZ5XFBffnLjuXoBjVGr2IQEGmxIs2Ew30lHUuIn7YmKPRu9EAKqVbcJoRw+NqCFNajJo9fub6MWzli0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jYTOrGLP; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jYTOrGLP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DD92A21174
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 09:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740043372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MXM7L04ykvuovkhOKzygkMscFl4C1gAn9/UV8SetCrw=;
	b=jYTOrGLPSGO0YDm2IEvdSelDyAKEOZfc1ShEKf2bj+RP/J07nJsvXuWJ/B5p0QS3FZro6i
	JnDosiSVJ9tEPTszW5lL5V5422YEeaOTl080zBUjbMdAb3h8gGsfs92Mkubo2mAigzaoei
	L6IuUBDAQTlmb3AXZo82WGdysBiF9m8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740043372; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MXM7L04ykvuovkhOKzygkMscFl4C1gAn9/UV8SetCrw=;
	b=jYTOrGLPSGO0YDm2IEvdSelDyAKEOZfc1ShEKf2bj+RP/J07nJsvXuWJ/B5p0QS3FZro6i
	JnDosiSVJ9tEPTszW5lL5V5422YEeaOTl080zBUjbMdAb3h8gGsfs92Mkubo2mAigzaoei
	L6IuUBDAQTlmb3AXZo82WGdysBiF9m8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1F3913A69
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 09:22:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aCPdHmv0tmfBcgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Feb 2025 09:22:51 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/5] btrfs: prepare extent_io.c for future larger folio support
Date: Thu, 20 Feb 2025 19:52:25 +1030
Message-ID: <19dfc0e42dce6416b66df114513d18d93b830d17.1740043233.git.wqu@suse.com>
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
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

When we're handling folios from filemap, we can no longer assume all
folios are page sized.

Thus for call sites assuming the folio is page sized, change the
PAGE_SIZE usage to folio_size() instead.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index e1efb6419601..88bac9a32919 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -425,7 +425,7 @@ static void end_folio_read(struct folio *folio, bool uptodate, u64 start, u32 le
 	struct btrfs_fs_info *fs_info = folio_to_fs_info(folio);
 
 	ASSERT(folio_pos(folio) <= start &&
-	       start + len <= folio_pos(folio) + PAGE_SIZE);
+	       start + len <= folio_pos(folio) + folio_size(folio));
 
 	if (uptodate && btrfs_verify_folio(folio, start, len))
 		btrfs_folio_set_uptodate(fs_info, folio, start, len);
@@ -492,7 +492,7 @@ static void begin_folio_read(struct btrfs_fs_info *fs_info, struct folio *folio)
 		return;
 
 	ASSERT(folio_test_private(folio));
-	btrfs_folio_set_lock(fs_info, folio, folio_pos(folio), PAGE_SIZE);
+	btrfs_folio_set_lock(fs_info, folio, folio_pos(folio), folio_size(folio));
 }
 
 /*
@@ -753,7 +753,7 @@ static void submit_extent_folio(struct btrfs_bio_ctrl *bio_ctrl,
 {
 	struct btrfs_inode *inode = folio_to_inode(folio);
 
-	ASSERT(pg_offset + size <= PAGE_SIZE);
+	ASSERT(pg_offset + size <= folio_size(folio));
 	ASSERT(bio_ctrl->end_io_func);
 
 	if (bio_ctrl->bbio &&
@@ -935,7 +935,7 @@ static int btrfs_do_readpage(struct folio *folio, struct extent_map **em_cached,
 	struct inode *inode = folio->mapping->host;
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
 	u64 start = folio_pos(folio);
-	const u64 end = start + PAGE_SIZE - 1;
+	const u64 end = start + folio_size(folio) - 1;
 	u64 cur = start;
 	u64 extent_offset;
 	u64 last_byte = i_size_read(inode);
@@ -1277,7 +1277,7 @@ static void set_delalloc_bitmap(struct folio *folio, unsigned long *delalloc_bit
 	unsigned int start_bit;
 	unsigned int nbits;
 
-	ASSERT(start >= folio_start && start + len <= folio_start + PAGE_SIZE);
+	ASSERT(start >= folio_start && start + len <= folio_start + folio_size(folio));
 	start_bit = (start - folio_start) >> fs_info->sectorsize_bits;
 	nbits = len >> fs_info->sectorsize_bits;
 	ASSERT(bitmap_test_range_all_zero(delalloc_bitmap, start_bit, nbits));
@@ -1295,7 +1295,7 @@ static bool find_next_delalloc_bitmap(struct folio *folio,
 	unsigned int first_zero;
 	unsigned int first_set;
 
-	ASSERT(start >= folio_start && start < folio_start + PAGE_SIZE);
+	ASSERT(start >= folio_start && start < folio_start + folio_size(folio));
 
 	start_bit = (start - folio_start) >> fs_info->sectorsize_bits;
 	first_set = find_next_bit(delalloc_bitmap, bitmap_size, start_bit);
@@ -1497,10 +1497,10 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 		delalloc_end = page_end;
 	/*
 	 * delalloc_end is already one less than the total length, so
-	 * we don't subtract one from PAGE_SIZE
+	 * we don't subtract one from folio_size().
 	 */
 	delalloc_to_write +=
-		DIV_ROUND_UP(delalloc_end + 1 - page_start, PAGE_SIZE);
+		DIV_ROUND_UP(delalloc_end + 1 - page_start, folio_size(folio));
 
 	/*
 	 * If all ranges are submitted asynchronously, we just need to account
@@ -1737,7 +1737,7 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 		goto done;
 
 	ret = extent_writepage_io(inode, folio, folio_pos(folio),
-				  PAGE_SIZE, bio_ctrl, i_size);
+				  folio_size(folio), bio_ctrl, i_size);
 	if (ret == 1)
 		return 0;
 	if (ret < 0)
@@ -2468,8 +2468,8 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 	ASSERT(IS_ALIGNED(start, sectorsize) && IS_ALIGNED(end + 1, sectorsize));
 
 	while (cur <= end) {
-		u64 cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
-		u32 cur_len = cur_end + 1 - cur;
+		u64 cur_end;
+		u32 cur_len;
 		struct folio *folio;
 
 		folio = filemap_get_folio(mapping, cur >> PAGE_SHIFT);
@@ -2479,13 +2479,18 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 		 * code is just in case, but shouldn't actually be run.
 		 */
 		if (IS_ERR(folio)) {
+			cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
+			cur_len = cur_end + 1 - cur;
 			btrfs_mark_ordered_io_finished(BTRFS_I(inode), NULL,
 						       cur, cur_len, false);
 			mapping_set_error(mapping, PTR_ERR(folio));
-			cur = cur_end + 1;
+			cur = cur_end;
 			continue;
 		}
 
+		cur_end = min(folio_pos(folio) + folio_size(folio) - 1, end);
+		cur_len = cur_end + 1 - cur;
+
 		ASSERT(folio_test_locked(folio));
 		if (pages_dirty && folio != locked_folio)
 			ASSERT(folio_test_dirty(folio));
@@ -2597,7 +2602,7 @@ static bool try_release_extent_state(struct extent_io_tree *tree,
 				     struct folio *folio)
 {
 	u64 start = folio_pos(folio);
-	u64 end = start + PAGE_SIZE - 1;
+	u64 end = start + folio_size(folio) - 1;
 	bool ret;
 
 	if (test_range_bit_exists(tree, start, end, EXTENT_LOCKED)) {
@@ -2635,7 +2640,7 @@ static bool try_release_extent_state(struct extent_io_tree *tree,
 bool try_release_extent_mapping(struct folio *folio, gfp_t mask)
 {
 	u64 start = folio_pos(folio);
-	u64 end = start + PAGE_SIZE - 1;
+	u64 end = start + folio_size(folio) - 1;
 	struct btrfs_inode *inode = folio_to_inode(folio);
 	struct extent_io_tree *io_tree = &inode->io_tree;
 
-- 
2.48.1


