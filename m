Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CC46643C8
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Jan 2023 15:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbjAJO53 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Jan 2023 09:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238761AbjAJO47 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Jan 2023 09:56:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A905458D16
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 06:56:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A606B816AA
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 14:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACAEC433D2
        for <linux-btrfs@vger.kernel.org>; Tue, 10 Jan 2023 14:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673362611;
        bh=vJalnNcCHxj47rpKQ8jOMYxy7T8XQYHqvl7ea3k3Ebk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aoCFaBNkK2ApYJMb00Ksc5He64Uas2vk+Rx4m9pqKh7aAdB55qgi+jDC4ZI3fyACc
         zLZn+kUApXq2bXHaQd83WnEVJLCBSSefkXYGw/tGwMEbLa9ra4hA45uU+1SO2Z3u/p
         mfPP30vWnAOHph5k5+jJ3iniDgbLNy/nAlGFhPZI0yOBql0Uv+mM9cMyZ6AVTHLHr6
         wxgsYz2uiiKcl/U7ejx8uaCrVY8V4pLirHJjKwzrWV/q48E2Fne0Hu2dltknFbil3X
         eVllnCRfdR4uMAptZkVNQFm2y2uTH9WUAWKQrmrfRgWmqLE6wUeIve9n4FDPx+UPXI
         zRKL6IrAaN9hA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 8/8] btrfs: use a single variable to track return value for log_dir_items()
Date:   Tue, 10 Jan 2023 14:56:41 +0000
Message-Id: <237ac621b36388b5e35aad20adc90b1da9f41970.1673361215.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1673361215.git.fdmanana@suse.com>
References: <cover.1673361215.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

We currently use 'ret' and 'err' to track the return value for
log_dir_items(), which is confusing and likely the cause for previous
bugs where log_dir_items() did not return an error when it should, fixed
in previous patches.

So change this and use only a single variable, 'ret', to track the return
value. This is simpler and makes it similar to most of the existing code.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 94fc8b08254c..997ba92481cb 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3793,7 +3793,6 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 	struct btrfs_key min_key;
 	struct btrfs_root *root = inode->root;
 	struct btrfs_root *log = root->log_root;
-	int err = 0;
 	int ret;
 	u64 last_old_dentry_offset = min_offset - 1;
 	u64 last_offset = (u64)-1;
@@ -3834,8 +3833,8 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 					      path->slots[0]);
 			if (tmp.type == BTRFS_DIR_INDEX_KEY)
 				last_old_dentry_offset = tmp.offset;
-		} else if (ret < 0) {
-			err = ret;
+		} else if (ret > 0) {
+			ret = 0;
 		}
 
 		goto done;
@@ -3858,7 +3857,6 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 		if (tmp.type == BTRFS_DIR_INDEX_KEY)
 			last_old_dentry_offset = tmp.offset;
 	} else if (ret < 0) {
-		err = ret;
 		goto done;
 	}
 
@@ -3880,12 +3878,15 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 	 */
 search:
 	ret = btrfs_search_slot(NULL, root, &min_key, path, 0, 0);
-	if (ret > 0)
+	if (ret > 0) {
 		ret = btrfs_next_item(root, path);
+		if (ret > 0) {
+			/* There are no more keys in the inode's root. */
+			ret = 0;
+			goto done;
+		}
+	}
 	if (ret < 0)
-		err = ret;
-	/* If ret is 1, there are no more keys in the inode's root. */
-	if (ret != 0)
 		goto done;
 
 	/*
@@ -3896,8 +3897,8 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 		ret = process_dir_items_leaf(trans, inode, path, dst_path, ctx,
 					     &last_old_dentry_offset);
 		if (ret != 0) {
-			if (ret < 0)
-				err = ret;
+			if (ret > 0)
+				ret = 0;
 			goto done;
 		}
 		path->slots[0] = btrfs_header_nritems(path->nodes[0]);
@@ -3908,10 +3909,10 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 		 */
 		ret = btrfs_next_leaf(root, path);
 		if (ret) {
-			if (ret == 1)
+			if (ret == 1) {
 				last_offset = (u64)-1;
-			else
-				err = ret;
+				ret = 0;
+			}
 			goto done;
 		}
 		btrfs_item_key_to_cpu(path->nodes[0], &min_key, path->slots[0]);
@@ -3942,7 +3943,7 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 	btrfs_release_path(path);
 	btrfs_release_path(dst_path);
 
-	if (err == 0) {
+	if (ret == 0) {
 		*last_offset_ret = last_offset;
 		/*
 		 * In case the leaf was changed in the current transaction but
@@ -3953,15 +3954,13 @@ static noinline int log_dir_items(struct btrfs_trans_handle *trans,
 		 * a range, last_old_dentry_offset is == to last_offset.
 		 */
 		ASSERT(last_old_dentry_offset <= last_offset);
-		if (last_old_dentry_offset < last_offset) {
+		if (last_old_dentry_offset < last_offset)
 			ret = insert_dir_log_key(trans, log, path, ino,
 						 last_old_dentry_offset + 1,
 						 last_offset);
-			if (ret)
-				err = ret;
-		}
 	}
-	return err;
+
+	return ret;
 }
 
 /*
-- 
2.35.1

