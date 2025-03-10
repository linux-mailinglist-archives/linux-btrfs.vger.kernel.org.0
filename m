Return-Path: <linux-btrfs+bounces-12130-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1411BA58D04
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 08:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAF877A452F
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 07:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A74221542;
	Mon, 10 Mar 2025 07:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aV1fqrT3";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="W67amPL0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2642206B6
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 07:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741592211; cv=none; b=TWsdGSyM0bFZzk8Y9Y6GkAKyO70P7wc91ZGDyynJy7rvDZGAFh+725OHSFJAQ/kYO+4+i59VlworPwKJuHSB6RwcVK5PkvunQPYS3rR26dViWAgaqEzTWu+RAE0XB5zAGIYmehJuLDSAEi+w09YjGVk3r1gkfjWp0BuLtM5d8Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741592211; c=relaxed/simple;
	bh=MTTqZC6ZKat3DZsFdjeOrG6UcSFq9hnd5VswdJgHBWk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SZov71LgJ5ZclPDzvps1pM89RVgiXZeVcp++1AychNyXkKh/tNOASLipgOAznLSdrbDp0PB+QLly8tqQr1OXGtLAr13y7qk2byfbiBDWd4m6NStEGI3cgBiNSFmrwEIoG0Imi3iHVZJmycXtClf+XtZoByhh1gqVIKP8Em5LU9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aV1fqrT3; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=W67amPL0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E3BB81F454
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 07:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741592188; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQt26cnl6VKPZHpaNK7cz1vsppPYP0zJAdIpiP86oXk=;
	b=aV1fqrT339nK54GTLLu2q+G72eOfPCPQtGtibAqp4tubLUOEIECIfxzJ2lV40Tp/rOVhN/
	+oOHgc9Q+NZasZG8bQ0HN7cMyZC32e/rAZoSOEF228YEcu/tyEMrY4Q6HEJUp38jSNO2dq
	Vp3GQyO1S2Jb1UC9JPoRduhO4+i5aHo=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=W67amPL0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1741592187; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aQt26cnl6VKPZHpaNK7cz1vsppPYP0zJAdIpiP86oXk=;
	b=W67amPL0jWzZbRQzQUxgCltxjySfLfDNGXRVVxXa4QXymMLnUqFL06C6fmr+IT/cuXH5Mf
	4sAZfEKAbBwwK2p0mr+bnIaPN0lqTqIkj0c/HBbVqHL/2sZRPpWjn4uXhJu4VBjwtxHT7U
	AWsrYtRi7EmgJ8BI1uVc6R30j8ISnKk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 227E813A70
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 07:36:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oBTQNHqWzmfpMAAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 07:36:26 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 5/6] btrfs: prepare extent_io.c for future larger folio support
Date: Mon, 10 Mar 2025 18:06:01 +1030
Message-ID: <657d28be4aebee9d3b40e7e34b0c1b75fbbf5da6.1741591823.git.wqu@suse.com>
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
X-Rspamd-Queue-Id: E3BB81F454
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

When we're handling folios from filemap, we can no longer assume all
folios are page sized.

Thus for call sites assuming the folio is page sized, change the
PAGE_SIZE usage to folio_size() instead.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 337d2bed98d9..337908f09b88 100644
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
 	u64 extent_offset;
 	u64 last_byte = i_size_read(inode);
 	struct extent_map *em;
@@ -1279,7 +1279,7 @@ static void set_delalloc_bitmap(struct folio *folio, unsigned long *delalloc_bit
 	unsigned int start_bit;
 	unsigned int nbits;
 
-	ASSERT(start >= folio_start && start + len <= folio_start + PAGE_SIZE);
+	ASSERT(start >= folio_start && start + len <= folio_start + folio_size(folio));
 	start_bit = (start - folio_start) >> fs_info->sectorsize_bits;
 	nbits = len >> fs_info->sectorsize_bits;
 	ASSERT(bitmap_test_range_all_zero(delalloc_bitmap, start_bit, nbits));
@@ -1297,7 +1297,7 @@ static bool find_next_delalloc_bitmap(struct folio *folio,
 	unsigned int first_zero;
 	unsigned int first_set;
 
-	ASSERT(start >= folio_start && start < folio_start + PAGE_SIZE);
+	ASSERT(start >= folio_start && start < folio_start + folio_size(folio));
 
 	start_bit = (start - folio_start) >> fs_info->sectorsize_bits;
 	first_set = find_next_bit(delalloc_bitmap, bitmap_size, start_bit);
@@ -1499,10 +1499,10 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
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
@@ -1765,7 +1765,7 @@ static int extent_writepage(struct folio *folio, struct btrfs_bio_ctrl *bio_ctrl
 		goto done;
 
 	ret = extent_writepage_io(inode, folio, folio_pos(folio),
-				  PAGE_SIZE, bio_ctrl, i_size);
+				  folio_size(folio), bio_ctrl, i_size);
 	if (ret == 1)
 		return 0;
 	if (ret < 0)
@@ -2492,8 +2492,8 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
 	ASSERT(IS_ALIGNED(start, sectorsize) && IS_ALIGNED(end + 1, sectorsize));
 
 	while (cur <= end) {
-		u64 cur_end = min(round_down(cur, PAGE_SIZE) + PAGE_SIZE - 1, end);
-		u32 cur_len = cur_end + 1 - cur;
+		u64 cur_end;
+		u32 cur_len;
 		struct folio *folio;
 
 		folio = filemap_get_folio(mapping, cur >> PAGE_SHIFT);
@@ -2503,13 +2503,18 @@ void extent_write_locked_range(struct inode *inode, const struct folio *locked_f
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
@@ -2621,7 +2626,7 @@ static bool try_release_extent_state(struct extent_io_tree *tree,
 				     struct folio *folio)
 {
 	u64 start = folio_pos(folio);
-	u64 end = start + PAGE_SIZE - 1;
+	u64 end = start + folio_size(folio) - 1;
 	bool ret;
 
 	if (test_range_bit_exists(tree, start, end, EXTENT_LOCKED)) {
@@ -2659,7 +2664,7 @@ static bool try_release_extent_state(struct extent_io_tree *tree,
 bool try_release_extent_mapping(struct folio *folio, gfp_t mask)
 {
 	u64 start = folio_pos(folio);
-	u64 end = start + PAGE_SIZE - 1;
+	u64 end = start + folio_size(folio) - 1;
 	struct btrfs_inode *inode = folio_to_inode(folio);
 	struct extent_io_tree *io_tree = &inode->io_tree;
 
-- 
2.48.1


