Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B825403C7E
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Sep 2021 17:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352036AbhIHPah (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Sep 2021 11:30:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234070AbhIHPah (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 8 Sep 2021 11:30:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAE156113C
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Sep 2021 15:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631114969;
        bh=3/A6lwJWsHt+LeLEI2YFWUOXh9xmG50SWQpkzMBMTeg=;
        h=From:To:Subject:Date:From;
        b=SpjcKGFjsY6tEauQaZ5Bgww2cLDyyOqzO9DOJcyVCX0ufl3qjYwjn5AUk4MeT9fZ/
         TxLXZGO1Ikfl9WWsd/GzJEzweKwtqd8JuZezL4IIRa6kw111AqKvPnGuo3hHnP3MQB
         Q+jozlwNovV1jeOz8GKTGcEovdQpUPYpCS0nU8CV6xBuUZSx4wun7TfQihzWFD3LQn
         531OA6OTZtpM3mqcGkds6rDjN7XqcLfHM8268cVZAA6Z6iC2gu4ysQL7KR37O2j9wW
         SMS7lhfi+5hoD/XX/ulgAgcrSCgNVGtSRPVvYB9N09e+IIQ68Mw7tDhB2Gh54rwpau
         CWkE9J+G/WA2w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix transaction handle leak after verity rollback failure
Date:   Wed,  8 Sep 2021 16:29:26 +0100
Message-Id: <b390e518f2091df52fd314806cce52fd00a19a00.1631114872.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During a verity rollback, if we fail to update the inode or delete the
orphan, we abort the transaction and return without releasing our
transaction handle. Fix that by releasing the handle.

Fixes: 146054090b0859 ("btrfs: initial fsverity support")
Fixes: 705242538ff348 ("btrfs: verity metadata orphan items")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/verity.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 28d443d3ef93..4968535dfff0 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -451,7 +451,7 @@ static int del_orphan(struct btrfs_trans_handle *trans, struct btrfs_inode *inod
  */
 static int rollback_verity(struct btrfs_inode *inode)
 {
-	struct btrfs_trans_handle *trans;
+	struct btrfs_trans_handle *trans = NULL;
 	struct btrfs_root *root = inode->root;
 	int ret;
 
@@ -473,6 +473,7 @@ static int rollback_verity(struct btrfs_inode *inode)
 	trans = btrfs_start_transaction(root, 2);
 	if (IS_ERR(trans)) {
 		ret = PTR_ERR(trans);
+		trans = NULL;
 		btrfs_handle_fs_error(root->fs_info, ret,
 			"failed to start transaction in verity rollback %llu",
 			(u64)inode->vfs_inode.i_ino);
@@ -490,8 +491,9 @@ static int rollback_verity(struct btrfs_inode *inode)
 		btrfs_abort_transaction(trans, ret);
 		goto out;
 	}
-	btrfs_end_transaction(trans);
 out:
+	if (trans)
+		btrfs_end_transaction(trans);
 	return ret;
 }
 
-- 
2.33.0

