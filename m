Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27A32A6C13
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2019 17:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbfICPAu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Sep 2019 11:00:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:57462 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729678AbfICPAt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Sep 2019 11:00:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3024AAEA1;
        Tue,  3 Sep 2019 15:00:48 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v4 04/12] btrfs-progs: don't assume checksums are always 4 bytes
Date:   Tue,  3 Sep 2019 17:00:38 +0200
Message-Id: <20190903150046.14926-5-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190903150046.14926-1-jthumshirn@suse.de>
References: <20190903150046.14926-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 btrfs-sb-mod.c              |  9 ++++++---
 check/main.c                |  2 +-
 cmds/inspect-dump-super.c   |  3 ++-
 cmds/rescue-chunk-recover.c |  2 +-
 convert/common.c            |  3 ++-
 disk-io.c                   | 12 ++++++------
 disk-io.h                   |  2 +-
 file-item.c                 |  2 +-
 8 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/btrfs-sb-mod.c b/btrfs-sb-mod.c
index 16a26f772494..932c2a0432ef 100644
--- a/btrfs-sb-mod.c
+++ b/btrfs-sb-mod.c
@@ -37,7 +37,8 @@ static int check_csum_superblock(void *sb)
 	u32 crc = ~(u32)0;
 
 	crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE,
-				crc, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
+				(u8 *)&crc,
+				BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 	btrfs_csum_final(crc, result);
 
 	return !memcmp(sb, &result, csum_size);
@@ -50,10 +51,12 @@ static void update_block_csum(void *block, int is_sb)
 	u32 crc = ~(u32)0;
 
 	if (is_sb) {
-		crc = btrfs_csum_data((char *)block + BTRFS_CSUM_SIZE, crc,
+		crc = btrfs_csum_data((char *)block + BTRFS_CSUM_SIZE,
+				      (u8 *)&crc,
 				BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 	} else {
-		crc = btrfs_csum_data((char *)block + BTRFS_CSUM_SIZE, crc,
+		crc = btrfs_csum_data((char *)block + BTRFS_CSUM_SIZE,
+				      (u8 *)&crc,
 				BLOCKSIZE - BTRFS_CSUM_SIZE);
 	}
 	btrfs_csum_final(crc, result);
diff --git a/check/main.c b/check/main.c
index 2e16b4e6f05b..0f02c85368ec 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5660,7 +5660,7 @@ static int check_extent_csums(struct btrfs_root *root, u64 bytenr,
 				tmp = offset + data_checked;
 
 				csum = btrfs_csum_data((char *)data + tmp,
-						csum, fs_info->sectorsize);
+						(u8 *)&csum, fs_info->sectorsize);
 				btrfs_csum_final(csum, (u8 *)&csum);
 
 				csum_offset = leaf_offset +
diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index 65fb3506eac6..96ad3deca3d8 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -41,7 +41,8 @@ static int check_csum_sblock(void *sb, int csum_size)
 	u32 crc = ~(u32)0;
 
 	crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE,
-				crc, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
+				(u8 *)&crc,
+				BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 	btrfs_csum_final(crc, result);
 
 	return !memcmp(sb, &result, csum_size);
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index c2a26ad040ee..37c024ed8965 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -1902,7 +1902,7 @@ static int check_one_csum(int fd, u64 start, u32 len, u32 tree_csum)
 		goto out;
 	}
 	ret = 0;
-	csum_result = btrfs_csum_data(data, csum_result, len);
+	csum_result = btrfs_csum_data(data, (u8 *)&csum_result, len);
 	btrfs_csum_final(csum_result, (u8 *)&csum_result);
 	if (csum_result != tree_csum)
 		ret = 1;
diff --git a/convert/common.c b/convert/common.c
index f8bbb23cba89..ab8e6b9f4749 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -65,7 +65,8 @@ static inline int write_temp_super(int fd, struct btrfs_super_block *sb,
        u32 crc = ~(u32)0;
        int ret;
 
-       crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE, crc,
+       crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE,
+			     (u8 *)&crc,
                              BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
        btrfs_csum_final(crc, &sb->csum[0]);
        ret = pwrite(fd, sb, BTRFS_SUPER_INFO_SIZE, sb_bytenr);
diff --git a/disk-io.c b/disk-io.c
index a4995a628210..a0c37c569d58 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -138,9 +138,9 @@ static void print_tree_block_error(struct btrfs_fs_info *fs_info,
 	}
 }
 
-u32 btrfs_csum_data(char *data, u32 seed, size_t len)
+u32 btrfs_csum_data(char *data, u8 *seed, size_t len)
 {
-	return crc32c(seed, data, len);
+	return crc32c(*(u32*)seed, data, len);
 }
 
 void btrfs_csum_final(u32 crc, u8 *result)
@@ -156,7 +156,7 @@ static int __csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
 	u32 crc = ~(u32)0;
 
 	len = buf->len - BTRFS_CSUM_SIZE;
-	crc = btrfs_csum_data(buf->data + BTRFS_CSUM_SIZE, crc, len);
+	crc = btrfs_csum_data(buf->data + BTRFS_CSUM_SIZE, (u8 *)&crc, len);
 	btrfs_csum_final(crc, result);
 
 	if (verify) {
@@ -1376,7 +1376,7 @@ int btrfs_check_super(struct btrfs_super_block *sb, unsigned sbflags)
 	csum_size = btrfs_csum_sizes[csum_type];
 
 	crc = ~(u32)0;
-	crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE, crc,
+	crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE, (u8 *)&crc,
 			      BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 	btrfs_csum_final(crc, result);
 
@@ -1631,7 +1631,7 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
 	if (fs_info->super_bytenr != BTRFS_SUPER_INFO_OFFSET) {
 		btrfs_set_super_bytenr(sb, fs_info->super_bytenr);
 		crc = ~(u32)0;
-		crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE, crc,
+		crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE, (u8 *)&crc,
 				      BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 		btrfs_csum_final(crc, &sb->csum[0]);
 
@@ -1667,7 +1667,7 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
 		btrfs_set_super_bytenr(sb, bytenr);
 
 		crc = ~(u32)0;
-		crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE, crc,
+		crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE, (u8 *)&crc,
 				      BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 		btrfs_csum_final(crc, &sb->csum[0]);
 
diff --git a/disk-io.h b/disk-io.h
index 394997ad72cb..92c87f28f8b2 100644
--- a/disk-io.h
+++ b/disk-io.h
@@ -186,7 +186,7 @@ int btrfs_free_fs_root(struct btrfs_root *root);
 void btrfs_mark_buffer_dirty(struct extent_buffer *buf);
 int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid);
 int btrfs_set_buffer_uptodate(struct extent_buffer *buf);
-u32 btrfs_csum_data(char *data, u32 seed, size_t len);
+u32 btrfs_csum_data(char *data, u8 *seed, size_t len);
 void btrfs_csum_final(u32 crc, u8 *result);
 
 int btrfs_open_device(struct btrfs_device *dev);
diff --git a/file-item.c b/file-item.c
index 3bf48c68913d..5f6548e9a74f 100644
--- a/file-item.c
+++ b/file-item.c
@@ -312,7 +312,7 @@ csum:
 	item = (struct btrfs_csum_item *)((unsigned char *)item +
 					  csum_offset * csum_size);
 found:
-	csum_result = btrfs_csum_data(data, csum_result, len);
+	csum_result = btrfs_csum_data(data, (u8 *)&csum_result, len);
 	btrfs_csum_final(csum_result, (u8 *)&csum_result);
 	if (csum_result == 0) {
 		printk("csum result is 0 for block %llu\n",
-- 
2.16.4

