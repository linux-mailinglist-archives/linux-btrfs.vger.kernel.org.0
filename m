Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25FD1D2B88
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 May 2020 11:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgENJfG (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 May 2020 05:35:06 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:41180 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgENJfF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 May 2020 05:35:05 -0400
Received: by mail-wr1-f47.google.com with SMTP id h17so2965132wrc.8
        for <linux-btrfs@vger.kernel.org>; Thu, 14 May 2020 02:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QFGtS7iNjUcdSLCLPWnO4stRBHLfU3RsWUTCNjCGcHI=;
        b=MWKkh7+pspq9PHVfqUXgqsUwciFIPg1Jfscy+SVMk3bMo1v7H4D6onVxaqOdBQ1oEA
         +KFWnOF7TEuQ0sFftNoFY8AZ6i6trv1Trk5sSJKWloto1wfCf//8XQ9xZ2Fr7XTsx3r7
         CW5D4rwDXV9z88LLdHch7ng4Tr+i333Ld6XOy6DMIJr99mbMa4wRR6b9u8DkTBGx00wt
         bmKOgNr8vJBjqTmVClntgZTHq007hwZHY+VZAP+r1DvqzN/U/LZ+S9y2f8GmOhjntVVu
         zbjd8UAVvuKSjiZapUJ1rMlcccnVOsAMIf0nMy2eDy3+sbJPLF7LiND4NyY0EIo+OpH6
         LWVw==
X-Gm-Message-State: AOAM531ABBfmxRJ8ldELadqIE69CGjfxHjr2d8hU/eQaMXnkVXhMwxub
        2L3w7yjxBILvQNQ4GhcKMpY=
X-Google-Smtp-Source: ABdhPJyjnhOk+cTGV40BveOlIy+sRYPpK8TrxfH080RbsTvd9F2gWzO/CQnOIICSt7di4+TywjRnbA==
X-Received: by 2002:adf:8169:: with SMTP id 96mr4340399wrm.283.1589448903618;
        Thu, 14 May 2020 02:35:03 -0700 (PDT)
Received: from linux-t19r.fritz.box (ppp-46-244-223-154.dynamic.mnet-online.de. [46.244.223.154])
        by smtp.gmail.com with ESMTPSA id l12sm3522750wrh.20.2020.05.14.02.35.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2020 02:35:03 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 4/5] btrfs-progs: add --auth-key to dump-super
Date:   Thu, 14 May 2020 11:34:32 +0200
Message-Id: <20200514093433.6818-5-jth@kernel.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200514093433.6818-1-jth@kernel.org>
References: <20200514093433.6818-1-jth@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Add auth-key option for btrfs inspect-internal dump-super so we can dump an
authenticated super-block and check for it's integrity.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 cmds/inspect-dump-super.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index dd42d180..1bc806e9 100644
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
@@ -326,7 +328,8 @@ static bool is_valid_csum_type(u16 csum_type)
 	}
 }
 
-static void dump_superblock(struct btrfs_super_block *sb, int full)
+static void dump_superblock(struct btrfs_super_block *sb, int full,
+			    char *auth_key)
 {
 	int i;
 	char *s, buf[BTRFS_UUID_UNPARSED_SIZE];
@@ -353,11 +356,11 @@ static void dump_superblock(struct btrfs_super_block *sb, int full)
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
@@ -485,7 +488,7 @@ static void dump_superblock(struct btrfs_super_block *sb, int full)
 }
 
 static int load_and_dump_sb(char *filename, int fd, u64 sb_bytenr, int full,
-		int force)
+		int force, char *auth_key)
 {
 	u8 super_block_data[BTRFS_SUPER_INFO_SIZE];
 	struct btrfs_super_block *sb;
@@ -510,7 +513,7 @@ static int load_and_dump_sb(char *filename, int fd, u64 sb_bytenr, int full,
 		error("bad magic on superblock on %s at %llu",
 				filename, (unsigned long long)sb_bytenr);
 	} else {
-		dump_superblock(sb, full);
+		dump_superblock(sb, full, auth_key);
 	}
 	return 0;
 }
@@ -524,6 +527,7 @@ static const char * const cmd_inspect_dump_super_usage[] = {
 	"-s|--super <super>    specify which copy to print out (values: 0, 1, 2)",
 	"-F|--force            attempt to dump superblocks with bad magic",
 	"--bytenr <offset>     specify alternate superblock offset",
+	"--auth-key <key>      specify authentication key for authenticated file-system",
 	"",
 	"Deprecated syntax:",
 	"-s <bytenr>           specify alternate superblock offset, values other than 0, 1, 2",
@@ -546,16 +550,19 @@ static int cmd_inspect_dump_super(const struct cmd_struct *cmd,
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
 
@@ -602,13 +609,16 @@ static int cmd_inspect_dump_super(const struct cmd_struct *cmd,
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
@@ -625,7 +635,8 @@ static int cmd_inspect_dump_super(const struct cmd_struct *cmd,
 			for (idx = 0; idx < BTRFS_SUPER_MIRROR_MAX; idx++) {
 				sb_bytenr = btrfs_sb_offset(idx);
 				if (load_and_dump_sb(filename, fd,
-						sb_bytenr, full, force)) {
+						sb_bytenr, full, force,
+						auth_key)) {
 					close(fd);
 					ret = 1;
 					goto out;
@@ -634,13 +645,15 @@ static int cmd_inspect_dump_super(const struct cmd_struct *cmd,
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
2.26.1

