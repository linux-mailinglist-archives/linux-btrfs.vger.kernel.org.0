Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 834FB140B4A
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jan 2020 14:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgAQNoE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jan 2020 08:44:04 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:40388 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgAQNoE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jan 2020 08:44:04 -0500
Received: by mail-qv1-f65.google.com with SMTP id dp13so10695044qvb.7
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Jan 2020 05:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WjYrOXWeuWMAJggjg/wyW53ZlvmOlMQMVRZVoUpmcho=;
        b=mPilTJWoxUi61GDU/RsI0V9cfFNbPiOcv+OCXRowzVhk/wJokb5qLoPshkpimgDQei
         fzEwKDou150l/yOxWZfZVb+8Nb/Qz7wiXGMusllRfguhN+z0VJ9iJgOUEprjUy4muBTG
         fm4KP5G+lA4MFOWBTzI1uHHOIhq8TOFQA+gZL90csc0dRfbrpnt8p6O3vsFfEJihvmoN
         /a0AMvSy3f75h7b4AziKI70dkb02YvL9UDkPCsoI2JvR1fQmlvlHDXeSDTcBiNXW+Kgf
         sWcWJJ9TXZaxFBsAStabJp1GrzBn5IK7B92rReXrV8ztQUVpR5/LISShf0KOiwZywIeC
         6CGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WjYrOXWeuWMAJggjg/wyW53ZlvmOlMQMVRZVoUpmcho=;
        b=HbpSL0OswMv8LCfzLVjkHxOOKtjDIN1Bcq8ZSnLLlg2deZst7zghz3HkW2sfpvNrl+
         TE71p83I1F8prbZQTsHhP2FIyloVciq1/IylU73R0h+Ok1p9KD4qmxWp3TMfsXkH3wKc
         eR1NCYAWV2TY++0nb+QViIiNJs1eloB5ovyH0D6BrQhwcr8/+PL06b8ghoiduEISgGP4
         g74iaH0dq7uKJr2LMdyz2rek78SfjlOdLcAzI4/Y8jpl3ZUKCSB8XYgeiVKs9TT1lccF
         9mhqJNzS8sdgvxV5nuYJ4Yek48yydo1r2KdgjZ39PSRPte4yUtanhWHSh6VdvUCLoFpH
         1dew==
X-Gm-Message-State: APjAAAUpLI9jnoaeIK1nlDFsNaFvLytfrwi+kOEgoWb8LTx8V3CC5wrQ
        aYhyQZSZ7+aCbNlCZ2e+58JFpE7i08OPzg==
X-Google-Smtp-Source: APXvYqyu4ZuGSi31FDIWEelP05WxBw1b4nKS+MLtkbzk+csKGMj8SFuI4ZvccpZWgAwj73PW3CTsnA==
X-Received: by 2002:a05:6214:707:: with SMTP id b7mr7532669qvz.97.1579268643229;
        Fri, 17 Jan 2020 05:44:03 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r37sm12955430qtj.44.2020.01.17.05.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:44:02 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH][RESEND] btrfs: drop log root for dropped roots
Date:   Fri, 17 Jan 2020 08:44:01 -0500
Message-Id: <20200117134401.41440-1-josef@toxicpanda.com>
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
encounter.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
- Nothing has changed for this one, it's just been rebased.

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

