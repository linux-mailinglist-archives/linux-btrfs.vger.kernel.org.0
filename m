Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28260115345
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2019 15:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfLFOhZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Dec 2019 09:37:25 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33842 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfLFOhY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Dec 2019 09:37:24 -0500
Received: by mail-qt1-f194.google.com with SMTP id 5so7362470qtz.1
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Dec 2019 06:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zDFN2zKwXeVtsdPwXg0XMsqbZs7OxQin/tviYZXQ9os=;
        b=ao6vMuKcj7d1ANlsQInpJ98BC2VO+JOmVW6Teb+lAXUp9s/8tmlg5i0D0EaLaXS/pG
         4Q9PqC4VCh//oEWznGfSOYiNdka7hryhwqOcwej7TjFfnkq8O1Xnj1RVOkVU2fmA3DmL
         n7zYyfG15gN+6frxABcJi1CjXvigOLYdoPmw47K3HvyygxZVvcxzgeTDAkiaj+w6Q0Mt
         3RcTe3f/KoHViGh97RYpVG5OJ+oNOtfjcQbv8OARqWv/4F2Dwk/yEeZz6/luzzm9Ya6V
         vLqPKe4WrwPgAv4n8JTcQG59Hs9YfwAm+5AlhByO0u5yJV0XaWftUsHryIBXgdCmJWJv
         TM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zDFN2zKwXeVtsdPwXg0XMsqbZs7OxQin/tviYZXQ9os=;
        b=eU0b1BB1026avBLjKVRWrJo+QrDRJIO9FkaZYH/+BomiFLUCTVr9KSItZV58jpsIgv
         3/Ewv+Wp6Suxom6I/xTgxRwn1ZWDJHM95wRqhkIPXxMHkw2+XIvkXKZa1Bi0z3B7jrY5
         qgdKk52EsIi9jgrt4JSVGA33u9/+MJnOFE/Jnw3o48AKoi5OtLSnum7BSuafEtkGn8lf
         C9jRRCPmgsEI0UsfrxjuW9wl4WNXhN35gZX8gcSKr/GBJr1chOTm1FB8xZk96DywaE0g
         ZxOKpz1pMXBwLdTkRZ4EuHmhUIKteBMdd/01xCL3doSiqyWyZyxGvJUPYmolVCWORRXz
         cQ/A==
X-Gm-Message-State: APjAAAWPLFDSWPpX8+EU8H3KvAZpwcBeKbqr7NNdM+/hHQJ5IE8A3XK+
        hIlP3+RkyKBldbyrl20xIqKqpeO7NGg9WQ==
X-Google-Smtp-Source: APXvYqzRNS3o+ou6bcQugLQJGAwHFT6lJuiTAbarRT0YKxmTq9VJb8tSU/dUqYcVeFkCBw42wJkJsA==
X-Received: by 2002:ac8:614a:: with SMTP id d10mr12761117qtm.373.1575643043438;
        Fri, 06 Dec 2019 06:37:23 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 50sm6391259qtv.88.2019.12.06.06.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 06:37:22 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 1/5] btrfs: drop log root for dropped roots
Date:   Fri,  6 Dec 2019 09:37:14 -0500
Message-Id: <20191206143718.167998-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206143718.167998-1-josef@toxicpanda.com>
References: <20191206143718.167998-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

If we fsync on a subvolume and create a log root for that volume, and
then later delete that subvolume we'll never clean up its log root.  Fix
this by making switch_commit_roots free the log for any dropped roots we
encounter.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
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
2.23.0

