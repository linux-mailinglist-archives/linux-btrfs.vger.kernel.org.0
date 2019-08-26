Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79EE89CE86
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2019 13:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbfHZLtA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Aug 2019 07:49:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:39232 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731107AbfHZLs6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Aug 2019 07:48:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DBD33AFF4
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Aug 2019 11:48:55 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 08/11] btrfs-progs: add option for checksum type to mkfs
Date:   Mon, 26 Aug 2019 13:48:50 +0200
Message-Id: <20190826114853.14860-9-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190826114853.14860-1-jthumshirn@suse.de>
References: <20190826114853.14860-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add an option to mkfs to specify which checksum algorithm will be used for
the filesystem.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 convert/common.c |  2 +-
 mkfs/common.c    |  2 +-
 mkfs/common.h    |  2 ++
 mkfs/main.c      | 21 ++++++++++++++++++++-
 4 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/convert/common.c b/convert/common.c
index 7936f8f10b29..8f5fdbf507a4 100644
--- a/convert/common.c
+++ b/convert/common.c
@@ -135,7 +135,7 @@ static int setup_temp_super(int fd, struct btrfs_mkfs_config *cfg,
 	super->__unused_leafsize = cpu_to_le32(cfg->nodesize);
 	btrfs_set_super_nodesize(super, cfg->nodesize);
 	btrfs_set_super_stripesize(super, cfg->stripesize);
-	btrfs_set_super_csum_type(super, BTRFS_CSUM_TYPE_CRC32);
+	btrfs_set_super_csum_type(super, cfg->csum_type);
 	btrfs_set_super_chunk_root(super, chunk_bytenr);
 	btrfs_set_super_cache_generation(super, -1);
 	btrfs_set_super_incompat_flags(super, cfg->features);
diff --git a/mkfs/common.c b/mkfs/common.c
index 9762391a8d2b..4a417bd7a306 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -202,7 +202,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	super.__unused_leafsize = cpu_to_le32(cfg->nodesize);
 	btrfs_set_super_nodesize(&super, cfg->nodesize);
 	btrfs_set_super_stripesize(&super, cfg->stripesize);
-	btrfs_set_super_csum_type(&super, BTRFS_CSUM_TYPE_CRC32);
+	btrfs_set_super_csum_type(&super, cfg->csum_type);
 	btrfs_set_super_chunk_root_generation(&super, 1);
 	btrfs_set_super_cache_generation(&super, -1);
 	btrfs_set_super_incompat_flags(&super, cfg->features);
diff --git a/mkfs/common.h b/mkfs/common.h
index 28912906d0a9..1ca71a4fcce5 100644
--- a/mkfs/common.h
+++ b/mkfs/common.h
@@ -53,6 +53,8 @@ struct btrfs_mkfs_config {
 	u64 features;
 	/* Size of the filesystem in bytes */
 	u64 num_bytes;
+	/* checksum algorithm to use */
+	enum btrfs_csum_type csum_type;
 
 	/* Output fields, set during creation */
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 8dbec0717b89..075e7e331ab4 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -346,6 +346,7 @@ static void print_usage(int ret)
 	printf("\t--shrink                (with --rootdir) shrink the filled filesystem to minimal size\n");
 	printf("\t-K|--nodiscard          do not perform whole device TRIM\n");
 	printf("\t-f|--force              force overwrite of existing filesystem\n");
+	printf("\t-C|--checksum           checksum algorithm to use (default: crc32c)\n");
 	printf("  general:\n");
 	printf("\t-q|--quiet              no messages except errors\n");
 	printf("\t-V|--version            print the mkfs.btrfs version and exit\n");
@@ -380,6 +381,18 @@ static u64 parse_profile(const char *s)
 	return 0;
 }
 
+static enum btrfs_csum_type parse_csum_type(const char *s)
+{
+	if (strcasecmp(s, "crc32c") == 0) {
+		return BTRFS_CSUM_TYPE_CRC32;
+	} else {
+		error("unknown csum type %s", s);
+		exit(1);
+	}
+	/* not reached */
+	return 0;
+}
+
 static char *parse_label(const char *input)
 {
 	int len = strlen(input);
@@ -826,6 +839,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	u64 features = BTRFS_MKFS_DEFAULT_FEATURES;
 	struct mkfs_allocation allocation = { 0 };
 	struct btrfs_mkfs_config mkfs_cfg;
+	enum btrfs_csum_type csum_type = BTRFS_CSUM_TYPE_CRC32;
 
 	crc32c_optimization_init();
 
@@ -835,6 +849,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		static const struct option long_options[] = {
 			{ "alloc-start", required_argument, NULL, 'A'},
 			{ "byte-count", required_argument, NULL, 'b' },
+			{ "checksum", required_argument, NULL, 'C' },
 			{ "force", no_argument, NULL, 'f' },
 			{ "leafsize", required_argument, NULL, 'l' },
 			{ "label", required_argument, NULL, 'L'},
@@ -854,7 +869,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			{ NULL, 0, NULL, 0}
 		};
 
-		c = getopt_long(argc, argv, "A:b:fl:n:s:m:d:L:O:r:U:VMKq",
+		c = getopt_long(argc, argv, "A:b:C:fl:n:s:m:d:L:O:r:U:VMKq",
 				long_options, NULL);
 		if (c < 0)
 			break;
@@ -932,6 +947,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			case GETOPT_VAL_SHRINK:
 				shrink_rootdir = true;
 				break;
+			case 'C':
+				csum_type = parse_csum_type(optarg);
+				break;
 			case GETOPT_VAL_HELP:
 			default:
 				print_usage(c != GETOPT_VAL_HELP);
@@ -1170,6 +1188,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	mkfs_cfg.sectorsize = sectorsize;
 	mkfs_cfg.stripesize = stripesize;
 	mkfs_cfg.features = features;
+	mkfs_cfg.csum_type = csum_type;
 
 	ret = make_btrfs(fd, &mkfs_cfg);
 	if (ret) {
-- 
2.16.4

