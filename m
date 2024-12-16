Return-Path: <linux-btrfs+bounces-10396-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789DE9F2959
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 05:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2F02162AD1
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 Dec 2024 04:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BD11C3C1B;
	Mon, 16 Dec 2024 04:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EmoM6JYO";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="EmoM6JYO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFC21BD9F6
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 04:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734324701; cv=none; b=cj27K6h83IwmrGaqtCQhvmO4W+X3HF4BU5pCYqkQvb+asshf/5AaBTSILQLBoS89MIdmVIS60qiaGf6X9ZSz+LtrXvEL9mmpeKOz9AJH2KfJE4e04ZeTbYT6xldHLnXwX54Gw9XEcp2COPGX3oTKGTq3rq2wlYgtvhIImegZm98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734324701; c=relaxed/simple;
	bh=Z4XtSwuHNqAbuNyu5Q2Bn14FhBVfUL3qUI7ORtN9RQo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqB838n+Z8J744MIFRwG3lC2oTr1xnczq2R2qbOiDcbPLq7/hbwXcrykffg6ZEjFpFWl8q0cmadNOUXoGXs4T80GIZInqTOiAYEclSW9wwtJSI8fKd9DNwjwUG+Z176B9GQgkcqYU1mzmlBjrNI6a8CrnBvBHZLezwUffPHvTSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EmoM6JYO; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=EmoM6JYO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D64C4211E8
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 04:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734324696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/dxfiC3Bbbm1fpryBE2b8J4fqIZVqdTYKQh9TjH1FLQ=;
	b=EmoM6JYONAyZoUL6H11oumspZXNT8UwVB6059Is+RP5Tvi5GTJvVHAVrh9frWJYdn22FUM
	vfggRdzQAggkqecCoJCA+xg6WgAs/X25/Etie152EQ+tazta6vLzewNuD/5WAYD2GbG/OT
	4aGNkTEj6aW5K1eI1v1+DY0nS5+eh6I=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1734324696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/dxfiC3Bbbm1fpryBE2b8J4fqIZVqdTYKQh9TjH1FLQ=;
	b=EmoM6JYONAyZoUL6H11oumspZXNT8UwVB6059Is+RP5Tvi5GTJvVHAVrh9frWJYdn22FUM
	vfggRdzQAggkqecCoJCA+xg6WgAs/X25/Etie152EQ+tazta6vLzewNuD/5WAYD2GbG/OT
	4aGNkTEj6aW5K1eI1v1+DY0nS5+eh6I=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F31E9137CF
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 04:51:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6Po9KtexX2ciNwAAD6G6ig
	(envelope-from <wqu@suse.com>)
	for <linux-btrfs@vger.kernel.org>; Mon, 16 Dec 2024 04:51:35 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org
Subject: [PATCH 4/4] btrfs-progs: rename btrfs_super_block::sectorsize to blocksize
Date: Mon, 16 Dec 2024 15:21:07 +1030
Message-ID: <587074e50389e226cfb8821b4b7e2d2774f0ec6f.1734324435.git.wqu@suse.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1734324435.git.wqu@suse.com>
References: <cover.1734324435.git.wqu@suse.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
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

This on-disk format rename is to keep the terminology aligned to other
filesystems.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 cmds/rescue-chunk-recover.c     |  4 ++--
 convert/common.c                |  2 +-
 image/image-restore.c           |  8 ++++----
 kernel-shared/accessors.h       |  4 ++--
 kernel-shared/disk-io.c         | 12 ++++++------
 kernel-shared/print-tree.c      |  4 ++--
 kernel-shared/uapi/btrfs_tree.h |  4 ++--
 mkfs/common.c                   |  2 +-
 8 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index 8bbf5b6deb4f..d767915cc415 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -1471,7 +1471,7 @@ open_ctree_with_broken_chunk(struct recover_control *rc)
 	}
 
 	UASSERT(!memcmp(disk_super->fsid, rc->fs_devices->fsid, BTRFS_FSID_SIZE));
-	fs_info->blocksize = btrfs_super_sectorsize(disk_super);
+	fs_info->blocksize = btrfs_super_blocksize(disk_super);
 	fs_info->nodesize = btrfs_super_nodesize(disk_super);
 	fs_info->stripesize = btrfs_super_stripesize(disk_super);
 
@@ -1535,7 +1535,7 @@ static int recover_prepare(struct recover_control *rc, const char *path)
 		goto out_close_fd;
 	}
 
