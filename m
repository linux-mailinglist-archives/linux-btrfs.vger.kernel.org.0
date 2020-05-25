Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF97B1E06FA
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 May 2020 08:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388845AbgEYGdN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 May 2020 02:33:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:60664 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388710AbgEYGdN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 May 2020 02:33:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B52BEAF43;
        Mon, 25 May 2020 06:33:13 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, u-boot@lists.denx.de
Cc:     marek.behun@nic.cz
Subject: [PATCH U-BOOT v2 02/30] fs: btrfs: Add More checksum algorithm support to btrfs
Date:   Mon, 25 May 2020 14:32:29 +0800
Message-Id: <20200525063257.46757-3-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525063257.46757-1-wqu@suse.com>
References: <20200525063257.46757-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This would mostly backport crypto/hash.[ch] from btrfs-progs.

The differences are:
- No blake2 support
  No blake2 related library in u-boot yet.

- Use uboot xxhash/sha256 directly
  No need to implement the code as U-boot has already provided the
  interface.

This adds the support for the following csums:
- SHA256
- XXHASH

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/Makefile      |  2 +-
 fs/btrfs/btrfs.c       |  3 ++-
 fs/btrfs/btrfs.h       | 11 ---------
 fs/btrfs/crypto/hash.c | 55 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/crypto/hash.h | 17 +++++++++++++
 fs/btrfs/dir-item.c    |  1 +
 fs/btrfs/disk-io.c     | 22 +++++++++++++++++
 fs/btrfs/disk-io.h     | 20 +++++++++++++++
 fs/btrfs/hash.c        | 38 -----------------------------
 fs/btrfs/super.c       | 23 +++++++++---------
 10 files changed, 130 insertions(+), 62 deletions(-)
 create mode 100644 fs/btrfs/crypto/hash.c
 create mode 100644 fs/btrfs/crypto/hash.h
 create mode 100644 fs/btrfs/disk-io.c
 create mode 100644 fs/btrfs/disk-io.h
 delete mode 100644 fs/btrfs/hash.c

diff --git a/fs/btrfs/Makefile b/fs/btrfs/Makefile
index 9b3159296fff..84b3b5ec0e8a 100644
--- a/fs/btrfs/Makefile
+++ b/fs/btrfs/Makefile
@@ -3,4 +3,4 @@
 # 2017 Marek Behun, CZ.NIC, marek.behun@nic.cz
 
 obj-y := btrfs.o chunk-map.o compression.o ctree.o dev.o dir-item.o \
-	extent-io.o hash.o inode.o root.o subvolume.o super.o
+	extent-io.o inode.o root.o subvolume.o super.o crypto/hash.o disk-io.o
diff --git a/fs/btrfs/btrfs.c b/fs/btrfs/btrfs.c
index 9f2888bab3b1..d5a87c175c52 100644
--- a/fs/btrfs/btrfs.c
+++ b/fs/btrfs/btrfs.c
@@ -5,11 +5,12 @@
  * 2017 Marek Behun, CZ.NIC, marek.behun@nic.cz
  */
 
-#include "btrfs.h"
 #include <config.h>
 #include <malloc.h>
 #include <uuid.h>
 #include <linux/time.h>
+#include "btrfs.h"
+#include "crypto/hash.h"
 
 struct btrfs_info btrfs_info;
 
