Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C88133D9DD
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Mar 2021 17:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbhCPQyB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Mar 2021 12:54:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234521AbhCPQxt (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Mar 2021 12:53:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3AF346510D
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Mar 2021 16:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615913629;
        bh=20V9sXdtWvFIRGVNJ4jIMvwmvg+wuJ8XYpwkDwp6mHE=;
        h=From:To:Subject:Date:From;
        b=XUNhI2nMmiSsEzgZ4ujHGba1n/S4mtlSyrbBZN6PjqAXN73QjIWJ7nTDUnOVIKlSL
         FCGWdvAprSikuc4f+TpV8YmabaNboAcKmm1psHyPKc4OgiiEFnOCvox5IZQiPB08CF
         dmNjBhODccvVZt05A9eOcKVFrSXq4W8M3xWdWTkkmB2pdoorXdIW07AGZB8c0UxU/z
         vTFHHclC8Talw6wIMhdbDRn/UINrL1aDAdKKOBp0DdvsrL+KtJANkTzcgrxlLsDuAa
         wjw0W7Ml8KczL+zqMWbXcvq3TxXTy8R3d+f7ve+Xt8H6OKWJxyjkzUsAl7zX6uoQkr
         SC+TR7pAIMxrg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix subvolume/snapshot deletion not triggered on mount
Date:   Tue, 16 Mar 2021 16:53:46 +0000
Message-Id: <5975ac44ce65830fd685896ed66b09eb16c4c4d8.1615912470.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During the mount procedure we are calling btrfs_orphan_cleanup() against
the root tree, which will find all orphans items in this tree. When an
orphan item corresponds to a deleted subvolume/snapshot (instead of an
inode space cache), it must not delete the orphan item, because that will
cause btrfs_find_orphan_roots() to not find the orphan item and therefore
not add the corresponding subvolume root to the list of dead roots, which
results in the subvolume's tree never being deleted by the cleanup thread.

The same applies to the remount from RO to RW path.

Fix this by making btrfs_find_orphan_roots() run before calling
btrfs_orphan_cleanup() against the root tree.

A test case for fstests will follow soon.

Reported-by: Robbie Ko <robbieko@synology.com>
Link: https://lore.kernel.org/linux-btrfs/b19f4310-35e0-606e-1eea-2dd84d28c5da@synology.com/
Fixes: 638331fa56caea ("btrfs: fix transaction leak and crash after cleaning up orphans on RO mount")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 41b718cfea40..7f50b3f65f3a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3009,6 +3009,21 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
 		}
 	}
 
+	/*
+	 * btrfs_find_orphan_roots() is responsible for finding all the dead
+	 * roots (with 0 refs), flag them with BTRFS_ROOT_DEAD_TREE and load
+	 * them into the fs_info->fs_roots_radix tree. This must be done before
+	 * calling btrfs_orphan_cleanup() on the tree root. If we don't do it
+	 * first, then btrfs_orphan_cleanup() will delete a dead root's orphan
+	 * item before the root's tree is deleted - this means that if we unmount
+	 * or crash before the deletion completes, on the next mount we will not
+	 * delete what remains of the tree because the orphan item does not
+	 * exists anymore, which is what tells us we have a pending deletion.
+	 */
+	ret = btrfs_find_orphan_roots(fs_info);
+	if (ret)
+		goto out;
+
 	ret = btrfs_cleanup_fs_roots(fs_info);
 	if (ret)
 		goto out;
@@ -3068,7 +3083,6 @@ int btrfs_start_pre_rw_mount(struct btrfs_fs_info *fs_info)
 		}
 	}
 
-	ret = btrfs_find_orphan_roots(fs_info);
 out:
 	return ret;
 }
-- 
2.28.0

