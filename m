Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105A63B3D0F
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Jun 2021 09:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhFYHPz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Jun 2021 03:15:55 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59686 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhFYHPv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Jun 2021 03:15:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6586F21BF2;
        Fri, 25 Jun 2021 07:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1624605210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tuYlHVlrPotgMT4HkGeWHW92FBitnN88AapArUrvbhc=;
        b=Ikzh9XkXasql9BdS3tq9H8ErUKDRjAEmqJs8rZAWK3A5ah//GSR0K8R7XDIpN/p+KMGuYz
        XHavlDoDSltdGNUNSWJSUuIIU3GH1vSGPJzmNdSvj1aSBQZeqFWA/AIjZudwSG32rLysY3
        x5fCC8nZfHngQXuFirRsbWkHvKMkUE8=
Received: from adam-pc.lan (unknown [10.163.16.38])
        by relay2.suse.de (Postfix) with ESMTP id DC182A3BB4;
        Fri, 25 Jun 2021 07:13:28 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Zhenyu Wu <wuzy001@gmail.com>
Subject: [PATCH 2/3] btrfs-progs: check/original: detect and repair orphan subvolume without orphan item
Date:   Fri, 25 Jun 2021 15:13:21 +0800
Message-Id: <20210625071322.221780-3-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210625071322.221780-1-wqu@suse.com>
References: <20210625071322.221780-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For the detection part, just change how we handle root_item::refs == 0
case, so that even we find a root_item whose refs == 0, we still set
root_rec::found_root_item, then existing code can handle it well.

For repair part, use the repair_root_orphan_item() function.

Also since we're here, use the common orphan item search function to
replace the original mode specific function.

Reported-by: Zhenyu Wu <wuzy001@gmail.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/check/main.c b/check/main.c
index ee6cf793251c..62bfc00ab12e 100644
--- a/check/main.c
+++ b/check/main.c
@@ -862,24 +862,6 @@ static void maybe_free_inode_rec(struct cache_tree *inode_cache,
 	}
 }
 
-static int check_orphan_item(struct btrfs_root *root, u64 ino)
-{
-	struct btrfs_path path;
-	struct btrfs_key key;
-	int ret;
-
-	key.objectid = BTRFS_ORPHAN_OBJECTID;
-	key.type = BTRFS_ORPHAN_ITEM_KEY;
-	key.offset = ino;
-
-	btrfs_init_path(&path);
-	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
-	btrfs_release_path(&path);
-	if (ret > 0)
-		ret = -ENOENT;
-	return ret;
-}
-
 static int process_inode_item(struct extent_buffer *eb,
 			      int slot, struct btrfs_key *key,
 			      struct shared_node *active_node)
@@ -3063,8 +3045,7 @@ static int check_inode_recs(struct btrfs_root *root,
 		}
 
 		if (rec->errors & I_ERR_NO_ORPHAN_ITEM) {
-			ret = check_orphan_item(root, rec->ino);
-			if (ret == 0)
+			if (btrfs_has_orphan_item(root, rec->ino))
 				rec->errors &= ~I_ERR_NO_ORPHAN_ITEM;
 			if (can_free_inode_rec(rec)) {
 				free_inode_rec(rec);
@@ -3339,8 +3320,8 @@ static int check_root_refs(struct btrfs_root *root,
 		if (rec->found_ref == 0 &&
 		    rec->objectid >= BTRFS_FIRST_FREE_OBJECTID &&
 		    rec->objectid <= BTRFS_LAST_FREE_OBJECTID) {
-			ret = check_orphan_item(gfs_info->tree_root, rec->objectid);
-			if (ret == 0)
+			if (btrfs_has_orphan_item(root->fs_info->tree_root,
+						  rec->objectid))
 				continue;
 
 			/*
@@ -3350,9 +3331,14 @@ static int check_root_refs(struct btrfs_root *root,
 			 */
 			if (!rec->found_root_item)
 				continue;
-			errors++;
 			fprintf(stderr, "fs tree %llu not referenced\n",
-				(unsigned long long)rec->objectid);
+				rec->objectid);
+
+			if (repair)
+				ret = repair_root_orphan_item(root->fs_info,
+							      rec->objectid);
+			if (!repair || ret)
+				errors++;
 		}
 
 		error = 0;
@@ -3579,8 +3565,7 @@ static int check_fs_root(struct btrfs_root *root,
 	if (root->root_key.objectid != BTRFS_TREE_RELOC_OBJECTID) {
 		rec = get_root_rec(root_cache, root->root_key.objectid);
 		BUG_ON(IS_ERR(rec));
-		if (btrfs_root_refs(root_item) > 0)
-			rec->found_root_item = 1;
+		rec->found_root_item = 1;
 	}
 
 	btrfs_init_path(&path);
-- 
2.32.0

