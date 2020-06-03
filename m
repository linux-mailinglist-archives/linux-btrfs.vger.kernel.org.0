Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28DF21EC92F
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jun 2020 07:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgFCF4o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Jun 2020 01:56:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:42464 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbgFCFzz (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 3 Jun 2020 01:55:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AAB9AB003;
        Wed,  3 Jun 2020 05:55:56 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 09/46] btrfs: Make qgroup_free_reserved_data take btrfs_inode
Date:   Wed,  3 Jun 2020 08:55:09 +0300
Message-Id: <20200603055546.3889-10-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200603055546.3889-1-nborisov@suse.com>
References: <20200603055546.3889-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

It  only uses btrfs_inode so can just as easily take it as an argument.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/qgroup.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 5bd4089ad0e1..dcde4f9cba6c 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3448,10 +3448,10 @@ int btrfs_qgroup_reserve_data(struct inode *inode,
 }

 /* Free ranges specified by @reserved, normally in error path */
-static int qgroup_free_reserved_data(struct inode *inode,
+static int qgroup_free_reserved_data(struct btrfs_inode *inode,
 			struct extent_changeset *reserved, u64 start, u64 len)
 {
-	struct btrfs_root *root = BTRFS_I(inode)->root;
+	struct btrfs_root *root = inode->root;
 	struct ulist_node *unode;
 	struct ulist_iterator uiter;
 	struct extent_changeset changeset;
@@ -3487,8 +3487,8 @@ static int qgroup_free_reserved_data(struct inode *inode,
 		 * EXTENT_QGROUP_RESERVED, we won't double free.
 		 * So not need to rush.
 		 */
-		ret = clear_record_extent_bits(&BTRFS_I(inode)->io_tree,
-				free_start, free_start + free_len - 1,
+		ret = clear_record_extent_bits(&inode->io_tree, free_start,
+				free_start + free_len - 1,
 				EXTENT_QGROUP_RESERVED, &changeset);
 		if (ret < 0)
 			goto out;
@@ -3517,9 +3517,10 @@ static int __btrfs_qgroup_release_data(struct inode *inode,
 	/* In release case, we shouldn't have @reserved */
 	WARN_ON(!free && reserved);
 	if (free && reserved)
-		return qgroup_free_reserved_data(inode, reserved, start, len);
+		return qgroup_free_reserved_data(BTRFS_I(inode), reserved,
+						 start, len);
 	extent_changeset_init(&changeset);
-	ret = clear_record_extent_bits(&BTRFS_I(inode)->io_tree, start,
+	ret = clear_record_extent_bits(&BTRFS_I(inode)->io_tree, start,
 			start + len -1, EXTENT_QGROUP_RESERVED, &changeset);
 	if (ret < 0)
 		goto out;
--
2.17.1

