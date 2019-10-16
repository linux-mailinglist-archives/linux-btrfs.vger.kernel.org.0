Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97D5BD8B81
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Oct 2019 10:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390087AbfJPImE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Oct 2019 04:42:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:48272 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404146AbfJPImD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Oct 2019 04:42:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 569D1AD7F
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Oct 2019 08:42:01 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Cc:     Johannes Thumshirn <jthumshirn@suse.de>
Subject: [RFC PATCH 4/4] btrfs-progs: add --auth-key to dump-super
Date:   Wed, 16 Oct 2019 10:41:58 +0200
Message-Id: <20191016084158.7573-4-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191016084158.7573-1-jthumshirn@suse.de>
References: <20191016084158.7573-1-jthumshirn@suse.de>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add auth-key option for btrfs inspect-internal dump-super so we can dump an
authenticated super-block and check for it's integrity.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 cmds/inspect-dump-super.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index 5bf5a6bc6f27..ad81ba9f9ea2 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -35,11 +35,13 @@
 #include "crypto/crc32c.h"
 #include "common/help.h"
 
-static int check_csum_sblock(void *sb, int csum_size, u16 csum_type)
+static int check_csum_sblock(void *sb, int csum_size, u16 csum_type,
+			     char *auth_key)
 {
+	struct btrfs_fs_info dummy_fs_info = { .auth_key = auth_key };
 	u8 result[BTRFS_CSUM_SIZE];
 
-	btrfs_csum_data(NULL, csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
+	btrfs_csum_data(&dummy_fs_info, csum_type, (u8 *)sb + BTRFS_CSUM_SIZE,
 			result, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
 
 	return !memcmp(sb, result, csum_size);
@@ -325,7 +327,8 @@ static bool is_valid_csum_type(u16 csum_type)
 	}
 }
 
-static void dump_superblock(struct btrfs_super_block *sb, int full)
+static void dump_superblock(struct btrfs_super_block *sb, int full,
+			    char *auth_key)
 {
 	int i;
 	char *s, buf[BTRFS_UUID_UNPARSED_SIZE];
@@ -352,11 +355,11 @@ static void dump_superblock(struct btrfs_super_block *sb, int full)
 	printf("csum\t\t\t0x");
 	for (i = 0, p = sb->csum; i < csum_size; i++)
 		printf("%02x", p[i]);
-	if (csum_type == BTRFS_CSUM_TYPE_HMAC_SHA256)
+	if (csum_type == BTRFS_CSUM_TYPE_HMAC_SHA256 && !auth_key)
 		printf(" [NO KEY FOR HMAC]");
 	else if (!is_valid_csum_type(csum_type))
 		printf(" [UNKNOWN CSUM TYPE OR SIZE]");
-	else if (check_csum_sblock(sb, csum_size, csum_type))
+	else if (check_csum_sblock(sb, csum_size, csum_type, auth_key))
 		printf(" [match]");
 	else
 		printf(" [DON'T MATCH]");
@@ -484,7 +487,7 @@ static void dump_superblock(struct btrfs_super_block *sb, int full)
 }
 
 static int load_and_dump_sb(char *filename, int fd, u64 sb_bytenr, int full,
-		int force)
+		int force, char *auth_key)
 {
 	u8 super_block_data[BTRFS_SUPER_INFO_SIZE];
 	struct btrfs_super_block *sb;
@@ -509,7 +512,7 @@ static int load_and_dump_sb(char *filename, int fd, u64 sb_bytenr, int full,
 		error("bad magic on superblock on %s at %llu",
 				filename, (unsigned long long)sb_bytenr);
 	} else {
-		dump_superblock(sb, full);
+		dump_superblock(sb, full, auth_key);
 	}
 	return 0;
 }
@@ -523,6 +526,7 @@ static const char * const cmd_inspect_dump_super_usage[] = {
 	"-s|--super <super>    specify which copy to print out (values: 0, 1, 2)",
 	"-F|--force            attempt to dump superblocks with bad magic",
 	"--bytenr <offset>     specify alternate superblock offset",
+	"--auth-key <key>      specify authentication key for authenticated file-system",
 	"",
 	"Deprecated syntax:",
 	"-s <bytenr>           specify alternate superblock offset, values other than 0, 1, 2",
@@ -545,16 +549,19 @@ static int cmd_inspect_dump_super(const struct cmd_struct *cmd,
 	int ret = 0;
 	u64 arg;
 	u64 sb_bytenr = btrfs_sb_offset(0);
+	char *auth_key = NULL;
 
 	while (1) {
 		int c;
-		enum { GETOPT_VAL_BYTENR = 257 };
+		enum { GETOPT_VAL_BYTENR = 257, GETOPT_VAL_AUTHKEY, };
 		static const struct option long_options[] = {
 			{"all", no_argument, NULL, 'a'},
 			{"bytenr", required_argument, NULL, GETOPT_VAL_BYTENR },
 			{"full", no_argument, NULL, 'f'},
 			{"force", no_argument, NULL, 'F'},
 			{"super", required_argument, NULL, 's' },
+			{"auth-key", required_argument, NULL,
+				GETOPT_VAL_AUTHKEY },
 			{NULL, 0, NULL, 0}
 		};
 
@@ -601,13 +608,16 @@ static int cmd_inspect_dump_super(const struct cmd_struct *cmd,
 			sb_bytenr = arg;
 			all = 0;
 			break;
+		case GETOPT_VAL_AUTHKEY:
+			auth_key = strdup(optarg);
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
 	}
 
 	if (check_argc_min(argc - optind, 1))
-		return 1;
+		goto out;
 
 	for (i = optind; i < argc; i++) {
 		filename = argv[i];
@@ -624,7 +634,8 @@ static int cmd_inspect_dump_super(const struct cmd_struct *cmd,
 			for (idx = 0; idx < BTRFS_SUPER_MIRROR_MAX; idx++) {
 				sb_bytenr = btrfs_sb_offset(idx);
 				if (load_and_dump_sb(filename, fd,
-						sb_bytenr, full, force)) {
+						sb_bytenr, full, force,
+						auth_key)) {
 					close(fd);
 					ret = 1;
 					goto out;
@@ -633,13 +644,15 @@ static int cmd_inspect_dump_super(const struct cmd_struct *cmd,
 				putchar('\n');
 			}
 		} else {
-			load_and_dump_sb(filename, fd, sb_bytenr, full, force);
+			load_and_dump_sb(filename, fd, sb_bytenr, full, force,
+					 auth_key);
 			putchar('\n');
 		}
 		close(fd);
 	}
 
 out:
+	free(auth_key);
 	return ret;
 }
 DEFINE_SIMPLE_COMMAND(inspect_dump_super, "dump-super");
-- 
2.16.4

