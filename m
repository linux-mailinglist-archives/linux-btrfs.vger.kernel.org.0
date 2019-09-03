Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF613A6C1C
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Sep 2019 17:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbfICPA5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Sep 2019 11:00:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:57510 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729706AbfICPAv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Sep 2019 11:00:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7BBF6AF38;
        Tue,  3 Sep 2019 15:00:48 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v4 10/12] btrfs-progs: add xxhash64 as checksum algorithm
Date:   Tue,  3 Sep 2019 17:00:44 +0200
Message-Id: <20190903150046.14926-11-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190903150046.14926-1-jthumshirn@suse.de>
References: <20190903150046.14926-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: David Sterba <dsterba@suse.com>

Add xxhash64 as another checksumming algorithm.

Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

---
Changes to v3:
- Fix usage of is_valid_csum_type() (Nikolay)
- Remove unrelated whitespace change (Nikolay)

Changes to v2:
- Integrated comments from Nikolay
---
 Makefile                  |  3 ++-
 cmds/inspect-dump-super.c | 24 +++++++++++++++---------
 convert/common.c          |  2 +-
 convert/main.c            |  2 +-
 crypto/hash.c             | 16 ++++++++++++++++
 crypto/hash.h             | 10 ++++++++++
 ctree.h                   | 14 ++++++++++----
 disk-io.c                 |  7 +++++--
 image/main.c              |  5 +++--
 mkfs/common.c             | 14 +++++++-------
 mkfs/main.c               |  6 +++++-
 11 files changed, 75 insertions(+), 28 deletions(-)
 create mode 100644 crypto/hash.c
 create mode 100644 crypto/hash.h

diff --git a/Makefile b/Makefile
index 370e0c37ff65..45530749e2b9 100644
--- a/Makefile
+++ b/Makefile
@@ -151,7 +151,8 @@ cmds_objects = cmds/subvolume.o cmds/filesystem.o cmds/device.o cmds/scrub.o \
 	       mkfs/common.o check/mode-common.o check/mode-lowmem.o
 libbtrfs_objects = send-stream.o send-utils.o kernel-lib/rbtree.o btrfs-list.o \
 		   kernel-lib/crc32c.o common/messages.o \
-		   uuid-tree.o utils-lib.o common/rbtree-utils.o
+		   uuid-tree.o utils-lib.o common/rbtree-utils.o \
+		   crypto/hash.o crypto/xxhash.o
 libbtrfs_headers = send-stream.h send-utils.h send.h kernel-lib/rbtree.h btrfs-list.h \
 	       kernel-lib/crc32c.h kernel-lib/list.h kerncompat.h \
 	       kernel-lib/radix-tree.h kernel-lib/sizes.h kernel-lib/raid56.h \
diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index 58bf82b0bbd3..f9f38751f429 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -311,6 +311,17 @@ static void print_readable_super_flag(u64 flag)
 				     super_flags_num, BTRFS_SUPER_FLAG_SUPP);
 }
 
