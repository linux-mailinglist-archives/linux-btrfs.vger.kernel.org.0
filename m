Return-Path: <linux-btrfs+bounces-6124-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8ACC923905
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 11:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544671F2302E
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 09:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E816514EC7F;
	Tue,  2 Jul 2024 09:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="Yfp71bv2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail.synology.com (mail.synology.com [211.23.38.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960B81A28B
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Jul 2024 09:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.23.38.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719910894; cv=none; b=akxCLMdTrrk9KaiiP2WDzzd5OetA4aBlCAxxG7hw6QUJ+9QWdv2vX5HuhC0+kh7NCygcgRW/jp5wo9O/VvY2C2TLd4LZtjMtqwTrr5gX/6I4safOCVj0WubD/KKBN38H38lxKb8ZnO5kOiCudA7cFhg77w0B0RtNmjxT1zQP+Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719910894; c=relaxed/simple;
	bh=SrRQlYbOTaBf3ZsRU0/DO8bcIACf1MejM6dCLEUOKRg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nc/cCh+02AD8jhmtrdWFzV/MO9BMaxE7PtI64Lpam8FHCFTLgmt3BLve6FyUzwdpCqaIVzQWBf5Ft8sy3WTyCMFFozK9fHLIcT+cyzUmCoeUzLY9fCIR1S2KXcvWJHwBMLlt/WDjZyMaOvjLL5Qg2P3eXbYglgca7YkNQkRjNvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com; spf=pass smtp.mailfrom=synology.com; dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b=Yfp71bv2; arc=none smtp.client-ip=211.23.38.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synology.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synology.com
From: Chung-Chiang Cheng <cccheng@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
	t=1719910504; bh=SrRQlYbOTaBf3ZsRU0/DO8bcIACf1MejM6dCLEUOKRg=;
	h=From:To:Cc:Subject:Date;
	b=Yfp71bv2gFjB/q82wzIVf2+9gpJmSe8di/l+Y968ZtceQAGKn1RfLSsdo+lKwojVQ
	 NmQ0jWWyAT9aNILDbzKGTgojQu+DPZ8vZmh1YHl/DUSIWksz2oVBbtEM14ua6vXZtJ
	 vxlxFZUE5Ao0GqBHKT7/lMQsNXO2WIqgd/t6WUD4=
To: linux-btrfs@vger.kernel.org
Cc: shepjeng@gmail.com,
	btrfs@cccheng.net,
	Chung-Chiang Cheng <cccheng@synology.com>
Subject: [PATCH] btrfs-progs: inspect tree-stats: support to show a specified tree
Date: Tue,  2 Jul 2024 16:55:02 +0800
Message-Id: <cccf210bb40ff2455b03c8e6f77a9bef62d80cb3.1719910442.git.cccheng@synology.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Synology-Virus-Status: no
X-Synology-MCP-Status: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Spam-Flag: no

tree-stats currently displays only some global trees and fs-tree 5. Add
support to show the stats of a specified tree.

Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
---
 cmds/inspect-tree-stats.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/cmds/inspect-tree-stats.c b/cmds/inspect-tree-stats.c
index 42dab804528a..82298cd04a28 100644
--- a/cmds/inspect-tree-stats.c
+++ b/cmds/inspect-tree-stats.c
@@ -35,6 +35,7 @@
 #include "common/help.h"
 #include "common/messages.h"
 #include "common/open-utils.h"
+#include "common/string-utils.h"
 #include "common/units.h"
 #include "cmds/commands.h"
 
@@ -441,6 +442,7 @@ static const char * const cmd_inspect_tree_stats_usage[] = {
 	"Print various stats for trees",
 	"",
 	OPTLINE("-b", "raw numbers in bytes"),
+	OPTLINE("-t <tree_id>", "print only tree with the given id"),
 	NULL
 };
 
@@ -451,9 +453,10 @@ static int cmd_inspect_tree_stats(const struct cmd_struct *cmd,
 	struct btrfs_root *root;
 	int opt;
 	int ret = 0;
+	u64 tree_id = 0;
 
 	optind = 0;
-	while ((opt = getopt(argc, argv, "vb")) != -1) {
+	while ((opt = getopt(argc, argv, "vbt:")) != -1) {
 		switch (opt) {
 		case 'v':
 			verbose++;
@@ -461,6 +464,13 @@ static int cmd_inspect_tree_stats(const struct cmd_struct *cmd,
 		case 'b':
 			no_pretty = true;
 			break;
+		case 't':
+			tree_id = arg_strtou64(optarg);
+			if (!tree_id) {
+				error("unrecognized tree id: %s", optarg);
+				exit(1);
+			}
+			break;
 		default:
 			usage_unknown_option(cmd, argv);
 		}
@@ -485,6 +495,14 @@ static int cmd_inspect_tree_stats(const struct cmd_struct *cmd,
 		exit(1);
 	}
 
+	if (tree_id) {
+		pr_verbose(LOG_DEFAULT, "Calculating size of tree (%llu)\n", tree_id);
+		key.objectid = tree_id;
+		key.offset = (u64)-1;
+		ret = calc_root_size(root, &key, 1);
+		goto out;
+	}
+
 	pr_verbose(LOG_DEFAULT, "Calculating size of root tree\n");
 	key.objectid = BTRFS_ROOT_TREE_OBJECTID;
 	ret = calc_root_size(root, &key, 0);
-- 
2.34.1


