Return-Path: <linux-btrfs+bounces-4029-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053C189CE72
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 00:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5307B224F9
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Apr 2024 22:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E892F38DD9;
	Mon,  8 Apr 2024 22:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GaU2SdwG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="GaU2SdwG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB702383B1
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Apr 2024 22:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712615645; cv=none; b=D/SQu55XkCOcwRb2mS2RTY8TWYl8S2chfxfbZE9hr5XUUO0S9LiU0tHFp0kMhGAnEXftDErje0hNnnGO/ZaOi5jZ7tMpt4W7RJAiWAp9VSSAmTN/sCytwPy75Ex/HkKpJ00Yc4Vr4JhWHyRQEn7Pgim1JT3XM1umt4pWxN54I/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712615645; c=relaxed/simple;
	bh=w2uTKes9fH40d0jBnhwG6oCxRtNTO2c0CdvqcvVURmQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oma48qEfzf2mrq0TzrEv92wcpkIpOFA9JQ1jNo9/sJHODRWunhnO6cZqXrOhSO15UCETbrRn9HdiHF+shWqR7i519zr1HTkbauScg+yv78+ii70bhwl1OLjMjdXLjqC8GgguB+HJEDBOYKKNR09e3RxEYOq+bwgNDy3BdLgR7DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GaU2SdwG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=GaU2SdwG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1A02D22DBD
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Apr 2024 22:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712615641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xcmxGhOcC24+3tU/NWYBcMkPeCjHqoBj1wEgx0kr4lc=;
	b=GaU2SdwGRYtBgtWXl89TA1ILPT3zEJpCPyTEAiYA+cgakfN5sl3k38BvjMu7jjpoXZ0JRn
	sTarXI6lthlzUx1kWViB/bIki7adsr6U4mLBOZjlxzeiPGEQFUalan8nJ6V/u24Y95mUHh
	b+rB7HILPPvbW0b+QdHoxED4JBWI0NU=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1712615641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xcmxGhOcC24+3tU/NWYBcMkPeCjHqoBj1wEgx0kr4lc=;
	b=GaU2SdwGRYtBgtWXl89TA1ILPT3zEJpCPyTEAiYA+cgakfN5sl3k38BvjMu7jjpoXZ0JRn
	sTarXI6lthlzUx1kWViB/bIki7adsr6U4mLBOZjlxzeiPGEQFUalan8nJ6V/u24Y95mUHh
	b+rB7HILPPvbW0b+QdHoxED4JBWI0NU=
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 375171332F
	for <linux-btrfs@vger.kernel.org>; Mon,  8 Apr 2024 22:33:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id SJH+NtdwFGaSTQAAn2gu4w
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 08 Apr 2024 22:33:59 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 1/8] btrfs: rename extent_map::orig_block_len to disk_num_bytes
Date: Tue,  9 Apr 2024 08:03:40 +0930
Message-ID: <4087de32eabbf9f14988f69e33240db2d5576f5d.1712614770.git.wqu@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712614770.git.wqu@suse.com>
References: <cover.1712614770.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

This would make it very obvious that the member just matches
btrfs_file_extent_item::disk_num_bytes.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_map.c | 16 ++++++++--------
 fs/btrfs/extent_map.h |  2 +-
 fs/btrfs/file-item.c  |  4 ++--
 fs/btrfs/file.c       |  2 +-
 fs/btrfs/inode.c      | 10 +++++-----
 fs/btrfs/tree-log.c   |  6 +++---
 6 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 955ce300e5a1..dd51a21b6a76 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -759,14 +759,14 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 					split->block_len = em->block_len;
 				else
 					split->block_len = split->len;
-				split->orig_block_len = max(split->block_len,
-						em->orig_block_len);
+				split->disk_num_bytes = max(split->block_len,
+							    em->disk_num_bytes);
 				split->ram_bytes = em->ram_bytes;
 			} else {
 				split->orig_start = split->start;
 				split->block_len = 0;
 				split->block_start = em->block_start;
-				split->orig_block_len = 0;
+				split->disk_num_bytes = 0;
 				split->ram_bytes = split->len;
 			}
 
