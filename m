Return-Path: <linux-btrfs+bounces-5227-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5608CCB92
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 07:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 272F2B21D85
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 May 2024 05:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E2A13A3F2;
	Thu, 23 May 2024 05:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pcj8Pemx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="pcj8Pemx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C70C2374E
	for <linux-btrfs@vger.kernel.org>; Thu, 23 May 2024 05:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716440635; cv=none; b=E2WHrvADTkAQpY6JzVrucPy/b9BjeH495eaY/Vuz/EqbSbf9PEGyiXtHzNNzco4xGnPuMrMaxK8QieLXqA6HbE47EXpjjdeYL2lyacbJf58ZEDBYf77wKaxPQMeVfJOY8ApqySIe5RYGQEdV8D1XuHrNFTzvyTVzV+FwjRKLaC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716440635; c=relaxed/simple;
	bh=Sl+xHSwta/NNrJJL/gDBq2lGSAQbAhdYcHU4ecDeAww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YeKWorNUu1uXELLDBTCuVotwgESyqKguAZYAIaJLmNt/Y6TA0sx5tial5WxsQKakgM4lGxjGV0xNMBa6j9rgJYSf2Zz2fZfaxo3klfYFCJP7KIu0SO192/iwqly15DqgwvYi/+0sc+KsCs/Vl/WzZcj5UgKDXBUrZuvN4GwZO0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pcj8Pemx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=pcj8Pemx; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 979C1220E2;
	Thu, 23 May 2024 05:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716440631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NvwrWw9wyZMJGtYTRZJPPXupBJk+7Srijztxumo/d0U=;
	b=pcj8Pemx4YylydwjTvrtrSG4/FH9hZUhcW2wr7AUDBZATQUV+JRRJeWW9JxXT56hkIMhOL
	Bx7/dQ/PKvQsf+upX288TFXcBYl0ngSxjxlZKmAZqy9rWt25zwfSmD9EkdOySs+KkBOR7C
	BouMAsS6ihFO2qTZcTn4ZWVEInA6UZI=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1716440631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NvwrWw9wyZMJGtYTRZJPPXupBJk+7Srijztxumo/d0U=;
	b=pcj8Pemx4YylydwjTvrtrSG4/FH9hZUhcW2wr7AUDBZATQUV+JRRJeWW9JxXT56hkIMhOL
	Bx7/dQ/PKvQsf+upX288TFXcBYl0ngSxjxlZKmAZqy9rWt25zwfSmD9EkdOySs+KkBOR7C
	BouMAsS6ihFO2qTZcTn4ZWVEInA6UZI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 691F413A6B;
	Thu, 23 May 2024 05:03:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sLd8BzbOTmZPegAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 23 May 2024 05:03:50 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v3 01/11] btrfs: rename extent_map::orig_block_len to disk_num_bytes
Date: Thu, 23 May 2024 14:33:20 +0930
Message-ID: <2f48e58947cdc6e0b82b6a1c246068e78ff6be8e.1716440169.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <cover.1716440169.git.wqu@suse.com>
References: <cover.1716440169.git.wqu@suse.com>
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]

This would make it very obvious that the member just matches
btrfs_file_extent_item::disk_num_bytes.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_map.c | 16 ++++++++--------
 fs/btrfs/extent_map.h |  2 +-
 fs/btrfs/file-item.c  |  4 ++--
 fs/btrfs/file.c       |  2 +-
 fs/btrfs/inode.c      | 12 ++++++------
 fs/btrfs/tree-log.c   |  4 ++--
 6 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 35e163152dbc..a9d60d1eade9 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -785,14 +785,14 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
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
 
