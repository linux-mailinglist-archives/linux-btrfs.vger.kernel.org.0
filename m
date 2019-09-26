Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89161BEF51
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2019 12:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbfIZKL2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Sep 2019 06:11:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:50106 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725790AbfIZKL2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Sep 2019 06:11:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5DF1DAEB8;
        Thu, 26 Sep 2019 10:11:26 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Nikolay Borisov <nborisov@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v6] btrfs-progs: add xxhash64 to mkfs
Date:   Thu, 26 Sep 2019 12:11:23 +0200
Message-Id: <20190926101123.19486-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190925133728.18027-6-jthumshirn@suse.de>
References: <20190925133728.18027-6-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---

Changes since v5:
- add xxhash64 to hash table

 Makefile                  |  3 ++-
 cmds/inspect-dump-super.c |  1 +
 crypto/hash.c             | 16 ++++++++++++++++
 crypto/hash.h             | 10 ++++++++++
 ctree.c                   |  1 +
 ctree.h                   |  3 ++-
 disk-io.c                 |  3 +++
 mkfs/main.c               |  3 +++
 8 files changed, 38 insertions(+), 2 deletions(-)
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
index bf380ad2b56a..73e986ed8ee8 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -315,6 +315,7 @@ static bool is_valid_csum_type(u16 csum_type)
 {
 	switch (csum_type) {
 	case BTRFS_CSUM_TYPE_CRC32:
+	case BTRFS_CSUM_TYPE_XXHASH:
 		return true;
 	default:
 		return false;
diff --git a/crypto/hash.c b/crypto/hash.c
new file mode 100644
index 000000000000..8c428cba11f0
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
+	/*
+	 * NOTE: we're not taking the canonical form here but the plain hash to
+	 * be compatible with the kernel implementation!
+	 */
+	memcpy(out, &hash, 8);
+
+	return 0;
+}
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
diff --git a/ctree.c b/ctree.c
index a52ccfe19f94..139ffd613da5 100644
--- a/ctree.c
+++ b/ctree.c
@@ -43,6 +43,7 @@ static struct btrfs_csum {
 	const char *name;
 } btrfs_csums[] = {
 	[BTRFS_CSUM_TYPE_CRC32] = { 4, "crc32c" },
+	[BTRFS_CSUM_TYPE_XXHASH] = { 8, "xxhash64" },
 };
 
 u16 btrfs_super_csum_size(const struct btrfs_super_block *sb)
diff --git a/ctree.h b/ctree.h
index f70271dc658e..144c89eb4a36 100644
--- a/ctree.h
+++ b/ctree.h
@@ -166,7 +166,8 @@ struct btrfs_free_space_ctl;
 
 /* csum types */
 enum btrfs_csum_type {
-	BTRFS_CSUM_TYPE_CRC32   = 0,
+	BTRFS_CSUM_TYPE_CRC32	= 0,
+	BTRFS_CSUM_TYPE_XXHASH	= 1,
 };
 
 #define BTRFS_EMPTY_DIR_SIZE 0
diff --git a/disk-io.c b/disk-io.c
index 72c672919cf9..59e297e2039c 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -34,6 +34,7 @@
 #include "print-tree.h"
 #include "common/rbtree-utils.h"
 #include "common/device-scan.h"
+#include "crypto/hash.h"
 
 /* specified errno for check_tree_block */
 #define BTRFS_BAD_BYTENR		(-1)
@@ -149,6 +150,8 @@ int btrfs_csum_data(u16 csum_type, const u8 *data, u8 *out, size_t len)
 		crc = crc32c(crc, data, len);
 		put_unaligned_le32(~crc, out);
 		return 0;
+	case BTRFS_CSUM_TYPE_XXHASH:
+		return hash_xxhash(data, len, out);
 	default:
 		fprintf(stderr, "ERROR: unknown csum type: %d\n", csum_type);
 		ASSERT(0);
diff --git a/mkfs/main.c b/mkfs/main.c
index f52e8b61a460..a6deddc47c69 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -392,6 +392,9 @@ static enum btrfs_csum_type parse_csum_type(const char *s)
 {
 	if (strcasecmp(s, "crc32c") == 0) {
 		return BTRFS_CSUM_TYPE_CRC32;
+	} else if (strcasecmp(s, "xxhash64") == 0 ||
+		   strcasecmp(s, "xxhash") == 0) {
+		return BTRFS_CSUM_TYPE_XXHASH;
 	} else {
 		error("unknown csum type %s", s);
 		exit(1);
-- 
2.16.4

