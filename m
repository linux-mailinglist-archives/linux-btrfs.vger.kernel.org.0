Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 119CEA6C15
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2019 17:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbfICPAw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Sep 2019 11:00:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:57500 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729696AbfICPAv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Sep 2019 11:00:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4CAB9AF06;
        Tue,  3 Sep 2019 15:00:48 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v4 07/12] btrfs-progs: update checksumming api
Date:   Tue,  3 Sep 2019 17:00:41 +0200
Message-Id: <20190903150046.14926-8-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190903150046.14926-1-jthumshirn@suse.de>
References: <20190903150046.14926-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: David Sterba <dsterba@suse.com>

Update the checksumming API to be able to cope with more checksum types
than just CRC32C.

Co-developed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 btrfs-sb-mod.c              | 21 ++++++----------
 check/main.c                | 20 +++++++--------
 cmds/inspect-dump-super.c   |  9 +++----
 cmds/rescue-chunk-recover.c | 12 ++++++---
 convert/common.c            |  9 +++----
 disk-io.c                   | 59 ++++++++++++++++++---------------------------
 disk-io.h                   |  3 +--
 file-item.c                 |  8 +++---
 8 files changed, 60 insertions(+), 81 deletions(-)

diff --git a/btrfs-sb-mod.c b/btrfs-sb-mod.c
index 9e64b34d2b8f..105b556b0cf1 100644
--- a/btrfs-sb-mod.c
+++ b/btrfs-sb-mod.c
@@ -33,31 +33,24 @@ static int csum_size;
 
 static int check_csum_superblock(void *sb)
 {
-	u8 result[csum_size];
-	u32 crc = ~(u32)0;
+	u8 result[BTRFS_CSUM_SIZE];
 	u16 csum_type = btrfs_super_csum_type(sb);
 
-	crc = btrfs_csum_data(csum_type,
-			      (char *)sb + BTRFS_CSUM_SIZE,
-				(u8 *)&crc,
-				BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
-	btrfs_csum_final(csum_type, crc, result);
+	btrfs_csum_data(csum_type, (char *)sb + BTRFS_CSUM_SIZE,
+			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 
-	return !memcmp(sb, &result, csum_size);
+	return !memcmp(sb, result, csum_size);
 }
 
 static void update_block_csum(void *block)
 {
-	u8 result[csum_size];
+	u8 result[BTRFS_CSUM_SIZE];
 	struct btrfs_header *hdr;
-	u32 crc = ~(u32)0;
 	u16 csum_type = btrfs_super_csum_type(block);
 
-	crc = btrfs_csum_data(csum_type, (char *)block + BTRFS_CSUM_SIZE,
-			      (u8 *)&crc,
-			      BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
+	btrfs_csum_data(csum_type, (char *)block + BTRFS_CSUM_SIZE,
+			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 
-	btrfs_csum_final(csum_type, crc, result);
 	memset(block, 0, BTRFS_CSUM_SIZE);
 	hdr = (struct btrfs_header *)block;
 	memcpy(&hdr->csum, result, csum_size);
diff --git a/check/main.c b/check/main.c
index 1896a28f157d..5028599a773a 100644
--- a/check/main.c
+++ b/check/main.c
@@ -5620,10 +5620,10 @@ static int check_extent_csums(struct btrfs_root *root, u64 bytenr,
 	u64 offset = 0;
 	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
 	u16 csum_type = btrfs_super_csum_type(fs_info->super_copy);
-	char *data;
+	u8 *data;
 	unsigned long csum_offset;
-	u32 csum;
-	u32 csum_expected;
+	u8 result[BTRFS_CSUM_SIZE];
+	u8 csum_expected[BTRFS_CSUM_SIZE];
 	u64 read_len;
 	u64 data_checked = 0;
 	u64 tmp;
@@ -5649,7 +5649,7 @@ static int check_extent_csums(struct btrfs_root *root, u64 bytenr,
 		for (mirror = 1; mirror <= num_copies; mirror++) {
 			read_len = num_bytes - offset;
 			/* read as much space once a time */
-			ret = read_extent_data(fs_info, data + offset,
+			ret = read_extent_data(fs_info, (char *)data + offset,
 					bytenr + offset, &read_len, mirror);
 			if (ret)
 				goto out;
@@ -5657,24 +5657,22 @@ static int check_extent_csums(struct btrfs_root *root, u64 bytenr,
 			data_checked = 0;
 			/* verify every 4k data's checksum */
 			while (data_checked < read_len) {
-				csum = ~(u32)0;
 				tmp = offset + data_checked;
 
-				csum = btrfs_csum_data(csum_type,
-						       (char *)data + tmp,
-						(u8 *)&csum, fs_info->sectorsize);
-				btrfs_csum_final(csum_type, csum, (u8 *)&csum);
+				btrfs_csum_data(csum_type, data + tmp,
+						result, fs_info->sectorsize);
 
 				csum_offset = leaf_offset +
 					 tmp / fs_info->sectorsize * csum_size;
 				read_extent_buffer(eb, (char *)&csum_expected,
 						   csum_offset, csum_size);
-				if (csum != csum_expected) {
+				if (memcmp(result, csum_expected, csum_size) != 0) {
 					csum_mismatch = true;
+					/* FIXME: format */
 					fprintf(stderr,
 			"mirror %d bytenr %llu csum %u expected csum %u\n",
 						mirror, bytenr + tmp,
-						csum, csum_expected);
+						result[0], csum_expected[0]);
 				}
 				data_checked += fs_info->sectorsize;
 			}
diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index 40019a6670ef..58bf82b0bbd3 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -38,14 +38,11 @@
 static int check_csum_sblock(void *sb, int csum_size, u16 csum_type)
 {
 	u8 result[BTRFS_CSUM_SIZE];
-	u32 crc = ~(u32)0;
 
-	crc = btrfs_csum_data(csum_type, (char *)sb + BTRFS_CSUM_SIZE,
-				(u8 *)&crc,
-				BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
-	btrfs_csum_final(csum_type, crc, result);
+	btrfs_csum_data(csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
+			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 
-	return !memcmp(sb, &result, csum_size);
+	return !memcmp(sb, result, csum_size);
 }
 
 static void print_sys_chunk_array(struct btrfs_super_block *sb)
diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
index d556323ec34a..329a608dfc6b 100644
--- a/cmds/rescue-chunk-recover.c
+++ b/cmds/rescue-chunk-recover.c
@@ -1892,7 +1892,11 @@ static int check_one_csum(int fd, u64 start, u32 len, u32 tree_csum,
 {
 	char *data;
 	int ret = 0;
-	u32 csum_result = ~(u32)0;
+	u8 result[BTRFS_CSUM_SIZE];
+	int csum_size = 0;
+	u8 expected_csum[BTRFS_CSUM_SIZE];
+
+	ASSERT(0);
 
 	data = malloc(len);
 	if (!data)
@@ -1903,9 +1907,9 @@ static int check_one_csum(int fd, u64 start, u32 len, u32 tree_csum,
 		goto out;
 	}
 	ret = 0;
-	csum_result = btrfs_csum_data(csum_type, data, (u8 *)&csum_result, len);
-	btrfs_csum_final(csum_type, csum_result, (u8 *)&csum_result);
-	if (csum_result != tree_csum)
+	put_unaligned_le32(tree_csum, expected_csum);
+	btrfs_csum_data(csum_type, (u8 *)data, result, len);
+	if (memcmp(result, expected_csum, csum_size) != 0)
 		ret = 1;
 out:
 	free(data);
diff --git a/convert/common.c b/convert/common.c
index 894a6ee0ba90..8cae507ec0f7 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -62,14 +62,13 @@ static int reserve_free_space(struct cache_tree *free_tree, u64 len,
 static inline int write_temp_super(int fd, struct btrfs_super_block *sb,
                                   u64 sb_bytenr)
 {
-       u32 crc = ~(u32)0;
+       u8 result[BTRFS_CSUM_SIZE];
        u16 csum_type = btrfs_super_csum_type(sb);
        int ret;
 
-       crc = btrfs_csum_data(csum_type, (char *)sb + BTRFS_CSUM_SIZE,
-			     (u8 *)&crc,
-                             BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
-       btrfs_csum_final(csum_type, crc, &sb->csum[0]);
+       btrfs_csum_data(csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
+		       result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
+       memcpy(&sb->csum[0], result, BTRFS_CSUM_SIZE);
        ret = pwrite(fd, sb, BTRFS_SUPER_INFO_SIZE, sb_bytenr);
        if (ret < BTRFS_SUPER_INFO_SIZE)
                ret = (ret < 0 ? -errno : -EIO);
diff --git a/disk-io.c b/disk-io.c
index 7e538969c57a..810c2e14294a 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -138,26 +138,22 @@ static void print_tree_block_error(struct btrfs_fs_info *fs_info,
 	}
 }
 
-u32 btrfs_csum_data(u16 csum_type, char *data, u8 *seed, size_t len)
+int btrfs_csum_data(u16 csum_type, const u8 *data, u8 *out, size_t len)
 {
-	switch (csum_type) {
-	case BTRFS_CSUM_TYPE_CRC32:
-		return crc32c(*(u32*)seed, data, len);
-	default: /* Not reached */
-		return ~(u32)0;
-	}
-
-}
+	u32 crc = ~(u32)0;
+	memset(out, 0, BTRFS_CSUM_SIZE);
 
-void btrfs_csum_final(u16 csum_type, u32 crc, u8 *result)
-{
 	switch (csum_type) {
 	case BTRFS_CSUM_TYPE_CRC32:
-		put_unaligned_le32(~crc, result);
-		break;
-	default: /* Not reached */
-		break;
+		crc = crc32c(crc, data, len);
+		put_unaligned_le32(~crc, out);
+		return 0;
+	default:
+		fprintf(stderr, "ERROR: unknown csum type: %d\n", csum_type);
+		ASSERT(0);
 	}
+
+	return -1;
 }
 
 static int __csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
@@ -165,20 +161,19 @@ static int __csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
 {
 	u8 result[BTRFS_CSUM_SIZE];
 	u32 len;
-	u32 crc = ~(u32)0;
 
 	len = buf->len - BTRFS_CSUM_SIZE;
-	crc = btrfs_csum_data(csum_type, buf->data + BTRFS_CSUM_SIZE,
-			      (u8 *)&crc, len);
-	btrfs_csum_final(csum_type, crc, result);
+	btrfs_csum_data(csum_type, (u8 *)buf->data + BTRFS_CSUM_SIZE,
+			result, len);
 
 	if (verify) {
 		if (memcmp_extent_buffer(buf, result, 0, csum_size)) {
+			/* FIXME: format */
 			if (!silent)
 				printk("checksum verify failed on %llu found %08X wanted %08X\n",
 				       (unsigned long long)buf->start,
-				       *((u32 *)result),
-				       *((u32*)(char *)buf->data));
+				       result[0],
+				       buf->data[0]);
 			return 1;
 		}
 	} else {
@@ -1367,7 +1362,6 @@ struct btrfs_root *open_ctree_fd(int fp, const char *path, u64 sb_bytenr,
 int btrfs_check_super(struct btrfs_super_block *sb, unsigned sbflags)
 {
 	u8 result[BTRFS_CSUM_SIZE];
-	u32 crc;
 	u16 csum_type;
 	int csum_size;
 	u8 *metadata_uuid;
@@ -1388,11 +1382,8 @@ int btrfs_check_super(struct btrfs_super_block *sb, unsigned sbflags)
 	}
 	csum_size = btrfs_csum_sizes[csum_type];
 
-	crc = ~(u32)0;
-	crc = btrfs_csum_data(csum_type,(char *)sb + BTRFS_CSUM_SIZE,
-			      (u8 *)&crc,
-			      BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
-	btrfs_csum_final(csum_type, crc, result);
+	btrfs_csum_data(csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
+			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 
 	if (memcmp(result, sb->csum, csum_size)) {
 		error("superblock checksum mismatch");
@@ -1628,7 +1619,7 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
 			    struct btrfs_device *device)
 {
 	u64 bytenr;
-	u32 crc;
+	u8 result[BTRFS_CSUM_SIZE];
 	int i, ret;
 	u16 csum_type = btrfs_super_csum_type(sb);
 
@@ -1645,10 +1636,9 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
 	}
 	if (fs_info->super_bytenr != BTRFS_SUPER_INFO_OFFSET) {
 		btrfs_set_super_bytenr(sb, fs_info->super_bytenr);
-		crc = ~(u32)0;
-		crc = btrfs_csum_data(csum_type, (char *)sb + BTRFS_CSUM_SIZE, (u8 *)&crc,
-				      BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
-		btrfs_csum_final(csum_type, crc, &sb->csum[0]);
+		btrfs_csum_data(csum_type, (u8 *)sb + BTRFS_CSUM_SIZE, result,
+				BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
+		memcpy(&sb->csum[0], result, BTRFS_CSUM_SIZE);
 
 		/*
 		 * super_copy is BTRFS_SUPER_INFO_SIZE bytes and is
@@ -1681,10 +1671,9 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
 
 		btrfs_set_super_bytenr(sb, bytenr);
 
-		crc = ~(u32)0;
-		crc = btrfs_csum_data(csum_type, (char *)sb + BTRFS_CSUM_SIZE, (u8 *)&crc,
+		btrfs_csum_data(csum_type, (u8 *)sb + BTRFS_CSUM_SIZE, result,
 				      BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
-		btrfs_csum_final(csum_type, crc, &sb->csum[0]);
+		memcpy(&sb->csum[0], result, BTRFS_CSUM_SIZE);
 
 		/*
 		 * super_copy is BTRFS_SUPER_INFO_SIZE bytes and is
diff --git a/disk-io.h b/disk-io.h
index 4b5e9ea86385..545cacda9a79 100644
--- a/disk-io.h
+++ b/disk-io.h
@@ -186,8 +186,7 @@ int btrfs_free_fs_root(struct btrfs_root *root);
 void btrfs_mark_buffer_dirty(struct extent_buffer *buf);
 int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid);
 int btrfs_set_buffer_uptodate(struct extent_buffer *buf);
-u32 btrfs_csum_data(u16 csum_type, char *data, u8 *seed, size_t len);
-void btrfs_csum_final(u16 csum_type, u32 crc, u8 *result);
+int btrfs_csum_data(u16 csum_type, const u8 *data, u8 *out, size_t len);
 
 int btrfs_open_device(struct btrfs_device *dev);
 int csum_tree_block_size(struct extent_buffer *buf, u16 csum_sectorsize,
diff --git a/file-item.c b/file-item.c
index 78fdcecd0bab..c6e9d212bcab 100644
--- a/file-item.c
+++ b/file-item.c
@@ -195,7 +195,7 @@ int btrfs_csum_file_block(struct btrfs_trans_handle *trans,
 	struct btrfs_csum_item *item;
 	struct extent_buffer *leaf = NULL;
 	u64 csum_offset;
-	u32 csum_result = ~(u32)0;
+	u8 csum_result[BTRFS_CSUM_SIZE];
 	u32 sectorsize = root->fs_info->sectorsize;
 	u32 nritems;
 	u32 ins_size;
@@ -315,14 +315,14 @@ csum:
 	item = (struct btrfs_csum_item *)((unsigned char *)item +
 					  csum_offset * csum_size);
 found:
-	csum_result = btrfs_csum_data(csum_type, data, (u8 *)&csum_result, len);
-	btrfs_csum_final(csum_type, csum_result, (u8 *)&csum_result);
+	btrfs_csum_data(csum_type, (u8 *)data, csum_result, len);
+	/* FIXME: does not make sense for non-crc32c */
 	if (csum_result == 0) {
 		printk("csum result is 0 for block %llu\n",
 		       (unsigned long long)bytenr);
 	}
 
-	write_extent_buffer(leaf, &csum_result, (unsigned long)item,
+	write_extent_buffer(leaf, csum_result, (unsigned long)item,
 			    csum_size);
 	btrfs_mark_buffer_dirty(path->nodes[0]);
 fail:
-- 
2.16.4