diff --git a/fs/btrfs/btrfs.h b/fs/btrfs/btrfs.h
index 25a8cf6a8792..1aacbc8cbb83 100644
--- a/fs/btrfs/btrfs.h
+++ b/fs/btrfs/btrfs.h
@@ -23,17 +23,6 @@ struct btrfs_info {
 
 extern struct btrfs_info btrfs_info;
 
-/* hash.c */
-void btrfs_hash_init(void);
-u32 btrfs_crc32c(u32, const void *, size_t);
-u32 btrfs_csum_data(char *, u32, size_t);
-void btrfs_csum_final(u32, void *);
-
-static inline u64 btrfs_name_hash(const char *name, int len)
-{
-	return btrfs_crc32c((u32) ~1, name, len);
-}
-
 /* dev.c */
 extern struct blk_desc *btrfs_blk_desc;
 extern struct disk_partition *btrfs_part_info;
diff --git a/fs/btrfs/crypto/hash.c b/fs/btrfs/crypto/hash.c
new file mode 100644
index 000000000000..fb51f6386cb1
--- /dev/null
+++ b/fs/btrfs/crypto/hash.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/xxhash.h>
+#include <linux/unaligned/access_ok.h>
+#include <linux/types.h>
+#include <u-boot/sha256.h>
+#include <u-boot/crc.h>
+
+static u32 btrfs_crc32c_table[256];
+
+void btrfs_hash_init(void)
+{
+	static int inited = 0;
+
+	if (!inited) {
+		crc32c_init(btrfs_crc32c_table, 0x82F63B78);
+		inited = 1;
+	}
+}
+
+int hash_sha256(const u8 *buf, size_t length, u8 *out)
+{
+	sha256_context ctx;
+
+	sha256_starts(&ctx);
+	sha256_update(&ctx, buf, length);
+	sha256_finish(&ctx, out);
+
+	return 0;
+}
+
+int hash_xxhash(const u8 *buf, size_t length, u8 *out)
+{
+	u64 hash;
+
+	hash = xxh64(buf, length, 0);
+	put_unaligned_le64(hash, out);
+
+	return 0;
+}
+
+int hash_crc32c(const u8 *buf, size_t length, u8 *out)
+{
+	u32 crc;
+
+	crc = crc32c_cal((u32)~0, (char *)buf, length, btrfs_crc32c_table);
+	put_unaligned_le32(~crc, out);
+
+	return 0;
+}
+
+u32 crc32c(u32 seed, const void * data, size_t len)
+{
+	return crc32c_cal(seed, data, len, btrfs_crc32c_table);
+}
diff --git a/fs/btrfs/crypto/hash.h b/fs/btrfs/crypto/hash.h
new file mode 100644
index 000000000000..d1ba1fa374e3
--- /dev/null
+++ b/fs/btrfs/crypto/hash.h
@@ -0,0 +1,17 @@
+#ifndef CRYPTO_HASH_H
+#define CRYPTO_HASH_H
+
+#include <linux/types.h>
+
+#define CRYPTO_HASH_SIZE_MAX	32
+
+void btrfs_hash_init(void);
+int hash_crc32c(const u8 *buf, size_t length, u8 *out);
+int hash_xxhash(const u8 *buf, size_t length, u8 *out);
+int hash_sha256(const u8 *buf, size_t length, u8 *out);
+
+u32 crc32c(u32 seed, const void * data, size_t len);
+
+/* Blake2B is not yet supported due to lack of library */
+
+#endif
diff --git a/fs/btrfs/dir-item.c b/fs/btrfs/dir-item.c
index 63b5bf0a860f..1ff446a45a85 100644
--- a/fs/btrfs/dir-item.c
+++ b/fs/btrfs/dir-item.c
@@ -6,6 +6,7 @@
  */
 
 #include "btrfs.h"
+#include "disk-io.h"
 
 static int verify_dir_item(struct btrfs_dir_item *item, u32 start, u32 total)
 {
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
new file mode 100644
index 000000000000..58c32b548e50
--- /dev/null
+++ b/fs/btrfs/disk-io.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <common.h>
+#include <fs_internal.h>
+#include "disk-io.h"
+#include "crypto/hash.h"
+
+int btrfs_csum_data(u16 csum_type, const u8 *data, u8 *out, size_t len)
+{
+	memset(out, 0, BTRFS_CSUM_SIZE);
+
+	switch (csum_type) {
+	case BTRFS_CSUM_TYPE_CRC32:
+		return hash_crc32c(data, len, out);
+	case BTRFS_CSUM_TYPE_XXHASH:
+		return hash_xxhash(data, len, out);
+	case BTRFS_CSUM_TYPE_SHA256:
+		return hash_sha256(data, len, out);
+	default:
+		printf("Unknown csum type %d\n", csum_type);
+		return -EINVAL;
+	}
+}
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
new file mode 100644
index 000000000000..efb715828cce
--- /dev/null
+++ b/fs/btrfs/disk-io.h
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0+
+#ifndef __BTRFS_DISK_IO_H__
+#define __BTRFS_DISK_IO_H__
+
+#include "crypto/hash.h"
+#include "ctree.h"
+#include "disk-io.h"
+
+static inline u64 btrfs_name_hash(const char *name, int len)
+{
+	u32 crc;
+
+	crc = crc32c((u32)~1, (unsigned char *)name, len);
+
+	return (u64)crc;
+}
+
+int btrfs_csum_data(u16 csum_type, const u8 *data, u8 *out, size_t len);
+
+#endif
diff --git a/fs/btrfs/hash.c b/fs/btrfs/hash.c
deleted file mode 100644
index 52a8ceaf0c8b..000000000000
--- a/fs/btrfs/hash.c
+++ /dev/null
@@ -1,38 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0+
-/*
- * BTRFS filesystem implementation for U-Boot
- *
- * 2017 Marek Behun, CZ.NIC, marek.behun@nic.cz
- */
-
-#include "btrfs.h"
-#include <u-boot/crc.h>
-#include <asm/unaligned.h>
-
-static u32 btrfs_crc32c_table[256];
-
-void btrfs_hash_init(void)
-{
-	static int inited = 0;
-
-	if (!inited) {
-		crc32c_init(btrfs_crc32c_table, 0x82F63B78);
-		inited = 1;
-	}
-}
-
-u32 btrfs_crc32c(u32 crc, const void *data, size_t length)
-{
-	return crc32c_cal(crc, (const char *) data, length,
-			  btrfs_crc32c_table);
-}
-
-u32 btrfs_csum_data(char *data, u32 seed, size_t len)
-{
-	return btrfs_crc32c(seed, data, len);
-}
-
-void btrfs_csum_final(u32 crc, void *result)
-{
-	put_unaligned(cpu_to_le32(~crc), (u32 *)result);
-}
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 913a4d402e91..d67d5a244712 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -11,6 +11,7 @@
 #include <part.h>
 #include <linux/compat.h>
 #include "btrfs.h"
+#include "disk-io.h"
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN	\
 				 | BTRFS_HEADER_FLAG_RELOC	\
@@ -61,19 +62,19 @@ static int btrfs_check_super_csum(char *raw_disk_sb)
 		(struct btrfs_super_block *) raw_disk_sb;
 	u16 csum_type = le16_to_cpu(disk_sb->csum_type);
 
-	if (csum_type == BTRFS_CSUM_TYPE_CRC32) {
-		u32 crc = ~(u32) 0;
-		const int csum_size = sizeof(crc);
-		char result[csum_size];
+	if (csum_type == BTRFS_CSUM_TYPE_CRC32 ||
+	    csum_type == BTRFS_CSUM_TYPE_SHA256 ||
+	    csum_type == BTRFS_CSUM_TYPE_XXHASH) {
+		u8 result[BTRFS_CSUM_SIZE];
 
-		crc = btrfs_csum_data(raw_disk_sb + BTRFS_CSUM_SIZE, crc,
-				      BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
-		btrfs_csum_final(crc, result);
+		btrfs_csum_data(csum_type, (u8 *)raw_disk_sb + BTRFS_CSUM_SIZE,
+			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 
-		if (memcmp(raw_disk_sb, result, csum_size))
-			return -1;
-	} else {
-		return -1;
+		if (memcmp(raw_disk_sb, result, BTRFS_CSUM_SIZE))
+			return -EIO;
+	} else if (csum_type == BTRFS_CSUM_TYPE_BLAKE2){
+		printf("Blake2 csum type is not supported yet\n");
+		return -ENOTSUPP;
 	}
 
 	return 0;
-- 
2.26.2

