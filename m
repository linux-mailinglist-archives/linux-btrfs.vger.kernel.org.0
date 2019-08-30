Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18A9DA35C0
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2019 13:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbfH3Lcr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Aug 2019 07:32:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:48890 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727961AbfH3Lcm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Aug 2019 07:32:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2737BB028;
        Fri, 30 Aug 2019 11:32:39 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v3 08/12] btrfs-progs: add option for checksum type to mkfs
Date:   Fri, 30 Aug 2019 13:32:30 +0200
Message-Id: <20190830113234.16615-9-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190830113234.16615-1-jthumshirn@suse.de>
References: <20190830113234.16615-1-jthumshirn@suse.de>
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
 mkfs/main.c      | 21 ++++++++++++++++++++-
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/convert/common.c b/convert/common.c
index 8cae507ec0f7..2e2318a5863e 100644
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
diff --git a/mkfs/main.c b/mkfs/main.c
index b752da13aba9..e96cbc5399a2 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -352,6 +352,7 @@ static void print_usage(int ret)
 	printf("\t--shrink                (with --rootdir) shrink the filled filesystem to minimal size\n");
 	printf("\t-K|--nodiscard          do not perform whole device TRIM\n");
 	printf("\t-f|--force              force overwrite of existing filesystem\n");
+	printf("\t-C|--checksum           checksum algorithm to use (default: crc32c)\n");
 	printf("  general:\n");
 	printf("\t-q|--quiet              no messages except errors\n");
 	printf("\t-V|--version            print the mkfs.btrfs version and exit\n");
@@ -386,6 +387,18 @@ static u64 parse_profile(const char *s)
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
@@ -832,6 +845,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	u64 features = BTRFS_MKFS_DEFAULT_FEATURES;
 	struct mkfs_allocation allocation = { 0 };
 	struct btrfs_mkfs_config mkfs_cfg;
+	enum btrfs_csum_type csum_type = BTRFS_CSUM_TYPE_CRC32;
 
 	crc32c_optimization_init();
 
@@ -841,6 +855,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		static const struct option long_options[] = {
 			{ "alloc-start", required_argument, NULL, 'A'},
 			{ "byte-count", required_argument, NULL, 'b' },
+			{ "checksum", required_argument, NULL, 'C' },
 			{ "force", no_argument, NULL, 'f' },
 			{ "leafsize", required_argument, NULL, 'l' },
 			{ "label", required_argument, NULL, 'L'},
@@ -860,7 +875,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			{ NULL, 0, NULL, 0}
 		};
 
-		c = getopt_long(argc, argv, "A:b:fl:n:s:m:d:L:O:r:U:VMKq",
+		c = getopt_long(argc, argv, "A:b:C:fl:n:s:m:d:L:O:r:U:VMKq",
 				long_options, NULL);
 		if (c < 0)
 			break;
@@ -938,6 +953,9 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 			case GETOPT_VAL_SHRINK:
 				shrink_rootdir = true;
 				break;
+			case 'C':
+				csum_type = parse_csum_type(optarg);
+				break;
 			case GETOPT_VAL_HELP:
 			default:
 				print_usage(c != GETOPT_VAL_HELP);
@@ -1176,6 +1194,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	mkfs_cfg.sectorsize = sectorsize;
 	mkfs_cfg.stripesize = stripesize;
 	mkfs_cfg.features = features;
+	mkfs_cfg.csum_type = csum_type;
 
 	ret = make_btrfs(fd, &mkfs_cfg);
 	if (ret) {
-- 
2.16.4

