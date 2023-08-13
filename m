Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B5A77A5E8
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Aug 2023 11:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjHMJvZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Aug 2023 05:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjHMJvW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Aug 2023 05:51:22 -0400
Received: from mail-108-mta160.mxroute.com (mail-108-mta160.mxroute.com [136.175.108.160])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB54F1712
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Aug 2023 02:51:21 -0700 (PDT)
Received: from mail-111-mta2.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta160.mxroute.com (ZoneMTA) with ESMTPSA id 189ee49ed1200023b6.001
 for <linux-btrfs@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 13 Aug 2023 09:46:09 +0000
X-Zone-Loop: 1336b6fb27cafbaa9d87ceb81e384f554e1ce389494d
X-Originating-IP: [136.175.111.2]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=c8h4.io;
        s=x; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=hhQKnP2IWlvKtVIhpv86VFiOlUCM34ifxp8u6AljrK0=; b=MkkNRkjx0rdVbM9DIDeeSo4IwF
        /1t1W4H5BFh0fmcEvqbq44Gaw2C/ObBUjtPPlUu9GVQ6Cxd6clnZvOBHBCcFP0cUQFYhBOwbW9eyb
        cWmHwDEGWe9mbmSRLy2vW3uhNOhc6wUq8VobCEL7WMM0/RvKZ/LTji5CPH7OHLW859nRuPPn3VTim
        TJ4BQPXEZcStcE81s5Xsl6rj1apiJHUCnkbre8yypvVaBOgMn3SoplrKtjOCjxaxRBUooqU50Np5E
        Kw/93j0r2gAyi5J0oaLnVcdAv2ylxsvy4RDFmUyB8dk7H332QioKemViXWFxHueJd8TIb7V+7C1JF
        YblOejEQ==;
From:   Christoph Heiss <christoph@c8h4.io>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 7/7] btrfs-progs: subvol show: implement json format output
Date:   Sun, 13 Aug 2023 11:45:02 +0200
Message-ID: <20230813094555.106052-8-christoph@c8h4.io>
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

Implements JSON-formatted output for the `subvolume list` command using
the `--format json` global option, much like it is implemented for other
commands.

Signed-off-by: Christoph Heiss <christoph@c8h4.io>
---
 cmds/subvolume.c | 108 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 98 insertions(+), 10 deletions(-)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index f7076655..1f513a4a 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -1375,6 +1375,64 @@ static void print_subvolume_show_quota_text(const struct btrfs_util_subvolume_in
 			pretty_size_mode(stats->info.exclusive, unit_mode));
 }
 
