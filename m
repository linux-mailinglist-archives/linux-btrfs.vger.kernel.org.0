Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87963D8B83
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2019 10:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391812AbfJPImG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Oct 2019 04:42:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:48260 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404143AbfJPImD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Oct 2019 04:42:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2FA7DAD73
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2019 08:42:01 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>
Subject: [RFC PATCH 1/4] btrfs-progs: pass in fs_info to btrfs_csum_data
Date:   Wed, 16 Oct 2019 10:41:55 +0200
Message-Id: <20191016084158.7573-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For passing authentication keys to the checksumming functions we need a
container for the key.

Pass in a btrfs_fs_info to btrfs_csum_data() so we can use the fs_info as
a container for the authentication key.

Note this is not always possible for all callers of btrfs_csum_data() so
we're just passing in NULL if it is not directly possible.

Functions calling btrfs_csum_data() with a NULL fs_info argument are
currently not supported in the context of an authenticated file-system.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 btrfs-sb-mod.c              |  4 ++--
 check/main.c                |  2 +-
 cmds/inspect-dump-super.c   |  2 +-
 cmds/rescue-chunk-recover.c |  2 +-
 convert/common.c            |  2 +-
 disk-io.c                   | 16 +++++++++-------
 disk-io.h                   |  3 ++-
 file-item.c                 |  2 +-
 8 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/btrfs-sb-mod.c b/btrfs-sb-mod.c
index ad143ca05aa6..537002687da6 100644
--- a/btrfs-sb-mod.c
+++ b/btrfs-sb-mod.c
@@ -36,7 +36,7 @@ static int check_csum_superblock(void *sb)
 	u8 result[BTRFS_CSUM_SIZE];
 	u16 csum_type = btrfs_super_csum_type(sb);
 
