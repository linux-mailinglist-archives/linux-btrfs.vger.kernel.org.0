Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19191EA729
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jun 2020 17:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgFAPi3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 11:38:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:34070 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbgFAPhv (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 1 Jun 2020 11:37:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B0FBCB216;
        Mon,  1 Jun 2020 15:37:50 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 10/46] btrfs: Make __btrfs_qgroup_release_data take btrfs_inode
Date:   Mon,  1 Jun 2020 18:37:08 +0300
Message-Id: <20200601153744.31891-11-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200601153744.31891-1-nborisov@suse.com>
References: <20200601153744.31891-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It uses vfs_inode only for a tracepoint so convert its interface to take
btrfs_inode directly.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/qgroup.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index dcde4f9cba6c..008e44446bd6 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3502,7 +3502,7 @@ static int qgroup_free_reserved_data(struct btrfs_inode *inode,
 	return ret;
 }

-static int __btrfs_qgroup_release_data(struct inode *inode,
+static int __btrfs_qgroup_release_data(struct btrfs_inode *inode,
 			struct extent_changeset *reserved, u64 start, u64 len,
 			int free)
 {
@@ -3510,28 +3510,26 @@ static int __btrfs_qgroup_release_data(struct inode *inode,
 	int trace_op = QGROUP_RELEASE;
 	int ret;

-	if (!test_bit(BTRFS_FS_QUOTA_ENABLED,
-		      &BTRFS_I(inode)->root->fs_info->flags))
+	if (!test_bit(BTRFS_FS_QUOTA_ENABLED, &inode->root->fs_info->flags))
 		return 0;

 	/* In release case, we shouldn't have @reserved */
 	WARN_ON(!free && reserved);
 	if (free && reserved)
-		return qgroup_free_reserved_data(BTRFS_I(inode), reserved,
-						 start, len);
+		return qgroup_free_reserved_data(inode, reserved, start, len);
 	extent_changeset_init(&changeset);
-	ret = clear_record_extent_bits(&BTRFS_I(inode)->io_tree, start,
-			start + len -1, EXTENT_QGROUP_RESERVED, &changeset);
+	ret = clear_record_extent_bits(&inode->io_tree, start, start + len -1,
+				       EXTENT_QGROUP_RESERVED, &changeset);
 	if (ret < 0)
 		goto out;

 	if (free)
 		trace_op = QGROUP_FREE;
-	trace_btrfs_qgroup_release_data(inode, start, len,
+	trace_btrfs_qgroup_release_data(&inode->vfs_inode, start, len,
 					changeset.bytes_changed, trace_op);
 	if (free)
-		btrfs_qgroup_free_refroot(BTRFS_I(inode)->root->fs_info,
-				BTRFS_I(inode)->root->root_key.objectid,
+		btrfs_qgroup_free_refroot(inode->root->fs_info,
+				inode->root->root_key.objectid,
 				changeset.bytes_changed, BTRFS_QGROUP_RSV_DATA);
 	ret = changeset.bytes_changed;
 out:
@@ -3554,7 +3552,7 @@ static int __btrfs_qgroup_release_data(struct inode *inode,
 int btrfs_qgroup_free_data(struct inode *inode,
 			struct extent_changeset *reserved, u64 start, u64 len)
 {
-	return __btrfs_qgroup_release_data(inode, reserved, start, len, 1);
+	return __btrfs_qgroup_release_data(BTRFS_I(inode), reserved, start, len, 1);
 }

 /*
@@ -3574,7 +3572,7 @@ int btrfs_qgroup_free_data(struct inode *inode,
  */
 int btrfs_qgroup_release_data(struct inode *inode, u64 start, u64 len)
 {
-	return __btrfs_qgroup_release_data(inode, NULL, start, len, 0);
+	return __btrfs_qgroup_release_data(BTRFS_I(inode), NULL, start, len, 0);
 }

 static void add_root_meta_rsv(struct btrfs_root *root, int num_bytes,
--
2.17.1

