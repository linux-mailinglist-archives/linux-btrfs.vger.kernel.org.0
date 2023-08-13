Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A4277A5E6
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Aug 2023 11:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjHMJvX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Aug 2023 05:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjHMJvV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Aug 2023 05:51:21 -0400
Received: from mail-108-mta155.mxroute.com (mail-108-mta155.mxroute.com [136.175.108.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB45C1710
        for <linux-btrfs@vger.kernel.org>; Sun, 13 Aug 2023 02:51:21 -0700 (PDT)
Received: from mail-111-mta2.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta155.mxroute.com (ZoneMTA) with ESMTPSA id 189ee49e8c600023b6.001
 for <linux-btrfs@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 13 Aug 2023 09:46:08 +0000
X-Zone-Loop: c8d07d44ba2b396021e37d7c839687867f1daecf41ec
X-Originating-IP: [136.175.111.2]
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=c8h4.io;
        s=x; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=DJRya04kart+Tx59DLAWo+K2dJaDrWgO5TBnAmqSgfQ=; b=KijIPd+/1S4sAFcFbJi/JR11/n
        iiSdJV2Nf2NOp4vwhEQhb7TaLwJI0AcupVxYHV6YKYvKVjwia0cv7AbjQmI/UUAscYgkzYdzhIm+J
        d/o79MpQMKCI6Ix7Go63HGecBZUlSkLeG2vZ8j8j838TgFaeEPLSXn3LPRaGFfMp5q9ae6+SfuQ9P
        iRNj4QEqOS0sDgWiTF0iM43sjKopyVkehgvV1iqd/uXZbI/foNc7/mCMCm5bnR0v0MhXSw52kHUE0
        UFu6VXoI35b844tSAbousB+rtj0oh4xOaQZ5tqnSqisah5EK5rACFvMSz+uPkWwtavCtteMKL1IWr
        yMDIyBqg==;
From:   Christoph Heiss <christoph@c8h4.io>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/7] btrfs-progs: subvol list: implement json format output
Date:   Sun, 13 Aug 2023 11:45:00 +0200
Message-ID: <20230813094555.106052-6-christoph@c8h4.io>
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

Re-uses the `btrfs_list_layout` infrastructure to nicely fit it into the
existing formatting code.

A notable difference to the normal, text-based output is that in the
JSON output, timestamps include the timezone offset as well.

Signed-off-by: Christoph Heiss <christoph@c8h4.io>
---
 cmds/subvolume-list.c | 91 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 88 insertions(+), 3 deletions(-)

diff --git a/cmds/subvolume-list.c b/cmds/subvolume-list.c
index 382b0676..be7faca6 100644
--- a/cmds/subvolume-list.c
+++ b/cmds/subvolume-list.c
@@ -35,7 +35,9 @@
 #include "common/open-utils.h"
 #include "common/string-utils.h"
 #include "common/utils.h"
+#include "common/format-output.h"
 #include "cmds/commands.h"
+#include "cmds/subvolume.h"
 
 /*
  * Naming of options:
@@ -75,6 +77,8 @@ static const char * const cmd_subvolume_list_usage[] = {
 	OPTLINE("--sort=gen,ogen,rootid,path", "list the subvolume in order of gen, ogen, rootid or path "
 		"you also can add '+' or '-' in front of each items. "
 		"(+:ascending, -:descending, ascending default)"),
+	HELPINFO_INSERT_GLOBALS,
+	HELPINFO_INSERT_FORMAT,
 	NULL,
 };
 
@@ -84,7 +88,8 @@ static const char * const cmd_subvolume_list_usage[] = {
 enum btrfs_list_layout {
 	BTRFS_LIST_LAYOUT_DEFAULT = 0,
 	BTRFS_LIST_LAYOUT_TABLE,
-	BTRFS_LIST_LAYOUT_RAW
+	BTRFS_LIST_LAYOUT_RAW,
+	BTRFS_LIST_LAYOUT_JSON
 };
 
 /*
@@ -1269,14 +1274,83 @@ static void print_all_subvol_info_tab_head(void)
 	}
 }
 
+static void print_subvol_json_key(struct format_ctx *fctx,
+				  const struct root_info *subv,
+				  const enum btrfs_list_column_enum column)
+{
+	const char *column_name;
+
+	UASSERT(0 <= column && column < BTRFS_LIST_ALL);
+
+	column_name = btrfs_list_columns[column].name;
+	switch (column) {
+	case BTRFS_LIST_OBJECTID:
+		fmt_print(fctx, column_name, subv->root_id);
+		break;
+	case BTRFS_LIST_GENERATION:
+		fmt_print(fctx, column_name, subv->gen);
+		break;
+	case BTRFS_LIST_OGENERATION:
+		fmt_print(fctx, column_name, subv->ogen);
+		break;
+	case BTRFS_LIST_PARENT:
+		fmt_print(fctx, column_name, subv->ref_tree);
+		break;
+	case BTRFS_LIST_TOP_LEVEL:
+		fmt_print(fctx, column_name, subv->top_id);
+		break;
+	case BTRFS_LIST_OTIME:
+		fmt_print(fctx, column_name, subv->otime);
+		break;
+	case BTRFS_LIST_UUID:
+		fmt_print(fctx, column_name, subv->uuid);
+		break;
+	case BTRFS_LIST_PUUID:
+		fmt_print(fctx, column_name, subv->puuid);
+		break;
+	case BTRFS_LIST_RUUID:
+		fmt_print(fctx, column_name, subv->ruuid);
+		break;
+	case BTRFS_LIST_PATH:
+		BUG_ON(!subv->full_path);
+		fmt_print(fctx, column_name, subv->full_path);
+		break;
+	default:
+		break;
+	}
+}
+
+static void print_one_subvol_info_json(struct format_ctx *fctx,
+				struct root_info *subv)
+{
+	int i;
+
+	fmt_print_start_group(fctx, NULL, JSON_TYPE_MAP);
+
+	for (i = 0; i < BTRFS_LIST_ALL; i++) {
+		if (!btrfs_list_columns[i].need_print)
+			continue;
+
+		print_subvol_json_key(fctx, subv, i);
+	}
+
+	fmt_print_end_group(fctx, NULL);
+}
+
+
 static void print_all_subvol_info(struct rb_root *sorted_tree,
 		  enum btrfs_list_layout layout, const char *raw_prefix)
 {
 	struct rb_node *n;
 	struct root_info *entry;
+	struct format_ctx fctx;
 
-	if (layout == BTRFS_LIST_LAYOUT_TABLE)
+	if (layout == BTRFS_LIST_LAYOUT_TABLE) {
 		print_all_subvol_info_tab_head();
+	} else if (layout == BTRFS_LIST_LAYOUT_JSON) {
+		fmt_start(&fctx, btrfs_subvolume_rowspec, 1, 0);
+		fmt_print_start_group(&fctx, "subvolume-list", JSON_TYPE_ARRAY);
+	}
 
 	n = rb_first(sorted_tree);
 	while (n) {
@@ -1296,10 +1370,18 @@ static void print_all_subvol_info(struct rb_root *sorted_tree,
 		case BTRFS_LIST_LAYOUT_RAW:
 			print_one_subvol_info_raw(entry, raw_prefix);
 			break;
+		case BTRFS_LIST_LAYOUT_JSON:
+			print_one_subvol_info_json(&fctx, entry);
+			break;
 		}
 next:
 		n = rb_next(n);
 	}
+
+	if (layout == BTRFS_LIST_LAYOUT_JSON) {
+		fmt_print_end_group(&fctx, "subvolume-list");
+		fmt_end(&fctx);
+	}
 }
 
 static int btrfs_list_subvols(int fd, struct rb_root *root_lookup)
@@ -1631,6 +1713,9 @@ static int cmd_subvolume_list(const struct cmd_struct *cmd, int argc, char **arg
 	btrfs_list_setup_print_column(BTRFS_LIST_TOP_LEVEL);
 	btrfs_list_setup_print_column(BTRFS_LIST_PATH);
 
+	if (bconf.output_format == CMD_FORMAT_JSON)
+		layout = BTRFS_LIST_LAYOUT_JSON;
+
 	ret = btrfs_list_subvols_print(fd, filter_set, comparer_set,
 			layout, !is_list_all && !is_only_in_path, NULL);
 
@@ -1644,4 +1729,4 @@ out:
 		usage(cmd, 1);
 	return !!ret;
 }
-DEFINE_SIMPLE_COMMAND(subvolume_list, "list");
+DEFINE_COMMAND_WITH_FLAGS(subvolume_list, "list", CMD_FORMAT_JSON);
-- 
2.41.0

