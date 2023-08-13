Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD7E77A5E7
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Aug 2023 11:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjHMJvY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Aug 2023 05:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjHMJvV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Aug 2023 05:51:21 -0400
Received: from mail-108-mta98.mxroute.com (mail-108-mta98.mxroute.com [136.175.108.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6891718
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Aug 2023 02:51:21 -0700 (PDT)
Received: from mail-111-mta2.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta98.mxroute.com (ZoneMTA) with ESMTPSA id 189ee49eb1000023b6.001
 for <linux-btrfs@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 13 Aug 2023 09:46:09 +0000
X-Zone-Loop: af3278ed87ca2e15cdf2442caee45a39ba62aac6b761
X-Originating-IP: [136.175.111.2]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=c8h4.io;
        s=x; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=FB9saJ73aePHW12/2NAYHB+pC/mx/z3q0o4a5z26h+w=; b=VUc8UiaXpeZZNvg28sq6P979mi
        mUiQCRZ/d9Yv63MaZle5591Ti37S7i0dGIilT/0zdP+mW/VPjNZcbVJwj9f30ISERERfaghcdVgZ6
        D8eNBUf4MDFOgrIVkWVbWPGUFtcKS+S3i8/n3foYKFrBGq7ztQYfrtHGrBLQ06a0yKwPmzPcKh9pq
        X1lA/OvPjdRIzBtAimhUK4h1erm/kLTryjOXD9rVcXXHNpi5UXI6OE95N7+ZfLvCWqE+uXRCg1KOB
        XLrDFckSMNp/Q+czMSUiSDBPMboB3WOKyC4HKKhipKOJ53t9ULufQmmEMxtq3V/Lrb9uoWgWDoyXm
        tYCvMGmg==;
From:   Christoph Heiss <christoph@c8h4.io>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/7] btrfs-progs: subvol get-default: implement json format output
Date:   Sun, 13 Aug 2023 11:45:01 +0200
Message-ID: <20230813094555.106052-7-christoph@c8h4.io>
In-Reply-To: <20230813094555.106052-1-christoph@c8h4.io>
References: <20230813094555.106052-1-christoph@c8h4.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: christoph@c8h4.io
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Implements JSON-formatted output for the `subvolume get-default` command
using the `--format json` global option, much like it is implemented for
other commands.

Signed-off-by: Christoph Heiss <christoph@c8h4.io>
---
 cmds/subvolume.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index cb863ac7..f7076655 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -701,6 +701,8 @@ static DEFINE_SIMPLE_COMMAND(subvolume_snapshot, "snapshot");
 static const char * const cmd_subvolume_get_default_usage[] = {
 	"btrfs subvolume get-default <path>",
 	"Get the default subvolume of a filesystem",
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_FORMAT,
 	NULL
 };
 
@@ -712,6 +714,7 @@ static int cmd_subvolume_get_default(const struct cmd_struct *cmd, int argc, cha
 	DIR *dirstream = NULL;
 	enum btrfs_util_error err;
 	struct btrfs_util_subvolume_info subvol;
+	struct format_ctx fctx;
 	char *path;
 
 	clean_args_no_options(cmd, argc, argv);
@@ -731,7 +734,14 @@ static int cmd_subvolume_get_default(const struct cmd_struct *cmd, int argc, cha
 
 	/* no need to resolve roots if FS_TREE is default */
 	if (default_id == BTRFS_FS_TREE_OBJECTID) {
-		pr_verbose(LOG_DEFAULT, "ID 5 (FS_TREE)\n");
+		if (bconf.output_format == CMD_FORMAT_JSON) {
+			fmt_start(&fctx, btrfs_subvolume_rowspec, 1, 0);
+			fmt_print(&fctx, "ID", 5);
+			fmt_end(&fctx);
+		} else {
+			pr_verbose(LOG_DEFAULT, "ID 5 (FS_TREE)\n");
+		}
+
 		ret = 0;
 		goto out;
 	}
@@ -748,8 +758,17 @@ static int cmd_subvolume_get_default(const struct cmd_struct *cmd, int argc, cha
 		goto out;
 	}
 
-	pr_verbose(LOG_DEFAULT, "ID %" PRIu64 " gen %" PRIu64 " top level %" PRIu64 " path %s\n",
-	       subvol.id, subvol.generation, subvol.parent_id, path);
+	if (bconf.output_format == CMD_FORMAT_JSON) {
+		fmt_start(&fctx, btrfs_subvolume_rowspec, 1, 0);
+		fmt_print(&fctx, "ID", subvol.id);
+		fmt_print(&fctx, "gen", subvol.generation);
+		fmt_print(&fctx, "top level", subvol.parent_id);
+		fmt_print(&fctx, "path", path);
+		fmt_end(&fctx);
+	} else {
+		pr_verbose(LOG_DEFAULT, "ID %" PRIu64 " gen %" PRIu64 " top level %" PRIu64 " path %s\n",
+		       subvol.id, subvol.generation, subvol.parent_id, path);
+	}
 
 	free(path);
 
@@ -758,7 +777,7 @@ out:
 	close_file_or_dir(fd, dirstream);
 	return ret;
 }
-static DEFINE_SIMPLE_COMMAND(subvolume_get_default, "get-default");
+static DEFINE_COMMAND_WITH_FLAGS(subvolume_get_default, "get-default", CMD_FORMAT_JSON);
 
 static const char * const cmd_subvolume_set_default_usage[] = {
 	"btrfs subvolume set-default <subvolume>\n"
-- 
2.41.0

