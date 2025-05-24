Return-Path: <linux-btrfs+bounces-14207-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 319FAAC2D0B
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 04:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67FE4E17E9
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 02:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC5A192580;
	Sat, 24 May 2025 02:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="drgvksSD";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="drgvksSD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A231118F2FC
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748052557; cv=none; b=rjq6rDtWQMNeWfSI0hH7RDidrC4YFtYSNM446C071yPv6aOVWFSerNMWso1uHm5b6TnDbF2eA/5C3tift9OrQUCySQ60QXxjAp75HcZdmRSxY/8H51MT+KhEQUmwqiAJFD4B7lssASkQtQrTbsQNVOz6er9fKju1ClqpuSkQK2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748052557; c=relaxed/simple;
	bh=7R5Ej/u/Z3mi+xviiXh9OGAGs27rduMj4iS6VXF8qXM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTG6oEUHNE7dhubRVZjDeu95sq5AbIW7JTLEsvoCX+J0+xD5aR2NzVfi8eCYTWGK5ZwIUb9v6Y9sqM74SN+xo9JMKsg5ggXK2/mdDX1Ybnyg1Iau3d+d72f+ASfi+qx7QEAUBRn/0xKLlcV3650ruZ51lfeOpX6W1FJNU5289u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=drgvksSD; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=drgvksSD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A13991FCEB
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748052524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2PV+IF1au1cN2t7Yzee4llP3G+e5Xg6VVwQgHKk6qo8=;
	b=drgvksSDIfyoMUZ5z8YcIMDOGpkfEE56oOfu+QMxNfE1jaZKyIfiX+69t4chISg+BFkKub
	uGkEaLAZBoM/BATRhN1R0BHzx4+1GudVWTC1hWxAHGQqvR/LEaewvOFWDtPLi6Exyjm3Ss
	Oy9Ox37JrUVHtUm3SEDlU2ub8Yn1BhY=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=drgvksSD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748052524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2PV+IF1au1cN2t7Yzee4llP3G+e5Xg6VVwQgHKk6qo8=;
	b=drgvksSDIfyoMUZ5z8YcIMDOGpkfEE56oOfu+QMxNfE1jaZKyIfiX+69t4chISg+BFkKub
	uGkEaLAZBoM/BATRhN1R0BHzx4+1GudVWTC1hWxAHGQqvR/LEaewvOFWDtPLi6Exyjm3Ss
	Oy9Ox37JrUVHtUm3SEDlU2ub8Yn1BhY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2C151373E
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EFQ7KSsqMWjYXQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:43 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 8/9] btrfs-progs: convert: implement the block group tree support properly
Date: Sat, 24 May 2025 11:38:14 +0930
Message-ID: <92d9f0c8f845b1f664c95392065604e0bdd928f0.1748049973.git.wqu@suse.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1748049973.git.wqu@suse.com>
References: <cover.1748049973.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spam-Score: -0.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A13991FCEB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.01 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid,suse.com:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.com:+]

Previously there are some problems related to btrfs-convert bgt support,
that it doesn't work at all, caused by the following reasons:

- We never update the super block with extra compat ro flags
  Even if we set "-O bgt" flags, it will not set the compat ro flags,
  and everything just go non-bgt routine.

  Meanwhile other compat ro flags are for free-space-tree, and
  free-space-tree is rebuilt after the full convert is done.
  Thus this bug won't cause any problem for fst features, but only
  affecting bgt so far.

- No extra handling to create block group tree

Fix above problems by:

- Set the proper compat RO flag for the temporary super block
  We should only set the compat RO flags except the two FST related
  bits.
  As FST is handled after conversion, we should not set the flag at that
  timing.

- Add block group tree root item and its backrefs
  So the initial temporary fs will have a proper block group tree.

  The only tricky part is for the extent tree population, where we have
  to put all block group items into the block group tree other than the
  extent tree.

With these two points addressed, now block group tree can be properly
enabled for btrfs-convert.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/common.c | 108 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 85 insertions(+), 23 deletions(-)

