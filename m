Return-Path: <linux-btrfs+bounces-9332-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DD4D9BC5F4
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2024 07:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD65C1F22E70
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2024 06:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB14E1FCC73;
	Tue,  5 Nov 2024 06:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MPONSHuO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MPONSHuO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D121714A0
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Nov 2024 06:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730789322; cv=none; b=gDUfL9yNywf7sw+iiykH4S2J5CIwj8SfFiWEdeCsEpOivWk4x3ZkqaO1JiWd3AsRk4zvmE7AoT0lC2USw1nfke4DFuaAfVjDEtJRaAC0NqWjkasFFLfN0eJmDmonmjcjcO72LjU+fcNOfLOk7T3lComLYZPe5NAS0Q2lSYK2zwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730789322; c=relaxed/simple;
	bh=v0QeLkMeQIGiWqLMX28s6BLEgndE0d0qz+JPEkFO6+E=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHmOkteP7/89rlYe6xAip/3kLM65A0VJO6obp4NeOn+dxP9w5L1eBvvZ3WEZNssI4dg1IVoESW7ggxanycaaSKNyQsRgg+P7NKcrIEIn3UtN/wcKauAYWgTr3yJ7FilyIPHCgO3BDYLpYrRGWzZ8FCDDq7vvZTMlrl0sFl63h9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MPONSHuO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MPONSHuO; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 948581FE5F
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Nov 2024 06:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730789315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfyF0LR1RZGtgdekeaMI1YLSbGk4CaNMatapyvShFBQ=;
	b=MPONSHuOB7b43jiq4kddpDPc2o+CWB32S0NFVGcUVfyR9PUP1UzCMk0AS/+SGMvkA3DBYP
	Fd+vCC5L1V3szdcl2e/nwy0JjTzLhSuNh3FdH4InPSEXulGEI4JvOvwkuIl94m1FZjQMXP
	KCUs+53eUkY7lwxHnVMu+WGq9YplBzI=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=MPONSHuO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1730789315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jfyF0LR1RZGtgdekeaMI1YLSbGk4CaNMatapyvShFBQ=;
	b=MPONSHuOB7b43jiq4kddpDPc2o+CWB32S0NFVGcUVfyR9PUP1UzCMk0AS/+SGMvkA3DBYP
	Fd+vCC5L1V3szdcl2e/nwy0JjTzLhSuNh3FdH4InPSEXulGEI4JvOvwkuIl94m1FZjQMXP
	KCUs+53eUkY7lwxHnVMu+WGq9YplBzI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2EB713964
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Nov 2024 06:48:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wCclJcK/KWeUDgAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Tue, 05 Nov 2024 06:48:34 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: make btrfs_insert_file_extent() to accept an on-stack file extent item
Date: Tue,  5 Nov 2024 17:18:14 +1030
Message-ID: <4d5c932e1a1625e6c314e1d67758953047423978.1730788965.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1730788965.git.wqu@suse.com>
References: <cover.1730788965.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 948581FE5F
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	PREVIOUSLY_DELIVERED(0.00)[linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Just like insert_reserved_file_extent() from the kernel, we can make
btrfs_insert_file_extent() to accept an on-stack file extent item
directly.

This makes btrfs_insert_file_extent() more flex, and it can now handle
the converted file extent where it has an non-zero offset.

And this makes it much easier to expand for future compressed file
extent generation.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 convert/common.c          | 33 +++++++++++++----------------
 kernel-shared/file-item.c | 44 +++++++++------------------------------
 kernel-shared/file-item.h |  4 ++--
 kernel-shared/file.c      |  6 +++++-
 mkfs/rootdir.c            | 33 +++++++++++++++++------------
 5 files changed, 51 insertions(+), 69 deletions(-)

diff --git a/convert/common.c b/convert/common.c
index 0ec9f2ec193f..802b809ca837 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -987,8 +987,7 @@ static int __btrfs_convert_file_extent(struct btrfs_trans_handle *trans,
 	int ret;
 	struct btrfs_fs_info *info = root->fs_info;
 	struct btrfs_root *extent_root = btrfs_extent_root(info, disk_bytenr);
-	struct extent_buffer *leaf;
-	struct btrfs_file_extent_item *fi;
+	struct btrfs_file_extent_item stack_fi = { 0 };
 	struct btrfs_key ins_key;
 	struct btrfs_path *path;
 	struct btrfs_extent_item *ei;
@@ -1009,9 +1008,11 @@ static int __btrfs_convert_file_extent(struct btrfs_trans_handle *trans,
 	 * hole.  And hole extent has no size limit, no need to loop.
 	 */
 	if (disk_bytenr == 0) {
+		btrfs_set_stack_file_extent_type(&stack_fi, BTRFS_FILE_EXTENT_REG);
+		btrfs_set_stack_file_extent_num_bytes(&stack_fi, num_bytes);
+		btrfs_set_stack_file_extent_ram_bytes(&stack_fi, num_bytes);
 		ret = btrfs_insert_file_extent(trans, root, objectid,
-					       file_pos, disk_bytenr,
-					       num_bytes, num_bytes);
+					       file_pos, &stack_fi);
 		return ret;
 	}
 	num_bytes = min_t(u64, num_bytes, BTRFS_MAX_EXTENT_SIZE);
@@ -1052,6 +1053,8 @@ static int __btrfs_convert_file_extent(struct btrfs_trans_handle *trans,
 		ret = btrfs_insert_empty_item(trans, extent_root, path,
 					      &ins_key, sizeof(*ei));
 		if (ret == 0) {
+			struct extent_buffer *leaf;
+
 			leaf = path->nodes[0];
 			ei = btrfs_item_ptr(leaf, path->slots[0],
 					    struct btrfs_extent_item);
@@ -1083,26 +1086,18 @@ static int __btrfs_convert_file_extent(struct btrfs_trans_handle *trans,
 	ins_key.objectid = objectid;
 	ins_key.type = BTRFS_EXTENT_DATA_KEY;
 	ins_key.offset = file_pos;
-	ret = btrfs_insert_empty_item(trans, root, path, &ins_key, sizeof(*fi));
+	btrfs_set_stack_file_extent_type(&stack_fi, BTRFS_FILE_EXTENT_REG);
+	btrfs_set_stack_file_extent_disk_bytenr(&stack_fi, extent_bytenr);
+	btrfs_set_stack_file_extent_disk_num_bytes(&stack_fi, extent_num_bytes);
+	btrfs_set_stack_file_extent_offset(&stack_fi, extent_offset);
+	btrfs_set_stack_file_extent_num_bytes(&stack_fi, num_bytes);
+	btrfs_set_stack_file_extent_ram_bytes(&stack_fi, extent_num_bytes);
+	ret = btrfs_insert_file_extent(trans, root, objectid, file_pos, &stack_fi);
 	if (ret)
 		goto fail;
-	leaf = path->nodes[0];
-	fi = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
-	btrfs_set_file_extent_generation(leaf, fi, trans->transid);
-	btrfs_set_file_extent_type(leaf, fi, BTRFS_FILE_EXTENT_REG);
-	btrfs_set_file_extent_disk_bytenr(leaf, fi, extent_bytenr);
-	btrfs_set_file_extent_disk_num_bytes(leaf, fi, extent_num_bytes);
-	btrfs_set_file_extent_offset(leaf, fi, extent_offset);
-	btrfs_set_file_extent_num_bytes(leaf, fi, num_bytes);
-	btrfs_set_file_extent_ram_bytes(leaf, fi, extent_num_bytes);
-	btrfs_set_file_extent_compression(leaf, fi, 0);
-	btrfs_set_file_extent_encryption(leaf, fi, 0);
-	btrfs_set_file_extent_other_encoding(leaf, fi, 0);
-	btrfs_mark_buffer_dirty(leaf);
 
 	nbytes = btrfs_stack_inode_nbytes(inode) + num_bytes;
 	btrfs_set_stack_inode_nbytes(inode, nbytes);
-	btrfs_release_path(path);
 
 	ret = btrfs_inc_extent_ref(trans, extent_bytenr, extent_num_bytes,
 				   0, root->root_key.objectid, objectid,
diff --git a/kernel-shared/file-item.c b/kernel-shared/file-item.c
index eb9024022d9f..0de2a216c54d 100644
--- a/kernel-shared/file-item.c
+++ b/kernel-shared/file-item.c
@@ -33,55 +33,31 @@
 			       size) - 1))
 int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root,
-			     u64 objectid, u64 pos, u64 offset,
-			     u64 disk_num_bytes, u64 num_bytes)
+			     u64 ino, u64 file_pos,
+			     struct btrfs_file_extent_item *stack_fi)
 {
 	int ret = 0;
 	int is_hole = 0;
-	struct btrfs_file_extent_item *item;
 	struct btrfs_key file_key;
-	struct btrfs_path *path;
-	struct extent_buffer *leaf;
 
-	if (offset == 0)
+	if (btrfs_stack_file_extent_disk_bytenr(stack_fi) == 0)
 		is_hole = 1;
+
 	/* For NO_HOLES, we don't insert hole file extent */
 	if (btrfs_fs_incompat(root->fs_info, NO_HOLES) && is_hole)
 		return 0;
 
 	/* For hole, its disk_bytenr and disk_num_bytes must be 0 */
 	if (is_hole)
-		disk_num_bytes = 0;
+		btrfs_set_stack_file_extent_disk_num_bytes(stack_fi, 0);
 
-	path = btrfs_alloc_path();
-	if (!path)
-		return -ENOMEM;
-
-	file_key.objectid = objectid;
+	file_key.objectid = ino;
 	file_key.type = BTRFS_EXTENT_DATA_KEY;
-	file_key.offset = pos;
+	file_key.offset = file_pos;
 
-	ret = btrfs_insert_empty_item(trans, root, path, &file_key,
-				      sizeof(*item));
-	if (ret < 0)
-		goto out;
-	BUG_ON(ret);
-	leaf = path->nodes[0];
-	item = btrfs_item_ptr(leaf, path->slots[0],
-			      struct btrfs_file_extent_item);
-	btrfs_set_file_extent_disk_bytenr(leaf, item, offset);
-	btrfs_set_file_extent_disk_num_bytes(leaf, item, disk_num_bytes);
-	btrfs_set_file_extent_offset(leaf, item, 0);
-	btrfs_set_file_extent_num_bytes(leaf, item, num_bytes);
-	btrfs_set_file_extent_ram_bytes(leaf, item, num_bytes);
-	btrfs_set_file_extent_generation(leaf, item, trans->transid);
-	btrfs_set_file_extent_type(leaf, item, BTRFS_FILE_EXTENT_REG);
-	btrfs_set_file_extent_compression(leaf, item, 0);
-	btrfs_set_file_extent_encryption(leaf, item, 0);
-	btrfs_set_file_extent_other_encoding(leaf, item, 0);
-	btrfs_mark_buffer_dirty(leaf);
-out:
-	btrfs_free_path(path);
+	btrfs_set_stack_file_extent_generation(stack_fi, trans->transid);
+	ret = btrfs_insert_item(trans, root, &file_key, stack_fi,
+				sizeof(struct btrfs_file_extent_item));
 	return ret;
 }
 
diff --git a/kernel-shared/file-item.h b/kernel-shared/file-item.h
index 2c1e17c990dc..cb38a1fc0296 100644
--- a/kernel-shared/file-item.h
+++ b/kernel-shared/file-item.h
@@ -85,8 +85,8 @@ u64 btrfs_file_extent_end(const struct btrfs_path *path);
  */
 int btrfs_insert_file_extent(struct btrfs_trans_handle *trans,
 			     struct btrfs_root *root,
-			     u64 objectid, u64 pos, u64 offset,
-			     u64 disk_num_bytes, u64 num_bytes);
+			     u64 ino, u64 file_pos,
+			     struct btrfs_file_extent_item *stack_fi);
 int btrfs_csum_file_block(struct btrfs_trans_handle *trans, u64 logical,
 			  u64 csum_objectid, u32 csum_type, const char *data);
 int btrfs_insert_inline_extent(struct btrfs_trans_handle *trans,
diff --git a/kernel-shared/file.c b/kernel-shared/file.c
index 414a01b3ec4b..7ed1b6891795 100644
--- a/kernel-shared/file.c
+++ b/kernel-shared/file.c
@@ -152,6 +152,7 @@ int btrfs_punch_hole(struct btrfs_trans_handle *trans,
 		     u64 ino, u64 offset, u64 len)
 {
 	struct btrfs_path *path;
+	struct btrfs_file_extent_item stack_fi = { 0 };
 	int ret = 0;
 
 	path = btrfs_alloc_path();
@@ -166,7 +167,10 @@ int btrfs_punch_hole(struct btrfs_trans_handle *trans,
 		goto out;
 	}
 
-	ret = btrfs_insert_file_extent(trans, root, ino, offset, 0, 0, len);
+	btrfs_set_stack_file_extent_type(&stack_fi, BTRFS_FILE_EXTENT_REG);
+	btrfs_set_stack_file_extent_num_bytes(&stack_fi, len);
+	btrfs_set_stack_file_extent_ram_bytes(&stack_fi, len);
+	ret = btrfs_insert_file_extent(trans, root, ino, offset, &stack_fi);
 out:
 	btrfs_free_path(path);
 	return ret;
diff --git a/mkfs/rootdir.c b/mkfs/rootdir.c
index 526fa255306f..5fa480886139 100644
--- a/mkfs/rootdir.c
+++ b/mkfs/rootdir.c
@@ -366,17 +366,21 @@ fail:
 static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 				       struct btrfs_root *root, u64 ino,
 				       struct btrfs_inode_item *inode,
-				       u64 file_pos, u64 disk_bytenr,
-				       u64 num_bytes)
+				       u64 file_pos,
+				       struct btrfs_file_extent_item *stack_fi)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
-	struct btrfs_root *extent_root = btrfs_extent_root(fs_info, disk_bytenr);
+	struct btrfs_root *extent_root;
 	struct extent_buffer *leaf;
 	struct btrfs_key ins_key;
 	struct btrfs_path *path;
 	struct btrfs_extent_item *ei;
