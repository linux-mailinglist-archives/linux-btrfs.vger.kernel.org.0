Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5854BDF1F
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2019 15:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406655AbfIYNht (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Sep 2019 09:37:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:35650 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2406609AbfIYNht (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Sep 2019 09:37:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D720DB609;
        Wed, 25 Sep 2019 13:37:43 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v5 3/7] btrfs-progs: add table for checksum type and name
Date:   Wed, 25 Sep 2019 15:37:24 +0200
Message-Id: <20190925133728.18027-4-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190925133728.18027-1-jthumshirn@suse.de>
References: <20190925133728.18027-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Adding this table will make extending btrfs-progs with new checksum types
easier.

Also add accessor functions to access the table fields.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 cmds/inspect-dump-super.c |  8 ++------
 convert/common.c          |  2 +-
 convert/main.c            |  4 ++--
 ctree.c                   | 28 ++++++++++++++++++++++++++++
 ctree.h                   | 15 +++++----------
 disk-io.c                 |  4 ++--
 image/main.c              |  5 +++--
 mkfs/common.c             | 14 +++++++-------
 8 files changed, 50 insertions(+), 30 deletions(-)

diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index 272df1bfdc14..bf380ad2b56a 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -339,12 +339,8 @@ static void dump_superblock(struct btrfs_super_block *sb, int full)
 	if (!is_valid_csum_type(csum_type)) {
 		printf("INVALID");
 	} else {
-		if (csum_type == BTRFS_CSUM_TYPE_CRC32) {
-			printf("crc32c");
-			csum_size = btrfs_csum_sizes[csum_type];
-		} else {
-			printf("unknown");
-		}
+		printf("%s", btrfs_super_csum_name(csum_type));
+		csum_size = btrfs_super_csum_size(sb);
 	}
 	printf(")\n");
 	printf("csum_size\t\t%llu\n", (unsigned long long)csum_size);
diff --git a/convert/common.c b/convert/common.c
index 2e2318a5863e..3cb2d9d44881 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -224,7 +224,7 @@ static inline int write_temp_extent_buffer(int fd, struct extent_buffer *buf,
 {
 	int ret;
 
-	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
+	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
 			     cfg->csum_type);
 
 	/* Temporary extent buffer is always mapped 1:1 on disk */
diff --git a/convert/main.c b/convert/main.c
index 611ca7693bde..bb689be9f3e4 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -1058,8 +1058,8 @@ static int migrate_super_block(int fd, u64 old_bytenr)
 	BUG_ON(btrfs_super_bytenr(super) != old_bytenr);
 	btrfs_set_super_bytenr(super, BTRFS_SUPER_INFO_OFFSET);
 
-	csum_tree_block_size(buf, btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32], 0,
-			     btrfs_super_csum_type(super));
+	csum_tree_block_size(buf, btrfs_super_csum_size(super),
+			     0, btrfs_super_csum_type(super));
 	ret = pwrite(fd, buf->data, BTRFS_SUPER_INFO_SIZE,
 		BTRFS_SUPER_INFO_OFFSET);
 	if (ret != BTRFS_SUPER_INFO_SIZE)
diff --git a/ctree.c b/ctree.c
index c97fbb40bb6e..6058c9b660b0 100644
--- a/ctree.c
+++ b/ctree.c
@@ -38,6 +38,34 @@ static int balance_node_right(struct btrfs_trans_handle *trans,
 			      struct extent_buffer *dst_buf,
 			      struct extent_buffer *src_buf);
 
+static struct btrfs_csum {
+	u16 size;
+	const char *name;
+} btrfs_csums[] = {
+	[BTRFS_CSUM_TYPE_CRC32] = { 4, "crc32c" },
+};
+
+u16 btrfs_super_csum_size(const struct btrfs_super_block *sb)
+{
+	u16 csum_type = btrfs_super_csum_type(sb);
+	return btrfs_csums[csum_type].size;
+}
+
+const char *btrfs_super_csum_name(u16 csum_type)
+{
+	return btrfs_csums[csum_type].name;
+}
+
+size_t btrfs_super_num_csums(void)
+{
+	return ARRAY_SIZE(btrfs_csums);
+}
+
+u16 btrfs_csum_type_size(u16 csum_type)
+{
+	return btrfs_csums[csum_type].size;
+}
+
 inline void btrfs_init_path(struct btrfs_path *p)
 {
 	memset(p, 0, sizeof(*p));
diff --git a/ctree.h b/ctree.h
index e0dfb4853b18..f70271dc658e 100644
--- a/ctree.h
+++ b/ctree.h
@@ -169,9 +169,6 @@ enum btrfs_csum_type {
 	BTRFS_CSUM_TYPE_CRC32   = 0,
 };
 
-/* four bytes for CRC32 */
-static int btrfs_csum_sizes[] = { 4 };
-
 #define BTRFS_EMPTY_DIR_SIZE 0
 
 #define BTRFS_FT_UNKNOWN	0
@@ -2263,13 +2260,6 @@ BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generation, struct btrfs_super_block,
 			 uuid_tree_generation, 64);
 BTRFS_SETGET_STACK_FUNCS(super_magic, struct btrfs_super_block, magic, 64);
 
-static inline int btrfs_super_csum_size(struct btrfs_super_block *s)
-{
-	int t = btrfs_super_csum_type(s);
-	BUG_ON(t >= ARRAY_SIZE(btrfs_csum_sizes));
-	return btrfs_csum_sizes[t];
-}
-
 static inline unsigned long btrfs_leaf_data(struct extent_buffer *l)
 {
 	return offsetof(struct btrfs_leaf, items);
@@ -2700,6 +2690,11 @@ void btrfs_set_item_key_unsafe(struct btrfs_root *root,
 			       struct btrfs_path *path,
 			       struct btrfs_key *new_key);
 
+u16 btrfs_super_csum_size(const struct btrfs_super_block *s);
+const char *btrfs_super_csum_name(u16 csum_type);
+u16 btrfs_csum_type_size(u16 csum_type);
+size_t btrfs_super_num_csums(void);
+
 /* root-item.c */
 int btrfs_add_root_ref(struct btrfs_trans_handle *trans,
 		       struct btrfs_root *tree_root,
diff --git a/disk-io.c b/disk-io.c
index 20a6569d259c..72c672919cf9 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -1377,11 +1377,11 @@ int btrfs_check_super(struct btrfs_super_block *sb, unsigned sbflags)
 	}
 
 	csum_type = btrfs_super_csum_type(sb);
-	if (csum_type >= ARRAY_SIZE(btrfs_csum_sizes)) {
+	if (csum_type >= btrfs_super_num_csums()) {
 		error("unsupported checksum algorithm %u", csum_type);
 		return -EIO;
 	}
-	csum_size = btrfs_csum_sizes[csum_type];
+	csum_size = btrfs_super_csum_size(sb);
 
 	btrfs_csum_data(csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
 			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
diff --git a/image/main.c b/image/main.c
index 0c8ffede56f5..f713e47b85cb 100644
--- a/image/main.c
+++ b/image/main.c
@@ -121,11 +121,12 @@ static struct extent_buffer *alloc_dummy_eb(u64 bytenr, u32 size);
 
 static void csum_block(u8 *buf, size_t len)
 {
-	u8 result[btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32]];
+	u16 csum_size = btrfs_csum_type_size(BTRFS_CSUM_TYPE_CRC32);
+	u8 result[csum_size];
 	u32 crc = ~(u32)0;
 	crc = crc32c(crc, buf + BTRFS_CSUM_SIZE, len - BTRFS_CSUM_SIZE);
 	put_unaligned_le32(~crc, result);
-	memcpy(buf, result, btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32]);
+	memcpy(buf, result, csum_size);
 }
 
 static int has_name(struct btrfs_key *key)
diff --git a/mkfs/common.c b/mkfs/common.c
index 4a417bd7a306..469b88d6a8d3 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -101,7 +101,7 @@ static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
 	}
 
 	/* generate checksum */
-	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
+	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
 			     cfg->csum_type);
 
 	/* write back root tree */