+static bool is_valid_csum_type(u16 csum_type)
+{
+	switch (csum_type) {
+	case BTRFS_CSUM_TYPE_CRC32:
+	case BTRFS_CSUM_TYPE_XXHASH:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static void dump_superblock(struct btrfs_super_block *sb, int full)
 {
 	int i;
@@ -326,15 +337,11 @@ static void dump_superblock(struct btrfs_super_block *sb, int full)
 	csum_type = btrfs_super_csum_type(sb);
 	csum_size = BTRFS_CSUM_SIZE;
 	printf("csum_type\t\t%hu (", csum_type);
-	if (csum_type >= ARRAY_SIZE(btrfs_csum_sizes)) {
+	if (!is_valid_csum_type(csum_type)) {
 		printf("INVALID");
 	} else {
-		if (csum_type == BTRFS_CSUM_TYPE_CRC32) {
-			printf("crc32c");
-			csum_size = btrfs_csum_sizes[csum_type];
-		} else {
-			printf("unknown");
-		}
+		printf("%s", btrfs_csums[csum_type].name);
+		csum_size = btrfs_csums[csum_type].size;
 	}
 	printf(")\n");
 	printf("csum_size\t\t%llu\n", (unsigned long long)csum_size);
@@ -342,8 +349,7 @@ static void dump_superblock(struct btrfs_super_block *sb, int full)
 	printf("csum\t\t\t0x");
 	for (i = 0, p = sb->csum; i < csum_size; i++)
 		printf("%02x", p[i]);
-	if (csum_type != BTRFS_CSUM_TYPE_CRC32 ||
-	    csum_size != btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32])
+	if (!is_valid_csum_type(csum_type))
 		printf(" [UNKNOWN CSUM TYPE OR SIZE]");
 	else if (check_csum_sblock(sb, csum_size, csum_type))
 		printf(" [match]");
diff --git a/convert/common.c b/convert/common.c
index 2e2318a5863e..5dd1a2644bf6 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -224,7 +224,7 @@ static inline int write_temp_extent_buffer(int fd, struct extent_buffer *buf,
 {
 	int ret;
 
-	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
+	csum_tree_block_size(buf, btrfs_csums[cfg->csum_type].size, 0,
 			     cfg->csum_type);
 
 	/* Temporary extent buffer is always mapped 1:1 on disk */
diff --git a/convert/main.c b/convert/main.c
index 5e6b12431f59..5eb2a59fb68a 100644
--- a/convert/main.c
+++ b/convert/main.c
@@ -1058,7 +1058,7 @@ static int migrate_super_block(int fd, u64 old_bytenr)
 	BUG_ON(btrfs_super_bytenr(super) != old_bytenr);
 	btrfs_set_super_bytenr(super, BTRFS_SUPER_INFO_OFFSET);
 
-	csum_tree_block_size(buf, btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32], 0,
+	csum_tree_block_size(buf, btrfs_csums[BTRFS_CSUM_TYPE_CRC32].size, 0,
 			     btrfs_super_csum_type(super));
 	ret = pwrite(fd, buf->data, BTRFS_SUPER_INFO_SIZE,
 		BTRFS_SUPER_INFO_OFFSET);
diff --git a/crypto/hash.c b/crypto/hash.c
new file mode 100644
index 000000000000..fda7fc4e9f23
--- /dev/null
+++ b/crypto/hash.c
@@ -0,0 +1,16 @@
+#include "crypto/hash.h"
+#include "crypto/xxhash.h"
+
+int hash_xxhash(const u8 *buf, size_t length, u8 *out)
+{
+	XXH64_hash_t hash;
+
+	hash = XXH64(buf, length, 0);
+	/* NOTE: we're not taking the canonical form here but the plain hash to
+	 * be compatible with the kernel implementation!
+	 */
+	memcpy(out, &hash, 8);
+
+	return 0;
+}
+
diff --git a/crypto/hash.h b/crypto/hash.h
new file mode 100644
index 000000000000..45c1ef17bc57
--- /dev/null
+++ b/crypto/hash.h
@@ -0,0 +1,10 @@
+#ifndef CRYPTO_HASH_H
+#define CRYPTO_HASH_H
+
+#include "../kerncompat.h"
+
+#define CRYPTO_HASH_SIZE_MAX	32
+
+int hash_xxhash(const u8 *buf, size_t length, u8 *out);
+
+#endif
diff --git a/ctree.h b/ctree.h
index 870d9f4948de..4ded8161d149 100644
--- a/ctree.h
+++ b/ctree.h
@@ -167,10 +167,16 @@ struct btrfs_free_space_ctl;
 /* csum types */
 enum btrfs_csum_type {
 	BTRFS_CSUM_TYPE_CRC32	= 0,
+	BTRFS_CSUM_TYPE_XXHASH	= 1,
 };
 
-/* four bytes for CRC32 */
-static int btrfs_csum_sizes[] = { 4 };
+static struct btrfs_csum {
+	u16 size;
+	const char *name;
+} btrfs_csums[] = {
+	[BTRFS_CSUM_TYPE_CRC32] = { 4, "crc32c" },
+	[BTRFS_CSUM_TYPE_XXHASH] = { 8, "xxhash64" },
+};
 
 #define BTRFS_EMPTY_DIR_SIZE 0
 
@@ -2266,8 +2272,8 @@ BTRFS_SETGET_STACK_FUNCS(super_magic, struct btrfs_super_block, magic, 64);
 static inline int btrfs_super_csum_size(struct btrfs_super_block *s)
 {
 	int t = btrfs_super_csum_type(s);
-	BUG_ON(t >= ARRAY_SIZE(btrfs_csum_sizes));
-	return btrfs_csum_sizes[t];
+	BUG_ON(t >= ARRAY_SIZE(btrfs_csums));
+	return btrfs_csums[t].size;
 }
 
 static inline unsigned long btrfs_leaf_data(struct extent_buffer *l)
diff --git a/disk-io.c b/disk-io.c
index 810c2e14294a..ce0b746f4db9 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -34,6 +34,7 @@
 #include "print-tree.h"
 #include "common/rbtree-utils.h"
 #include "common/device-scan.h"
+#include "crypto/hash.h"
 
 /* specified errno for check_tree_block */
 #define BTRFS_BAD_BYTENR		(-1)
@@ -148,6 +149,8 @@ int btrfs_csum_data(u16 csum_type, const u8 *data, u8 *out, size_t len)
 		crc = crc32c(crc, data, len);
 		put_unaligned_le32(~crc, out);
 		return 0;
+	case BTRFS_CSUM_TYPE_XXHASH:
+		return hash_xxhash(data, len, out);
 	default:
 		fprintf(stderr, "ERROR: unknown csum type: %d\n", csum_type);
 		ASSERT(0);
@@ -1376,11 +1379,11 @@ int btrfs_check_super(struct btrfs_super_block *sb, unsigned sbflags)
 	}
 
 	csum_type = btrfs_super_csum_type(sb);
-	if (csum_type >= ARRAY_SIZE(btrfs_csum_sizes)) {
+	if (csum_type >= ARRAY_SIZE(btrfs_csums)) {
 		error("unsupported checksum algorithm %u", csum_type);
 		return -EIO;
 	}
-	csum_size = btrfs_csum_sizes[csum_type];
+	csum_size = btrfs_csums[csum_type].size;
 
 	btrfs_csum_data(csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
 			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
diff --git a/image/main.c b/image/main.c
index 0c8ffede56f5..1265152cf524 100644
--- a/image/main.c
+++ b/image/main.c
@@ -121,11 +121,12 @@ static struct extent_buffer *alloc_dummy_eb(u64 bytenr, u32 size);
 
 static void csum_block(u8 *buf, size_t len)
 {
-	u8 result[btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32]];
+	u16 csum_size = btrfs_csums[BTRFS_CSUM_TYPE_CRC32].size;
+	u8 result[csum_size];
 	u32 crc = ~(u32)0;
 	crc = crc32c(crc, buf + BTRFS_CSUM_SIZE, len - BTRFS_CSUM_SIZE);
 	put_unaligned_le32(~crc, result);
-	memcpy(buf, result, btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32]);
+	memcpy(buf, result, csum_size);
 }
 
 static int has_name(struct btrfs_key *key)
diff --git a/mkfs/common.c b/mkfs/common.c
index 4a417bd7a306..939be5eb2dc2 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -101,7 +101,7 @@ static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
 	}
 
 	/* generate checksum */
-	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
+	csum_tree_block_size(buf, btrfs_csums[cfg->csum_type].size, 0,
 			     cfg->csum_type);
 
 	/* write back root tree */
@@ -293,7 +293,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_EXTENT_TREE]);
 	btrfs_set_header_owner(buf, BTRFS_EXTENT_TREE_OBJECTID);
 	btrfs_set_header_nritems(buf, nritems);
-	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
+	csum_tree_block_size(buf, btrfs_csums[cfg->csum_type].size, 0,
 			     cfg->csum_type);
 	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_EXTENT_TREE]);
 	if (ret != cfg->nodesize) {
@@ -382,7 +382,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_CHUNK_TREE]);
 	btrfs_set_header_owner(buf, BTRFS_CHUNK_TREE_OBJECTID);
 	btrfs_set_header_nritems(buf, nritems);
