Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64284543EBD
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 23:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbiFHVkg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 17:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236310AbiFHVkd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 17:40:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561452B7E3A
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 14:40:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 156731FD42;
        Wed,  8 Jun 2022 21:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654724431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ayYu7Dc6sNsmCzqizlF+yE6RVLZFdbix0R49vt+RXSA=;
        b=t70Ocs/1QU1T9aDQ3S0Xw8oGRIGFgvNExgRjV1EiXdowarPBYEPpCPMHOamneoUHjUqipp
        O8cgW0RlssP5HciOb09gGZqOwLpA1HTnYXGzpG4oOMkSmXbaDLdCQLoxeyi8KUCH8ddWPS
        NLsjp2sq0B3dYprZw5AZYjF2j4s8LvQ=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 0B3722C141;
        Wed,  8 Jun 2022 21:40:31 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5DF4DDA883; Wed,  8 Jun 2022 23:36:02 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/4] btrfs: simplify parameters of backref iterators
Date:   Wed,  8 Jun 2022 23:36:02 +0200
Message-Id: <ea757e4c48c4e58710d7a92e31331db5d9dfbd71.1654723641.git.dsterba@suse.com>
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

The inode reference iterator interface takes parameters that are derived
from the context parameter, but as it's a void* type the values are
passed individually.

Change the ctx type to inode_fs_path as it's the only thing we pass and
drop any parameters that are derived from that.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/backref.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index df3352f8be24..e62f142fd3e5 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2055,10 +2055,9 @@ int iterate_inodes_from_logical(u64 logical, struct btrfs_fs_info *fs_info,
 }
 
 static int inode_to_path(u64 inum, u32 name_len, unsigned long name_off,
-			 struct extent_buffer *eb, void *ctx);
+			 struct extent_buffer *eb, struct inode_fs_paths *ipath);
 
-static int iterate_inode_refs(u64 inum, struct btrfs_root *fs_root,
-			      struct btrfs_path *path, void *ctx)
+static int iterate_inode_refs(u64 inum, struct inode_fs_paths *ipath)
 {
 	int ret = 0;
 	int slot;
@@ -2067,6 +2066,8 @@ static int iterate_inode_refs(u64 inum, struct btrfs_root *fs_root,
 	u32 name_len;
 	u64 parent = 0;
 	int found = 0;
+	struct btrfs_root *fs_root = ipath->fs_root;
+	struct btrfs_path *path = ipath->btrfs_path;
 	struct extent_buffer *eb;
 	struct btrfs_inode_ref *iref;
 	struct btrfs_key found_key;
@@ -2103,7 +2104,7 @@ static int iterate_inode_refs(u64 inum, struct btrfs_root *fs_root,
 				cur, found_key.objectid,
 				fs_root->root_key.objectid);
 			ret = inode_to_path(parent, name_len,
-				      (unsigned long)(iref + 1), eb, ctx);
+				      (unsigned long)(iref + 1), eb, ipath);
 			if (ret)
 				break;
 			len = sizeof(*iref) + name_len;
@@ -2117,14 +2118,15 @@ static int iterate_inode_refs(u64 inum, struct btrfs_root *fs_root,
 	return ret;
 }
 
-static int iterate_inode_extrefs(u64 inum, struct btrfs_root *fs_root,
-				 struct btrfs_path *path, void *ctx)
+static int iterate_inode_extrefs(u64 inum, struct inode_fs_paths *ipath)
 {
 	int ret;
 	int slot;
 	u64 offset = 0;
 	u64 parent;
 	int found = 0;
+	struct btrfs_root *fs_root = ipath->fs_root;
+	struct btrfs_path *path = ipath->btrfs_path;
 	struct extent_buffer *eb;
 	struct btrfs_inode_extref *extref;
 	u32 item_size;
@@ -2161,7 +2163,7 @@ static int iterate_inode_extrefs(u64 inum, struct btrfs_root *fs_root,
 			parent = btrfs_inode_extref_parent(eb, extref);
 			name_len = btrfs_inode_extref_name_len(eb, extref);
 			ret = inode_to_path(parent, name_len,
-				      (unsigned long)&extref->name, eb, ctx);
+				      (unsigned long)&extref->name, eb, ipath);
 			if (ret)
 				break;
 
@@ -2183,9 +2185,8 @@ static int iterate_inode_extrefs(u64 inum, struct btrfs_root *fs_root,
  * returns <0 in case of an error
  */
 static int inode_to_path(u64 inum, u32 name_len, unsigned long name_off,
-			 struct extent_buffer *eb, void *ctx)
+			 struct extent_buffer *eb, struct inode_fs_paths *ipath)
 {
-	struct inode_fs_paths *ipath = ctx;
 	char *fspath;
 	char *fspath_min;
 	int i = ipath->fspath->elem_cnt;
@@ -2229,13 +2230,13 @@ int paths_from_inode(u64 inum, struct inode_fs_paths *ipath)
 	int ret;
 	int found_refs = 0;
 
-	ret = iterate_inode_refs(inum, ipath->fs_root, ipath->btrfs_path, ipath);
+	ret = iterate_inode_refs(inum, ipath);
 	if (!ret)
 		++found_refs;
 	else if (ret != -ENOENT)
 		return ret;
 
-	ret = iterate_inode_extrefs(inum, ipath->fs_root, ipath->btrfs_path, ipath);
+	ret = iterate_inode_extrefs(inum, ipath);
 	if (ret == -ENOENT && found_refs)
 		return 0;
 
-- 
2.36.1

