Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7A01749FF
	for <lists+linux-btrfs@lfdr.de>; Thu, 25 Jul 2019 11:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390582AbfGYJeT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 25 Jul 2019 05:34:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:52346 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403758AbfGYJeL (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 25 Jul 2019 05:34:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2CC56AE6D
        for <linux-btrfs@vger.kernel.org>; Thu, 25 Jul 2019 09:34:09 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [RFC PATCH 05/17] btrfs-progs: add option for checksum type to mkfs
Date:   Thu, 25 Jul 2019 11:33:52 +0200
Message-Id: <d404e57945240f413ab62945fd1cc4bfc86364ae.1564046971.git.jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <cover.1564046812.git.jthumshirn@suse.de>
References: <cover.1564046812.git.jthumshirn@suse.de>
In-Reply-To: <cover.1564046812.git.jthumshirn@suse.de>
References: <cover.1564046812.git.jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add an option to mkfs to specify which checksum algorithm will be used for
the filesystem.

XXX this patch should go last in the series.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 mkfs/common.c |  2 +-
 mkfs/common.h |  2 ++
 mkfs/main.c   | 21 ++++++++++++++++++++-
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/mkfs/common.c b/mkfs/common.c
index caca5e707233..8249492704ad 100644
--- a/mkfs/common.c
+++ b/mkfs/common.c
@@ -201,7 +201,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
 	super.__unused_leafsize = cpu_to_le32(cfg->nodesize);
 	btrfs_set_super_nodesize(&super, cfg->nodesize);
 	btrfs_set_super_stripesize(&super, cfg->stripesize);
-	btrfs_set_super_csum_type(&super, BTRFS_CSUM_TYPE_CRC32);
+	btrfs_set_super_csum_type(&super, cfg->csum_type);
 	btrfs_set_super_chunk_root_generation(&super, 1);
 	btrfs_set_super_cache_generation(&super, -1);
 	btrfs_set_super_incompat_flags(&super, cfg->features);
diff --git a/mkfs/common.h b/mkfs/common.h
index 28912906d0a9..384c1ef6a753 100644
--- a/mkfs/common.h
+++ b/mkfs/common.h
@@ -53,6 +53,8 @@ struct btrfs_mkfs_config {
 	u64 features;
 	/* Size of the filesystem in bytes */
 	u64 num_bytes;
+	/* checksum algorithm to use */
+	u16 csum_type;
 
 	/* Output fields, set during creation */
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 8dbec0717b89..3deff76045ba 100644
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
 
+static u16 parse_csum_type(const char *s)
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
+	int csum_type = BTRFS_CSUM_TYPE_CRC32;
 
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