-	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
+	csum_tree_block_size(buf, btrfs_csums[cfg->csum_type].size, 0,
 			     cfg->csum_type);
 	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_CHUNK_TREE]);
 	if (ret != cfg->nodesize) {
@@ -423,7 +423,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_DEV_TREE]);
 	btrfs_set_header_owner(buf, BTRFS_DEV_TREE_OBJECTID);
 	btrfs_set_header_nritems(buf, nritems);
-	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
+	csum_tree_block_size(buf, btrfs_csums[cfg->csum_type].size, 0,
 			     cfg->csum_type);
 	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_DEV_TREE]);
 	if (ret != cfg->nodesize) {
@@ -437,7 +437,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_FS_TREE]);
 	btrfs_set_header_owner(buf, BTRFS_FS_TREE_OBJECTID);
 	btrfs_set_header_nritems(buf, 0);
-	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
+	csum_tree_block_size(buf, btrfs_csums[cfg->csum_type].size, 0,
 			     cfg->csum_type);
 	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_FS_TREE]);
 	if (ret != cfg->nodesize) {
@@ -450,7 +450,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_CSUM_TREE]);
 	btrfs_set_header_owner(buf, BTRFS_CSUM_TREE_OBJECTID);
 	btrfs_set_header_nritems(buf, 0);
