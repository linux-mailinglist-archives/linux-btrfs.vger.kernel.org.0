Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 875E118A3A4
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Mar 2020 21:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgCRUSy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Mar 2020 16:18:54 -0400
Received: from gateway21.websitewelcome.com ([192.185.46.113]:44592 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726663AbgCRUSy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Mar 2020 16:18:54 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 820994011AE7D
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Mar 2020 15:18:52 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id Ef9QjFOXMAGTXEf9QjfWlj; Wed, 18 Mar 2020 15:18:52 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QmMwKn25xxXIipr6CHwpL0xXXilvyoO+iJoU/DLMhfg=; b=pXfBN3AspyF+c/dxmMCrViHqkC
        j2sXJ5qtvuew3daJ0nHlxJ++Guc8JDlWxlG33IHg+ioIeW3NtXsPfxitpDGByiLS/W+7wkP4VIpOr
        BEnOyJJZ/xerUNhBeqkAUeQwbMpYgHcq7j7q+8VegNN9+005QQDyCnBhSN5bJ7TQmIeupFzvI+nZy
        zz4h9yky/VnvPwINpx+HX6LCTv3uIPcMhHeuVrudYFQaXNdyb3+HL+JZQgp1tDcay5AvgbpLuYSon
        lEJFe6AvxDEsZnBdC2FRct+U87Y42P7NMXaeZvLB2YrQMygbgrZcIWBd5VLdHwdx1nFLr51l8OEtf
        ulSenoDQ==;
Received: from [191.249.66.103] (port=50308 helo=hephaestus.prv.suse.net)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jEf9P-000yAj-K2; Wed, 18 Mar 2020 17:18:52 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org
Cc:     Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v4 04/11] btrfs-progs: qgroup-verify: Move qgroup classification out of report_qgroups
Date:   Wed, 18 Mar 2020 17:21:41 -0300
Message-Id: <20200318202148.14828-5-marcos@mpdesouza.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200318202148.14828-1-marcos@mpdesouza.com>
References: <20200318202148.14828-1-marcos@mpdesouza.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br540.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mpdesouza.com
X-BWhitelist: no
X-Source-IP: 191.249.66.103
X-Source-L: No
X-Exim-ID: 1jEf9P-000yAj-K2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.prv.suse.net) [191.249.66.103]:50308
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 15
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

The original qgroup-verify integrates qgroup classification into
report_qgroups().
This behavior makes silent qgroup repair (or offline rescan) impossible.

To repair qgroup, we must call report_qgroups() to trigger bad qgroup
classification, which will output error message.

This patch moves bad qgroup classification from report_qgroups() to
qgroup_verify_all().
Now report_qgroups() is pretty lightweight, only doing basic qgroup
difference report thus change it type to void.

And since the functionality of qgroup_verify_all() changes, change
callers to handle the new return value correctly.

Signed-off-by: Qu Wenruo <wqu@suse.com>
[ removed some comments ]
Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 check/main.c          | 18 ++++++------
 check/qgroup-verify.c | 67 +++++++++++++++++++++++++++++++------------
 check/qgroup-verify.h |  2 +-
 3 files changed, 59 insertions(+), 28 deletions(-)

diff --git a/check/main.c b/check/main.c
index 49bdbfec..7632b60a 100644
--- a/check/main.c
+++ b/check/main.c
@@ -9941,7 +9941,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 	int clear_space_cache = 0;
 	int qgroup_report = 0;
 	int qgroups_repaired = 0;
-	int qgroup_report_ret;
+	int qgroup_verify_ret;
 	unsigned ctree_flags = OPEN_CTREE_EXCLUSIVE;
 	int force = 0;
 
@@ -10198,8 +10198,8 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 		       uuidbuf);
 		ret = qgroup_verify_all(info);
 		err |= !!ret;
-		if (ret == 0)
-			err |= !!report_qgroups(1);
+		if (ret >= 0)
+			report_qgroups(1);
 		goto close_out;
 	}
 	if (subvolid) {
@@ -10433,21 +10433,21 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 			ctx.tp = TASK_QGROUPS;
 			task_start(ctx.info, &ctx.start_time, &ctx.item_count);
 		}
-		ret = qgroup_verify_all(info);
+		qgroup_verify_ret = qgroup_verify_all(info);
 		task_stop(ctx.info);
