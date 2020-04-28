Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1526C1BBC07
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Apr 2020 13:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbgD1LLi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Apr 2020 07:11:38 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38115 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgD1LLg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Apr 2020 07:11:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id g12so2381443wmh.3
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Apr 2020 04:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j8lTiPyjL2UXCV8oXFmBTZNTZbM4gghzDjYM/gjEC2Q=;
        b=SG4vLKMQKkVbdx3xL5JXIJ44k8igaH3suCPdPpfjcEDf0kHuFrmmPdPfTyR0htXhpU
         mn8dZJywbxTnWhHpbg1nGFU+fzrHEPGrKNRo6YLMIZajA4mU+TeXGRvpIWoqvSxi65n5
         zJCdGpjeIhLWM2t7zJOYr5KXnOQRuL+I8kT9WrnPYagf5EhL7DQQVDZ9ogcMoSfD1p5g
         Scao+DAM17/AgZpCE9iSTpPTKlptTnTrVGWYSIzm3IU39h/PBx3dN0UO7hspETorntSV
         W4I4VwT4eHin6wQ+ffw5RTkePqviAXo4pGHoacIIQ6G519j9rtsPopl91rklVCmhEjLe
         jOPg==
X-Gm-Message-State: AGi0Pua+eM06KrnCjD94sxNcw0DOnJr98+iXngS0pUjcY6dYCmIr3+1Y
        J/QYDUyRrCWAwT2AZl1baHLplEYb/FlDXw==
X-Google-Smtp-Source: APiQypJC4i3akY8aSGTpOQsT1SQx2r6Z9b1Wl63Zr5XaRQDGj0A63+VEiFCiibiIpFJvuxBUE5Gqsg==
X-Received: by 2002:a1c:1dc3:: with SMTP id d186mr3992769wmd.90.1588072294134;
        Tue, 28 Apr 2020 04:11:34 -0700 (PDT)
Received: from linux-t19r.fritz.box (ppp-46-244-205-206.dynamic.mnet-online.de. [46.244.205.206])
        by smtp.gmail.com with ESMTPSA id b191sm3126291wmd.39.2020.04.28.04.11.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 04:11:33 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 3/5] btrfs-progs: Add HMAC(SHA256) support
Date:   Tue, 28 Apr 2020 13:11:06 +0200
Message-Id: <20200428111109.5687-4-jth@kernel.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200428111109.5687-1-jth@kernel.org>
References: <20200428111109.5687-1-jth@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Johannes Thumshirn <jthumshirn@suse.de>

Add support for authenticated file systems using HMAC(SHA256) as
checksumming algorithm.

Example:
mkfs.btrfs --csum hmac-sha256 --auth-key 0123456789 -f test.img

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 cmds/inspect-dump-super.c |  5 ++++-
 common/utils.c            |  3 +++
 configure.ac              |  1 -
 crypto/hash.c             | 23 +++++++++++++++++++++++
 crypto/hash.h             |  2 ++
 ctree.c                   |  1 +
 ctree.h                   |  3 +++
 disk-io.c                 |  7 ++++++-
 mkfs/common.c             | 10 ++++++++++
 mkfs/common.h             |  3 +++
 mkfs/main.c               | 22 +++++++++++++++++++++-
 11 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index 99f35def..dd42d180 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -319,6 +319,7 @@ static bool is_valid_csum_type(u16 csum_type)
 	case BTRFS_CSUM_TYPE_XXHASH:
 	case BTRFS_CSUM_TYPE_SHA256:
 	case BTRFS_CSUM_TYPE_BLAKE2:
+	case BTRFS_CSUM_TYPE_HMAC_SHA256:
 		return true;
 	default:
 		return false;
@@ -352,7 +353,9 @@ static void dump_superblock(struct btrfs_super_block *sb, int full)
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
diff --git a/common/utils.c b/common/utils.c
index 2517bb34..9c1d9a1b 100644
--- a/common/utils.c
+++ b/common/utils.c
@@ -774,6 +774,9 @@ enum btrfs_csum_type parse_csum_type(const char *s)
 	} else if (strcasecmp(s, "blake2b") == 0 ||
 		   strcasecmp(s, "blake2") == 0) {
 		return BTRFS_CSUM_TYPE_BLAKE2;
+	} else if (strcasecmp(s, "hmac-sha256") == 0 ||
+		   strcasecmp(s, "hmac(sha256)") == 0) {
+		return BTRFS_CSUM_TYPE_HMAC_SHA256;
 	} else {
 		error("unknown csum type %s", s);
 		exit(1);
diff --git a/configure.ac b/configure.ac
index 24b1641f..c842570c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -295,7 +295,6 @@ AC_SUBST([LZO2_LIBS])
 AC_SUBST([LZO2_LIBS_STATIC])
 AC_SUBST([LZO2_CFLAGS])
 
-
 dnl library stuff
 AC_SUBST([LIBBTRFS_MAJOR])
 AC_SUBST([LIBBTRFS_MINOR])
diff --git a/crypto/hash.c b/crypto/hash.c
index fc658475..94d782d1 100644
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
@@ -72,12 +76,25 @@ int hash_blake2b(const u8 *buf, size_t len, u8 *out)
 	return 0;
 }
 
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
+
 #endif
 
 #if CRYPTOPROVIDER_LIBSODIUM == 1
 
 #include <sodium/crypto_hash_sha256.h>
 #include <sodium/crypto_generichash_blake2b.h>
