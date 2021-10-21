Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666BD43585C
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Oct 2021 03:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhJUBnC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Oct 2021 21:43:02 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:40630 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbhJUBm6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Oct 2021 21:42:58 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 433E01FD53
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 01:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1634780442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uytcuDf2jgKbf35Jk/4YwocSd5tFooo7j4sskr+WIJQ=;
        b=lND2tHiKVBJ1JQ/7OrsK+ZbSz9ljvh5rr2zV+jwoKOuAtKiIYpETowveB2Q1ILMR7TKYVz
        scP4qfK7h9NdzTEdqLvXk6wZRRP6v0ONXcWniGxfipf/6Hq+abd9S+1re2sAxxxFD6ofZK
        kFzFJXV/R7a/a8w7CWd42BZboZ+Otn0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FC6F13F8A
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 01:40:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MDvZFRnFcGFYIQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Oct 2021 01:40:41 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/3] btrfs-progs: cache csum_size and csum_type in btrfs_fs_info
Date:   Thu, 21 Oct 2021 09:40:20 +0800
Message-Id: <20211021014020.482242-4-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211021014020.482242-1-wqu@suse.com>
References: <20211021014020.482242-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Just like kernel commit 22b6331d9617 ("btrfs: store precalculated
csum_size in fs_info"), we can cache csum_size and csum_type in
btrfs_fs_info.

Furthermore, there is already a 32 bits hole in btrfs_fs_info, and we
can fit csum_type and csum_size into the hole without increase the size
of btrfs_fs_info.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 btrfs-corrupt-block.c       |  6 +++---
 check/main.c                |  6 +++---
 check/mode-common.c         |  2 +-
 cmds/rescue-chunk-recover.c |  4 ++--
 kernel-shared/ctree.h       |  2 ++
 kernel-shared/disk-io.c     |  6 ++++--
 kernel-shared/file-item.c   | 15 +++++----------
 kernel-shared/print-tree.c  |  4 ++--
 8 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index c1624ee1e6bf..d00ed98e8ffe 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -158,9 +158,9 @@ static void corrupt_keys(struct btrfs_trans_handle *trans,
 	}
 	btrfs_mark_buffer_dirty(eb);
 	if (!trans) {
-		u16 csum_size =
-			btrfs_super_csum_size(fs_info->super_copy);
-		u16 csum_type = btrfs_super_csum_type(fs_info->super_copy);
+		u16 csum_size = fs_info->csum_size;
+		u16 csum_type = fs_info->csum_type;
+
 		csum_tree_block_size(eb, csum_size, 0, csum_type);
 		write_extent_to_disk(eb);
 	}
diff --git a/check/main.c b/check/main.c
index 38b2cfdf5b0b..935e604ac1c6 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5762,8 +5762,8 @@ static int check_extent_csums(struct btrfs_root *root, u64 bytenr,
 			struct extent_buffer *eb)
 {
 	u64 offset = 0;
-	u16 csum_size = btrfs_super_csum_size(gfs_info->super_copy);
-	u16 csum_type = btrfs_super_csum_type(gfs_info->super_copy);
+	u16 csum_size = gfs_info->csum_size;
+	u16 csum_type = gfs_info->csum_type;
 	u8 *data;
 	unsigned long csum_offset;
 	u8 result[BTRFS_CSUM_SIZE];
@@ -5981,7 +5981,7 @@ static int check_csums(struct btrfs_root *root)
 	struct btrfs_key key;
 	u64 last_data_end = 0;
 	u64 offset = 0, num_bytes = 0;
-	u16 csum_size = btrfs_super_csum_size(gfs_info->super_copy);
+	u16 csum_size = gfs_info->csum_size;
 	int errors = 0;
 	int ret;
 	u64 data_len;
diff --git a/check/mode-common.c b/check/mode-common.c
index 0059672c6402..d28e79af64ef 100644
--- a/check/mode-common.c
+++ b/check/mode-common.c
@@ -294,7 +294,7 @@ int count_csum_range(u64 start, u64 len, u64 *found)
 	size_t size;
 	*found = 0;
 	u64 csum_end;
-	u16 csum_size = btrfs_super_csum_size(gfs_info->super_copy);
+	u16 csum_size = gfs_info->csum_size;
 
 	btrfs_init_path(&path);
 
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index 35c6f66548fd..15971873aca7 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -1820,7 +1820,7 @@ static int next_csum(struct btrfs_root *root,
 	struct btrfs_root *csum_root = root->fs_info->csum_root;
 	struct btrfs_csum_item *csum_item;
 	u32 blocksize = root->fs_info->sectorsize;
-	u16 csum_size = btrfs_super_csum_size(root->fs_info->super_copy);
+	u16 csum_size = root->fs_info->csum_size;
 	int csums_in_item = btrfs_item_size_nr(*leaf, *slot) / csum_size;
 
 	if (*csum_offset >= csums_in_item) {
@@ -1904,7 +1904,7 @@ out:
 static u64 item_end_offset(struct btrfs_root *root, struct btrfs_key *key,
 			   struct extent_buffer *leaf, int slot) {
 	u32 blocksize = root->fs_info->sectorsize;
-	u16 csum_size = btrfs_super_csum_size(root->fs_info->super_copy);
+	u16 csum_size = root->fs_info->csum_size;
 
 	u64 offset = btrfs_item_size_nr(leaf, slot);
 	offset /= csum_size;
diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 6451690ce4fa..2ebaae2e9321 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1231,6 +1231,8 @@ struct btrfs_fs_info {
 	u32 nodesize;
 	u32 sectorsize;
 	u32 stripesize;
+	u16 csum_type;
+	u16 csum_size;
 
 	/*
 	 * Zone size > 0 when in ZONED mode, otherwise it's used for a check
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 30f16f4da126..e79f8b5a7c48 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -209,8 +209,8 @@ int verify_tree_block_csum_silent(struct extent_buffer *buf, u16 csum_size,
 int csum_tree_block(struct btrfs_fs_info *fs_info,
 		    struct extent_buffer *buf, int verify)
 {
-	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
-	u16 csum_type = btrfs_super_csum_type(fs_info->super_copy);
+	u16 csum_size = fs_info->csum_size;
+	u16 csum_type = fs_info->csum_type;
 
 	if (verify && fs_info->suppress_check_block_errors)
 		return verify_tree_block_csum_silent(buf, csum_size, csum_type);
@@ -1297,6 +1297,8 @@ static struct btrfs_fs_info *__open_ctree_fd(int fp, struct open_ctree_flags *oc
 	fs_info->sectorsize = btrfs_super_sectorsize(disk_super);
 	fs_info->nodesize = btrfs_super_nodesize(disk_super);
 	fs_info->stripesize = btrfs_super_stripesize(disk_super);
+	fs_info->csum_type = btrfs_super_csum_type(disk_super);
+	fs_info->csum_size = btrfs_super_csum_size(disk_super);
 
 	ret = btrfs_check_fs_compatibility(fs_info->super_copy, flags);
 	if (ret)
diff --git a/kernel-shared/file-item.c b/kernel-shared/file-item.c
index c910e27e5a5d..ecb8e5cd29e1 100644
--- a/kernel-shared/file-item.c
+++ b/kernel-shared/file-item.c
@@ -142,8 +142,7 @@ btrfs_lookup_csum(struct btrfs_trans_handle *trans,
 	struct btrfs_csum_item *item;
 	struct extent_buffer *leaf;
 	u64 csum_offset = 0;
-	u16 csum_size =
-		btrfs_super_csum_size(root->fs_info->super_copy);
+	u16 csum_size = root->fs_info->csum_size;
 	int csums_in_item;
 
 	file_key.objectid = BTRFS_EXTENT_CSUM_OBJECTID;
@@ -199,11 +198,8 @@ int btrfs_csum_file_block(struct btrfs_trans_handle *trans,
 	u32 sectorsize = root->fs_info->sectorsize;
 	u32 nritems;
 	u32 ins_size;
-	u16 csum_size =
-		btrfs_super_csum_size(root->fs_info->super_copy);
-
-	u16 csum_type =
-		btrfs_super_csum_type(root->fs_info->super_copy);
+	u16 csum_size = root->fs_info->csum_size;
+	u16 csum_type = root->fs_info->csum_type;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -341,8 +337,7 @@ static noinline int truncate_one_csum(struct btrfs_root *root,
 				      u64 bytenr, u64 len)
 {
 	struct extent_buffer *leaf;
-	u16 csum_size =
-		btrfs_super_csum_size(root->fs_info->super_copy);
+	u16 csum_size = root->fs_info->csum_size;
 	u64 csum_end;
 	u64 end_byte = bytenr + len;
 	u32 blocksize = root->fs_info->sectorsize;
@@ -399,7 +394,7 @@ int btrfs_del_csums(struct btrfs_trans_handle *trans, u64 bytenr, u64 len)
 	u64 csum_end;
 	struct extent_buffer *leaf;
 	int ret;
-	u16 csum_size = btrfs_super_csum_size(trans->fs_info->super_copy);
+	u16 csum_size = trans->fs_info->csum_size;
 	int blocksize = trans->fs_info->sectorsize;
 	struct btrfs_root *csum_root = trans->fs_info->csum_root;
 
diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
index 39655590272e..4de51175d62f 100644
--- a/kernel-shared/print-tree.c
+++ b/kernel-shared/print-tree.c
@@ -1156,7 +1156,7 @@ static void print_extent_csum(struct extent_buffer *eb,
 		printf("\t\trange start %llu\n", (unsigned long long)offset);
 		return;
 	}
-	csum_size = btrfs_super_csum_size(fs_info->super_copy);
+	csum_size = fs_info->csum_size;
 	size = (item_size / csum_size) * fs_info->sectorsize;
 	printf("\t\trange start %llu end %llu length %u\n",
 			(unsigned long long)offset,
@@ -1246,7 +1246,7 @@ static void print_header_info(struct extent_buffer *eb, unsigned int mode)
 		char *tmp = csum_str;
 		u8 *csum = (u8 *)(eb->data + offsetof(struct btrfs_header, csum));
 
-		csum_size = btrfs_super_csum_size(fs_info->super_copy);
+		csum_size = fs_info->csum_size;
 		strcpy(csum_str, " csum 0x");
 		tmp = csum_str + strlen(csum_str);
 		for (i = 0; i < csum_size; i++) {
-- 
2.33.0