+	u64 disk_bytenr = btrfs_stack_file_extent_disk_bytenr(stack_fi);
+	u64 disk_num_bytes = btrfs_stack_file_extent_disk_num_bytes(stack_fi);
+	u64 num_bytes = btrfs_stack_file_extent_num_bytes(stack_fi);
 	int ret;
 
+	extent_root = btrfs_extent_root(fs_info, disk_bytenr);
 	/*
 	 * @ino should be an inode number, thus it must not be smaller
 	 * than BTRFS_FIRST_FREE_OBJECTID.
@@ -384,18 +388,15 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	UASSERT(ino >= BTRFS_FIRST_FREE_OBJECTID);
 
 	/* The reserved data extent should never exceed the upper limit. */
-	UASSERT(num_bytes <= BTRFS_MAX_EXTENT_SIZE);
+	UASSERT(disk_num_bytes <= BTRFS_MAX_EXTENT_SIZE);
 
 	/*
 	 * All supported file system should not use its 0 extent.  As it's for
 	 * hole.  And hole extent has no size limit, no need to loop.
 	 */
-	if (disk_bytenr == 0) {
-		ret = btrfs_insert_file_extent(trans, root, ino,
-					       file_pos, disk_bytenr,
-					       num_bytes, num_bytes);
-		return ret;
-	}
+	if (disk_bytenr == 0)
+		return btrfs_insert_file_extent(trans, root, ino,
+					       file_pos, stack_fi);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -437,8 +438,7 @@ static int insert_reserved_file_extent(struct btrfs_trans_handle *trans,
 	ins_key.objectid = ino;
 	ins_key.type = BTRFS_EXTENT_DATA_KEY;
 	ins_key.offset = file_pos;
-	ret = btrfs_insert_file_extent(trans, root, ino, file_pos, disk_bytenr,
-				       num_bytes, num_bytes);
+	ret = btrfs_insert_file_extent(trans, root, ino, file_pos, stack_fi);
 	if (ret)
 		goto fail;
 	btrfs_set_stack_inode_nbytes(inode,
@@ -564,8 +564,15 @@ again:
 	}
 
 	if (bytes_read) {
+		struct btrfs_file_extent_item stack_fi = { 0 };
+
+		btrfs_set_stack_file_extent_type(&stack_fi, BTRFS_FILE_EXTENT_REG);
+		btrfs_set_stack_file_extent_disk_bytenr(&stack_fi, first_block);
+		btrfs_set_stack_file_extent_disk_num_bytes(&stack_fi, cur_bytes);
+		btrfs_set_stack_file_extent_num_bytes(&stack_fi, cur_bytes);
+		btrfs_set_stack_file_extent_ram_bytes(&stack_fi, cur_bytes);
 		ret = insert_reserved_file_extent(trans, root, objectid,
-				btrfs_inode, file_pos, first_block, cur_bytes);
+				btrfs_inode, file_pos, &stack_fi);
 		if (ret)
 			goto end;
 
-- 
2.47.0


