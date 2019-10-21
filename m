Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B71EDF375
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Oct 2019 18:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbfJUQpM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Oct 2019 12:45:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:52942 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729590AbfJUQpM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Oct 2019 12:45:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D8136ABC7;
        Mon, 21 Oct 2019 16:45:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2B0B2DA733; Mon, 21 Oct 2019 18:45:23 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/4] btrfs-progs: add blake2b support
Date:   Mon, 21 Oct 2019 18:45:23 +0200
Message-Id: <20191021164523.15210-1-dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571674940.git.dsterba@suse.com>
References: <cover.1571674940.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add definition, crypto wrappers and support to mkfs for blake2 for
checksumming. There are 2 aliases either blake2 or blake2b.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 cmds/inspect-dump-super.c |  1 +
 crypto/hash.c             | 12 ++++++++++++
 crypto/hash.h             |  1 +
 ctree.c                   |  1 +
 ctree.h                   |  1 +
 disk-io.c                 |  2 ++
 mkfs/main.c               |  3 +++
 7 files changed, 21 insertions(+)

diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index 47f56f78934f..fc06488dde32 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -317,6 +317,7 @@ static bool is_valid_csum_type(u16 csum_type)
 	case BTRFS_CSUM_TYPE_CRC32:
 	case BTRFS_CSUM_TYPE_XXHASH:
 	case BTRFS_CSUM_TYPE_SHA256:
+	case BTRFS_CSUM_TYPE_BLAKE2:
 		return true;
 	default:
 		return false;
diff --git a/crypto/hash.c b/crypto/hash.c
index ee4c7f4e7112..48623c798739 100644
--- a/crypto/hash.c
+++ b/crypto/hash.c
@@ -2,6 +2,7 @@
 #include "crypto/crc32c.h"
 #include "crypto/xxhash.h"
 #include "crypto/sha.h"
+#include "crypto/blake2.h"
 
 int hash_crc32c(const u8* buf, size_t length, u8 *out)
 {
@@ -37,3 +38,14 @@ int hash_sha256(const u8 *buf, size_t len, u8 *out)
 
 	return 0;
 }
+
+int hash_blake2b(const u8 *buf, size_t len, u8 *out)
+{
+	blake2b_state S;
+
+	blake2b_init(&S, CRYPTO_HASH_SIZE_MAX);
+	blake2b_update(&S, buf, len);
+	blake2b_final(&S, out, CRYPTO_HASH_SIZE_MAX);
+
+	return 0;
+}
diff --git a/crypto/hash.h b/crypto/hash.h
index 49d586541af9..fefccbd59a09 100644
--- a/crypto/hash.h
+++ b/crypto/hash.h
@@ -8,5 +8,6 @@
 int hash_crc32c(const u8 *buf, size_t length, u8 *out);
 int hash_xxhash(const u8 *buf, size_t length, u8 *out);
 int hash_sha256(const u8 *buf, size_t length, u8 *out);
+int hash_blake2b(const u8 *buf, size_t length, u8 *out);
 
 #endif
diff --git a/ctree.c b/ctree.c
index 19052e8ec128..97b44d48dc85 100644
--- a/ctree.c
+++ b/ctree.c
@@ -45,6 +45,7 @@ static const struct btrfs_csum {
 	[BTRFS_CSUM_TYPE_CRC32]		= {  4, "crc32c" },
 	[BTRFS_CSUM_TYPE_XXHASH]	= {  8, "xxhash64" },
 	[BTRFS_CSUM_TYPE_SHA256]	= { 32, "sha256" },
+	[BTRFS_CSUM_TYPE_BLAKE2]	= { 32, "blake2" },
 };
 
 u16 btrfs_super_csum_size(const struct btrfs_super_block *sb)
diff --git a/ctree.h b/ctree.h
index f7f7e2963b0e..b99ba11279ad 100644
--- a/ctree.h
+++ b/ctree.h
@@ -169,6 +169,7 @@ enum btrfs_csum_type {
 	BTRFS_CSUM_TYPE_CRC32		= 0,
 	BTRFS_CSUM_TYPE_XXHASH		= 1,
 	BTRFS_CSUM_TYPE_SHA256		= 2,
+	BTRFS_CSUM_TYPE_BLAKE2		= 3,
 };
 
 #define BTRFS_EMPTY_DIR_SIZE 0
diff --git a/disk-io.c b/disk-io.c
index 62ec8c1a84bf..a9744af90a43 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -150,6 +150,8 @@ int btrfs_csum_data(u16 csum_type, const u8 *data, u8 *out, size_t len)
 		return hash_xxhash(data, len, out);
 	case BTRFS_CSUM_TYPE_SHA256:
 		return hash_sha256(data, len, out);
+	case BTRFS_CSUM_TYPE_BLAKE2:
+		return hash_blake2b(data, len, out);
 	default:
 		fprintf(stderr, "ERROR: unknown csum type: %d\n", csum_type);
 		ASSERT(0);
diff --git a/mkfs/main.c b/mkfs/main.c
index 607cfe3e0cf5..1a4578412b41 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -397,6 +397,9 @@ static enum btrfs_csum_type parse_csum_type(const char *s)
 		return BTRFS_CSUM_TYPE_XXHASH;
 	} else if (strcasecmp(s, "sha256") == 0) {
 		return BTRFS_CSUM_TYPE_SHA256;
+	} else if (strcasecmp(s, "blake2b") == 0 ||
+		   strcasecmp(s, "blake2") == 0) {
+		return BTRFS_CSUM_TYPE_BLAKE2;
 	} else {
 		error("unknown csum type %s", s);
 		exit(1);
-- 
2.23.0