diff --git a/convert/common.c b/convert/common.c
index b00d69cedd68..c2210f2686b3 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -150,6 +150,13 @@ static int setup_temp_super(int fd, struct btrfs_mkfs_config *cfg,
 	btrfs_set_super_chunk_root(&super, chunk_bytenr);
 	btrfs_set_super_cache_generation(&super, -1);
 	btrfs_set_super_incompat_flags(&super, cfg->features.incompat_flags);
+	/*
+	 * Do not set fst related flags yet, it will be handled after
+	 * the fs is converted.
+	 */
+	btrfs_set_super_compat_ro_flags(&super, cfg->features.compat_ro_flags &
+			~(BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
+			  BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID));
 	if (cfg->label)
 		strncpy_null(super.label, cfg->label, BTRFS_LABEL_SIZE);
 
@@ -200,6 +207,12 @@ static u32 get_item_offset(const struct extent_buffer *eb,
 		return cfg->leaf_data_size;
 }
 
+static bool btrfs_is_bgt(const struct btrfs_mkfs_config *cfg)
+{
+	return cfg->features.compat_ro_flags &
+	       BTRFS_FEATURE_COMPAT_RO_BLOCK_GROUP_TREE;
+}
+
 static void insert_temp_root_item(struct extent_buffer *buf,
 				  struct btrfs_mkfs_config *cfg,
 				  u64 objectid, u64 bytenr)
@@ -260,7 +273,8 @@ static inline int write_temp_extent_buffer(int fd, struct extent_buffer *buf,
 
 static int setup_temp_root_tree(int fd, struct btrfs_mkfs_config *cfg,
 				u64 root_bytenr, u64 extent_bytenr,
-				u64 dev_bytenr, u64 fs_bytenr, u64 csum_bytenr)
+				u64 dev_bytenr, u64 fs_bytenr, u64 csum_bytenr,
+				u64 bgt_bytenr)
 {
 	struct extent_buffer *buf = NULL;
 	int ret;
@@ -270,7 +284,8 @@ static int setup_temp_root_tree(int fd, struct btrfs_mkfs_config *cfg,
 	 * bad key order.
 	 */
 	UASSERT(root_bytenr < extent_bytenr && extent_bytenr < dev_bytenr &&
-	        dev_bytenr < fs_bytenr && fs_bytenr < csum_bytenr);
+	        dev_bytenr < fs_bytenr && fs_bytenr < csum_bytenr &&
+		csum_bytenr < bgt_bytenr);
 	buf = malloc(sizeof(*buf) + cfg->nodesize);
 	if (!buf)
 		return -ENOMEM;
@@ -284,6 +299,9 @@ static int setup_temp_root_tree(int fd, struct btrfs_mkfs_config *cfg,
 	insert_temp_root_item(buf, cfg, BTRFS_DEV_TREE_OBJECTID, dev_bytenr);
 	insert_temp_root_item(buf, cfg, BTRFS_FS_TREE_OBJECTID, fs_bytenr);
 	insert_temp_root_item(buf, cfg, BTRFS_CSUM_TREE_OBJECTID, csum_bytenr);
+	if (btrfs_is_bgt(cfg))
+		insert_temp_root_item(buf, cfg, BTRFS_BLOCK_GROUP_TREE_OBJECTID,
+				      bgt_bytenr);
 
 	ret = write_temp_extent_buffer(fd, buf, root_bytenr, cfg);
 out:
@@ -658,9 +676,12 @@ static void insert_temp_block_group(struct extent_buffer *buf,
 static int setup_temp_extent_tree(int fd, struct btrfs_mkfs_config *cfg,
 				  u64 chunk_bytenr, u64 root_bytenr,
 				  u64 extent_bytenr, u64 dev_bytenr,
-				  u64 fs_bytenr, u64 csum_bytenr)
+				  u64 fs_bytenr, u64 csum_bytenr,
+				  u64 bgt_bytenr)
 {
-	struct extent_buffer *buf = NULL;
+	struct extent_buffer *extent_buf = NULL;
+	struct extent_buffer *bg_buf = NULL;
+	const bool is_bgt = btrfs_is_bgt(cfg);
 	int ret;
 
 	/*
@@ -669,55 +690,85 @@ static int setup_temp_extent_tree(int fd, struct btrfs_mkfs_config *cfg,
 	 */
 	UASSERT(chunk_bytenr < root_bytenr && root_bytenr < extent_bytenr &&
 		extent_bytenr < dev_bytenr && dev_bytenr < fs_bytenr &&
-		fs_bytenr < csum_bytenr);
-	buf = malloc(sizeof(*buf) + cfg->nodesize);
-	if (!buf)
-		return -ENOMEM;
+		fs_bytenr < csum_bytenr && csum_bytenr < bgt_bytenr);
+	extent_buf = malloc(sizeof(*extent_buf) + cfg->nodesize);
+	if (!extent_buf) {
+		ret = -ENOMEM;
+		goto out;
+	}
 
-	ret = setup_temp_extent_buffer(buf, cfg, extent_bytenr,
+	ret = setup_temp_extent_buffer(extent_buf, cfg, extent_bytenr,
 				       BTRFS_EXTENT_TREE_OBJECTID);
 	if (ret < 0)
 		goto out;
 
-	ret = insert_temp_extent_item(fd, buf, cfg,  chunk_bytenr,
+	if (is_bgt) {
+		bg_buf = malloc(sizeof(*bg_buf) + cfg->nodesize);
+		if (!bg_buf) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		ret = setup_temp_extent_buffer(bg_buf, cfg, bgt_bytenr,
+					       BTRFS_BLOCK_GROUP_TREE_OBJECTID);
+		if (ret < 0)
+			goto out;
+	}
+
+	ret = insert_temp_extent_item(fd, extent_buf, cfg,  chunk_bytenr,
 				      BTRFS_CHUNK_TREE_OBJECTID);
 	if (ret < 0)
 		goto out;
 
-	insert_temp_block_group(buf, cfg, chunk_bytenr,
+	insert_temp_block_group(is_bgt ? bg_buf : extent_buf, cfg, chunk_bytenr,
 				BTRFS_MKFS_SYSTEM_GROUP_SIZE, cfg->nodesize,
 				BTRFS_BLOCK_GROUP_SYSTEM);
 
-	ret = insert_temp_extent_item(fd, buf, cfg, root_bytenr,
+	ret = insert_temp_extent_item(fd, extent_buf, cfg, root_bytenr,
 				      BTRFS_ROOT_TREE_OBJECTID);
 	if (ret < 0)
 		goto out;
 
-	/* 5 tree block used, root, extent, dev, fs and csum*/
-	insert_temp_block_group(buf, cfg, root_bytenr,
-				BTRFS_CONVERT_META_GROUP_SIZE, cfg->nodesize * 5,
+	/*
+	 * 5 tree block used, root, extent, dev, fs and csum.
+	 * Plus bg tree if specified.
+	 */
+	insert_temp_block_group(is_bgt ? bg_buf : extent_buf, cfg, root_bytenr,
+				BTRFS_CONVERT_META_GROUP_SIZE,
+				is_bgt ? cfg->nodesize * 6 : cfg->nodesize * 5,
 				BTRFS_BLOCK_GROUP_METADATA);
 
-	ret = insert_temp_extent_item(fd, buf, cfg, extent_bytenr,
+	ret = insert_temp_extent_item(fd, extent_buf, cfg, extent_bytenr,
 				      BTRFS_EXTENT_TREE_OBJECTID);
 	if (ret < 0)
 		goto out;
-	ret = insert_temp_extent_item(fd, buf, cfg, dev_bytenr,
+	ret = insert_temp_extent_item(fd, extent_buf, cfg, dev_bytenr,
 				      BTRFS_DEV_TREE_OBJECTID);
 	if (ret < 0)
 		goto out;
-	ret = insert_temp_extent_item(fd, buf, cfg, fs_bytenr,
+	ret = insert_temp_extent_item(fd, extent_buf, cfg, fs_bytenr,
 				      BTRFS_FS_TREE_OBJECTID);
 	if (ret < 0)
 		goto out;
-	ret = insert_temp_extent_item(fd, buf, cfg, csum_bytenr,
+	ret = insert_temp_extent_item(fd, extent_buf, cfg, csum_bytenr,
 				      BTRFS_CSUM_TREE_OBJECTID);
 	if (ret < 0)
 		goto out;
+	if (btrfs_is_bgt(cfg)) {
+		ret = insert_temp_extent_item(fd, extent_buf, cfg, bgt_bytenr,
+				      BTRFS_BLOCK_GROUP_TREE_OBJECTID);
+		if (ret < 0)
+			goto out;
+	}
+
+	ret = write_temp_extent_buffer(fd, extent_buf, extent_bytenr, cfg);
+	if (ret < 0)
+		goto out;
+	if (is_bgt)
+		ret = write_temp_extent_buffer(fd, bg_buf, bgt_bytenr, cfg);
 
-	ret = write_temp_extent_buffer(fd, buf, extent_bytenr, cfg);
 out:
-	free(buf);
+	free(extent_buf);
+	free(bg_buf);
 	return ret;
 }
 
@@ -751,6 +802,7 @@ int make_convert_btrfs(int fd, struct btrfs_mkfs_config *cfg,
 {
 	struct cache_tree *free_space = &cctx->free_space;
 	struct cache_tree *used_space = &cctx->used_space;
+	const bool is_bgt = btrfs_is_bgt(cfg);
 	u64 sys_chunk_start;
 	u64 meta_chunk_start;
 	/* chunk tree bytenr, in system chunk */
@@ -761,6 +813,7 @@ int make_convert_btrfs(int fd, struct btrfs_mkfs_config *cfg,
 	u64 dev_bytenr;
 	u64 fs_bytenr;
 	u64 csum_bytenr;
+	u64 bgt_bytenr = (u64)-1;
 	int ret;
 
 	/* Source filesystem must be opened, checked and analyzed in advance */
@@ -814,6 +867,7 @@ int make_convert_btrfs(int fd, struct btrfs_mkfs_config *cfg,
 	 *  | +nodesize * 2	| device root	|
 	 *  | +nodesize * 3	| fs tree	|
 	 *  | +nodesize * 4	| csum tree	|
+	 *  | +nodesize * 5	| bg tree	| (Optional)
 	 *  -------------------------------------
 	 * Inside the allocated system chunk, the layout will be:
 	 *  | offset		| contents	|
@@ -827,13 +881,15 @@ int make_convert_btrfs(int fd, struct btrfs_mkfs_config *cfg,
 	dev_bytenr = meta_chunk_start + cfg->nodesize * 2;
 	fs_bytenr = meta_chunk_start + cfg->nodesize * 3;
 	csum_bytenr = meta_chunk_start + cfg->nodesize * 4;
+	if (is_bgt)
+		bgt_bytenr = meta_chunk_start + cfg->nodesize * 5;
 
 	ret = setup_temp_super(fd, cfg, root_bytenr, chunk_bytenr);
 	if (ret < 0)
 		goto out;
 
 	ret = setup_temp_root_tree(fd, cfg, root_bytenr, extent_bytenr,
-				   dev_bytenr, fs_bytenr, csum_bytenr);
+				   dev_bytenr, fs_bytenr, csum_bytenr, bgt_bytenr);
 	if (ret < 0)
 		goto out;
 	ret = setup_temp_chunk_tree(fd, cfg, sys_chunk_start, meta_chunk_start,
@@ -850,13 +906,19 @@ int make_convert_btrfs(int fd, struct btrfs_mkfs_config *cfg,
 	ret = setup_temp_empty_tree(fd, cfg, csum_bytenr, BTRFS_CSUM_TREE_OBJECTID);
 	if (ret < 0)
 		goto out;
+	if (is_bgt) {
+		ret = setup_temp_empty_tree(fd, cfg, bgt_bytenr,
+					    BTRFS_BLOCK_GROUP_TREE_OBJECTID);
+		if (ret < 0)
+			goto out;
+	}
 	/*
 	 * Setup extent tree last, since it may need to read tree block key
 	 * for non-skinny metadata case.
 	 */
 	ret = setup_temp_extent_tree(fd, cfg, chunk_bytenr, root_bytenr,
 				     extent_bytenr, dev_bytenr, fs_bytenr,
-				     csum_bytenr);
+				     csum_bytenr, bgt_bytenr);
 out:
 	return ret;
 }
-- 
2.49.0