+static void print_subvolume_show_json(struct format_ctx *fctx,
+				      const struct btrfs_util_subvolume_info *subvol,
+				      const char *subvol_path, const char *subvol_name)
+{
+	fmt_print(fctx, "name", subvol_name);
+
+	if (!uuid_is_null(subvol->uuid))
+		fmt_print(fctx, "uuid", subvol->uuid);
+	if (!uuid_is_null(subvol->parent_uuid))
+		fmt_print(fctx, "parent_uuid", subvol->parent_uuid);
+	if (!uuid_is_null(subvol->received_uuid))
+		fmt_print(fctx, "received_uuid", subvol->received_uuid);
+
+	fmt_print(fctx, "otime", subvol->otime);
+	fmt_print(fctx, "ID", subvol->id);
+	fmt_print(fctx, "gen", subvol->generation);
+	fmt_print(fctx, "cgen", subvol->otransid);
+	fmt_print(fctx, "parent", subvol->parent_id);
+	fmt_print(fctx, "top level", subvol->parent_id);
+
+	fmt_print_start_group(fctx, "flags", JSON_TYPE_ARRAY);
+	if (subvol->flags & BTRFS_ROOT_SUBVOL_RDONLY)
+		fmt_print(fctx, "flag-list-item", "readonly");
+	fmt_print_end_group(fctx, "flags");
+
+	if (subvol->stransid)
+		fmt_print(fctx, "stransid", subvol->stransid);
+
+	if (subvol->stime.tv_sec)
+		fmt_print(fctx, "stime", subvol->stime);
+
+	if (subvol->rtransid)
+		fmt_print(fctx, "rtransid", subvol->rtransid);
+
+	if (subvol->rtime.tv_sec)
+		fmt_print(fctx, "rtime", subvol->rtime);
+}
+
+static void print_subvolume_show_quota_json(struct format_ctx *fctx,
+					     const struct btrfs_util_subvolume_info *subvol,
+					     const struct btrfs_qgroup_stats *stats)
+{
+	fmt_print_start_group(fctx, "quota", JSON_TYPE_MAP);
+	fmt_print(fctx, "quota-group", 0, subvol->id);
+
+	fmt_print_start_group(fctx, "limit", JSON_TYPE_MAP);
+	fmt_print(fctx, "quota-ref", stats->limit.max_referenced);
+	fmt_print(fctx, "quota-excl", stats->limit.max_exclusive);
+	fmt_print_end_group(fctx, "limit");
+
+	fmt_print_start_group(fctx, "usage", JSON_TYPE_MAP);
+	fmt_print(fctx, "quota-ref", stats->info.referenced);
+	fmt_print(fctx, "quota-excl", stats->info.exclusive);
+	fmt_print_end_group(fctx, "usage");
+
+	fmt_print_end_group(fctx, "quota");
+}
+
 static const char * const cmd_subvolume_show_usage[] = {
 	"btrfs subvolume show [options] <path>",
 	"Show more information about the subvolume (UUIDs, generations, times, snapshots)",
@@ -1385,6 +1443,8 @@ static const char * const cmd_subvolume_show_usage[] = {
 	OPTLINE("-r|--rootid ID", "root id of the subvolume"),
 	OPTLINE("-u|--uuid UUID", "UUID of the subvolum"),
 	HELPINFO_UNITS_SHORT_LONG,
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_FORMAT,
 	NULL
 };
 
@@ -1406,6 +1466,7 @@ static int cmd_subvolume_show(const struct cmd_struct *cmd, int argc, char **arg
 	enum btrfs_util_error err;
 	struct btrfs_qgroup_stats stats;
 	unsigned int unit_mode;
+	struct format_ctx fctx;
 
 	unit_mode = get_unit_mode_from_arg(&argc, argv, 1);
 
@@ -1516,10 +1577,19 @@ static int cmd_subvolume_show(const struct cmd_struct *cmd, int argc, char **arg
 		subvol_name = basename(subvol_path);
 	}
 
-	print_subvolume_show_text(&subvol, subvol_path, subvol_name);
+	if (bconf.output_format == CMD_FORMAT_JSON) {
+		fmt_start(&fctx, btrfs_subvolume_rowspec, 1, 0);
+		fmt_print_start_group(&fctx, subvol_path, JSON_TYPE_MAP);
+		print_subvolume_show_json(&fctx, &subvol, subvol_path, subvol_name);
+	} else {
+		print_subvolume_show_text(&subvol, subvol_path, subvol_name);
+	}
 
 	/* print the snapshots of the given subvol if any*/
-	pr_verbose(LOG_DEFAULT, "\tSnapshot(s):\n");
+	if (bconf.output_format == CMD_FORMAT_JSON)
+		fmt_print_start_group(&fctx, "snapshots", JSON_TYPE_ARRAY);
+	else
+		pr_verbose(LOG_DEFAULT, "\tSnapshot(s):\n");
 
 	err = btrfs_util_create_subvolume_iterator_fd(fd,
 						      BTRFS_FS_TREE_OBJECTID, 0,
@@ -1535,30 +1605,48 @@ static int cmd_subvolume_show(const struct cmd_struct *cmd, int argc, char **arg
 		} else if (err) {
 			error_btrfs_util(err);
 			btrfs_util_destroy_subvolume_iterator(iter);
-			goto out;
+			goto out2;
 		}
 
-		if (uuid_compare(subvol2.parent_uuid, subvol.uuid) == 0)
-			pr_verbose(LOG_DEFAULT, "\t\t\t\t%s\n", path);
+		if (uuid_compare(subvol2.parent_uuid, subvol.uuid) == 0) {
+			if (bconf.output_format == CMD_FORMAT_JSON)
+				fmt_print(&fctx, "snapshot-list-item", path);
+			else
+				pr_verbose(LOG_DEFAULT, "\t\t\t\t%s\n", path);
+		}
 
 		free(path);
 	}
+
+	if (bconf.output_format == CMD_FORMAT_JSON)
+		fmt_print_end_group(&fctx, "snapshots");
+
 	btrfs_util_destroy_subvolume_iterator(iter);
 
 	ret = btrfs_qgroup_query(fd, subvol.id, &stats);
 	if (ret == -ENOTTY) {
 		/* Quota information not available, not fatal */
-		pr_verbose(LOG_DEFAULT, "\tQuota group:\t\tn/a\n");
+		if (bconf.output_format == CMD_FORMAT_TEXT)
+			pr_verbose(LOG_DEFAULT, "\tQuota group:\t\tn/a\n");
 		ret = 0;
-		goto out;
+		goto out2;
 	}
 
 	if (ret) {
 		error("quota query failed: %m");
-		goto out;
+		goto out2;
 	}
 
-	print_subvolume_show_quota_text(&subvol, &stats, unit_mode);
+	if (bconf.output_format == CMD_FORMAT_JSON)
+		print_subvolume_show_quota_json(&fctx, &subvol, &stats);
+	else
+		print_subvolume_show_quota_text(&subvol, &stats, unit_mode);
+
+out2:
+	if (bconf.output_format == CMD_FORMAT_JSON) {
+		fmt_print_end_group(&fctx, subvol_path);
+		fmt_end(&fctx);
+	}
 
 out:
 	free(subvol_path);
@@ -1566,7 +1654,7 @@ out:
 	free(fullpath);
 	return !!ret;
 }
-static DEFINE_SIMPLE_COMMAND(subvolume_show, "show");
+static DEFINE_COMMAND_WITH_FLAGS(subvolume_show, "show", CMD_FORMAT_JSON);
 
 static const char * const cmd_subvolume_sync_usage[] = {
 	"btrfs subvolume sync <path> [<subvolid>...]",
-- 
2.41.0

