Return-Path: <linux-btrfs+bounces-14202-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEF5AC2D08
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 04:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AA5C7AC552
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 May 2025 02:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15348192580;
	Sat, 24 May 2025 02:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KfTcho6G";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="KfTcho6G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A4B18BB8E
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748052537; cv=none; b=rqPYO6kruX1L5KQNIBzMaYPYT6AVGXTWuLAh69VnKl78EjRZRlbCNb047zHa4QjZRqV8+Sf7KMk2wUCP+zmo8uM/4qA+S/Q5xdrsaCk24wo9wQXR+d0RBTZRqkHPkHk6WkhicgJA0CzIt31Po2BTnuR4F0g3ygSxpOd9qFpZpns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748052537; c=relaxed/simple;
	bh=kaF3U25BrDpraxvlttTx22H/vQSWmjftyN1AKsOUeWU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOC3A+RMhve5wPxZYlXDwb9FXhBE9mkTEA9ikLtM40fvMhb60g5Mb8k/jYm33ctgtTTVz7Vf32uLTirPGJtVHnJT+V6xQf6gdNNjqsg07fpHeHxXB5O3iuz+5gaIQCZ9iUB342N4bbcqaAAkFd42N1rupKv2O8jrlGUrVU6WXCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KfTcho6G; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=KfTcho6G; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 172701FCE9
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748052521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wkn8ofpAo3ozUvImLolkPrlvXjaxpqIaOynciPd8X74=;
	b=KfTcho6G+jxegXmTsyGtIOi2iwfYT3+eOi0m/KNMQ8ca7YFyjY/xlQefHVyXRjOqd0+vC0
	P656psm3iIX5xh6u1q+JUZioXRC9+vvB6B3gsVE/TgfZv7mcOrVT8idV9FoUeVu8dpnW4G
	TZHF2iQ2Ft0jKvUXWg6R4ml05AwIOvY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1748052521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wkn8ofpAo3ozUvImLolkPrlvXjaxpqIaOynciPd8X74=;
	b=KfTcho6G+jxegXmTsyGtIOi2iwfYT3+eOi0m/KNMQ8ca7YFyjY/xlQefHVyXRjOqd0+vC0
	P656psm3iIX5xh6u1q+JUZioXRC9+vvB6B3gsVE/TgfZv7mcOrVT8idV9FoUeVu8dpnW4G
	TZHF2iQ2Ft0jKvUXWg6R4ml05AwIOvY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B3201373E
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GI6sAigqMWjYXQAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Sat, 24 May 2025 02:08:40 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 6/9] btrfs-progs: convert: simplify insert_temp_extent_item() and insert_temp_block_group()
Date: Sat, 24 May 2025 11:38:11 +0930
Message-ID: <2dc5873a5ccaaf3261c98588cfb616d542fbd7cf.1748049973.git.wqu@suse.com>
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
X-Spam-Flag: NO
X-Spam-Score: 0.20
X-Spamd-Result: default: False [0.20 / 50.00];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	RCVD_TLS_ALL(0.00)[]

These functions require parameters @slot and @itemoff to record where the
next item should land.

But this is overkilled, as after inserting an item, the temporary extent
buffer will have its header nritems and the item pointer updated.

We can use that header nritems and item pointer to get where the next
item should land.

This removes the external counter to record @slot and @itemoff.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/common.c | 72 +++++++++++++++++++++++-------------------------
 1 file changed, 35 insertions(+), 37 deletions(-)

