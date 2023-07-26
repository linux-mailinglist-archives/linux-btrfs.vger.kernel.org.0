Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51805763BCC
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jul 2023 17:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbjGZP6E (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jul 2023 11:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbjGZP53 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jul 2023 11:57:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAEE2136
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 08:57:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CB9261BA6
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D83C433CB
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Jul 2023 15:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690387047;
        bh=QqqVnOJ/3/tMBHY//DFNWBzTWtHy6dcSDDwyZB4OPns=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=JLHDtx8GeEqr43mLKrjHlnVePPQBr2pjQU6yyIi8iosxxj2RTj87ynMipvSscvwhN
         5q1hvEn1+lWqj/+1uJcCLQZQvzVd/q2UAcxEx4Dg4k0Vr+nFKFootqAk1jnuLOBi8/
         rXbLV0OxNcQsx9v5AgU3G5ZNe8JvjzYT7hnQGvhPfZhV2OfDehs/OxUi9/3yAEoSI4
         UTpVVK2hp1QJjBrkXEtnZupW2HOhKdFL4irueFoBt0kl6M80Sxyw521l897t3d5ZA+
         dScPQM59lrlN1h4Eegisv7xHYykEeOO96nKSHBBeSGsHrB7hapuXGQ3+quqUDqujgi
         KnafLiCf4l27w==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 11/17] btrfs: make btrfs_cleanup_fs_roots() static
Date:   Wed, 26 Jul 2023 16:57:07 +0100
Message-Id: <f20e4fcbceb7299d675af2e2245b155de254dcfa.1690383587.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690383587.git.fdmanana@suse.com>
References: <cover.1690383587.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

btrfs_cleanup_fs_roots() is not used outside disk-io.c, so make it static,
remove its prototype from disk-io.h and move its definition above the
where it's used in disk-io.c

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/disk-io.c | 100 ++++++++++++++++++++++-----------------------
 fs/btrfs/disk-io.h |   1 -
 2 files changed, 50 insertions(+), 51 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index cad79d4eecdf..da51e5750443 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2858,6 +2858,56 @@ static int btrfs_check_uuid_tree(struct btrfs_fs_info *fs_info)
 	return 0;
 }
 
+static int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
+{
+	u64 root_objectid = 0;
+	struct btrfs_root *gang[8];
+	int i = 0;
+	int err = 0;
+	unsigned int ret = 0;
+
+	while (1) {
+		spin_lock(&fs_info->fs_roots_radix_lock);
+		ret = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
+					     (void **)gang, root_objectid,
+					     ARRAY_SIZE(gang));
+		if (!ret) {
+			spin_unlock(&fs_info->fs_roots_radix_lock);
+			break;
+		}
+		root_objectid = gang[ret - 1]->root_key.objectid + 1;
+
+		for (i = 0; i < ret; i++) {
+			/* Avoid to grab roots in dead_roots. */
+			if (btrfs_root_refs(&gang[i]->root_item) == 0) {
+				gang[i] = NULL;
+				continue;
+			}
+			/* Grab all the search result for later use. */
+			gang[i] = btrfs_grab_root(gang[i]);
+		}
+		spin_unlock(&fs_info->fs_roots_radix_lock);
+
+		for (i = 0; i < ret; i++) {
+			if (!gang[i])
+				continue;
+			root_objectid = gang[i]->root_key.objectid;
+			err = btrfs_orphan_cleanup(gang[i]);
+			if (err)
+				goto out;
+			btrfs_put_root(gang[i]);
+		}
+		root_objectid++;
+	}
+out:
+	/* Release the uncleaned roots due to error. */
+	for (; i < ret; i++) {
+		if (gang[i])
+			btrfs_put_root(gang[i]);
+	}
+	return err;
+}
+
 /*
  * Some options only have meaning at mount time and shouldn't persist across
  * remounts, or be displayed. Clear these at the end of mount and remount
@@ -4125,56 +4175,6 @@ void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
 		btrfs_put_root(root);
 }
 
-int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info)
-{
-	u64 root_objectid = 0;
-	struct btrfs_root *gang[8];
-	int i = 0;
-	int err = 0;
-	unsigned int ret = 0;
-
-	while (1) {
-		spin_lock(&fs_info->fs_roots_radix_lock);
-		ret = radix_tree_gang_lookup(&fs_info->fs_roots_radix,
-					     (void **)gang, root_objectid,
-					     ARRAY_SIZE(gang));
-		if (!ret) {
-			spin_unlock(&fs_info->fs_roots_radix_lock);
-			break;
-		}
-		root_objectid = gang[ret - 1]->root_key.objectid + 1;
-
-		for (i = 0; i < ret; i++) {
-			/* Avoid to grab roots in dead_roots */
-			if (btrfs_root_refs(&gang[i]->root_item) == 0) {
-				gang[i] = NULL;
-				continue;
-			}
-			/* grab all the search result for later use */
-			gang[i] = btrfs_grab_root(gang[i]);
-		}
-		spin_unlock(&fs_info->fs_roots_radix_lock);
-
-		for (i = 0; i < ret; i++) {
-			if (!gang[i])
-				continue;
-			root_objectid = gang[i]->root_key.objectid;
-			err = btrfs_orphan_cleanup(gang[i]);
-			if (err)
-				goto out;
-			btrfs_put_root(gang[i]);
-		}
-		root_objectid++;
-	}
-out:
-	/* release the uncleaned roots due to error */
-	for (; i < ret; i++) {
-		if (gang[i])
-			btrfs_put_root(gang[i]);
-	}
-	return err;
-}
-
 int btrfs_commit_super(struct btrfs_fs_info *fs_info)
 {
 	struct btrfs_root *root = fs_info->tree_root;
diff --git a/fs/btrfs/disk-io.h b/fs/btrfs/disk-io.h
index b03767f4d7ed..02b645744a82 100644
--- a/fs/btrfs/disk-io.h
+++ b/fs/btrfs/disk-io.h
@@ -77,7 +77,6 @@ struct btrfs_root *btrfs_extent_root(struct btrfs_fs_info *fs_info, u64 bytenr);
 struct btrfs_root *btrfs_block_group_root(struct btrfs_fs_info *fs_info);
 
 void btrfs_free_fs_info(struct btrfs_fs_info *fs_info);
-int btrfs_cleanup_fs_roots(struct btrfs_fs_info *fs_info);
 void btrfs_btree_balance_dirty(struct btrfs_fs_info *fs_info);
 void btrfs_btree_balance_dirty_nodelay(struct btrfs_fs_info *fs_info);
 void btrfs_drop_and_free_fs_root(struct btrfs_fs_info *fs_info,
-- 
2.34.1

