Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F9F77A5E5
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Aug 2023 11:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjHMJvV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Aug 2023 05:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjHMJvU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Aug 2023 05:51:20 -0400
Received: from mail-108-mta231.mxroute.com (mail-108-mta231.mxroute.com [136.175.108.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AED10FE
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Aug 2023 02:51:16 -0700 (PDT)
Received: from mail-111-mta2.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta231.mxroute.com (ZoneMTA) with ESMTPSA id 189ee49e40300023b6.001
 for <linux-btrfs@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 13 Aug 2023 09:46:07 +0000
X-Zone-Loop: ab7c8a571c2c45539a82f4dc730fbec72a081cbfbcbd
X-Originating-IP: [136.175.111.2]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=c8h4.io;
        s=x; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=wOrs6ZCSsovN1VntlVdgmEr9ceHBhCNp9NO6L3xvDxc=; b=ibH82YwP/u/ffy+u6OjWF+U+an
        /q4R1HOuQnpP0LJ3DY/4da1jPwHSr5/B1T4/XKoIWRRjCGZEwPQDd9rB1opTwssIvTHQEcasMNMWY
        QcHmL4UztD3Iu6UJjhAjjfvEKm/1bhcmkUkJHhItvW4iQUjpJt8kvgSHZMPdzdUSXjHCyzmTqwv5d
        3vviuLLPqndxCjUxBf6W25x+IVp4WBmLBD5V9qml3UnGY460xPOtpLUBvZWtv8fJsV/16F3SHxnEM
        x1SPKkyOpgxiQAU8lnWS4xrDxfxSrYN778nTx5nKwqzzKL0OkC0f3dFmPBIL5SUdRgeLI5kv1usEO
        6R+vc31w==;
From:   Christoph Heiss <christoph@c8h4.io>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 3/7] btrfs-progs: subvol show: factor out text printing to own function
Date:   Sun, 13 Aug 2023 11:44:58 +0200
Message-ID: <20230813094555.106052-4-christoph@c8h4.io>
In-Reply-To: <20230813094555.106052-1-christoph@c8h4.io>
References: <20230813094555.106052-1-christoph@c8h4.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: christoph@c8h4.io
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 cmds/subvolume.c | 190 ++++++++++++++++++++++++++---------------------
 1 file changed, 107 insertions(+), 83 deletions(-)

diff --git a/cmds/subvolume.c b/cmds/subvolume.c
index a5423759..65cff24b 100644
--- a/cmds/subvolume.c
+++ b/cmds/subvolume.c
@@ -1232,6 +1232,105 @@ static int cmd_subvolume_find_new(const struct cmd_struct *cmd, int argc, char *
 }
 static DEFINE_SIMPLE_COMMAND(subvolume_find_new, "find-new");
 
+static void print_subvolume_show_text(const struct btrfs_util_subvolume_info *subvol,
+				      const char *subvol_path, const char *subvol_name)
+{
+	char tstr[256];
+	char uuidparse[BTRFS_UUID_UNPARSED_SIZE];
+
+	/* Warn if it's a read-write subvolume with received_uuid */
+	if (!uuid_is_null(subvol->received_uuid) &&
+	    !(subvol->flags & BTRFS_ROOT_SUBVOL_RDONLY)) {
+		warning("the subvolume is read-write and has received_uuid set,\n"
+			"\t don't use it for incremental send. Please see section\n"
+			"\t 'SUBVOLUME FLAGS' in manual page btrfs-subvolume for\n"
+			"\t further information.");
+	}
+
+	/* print the info */
+	pr_verbose(LOG_DEFAULT, "%s\n",
+		   subvol->id == BTRFS_FS_TREE_OBJECTID ? "/" : subvol_path);
+	pr_verbose(LOG_DEFAULT, "\tName: \t\t\t%s\n", subvol_name);
+
+	if (uuid_is_null(subvol->uuid))
+		strcpy(uuidparse, "-");
+	else
+		uuid_unparse(subvol->uuid, uuidparse);
+	pr_verbose(LOG_DEFAULT, "\tUUID: \t\t\t%s\n", uuidparse);
+
+	if (uuid_is_null(subvol->parent_uuid))
+		strcpy(uuidparse, "-");
+	else
+		uuid_unparse(subvol->parent_uuid, uuidparse);
+	pr_verbose(LOG_DEFAULT, "\tParent UUID: \t\t%s\n", uuidparse);
+
+	if (uuid_is_null(subvol->received_uuid))
+		strcpy(uuidparse, "-");
+	else
+		uuid_unparse(subvol->received_uuid, uuidparse);
+	pr_verbose(LOG_DEFAULT, "\tReceived UUID: \t\t%s\n", uuidparse);
+
+	if (subvol->otime.tv_sec) {
+		struct tm tm;
+
+		localtime_r(&subvol->otime.tv_sec, &tm);
+		strftime(tstr, 256, "%Y-%m-%d %X %z", &tm);
+	} else
+		strcpy(tstr, "-");
+	pr_verbose(LOG_DEFAULT, "\tCreation time: \t\t%s\n", tstr);
+
+	pr_verbose(LOG_DEFAULT, "\tSubvolume ID: \t\t%" PRIu64 "\n", subvol->id);
+	pr_verbose(LOG_DEFAULT, "\tGeneration: \t\t%" PRIu64 "\n", subvol->generation);
+	pr_verbose(LOG_DEFAULT, "\tGen at creation: \t%" PRIu64 "\n", subvol->otransid);
+	pr_verbose(LOG_DEFAULT, "\tParent ID: \t\t%" PRIu64 "\n", subvol->parent_id);
+	pr_verbose(LOG_DEFAULT, "\tTop level ID: \t\t%" PRIu64 "\n", subvol->parent_id);
+
+	if (subvol->flags & BTRFS_ROOT_SUBVOL_RDONLY)
+		pr_verbose(LOG_DEFAULT, "\tFlags: \t\t\treadonly\n");
+	else
+		pr_verbose(LOG_DEFAULT, "\tFlags: \t\t\t-\n");
+
+	pr_verbose(LOG_DEFAULT, "\tSend transid: \t\t%" PRIu64 "\n", subvol->stransid);
+	pr_verbose(LOG_DEFAULT, "\tSend time: \t\t%s\n", tstr);
+	if (subvol->stime.tv_sec) {
+		struct tm tm;
+
+		localtime_r(&subvol->stime.tv_sec, &tm);
+		strftime(tstr, 256, "%Y-%m-%d %X %z", &tm);
+	} else {
+		strcpy(tstr, "-");
+	}
+	pr_verbose(LOG_DEFAULT, "\tReceive transid: \t%" PRIu64 "\n", subvol->rtransid);
+	if (subvol->rtime.tv_sec) {
+		struct tm tm;
+
+		localtime_r(&subvol->rtime.tv_sec, &tm);
+		strftime(tstr, 256, "%Y-%m-%d %X %z", &tm);
+	} else {
+		strcpy(tstr, "-");
+	}
+	pr_verbose(LOG_DEFAULT, "\tReceive time: \t\t%s\n", tstr);
+}
+
+static void print_subvolume_show_quota_text(const struct btrfs_util_subvolume_info *subvol,
+					    const struct btrfs_qgroup_stats *stats,
+					    unsigned int unit_mode)
+{
+	pr_verbose(LOG_DEFAULT, "\tQuota group:\t\t0/%" PRIu64 "\n", subvol->id);
+	fflush(stdout);
+
+	pr_verbose(LOG_DEFAULT, "\t  Limit referenced:\t%s\n",
+			stats->limit.max_referenced == 0 ? "-" :
+			pretty_size_mode(stats->limit.max_referenced, unit_mode));
+	pr_verbose(LOG_DEFAULT, "\t  Limit exclusive:\t%s\n",
+			stats->limit.max_exclusive == 0 ? "-" :
+			pretty_size_mode(stats->limit.max_exclusive, unit_mode));
+	pr_verbose(LOG_DEFAULT, "\t  Usage referenced:\t%s\n",
+			pretty_size_mode(stats->info.referenced, unit_mode));
+	pr_verbose(LOG_DEFAULT, "\t  Usage exclusive:\t%s\n",
+			pretty_size_mode(stats->info.exclusive, unit_mode));
+}
+
 static const char * const cmd_subvolume_show_usage[] = {
 	"btrfs subvolume show [options] <path>",
 	"Show more information about the subvolume (UUIDs, generations, times, snapshots)",
@@ -1247,7 +1346,6 @@ static const char * const cmd_subvolume_show_usage[] = {
 
 static int cmd_subvolume_show(const struct cmd_struct *cmd, int argc, char **argv)
 {
-	char tstr[256];
 	char uuidparse[BTRFS_UUID_UNPARSED_SIZE];
 	char *fullpath = NULL;
 	int fd = -1;
@@ -1260,6 +1358,7 @@ static int cmd_subvolume_show(const struct cmd_struct *cmd, int argc, char **arg
 	struct btrfs_util_subvolume_iterator *iter;
 	struct btrfs_util_subvolume_info subvol;
 	char *subvol_path = NULL;
+	char *subvol_name = NULL;
 	enum btrfs_util_error err;
 	struct btrfs_qgroup_stats stats;
 	unsigned int unit_mode;
@@ -1365,78 +1464,15 @@ static int cmd_subvolume_show(const struct cmd_struct *cmd, int argc, char **arg
 
 	}
 
-	/* Warn if it's a read-write subvolume with received_uuid */
-	if (!uuid_is_null(subvol.received_uuid) &&
-	    !(subvol.flags & BTRFS_ROOT_SUBVOL_RDONLY)) {
-		warning("the subvolume is read-write and has received_uuid set,\n"
-			"\t don't use it for incremental send. Please see section\n"
-			"\t 'SUBVOLUME FLAGS' in manual page btrfs-subvolume for\n"
-			"\t further information.");
-	}
-	/* print the info */
-	pr_verbose(LOG_DEFAULT, "%s\n", subvol.id == BTRFS_FS_TREE_OBJECTID ? "/" : subvol_path);
-	pr_verbose(LOG_DEFAULT, "\tName: \t\t\t%s\n",
-	       (subvol.id == BTRFS_FS_TREE_OBJECTID ? "<FS_TREE>" :
-		basename(subvol_path)));
-
-	if (uuid_is_null(subvol.uuid))
-		strcpy(uuidparse, "-");
-	else
-		uuid_unparse(subvol.uuid, uuidparse);
-	pr_verbose(LOG_DEFAULT, "\tUUID: \t\t\t%s\n", uuidparse);
-
-	if (uuid_is_null(subvol.parent_uuid))
-		strcpy(uuidparse, "-");
-	else
-		uuid_unparse(subvol.parent_uuid, uuidparse);
-	pr_verbose(LOG_DEFAULT, "\tParent UUID: \t\t%s\n", uuidparse);
-
-	if (uuid_is_null(subvol.received_uuid))
-		strcpy(uuidparse, "-");
-	else
-		uuid_unparse(subvol.received_uuid, uuidparse);
-	pr_verbose(LOG_DEFAULT, "\tReceived UUID: \t\t%s\n", uuidparse);
-
-	if (subvol.otime.tv_sec) {
-		struct tm tm;
-
-		localtime_r(&subvol.otime.tv_sec, &tm);
-		strftime(tstr, 256, "%Y-%m-%d %X %z", &tm);
-	} else
-		strcpy(tstr, "-");
-	pr_verbose(LOG_DEFAULT, "\tCreation time: \t\t%s\n", tstr);
-
-	pr_verbose(LOG_DEFAULT, "\tSubvolume ID: \t\t%" PRIu64 "\n", subvol.id);
-	pr_verbose(LOG_DEFAULT, "\tGeneration: \t\t%" PRIu64 "\n", subvol.generation);
-	pr_verbose(LOG_DEFAULT, "\tGen at creation: \t%" PRIu64 "\n", subvol.otransid);
-	pr_verbose(LOG_DEFAULT, "\tParent ID: \t\t%" PRIu64 "\n", subvol.parent_id);
-	pr_verbose(LOG_DEFAULT, "\tTop level ID: \t\t%" PRIu64 "\n", subvol.parent_id);
-
-	if (subvol.flags & BTRFS_ROOT_SUBVOL_RDONLY)
-		pr_verbose(LOG_DEFAULT, "\tFlags: \t\t\treadonly\n");
-	else
-		pr_verbose(LOG_DEFAULT, "\tFlags: \t\t\t-\n");
-
-	pr_verbose(LOG_DEFAULT, "\tSend transid: \t\t%" PRIu64 "\n", subvol.stransid);
-	pr_verbose(LOG_DEFAULT, "\tSend time: \t\t%s\n", tstr);
-	if (subvol.stime.tv_sec) {
-		struct tm tm;
-
-		localtime_r(&subvol.stime.tv_sec, &tm);
-		strftime(tstr, 256, "%Y-%m-%d %X %z", &tm);
+	if (subvol.id == BTRFS_FS_TREE_OBJECTID) {
+		free(subvol_path);
+		subvol_path = strdup("/");
+		subvol_name = "<FS_TREE>";
 	} else {
-		strcpy(tstr, "-");
+		subvol_name = basename(subvol_path);
 	}
-	pr_verbose(LOG_DEFAULT, "\tReceive transid: \t%" PRIu64 "\n", subvol.rtransid);
-	if (subvol.rtime.tv_sec) {
-		struct tm tm;
 
-		localtime_r(&subvol.rtime.tv_sec, &tm);
-		strftime(tstr, 256, "%Y-%m-%d %X %z", &tm);
-	} else {
-		strcpy(tstr, "-");
-	}
-	pr_verbose(LOG_DEFAULT, "\tReceive time: \t\t%s\n", tstr);
+	print_subvolume_show_text(&subvol, subvol_path, subvol_name);
 
 	/* print the snapshots of the given subvol if any*/
 	pr_verbose(LOG_DEFAULT, "\tSnapshot(s):\n");
@@ -1478,19 +1514,7 @@ static int cmd_subvolume_show(const struct cmd_struct *cmd, int argc, char **arg
 		goto out;
 	}
 
-	pr_verbose(LOG_DEFAULT, "\tQuota group:\t\t0/%" PRIu64 "\n", subvol.id);
-	fflush(stdout);
-
-	pr_verbose(LOG_DEFAULT, "\t  Limit referenced:\t%s\n",
-			stats.limit.max_referenced == 0 ? "-" :
-			pretty_size_mode(stats.limit.max_referenced, unit_mode));
-	pr_verbose(LOG_DEFAULT, "\t  Limit exclusive:\t%s\n",
-			stats.limit.max_exclusive == 0 ? "-" :
-			pretty_size_mode(stats.limit.max_exclusive, unit_mode));
-	pr_verbose(LOG_DEFAULT, "\t  Usage referenced:\t%s\n",
-			pretty_size_mode(stats.info.referenced, unit_mode));
-	pr_verbose(LOG_DEFAULT, "\t  Usage exclusive:\t%s\n",
-			pretty_size_mode(stats.info.exclusive, unit_mode));
+	print_subvolume_show_quota_text(&subvol, &stats, unit_mode);
 
 out:
 	free(subvol_path);
-- 
2.41.0

