Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13000D8B82
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2019 10:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391782AbfJPImE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Oct 2019 04:42:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:48268 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404145AbfJPImE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Oct 2019 04:42:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 47222ADAB
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2019 08:42:01 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>
Subject: [RFC PATCH 3/4] btrfs-progs: Add HMAC(SHA256) support
Date:   Wed, 16 Oct 2019 10:41:57 +0200
Message-Id: <20191016084158.7573-3-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191016084158.7573-1-jthumshirn@suse.de>
References: <20191016084158.7573-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add support for authenticated file systems using HMAC(SHA256) as
checksumming algorithm.

Example:
mkfs.btrfs --csum hmac-sha256 --auth-key 0123456789 -f test.img

Not-yet-signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 Makefile.inc.in           |  2 +-
 cmds/inspect-dump-super.c |  5 ++++-
 configure.ac              |  7 +++++++
 crypto/hash.c             | 16 ++++++++++++++++
 crypto/hash.h             |  2 ++
 ctree.c                   |  1 +
 ctree.h                   |  3 +++
 disk-io.c                 |  9 ++++++++-
 mkfs/common.c             | 10 ++++++++++
 mkfs/common.h             |  3 +++
 mkfs/main.c               | 25 ++++++++++++++++++++++++-
 11 files changed, 79 insertions(+), 4 deletions(-)

diff --git a/Makefile.inc.in b/Makefile.inc.in
index a86c528ed0a5..34191fa0a381 100644
--- a/Makefile.inc.in
+++ b/Makefile.inc.in
@@ -25,7 +25,7 @@ PYTHON_CFLAGS = @PYTHON_CFLAGS@
 SUBST_CFLAGS = @CFLAGS@
 SUBST_LDFLAGS = @LDFLAGS@
 
-LIBS_BASE = @UUID_LIBS@ @BLKID_LIBS@ -L. -pthread
+LIBS_BASE = @UUID_LIBS@ @BLKID_LIBS@ @LIBGCRYPT_LIBS@ -L. -pthread
 LIBS_COMP = @ZLIB_LIBS@ @LZO2_LIBS@ @ZSTD_LIBS@
 LIBS_PYTHON = @PYTHON_LIBS@
 STATIC_LIBS_BASE = @UUID_LIBS_STATIC@ @BLKID_LIBS_STATIC@ -L. -pthread
diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index 1a2ef4d4822c..5bf5a6bc6f27 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -318,6 +318,7 @@ static bool is_valid_csum_type(u16 csum_type)
 	case BTRFS_CSUM_TYPE_XXHASH:
 	case BTRFS_CSUM_TYPE_SHA256:
 	case BTRFS_CSUM_TYPE_BLAKE2:
+	case BTRFS_CSUM_TYPE_HMAC_SHA256:
 		return true;
 	default:
 		return false;
@@ -351,7 +352,9 @@ static void dump_superblock(struct btrfs_super_block *sb, int full)
 	printf("csum\t\t\t0x");
 	for (i = 0, p = sb->csum; i < csum_size; i++)
 		printf("%02x", p[i]);
-	if (!is_valid_csum_type(csum_type))
+	if (csum_type == BTRFS_CSUM_TYPE_HMAC_SHA256)
+		printf(" [NO KEY FOR HMAC]");
+	else if (!is_valid_csum_type(csum_type))
 		printf(" [UNKNOWN CSUM TYPE OR SIZE]");
 	else if (check_csum_sblock(sb, csum_size, csum_type))
 		printf(" [match]");
diff --git a/configure.ac b/configure.ac
index cf792eb5488b..32b3f41e70d9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -267,6 +267,13 @@ AC_SUBST([LZO2_LIBS])
 AC_SUBST([LZO2_LIBS_STATIC])
 AC_SUBST([LZO2_CFLAGS])
 
+dnl gcrypt library for HMAC(SHA256)
+AM_PATH_LIBGCRYPT([1.0.0], [
+		   AC_SUBST(LIBGCRYPT_LIBS)
+		   AC_SUBST(LIBGCRYPT_CFLAGS)
+		   ], [
+		       AC_MSG_ERROR([cannot find gcrypt library])
+])
 
 dnl library stuff
 AC_SUBST([LIBBTRFS_MAJOR])
diff --git a/crypto/hash.c b/crypto/hash.c
index 48623c798739..c507a007d4d6 100644
--- a/crypto/hash.c
+++ b/crypto/hash.c
@@ -1,3 +1,7 @@
+#include <gcrypt.h>
+
+#include "ctree.h"
+
 #include "crypto/hash.h"
 #include "crypto/crc32c.h"
 #include "crypto/xxhash.h"
@@ -49,3 +53,15 @@ int hash_blake2b(const u8 *buf, size_t len, u8 *out)
 
 	return 0;
 }
