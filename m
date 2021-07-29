Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351603DA664
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Jul 2021 16:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbhG2O3G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Jul 2021 10:29:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234361AbhG2O3G (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Jul 2021 10:29:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BCBD160F4B
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Jul 2021 14:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627568943;
        bh=11giaWyQOf5rjLEUlGWqJ1IT7bubsGdOkSq9netej7c=;
        h=From:To:Subject:Date:From;
        b=eqnSAvgNzdy4UPp4dHVhiFo/d77gIwa6GYQGwMNuTCGEFuGf+TeqDia7Y9hkN3Rfm
         bU/M3eTgpTBe11LzrNSvEg0gIJgr48EAdUwpqxt7MelAvLo+kzsUHgpeo9j1Y7TiBz
         JhljvfTnDFD8buORZbDMavTCcTkO/KzB0Tnwv1m1LlXXlvCANV5YQS/YtFYl6DxtXM
         7VVo70u/g6omMZZgDd6RTf0imwMohqGz7W7e/CjiLhJYXR7ZI9bYDGa0zbjpGX0gO7
         EeypwI1sgFc5vv2UYPrZQGXYRvFxKBszVvoySg0l1R3oyD2gNEsfqXC4LUeEAood1Z
         X9Wa4LgVokiaA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: remove no longer needed full sync flag check at inode_logged()
Date:   Thu, 29 Jul 2021 15:29:01 +0100
Message-Id: <be665ad9dd952a442dbb8448539c87d2593e081a.1627568480.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

Now that we are checking if the inode's logged_trans is 0 to detect the
possibility of the inode having been evicted and reloaded, the test for
the full sync flag (BTRFS_INODE_NEEDS_FULL_SYNC) is no longer needed at
tree-log.c:inode_logged(). Its purpose was to detect the possibility
of a previous eviction as well, since when an inode is loaded the full
sync flag is always set on it (and only cleared after the inode is
logged).

So just remove the check and update the comment. The check for the inode's
logged_trans being 0 was added recently by the patch with the subject
"btrfs: eliminate some false positives when checking if inode was logged".

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 4de3f78c579b..d2039743ecf2 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3435,16 +3435,14 @@ static bool inode_logged(struct btrfs_trans_handle *trans,
 	/*
 	 * The inode's logged_trans is always 0 when we load it (because it is
 	 * not persisted in the inode item or elsewhere). So if it is 0, the
-	 * inode was last modified in the current transaction and has the
-	 * full_sync flag set, then the inode may have been logged before in
-	 * the current transaction, then evicted and loaded again in the current
-	 * transaction - or may have never been logged in the current transaction,
-	 * but since we can not be sure, we have to assume it was, otherwise our
-	 * callers can leave an inconsistent log.
+	 * inode was last modified in the current transaction then the inode may
+	 * have been logged before in the current transaction, then evicted and
+	 * loaded again in the current transaction - or may have never been logged
+	 * in the current transaction, but since we can not be sure, we have to
+	 * assume it was, otherwise our callers can leave an inconsistent log.
 	 */
 	if (inode->logged_trans == 0 &&
 	    inode->last_trans == trans->transid &&
-	    test_bit(BTRFS_INODE_NEEDS_FULL_SYNC, &inode->runtime_flags) &&
 	    !test_bit(BTRFS_FS_LOG_RECOVERING, &trans->fs_info->flags))
 		return true;
 
-- 
2.28.0