-		err |= !!ret;
-		if (ret) {
+		if (qgroup_verify_ret < 0) {
 			error("failed to check quota groups");
+			err |= !!qgroup_verify_ret;
 			goto out;
 		}
-		qgroup_report_ret = report_qgroups(0);
+		report_qgroups(0);
 		ret = repair_qgroups(info, &qgroups_repaired);
 		if (ret) {
 			error("failed to repair quota groups");
 			goto out;
 		}
-		if (qgroup_report_ret && (!qgroups_repaired || ret))
-			err |= qgroup_report_ret;
+		if (qgroup_verify_ret && (!qgroups_repaired || ret))
+			err |= !!qgroup_verify_ret;
 		ret = 0;
 	} else {
 		fprintf(stderr,
diff --git a/check/qgroup-verify.c b/check/qgroup-verify.c
index b7b63095..b1e6b26c 100644
--- a/check/qgroup-verify.c
+++ b/check/qgroup-verify.c
@@ -1311,18 +1311,13 @@ static int report_qgroup_difference(struct qgroup_count *count, int verbose)
 
 /*
  * Report qgroups errors
- * Return 0 if nothing wrong.
- * Return <0 if any qgroup is inconsistent.
- *
  * @all:	if set, all qgroup will be checked and reported even already
  * 		inconsistent or under rescan.
  */
-int report_qgroups(int all)
+void report_qgroups(int all)
 {
 	struct rb_node *node;
 	struct qgroup_count *c;
-	bool found_err = false;
-	bool skip_err = false;
 
 	if (!repair && counts.rescan_running) {
 		if (all) {
@@ -1331,34 +1326,26 @@ int report_qgroups(int all)
 		} else {
 			printf(
 	"Qgroup rescan is running, qgroups will not be printed.\n");
-			return 0;
+			return;
 		}
 	}
 	/*
 	 * It's possible that rescan hasn't been initialized yet.
 	 */
 	if (counts.qgroup_inconsist && !counts.rescan_running &&
-	    counts.rescan_running == 0) {
+	    counts.rescan_running == 0)
 		printf(
-"Rescan hasn't been initialized, a difference in qgroup accounting is expected\n");
-		skip_err = true;
-	}
+"Rescan hasn't been initialzied, a difference in qgroup accounting is expected\n");
 	if (counts.qgroup_inconsist && !counts.rescan_running)
 		fprintf(stderr, "Qgroup are marked as inconsistent.\n");
 	node = rb_first(&counts.root);
 	while (node) {
 		c = rb_entry(node, struct qgroup_count, rb_node);
 
-		if (report_qgroup_difference(c, all)) {
-			list_add_tail(&c->bad_list, &bad_qgroups);
-			found_err = true;
-		}
+		report_qgroup_difference(c, all);
 
 		node = rb_next(node);
 	}
-	if (found_err && !skip_err)
-		return -EUCLEAN;
-	return 0;
 }
 
 void free_qgroup_counts(void)
@@ -1393,9 +1380,29 @@ void free_qgroup_counts(void)
 	}
 }
 
+static bool is_bad_qgroup(struct qgroup_count *count)
+{
+	struct qgroup_info *info = &count->info;
+	struct qgroup_info *disk = &count->diskinfo;
+	s64 excl_diff = info->exclusive - disk->exclusive;
+	s64 ref_diff = info->referenced - disk->referenced;
+
+	return (excl_diff || ref_diff);
+}
+
+/*
+ * Verify all qgroup numbers.
+ *
+ * Return <0 for fatal errors (e.g. ENOMEM or failed to read quota tree)
+ * Return 0 if all qgroup numbers are correct or no need to check (under rescan)
+ * Return >0 if qgroup numbers are inconsistent.
+ */
 int qgroup_verify_all(struct btrfs_fs_info *info)
 {
 	int ret;
+	bool found_err = false;
+	bool skip_err = false;
+	struct rb_node *node;
 
 	if (!info->quota_enabled)
 		return 0;
@@ -1413,6 +1420,12 @@ int qgroup_verify_all(struct btrfs_fs_info *info)
 		goto out;
 	}
 
+	if (counts.rescan_running)
+		skip_err = true;
+	if (counts.qgroup_inconsist && !counts.rescan_running &&
+	    counts.rescan_running == 0)
+		skip_err = true;
+
 	/*
 	 * Put all extent refs into our rbtree
 	 */
@@ -1430,6 +1443,22 @@ int qgroup_verify_all(struct btrfs_fs_info *info)
 
 	ret = account_all_refs(1, 0);
 
+	/*
+	 * Do the correctness check here, so for callers who don't want
+	 * verbose report can skip calling report_qgroups()
+	 */
+	node = rb_first(&counts.root);
+	while (node) {
+		struct qgroup_count *c;
+
+		c = rb_entry(node, struct qgroup_count, rb_node);
+		if (is_bad_qgroup(c)) {
+			list_add_tail(&c->bad_list, &bad_qgroups);
+			found_err = true;
+		}
+		node = rb_next(node);
+	}
+
 out:
 	/*
 	 * Don't free the qgroup count records as they will be walked
@@ -1437,6 +1466,8 @@ out:
 	 */
 	free_tree_blocks();
 	free_ref_tree(&by_bytenr);
+	if (!ret && !skip_err && found_err)
+		ret = 1;
 	return ret;
 }
 
diff --git a/check/qgroup-verify.h b/check/qgroup-verify.h
index 20e93708..6495dd18 100644
--- a/check/qgroup-verify.h
+++ b/check/qgroup-verify.h
@@ -23,7 +23,7 @@
 #include "ctree.h"
 
 int qgroup_verify_all(struct btrfs_fs_info *info);
-int report_qgroups(int all);
+void report_qgroups(int all);
 int repair_qgroups(struct btrfs_fs_info *info, int *repaired);
 
 int print_extent_state(struct btrfs_fs_info *info, u64 subvol);
-- 
2.25.0

