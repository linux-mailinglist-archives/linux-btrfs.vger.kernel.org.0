Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B69715A250
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Feb 2020 08:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgBLHnm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 12 Feb 2020 02:43:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:39884 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbgBLHnm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 12 Feb 2020 02:43:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 29D1EAEF6
        for <linux-btrfs@vger.kernel.org>; Wed, 12 Feb 2020 07:43:41 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: relocation: Remove is_cowonly_root()
Date:   Wed, 12 Feb 2020 15:43:31 +0800
Message-Id: <20200212074331.32800-1-wqu@suse.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This function is only used in read_fs_root(), which is just a wrapper of
btrfs_get_fs_root().

For all the mentioned essential roots except log root tree,
btrfs_get_fs_root() has its own quick path to grab them from fs_info
directly, thus no need for key.offset modification.

For subvolume trees, btrfs_get_fs_root() with key.offset == -1 is
completely fine.

For log trees and log root tree, it's impossible to hit them, as for
relocation all backrefs are fetched from commit root, which never
records log tree blocks.

Log tree blocks either get freed in regular transaction commit, or
replayed at mount time. At runtime we should never hit an backref for
log tree in extent tree.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/relocation.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 9c68c0e42898..207442557ac4 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -505,21 +505,6 @@ static struct btrfs_root *find_reloc_root(struct reloc_control *rc,
 	return root;
 }
 
-static int is_cowonly_root(u64 root_objectid)
-{
-	if (root_objectid == BTRFS_ROOT_TREE_OBJECTID ||
-	    root_objectid == BTRFS_EXTENT_TREE_OBJECTID ||
-	    root_objectid == BTRFS_CHUNK_TREE_OBJECTID ||
-	    root_objectid == BTRFS_DEV_TREE_OBJECTID ||
-	    root_objectid == BTRFS_TREE_LOG_OBJECTID ||
-	    root_objectid == BTRFS_CSUM_TREE_OBJECTID ||
-	    root_objectid == BTRFS_UUID_TREE_OBJECTID ||
-	    root_objectid == BTRFS_QUOTA_TREE_OBJECTID ||
-	    root_objectid == BTRFS_FREE_SPACE_TREE_OBJECTID)
-		return 1;
-	return 0;
-}
-
 static struct btrfs_root *read_fs_root(struct btrfs_fs_info *fs_info,
 					u64 root_objectid)
 {
@@ -527,10 +512,7 @@ static struct btrfs_root *read_fs_root(struct btrfs_fs_info *fs_info,
 
 	key.objectid = root_objectid;
 	key.type = BTRFS_ROOT_ITEM_KEY;
-	if (is_cowonly_root(root_objectid))
-		key.offset = 0;
-	else
-		key.offset = (u64)-1;
+	key.offset = (u64)-1;
 
 	return btrfs_get_fs_root(fs_info, &key, false);
 }
-- 
2.25.0

