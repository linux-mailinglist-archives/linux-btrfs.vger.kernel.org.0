Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F53BCDFFD
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 13:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfJGLNb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 07:13:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:34748 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727395AbfJGLNb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Oct 2019 07:13:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C6DEDAE8D;
        Mon,  7 Oct 2019 11:13:28 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] btrfs-progs: add sha256 as supported checksumming algorithm
Date:   Mon,  7 Oct 2019 13:13:26 +0200
Message-Id: <20191007111326.10474-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 Makefile                  |  2 +-
 cmds/inspect-dump-super.c |  1 +
 crypto/hash.c             | 12 ++++++++++++
 crypto/hash.h             |  1 +
 crypto/sha224-256.c       |  4 ++--
 ctree.c                   |  1 +
 ctree.h                   |  1 +
 disk-io.c                 |  2 ++
 mkfs/main.c               |  2 ++
 9 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 7a7587c01057..84834025f7be 100644
--- a/Makefile
+++ b/Makefile
@@ -153,7 +153,7 @@ libbtrfs_objects = send-stream.o send-utils.o kernel-lib/rbtree.o btrfs-list.o \
 		   kernel-lib/radix-tree.o extent-cache.o extent_io.o \
 		   crypto/crc32c.o common/messages.o \
 		   uuid-tree.o utils-lib.o common/rbtree-utils.o \
-		   crypto/hash.o crypto/xxhash.o
+		   crypto/hash.o crypto/xxhash.o crypto/sha224-256.o
 libbtrfs_headers = send-stream.h send-utils.h send.h kernel-lib/rbtree.h btrfs-list.h \
 	       crypto/crc32c.h kernel-lib/list.h kerncompat.h \
 	       kernel-lib/radix-tree.h kernel-lib/sizes.h kernel-lib/raid56.h \
diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index 52636bd2e11c..47f56f78934f 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -316,6 +316,7 @@ static bool is_valid_csum_type(u16 csum_type)
 	switch (csum_type) {
 	case BTRFS_CSUM_TYPE_CRC32:
 	case BTRFS_CSUM_TYPE_XXHASH:
+	case BTRFS_CSUM_TYPE_SHA256:
 		return true;
 	default:
 		return false;
diff --git a/crypto/hash.c b/crypto/hash.c
index dbabfadf8d76..ee4c7f4e7112 100644
--- a/crypto/hash.c
+++ b/crypto/hash.c
@@ -1,6 +1,7 @@
 #include "crypto/hash.h"
 #include "crypto/crc32c.h"
 #include "crypto/xxhash.h"
+#include "crypto/sha.h"
 
 int hash_crc32c(const u8* buf, size_t length, u8 *out)
 {
@@ -25,3 +26,14 @@ int hash_xxhash(const u8 *buf, size_t length, u8 *out)
 
 	return 0;
 }
+
+int hash_sha256(const u8 *buf, size_t len, u8 *out)
+{
+	SHA256Context context;
+
+	SHA256Reset(&context);
+	SHA256Input(&context, buf, len);
+	SHA256Result(&context, out);
+
+	return 0;
+}
diff --git a/crypto/hash.h b/crypto/hash.h
index 7298d69d10ac..49d586541af9 100644
--- a/crypto/hash.h
+++ b/crypto/hash.h
@@ -7,5 +7,6 @@
 
 int hash_crc32c(const u8 *buf, size_t length, u8 *out);
 int hash_xxhash(const u8 *buf, size_t length, u8 *out);
+int hash_sha256(const u8 *buf, size_t length, u8 *out);
 
 #endif
diff --git a/crypto/sha224-256.c b/crypto/sha224-256.c
index 82124a0335e9..f38cee180ef9 100644
--- a/crypto/sha224-256.c
+++ b/crypto/sha224-256.c
@@ -40,8 +40,8 @@
  *   to hash the final few bits of the input.
  */
 
-#include "tests/sha.h"
-#include "tests/sha-private.h"
+#include "crypto/sha.h"
+#include "crypto/sha-private.h"
 
 /* Define the SHA shift, rotate left, and rotate right macros */
 #define SHA256_SHR(bits,word)      ((word) >> (bits))
diff --git a/ctree.c b/ctree.c
index d1680a6ac3bb..19052e8ec128 100644
--- a/ctree.c
+++ b/ctree.c
@@ -44,6 +44,7 @@ static const struct btrfs_csum {
 } btrfs_csums[] = {
 	[BTRFS_CSUM_TYPE_CRC32]		= {  4, "crc32c" },
 	[BTRFS_CSUM_TYPE_XXHASH]	= {  8, "xxhash64" },
+	[BTRFS_CSUM_TYPE_SHA256]	= { 32, "sha256" },
 };
 
 u16 btrfs_super_csum_size(const struct btrfs_super_block *sb)
diff --git a/ctree.h b/ctree.h
index 5c3a66fb819e..f7f7e2963b0e 100644
--- a/ctree.h
+++ b/ctree.h
@@ -168,6 +168,7 @@ struct btrfs_free_space_ctl;
 enum btrfs_csum_type {
 	BTRFS_CSUM_TYPE_CRC32		= 0,
 	BTRFS_CSUM_TYPE_XXHASH		= 1,
+	BTRFS_CSUM_TYPE_SHA256		= 2,
 };
 
 #define BTRFS_EMPTY_DIR_SIZE 0
diff --git a/disk-io.c b/disk-io.c
index fa679133e171..62ec8c1a84bf 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -148,6 +148,8 @@ int btrfs_csum_data(u16 csum_type, const u8 *data, u8 *out, size_t len)
 		return hash_crc32c(data, len, out);
 	case BTRFS_CSUM_TYPE_XXHASH:
 		return hash_xxhash(data, len, out);
+	case BTRFS_CSUM_TYPE_SHA256:
+		return hash_sha256(data, len, out);
 	default:
 		fprintf(stderr, "ERROR: unknown csum type: %d\n", csum_type);
 		ASSERT(0);
diff --git a/mkfs/main.c b/mkfs/main.c
index 1f8ee71e42ea..607cfe3e0cf5 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -395,6 +395,8 @@ static enum btrfs_csum_type parse_csum_type(const char *s)
 	} else if (strcasecmp(s, "xxhash64") == 0 ||
 		   strcasecmp(s, "xxhash") == 0) {
 		return BTRFS_CSUM_TYPE_XXHASH;
+	} else if (strcasecmp(s, "sha256") == 0) {
+		return BTRFS_CSUM_TYPE_SHA256;
 	} else {
 		error("unknown csum type %s", s);
 		exit(1);
-- 
2.16.4