+
+int hash_hmac_sha256(struct btrfs_fs_info *fs_info, const u8 *buf,
+		     size_t length, u8 *out)
+{
+	gcry_mac_hd_t mac;
+	gcry_mac_open(&mac, GCRY_MAC_HMAC_SHA256, 0, NULL);
+	gcry_mac_setkey(mac, fs_info->auth_key, strlen(fs_info->auth_key));
+	gcry_mac_write(mac, buf, length);
+	gcry_mac_read(mac, out, &length);
+
+	return 0;
+}
diff --git a/crypto/hash.h b/crypto/hash.h
index fefccbd59a09..252ce9f94f72 100644
--- a/crypto/hash.h
+++ b/crypto/hash.h
@@ -9,5 +9,7 @@ int hash_crc32c(const u8 *buf, size_t length, u8 *out);
 int hash_xxhash(const u8 *buf, size_t length, u8 *out);
 int hash_sha256(const u8 *buf, size_t length, u8 *out);
 int hash_blake2b(const u8 *buf, size_t length, u8 *out);
+int hash_hmac_sha256(struct btrfs_fs_info *fs_info, const u8 *buf,
+		     size_t length, u8 *out);
 
 #endif
diff --git a/ctree.c b/ctree.c
index 97b44d48dc85..a22ad0bfe3fd 100644
--- a/ctree.c
+++ b/ctree.c
@@ -46,6 +46,7 @@ static const struct btrfs_csum {
 	[BTRFS_CSUM_TYPE_XXHASH]	= {  8, "xxhash64" },
 	[BTRFS_CSUM_TYPE_SHA256]	= { 32, "sha256" },
 	[BTRFS_CSUM_TYPE_BLAKE2]	= { 32, "blake2" },
+	[BTRFS_CSUM_TYPE_HMAC_SHA256]	= { 32, "hmac-sha256" },
 };
 
 u16 btrfs_super_csum_size(const struct btrfs_super_block *sb)
diff --git a/ctree.h b/ctree.h
index b99ba11279ad..bb64d54c5894 100644
--- a/ctree.h
+++ b/ctree.h
@@ -170,6 +170,7 @@ enum btrfs_csum_type {
 	BTRFS_CSUM_TYPE_XXHASH		= 1,
 	BTRFS_CSUM_TYPE_SHA256		= 2,
 	BTRFS_CSUM_TYPE_BLAKE2		= 3,
+	BTRFS_CSUM_TYPE_HMAC_SHA256	= 32, // XXX dummy value for now
 };
 
 #define BTRFS_EMPTY_DIR_SIZE 0
@@ -1190,6 +1191,8 @@ struct btrfs_fs_info {
 	u32 nodesize;
 	u32 sectorsize;
 	u32 stripesize;
+
+	char *auth_key;
 };
 
 /*
diff --git a/disk-io.c b/disk-io.c
index 5de6daf1563a..ef43521d0dcf 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -153,6 +153,12 @@ int btrfs_csum_data(struct btrfs_fs_info *fs_info, u16 csum_type,
 		return hash_sha256(data, len, out);
 	case BTRFS_CSUM_TYPE_BLAKE2:
 		return hash_blake2b(data, len, out);
+	case BTRFS_CSUM_TYPE_HMAC_SHA256:
+		if (!fs_info || !fs_info->auth_key) {
+			fprintf(stderr, "ERROR: no key for HMAC(SHA256)\n");
+			return 0;
+		}
+		return hash_hmac_sha256(fs_info, data, len, out);
 	default:
 		fprintf(stderr, "ERROR: unknown csum type: %d\n", csum_type);
 		ASSERT(0);
@@ -817,6 +823,7 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr,
 	fs_info->data_alloc_profile = (u64)-1;
 	fs_info->metadata_alloc_profile = (u64)-1;
 	fs_info->system_alloc_profile = fs_info->metadata_alloc_profile;
+	fs_info->auth_key = auth_key;
 	return fs_info;
 free_all:
 	btrfs_free_fs_info(fs_info);
@@ -1393,7 +1400,7 @@ int btrfs_check_super(struct btrfs_super_block *sb, unsigned sbflags)
 	btrfs_csum_data(NULL, csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
 			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 
-	if (memcmp(result, sb->csum, csum_size)) {
+	if (memcmp(result, sb->csum, csum_size) && csum_type != BTRFS_CSUM_TYPE_HMAC_SHA256) {
 		error("superblock checksum mismatch");
 		return -EIO;
 	}
diff --git a/mkfs/common.c b/mkfs/common.c
index 469b88d6a8d3..81d0b5c12a52 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -160,6 +160,13 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	if (!buf)
 		return -ENOMEM;
 
+	buf->fs_info = calloc(1, sizeof(struct btrfs_fs_info));
+	if (!buf->fs_info) {
+		free(buf);
+		return -ENOMEM;
+	}
+
+
 	first_free = BTRFS_SUPER_INFO_OFFSET + cfg->sectorsize * 2 - 1;
 	first_free &= ~((u64)cfg->sectorsize - 1);
 
@@ -224,6 +231,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 			    btrfs_header_chunk_tree_uuid(buf),
 			    BTRFS_UUID_SIZE);
 
+	buf->fs_info->auth_key = cfg->auth_key;
+
 	ret = btrfs_create_tree_root(fd, cfg, buf);
 	if (ret < 0)
 		goto out;
@@ -474,6 +483,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	ret = 0;
 
 out:
+	free(buf->fs_info);
 	free(buf);
 	return ret;
 }
diff --git a/mkfs/common.h b/mkfs/common.h
index 1ca71a4fcce5..161221d849ec 100644
--- a/mkfs/common.h
+++ b/mkfs/common.h
@@ -65,6 +65,9 @@ struct btrfs_mkfs_config {
 
 	/* Superblock offset after make_btrfs */
 	u64 super_bytenr;
