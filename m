Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD50543EB8
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jun 2022 23:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236310AbiFHVki (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 8 Jun 2022 17:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236320AbiFHVkh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 8 Jun 2022 17:40:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFE12BA417
        for <linux-btrfs@vger.kernel.org>; Wed,  8 Jun 2022 14:40:34 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 38C7921CAC;
        Wed,  8 Jun 2022 21:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1654724433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cHn9KgFLLoNKgJymByzK1XEx713+goT386Oss+S5Eus=;
        b=mPHCLp/I7I9sAdQcIepF5yht1iYeadqqATMkiEhg6SRV5jSc7SeDtp65R15Jl9Kifl/BWL
        Tqa8iwz9HCuTlvDmJ7pTZPk+3QI4QmP7FaTf/XixsFngnAiEBSAG5SLQoD7yQKuEc7W5h5
        fMMWdkcioiscfqOjLo0CNuyKuw8He4w=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 2F6F42C141;
        Wed,  8 Jun 2022 21:40:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8432BDA883; Wed,  8 Jun 2022 23:36:04 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 3/4] btrfs: sink iterator parameter to btrfs_ioctl_logical_to_ino
Date:   Wed,  8 Jun 2022 23:36:04 +0200
Message-Id: <50f2cf6559953bee816f5891c175c253054107ca.1654723641.git.dsterba@suse.com>
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

There's only one function we pass to iterate_inodes_from_logical as
iterator, so we can drop the indirection and call it directly, after
moving the function to backref.c

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/backref.c | 25 ++++++++++++++++++++++---
 fs/btrfs/backref.h |  3 +--
 fs/btrfs/ioctl.c   | 22 +---------------------
 3 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
index e62f142fd3e5..d385357e19b6 100644
--- a/fs/btrfs/backref.c
+++ b/fs/btrfs/backref.c
@@ -2028,10 +2028,29 @@ int iterate_extent_inodes(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+static int build_ino_list(u64 inum, u64 offset, u64 root, void *ctx)
+{
+	struct btrfs_data_container *inodes = ctx;
+	const size_t c = 3 * sizeof(u64);
+
+	if (inodes->bytes_left >= c) {
+		inodes->bytes_left -= c;
+		inodes->val[inodes->elem_cnt] = inum;
+		inodes->val[inodes->elem_cnt + 1] = offset;
+		inodes->val[inodes->elem_cnt + 2] = root;
+		inodes->elem_cnt += 3;
+	} else {
+		inodes->bytes_missing += c - inodes->bytes_left;
+		inodes->bytes_left = 0;
+		inodes->elem_missed += 3;
+	}
+
+	return 0;
+}
+
 int iterate_inodes_from_logical(u64 logical, struct btrfs_fs_info *fs_info,
 				struct btrfs_path *path,
-				iterate_extent_inodes_t *iterate, void *ctx,
-				bool ignore_offset)
+				void *ctx, bool ignore_offset)
 {
 	int ret;
 	u64 extent_item_pos;
@@ -2049,7 +2068,7 @@ int iterate_inodes_from_logical(u64 logical, struct btrfs_fs_info *fs_info,
 	extent_item_pos = logical - found_key.objectid;
 	ret = iterate_extent_inodes(fs_info, found_key.objectid,
 					extent_item_pos, search_commit_root,
-					iterate, ctx, ignore_offset);
+					build_ino_list, ctx, ignore_offset);
 
 	return ret;
 }
diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
index ba454032dbe2..2759de7d324c 100644
--- a/fs/btrfs/backref.h
+++ b/fs/btrfs/backref.h
@@ -35,8 +35,7 @@ int iterate_extent_inodes(struct btrfs_fs_info *fs_info,
 				bool ignore_offset);
 
 int iterate_inodes_from_logical(u64 logical, struct btrfs_fs_info *fs_info,
-				struct btrfs_path *path,
-				iterate_extent_inodes_t *iterate, void *ctx,
+				struct btrfs_path *path, void *ctx,
 				bool ignore_offset);
 
 int paths_from_inode(u64 inum, struct inode_fs_paths *ipath);
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 679ce4c5c341..7e1b4b0fbd6c 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -4243,26 +4243,6 @@ static long btrfs_ioctl_ino_to_path(struct btrfs_root *root, void __user *arg)
 	return ret;
 }
 
-static int build_ino_list(u64 inum, u64 offset, u64 root, void *ctx)
-{
-	struct btrfs_data_container *inodes = ctx;
-	const size_t c = 3 * sizeof(u64);
-
-	if (inodes->bytes_left >= c) {
-		inodes->bytes_left -= c;
-		inodes->val[inodes->elem_cnt] = inum;
-		inodes->val[inodes->elem_cnt + 1] = offset;
-		inodes->val[inodes->elem_cnt + 2] = root;
-		inodes->elem_cnt += 3;
-	} else {
-		inodes->bytes_missing += c - inodes->bytes_left;
-		inodes->bytes_left = 0;
-		inodes->elem_missed += 3;
-	}
-
-	return 0;
-}
-
 static long btrfs_ioctl_logical_to_ino(struct btrfs_fs_info *fs_info,
 					void __user *arg, int version)
 {
@@ -4312,7 +4292,7 @@ static long btrfs_ioctl_logical_to_ino(struct btrfs_fs_info *fs_info,
 	}
 
 	ret = iterate_inodes_from_logical(loi->logical, fs_info, path,
-					  build_ino_list, inodes, ignore_offset);
+					  inodes, ignore_offset);
 	if (ret == -EINVAL)
 		ret = -ENOENT;
 	if (ret < 0)
-- 
2.36.1