diff --git a/convert/common.c b/convert/common.c
index a9d3b395b37b..d062a1306c9e 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -567,8 +567,7 @@ out:
  */
 static int insert_temp_extent_item(int fd, struct extent_buffer *buf,
 				   struct btrfs_mkfs_config *cfg,
-				   int *slot, u32 *itemoff, u64 bytenr,
-				   u64 ref_root)
+				   u64 bytenr, u64 ref_root)
 {
 	struct extent_buffer *tmp;
 	struct btrfs_extent_item *ei;
@@ -576,6 +575,8 @@ static int insert_temp_extent_item(int fd, struct extent_buffer *buf,
 	struct btrfs_disk_key disk_key;
 	struct btrfs_disk_key tree_info_key;
 	struct btrfs_tree_block_info *info;
+	u32 slot = btrfs_header_nritems(buf);
+	u32 itemoff = get_item_offset(buf, cfg);
 	int itemsize;
 	int skinny_metadata = cfg->features.incompat_flags &
 			      BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA;
@@ -587,8 +588,8 @@ static int insert_temp_extent_item(int fd, struct extent_buffer *buf,
 		itemsize = sizeof(*ei) + sizeof(*iref) +
 			   sizeof(struct btrfs_tree_block_info);
 
-	btrfs_set_header_nritems(buf, *slot + 1);
-	*(itemoff) -= itemsize;
+	btrfs_set_header_nritems(buf, slot + 1);
+	itemoff -= itemsize;
 
 	if (skinny_metadata) {
 		btrfs_set_disk_key_type(&disk_key, BTRFS_METADATA_ITEM_KEY);
@@ -599,11 +600,11 @@ static int insert_temp_extent_item(int fd, struct extent_buffer *buf,
 	}
 	btrfs_set_disk_key_objectid(&disk_key, bytenr);
 
-	btrfs_set_item_key(buf, &disk_key, *slot);
-	btrfs_set_item_offset(buf, *slot, *itemoff);
-	btrfs_set_item_size(buf, *slot, itemsize);
+	btrfs_set_item_key(buf, &disk_key, slot);
+	btrfs_set_item_offset(buf, slot, itemoff);
+	btrfs_set_item_size(buf, slot, itemsize);
 
-	ei = btrfs_item_ptr(buf, *slot, struct btrfs_extent_item);
+	ei = btrfs_item_ptr(buf, slot, struct btrfs_extent_item);
 	btrfs_set_extent_refs(buf, ei, 1);
 	btrfs_set_extent_generation(buf, ei, 1);
 	btrfs_set_extent_flags(buf, ei, BTRFS_EXTENT_FLAG_TREE_BLOCK);
@@ -618,7 +619,6 @@ static int insert_temp_extent_item(int fd, struct extent_buffer *buf,
 					 BTRFS_TREE_BLOCK_REF_KEY);
 	btrfs_set_extent_inline_ref_offset(buf, iref, ref_root);
 
-	(*slot)++;
 	if (skinny_metadata)
 		return 0;
 
@@ -654,28 +654,28 @@ out:
 
 static void insert_temp_block_group(struct extent_buffer *buf,
 				   struct btrfs_mkfs_config *cfg,
-				   int *slot, u32 *itemoff,
 				   u64 bytenr, u64 len, u64 used, u64 flag)
 {
 	struct btrfs_block_group_item bgi;
 	struct btrfs_disk_key disk_key;
+	u32 slot = btrfs_header_nritems(buf);
+	u32 itemoff = get_item_offset(buf, cfg);
 
-	btrfs_set_header_nritems(buf, *slot + 1);
-	(*itemoff) -= sizeof(bgi);
+	btrfs_set_header_nritems(buf, slot + 1);
+	itemoff -= sizeof(bgi);
 	btrfs_set_disk_key_type(&disk_key, BTRFS_BLOCK_GROUP_ITEM_KEY);
 	btrfs_set_disk_key_objectid(&disk_key, bytenr);
 	btrfs_set_disk_key_offset(&disk_key, len);
-	btrfs_set_item_key(buf, &disk_key, *slot);
-	btrfs_set_item_offset(buf, *slot, *itemoff);
-	btrfs_set_item_size(buf, *slot, sizeof(bgi));
+	btrfs_set_item_key(buf, &disk_key, slot);
+	btrfs_set_item_offset(buf, slot, itemoff);
+	btrfs_set_item_size(buf, slot, sizeof(bgi));
 
 	btrfs_set_stack_block_group_flags(&bgi, flag);
 	btrfs_set_stack_block_group_used(&bgi, used);
 	btrfs_set_stack_block_group_chunk_objectid(&bgi,
 			BTRFS_FIRST_CHUNK_TREE_OBJECTID);
-	write_extent_buffer(buf, &bgi, btrfs_item_ptr_offset(buf, *slot),
+	write_extent_buffer(buf, &bgi, btrfs_item_ptr_offset(buf, slot),
 			    sizeof(bgi));
-	(*slot)++;
 }
 
 static int setup_temp_extent_tree(int fd, struct btrfs_mkfs_config *cfg,
@@ -684,8 +684,6 @@ static int setup_temp_extent_tree(int fd, struct btrfs_mkfs_config *cfg,
 				  u64 fs_bytenr, u64 csum_bytenr)
 {
 	struct extent_buffer *buf = NULL;
-	u32 itemoff = cfg->leaf_data_size;
-	int slot = 0;
 	int ret;
 
 	/*
@@ -704,39 +702,39 @@ static int setup_temp_extent_tree(int fd, struct btrfs_mkfs_config *cfg,
 	if (ret < 0)
 		goto out;
 
-	ret = insert_temp_extent_item(fd, buf, cfg, &slot, &itemoff,
-			chunk_bytenr, BTRFS_CHUNK_TREE_OBJECTID);
+	ret = insert_temp_extent_item(fd, buf, cfg,  chunk_bytenr,
+				      BTRFS_CHUNK_TREE_OBJECTID);
 	if (ret < 0)
 		goto out;
 
-	insert_temp_block_group(buf, cfg, &slot, &itemoff, chunk_bytenr,
-			BTRFS_MKFS_SYSTEM_GROUP_SIZE, cfg->nodesize,
-			BTRFS_BLOCK_GROUP_SYSTEM);
+	insert_temp_block_group(buf, cfg, chunk_bytenr,
+				BTRFS_MKFS_SYSTEM_GROUP_SIZE, cfg->nodesize,
+				BTRFS_BLOCK_GROUP_SYSTEM);
 
-	ret = insert_temp_extent_item(fd, buf, cfg, &slot, &itemoff,
-			root_bytenr, BTRFS_ROOT_TREE_OBJECTID);
+	ret = insert_temp_extent_item(fd, buf, cfg, root_bytenr,
+				      BTRFS_ROOT_TREE_OBJECTID);
 	if (ret < 0)
 		goto out;
 
 	/* 5 tree block used, root, extent, dev, fs and csum*/
-	insert_temp_block_group(buf, cfg, &slot, &itemoff, root_bytenr,
-			BTRFS_CONVERT_META_GROUP_SIZE, cfg->nodesize * 5,
-			BTRFS_BLOCK_GROUP_METADATA);
+	insert_temp_block_group(buf, cfg, root_bytenr,
+				BTRFS_CONVERT_META_GROUP_SIZE, cfg->nodesize * 5,
+				BTRFS_BLOCK_GROUP_METADATA);
 
-	ret = insert_temp_extent_item(fd, buf, cfg, &slot, &itemoff,
-			extent_bytenr, BTRFS_EXTENT_TREE_OBJECTID);
+	ret = insert_temp_extent_item(fd, buf, cfg, extent_bytenr,
+				      BTRFS_EXTENT_TREE_OBJECTID);
 	if (ret < 0)
 		goto out;
-	ret = insert_temp_extent_item(fd, buf, cfg, &slot, &itemoff,
-			dev_bytenr, BTRFS_DEV_TREE_OBJECTID);
+	ret = insert_temp_extent_item(fd, buf, cfg, dev_bytenr,
+				      BTRFS_DEV_TREE_OBJECTID);
 	if (ret < 0)
 		goto out;
-	ret = insert_temp_extent_item(fd, buf, cfg, &slot, &itemoff,
-			fs_bytenr, BTRFS_FS_TREE_OBJECTID);
+	ret = insert_temp_extent_item(fd, buf, cfg, fs_bytenr,
+				      BTRFS_FS_TREE_OBJECTID);
 	if (ret < 0)
 		goto out;
-	ret = insert_temp_extent_item(fd, buf, cfg, &slot, &itemoff,
-			csum_bytenr, BTRFS_CSUM_TREE_OBJECTID);
+	ret = insert_temp_extent_item(fd, buf, cfg, csum_bytenr,
+				      BTRFS_CSUM_TREE_OBJECTID);
 	if (ret < 0)
 		goto out;
 
-- 
2.49.0


