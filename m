Return-Path: <linux-btrfs+bounces-4701-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D48908BA6CD
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 08:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C991C21F82
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 06:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DD0139D01;
	Fri,  3 May 2024 06:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="tIiY3ERx";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="HYEVKCR8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69F6139CE3
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 06:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714716131; cv=none; b=o2WWyVbzAmaDfRl/vUrY5UAgrDJtifaDtwrHj94/3CMp7msRQrtQd48HtiswkvQq4YDU4u/ZQQCySFm6vsGT7u7tpB8rIZwEKgVV1ZenU5yd4vgYZPseoOO9C/fBxFqaOJRdJQSLpedCgCo0L6Gek/qWPsVskU9aBtRwE97575I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714716131; c=relaxed/simple;
	bh=JXlk0O7SnZFAhpPXiBBpM1+d97A/QDUl522ySP+b2iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdJ6ZVGJAX2Wzt+Sre1z1pKEro/ZAo8DypJUpr9fMmeh6MhVHy4KZnQX499alF4RSum2D77JchZveMN8Tbc1yLf9eiKl0lViKMIGKYfY4q7YPJtEQrwc3dX1Lyu+tM5EzyFqNg6of4zKrCjl9dgOgItPiK6lB2ZZCVpkfqyflyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=tIiY3ERx; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=HYEVKCR8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E41071FDBF;
	Fri,  3 May 2024 06:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714716128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=doaSpPbYrxVB+Ijqlek3R+h0/pFaFk84TYodaGvHOFk=;
	b=tIiY3ERxH+zH5/Nl9ecHRNthE0jQ5J+6G2fFwoSOnMYzDQGI5FD505Q/e0KqXNyVwL9s6y
	G2o9tMzi7PLe9slx4TDzVOpIAGADvL7YnNFRDIoTooW4/ZHirr89Xx6KLjlTDfTStBTEM9
	WMGK7KFeB6yknOOWzUAvD7/kJFE2iIw=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=HYEVKCR8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1714716127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=doaSpPbYrxVB+Ijqlek3R+h0/pFaFk84TYodaGvHOFk=;
	b=HYEVKCR8JAlEXoIuhLONV1LJrK6nQhlIcb3P4mvGXybNzsi8df+ezOlEnDWwK14bjtfqfX
	CAOIG2x8LaNUrr7DzGuGNZYOPMtQtbLphjTGhWcFnjfopUkonc29vJ+OzvhVWtE/D/fSDR
	QD8GqB0ZceMzI5/rBnQ5A7du+ZM8gKo=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AFA0113991;
	Fri,  3 May 2024 06:02:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OPShGN59NGbgawAAD6G6ig
	(envelope-from <wqu@suse.com>); Fri, 03 May 2024 06:02:06 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>
Subject: [PATCH v2 01/11] btrfs: rename extent_map::orig_block_len to disk_num_bytes
Date: Fri,  3 May 2024 15:31:36 +0930
Message-ID: <7721e4ee372d1f2244aeb0c6c2d80070a70d2f5f.1714707707.git.wqu@suse.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <cover.1714707707.git.wqu@suse.com>
References: <cover.1714707707.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E41071FDBF
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.com:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:email]

This would make it very obvious that the member just matches
btrfs_file_extent_item::disk_num_bytes.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_map.c | 16 ++++++++--------
 fs/btrfs/extent_map.h |  2 +-
 fs/btrfs/file-item.c  |  4 ++--
 fs/btrfs/file.c       |  2 +-
 fs/btrfs/inode.c      | 10 +++++-----
 fs/btrfs/tree-log.c   |  6 +++---
 6 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 744e8952abb0..4230dd0f34cc 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -783,14 +783,14 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
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
 