+
+	/* authentication key */
+	char *auth_key;
 };
 
 int make_btrfs(int fd, struct btrfs_mkfs_config *cfg);
diff --git a/mkfs/main.c b/mkfs/main.c
index aca104a4bd57..5ba57c923359 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -343,6 +343,7 @@ static void print_usage(int ret)
 	printf("  features:\n");
 	printf("\t--csum TYPE\n");
 	printf("\t--checksum TYPE         checksum algorithm to use (default: crc32c)\n");
+	printf("\t--auth-key KEY          authentication key to use for authenticated file-systems\n");
 	printf("\t-n|--nodesize SIZE      size of btree nodes\n");
 	printf("\t-s|--sectorsize SIZE    data block size (may not be mountable by current kernel)\n");
 	printf("\t-O|--features LIST      comma separated list of filesystem features (use '-O list-all' to list features)\n");
@@ -400,6 +401,9 @@ static enum btrfs_csum_type parse_csum_type(const char *s)
 	} else if (strcasecmp(s, "blake2b") == 0 ||
 		   strcasecmp(s, "blake2") == 0) {
 		return BTRFS_CSUM_TYPE_BLAKE2;
+	} else if (strcasecmp(s, "hmac-sha256") == 0 ||
+		   strcasecmp(s, "hmac(sha256)") == 0) {
+		return BTRFS_CSUM_TYPE_HMAC_SHA256;
 	} else {
 		error("unknown csum type %s", s);
 		exit(1);
@@ -855,14 +859,21 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	struct mkfs_allocation allocation = { 0 };
 	struct btrfs_mkfs_config mkfs_cfg;
 	enum btrfs_csum_type csum_type = BTRFS_CSUM_TYPE_CRC32;
+	char *auth_key = NULL;
 
 	crc32c_optimization_init();
 
 	while(1) {
 		int c;
-		enum { GETOPT_VAL_SHRINK = 257, GETOPT_VAL_CHECKSUM };
+		enum {
+			GETOPT_VAL_SHRINK = 257,
+			GETOPT_VAL_CHECKSUM,
+			GETOPT_VAL_AUTHKEY,
+		};
 		static const struct option long_options[] = {
 			{ "alloc-start", required_argument, NULL, 'A'},
+			{ "auth-key", required_argument, NULL,
+				GETOPT_VAL_AUTHKEY },
 			{ "byte-count", required_argument, NULL, 'b' },
 			{ "csum", required_argument, NULL,
 				GETOPT_VAL_CHECKSUM },
@@ -968,6 +979,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			case GETOPT_VAL_CHECKSUM:
 				csum_type = parse_csum_type(optarg);
 				break;
+			case GETOPT_VAL_AUTHKEY:
+				auth_key = strdup(optarg);
+				break;
 			case GETOPT_VAL_HELP:
 			default:
 				print_usage(c != GETOPT_VAL_HELP);
@@ -995,6 +1009,12 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		goto error;
 	}
 
+	if ((auth_key && csum_type != BTRFS_CSUM_TYPE_HMAC_SHA256) ||
+	    (csum_type == BTRFS_CSUM_TYPE_HMAC_SHA256 && !auth_key)) {
+		error("the option --auth-key must be used with --csum hmac(sha256)");
+		goto error;
+	}
+
 	if (*fs_uuid) {
 		uuid_t dummy_uuid;
 
@@ -1208,6 +1228,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	mkfs_cfg.stripesize = stripesize;
 	mkfs_cfg.features = features;
 	mkfs_cfg.csum_type = csum_type;
+	mkfs_cfg.auth_key = auth_key;
 
 	ret = make_btrfs(fd, &mkfs_cfg);
 	if (ret) {
@@ -1424,6 +1445,7 @@ out:
 
 	btrfs_close_all_devices();
 	free(label);
+	free(auth_key);
 
 	return !!ret;
 error:
@@ -1431,6 +1453,7 @@ error:
 		close(fd);
 
 	free(label);
+	free(auth_key);
 	exit(1);
 success:
 	exit(0);
-- 
2.16.4

