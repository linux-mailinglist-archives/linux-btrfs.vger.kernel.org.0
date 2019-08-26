Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8F149CE82
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 13:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbfHZLs5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 07:48:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:39202 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730841AbfHZLs5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 07:48:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AF81CAFCB
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 11:48:55 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 03/11] btrfs-progs: add checksum type to checksumming functions
Date:   Mon, 26 Aug 2019 13:48:45 +0200
Message-Id: <20190826114853.14860-4-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190826114853.14860-1-jthumshirn@suse.de>
References: <20190826114853.14860-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add the checksum type to csum_tree_block_size(), __csum_tree_block_size()
and verify_tree_block_csum_silent().

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 btrfs-corrupt-block.c       |  3 ++-
 cmds/rescue-chunk-recover.c |  3 ++-
 convert/common.c            |  3 ++-
 convert/main.c              |  3 ++-
 disk-io.c                   | 21 ++++++++++++---------
 disk-io.h                   |  5 +++--
 mkfs/common.c               | 21 ++++++++++++++-------
 7 files changed, 37 insertions(+), 22 deletions(-)

diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
index bbef0c02e5d1..1dde9594bdcc 100644
--- a/btrfs-corrupt-block.c
+++ b/btrfs-corrupt-block.c
@@ -158,7 +158,8 @@ static void corrupt_keys(struct btrfs_trans_handle *trans,
 	if (!trans) {
 		u16 csum_size =
 			btrfs_super_csum_size(fs_info->super_copy);
-		csum_tree_block_size(eb, csum_size, 0);
+		u16 csum_type = btrfs_super_csum_type(fs_info->super_copy);
+		csum_tree_block_size(eb, csum_size, 0, csum_type);
 		write_extent_to_disk(eb);
 	}
 }
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index 308731ea5ea6..1a368310d895 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -768,7 +768,8 @@ static int scan_one_device(void *dev_scan_struct)
 			continue;
 		}
 
-		if (verify_tree_block_csum_silent(buf, rc->csum_size)) {
+		if (verify_tree_block_csum_silent(buf, rc->csum_size,
+						  rc->csum_type)) {
 			bytenr += rc->sectorsize;
 			continue;
 		}
diff --git a/convert/common.c b/convert/common.c
index af4f8d372299..ba69e132677e 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -222,7 +222,8 @@ static inline int write_temp_extent_buffer(int fd, struct extent_buffer *buf,
 {
 	int ret;
 
-	csum_tree_block_size(buf, btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32], 0);
+	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
+			     cfg->csum_type);
 
 	/* Temporary extent buffer is always mapped 1:1 on disk */
 	ret = pwrite(fd, buf->data, buf->len, bytenr);
diff --git a/convert/main.c b/convert/main.c
index 9711874bd137..5e6b12431f59 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -1058,7 +1058,8 @@ static int migrate_super_block(int fd, u64 old_bytenr)
 	BUG_ON(btrfs_super_bytenr(super) != old_bytenr);
 	btrfs_set_super_bytenr(super, BTRFS_SUPER_INFO_OFFSET);
 
-	csum_tree_block_size(buf, btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32], 0);
+	csum_tree_block_size(buf, btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32], 0,
+			     btrfs_super_csum_type(super));
 	ret = pwrite(fd, buf->data, BTRFS_SUPER_INFO_SIZE,
 		BTRFS_SUPER_INFO_OFFSET);
 	if (ret != BTRFS_SUPER_INFO_SIZE)
diff --git a/disk-io.c b/disk-io.c
index be44eead5cef..9cb475bc6262 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -149,7 +149,7 @@ void btrfs_csum_final(u32 crc, u8 *result)
 }
 
 static int __csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
-				  int verify, int silent)
+				  int verify, int silent, u16 csum_type)
 {
 	u8 result[BTRFS_CSUM_SIZE];
 	u32 len;
@@ -174,24 +174,27 @@ static int __csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
 	return 0;
 }
 
-int csum_tree_block_size(struct extent_buffer *buf, u16 csum_size, int verify)
+int csum_tree_block_size(struct extent_buffer *buf, u16 csum_size, int verify,
+			 u16 csum_type)
 {
-	return __csum_tree_block_size(buf, csum_size, verify, 0);
+	return __csum_tree_block_size(buf, csum_size, verify, 0, csum_type);
 }
 