@@ -815,8 +815,8 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 			split->generation = gen;
 
 			if (em->block_start < EXTENT_MAP_LAST_BYTE) {
-				split->orig_block_len = max(em->block_len,
-						    em->orig_block_len);
+				split->disk_num_bytes = max(em->block_len,
+							    em->disk_num_bytes);
 
 				split->ram_bytes = em->ram_bytes;
 				if (compressed) {
@@ -833,7 +833,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode *inode, u64 start, u64 end,
 				split->ram_bytes = split->len;
 				split->orig_start = split->start;
 				split->block_len = 0;
-				split->orig_block_len = 0;
+				split->disk_num_bytes = 0;
 			}
 
 			if (extent_map_in_tree(em)) {
@@ -990,7 +990,7 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	split_pre->orig_start = split_pre->start;
 	split_pre->block_start = new_logical;
 	split_pre->block_len = split_pre->len;
-	split_pre->orig_block_len = split_pre->block_len;
+	split_pre->disk_num_bytes = split_pre->block_len;
 	split_pre->ram_bytes = split_pre->len;
 	split_pre->flags = flags;
 	split_pre->generation = em->generation;
@@ -1008,7 +1008,7 @@ int split_extent_map(struct btrfs_inode *inode, u64 start, u64 len, u64 pre,
 	split_mid->orig_start = split_mid->start;
 	split_mid->block_start = em->block_start + pre;
 	split_mid->block_len = split_mid->len;
-	split_mid->orig_block_len = split_mid->block_len;
+	split_mid->disk_num_bytes = split_mid->block_len;
 	split_mid->ram_bytes = split_mid->len;
 	split_mid->flags = flags;
 	split_mid->generation = em->generation;
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 6d587111f73a..6ea0287b0d61 100644
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
index bce95f871750..2197cfe5443b 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -1294,7 +1294,7 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 		em->len = btrfs_file_extent_end(path) - extent_start;
 		em->orig_start = extent_start -
 			btrfs_file_extent_offset(leaf, fi);
-		em->orig_block_len = btrfs_file_extent_disk_num_bytes(leaf, fi);
+		em->disk_num_bytes = btrfs_file_extent_disk_num_bytes(leaf, fi);
 		bytenr = btrfs_file_extent_disk_bytenr(leaf, fi);
 		if (bytenr == 0) {
 			em->block_start = EXTENT_MAP_HOLE;
@@ -1303,7 +1303,7 @@ void btrfs_extent_item_to_extent_map(struct btrfs_inode *inode,
 		if (compress_type != BTRFS_COMPRESS_NONE) {
 			extent_map_set_compression(em, compress_type);
 			em->block_start = bytenr;
-			em->block_len = em->orig_block_len;
+			em->block_len = em->disk_num_bytes;
 		} else {
 			bytenr += btrfs_file_extent_offset(leaf, fi);
 			em->block_start = bytenr;
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0c7c1b42028e..d3cbd161cd90 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2338,7 +2338,7 @@ static int fill_holes(struct btrfs_trans_handle *trans,
 
 		hole_em->block_start = EXTENT_MAP_HOLE;
 		hole_em->block_len = 0;
-		hole_em->orig_block_len = 0;
+		hole_em->disk_num_bytes = 0;
 		hole_em->generation = trans->transid;
 
 		ret = btrfs_replace_extent_map_range(inode, hole_em, true);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index d0274324c75a..0e5d4517af0e 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4971,7 +4971,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 
 			hole_em->block_start = EXTENT_MAP_HOLE;
 			hole_em->block_len = 0;
-			hole_em->orig_block_len = 0;
+			hole_em->disk_num_bytes = 0;
 			hole_em->ram_bytes = hole_size;
 			hole_em->generation = btrfs_get_fs_generation(fs_info);
 
@@ -7292,7 +7292,7 @@ static int lock_extent_direct(struct inode *inode, u64 lockstart, u64 lockend,
 /* The callers of this must take lock_extent() */
 static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 				       u64 len, u64 orig_start, u64 block_start,
-				       u64 block_len, u64 orig_block_len,
+				       u64 block_len, u64 disk_num_bytes,
 				       u64 ram_bytes, int compress_type,
 				       int type)
 {
@@ -7324,7 +7324,7 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 		ASSERT(block_len == len);
 
 		/* COW results a new extent matching our file extent size. */
-		ASSERT(orig_block_len == len);
+		ASSERT(disk_num_bytes == len);
 		ASSERT(ram_bytes == len);
 
 		/* Since it's a new extent, we should not have any offset. */
@@ -7351,7 +7351,7 @@ static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 start,
 	em->len = len;
 	em->block_len = block_len;
 	em->block_start = block_start;
-	em->orig_block_len = orig_block_len;
+	em->disk_num_bytes = disk_num_bytes;
 	em->ram_bytes = ram_bytes;
 	em->generation = -1;
 	em->flags |= EXTENT_FLAG_PINNED;
@@ -9587,7 +9587,7 @@ static int __btrfs_prealloc_file_range(struct inode *inode, int mode,
 		em->len = ins.offset;
 		em->block_start = ins.objectid;
 		em->block_len = ins.offset;
-		em->orig_block_len = ins.offset;
+		em->disk_num_bytes = ins.offset;
 		em->ram_bytes = ins.offset;
 		em->flags |= EXTENT_FLAG_PREALLOC;
 		em->generation = trans->transid;
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 5146387b416b..83dff4b06c84 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -2874,7 +2874,7 @@ static inline void btrfs_remove_log_ctx(struct btrfs_root *root,
 	mutex_unlock(&root->log_mutex);
 }
 
-/* 
+/*
  * Invoked in log mutex context, or be sure there is no other task which
  * can access the list.
  */
@@ -4648,7 +4648,7 @@ static int log_extent_csums(struct btrfs_trans_handle *trans,
 	/* If we're compressed we have to save the entire range of csums. */
 	if (extent_map_is_compressed(em)) {
 		csum_offset = 0;
-		csum_len = max(em->block_len, em->orig_block_len);
+		csum_len = max(em->block_len, em->disk_num_bytes);
 	} else {
 		csum_offset = mod_start - em->start;
 		csum_len = mod_len;
@@ -4698,7 +4698,7 @@ static int log_one_extent(struct btrfs_trans_handle *trans,
 	else
 		btrfs_set_stack_file_extent_type(&fi, BTRFS_FILE_EXTENT_REG);
 
-	block_len = max(em->block_len, em->orig_block_len);
+	block_len = max(em->block_len, em->disk_num_bytes);
 	compress_type = extent_map_compression(em);
 	if (compress_type != BTRFS_COMPRESS_NONE) {
 		btrfs_set_stack_file_extent_disk_bytenr(&fi, em->block_start);
-- 
2.45.0


