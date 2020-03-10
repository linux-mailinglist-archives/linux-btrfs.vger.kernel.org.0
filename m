Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC9E417F730
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Mar 2020 13:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgCJMN5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Mar 2020 08:13:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbgCJMN5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Mar 2020 08:13:57 -0400
Received: from debian6.Home (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AE7B2467D
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Mar 2020 12:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583842437;
        bh=ohjr4TLd8o+LeSV8fsa8VNrNO/b6WVVs6oQib26tyxU=;
        h=From:To:Subject:Date:From;
        b=TqH98XFl5wBcoHEhJPVhD9jAW1ANdGB+60iDUt1SfE8Cwq7JW1+a7s+EG/x1QKYuD
         +ZfITPRgpzVXcrPa6Fx/uepeVyMSzWlFelJsv+WoKxZKQdYNby0nyLJbPU+64Ya8ye
         8hNMI1FGBOzQKk1oMXqd856nehgdWTvQ/DU7rV+k=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: fix log context list corruption after rename whiteout error
Date:   Tue, 10 Mar 2020 12:13:53 +0000
Message-Id: <20200310121353.11764-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During a rename whiteout, if btrfs_whiteout_for_rename() returns an error
we can end up returning from btrfs_rename() with the log context object
still in the root's log context list - this happens if 'sync_log' was
set to true before we called btrfs_whiteout_for_rename() and it is
dangerous because we end up with a corrupt linked list (root->log_ctxs)
as the log context object was allocated on the stack.

After btrfs_rename() returns, any task that is running btrfs_sync_log()
concurrently can end up crashing because that linked list is traversed by
btrfs_sync_log() (through btrfs_remove_all_log_ctxs()). That results in
the same issue that commit e6c617102c7e4 ("Btrfs: fix log context list
corruption after rename exchange operation") fixed.

Fixes: d4682ba03ef618 ("Btrfs: sync log after logging new name")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 3a636b405088..fd9091808ae5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9546,6 +9546,10 @@ static int btrfs_rename(struct inode *old_dir, struct dentry *old_dentry,
 		ret = btrfs_sync_log(trans, BTRFS_I(old_inode)->root, &ctx);
 		if (ret)
 			commit_transaction = true;
+	} else if (sync_log) {
+		mutex_lock(&root->log_mutex);
+		list_del(&ctx.list);
+		mutex_unlock(&root->log_mutex);
 	}
 	if (commit_transaction) {
 		ret = btrfs_commit_transaction(trans);
-- 
2.11.0