@@ -791,8 +791,8 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 			split->generation = gen;
 
 			if (em->block_start < EXTENT_MAP_LAST_BYTE) {
-				split->orig_block_len = max(em->block_len,
-						    em->orig_block_len);
+				split->disk_num_bytes = max(em->block_len,
+							    em->disk_num_bytes);
 
 				split->ram_bytes = em->ram_bytes;
 				if (compressed) {
@@ -809,7 +809,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 				split->ram_bytes = split->len;
 				split->orig_start = split->start;
 				split->block_len = 0;
-				split->orig_block_len = 0;
+				split->disk_num_bytes = 0;
 			}
 
 			if (extent_map_in_tree(em)) {
@@ -968,7 +968,7 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	split_pre->orig_start = split_pre->start;
 	split_pre->block_start = new_logical;
 	split_pre->block_len = split_pre->len;
-	split_pre->orig_block_len = split_pre->block_len;
+	split_pre->disk_num_bytes = split_pre->block_len;
 	split_pre->ram_bytes = split_pre->len;
 	split_pre->flags = flags;
 	split_pre->generation = em->generation;
@@ -986,7 +986,7 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	split_mid->orig_start = split_mid->start;
 	split_mid->block_start = em->block_start + pre;
 	split_mid->block_len = split_mid->len;
-	split_mid->orig_block_len = split_mid->block_len;
+	split_mid->disk_num_bytes = split_mid->block_len;
 	split_mid->ram_bytes = split_mid->len;
 	split_mid->flags = flags;
 	split_mid->generation = em->generation;
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 0b938e12cc78..242a0c2e7a5e 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -71,7 +71,7 @@ struct extent_map {
 	 * The full on-disk extent length, matching
 	 * btrfs_file_extent_item::disk_num_bytes.
 	 */
-	u64 orig_block_len;
+	u64 disk_num_bytes;
 
 	/*
 	 * The decompressed size of the whole on-disk extent, matching
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 844439f19949..b552646a0ce6 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1280,7 +1280,7 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 		em->len = btrfs_file_extent_end(path) - extent_start;
 		em->orig_start = extent_start -
 			btrfs_file_extent_offset(leaf, fi);
-		em->orig_block_len = btrfs_file_extent_disk_num_bytes(leaf, fi);
+		em->disk_num_bytes = btrfs_file_extent_disk_num_bytes(leaf, fi);
 		bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
 		if (bytenr == 0) {
 			em->block_start = EXTENT_MAP_HOLE;
@@ -1289,7 +1289,7 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 		if (compress_type != BTRFS_COMPRESS_NONE) {
 			extent_map_set_compression(em, compress_type);
 			em->block_start = bytenr;
-			em->block_len = em->orig_block_len;
+			em->block_len = em->disk_num_bytes;
 		} else {
 			bytenr += btrfs_file_extent_offset(leaf, fi);
 			em->block_start = bytenr;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0c23053951be..cdcd7e0785c1 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2162,7 +2162,7 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 
 		hole_em->block_start = EXTENT_MAP_HOLE;
 		hole_em->block_len = 0;
-		hole_em->orig_block_len = 0;
+		hole_em->disk_num_bytes = 0;
 		hole_em->generation = trans->transid;
 
 		ret = btrfs_replace_extent_map_range(inode, hole_em, true);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ced916f42bab..2e0156943c7c 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4991,7 +4991,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 
 			hole_em->block_start = EXTENT_MAP_HOLE;
 			hole_em->block_len = 0;
-			hole_em->orig_block_len = 0;
+			hole_em->disk_num_bytes = 0;
 			hole_em->ram_bytes = hole_size;
 			hole_em->generation = btrfs_get_fs_generation(fs_info);
 
@@ -7313,7 +7313,7 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 /* The callers of this must take lock_extent() */
 static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 				       u64 len, u64 orig_start, u64 block_start,
-				       u64 block_len, u64 orig_block_len,
+				       u64 block_len, u64 disk_num_bytes,
 				       u64 ram_bytes, int compress_type,
 				       int type)
 {
@@ -7345,7 +7345,7 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 		ASSERT(block_len == len);
 
 		/* COW results a new extent matching our file extent size. */
-		ASSERT(orig_block_len == len);
+		ASSERT(disk_num_bytes == len);
 		ASSERT(ram_bytes == len);
 
 		/* Since it's a new extent, we should not have any offset. */
@@ -7372,7 +7372,7 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 	em->len = len;
 	em->block_len = block_len;
 	em->block_start = block_start;
-	em->orig_block_len = orig_block_len;
+	em->disk_num_bytes = disk_num_bytes;
 	em->ram_bytes = ram_bytes;
 	em->generation = -1;
 	em->flags |= EXTENT_FLAG_PINNED;
@@ -9776,7 +9776,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		em->len = ins.offset;
 		em->block_start = ins.objectid;
 		em->block_len = ins.offset;
-		em->orig_block_len = ins.offset;
+		em->disk_num_bytes = ins.offset;
 		em->ram_bytes = ins.offset;
 		em->flags |= EXTENT_FLAG_PREALLOC;
 		em->generation = trans->transid;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index d9777649e170..2a13ca1eb7c5 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2872,7 +2872,7 @@ static inline void btrfs_remove_log_ctx(struct btrfs_root *root,
 	mutex_unlock(&root->log_mutex);
 }
 
-/* 
+/*
  * Invoked in log mutex context, or be sure there is no other task which
  * can access the list.
  */
@@ -4645,7 +4645,7 @@ static int log_extent_csums(struct btrfs_trans_handle *trans,
 	/* If we're compressed we have to save the entire range of csums. */
 	if (extent_map_is_compressed(em)) {
 		csum_offset = 0;
-		csum_len = max(em->block_len, em->orig_block_len);
+		csum_len = max(em->block_len, em->disk_num_bytes);
 	} else {
 		csum_offset = mod_start - em->start;
 		csum_len = mod_len;
@@ -4694,7 +4694,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	else
 		btrfs_set_stack_file_extent_type(&fi, BTRFS_FILE_EXTENT_REG);
 
-	block_len = max(em->block_len, em->orig_block_len);
+	block_len = max(em->block_len, em->disk_num_bytes);
 	compress_type = extent_map_compression(em);
 	if (compress_type != BTRFS_COMPRESS_NONE) {
 		btrfs_set_stack_file_extent_disk_bytenr(&fi, em->block_start);
-- 
2.44.0


