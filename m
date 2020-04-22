Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C861B37D9
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 08:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbgDVGuc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 02:50:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:51104 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgDVGuc (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 02:50:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 24652AB91;
        Wed, 22 Apr 2020 06:50:27 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org,
        u-boot@lists.denx.de
Cc:     marek.behun@nic.cz
Subject: [PATCH U-BOOT 03/26] fs: btrfs: Cross-port btrfs_read_dev_super() from btrfs-progs
Date:   Wed, 22 Apr 2020 14:49:46 +0800
Message-Id: <20200422065009.69392-4-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200422065009.69392-1-wqu@suse.com>
References: <20200422065009.69392-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch will use generic code shared from btrfs-progs to read one
super block from block device.

To support the btrfs-progs style code, the following codes are also
cross-ported:
- BTRFS_SETGET_FUNC for btrfs_super_block
- btrfs_check_super() function
- Move btrfs_read_superblock() to disk-io.[ch]
  Since super.c only contains pretty small amount of code, and
  the extra check will be covered in later root read patches.

The different between this implementation from btrfs-progs are:
- No sbflags/sb_bytenr support
  Since we only need to read the primary super block (like kernel), thus
  sbflags/sb_bytenr used by super block recovery is not needed.

Also, this changes the following behavior of U-boot btrfs:
- Only reads the primary super block
  The old implementation will read all 3 super blocks, with one
  non-existing backup super.
  This is not correct, especially for fs created after btrfs.

  Just like kernel, we only check the primary super block.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/Makefile  |   2 +-
 fs/btrfs/btrfs.c   |   1 +
 fs/btrfs/compat.h  |  56 ++++++++++
 fs/btrfs/ctree.c   |  32 ++++++
 fs/btrfs/ctree.h   |  67 ++++++++++++
 fs/btrfs/disk-io.c | 213 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/disk-io.h |   7 ++
 fs/btrfs/super.c   | 247 ---------------------------------------------
 8 files changed, 377 insertions(+), 248 deletions(-)
 create mode 100644 fs/btrfs/compat.h
 delete mode 100644 fs/btrfs/super.c

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 84b3b5ec0e8a..bd4b848d1b1f 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -3,4 +3,4 @@
 # 2017 Marek Behun, CZ.NIC, marek.behun@nic.cz
 
 obj-y := btrfs.o chunk-map.o compression.o ctree.o dev.o dir-item.o \
-	extent-io.o inode.o root.o subvolume.o super.o crypto/hash.o disk-io.o
+	extent-io.o inode.o root.o subvolume.o crypto/hash.o disk-io.o
diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index 012d8afa2f53..ec993a193106 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -10,6 +10,7 @@
 #include <linux/time.h>
 #include "btrfs.h"
 #include "crypto/hash.h"
+#include "disk-io.h"
 
 struct btrfs_info btrfs_info;
 
diff --git a/fs/btrfs/compat.h b/fs/btrfs/compat.h
new file mode 100644
index 000000000000..376a035cd6db
--- /dev/null
+++ b/fs/btrfs/compat.h
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#ifndef __BTRFS_COMPAT_H__
+#define __BTRFS_COMPAT_H__
+
+#include <linux/errno.h>
+#include <fs_internal.h>
+#include <uuid.h>
+
+/* Provide a compatibility layer to make code syncing easier */
+
+/* A simple wraper to for error() from btrfs-progs */
+#define error(...) { printf(__VA_ARGS__); printf("\n"); }
+
+#define BTRFS_UUID_UNPARSED_SIZE	37
+
+/*
+ * Macros to generate set/get funcs for the struct fields
+ * assume there is a lefoo_to_cpu for every type, so lets make a simple
+ * one for u8:
+ */
+#define le8_to_cpu(v) (v)
+#define cpu_to_le8(v) (v)
+#define __le8 u8
+
+/*
+ * Read data from device specified by @desc and @part
+ *
+ * U-boot equivalent of pread().
+ *
+ * Return the bytes of data read.
+ * Return <0 for error.
+ */
+static inline int __btrfs_devread(struct blk_desc *desc, disk_partition_t *part,
+				  void *buf, size_t size, u64 offset)
+{
+	lbaint_t sector;
+	int byte_offset;
+	int ret;
+
+	sector = offset >> desc->log2blksz;
+	byte_offset = offset % desc->blksz;
+
+	/* fs_devread() return 0 for error, >0 for success */
+	ret = fs_devread(desc, part, sector, byte_offset, size, buf);
+	if (!ret)
+		return -EIO;
+	return size;
+}
+
+static inline void uuid_unparse(const u8 *uuid, char *out)
+{
+	return uuid_bin_to_str((unsigned char *)uuid, out, 0);
+}
+
+#endif
diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 7fae383f1509..bdf8e18fd3ee 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -9,6 +9,38 @@
 #include <malloc.h>
 #include <memalign.h>
 
+static const struct btrfs_csum {
+	u16 size;
+	const char name[14];
+} btrfs_csums[] = {
+	[BTRFS_CSUM_TYPE_CRC32]		= {  4, "crc32c" },
+	[BTRFS_CSUM_TYPE_XXHASH]	= {  8, "xxhash64" },
+	[BTRFS_CSUM_TYPE_SHA256]	= { 32, "sha256" },
+	[BTRFS_CSUM_TYPE_BLAKE2]	= { 32, "blake2" },
+};
+
+u16 btrfs_super_csum_size(const struct btrfs_super_block *sb)
+{
+	const u16 csum_type = btrfs_super_csum_type(sb);
+
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
 int btrfs_comp_keys(struct btrfs_key *a, struct btrfs_key *b)
 {
 	if (a->objectid > b->objectid)
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 156ce69ed022..02125e5e100c 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -12,6 +12,7 @@
 #include <common.h>
 #include <compiler.h>
 #include "kernel-shared/btrfs_tree.h"
+#include "compat.h"
 
 #define BTRFS_MAX_MIRRORS 3
 
@@ -47,6 +48,16 @@
 #define BTRFS_FS_STATE_DEV_REPLACING	3
 #define BTRFS_FS_STATE_DUMMY_FS_INFO	4
 
+#define BTRFS_SETGET_STACK_FUNCS(name, type, member, bits)		\
+static inline u##bits btrfs_##name(const type *s)			\
+{									\
+	return le##bits##_to_cpu(s->member);				\
+}									\
+static inline void btrfs_set_##name(type *s, u##bits val)		\
+{									\
+	s->member = cpu_to_le##bits(val);				\
+}
+
 union btrfs_tree_node {
 	struct btrfs_header header;
 	struct btrfs_leaf leaf;
@@ -122,4 +133,60 @@ static inline void *btrfs_path_leaf_data(struct btrfs_path *p)
 #define btrfs_path_item_ptr(p,t)		\
 	((t *) btrfs_path_leaf_data((p)))
 
+u16 btrfs_super_csum_size(const struct btrfs_super_block *s);
+const char *btrfs_super_csum_name(u16 csum_type);
+u16 btrfs_csum_type_size(u16 csum_type);
+size_t btrfs_super_num_csums(void);
+
+/* struct btrfs_super_block */
+
+BTRFS_SETGET_STACK_FUNCS(super_bytenr, struct btrfs_super_block, bytenr, 64);
+BTRFS_SETGET_STACK_FUNCS(super_flags, struct btrfs_super_block, flags, 64);
+BTRFS_SETGET_STACK_FUNCS(super_generation, struct btrfs_super_block,
+			 generation, 64);
+BTRFS_SETGET_STACK_FUNCS(super_root, struct btrfs_super_block, root, 64);
+BTRFS_SETGET_STACK_FUNCS(super_sys_array_size,
+			 struct btrfs_super_block, sys_chunk_array_size, 32);
+BTRFS_SETGET_STACK_FUNCS(super_chunk_root_generation,
+			 struct btrfs_super_block, chunk_root_generation, 64);
+BTRFS_SETGET_STACK_FUNCS(super_root_level, struct btrfs_super_block,
+			 root_level, 8);
+BTRFS_SETGET_STACK_FUNCS(super_chunk_root, struct btrfs_super_block,
+			 chunk_root, 64);
+BTRFS_SETGET_STACK_FUNCS(super_chunk_root_level, struct btrfs_super_block,
+			 chunk_root_level, 8);
+BTRFS_SETGET_STACK_FUNCS(super_log_root, struct btrfs_super_block,
+			 log_root, 64);
+BTRFS_SETGET_STACK_FUNCS(super_log_root_transid, struct btrfs_super_block,
+			 log_root_transid, 64);
+BTRFS_SETGET_STACK_FUNCS(super_log_root_level, struct btrfs_super_block,
+			 log_root_level, 8);
+BTRFS_SETGET_STACK_FUNCS(super_total_bytes, struct btrfs_super_block,
+			 total_bytes, 64);
+BTRFS_SETGET_STACK_FUNCS(super_bytes_used, struct btrfs_super_block,
+			 bytes_used, 64);
+BTRFS_SETGET_STACK_FUNCS(super_sectorsize, struct btrfs_super_block,
+			 sectorsize, 32);
+BTRFS_SETGET_STACK_FUNCS(super_nodesize, struct btrfs_super_block,
+			 nodesize, 32);
+BTRFS_SETGET_STACK_FUNCS(super_stripesize, struct btrfs_super_block,
+			 stripesize, 32);
+BTRFS_SETGET_STACK_FUNCS(super_root_dir, struct btrfs_super_block,
+			 root_dir_objectid, 64);
+BTRFS_SETGET_STACK_FUNCS(super_num_devices, struct btrfs_super_block,
+			 num_devices, 64);
+BTRFS_SETGET_STACK_FUNCS(super_compat_flags, struct btrfs_super_block,
+			 compat_flags, 64);
+BTRFS_SETGET_STACK_FUNCS(super_compat_ro_flags, struct btrfs_super_block,
+			 compat_ro_flags, 64);
+BTRFS_SETGET_STACK_FUNCS(super_incompat_flags, struct btrfs_super_block,
+			 incompat_flags, 64);
+BTRFS_SETGET_STACK_FUNCS(super_csum_type, struct btrfs_super_block,
+			 csum_type, 16);
+BTRFS_SETGET_STACK_FUNCS(super_cache_generation, struct btrfs_super_block,
+			 cache_generation, 64);
+BTRFS_SETGET_STACK_FUNCS(super_uuid_tree_generation, struct btrfs_super_block,
+			 uuid_tree_generation, 64);
+BTRFS_SETGET_STACK_FUNCS(super_magic, struct btrfs_super_block, magic, 64);
+
 #endif /* __BTRFS_CTREE_H__ */
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 58c32b548e50..819068b936ec 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1,7 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0+
 #include <common.h>
 #include <fs_internal.h>
+#include <uuid.h>
+#include <memalign.h>
+#include "kernel-shared/btrfs_tree.h"
 #include "disk-io.h"
+#include "ctree.h"
+#include "btrfs.h"
 #include "crypto/hash.h"
 
 int btrfs_csum_data(u16 csum_type, const u8 *data, u8 *out, size_t len)
@@ -20,3 +25,211 @@ int btrfs_csum_data(u16 csum_type, const u8 *data, u8 *out, size_t len)
 		return -EINVAL;
 	}
 }
+
+/*
+ * Check if the super is valid:
+ * - nodesize/sectorsize - minimum, maximum, alignment
+ * - tree block starts   - alignment
+ * - number of devices   - something sane
+ * - sys array size      - maximum
+ */
+static int btrfs_check_super(struct btrfs_super_block *sb)
+{
+	u8 result[BTRFS_CSUM_SIZE];
+	u16 csum_type;
+	int csum_size;
+	u8 *metadata_uuid;
+
+	if (btrfs_super_magic(sb) != BTRFS_MAGIC)
+		return -EIO;
+
+	csum_type = btrfs_super_csum_type(sb);
+	if (csum_type >= btrfs_super_num_csums()) {
+		error("unsupported checksum algorithm %u", csum_type);
+		return -EIO;
+	}
+	csum_size = btrfs_super_csum_size(sb);
+
+	btrfs_csum_data(csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
+			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
+
+	if (memcmp(result, sb->csum, csum_size)) {
+		error("superblock checksum mismatch");
+		return -EIO;
+	}
+	if (btrfs_super_root_level(sb) >= BTRFS_MAX_LEVEL) {
+		error("tree_root level too big: %d >= %d",
+			btrfs_super_root_level(sb), BTRFS_MAX_LEVEL);
+		goto error_out;
+	}
+	if (btrfs_super_chunk_root_level(sb) >= BTRFS_MAX_LEVEL) {
+		error("chunk_root level too big: %d >= %d",
+			btrfs_super_chunk_root_level(sb), BTRFS_MAX_LEVEL);
+		goto error_out;
+	}
+	if (btrfs_super_log_root_level(sb) >= BTRFS_MAX_LEVEL) {
+		error("log_root level too big: %d >= %d",
+			btrfs_super_log_root_level(sb), BTRFS_MAX_LEVEL);
+		goto error_out;
+	}
+
+	if (!IS_ALIGNED(btrfs_super_root(sb), 4096)) {
+		error("tree_root block unaligned: %llu", btrfs_super_root(sb));
+		goto error_out;
+	}
+	if (!IS_ALIGNED(btrfs_super_chunk_root(sb), 4096)) {
+		error("chunk_root block unaligned: %llu",
+			btrfs_super_chunk_root(sb));
+		goto error_out;
+	}
+	if (!IS_ALIGNED(btrfs_super_log_root(sb), 4096)) {
+		error("log_root block unaligned: %llu",
+			btrfs_super_log_root(sb));
+		goto error_out;
+	}
+	if (btrfs_super_nodesize(sb) < 4096) {
+		error("nodesize too small: %u < 4096",
+			btrfs_super_nodesize(sb));
+		goto error_out;
+	}
+	if (!IS_ALIGNED(btrfs_super_nodesize(sb), 4096)) {
+		error("nodesize unaligned: %u", btrfs_super_nodesize(sb));
+		goto error_out;
+	}
+	if (btrfs_super_sectorsize(sb) < 4096) {
+		error("sectorsize too small: %u < 4096",
+			btrfs_super_sectorsize(sb));
+		goto error_out;
+	}
+	if (!IS_ALIGNED(btrfs_super_sectorsize(sb), 4096)) {
+		error("sectorsize unaligned: %u", btrfs_super_sectorsize(sb));
+		goto error_out;
+	}
+	if (btrfs_super_total_bytes(sb) == 0) {
+		error("invalid total_bytes 0");
+		goto error_out;
+	}
+	if (btrfs_super_bytes_used(sb) < 6 * btrfs_super_nodesize(sb)) {
+		error("invalid bytes_used %llu", btrfs_super_bytes_used(sb));
+		goto error_out;
+	}
+	if ((btrfs_super_stripesize(sb) != 4096)
+		&& (btrfs_super_stripesize(sb) != btrfs_super_sectorsize(sb))) {
+		error("invalid stripesize %u", btrfs_super_stripesize(sb));
+		goto error_out;
+	}
+
+	if (btrfs_super_incompat_flags(sb) & BTRFS_FEATURE_INCOMPAT_METADATA_UUID)
+		metadata_uuid = sb->metadata_uuid;
+	else
+		metadata_uuid = sb->fsid;
+
+	if (memcmp(metadata_uuid, sb->dev_item.fsid, BTRFS_FSID_SIZE) != 0) {
+		char fsid[BTRFS_UUID_UNPARSED_SIZE];
+		char dev_fsid[BTRFS_UUID_UNPARSED_SIZE];
+
+		uuid_unparse(sb->metadata_uuid, fsid);
+		uuid_unparse(sb->dev_item.fsid, dev_fsid);
+		error("dev_item UUID does not match fsid: %s != %s",
+			dev_fsid, fsid);
+		goto error_out;
+	}
+
+	/*
+	 * Hint to catch really bogus numbers, bitflips or so
+	 */
+	if (btrfs_super_num_devices(sb) > (1UL << 31)) {
+		error("suspicious number of devices: %llu",
+			btrfs_super_num_devices(sb));
+	}
+
+	if (btrfs_super_num_devices(sb) == 0) {
+		error("number of devices is 0");
+		goto error_out;
+	}
+
+	/*
+	 * Obvious sys_chunk_array corruptions, it must hold at least one key
+	 * and one chunk
+	 */
+	if (btrfs_super_sys_array_size(sb) > BTRFS_SYSTEM_CHUNK_ARRAY_SIZE) {
+		error("system chunk array too big %u > %u",
+		      btrfs_super_sys_array_size(sb),
+		      BTRFS_SYSTEM_CHUNK_ARRAY_SIZE);
+		goto error_out;
+	}
+	if (btrfs_super_sys_array_size(sb) < sizeof(struct btrfs_disk_key)
+			+ sizeof(struct btrfs_chunk)) {
+		error("system chunk array too small %u < %zu",
+		      btrfs_super_sys_array_size(sb),
+		      sizeof(struct btrfs_disk_key) +
+		      sizeof(struct btrfs_chunk));
+		goto error_out;
+	}
+
+	return 0;
+
+error_out:
+	error("superblock checksum matches but it has invalid members");
+	return -EIO;
+}
+
+/*
+ * btrfs_read_dev_super - read a valid primary superblock from a block device
+ * @desc,@part:	file descriptor of the device
+ * @sb:		buffer where the superblock is going to be read in
+ *
+ * Unlike the btrfs-progs/kernel version, here we ony care about the first
+ * super block, thus it's much simpler.
+ */
+int btrfs_read_dev_super(struct blk_desc *desc, disk_partition_t *part,
+			 struct btrfs_super_block *sb)
+{
+	char tmp[BTRFS_SUPER_INFO_SIZE];
+	struct btrfs_super_block *buf = (struct btrfs_super_block *)tmp;
+	int ret;
+
+	ret = __btrfs_devread(desc, part, tmp, BTRFS_SUPER_INFO_SIZE,
+			      BTRFS_SUPER_INFO_OFFSET);
+	if (ret < BTRFS_SUPER_INFO_SIZE)
+		return -EIO;
+
+	if (btrfs_super_bytenr(buf) != BTRFS_SUPER_INFO_OFFSET)
+		return -EIO;
+
+	if (btrfs_check_super(buf))
+		return -EIO;
+
+	memcpy(sb, buf, BTRFS_SUPER_INFO_SIZE);
+	return 0;
+}
+
+int btrfs_read_superblock(void)
+{
+	ALLOC_CACHE_ALIGN_BUFFER(char, raw_sb, BTRFS_SUPER_INFO_SIZE);
+	struct btrfs_super_block *sb = (struct btrfs_super_block *) raw_sb;
+	int ret;
+
+
+	btrfs_info.sb.generation = 0;
+
+	ret = btrfs_read_dev_super(btrfs_blk_desc, btrfs_part_info, sb);
+	if (ret < 0) {
+		debug("%s: No valid BTRFS superblock found!\n", __func__);
+		return ret;
+	}
+	btrfs_super_block_to_cpu(sb);
+	memcpy(&btrfs_info.sb, sb, sizeof(*sb));
+
+	if (btrfs_info.sb.num_devices != 1) {
+		printf("%s: Unsupported number of devices (%lli). This driver "
+		       "only supports filesystem on one device.\n", __func__,
+		       btrfs_info.sb.num_devices);
+		return -1;
+	}
+
+	debug("Chosen superblock with generation = %llu\n",
+	      btrfs_info.sb.generation);
+
+	return 0;
+}
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index efb715828cce..671f1ac55c68 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -2,10 +2,14 @@
 #ifndef __BTRFS_DISK_IO_H__
 #define __BTRFS_DISK_IO_H__
 
+#include <linux/sizes.h>
+#include <fs_internal.h>
 #include "crypto/hash.h"
 #include "ctree.h"
 #include "disk-io.h"
 
+#define BTRFS_SUPER_INFO_OFFSET SZ_64K
+#define BTRFS_SUPER_INFO_SIZE	SZ_4K
 static inline u64 btrfs_name_hash(const char *name, int len)
 {
 	u32 crc;
@@ -17,4 +21,7 @@ static inline u64 btrfs_name_hash(const char *name, int len)
 
 int btrfs_csum_data(u16 csum_type, const u8 *data, u8 *out, size_t len);
 
+int btrfs_read_dev_super(struct blk_desc *desc, disk_partition_t *part,
+			 struct btrfs_super_block *sb);
+int btrfs_read_superblock(void);
 #endif
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
deleted file mode 100644
index 7891d84ed369..000000000000
--- a/fs/btrfs/super.c
+++ /dev/null
@@ -1,247 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * BTRFS filesystem implementation for U-Boot
- *
- * 2017 Marek Behun, CZ.NIC, marek.behun@nic.cz
- */
-
-#include "btrfs.h"
-#include "disk-io.h"
-#include <memalign.h>
-
-#define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN	\
-				 | BTRFS_HEADER_FLAG_RELOC	\
-				 | BTRFS_SUPER_FLAG_ERROR	\
-				 | BTRFS_SUPER_FLAG_SEEDING	\
-				 | BTRFS_SUPER_FLAG_METADUMP)
-
-#define BTRFS_SUPER_INFO_SIZE	4096
-
-/*
- * checks if a valid root backup is present.
- * considers the case when all root backups empty valid.
- * returns -1 in case of invalid root backup and 0 for valid.
- */
-static int btrfs_check_super_roots(struct btrfs_super_block *sb)
-{
-	struct btrfs_root_backup *root_backup;
-	int i, newest = -1;
-	int num_empty = 0;
-
-	for (i = 0; i < BTRFS_NUM_BACKUP_ROOTS; ++i) {
-		root_backup = sb->super_roots + i;
-
-		if (root_backup->tree_root == 0 && root_backup->tree_root_gen == 0)
-			num_empty++;
-
-		if (root_backup->tree_root_gen == sb->generation)
-			newest = i;
-	}
-
-	if (num_empty == BTRFS_NUM_BACKUP_ROOTS) {
-		return 0;
-	} else if (newest >= 0) {
-		return 0;
-	}
-
-	return -1;
-}
-
-static inline int is_power_of_2(u64 x)
-{
-	return !(x & (x - 1));
-}
-
-static int btrfs_check_super_csum(char *raw_disk_sb)
-{
-	struct btrfs_super_block *disk_sb =
-		(struct btrfs_super_block *) raw_disk_sb;
-	u16 csum_type = le16_to_cpu(disk_sb->csum_type);
-
-	if (csum_type == BTRFS_CSUM_TYPE_CRC32 ||
-	    csum_type == BTRFS_CSUM_TYPE_SHA256 ||
-	    csum_type == BTRFS_CSUM_TYPE_XXHASH) {
-		u8 result[BTRFS_CSUM_SIZE];
-
-		btrfs_csum_data(csum_type, (u8 *)raw_disk_sb + BTRFS_CSUM_SIZE,
-			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
-
-		if (memcmp(raw_disk_sb, result, BTRFS_CSUM_SIZE))
-			return -EIO;
-	} else if (csum_type == BTRFS_CSUM_TYPE_BLAKE2){
-		printf("Blake2 csum type is not supported yet\n");
-		return -ENOTSUPP;
-	}
-
-	return 0;
-}
-
-static int btrfs_check_super(struct btrfs_super_block *sb)
-{
-	int ret = 0;
-
-	if (sb->flags & ~BTRFS_SUPER_FLAG_SUPP) {
-		printf("%s: Unsupported flags: %llu\n", __func__,
-		       sb->flags & ~BTRFS_SUPER_FLAG_SUPP);
-	}
-
-	if (sb->root_level > BTRFS_MAX_LEVEL) {
-		printf("%s: tree_root level too big: %d >= %d\n", __func__,
-		       sb->root_level, BTRFS_MAX_LEVEL);
-		ret = -1;
-	}
-
-	if (sb->chunk_root_level > BTRFS_MAX_LEVEL) {
-		printf("%s: chunk_root level too big: %d >= %d\n", __func__,
-		       sb->chunk_root_level, BTRFS_MAX_LEVEL);
-		ret = -1;
-	}
-
-	if (sb->log_root_level > BTRFS_MAX_LEVEL) {
-		printf("%s: log_root level too big: %d >= %d\n", __func__,
-		       sb->log_root_level, BTRFS_MAX_LEVEL);
-		ret = -1;
-	}
-
-	if (!is_power_of_2(sb->sectorsize) || sb->sectorsize < 4096 ||
-	    sb->sectorsize > BTRFS_MAX_METADATA_BLOCKSIZE) {
-		printf("%s: invalid sectorsize %u\n", __func__,
-		       sb->sectorsize);
-		ret = -1;
-	}
-
-	if (!is_power_of_2(sb->nodesize) || sb->nodesize < sb->sectorsize ||
-	    sb->nodesize > BTRFS_MAX_METADATA_BLOCKSIZE) {
-		printf("%s: invalid nodesize %u\n", __func__, sb->nodesize);
-		ret = -1;
-	}
-
-	if (sb->nodesize != sb->__unused_leafsize) {
-		printf("%s: invalid leafsize %u, should be %u\n", __func__,
-		       sb->__unused_leafsize, sb->nodesize);
-		ret = -1;
-	}
-
-	if (!IS_ALIGNED(sb->root, sb->sectorsize)) {
-		printf("%s: tree_root block unaligned: %llu\n", __func__,
-		       sb->root);
-		ret = -1;
-	}
-
-	if (!IS_ALIGNED(sb->chunk_root, sb->sectorsize)) {
-		printf("%s: chunk_root block unaligned: %llu\n", __func__,
-		       sb->chunk_root);
-		ret = -1;
-	}
-
-	if (!IS_ALIGNED(sb->log_root, sb->sectorsize)) {
-		printf("%s: log_root block unaligned: %llu\n", __func__,
-		       sb->log_root);
-		ret = -1;
-	}
-
-	if (memcmp(sb->fsid, sb->dev_item.fsid, BTRFS_UUID_SIZE) != 0) {
-		printf("%s: dev_item UUID does not match fsid\n", __func__);
-		ret = -1;
-	}
-
-	if (sb->bytes_used < 6*sb->nodesize) {
-		printf("%s: bytes_used is too small %llu\n", __func__,
-		       sb->bytes_used);
-		ret = -1;
-	}
-
-	if (!is_power_of_2(sb->stripesize)) {
-		printf("%s: invalid stripesize %u\n", __func__, sb->stripesize);
-		ret = -1;
-	}
-
-	if (sb->sys_chunk_array_size > BTRFS_SYSTEM_CHUNK_ARRAY_SIZE) {
-		printf("%s: system chunk array too big %u > %u\n", __func__,
-		       sb->sys_chunk_array_size, BTRFS_SYSTEM_CHUNK_ARRAY_SIZE);
-		ret = -1;
-	}
-
-	if (sb->sys_chunk_array_size < sizeof(struct btrfs_key) +
-	    sizeof(struct btrfs_chunk)) {
-		printf("%s: system chunk array too small %u < %zu\n", __func__,
-		       sb->sys_chunk_array_size, sizeof(struct btrfs_key)
-		       + sizeof(struct btrfs_chunk));
-		ret = -1;
-	}
-
-	return ret;
-}
-
-int btrfs_read_superblock(void)
-{
-	const u64 superblock_offsets[4] = {
-		0x10000ull,
-		0x4000000ull,
-		0x4000000000ull,
-		0x4000000000000ull
-	};
-	ALLOC_CACHE_ALIGN_BUFFER(char, raw_sb, BTRFS_SUPER_INFO_SIZE);
-	struct btrfs_super_block *sb = (struct btrfs_super_block *) raw_sb;
-	u64 dev_total_bytes;
-	int i;
-
-	dev_total_bytes = (u64) btrfs_part_info->size * btrfs_part_info->blksz;
-
-	btrfs_info.sb.generation = 0;
-
-	for (i = 0; i < 4; ++i) {
-		if (superblock_offsets[i] + sizeof(sb) > dev_total_bytes)
-			break;
-
-		if (!btrfs_devread(superblock_offsets[i], BTRFS_SUPER_INFO_SIZE,
-				   raw_sb))
-			break;
-
-		if (btrfs_check_super_csum(raw_sb)) {
-			debug("%s: invalid checksum at superblock mirror %i\n",
-			      __func__, i);
-			continue;
-		}
-
-		btrfs_super_block_to_cpu(sb);
-
-		if (sb->magic != BTRFS_MAGIC) {
-			debug("%s: invalid BTRFS magic 0x%016llX at "
-			      "superblock mirror %i\n", __func__, sb->magic, i);
-		} else if (sb->bytenr != superblock_offsets[i]) {
-			printf("%s: invalid bytenr 0x%016llX (expected "
-			       "0x%016llX) at superblock mirror %i\n",
-			       __func__, sb->bytenr, superblock_offsets[i], i);
-		} else if (btrfs_check_super(sb)) {
-			printf("%s: Checking superblock mirror %i failed\n",
-			       __func__, i);
-		} else if (sb->generation > btrfs_info.sb.generation) {
-			memcpy(&btrfs_info.sb, sb, sizeof(*sb));
-		} else {
-			/* Nothing */
-		}
-	}
-
-	if (!btrfs_info.sb.generation) {
-		debug("%s: No valid BTRFS superblock found!\n", __func__);
-		return -1;
-	}
-
-	if (btrfs_check_super_roots(&btrfs_info.sb)) {
-		printf("%s: No valid root_backup found!\n", __func__);
-		return -1;
-	}
-
-	if (btrfs_info.sb.num_devices != 1) {
-		printf("%s: Unsupported number of devices (%lli). This driver "
-		       "only supports filesystem on one device.\n", __func__,
-		       btrfs_info.sb.num_devices);
-		return -1;
-	}
-
-	debug("Chosen superblock with generation = %llu\n",
-	      btrfs_info.sb.generation);
-
-	return 0;
-}
-- 
2.26.0

