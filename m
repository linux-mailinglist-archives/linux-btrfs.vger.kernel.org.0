Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77D31D2B8A
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 May 2020 11:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgENJfH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 May 2020 05:35:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34280 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgENJfG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 May 2020 05:35:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id g14so13869976wme.1
        for <linux-btrfs@vger.kernel.org>; Thu, 14 May 2020 02:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d/+ZwHImVpfg2fbfG7e5tTb1Y0zb8CYXoOlm10QItlg=;
        b=n0K5lAp2RHxnZ7i89q5THhI4HYVRgliHOYtM9CJiT6f1l56zP702qLx8TtIUdsh+IN
         ACH19ZR34sXPKhixrUoDUK1Nmi4qJRTnmTiDPqg+iBLkaFqgp8bGhJfs041MTiojtR8U
         ooJ0auT4mQJ3q9S/ybHmkPY+6k8MZiRPjPkAjro9RU1s2kKAJs5Z1rawkwTEJwp0q2v6
         vI93X4oWha/5w2OvZa65mdG76DFzWfMmCUDuZ+wzD2IetJft6CRRQBnvh4WHcPjCzqhK
         yITLLKXOGzi0VwXCNM5+5jAHzfTMF7nv93YjhAZ8mb9pPdf/4spvapwvJ2ABHKPngwQt
         4w+g==
X-Gm-Message-State: AGi0PuavzFlQySVVgdn+5HqU9x4dPRGvvUuw7Wz6AqePDRZuHF+mbKYg
        GU8o/T45Hms7ud/zEh2DiBE=
X-Google-Smtp-Source: APiQypJEsH5Ov1DyHf8V6jULVOM37Vn6pYcvc9uMEb3YAsU0G62dSLi8PwnQvgHRZbMJj/NK41FvIQ==
X-Received: by 2002:a1c:770f:: with SMTP id t15mr46773396wmi.178.1589448904852;
        Thu, 14 May 2020 02:35:04 -0700 (PDT)
Received: from linux-t19r.fritz.box (ppp-46-244-223-154.dynamic.mnet-online.de. [46.244.223.154])
        by smtp.gmail.com with ESMTPSA id l12sm3522750wrh.20.2020.05.14.02.35.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2020 02:35:04 -0700 (PDT)
From:   Johannes Thumshirn <jth@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 5/5] btrfs-progs: add auth key to check
Date:   Thu, 14 May 2020 11:34:33 +0200
Message-Id: <20200514093433.6818-6-jth@kernel.org>
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
2.26.1

