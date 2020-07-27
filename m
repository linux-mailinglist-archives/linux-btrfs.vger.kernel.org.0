Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E6F22FBCF
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jul 2020 00:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgG0WFH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Jul 2020 18:05:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:58120 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgG0WFG (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Jul 2020 18:05:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7C211AB7A;
        Mon, 27 Jul 2020 22:05:15 +0000 (UTC)
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 3/3] btrfs: add more information for balance
Date:   Mon, 27 Jul 2020 17:04:51 -0500
Message-Id: <20200727220451.30680-4-rgoldwyn@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727220451.30680-1-rgoldwyn@suse.de>
References: <20200727220451.30680-1-rgoldwyn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Include information about the state of the balance and expected,
considered and completed statistics.

Q: I am not sure of the cancelled state, and stopping seemed more
appropriate since it was a transient state to cancelling the operation.
Would you prefer to call it cancelled?

This information is not used by user space as of now. We could use it
for "btrfs balance status" or ignore this patch for inclusion at all.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/btrfs/sysfs.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 71950c121588..001a7ae375d0 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -808,6 +808,33 @@ static ssize_t btrfs_checksum_show(struct kobject *kobj,
 
 BTRFS_ATTR(, checksum, btrfs_checksum_show);
 
+static ssize_t btrfs_balance_show(struct btrfs_fs_info *fs_info, char *buf)
+{
+	ssize_t ret = 0;
+	struct btrfs_balance_control *bctl;
+
+	ret += scnprintf(buf, PAGE_SIZE, "balance\n");
+	spin_lock(&fs_info->balance_lock);
+	bctl = fs_info->balance_ctl;
+	if (!bctl) {
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
+				"State: stopping\n");
+		goto out;
+	}
+	if (test_bit(BTRFS_FS_BALANCE_RUNNING, &fs_info->flags))
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
+				"State: running\n");
+	else
+		ret += scnprintf(buf + ret, PAGE_SIZE - ret,
+				"State: paused\n");
+	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%llu %llu %llu\n",
+			bctl->stat.expected, bctl->stat.considered,
+			bctl->stat.completed);
+out:
+	spin_unlock(&fs_info->balance_lock);
+	return ret;
+}
+
 static ssize_t btrfs_exclusive_operation_show(struct kobject *kobj,
 		struct kobj_attribute *a, char *buf)
 {
@@ -816,7 +843,7 @@ static ssize_t btrfs_exclusive_operation_show(struct kobject *kobj,
 		case  BTRFS_EXCLOP_NONE:
 			return scnprintf(buf, PAGE_SIZE, "none\n");
 		case BTRFS_EXCLOP_BALANCE:
-			return scnprintf(buf, PAGE_SIZE, "balance\n");
+			return btrfs_balance_show(fs_info, buf);
 		case BTRFS_EXCLOP_DEV_ADD:
 			return scnprintf(buf, PAGE_SIZE, "device add\n");
 		case BTRFS_EXCLOP_DEV_REPLACE:
-- 
2.26.2