-int verify_tree_block_csum_silent(struct extent_buffer *buf, u16 csum_size)
+int verify_tree_block_csum_silent(struct extent_buffer *buf, u16 csum_size,
+				  u16 csum_type)
 {
-	return __csum_tree_block_size(buf, csum_size, 1, 1);
+	return __csum_tree_block_size(buf, csum_size, 1, 1, csum_type);
 }
 
 int csum_tree_block(struct btrfs_fs_info *fs_info,
 		    struct extent_buffer *buf, int verify)
 {
-	u16 csum_size =
-		btrfs_super_csum_size(fs_info->super_copy);
+	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
+	u16 csum_type = btrfs_super_csum_type(fs_info->super_copy);
+
 	if (verify && fs_info->suppress_check_block_errors)
-		return verify_tree_block_csum_silent(buf, csum_size);
-	return csum_tree_block_size(buf, csum_size, verify);
+		return verify_tree_block_csum_silent(buf, csum_size, csum_type);
+	return csum_tree_block_size(buf, csum_size, verify, csum_type);
 }
 
 struct extent_buffer *btrfs_find_tree_block(struct btrfs_fs_info *fs_info,
diff --git a/disk-io.h b/disk-io.h
index 7b5c3806ba98..394997ad72cb 100644
--- a/disk-io.h
+++ b/disk-io.h
@@ -191,8 +191,9 @@ void btrfs_csum_final(u32 crc, u8 *result);
 
 int btrfs_open_device(struct btrfs_device *dev);
 int csum_tree_block_size(struct extent_buffer *buf, u16 csum_sectorsize,
-			 int verify);
-int verify_tree_block_csum_silent(struct extent_buffer *buf, u16 csum_size);
+			 int verify, u16 csum_type);
+int verify_tree_block_csum_silent(struct extent_buffer *buf, u16 csum_size,
+				  u16 csum_type);
 int btrfs_read_buffer(struct extent_buffer *buf, u64 parent_transid);
 int write_tree_block(struct btrfs_trans_handle *trans,
 		     struct btrfs_fs_info *fs_info,
diff --git a/mkfs/common.c b/mkfs/common.c
index b6e549b19272..9762391a8d2b 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -101,7 +101,8 @@ static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
 	}
 
 	/* generate checksum */
-	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0);
+	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
+			     cfg->csum_type);
 
 	/* write back root tree */
 	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_ROOT_TREE]);
@@ -292,7 +293,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_EXTENT_TREE]);
 	btrfs_set_header_owner(buf, BTRFS_EXTENT_TREE_OBJECTID);
 	btrfs_set_header_nritems(buf, nritems);
-	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0);
+	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
+			     cfg->csum_type);
 	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_EXTENT_TREE]);
 	if (ret != cfg->nodesize) {
 		ret = (ret < 0 ? -errno : -EIO);
@@ -380,7 +382,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_CHUNK_TREE]);
 	btrfs_set_header_owner(buf, BTRFS_CHUNK_TREE_OBJECTID);
 	btrfs_set_header_nritems(buf, nritems);
-	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0);
+	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
+			     cfg->csum_type);
 	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_CHUNK_TREE]);
 	if (ret != cfg->nodesize) {
 		ret = (ret < 0 ? -errno : -EIO);
@@ -420,7 +423,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_DEV_TREE]);
 	btrfs_set_header_owner(buf, BTRFS_DEV_TREE_OBJECTID);
 	btrfs_set_header_nritems(buf, nritems);
-	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0);
+	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
+			     cfg->csum_type);
 	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_DEV_TREE]);
 	if (ret != cfg->nodesize) {
 		ret = (ret < 0 ? -errno : -EIO);
@@ -433,7 +437,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_FS_TREE]);
 	btrfs_set_header_owner(buf, BTRFS_FS_TREE_OBJECTID);
 	btrfs_set_header_nritems(buf, 0);
-	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0);
+	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
+			     cfg->csum_type);
 	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_FS_TREE]);
 	if (ret != cfg->nodesize) {
 		ret = (ret < 0 ? -errno : -EIO);
@@ -445,7 +450,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_CSUM_TREE]);
 	btrfs_set_header_owner(buf, BTRFS_CSUM_TREE_OBJECTID);
 	btrfs_set_header_nritems(buf, 0);
-	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0);
+	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
+			     cfg->csum_type);
 	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_CSUM_TREE]);
 	if (ret != cfg->nodesize) {
 		ret = (ret < 0 ? -errno : -EIO);
@@ -456,7 +462,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	memset(buf->data, 0, BTRFS_SUPER_INFO_SIZE);
 	memcpy(buf->data, &super, sizeof(super));
 	buf->len = BTRFS_SUPER_INFO_SIZE;
-	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0);
+	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
+			     cfg->csum_type);
 	ret = pwrite(fd, buf->data, BTRFS_SUPER_INFO_SIZE,
 			cfg->blocks[MKFS_SUPER_BLOCK]);
 	if (ret != BTRFS_SUPER_INFO_SIZE) {
-- 
2.16.4