-	btrfs_csum_data(csum_type, (unsigned char *)sb + BTRFS_CSUM_SIZE,
+	btrfs_csum_data(NULL, csum_type, (unsigned char *)sb + BTRFS_CSUM_SIZE,
 			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 
 	return !memcmp(sb, result, csum_size);
@@ -48,7 +48,7 @@ static void update_block_csum(void *block)
 	struct btrfs_header *hdr;
 	u16 csum_type = btrfs_super_csum_type(block);
 
-	btrfs_csum_data(csum_type, (unsigned char *)block + BTRFS_CSUM_SIZE,
+	btrfs_csum_data(NULL, csum_type, (unsigned char *)block + BTRFS_CSUM_SIZE,
 			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 
 	memset(block, 0, BTRFS_CSUM_SIZE);
diff --git a/check/main.c b/check/main.c
index fd05430c1f51..d009f33e9657 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5659,7 +5659,7 @@ static int check_extent_csums(struct btrfs_root *root, u64 bytenr,
 			while (data_checked < read_len) {
 				tmp = offset + data_checked;
 
-				btrfs_csum_data(csum_type, data + tmp,
+				btrfs_csum_data(fs_info, csum_type, data + tmp,
 						result, fs_info->sectorsize);
 
 				csum_offset = leaf_offset +
diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index fc06488dde32..1a2ef4d4822c 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -39,7 +39,7 @@ static int check_csum_sblock(void *sb, int csum_size, u16 csum_type)
 {
 	u8 result[BTRFS_CSUM_SIZE];
 
-	btrfs_csum_data(csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
+	btrfs_csum_data(NULL, csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
 			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 
 	return !memcmp(sb, result, csum_size);
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index bf35693ddbfa..0896cea674ab 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -1908,7 +1908,7 @@ static int check_one_csum(int fd, u64 start, u32 len, u32 tree_csum,
 	}
 	ret = 0;
 	put_unaligned_le32(tree_csum, expected_csum);
-	btrfs_csum_data(csum_type, (u8 *)data, result, len);
+	btrfs_csum_data(NULL, csum_type, (u8 *)data, result, len);
 	if (memcmp(result, expected_csum, csum_size) != 0)
 		ret = 1;
 out:
diff --git a/convert/common.c b/convert/common.c
index 3cb2d9d44881..54ed52b592e6 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -66,7 +66,7 @@ static inline int write_temp_super(int fd, struct btrfs_super_block *sb,
        u16 csum_type = btrfs_super_csum_type(sb);
        int ret;
 
-       btrfs_csum_data(csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
+       btrfs_csum_data(NULL, csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
 		       result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
        memcpy(&sb->csum[0], result, BTRFS_CSUM_SIZE);
        ret = pwrite(fd, sb, BTRFS_SUPER_INFO_SIZE, sb_bytenr);
diff --git a/disk-io.c b/disk-io.c
index a9744af90a43..e68f28e72077 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -139,7 +139,8 @@ static void print_tree_block_error(struct btrfs_fs_info *fs_info,
 	}
 }
 
-int btrfs_csum_data(u16 csum_type, const u8 *data, u8 *out, size_t len)
+int btrfs_csum_data(struct btrfs_fs_info *fs_info, u16 csum_type,
+		    const u8 *data, u8 *out, size_t len)
 {
 	memset(out, 0, BTRFS_CSUM_SIZE);
 
@@ -167,7 +168,8 @@ static int __csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
 	u32 len;
 
 	len = buf->len - BTRFS_CSUM_SIZE;
-	btrfs_csum_data(csum_type, (u8 *)buf->data + BTRFS_CSUM_SIZE,
+	btrfs_csum_data(buf->fs_info, csum_type,
+			(u8 *)buf->data + BTRFS_CSUM_SIZE,
 			result, len);
 
 	if (verify) {
@@ -1386,7 +1388,7 @@ int btrfs_check_super(struct btrfs_super_block *sb, unsigned sbflags)
 	}
 	csum_size = btrfs_super_csum_size(sb);
 
-	btrfs_csum_data(csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
+	btrfs_csum_data(NULL, csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
 			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 
 	if (memcmp(result, sb->csum, csum_size)) {
@@ -1640,8 +1642,8 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
 	}
 	if (fs_info->super_bytenr != BTRFS_SUPER_INFO_OFFSET) {
 		btrfs_set_super_bytenr(sb, fs_info->super_bytenr);
-		btrfs_csum_data(csum_type, (u8 *)sb + BTRFS_CSUM_SIZE, result,
-				BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
+		btrfs_csum_data(fs_info, csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
+			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 		memcpy(&sb->csum[0], result, BTRFS_CSUM_SIZE);
 
 		/*
@@ -1675,8 +1677,8 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
 
 		btrfs_set_super_bytenr(sb, bytenr);
 
-		btrfs_csum_data(csum_type, (u8 *)sb + BTRFS_CSUM_SIZE, result,
-				      BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
+		btrfs_csum_data(fs_info, csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
+			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 		memcpy(&sb->csum[0], result, BTRFS_CSUM_SIZE);
 
 		/*
diff --git a/disk-io.h b/disk-io.h
index 545cacda9a79..bb093ae69d57 100644
--- a/disk-io.h
+++ b/disk-io.h
@@ -186,7 +186,8 @@ int btrfs_free_fs_root(struct btrfs_root *root);
 void btrfs_mark_buffer_dirty(struct extent_buffer *buf);
 int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid);
 int btrfs_set_buffer_uptodate(struct extent_buffer *buf);
-int btrfs_csum_data(u16 csum_type, const u8 *data, u8 *out, size_t len);
+int btrfs_csum_data(struct btrfs_fs_info *fs_info, u16 csum_type,
+		    const u8 *data, u8 *out, size_t len);
 
 int btrfs_open_device(struct btrfs_device *dev);
 int csum_tree_block_size(struct extent_buffer *buf, u16 csum_sectorsize,
diff --git a/file-item.c b/file-item.c
index 64af57693baf..fb84fbd6d54f 100644
--- a/file-item.c
+++ b/file-item.c
@@ -315,7 +315,7 @@ csum:
 	item = (struct btrfs_csum_item *)((unsigned char *)item +
 					  csum_offset * csum_size);
 found:
-	btrfs_csum_data(csum_type, (u8 *)data, csum_result, len);
+	btrfs_csum_data(root->fs_info, csum_type, (u8 *)data, csum_result, len);
 	/* FIXME: does not make sense for non-crc32c */
 	if (csum_result == 0) {
 		printk("csum result is 0 for block %llu\n",
-- 
2.16.4