@@ -817,8 +817,8 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 			split->generation = gen;
 
 			if (em->block_start < EXTENT_MAP_LAST_BYTE) {
-				split->orig_block_len = max(em->block_len,
-						    em->orig_block_len);
+				split->disk_num_bytes = max(em->block_len,
+							    em->disk_num_bytes);
 
 				split->ram_bytes = em->ram_bytes;
 				if (compressed) {
@@ -835,7 +835,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 				split->ram_bytes = split->len;
 				split->orig_start = split->start;
 				split->block_len = 0;
-				split->orig_block_len = 0;
+				split->disk_num_bytes = 0;
 			}
 
 			if (extent_map_in_tree(em)) {
@@ -992,7 +992,7 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	split_pre->orig_start = split_pre->start;
 	split_pre->block_start = new_logical;
 	split_pre->block_len = split_pre->len;
-	split_pre->orig_block_len = split_pre->block_len;
+	split_pre->disk_num_bytes = split_pre->block_len;
 	split_pre->ram_bytes = split_pre->len;
 	split_pre->flags = flags;
 	split_pre->generation = em->generation;
@@ -1010,7 +1010,7 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	split_mid->orig_start = split_mid->start;
 	split_mid->block_start = em->block_start + pre;
 	split_mid->block_len = split_mid->len;
-	split_mid->orig_block_len = split_mid->block_len;
+	split_mid->disk_num_bytes = split_mid->block_len;
 	split_mid->ram_bytes = split_mid->len;
 	split_mid->flags = flags;
 	split_mid->generation = em->generation;
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 9144721b88a5..2b7bbffd594b 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -74,7 +74,7 @@ struct extent_map {
 	 * The full on-disk extent length, matching
 	 * btrfs_file_extent_item::disk_num_bytes.
 	 */
-	u64 orig_block_len;
+	u64 disk_num_bytes;
 
 	/*
 	 * The decompressed size of the whole on-disk extent, matching
diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index f3ed78e21fa4..430dce44ebd2 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1295,7 +1295,7 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 		em->len = btrfs_file_extent_end(path) - extent_start;
 		em->orig_start = extent_start -
 			btrfs_file_extent_offset(leaf, fi);
-		em->orig_block_len = btrfs_file_extent_disk_num_bytes(leaf, fi);
+		em->disk_num_bytes = btrfs_file_extent_disk_num_bytes(leaf, fi);
 		bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
 		if (bytenr == 0) {
 			em->block_start = EXTENT_MAP_HOLE;
@@ -1304,7 +1304,7 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 		if (compress_type != BTRFS_COMPRESS_NONE) {
 			extent_map_set_compression(em, compress_type);
 			em->block_start = bytenr;
-			em->block_len = em->orig_block_len;
+			em->block_len = em->disk_num_bytes;
 		} else {
 			bytenr += btrfs_file_extent_offset(leaf, fi);
 			em->block_start = bytenr;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index af58a1b33498..a216a0fdf58d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2351,7 +2351,7 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 
 		hole_em->block_start = EXTENT_MAP_HOLE;
 		hole_em->block_len = 0;
-		hole_em->orig_block_len = 0;
+		hole_em->disk_num_bytes = 0;
 		hole_em->generation = trans->transid;
 
 		ret = btrfs_replace_extent_map_range(inode, hole_em, true);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b4410b463c6a..7148da50e435 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -139,7 +139,7 @@ static noinline int run_delalloc_cow(struct btrfs_inode *inode,
 				     bool pages_dirty);
 static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 				       u64 len, u64 orig_start, u64 block_start,
-				       u64 block_len, u64 orig_block_len,
+				       u64 block_len, u64 disk_num_bytes,
 				       u64 ram_bytes, int compress_type,
 				       int type);
 
@@ -5001,7 +5001,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 
 			hole_em->block_start = EXTENT_MAP_HOLE;
 			hole_em->block_len = 0;
-			hole_em->orig_block_len = 0;
+			hole_em->disk_num_bytes = 0;
 			hole_em->ram_bytes = hole_size;
 			hole_em->generation = btrfs_get_fs_generation(fs_info);
 
@@ -7330,7 +7330,7 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 /* The callers of this must take lock_extent() */
 static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 				       u64 len, u64 orig_start, u64 block_start,
-				       u64 block_len, u64 orig_block_len,
+				       u64 block_len, u64 disk_num_bytes,
 				       u64 ram_bytes, int compress_type,
 				       int type)
 {
@@ -7362,7 +7362,7 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 		ASSERT(block_len == len);
 
 		/* COW results a new extent matching our file extent size. */
-		ASSERT(orig_block_len == len);
+		ASSERT(disk_num_bytes == len);
 		ASSERT(ram_bytes == len);
 
 		/* Since it's a new extent, we should not have any offset. */
@@ -7389,7 +7389,7 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 	em->len = len;
 	em->block_len = block_len;
 	em->block_start = block_start;
-	em->orig_block_len = orig_block_len;
+	em->disk_num_bytes = disk_num_bytes;
 	em->ram_bytes = ram_bytes;
 	em->generation = -1;
 	em->flags |= EXTENT_FLAG_PINNED;
@@ -9614,7 +9614,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		em->len = ins.offset;
 		em->block_start = ins.objectid;
 		em->block_len = ins.offset;
-		em->orig_block_len = ins.offset;
+		em->disk_num_bytes = ins.offset;
 		em->ram_bytes = ins.offset;
 		em->flags |= EXTENT_FLAG_PREALLOC;
 		em->generation = trans->transid;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 51a167559ae8..f237b5ed80ec 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4651,7 +4651,7 @@ static int log_extent_csums(struct btrfs_trans_handle *trans,
 	/* If we're compressed we have to save the entire range of csums. */
 	if (extent_map_is_compressed(em)) {
 		csum_offset = 0;
-		csum_len = max(em->block_len, em->orig_block_len);
+		csum_len = max(em->block_len, em->disk_num_bytes);
 	} else {
 		csum_offset = mod_start - em->start;
 		csum_len = mod_len;
@@ -4701,7 +4701,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	else
 		btrfs_set_stack_file_extent_type(&fi, BTRFS_FILE_EXTENT_REG);
 
-	block_len = max(em->block_len, em->orig_block_len);
+	block_len = max(em->block_len, em->disk_num_bytes);
 	compress_type = extent_map_compression(em);
 	if (compress_type != BTRFS_COMPRESS_NONE) {
 		btrfs_set_stack_file_extent_disk_bytenr(&fi, em->block_start);
-- 
2.45.1


