Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E706148756E
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jan 2022 11:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237317AbiAGKYf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jan 2022 05:24:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57830 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbiAGKYf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jan 2022 05:24:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2FF5B8255C
        for <linux-btrfs@vger.kernel.org>; Fri,  7 Jan 2022 10:24:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30E2C36AE0;
        Fri,  7 Jan 2022 10:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641551072;
        bh=bPyDCYW6Cf4thHmcJcy+YX+Hqyd9+LMOMVft3jW4qrQ=;
        h=From:To:Cc:Subject:Date:From;
        b=LK7OT4R+846cc3zE98kUA8CpWtmRbuCt0yhFJPQhAzJrHRfZW4Hci2KY/kCEz/D/n
         nwCZFnzKqXZE3xy8gBU/ePQ7xTlOFzYtxLK4lF35vFSO+wNn6RbgzfzBuJsHtTC9Nx
         PsxhKQsD/qF+475vpW/vyxaz85avUwVnedyB1Cnz0HmNm08w6u3SHYBxQvkC7jKeM3
         I/JjMrqY7raoN43nfXLO3hQLjqna9OzAK/wnKDSPftBcQGwPk+MTdmchD8BCDA6VD7
         8vcIXacZXsqjehchaG2jhBzRXnUIoP2a/n9E00EfQ3bVtkU6KdXi+Ay5XesczbO/qP
         n3g3U1cUVJpXw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Cc:     dan.carpenter@oracle.com, Filipe Manana <fdmanana@suse.com>
Subject: [PATCH] btrfs: send: fix double and unpaired semaphore unlocks on -ENOMEM
Date:   Fri,  7 Jan 2022 10:24:18 +0000
Message-Id: <a7b1b2094bb0697dda72bdd9bf1ed789cb0b9b08.1641550850.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When doing an incremental send, at btrfs_compare_trees(), if we fail to
allocate the paths or clone extent buffers due to -ENOMEM:

1) We can end unlocking the commit root semaphore without having it
   locked before, when we fail to allocate the paths, because we
   jump to the 'out' label that always unlocks the semaphore;

2) When we fail to clone the extent buffers of the root nodes, we
   end up doing a double unlock of the commit root semaphore, once
   before jumping to the 'out' label and then once again under that
   label.

So fix those two issues.

This happens only after my previous patch that has the subject:

   "btrfs: make send work with concurrent block group relocation"

And it's not yet in Linus' tree.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---

Note: as the patch that introduced the issue is not yet in Linus' tree,
this can probably still be squashed into the original patch.

 fs/btrfs/send.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 3fc144b8c0d8..d8ccb62aa7d2 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7152,9 +7152,8 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 	left_path->nodes[left_level] =
 			btrfs_clone_extent_buffer(left_root->commit_root);
 	if (!left_path->nodes[left_level]) {
-		up_read(&fs_info->commit_root_sem);
 		ret = -ENOMEM;
-		goto out;
+		goto out_unlock;
 	}
 
 	right_level = btrfs_header_level(right_root->commit_root);
@@ -7162,9 +7161,8 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 	right_path->nodes[right_level] =
 			btrfs_clone_extent_buffer(right_root->commit_root);
 	if (!right_path->nodes[right_level]) {
-		up_read(&fs_info->commit_root_sem);
 		ret = -ENOMEM;
-		goto out;
+		goto out_unlock;
 	}
 	/*
 	 * Our right root is the parent root, while the left root is the "send"
@@ -7204,7 +7202,7 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 						       left_level, right_level,
 						       sctx);
 			if (ret < 0)
-				goto out;
+				goto out_unlock;
 			sctx->last_reloc_trans = fs_info->last_reloc_trans;
 		}
 
@@ -7216,7 +7214,7 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 			if (ret == -1)
 				left_end_reached = ADVANCE;
 			else if (ret < 0)
-				goto out;
+				goto out_unlock;
 			advance_left = 0;
 		}
 		if (advance_right && !right_end_reached) {
@@ -7227,13 +7225,13 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 			if (ret == -1)
 				right_end_reached = ADVANCE;
 			else if (ret < 0)
-				goto out;
+				goto out_unlock;
 			advance_right = 0;
 		}
 
 		if (left_end_reached && right_end_reached) {
 			ret = 0;
-			goto out;
+			goto out_unlock;
 		} else if (left_end_reached) {
 			if (right_level == 0) {
 				up_read(&fs_info->commit_root_sem);
@@ -7241,9 +7239,9 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 						&right_key,
 						BTRFS_COMPARE_TREE_DELETED,
 						sctx);
-				down_read(&fs_info->commit_root_sem);
 				if (ret < 0)
 					goto out;
+				down_read(&fs_info->commit_root_sem);
 			}
 			advance_right = ADVANCE;
 			continue;
@@ -7254,9 +7252,9 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 						&left_key,
 						BTRFS_COMPARE_TREE_NEW,
 						sctx);
-				down_read(&fs_info->commit_root_sem);
 				if (ret < 0)
 					goto out;
+				down_read(&fs_info->commit_root_sem);
 			}
 			advance_left = ADVANCE;
 			continue;
@@ -7293,9 +7291,9 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 				advance_right = ADVANCE;
 			}
 
-			down_read(&fs_info->commit_root_sem);
 			if (ret < 0)
 				goto out;
+			down_read(&fs_info->commit_root_sem);
 		} else if (left_level == right_level) {
 			cmp = btrfs_comp_cpu_keys(&left_key, &right_key);
 			if (cmp < 0) {
@@ -7335,8 +7333,9 @@ static int btrfs_compare_trees(struct btrfs_root *left_root,
 		}
 	}
 
-out:
+out_unlock:
 	up_read(&fs_info->commit_root_sem);
+out:
 	btrfs_free_path(left_path);
 	btrfs_free_path(right_path);
 	kvfree(tmp_buf);
-- 
2.33.0

