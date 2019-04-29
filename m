Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A97CBE1F7
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2019 14:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfD2MIT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Apr 2019 08:08:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727927AbfD2MIT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Apr 2019 08:08:19 -0400
Received: from localhost.localdomain (bl8-197-74.dsl.telepac.pt [85.241.197.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F28F02075E
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2019 12:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556539698;
        bh=bl+zW6lHWK3VfY18Ld40uvL2O1qL/SovhfMMCBUrytE=;
        h=From:To:Subject:Date:From;
        b=p1GCJ+UiR0w65ks9Y+jh/eNLLUCurxdM0xYlHuAaRO9Ju2IyhzAr15w61zhmlIUol
         f5HpmGkK7Ui1/I7FnsGBCNeEk4zF0uKiRz02z5vF7vd7X2sBsf5OF0yQc6J2ZwjiIL
         vDyCfwSnsfUblLQVLVw9+XgWx70dj/MZ1rttU6BI=
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] Btrfs: do not abort transaction at btrfs_update_root() after failure to COW path
Date:   Mon, 29 Apr 2019 13:08:14 +0100
Message-Id: <20190429120814.8638-1-fdmanana@kernel.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Currently when we fail to COW a path at btrfs_update_root() we end up
always aborting the transaction. However all the current callers of
btrfs_update_root() are able to deal with errors returned from it, many do
end up aborting the transaction themselves (directly or not, such as the
transaction commit path), other BUG_ON() or just gracefully cancel whatever
they were doing.

When syncing the fsync log, we call btrfs_update_root() through
tree-log.c:update_log_root(), and if it returns an -ENOSPC error, the log
sync code does not abort the transaction, instead it gracefully handles
the error and returns -EAGAIN to the fsync handler, so that it falls back
to a transaction commit. Any other error different from -ENOSPC, makes the
log sync code abort the transaction.

So remove the transaction abort from btrfs_update_log() when we fail to
COW a path to update the root item, so that if an -ENOSPC failure happens
we avoid aborting the current transaction and have a chance of the fsync
succeeding after falling back to a transaction commit.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=203413
Fixes: 79787eaab46121 ("btrfs: replace many BUG_ONs with proper error handling")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/root-tree.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
index 893d12fbfda0..1a92ad546f91 100644
--- a/fs/btrfs/root-tree.c
+++ b/fs/btrfs/root-tree.c
@@ -132,10 +132,8 @@ int btrfs_update_root(struct btrfs_trans_handle *trans, struct btrfs_root
 		return -ENOMEM;
 
 	ret = btrfs_search_slot(trans, root, key, path, 0, 1);
-	if (ret < 0) {
-		btrfs_abort_transaction(trans, ret);
+	if (ret < 0)
 		goto out;
-	}
 
 	if (ret != 0) {
 		btrfs_print_leaf(path->nodes[0]);
-- 
2.11.0

