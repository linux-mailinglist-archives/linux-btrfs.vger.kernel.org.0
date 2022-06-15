Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A639F54C9D2
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 15:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245511AbiFONaJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Jun 2022 09:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353163AbiFON3v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Jun 2022 09:29:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4517933E89
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Jun 2022 06:29:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 04E2921C63;
        Wed, 15 Jun 2022 13:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655299781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7LmcTjEQwomoyr7Bkxn2bJyHhzG9A1LHWUGX0R+MKlc=;
        b=RC1fPVO85IyUYvJ5LyIyuQqUrUQXMCm8yi+6ZoIan4H0eammRiGPgbWZKYXPNwyaq0rCo5
        AgTdGGxjmMt5jECzaA3pOMNjN/StOpQCKn/d1EyGvF0uIG08AhQVD/y5YxWzTRuF38kKQV
        fxg6ky6SD4nzUuCSKMqU7XG1ikRnOs8=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id F051B2C141;
        Wed, 15 Jun 2022 13:29:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A37B2DA85E; Wed, 15 Jun 2022 15:25:08 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 6/6] btrfs: send: use boolean types for current inode status
Date:   Wed, 15 Jun 2022 15:25:08 +0200
Message-Id: <58dd2aa4fa32f5a8b72c1b575fe42d3f797c2409.1655299339.git.dsterba@suse.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1655299339.git.dsterba@suse.com>
References: <cover.1655299339.git.dsterba@suse.com>
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

The new, new_gen and deleted indicate a status, use boolean type instead
of int.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/send.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index f6469c7666c9..b417674a36b9 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -117,9 +117,9 @@ struct send_ctx {
 	 */
 	u64 cur_ino;
 	u64 cur_inode_gen;
-	int cur_inode_new;
-	int cur_inode_new_gen;
-	int cur_inode_deleted;
+	bool cur_inode_new;
+	bool cur_inode_new_gen;
+	bool cur_inode_deleted;
 	u64 cur_inode_size;
 	u64 cur_inode_mode;
 	u64 cur_inode_rdev;
@@ -6529,7 +6529,7 @@ static int changed_inode(struct send_ctx *sctx,
 	close_current_inode(sctx);
 
 	sctx->cur_ino = key->objectid;
-	sctx->cur_inode_new_gen = 0;
+	sctx->cur_inode_new_gen = false;
 	sctx->cur_inode_last_extent = (u64)-1;
 	sctx->cur_inode_next_write_offset = 0;
 	sctx->ignore_cur_inode = false;
@@ -6570,7 +6570,7 @@ static int changed_inode(struct send_ctx *sctx,
 		 */
 		if (left_gen != right_gen &&
 		    sctx->cur_ino != BTRFS_FIRST_FREE_OBJECTID)
-			sctx->cur_inode_new_gen = 1;
+			sctx->cur_inode_new_gen = true;
 	}
 
 	/*
@@ -6602,8 +6602,8 @@ static int changed_inode(struct send_ctx *sctx,
 
 	if (result == BTRFS_COMPARE_TREE_NEW) {
 		sctx->cur_inode_gen = left_gen;
-		sctx->cur_inode_new = 1;
-		sctx->cur_inode_deleted = 0;
+		sctx->cur_inode_new = true;
+		sctx->cur_inode_deleted = false;
 		sctx->cur_inode_size = btrfs_inode_size(
 				sctx->left_path->nodes[0], left_ii);
 		sctx->cur_inode_mode = btrfs_inode_mode(
@@ -6614,8 +6614,8 @@ static int changed_inode(struct send_ctx *sctx,
 			ret = send_create_inode_if_needed(sctx);
 	} else if (result == BTRFS_COMPARE_TREE_DELETED) {
 		sctx->cur_inode_gen = right_gen;
-		sctx->cur_inode_new = 0;
-		sctx->cur_inode_deleted = 1;
+		sctx->cur_inode_new = false;
+		sctx->cur_inode_deleted = true;
 		sctx->cur_inode_size = btrfs_inode_size(
 				sctx->right_path->nodes[0], right_ii);
 		sctx->cur_inode_mode = btrfs_inode_mode(
@@ -6633,8 +6633,8 @@ static int changed_inode(struct send_ctx *sctx,
 			 * First, process the inode as if it was deleted.
 			 */
 			sctx->cur_inode_gen = right_gen;
-			sctx->cur_inode_new = 0;
-			sctx->cur_inode_deleted = 1;
+			sctx->cur_inode_new = false;
+			sctx->cur_inode_deleted = true;
 			sctx->cur_inode_size = btrfs_inode_size(
 					sctx->right_path->nodes[0], right_ii);
 			sctx->cur_inode_mode = btrfs_inode_mode(
@@ -6648,8 +6648,8 @@ static int changed_inode(struct send_ctx *sctx,
 			 * Now process the inode as if it was new.
 			 */
 			sctx->cur_inode_gen = left_gen;
-			sctx->cur_inode_new = 1;
-			sctx->cur_inode_deleted = 0;
+			sctx->cur_inode_new = true;
+			sctx->cur_inode_deleted = false;
 			sctx->cur_inode_size = btrfs_inode_size(
 					sctx->left_path->nodes[0], left_ii);
 			sctx->cur_inode_mode = btrfs_inode_mode(
@@ -6681,9 +6681,9 @@ static int changed_inode(struct send_ctx *sctx,
 				goto out;
 		} else {
 			sctx->cur_inode_gen = left_gen;
-			sctx->cur_inode_new = 0;
-			sctx->cur_inode_new_gen = 0;
-			sctx->cur_inode_deleted = 0;
+			sctx->cur_inode_new = false;
+			sctx->cur_inode_new_gen = false;
+			sctx->cur_inode_deleted = false;
 			sctx->cur_inode_size = btrfs_inode_size(
 					sctx->left_path->nodes[0], left_ii);
 			sctx->cur_inode_mode = btrfs_inode_mode(
-- 
2.36.1