-	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
+	csum_tree_block_size(buf, btrfs_csums[cfg->csum_type].size, 0,
 			     cfg->csum_type);
 	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_CSUM_TREE]);
 	if (ret != cfg->nodesize) {
@@ -462,7 +462,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	memset(buf->data, 0, BTRFS_SUPER_INFO_SIZE);
 	memcpy(buf->data, &super, sizeof(super));
 	buf->len = BTRFS_SUPER_INFO_SIZE;
-	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
+	csum_tree_block_size(buf, btrfs_csums[cfg->csum_type].size, 0,
 			     cfg->csum_type);
 	ret = pwrite(fd, buf->data, BTRFS_SUPER_INFO_SIZE,
 			cfg->blocks[MKFS_SUPER_BLOCK]);
diff --git a/mkfs/main.c b/mkfs/main.c
index e96cbc5399a2..64806dac7706 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -391,6 +391,9 @@ static enum btrfs_csum_type parse_csum_type(const char *s)
 {
 	if (strcasecmp(s, "crc32c") == 0) {
 		return BTRFS_CSUM_TYPE_CRC32;
+	} else if (strcasecmp(s, "xxhash64") == 0 ||
+		   strcasecmp(s, "xxhash") == 0) {
+		return BTRFS_CSUM_TYPE_XXHASH;
 	} else {
 		error("unknown csum type %s", s);
 		exit(1);
@@ -1376,7 +1379,8 @@ raid_groups:
 			pretty_size(allocation.system));
 		printf("SSD detected:       %s\n", ssd ? "yes" : "no");
 		btrfs_parse_features_to_string(features_buf, features);
-		printf("Incompat features:  %s", features_buf);
+		printf("Incompat features:  %s\n", features_buf);
+		printf("Checksum:           %s", btrfs_csums[csum_type].name);
 		printf("\n");
 
 		list_all_devices(root);
-- 
2.16.4

