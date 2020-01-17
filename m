Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F57F140C2A
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 15:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgAQOMt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 09:12:49 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44692 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbgAQOMt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 09:12:49 -0500
Received: by mail-qt1-f194.google.com with SMTP id w8so7430964qts.11
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 06:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FGTOWrHfi08mzT0zWN/d7Kf6UkRD+wGFiWu4nC7j/9o=;
        b=pfb6ce4oDyGS0vCG7afUKwb1HT8lE8MfdXNHeiFTbXjXh+QfGwV1/o4yEcDXB5wGaK
         6bGAzrzhYw2iVDQbb7yT+zzOTQurCZ++fqIddIeU2Fn+dudt/NMIATlPTES4kO9x7fNS
         Un5y+PCRubX8yQl//dtPZm0bHVDiTbKx1F+nh3j6Rnx3K/WEFHTgcUunYTZsiXk5Rb0A
         6A8QK9rFklChnzDh6rp2hUc7s+QhHn0+jC1NiExuhvErJt0p2Q5GfiRGRupl2vUXhaVZ
         uYFkkMFxJuRVMS6JJdJ9GBLK28IUwXkpX6gNBnL9CxhSsja7Z5LOWNs0CqBZHHRIzeT3
         xVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FGTOWrHfi08mzT0zWN/d7Kf6UkRD+wGFiWu4nC7j/9o=;
        b=gkJkO1TTcSfr+/Xc+UElQPnkOYff3d9ZP00KfMRnK9eOJFK62N6gnAeqmz1t885gyX
         ihryRByEnd0n2wju7WB+9sgl7KF1x+WSpuq0IyiDIspzyP2h9bUMv681jesIkTAhga/0
         SSSA3idDxX/70F8U5Izhhet2Oc3GosT+1dY7z3D1VyF6Lf7PH6+QmqJbcjp9WygZqp2g
         nsLUHQhH56Zg3mRuuDLeTnOhH7G57s2EWFyFUAcRzU0RIVCyyRMQ4w6I52EOrMGqVSqe
         LIegTggtLfO5lslq27Ay/yB4+XQzYFqvwiiNRnyGML8+1qaF5ZY7e/XBV6JLTThYchYH
         8Y7A==
X-Gm-Message-State: APjAAAWkFYhjPI/FV0y2SJ1YbUrToylaCGhu1dxSdURG+Pa/BiICGbdm
        e14dfeen3U37/uQI5l2WBDmUZ6l7U9c/iw==
X-Google-Smtp-Source: APXvYqypYEXoCzn2kwwJLmfMOoCuxnL7StvdqrY6wFtV78z8wNBnsgYp2OMzV438VaY2mKUrWIJjew==
X-Received: by 2002:aed:3b14:: with SMTP id p20mr7791463qte.176.1579270367699;
        Fri, 17 Jan 2020 06:12:47 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id u16sm11791582qku.19.2020.01.17.06.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 06:12:47 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH][v2] btrfs: drop log root for dropped roots
Date:   Fri, 17 Jan 2020 09:12:45 -0500
Message-Id: <20200117141245.42971-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we fsync on a subvolume and create a log root for that volume, and
then later delete that subvolume we'll never clean up its log root.  Fix
this by making switch_commit_roots free the log for any dropped roots we
encounter.  The extra churn is because we need a btrfs_trans_handle, not
the btrfs_transaction.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
v1->v2:
- Update commit message to indicate we need the trans_handle instead of the
  transaciton.

 fs/btrfs/transaction.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index cfc08ef9b876..55d8fd68775a 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -147,13 +147,14 @@ void btrfs_put_transaction(struct btrfs_transaction *transaction)
 	}
 }
 
-static noinline void switch_commit_roots(struct btrfs_transaction *trans)
+static noinline void switch_commit_roots(struct btrfs_trans_handle *trans)
 {
+	struct btrfs_transaction *cur_trans = trans->transaction;
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_root *root, *tmp;
 
 	down_write(&fs_info->commit_root_sem);
-	list_for_each_entry_safe(root, tmp, &trans->switch_commits,
+	list_for_each_entry_safe(root, tmp, &cur_trans->switch_commits,
 				 dirty_list) {
 		list_del_init(&root->dirty_list);
 		free_extent_buffer(root->commit_root);
@@ -165,16 +166,17 @@ static noinline void switch_commit_roots(struct btrfs_transaction *trans)
 	}
 
 	/* We can free old roots now. */
-	spin_lock(&trans->dropped_roots_lock);
-	while (!list_empty(&trans->dropped_roots)) {
-		root = list_first_entry(&trans->dropped_roots,
+	spin_lock(&cur_trans->dropped_roots_lock);
+	while (!list_empty(&cur_trans->dropped_roots)) {
+		root = list_first_entry(&cur_trans->dropped_roots,
 					struct btrfs_root, root_list);
 		list_del_init(&root->root_list);
-		spin_unlock(&trans->dropped_roots_lock);
+		spin_unlock(&cur_trans->dropped_roots_lock);
+		btrfs_free_log(trans, root);
 		btrfs_drop_and_free_fs_root(fs_info, root);
-		spin_lock(&trans->dropped_roots_lock);
+		spin_lock(&cur_trans->dropped_roots_lock);
 	}
-	spin_unlock(&trans->dropped_roots_lock);
+	spin_unlock(&cur_trans->dropped_roots_lock);
 	up_write(&fs_info->commit_root_sem);
 }
 
@@ -1421,7 +1423,7 @@ static int qgroup_account_snapshot(struct btrfs_trans_handle *trans,
 	ret = commit_cowonly_roots(trans);
 	if (ret)
 		goto out;
-	switch_commit_roots(trans->transaction);
+	switch_commit_roots(trans);
 	ret = btrfs_write_and_wait_transaction(trans);
 	if (ret)
 		btrfs_handle_fs_error(fs_info, ret,
@@ -2301,7 +2303,7 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 	list_add_tail(&fs_info->chunk_root->dirty_list,
 		      &cur_trans->switch_commits);
 
-	switch_commit_roots(cur_trans);
+	switch_commit_roots(trans);
 
 	ASSERT(list_empty(&cur_trans->dirty_bgs));
 	ASSERT(list_empty(&cur_trans->io_bgs));
-- 
2.24.1