-	rc->blocksize = btrfs_super_sectorsize(&sb);
+	rc->blocksize = btrfs_super_blocksize(&sb);
 	rc->nodesize = btrfs_super_nodesize(&sb);
 	rc->generation = btrfs_super_generation(&sb);
 	rc->chunk_root_generation = btrfs_super_chunk_root_generation(&sb);
diff --git a/convert/common.c b/convert/common.c
index e7bd0309225f..da939a79a840 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -143,7 +143,7 @@ static int setup_temp_super(int fd, struct btrfs_mkfs_config *cfg,
 	 * and csum tree.
 	 */
 	btrfs_set_super_bytes_used(&super, 6 * cfg->nodesize);
-	btrfs_set_super_sectorsize(&super, cfg->blocksize);
+	btrfs_set_super_blocksize(&super, cfg->blocksize);
 	super.__unused_leafsize = cpu_to_le32(cfg->nodesize);
 	btrfs_set_super_nodesize(&super, cfg->nodesize);
 	btrfs_set_super_stripesize(&super, cfg->stripesize);
diff --git a/image/image-restore.c b/image/image-restore.c
index 667b9811233d..9ab709b8351d 100644
--- a/image/image-restore.c
+++ b/image/image-restore.c
@@ -365,7 +365,7 @@ static void update_super_old(u8 *buffer)
 	struct btrfs_super_block *super = (struct btrfs_super_block *)buffer;
 	struct btrfs_chunk *chunk;
 	struct btrfs_disk_key *key;
-	u32 sectorsize = btrfs_super_sectorsize(super);
+	u32 blocksize = btrfs_super_blocksize(super);
 	u64 flags = btrfs_super_flags(super);
 
 	if (current_version->extra_sb_flags)
@@ -384,9 +384,9 @@ static void update_super_old(u8 *buffer)
 	btrfs_set_stack_chunk_owner(chunk, BTRFS_EXTENT_TREE_OBJECTID);
 	btrfs_set_stack_chunk_stripe_len(chunk, BTRFS_STRIPE_LEN);
 	btrfs_set_stack_chunk_type(chunk, BTRFS_BLOCK_GROUP_SYSTEM);
-	btrfs_set_stack_chunk_io_align(chunk, sectorsize);
-	btrfs_set_stack_chunk_io_width(chunk, sectorsize);
-	btrfs_set_stack_chunk_sector_size(chunk, sectorsize);
+	btrfs_set_stack_chunk_io_align(chunk, blocksize);
+	btrfs_set_stack_chunk_io_width(chunk, blocksize);
+	btrfs_set_stack_chunk_sector_size(chunk, blocksize);
 	btrfs_set_stack_chunk_num_stripes(chunk, 1);
 	btrfs_set_stack_chunk_sub_stripes(chunk, 0);
 	chunk->stripe.devid = super->dev_item.devid;
diff --git a/kernel-shared/accessors.h b/kernel-shared/accessors.h
index c88041c79c34..94c09b1c9c36 100644
--- a/kernel-shared/accessors.h
+++ b/kernel-shared/accessors.h
@@ -946,8 +946,8 @@ BTRFS_SETGET_STACK_FUNCS(super_total_bytes, struct btrfs_super_block,
 			 total_bytes, 64);
 BTRFS_SETGET_STACK_FUNCS(super_bytes_used, struct btrfs_super_block,
 			 bytes_used, 64);
-BTRFS_SETGET_STACK_FUNCS(super_sectorsize, struct btrfs_super_block,
-			 sectorsize, 32);
+BTRFS_SETGET_STACK_FUNCS(super_blocksize, struct btrfs_super_block,
+			 blocksize, 32);
 BTRFS_SETGET_STACK_FUNCS(super_nodesize, struct btrfs_super_block,
 			 nodesize, 32);
 BTRFS_SETGET_STACK_FUNCS(super_stripesize, struct btrfs_super_block,
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index c6189697675f..d42ebc519d2e 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -1587,7 +1587,7 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp, struct open_ctree_args *oca
 		ASSERT(!memcmp(disk_super->metadata_uuid,
 			       fs_devices->metadata_uuid, BTRFS_FSID_SIZE));
 
-	fs_info->blocksize = btrfs_super_sectorsize(disk_super);
+	fs_info->blocksize = btrfs_super_blocksize(disk_super);
 	fs_info->nodesize = btrfs_super_nodesize(disk_super);
 	fs_info->stripesize = btrfs_super_stripesize(disk_super);
 	fs_info->csum_type = btrfs_super_csum_type(disk_super);
@@ -1816,13 +1816,13 @@ int btrfs_check_super(struct btrfs_super_block *sb, unsigned sbflags)
 		error("nodesize unaligned: %u", btrfs_super_nodesize(sb));
 		goto error_out;
 	}
-	if (btrfs_super_sectorsize(sb) < 4096) {
+	if (btrfs_super_blocksize(sb) < 4096) {
 		error("blocksize too small: %u < 4096",
-			btrfs_super_sectorsize(sb));
+			btrfs_super_blocksize(sb));
 		goto error_out;
 	}
-	if (!IS_ALIGNED(btrfs_super_sectorsize(sb), 4096)) {
-		error("blocksize unaligned: %u", btrfs_super_sectorsize(sb));
+	if (!IS_ALIGNED(btrfs_super_blocksize(sb), 4096)) {
+		error("blocksize unaligned: %u", btrfs_super_blocksize(sb));
 		goto error_out;
 	}
 	if (btrfs_super_total_bytes(sb) == 0) {
@@ -1834,7 +1834,7 @@ int btrfs_check_super(struct btrfs_super_block *sb, unsigned sbflags)
 		goto error_out;
 	}
 	if ((btrfs_super_stripesize(sb) != 4096)
-		&& (btrfs_super_stripesize(sb) != btrfs_super_sectorsize(sb))) {
+		&& (btrfs_super_stripesize(sb) != btrfs_super_blocksize(sb))) {
 		error("invalid stripesize %u", btrfs_super_stripesize(sb));
 		goto error_out;
 	}
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 09130e97eafe..c1b107d24325 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -2259,8 +2259,8 @@ void btrfs_print_superblock(struct btrfs_super_block *sb, int full)
 	       (unsigned long long)btrfs_super_total_bytes(sb));
 	printf("bytes_used\t\t%llu\n",
 	       (unsigned long long)btrfs_super_bytes_used(sb));
-	printf("sectorsize\t\t%llu\n",
-	       (unsigned long long)btrfs_super_sectorsize(sb));
+	printf("blocksize\t\t%llu\n",
+	       (unsigned long long)btrfs_super_blocksize(sb));
 	printf("nodesize\t\t%llu\n",
 	       (unsigned long long)btrfs_super_nodesize(sb));
 	printf("leafsize (deprecated)\t%u\n",
diff --git a/kernel-shared/uapi/btrfs_tree.h b/kernel-shared/uapi/btrfs_tree.h
index 5720a03c939b..a0388473b9b4 100644
--- a/kernel-shared/uapi/btrfs_tree.h
+++ b/kernel-shared/uapi/btrfs_tree.h
@@ -256,7 +256,7 @@
  * When a block group becomes very fragmented, we convert it to use bitmaps
  * instead of extents. A free space bitmap is keyed on
  * (start, FREE_SPACE_BITMAP, length); the corresponding item is a bitmap with
- * (length / sectorsize) bits.
+ * (length / blocksize) bits.
  */
 #define BTRFS_FREE_SPACE_BITMAP_KEY 200
 
@@ -672,7 +672,7 @@ struct btrfs_super_block {
 	__le64 bytes_used;
 	__le64 root_dir_objectid;
 	__le64 num_devices;
-	__le32 sectorsize;
+	__le32 blocksize;
 	__le32 nodesize;
 	__le32 __unused_leafsize;
 	__le32 stripesize;
diff --git a/mkfs/common.c b/mkfs/common.c
index 10da578d0567..ddcb69ca1aa7 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -458,7 +458,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_super_chunk_root(&super, cfg->blocks[MKFS_CHUNK_TREE]);
 	btrfs_set_super_total_bytes(&super, num_bytes);
 	btrfs_set_super_bytes_used(&super, total_used);
-	btrfs_set_super_sectorsize(&super, cfg->blocksize);
+	btrfs_set_super_blocksize(&super, cfg->blocksize);
 	super.__unused_leafsize = cpu_to_le32(cfg->nodesize);
 	btrfs_set_super_nodesize(&super, cfg->nodesize);
 	btrfs_set_super_stripesize(&super, cfg->stripesize);
-- 
2.47.1