@@ -293,7 +293,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_EXTENT_TREE]);
 	btrfs_set_header_owner(buf, BTRFS_EXTENT_TREE_OBJECTID);
 	btrfs_set_header_nritems(buf, nritems);
-	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
+	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
 			     cfg->csum_type);
 	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_EXTENT_TREE]);
 	if (ret != cfg->nodesize) {
@@ -382,7 +382,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_CHUNK_TREE]);
 	btrfs_set_header_owner(buf, BTRFS_CHUNK_TREE_OBJECTID);
 	btrfs_set_header_nritems(buf, nritems);
-	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
+	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
 			     cfg->csum_type);
 	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_CHUNK_TREE]);
 	if (ret != cfg->nodesize) {
@@ -423,7 +423,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_DEV_TREE]);
 	btrfs_set_header_owner(buf, BTRFS_DEV_TREE_OBJECTID);
 	btrfs_set_header_nritems(buf, nritems);
-	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
+	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
 			     cfg->csum_type);
 	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_DEV_TREE]);
 	if (ret != cfg->nodesize) {
@@ -437,7 +437,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_FS_TREE]);
 	btrfs_set_header_owner(buf, BTRFS_FS_TREE_OBJECTID);
 	btrfs_set_header_nritems(buf, 0);
-	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
+	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
 			     cfg->csum_type);
 	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_FS_TREE]);
 	if (ret != cfg->nodesize) {
@@ -450,7 +450,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_CSUM_TREE]);
 	btrfs_set_header_owner(buf, BTRFS_CSUM_TREE_OBJECTID);
 	btrfs_set_header_nritems(buf, 0);
-	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
+	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
 			     cfg->csum_type);
 	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_CSUM_TREE]);
 	if (ret != cfg->nodesize) {
@@ -462,7 +462,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	memset(buf->data, 0, BTRFS_SUPER_INFO_SIZE);
 	memcpy(buf->data, &super, sizeof(super));
 	buf->len = BTRFS_SUPER_INFO_SIZE;
-	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
+	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
 			     cfg->csum_type);
 	ret = pwrite(fd, buf->data, BTRFS_SUPER_INFO_SIZE,
 			cfg->blocks[MKFS_SUPER_BLOCK]);
-- 
2.16.4

