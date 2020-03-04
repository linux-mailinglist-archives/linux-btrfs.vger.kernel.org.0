Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4F25178D81
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 10:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgCDJd5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 04:33:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:44100 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727734AbgCDJd5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 4 Mar 2020 04:33:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6BF60AE44;
        Wed,  4 Mar 2020 09:33:55 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Open code insert_extent_backref
Date:   Wed,  4 Mar 2020 11:33:53 +0200
Message-Id: <20200304093353.26248-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

No need to add a level of indirection for hiding a simple 'if'. Open
code insert_extent_backref in its sole caller. No functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent-tree.c | 29 +++++++++--------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 36374b86529c..a3778937d705 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -1189,24 +1189,6 @@ int insert_inline_extent_backref(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static int insert_extent_backref(struct btrfs_trans_handle *trans,
-				 struct btrfs_path *path,
-				 u64 bytenr, u64 parent, u64 root_objectid,
-				 u64 owner, u64 offset, int refs_to_add)
-{
-	int ret;
-	if (owner < BTRFS_FIRST_FREE_OBJECTID) {
-		BUG_ON(refs_to_add != 1);
-		ret = insert_tree_block_ref(trans, path, bytenr, parent,
-					    root_objectid);
-	} else {
-		ret = insert_extent_data_ref(trans, path, bytenr, parent,
-					     root_objectid, owner, offset,
-					     refs_to_add);
-	}
-	return ret;
-}
-
 static int remove_extent_backref(struct btrfs_trans_handle *trans,
 				 struct btrfs_path *path,
 				 struct btrfs_extent_inline_ref *iref,
@@ -1493,8 +1475,15 @@ static int __btrfs_inc_extent_ref(struct btrfs_trans_handle *trans,
 	path->reada = READA_FORWARD;
 	path->leave_spinning = 1;
 	/* now insert the actual backref */
-	ret = insert_extent_backref(trans, path, bytenr, parent, root_objectid,
-				    owner, offset, refs_to_add);
+	if (owner < BTRFS_FIRST_FREE_OBJECTID) {
+		BUG_ON(refs_to_add != 1);
+		ret = insert_tree_block_ref(trans, path, bytenr, parent,
+					    root_objectid);
+	} else {
+		ret = insert_extent_data_ref(trans, path, bytenr, parent,
+					     root_objectid, owner, offset,
+					     refs_to_add);
+	}
 	if (ret)
 		btrfs_abort_transaction(trans, ret);
 out:
-- 
2.17.1

