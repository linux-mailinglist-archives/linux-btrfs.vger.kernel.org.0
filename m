Return-Path: <linux-btrfs+bounces-10539-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E94D29F61FE
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 10:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA62116E708
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 09:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EAE19ABD4;
	Wed, 18 Dec 2024 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vQy0P7SQ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vQy0P7SQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CF3198A1A
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734514932; cv=none; b=bi0Rrvyh/p20mZZni1zAa/WZqAegtAnX08jNaaMV0nJNyBUw2XvLVyiq/yePO6Aj8fvc2JASk1CtPZnxz//p0bzG24ERuEUvxrsalVjyglEwXg8lRWuahVED8pqj0etp7ptBAMGioX+64P/CrmsmEcasDQ7PRjjEuUV30Vtl8oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734514932; c=relaxed/simple;
	bh=CZ3j1ilugXVhcETPlizzyby0TepX2Pyh7fdv0ao4r50=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGNFE8NAg+zHj4k8pZNle/OxbLzTlHDg2pZU1TD4200VUvjg4iBxxBaV9XZDkBC/rrUDjkOtpxE7u0Q0U4jpaV+yfdX9poJQna8vw3BYXcKKetn2flU70NKQeGgHRKlVk/YBIV0unEFHBHLPfguj5kaxAD9lBEPlhtRwnTIkpFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vQy0P7SQ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vQy0P7SQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6C83D21167
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=THURlZX5p7gb8h13WI0SVDxcmy2zvEtdWx2ITMhi7XM=;
	b=vQy0P7SQMj6Y6VkiE5trDOf42JJlY5JOqmu1hK/8gdE3O4Pi8zQguvjy03bOwTTSTykugM
	5IsTRi5wmRVZ+qZwenA2rXJ01FzCAPxkDJS/X7njKpZWVPJMw2Iw3SVQ/hHC6S8BvDiF9s
	Ot6g0rm8EzMSwuaP9Dpi9z+4Wi4JjEY=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734514929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=THURlZX5p7gb8h13WI0SVDxcmy2zvEtdWx2ITMhi7XM=;
	b=vQy0P7SQMj6Y6VkiE5trDOf42JJlY5JOqmu1hK/8gdE3O4Pi8zQguvjy03bOwTTSTykugM
	5IsTRi5wmRVZ+qZwenA2rXJ01FzCAPxkDJS/X7njKpZWVPJMw2Iw3SVQ/hHC6S8BvDiF9s
	Ot6g0rm8EzMSwuaP9Dpi9z+4Wi4JjEY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A87B132EA
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AELuFfCYYmdmSwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 09:42:08 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 12/18] btrfs: migrate defrag.c to use block size terminology
Date: Wed, 18 Dec 2024 20:11:28 +1030
Message-ID: <ed1c6f9daf9d0b2fa253a6d9b632ee53b64a1c06.1734514696.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734514696.git.wqu@suse.com>
References: <cover.1734514696.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
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

Straightforward rename from "sector" to "block".

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/defrag.c | 52 +++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index 968dae953948..7a96505957b3 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -272,7 +272,7 @@ static int btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 	if (ret < 0)
 		goto cleanup;
 
-	cur = max(cur + fs_info->sectorsize, range.start);
+	cur = max(cur + fs_info->blocksize, range.start);
 	goto again;
 
 cleanup:
@@ -749,14 +749,14 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
 	struct extent_map_tree *em_tree = &BTRFS_I(inode)->extent_tree;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct extent_map *em;
-	const u32 sectorsize = BTRFS_I(inode)->root->fs_info->sectorsize;
+	const u32 blocksize = BTRFS_I(inode)->root->fs_info->blocksize;
 
 	/*
 	 * Hopefully we have this extent in the tree already, try without the
 	 * full extent lock.
 	 */
 	read_lock(&em_tree->lock);
-	em = lookup_extent_mapping(em_tree, start, sectorsize);
+	em = lookup_extent_mapping(em_tree, start, blocksize);
 	read_unlock(&em_tree->lock);
 
 	/*
@@ -775,7 +775,7 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start,
 
 	if (!em) {
 		struct extent_state *cached = NULL;
-		u64 end = start + sectorsize - 1;
+		u64 end = start + blocksize - 1;
 
 		/* Get the big lock and read metadata off disk. */
 		if (!locked)
@@ -1199,7 +1199,7 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 	struct defrag_target_range *tmp;
 	LIST_HEAD(target_list);
 	struct folio **folios;
-	const u32 sectorsize = inode->root->fs_info->sectorsize;
+	const u32 blocksize = inode->root->fs_info->blocksize;
 	u64 last_index = (start + len - 1) >> PAGE_SHIFT;
 	u64 start_index = start >> PAGE_SHIFT;
 	unsigned int nr_pages = last_index - start_index + 1;
