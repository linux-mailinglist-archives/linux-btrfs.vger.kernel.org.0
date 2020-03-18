Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4B3418A3E4
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Mar 2020 21:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgCRUnc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Mar 2020 16:43:32 -0400
Received: from gateway36.websitewelcome.com ([192.185.197.22]:40768 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726647AbgCRUnc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Mar 2020 16:43:32 -0400
X-Greylist: delayed 1481 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Mar 2020 16:43:32 EDT
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id CD8D04068FDBB
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Mar 2020 14:34:53 -0500 (CDT)
Received: from br540.hostgator.com.br ([108.179.252.180])
        by cmsmtp with SMTP
        id Ef9RjlNAQSl8qEf9RjKGW5; Wed, 18 Mar 2020 15:18:53 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mpdesouza.com; s=default; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9Q1GO3N7UMmC9HV+qkUFefBdvFCgEOXvkIfH4IiZllk=; b=Vd6ncQw09vM8SwJkBNpQodVXR9
        CwfqSldjPD/iJw17wUaaNUdYYXXptG3EfvNS51fDLd4JmwOtyDfqJd0xYfdmNVe6rRSX4J5bq1MPF
        fvAVa890k6EsOVDUOrxUDYMvxTc/NrSfYFPYU35galmUpvgTA6gRN5duQsmKOuUWccUAxZ1MWlff+
        o0Rrcdiv9OoM667QbcbiDjPwPDpDJ1KsOmhRJGOq35QufGpoa2uLqNhQ9VqSIj2bPMQPFVUaIZVEH
        dbShr6XZQcT5x91p4ie5B85ZlJDLTB++MJBgI73cj7Gc2wD4jcAua44EqqQ5Hv4FhYJDtoDqxcQzt
        anRVKbWA==;
Received: from [191.249.66.103] (port=50308 helo=hephaestus.prv.suse.net)
        by br540.hostgator.com.br with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <marcos@mpdesouza.com>)
        id 1jEf9Q-000yAj-Uc; Wed, 18 Mar 2020 17:18:53 -0300
From:   Marcos Paulo de Souza <marcos@mpdesouza.com>
To:     dsterba@suse.com, wqu@suse.com, linux-btrfs@vger.kernel.org
Subject: [PATCH v4 05/11] btrfs-progs: qgroup-verify: Allow repair_qgroups function to do silent repair
Date:   Wed, 18 Mar 2020 17:21:42 -0300
Message-Id: <20200318202148.14828-6-marcos@mpdesouza.com>
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
X-Exim-ID: 1jEf9Q-000yAj-Uc
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (hephaestus.prv.suse.net) [191.249.66.103]:50308
X-Source-Auth: marcos@mpdesouza.com
X-Email-Count: 18
X-Source-Cap: bXBkZXNvNTM7bXBkZXNvNTM7YnI1NDAuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

Allow repair_qgroups() to do silent repair, so it can acts as offline
qgroup rescan.

This provides the basis for later mkfs quota support.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c          |  2 +-
 check/qgroup-verify.c | 19 +++++++++++--------
 check/qgroup-verify.h |  2 +-
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/check/main.c b/check/main.c
index 7632b60a..375aef8f 100644
--- a/check/main.c
+++ b/check/main.c
@@ -10441,7 +10441,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 			goto out;
 		}
 		report_qgroups(0);
-		ret = repair_qgroups(info, &qgroups_repaired);
+		ret = repair_qgroups(info, &qgroups_repaired, false);
 		if (ret) {
 			error("failed to repair quota groups");
 			goto out;
diff --git a/check/qgroup-verify.c b/check/qgroup-verify.c
index b1e6b26c..b1736aab 100644
--- a/check/qgroup-verify.c
+++ b/check/qgroup-verify.c
@@ -1540,7 +1540,7 @@ out:
 }
 
 static int repair_qgroup_info(struct btrfs_fs_info *info,
-			      struct qgroup_count *count)
+			      struct qgroup_count *count, bool silent)
 {
 	int ret;
 	struct btrfs_root *root = info->quota_root;
@@ -1549,8 +1549,10 @@ static int repair_qgroup_info(struct btrfs_fs_info *info,
 	struct btrfs_qgroup_info_item *info_item;
 	struct btrfs_key key;
 
-	printf("Repair qgroup %llu/%llu\n", btrfs_qgroup_level(count->qgroupid),
-	       btrfs_qgroup_subvid(count->qgroupid));
+	if (!silent)
+		printf("Repair qgroup %llu/%llu\n",
+			btrfs_qgroup_level(count->qgroupid),
+			btrfs_qgroup_subvid(count->qgroupid));
 
 	trans = btrfs_start_transaction(root, 1);
 	if (IS_ERR(trans))
@@ -1595,7 +1597,7 @@ out:
 	return ret;
 }
 
-static int repair_qgroup_status(struct btrfs_fs_info *info)
+static int repair_qgroup_status(struct btrfs_fs_info *info, bool silent)
 {
 	int ret;
 	struct btrfs_root *root = info->quota_root;
@@ -1604,7 +1606,8 @@ static int repair_qgroup_status(struct btrfs_fs_info *info)
 	struct btrfs_key key;
 	struct btrfs_qgroup_status_item *status_item;
 
-	printf("Repair qgroup status item\n");
+	if (!silent)
+		printf("Repair qgroup status item\n");
 
 	trans = btrfs_start_transaction(root, 1);
 	if (IS_ERR(trans))
@@ -1641,7 +1644,7 @@ out:
 	return ret;
 }
 
-int repair_qgroups(struct btrfs_fs_info *info, int *repaired)
+int repair_qgroups(struct btrfs_fs_info *info, int *repaired, bool silent)
 {
 	int ret = 0;
 	struct qgroup_count *count, *tmpcount;
@@ -1652,7 +1655,7 @@ int repair_qgroups(struct btrfs_fs_info *info, int *repaired)
 		return 0;
 
 	list_for_each_entry_safe(count, tmpcount, &bad_qgroups, bad_list) {
-		ret = repair_qgroup_info(info, count);
+		ret = repair_qgroup_info(info, count, silent);
 		if (ret) {
 			goto out;
 		}
@@ -1668,7 +1671,7 @@ int repair_qgroups(struct btrfs_fs_info *info, int *repaired)
 	 * mount.
 	 */
 	if (*repaired || counts.qgroup_inconsist || counts.rescan_running) {
-		ret = repair_qgroup_status(info);
+		ret = repair_qgroup_status(info, silent);
 		if (ret)
 			goto out;
 
diff --git a/check/qgroup-verify.h b/check/qgroup-verify.h
index 6495dd18..8a8694b6 100644
--- a/check/qgroup-verify.h
+++ b/check/qgroup-verify.h
@@ -24,7 +24,7 @@
 
 int qgroup_verify_all(struct btrfs_fs_info *info);
 void report_qgroups(int all);
-int repair_qgroups(struct btrfs_fs_info *info, int *repaired);
+int repair_qgroups(struct btrfs_fs_info *info, int *repaired, bool silent);
 
 int print_extent_state(struct btrfs_fs_info *info, u64 subvol);
 
-- 
2.25.0