+#include <sodium/crypto_auth_hmacsha256.h>
 
 int hash_sha256(const u8 *buf, size_t len, u8 *out)
 {
@@ -90,4 +107,10 @@ int hash_blake2b(const u8 *buf, size_t len, u8 *out)
 			NULL, 0);
 }
 
+int hash_hmac_sha256(struct btrfs_fs_info *fs_info, const u8 *buf,
+		     size_t length, u8 *out)
+{
+	return crypto_auth_hmacsha256(out, buf, length, (u8 *)fs_info->auth_key);
+}
+
 #endif
diff --git a/crypto/hash.h b/crypto/hash.h
index fefccbd5..252ce9f9 100644
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
index 3559680f..25a1e865 100644
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
index 2a871187..e1ff00f5 100644
--- a/ctree.h
+++ b/ctree.h
@@ -172,6 +172,7 @@ enum btrfs_csum_type {
 	BTRFS_CSUM_TYPE_XXHASH		= 1,
 	BTRFS_CSUM_TYPE_SHA256		= 2,
 	BTRFS_CSUM_TYPE_BLAKE2		= 3,
+	BTRFS_CSUM_TYPE_HMAC_SHA256	= 32,
 };
 
 #define BTRFS_EMPTY_DIR_SIZE 0
@@ -1212,6 +1213,8 @@ struct btrfs_fs_info {
 	u32 nodesize;
 	u32 sectorsize;
 	u32 stripesize;
+
+	char *auth_key;
 };
 
 /*
diff --git a/disk-io.c b/disk-io.c
index 6221c3ce..5fa1f0c3 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -153,6 +153,10 @@ int btrfs_csum_data(struct btrfs_fs_info *fs_info, u16 csum_type,
 		return hash_sha256(data, len, out);
 	case BTRFS_CSUM_TYPE_BLAKE2:
 		return hash_blake2b(data, len, out);
+	case BTRFS_CSUM_TYPE_HMAC_SHA256:
+		if (!fs_info || !fs_info->auth_key)
+			return 0;
+		return hash_hmac_sha256(fs_info, data, len, out);
 	default:
 		fprintf(stderr, "ERROR: unknown csum type: %d\n", csum_type);
 		ASSERT(0);
@@ -837,6 +841,7 @@ struct btrfs_fs_info *btrfs_new_fs_info(int writable, u64 sb_bytenr,
 	fs_info->data_alloc_profile = (u64)-1;
 	fs_info->metadata_alloc_profile = (u64)-1;
 	fs_info->system_alloc_profile = fs_info->metadata_alloc_profile;
+	fs_info->auth_key = auth_key;
 	return fs_info;
 free_all:
 	btrfs_free_fs_info(fs_info);
@@ -1418,7 +1423,7 @@ int btrfs_check_super(struct btrfs_super_block *sb, unsigned sbflags)
 	btrfs_csum_data(NULL, csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
 			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 
-	if (memcmp(result, sb->csum, csum_size)) {
+	if (memcmp(result, sb->csum, csum_size) && csum_type != BTRFS_CSUM_TYPE_HMAC_SHA256) {
 		error("superblock checksum mismatch");
 		return -EIO;
 	}
diff --git a/mkfs/common.c b/mkfs/common.c
index 469b88d6..81d0b5c1 100644
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
index 426852be..7aea13cd 100644
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
index e830de4e..9f783cc1 100644
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
@@ -839,14 +840,21 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
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
@@ -952,6 +960,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			case GETOPT_VAL_CHECKSUM:
 				csum_type = parse_csum_type(optarg);
 				break;
+			case GETOPT_VAL_AUTHKEY:
+				auth_key = strdup(optarg);
+				break;
 			case GETOPT_VAL_HELP:
 			default:
 				print_usage(c != GETOPT_VAL_HELP);
@@ -979,6 +990,12 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
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
 
@@ -1197,6 +1214,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	mkfs_cfg.stripesize = stripesize;
 	mkfs_cfg.features = features;
 	mkfs_cfg.csum_type = csum_type;
+	mkfs_cfg.auth_key = auth_key;
 
 	ret = make_btrfs(fd, &mkfs_cfg);
 	if (ret) {
@@ -1413,6 +1431,7 @@ out:
 
 	btrfs_close_all_devices();
 	free(label);
+	free(auth_key);
 
 	return !!ret;
 error:
@@ -1420,6 +1439,7 @@ error:
 		close(fd);
 
 	free(label);
+	free(auth_key);
 	exit(1);
 success:
 	exit(0);
-- 
2.16.4

