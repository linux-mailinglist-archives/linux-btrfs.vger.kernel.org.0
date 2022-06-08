Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC798543EB9
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 23:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236302AbiFHVkc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 17:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236235AbiFHVkb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 17:40:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A692B5B9A
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 14:40:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E1F8621CAC;
        Wed,  8 Jun 2022 21:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654724428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D2uurDuhJXjwizJ30XAuMW4Vm6ke2eE2xO/lKPYAqII=;
        b=HqUpPOOV3stDNubrdw9hMibel8+Oz2d/3UBI9IWFFPtS0U/eXKxlifkIU6YRJxjM2MTBqW
        m1c1+rlp/5kfWFP5l+h44s8hOTGbw1sE2yMEWXs2HrN/T1v6MQAVZFc4/JRfdynyjlJ/rW
        d3jJ6gv9YnyimjljAYdp0aSeBV2dLOQ=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D6F2D2C141;
        Wed,  8 Jun 2022 21:40:28 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3559FDA883; Wed,  8 Jun 2022 23:36:00 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/4] btrfs: call inode_to_path directly and drop indirection
Date:   Wed,  8 Jun 2022 23:36:00 +0200
Message-Id: <969e00a8830a78d62d89a03dfbad24fbf713b476.1654723641.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1654723641.git.dsterba@suse.com>
References: <cover.1654723641.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The functions for iterating inode reference take a function parameter
but there's only one value, inode_to_path(). Remove the indirection and
call the function. As paths_from_inode would become just an alias for
iterate_irefs(), merge the two into one function.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/backref.c | 50 +++++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index ebc392ea1d74..df3352f8be24 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2054,12 +2054,11 @@ int iterate_inodes_from_logical(u64 logical, struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
-typedef int (iterate_irefs_t)(u64 parent, u32 name_len, unsigned long name_off,
-			      struct extent_buffer *eb, void *ctx);
+static int inode_to_path(u64 inum, u32 name_len, unsigned long name_off,
+			 struct extent_buffer *eb, void *ctx);
 
 static int iterate_inode_refs(u64 inum, struct btrfs_root *fs_root,
-			      struct btrfs_path *path,
-			      iterate_irefs_t *iterate, void *ctx)
+			      struct btrfs_path *path, void *ctx)
 {
 	int ret = 0;
 	int slot;
@@ -2103,7 +2102,7 @@ static int iterate_inode_refs(u64 inum, struct btrfs_root *fs_root,
 				"following ref at offset %u for inode %llu in tree %llu",
 				cur, found_key.objectid,
 				fs_root->root_key.objectid);
-			ret = iterate(parent, name_len,
+			ret = inode_to_path(parent, name_len,
 				      (unsigned long)(iref + 1), eb, ctx);
 			if (ret)
 				break;
@@ -2119,8 +2118,7 @@ static int iterate_inode_refs(u64 inum, struct btrfs_root *fs_root,
 }
 
 static int iterate_inode_extrefs(u64 inum, struct btrfs_root *fs_root,
-				 struct btrfs_path *path,
-				 iterate_irefs_t *iterate, void *ctx)
+				 struct btrfs_path *path, void *ctx)
 {
 	int ret;
 	int slot;
@@ -2162,7 +2160,7 @@ static int iterate_inode_extrefs(u64 inum, struct btrfs_root *fs_root,
 			extref = (struct btrfs_inode_extref *)(ptr + cur_offset);
 			parent = btrfs_inode_extref_parent(eb, extref);
 			name_len = btrfs_inode_extref_name_len(eb, extref);
-			ret = iterate(parent, name_len,
+			ret = inode_to_path(parent, name_len,
 				      (unsigned long)&extref->name, eb, ctx);
 			if (ret)
 				break;
@@ -2180,26 +2178,6 @@ static int iterate_inode_extrefs(u64 inum, struct btrfs_root *fs_root,
 	return ret;
 }
 
-static int iterate_irefs(u64 inum, struct btrfs_root *fs_root,
-			 struct btrfs_path *path, iterate_irefs_t *iterate,
-			 void *ctx)
-{
-	int ret;
-	int found_refs = 0;
-
-	ret = iterate_inode_refs(inum, fs_root, path, iterate, ctx);
-	if (!ret)
-		++found_refs;
-	else if (ret != -ENOENT)
-		return ret;
-
-	ret = iterate_inode_extrefs(inum, fs_root, path, iterate, ctx);
-	if (ret == -ENOENT && found_refs)
-		return 0;
-
-	return ret;
-}
-
 /*
  * returns 0 if the path could be dumped (probably truncated)
  * returns <0 in case of an error
@@ -2248,8 +2226,20 @@ static int inode_to_path(u64 inum, u32 name_len, unsigned long name_off,
  */
 int paths_from_inode(u64 inum, struct inode_fs_paths *ipath)
 {
-	return iterate_irefs(inum, ipath->fs_root, ipath->btrfs_path,
-			     inode_to_path, ipath);
+	int ret;
+	int found_refs = 0;
+
+	ret = iterate_inode_refs(inum, ipath->fs_root, ipath->btrfs_path, ipath);
+	if (!ret)
+		++found_refs;
+	else if (ret != -ENOENT)
+		return ret;
+
+	ret = iterate_inode_extrefs(inum, ipath->fs_root, ipath->btrfs_path, ipath);
+	if (ret == -ENOENT && found_refs)
+		return 0;
+
+	return ret;
 }
 
 struct btrfs_data_container *init_data_container(u32 total_bytes)
-- 
2.36.1

