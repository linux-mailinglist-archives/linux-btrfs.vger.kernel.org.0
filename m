Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824B51BBC08
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Apr 2020 13:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgD1LLj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Apr 2020 07:11:39 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39526 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgD1LLh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Apr 2020 07:11:37 -0400
Received: by mail-wm1-f68.google.com with SMTP id y24so2393118wma.4
        for <linux-btrfs@vger.kernel.org>; Tue, 28 Apr 2020 04:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LAmD1I1J64F1thLf1cahC4sWWm61o1o1nMoXwtapJbw=;
        b=Cz+m3OPGTBoO/sl3INmK9+TnEoGSVFqNtoA+OnCZG92eUEV9HJzVK5RPe7UrZTS+x9
         +n6dQKQJbm6EpyAB4Bmfpo0AI/6DteDx+G34VAN1gEg2Bf0tyOG+6PQTRH8P44/K9f4R
         ioWDuYfrjqUWFiHQzfx6gjp1fckxJLUcjvfb1w2f1/IOX4SPEiSHDve05768iIsDKHCD
         zemsElfR//qaxpnPWMcA3RAxho3MVasH2XNbDPGuPgAIv00PuNbTGvpozsmceO4DKJzD
         LeZR0DybxAhrRAZraVBDg8cWKO43GOh9AL5gvvdee1nJK6qRSh5Y2nuo6Qzi2gng0izK
         Y1uA==
X-Gm-Message-State: AGi0PuaHdIJRVypAuBNjtKxaiCXyjojc4XI1Jz8/MeSy5rZe+NiTbKj9
        59UdsZkEyjFdxwFaN54ZR8DIGv2yMpoW7w==
X-Google-Smtp-Source: APiQypKMw/5c6fED6vIfi6KXnODankzE2HlNmC62ActPOkOMpabApK//WAgbTgfFzXLzP21epg8pBg==
X-Received: by 2002:a7b:ce88:: with SMTP id q8mr4285805wmj.161.1588072296028;
        Tue, 28 Apr 2020 04:11:36 -0700 (PDT)
Received: from linux-t19r.fritz.box (ppp-46-244-205-206.dynamic.mnet-online.de. [46.244.205.206])
        by smtp.gmail.com with ESMTPSA id b191sm3126291wmd.39.2020.04.28.04.11.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 04:11:35 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 5/5] btrfs-progs: add auth key to check
Date:   Tue, 28 Apr 2020 13:11:08 +0200
Message-Id: <20200428111109.5687-6-jth@kernel.org>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200428111109.5687-1-jth@kernel.org>
References: <20200428111109.5687-1-jth@kernel.org>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Add auth-key option for btrfs check so we can check an authenticated
file-system.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 check/main.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/check/main.c b/check/main.c
index 21b37e66..bb848edb 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9937,6 +9937,7 @@ static const char * const cmd_check_usage[] = {
 	"       --clear-space-cache v1|v2   clear space cache for v1 or v2",
 	"  check and reporting options:",
 	"       --check-data-csum           verify checksums of data blocks",
+	"       --auth-key                  key for authenticated file-system",
 	"       -Q|--qgroup-report          print a report on qgroup consistency",
 	"       -E|--subvol-extents <subvolid>",
 	"                                   print subvolume extents and sharing state",
@@ -9965,6 +9966,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 	int qgroup_report_ret;
 	unsigned ctree_flags = OPEN_CTREE_EXCLUSIVE;
 	int force = 0;
+	char *auth_key = NULL;
 
 	while(1) {
 		int c;
@@ -9972,7 +9974,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 			GETOPT_VAL_INIT_EXTENT, GETOPT_VAL_CHECK_CSUM,
 			GETOPT_VAL_READONLY, GETOPT_VAL_CHUNK_TREE,
 			GETOPT_VAL_MODE, GETOPT_VAL_CLEAR_SPACE_CACHE,
-			GETOPT_VAL_FORCE };
+			GETOPT_VAL_FORCE, GETOPT_VAL_AUTH_KEY };
 		static const struct option long_options[] = {
 			{ "super", required_argument, NULL, 's' },
 			{ "repair", no_argument, NULL, GETOPT_VAL_REPAIR },
@@ -9995,6 +9997,8 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 			{ "clear-space-cache", required_argument, NULL,
 				GETOPT_VAL_CLEAR_SPACE_CACHE},
 			{ "force", no_argument, NULL, GETOPT_VAL_FORCE },
+			{ "auth-key", required_argument, NULL,
+				GETOPT_VAL_AUTH_KEY },
 			{ NULL, 0, NULL, 0}
 		};
 
@@ -10082,6 +10086,9 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 			case GETOPT_VAL_FORCE:
 				force = 1;
 				break;
+			case GETOPT_VAL_AUTH_KEY:
+				auth_key = strdup(optarg);
+				break;
 		}
 	}
 
@@ -10162,7 +10169,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 		ctree_flags |= OPEN_CTREE_PARTIAL;
 
 	info = open_ctree_fs_info(argv[optind], bytenr, tree_root_bytenr,
-				  chunk_root_bytenr, ctree_flags, NULL);
+				  chunk_root_bytenr, ctree_flags, auth_key);
 	if (!info) {
 		error("cannot open file system");
 		ret = -EIO;
@@ -10508,6 +10515,8 @@ err_out:
 	if (ctx.progress_enabled)
 		task_deinit(ctx.info);
 
+	free(auth_key);
+
 	return err;
 }
 DEFINE_SIMPLE_COMMAND(check, "check");
-- 
2.16.4