@@ -1207,7 +1207,7 @@ static int defrag_one_range(struct btrfs_inode *inode, u64 start, u32 len,
 	int i;
 
 	ASSERT(nr_pages <= CLUSTER_SIZE / PAGE_SIZE);
-	ASSERT(IS_ALIGNED(start, sectorsize) && IS_ALIGNED(len, sectorsize));
+	ASSERT(IS_ALIGNED(start, blocksize) && IS_ALIGNED(len, blocksize));
 
 	folios = kcalloc(nr_pages, sizeof(struct folio *), GFP_NOFS);
 	if (!folios)
@@ -1270,11 +1270,11 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
 			      struct file_ra_state *ra,
 			      u64 start, u32 len, u32 extent_thresh,
 			      u64 newer_than, bool do_compress,
-			      unsigned long *sectors_defragged,
-			      unsigned long max_sectors,
+			      unsigned long *blocks_defragged,
+			      unsigned long max_blocks,
 			      u64 *last_scanned_ret)
 {
-	const u32 sectorsize = inode->root->fs_info->sectorsize;
+	const u32 blocksize = inode->root->fs_info->blocksize;
 	struct defrag_target_range *entry;
 	struct defrag_target_range *tmp;
 	LIST_HEAD(target_list);
@@ -1290,14 +1290,14 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
 		u32 range_len = entry->len;
 
 		/* Reached or beyond the limit */
-		if (max_sectors && *sectors_defragged >= max_sectors) {
+		if (max_blocks && *blocks_defragged >= max_blocks) {
 			ret = 1;
 			break;
 		}
 
-		if (max_sectors)
+		if (max_blocks)
 			range_len = min_t(u32, range_len,
-				(max_sectors - *sectors_defragged) * sectorsize);
+				(max_blocks - *blocks_defragged) * blocksize);
 
 		/*
 		 * If defrag_one_range() has updated last_scanned_ret,
@@ -1315,7 +1315,7 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
 		/*
 		 * Here we may not defrag any range if holes are punched before
 		 * we locked the pages.
-		 * But that's fine, it only affects the @sectors_defragged
+		 * But that's fine, it only affects the @blocks_defragged
 		 * accounting.
 		 */
 		ret = defrag_one_range(inode, entry->start, range_len,
@@ -1323,8 +1323,8 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
 				       last_scanned_ret);
 		if (ret < 0)
 			break;
-		*sectors_defragged += range_len >>
-				      inode->root->fs_info->sectorsize_bits;
+		*blocks_defragged += range_len >>
+				      inode->root->fs_info->blocksize_bits;
 	}
 out:
 	list_for_each_entry_safe(entry, tmp, &target_list, list) {
@@ -1343,11 +1343,11 @@ static int defrag_one_cluster(struct btrfs_inode *inode,
  * @ra:		   readahead state
  * @range:	   defrag options including range and flags
  * @newer_than:	   minimum transid to defrag
- * @max_to_defrag: max number of sectors to be defragged, if 0, the whole inode
+ * @max_to_defrag: max number of blocks to be defragged, if 0, the whole inode
  *		   will be defragged.
  *
  * Return <0 for error.
- * Return >=0 for the number of sectors defragged, and range->start will be updated
+ * Return >=0 for the number of blocks defragged, and range->start will be updated
  * to indicate the file offset where next defrag should be started at.
  * (Mostly for autodefrag, which sets @max_to_defrag thus we may exit early without
  *  defragging all the range).
@@ -1357,7 +1357,7 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 		      u64 newer_than, unsigned long max_to_defrag)
 {
 	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
-	unsigned long sectors_defragged = 0;
+	unsigned long blocks_defragged = 0;
 	u64 isize = i_size_read(inode);
 	u64 cur;
 	u64 last_byte;
@@ -1394,8 +1394,8 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 	}
 
 	/* Align the range */
-	cur = round_down(range->start, fs_info->sectorsize);
-	last_byte = round_up(last_byte, fs_info->sectorsize) - 1;
+	cur = round_down(range->start, fs_info->blocksize);
+	last_byte = round_up(last_byte, fs_info->blocksize) - 1;
 
 	/*
 	 * Make writeback start from the beginning of the range, so that the
@@ -1406,7 +1406,7 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 		inode->i_mapping->writeback_index = start_index;
 
 	while (cur < last_byte) {
-		const unsigned long prev_sectors_defragged = sectors_defragged;
+		const unsigned long prev_blocks_defragged = blocks_defragged;
 		u64 last_scanned = cur;
 		u64 cluster_end;
 
@@ -1434,10 +1434,10 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 			BTRFS_I(inode)->defrag_compress = compress_type;
 		ret = defrag_one_cluster(BTRFS_I(inode), ra, cur,
 				cluster_end + 1 - cur, extent_thresh,
-				newer_than, do_compress, &sectors_defragged,
+				newer_than, do_compress, &blocks_defragged,
 				max_to_defrag, &last_scanned);
 
-		if (sectors_defragged > prev_sectors_defragged)
+		if (blocks_defragged > prev_blocks_defragged)
 			balance_dirty_pages_ratelimited(inode->i_mapping);
 
 		btrfs_inode_unlock(BTRFS_I(inode), 0);
@@ -1456,9 +1456,9 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 	 * in next run.
 	 */
 	range->start = cur;
-	if (sectors_defragged) {
+	if (blocks_defragged) {
 		/*
-		 * We have defragged some sectors, for compression case they
+		 * We have defragged some blocks, for compression case they
 		 * need to be written back immediately.
 		 */
 		if (range->flags & BTRFS_DEFRAG_RANGE_START_IO) {
@@ -1471,7 +1471,7 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
 			btrfs_set_fs_incompat(fs_info, COMPRESS_LZO);
 		else if (range->compress_type == BTRFS_COMPRESS_ZSTD)
 			btrfs_set_fs_incompat(fs_info, COMPRESS_ZSTD);
-		ret = sectors_defragged;
+		ret = blocks_defragged;
 	}
 	if (do_compress) {
 		btrfs_inode_lock(BTRFS_I(inode), 0);
-- 
2.47.1


