Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C2E706605
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 May 2023 13:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjEQLEn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 May 2023 07:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjEQLEl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 May 2023 07:04:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802D15FCE
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 04:04:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5960C64547
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 11:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2CCC433EF
        for <linux-btrfs@vger.kernel.org>; Wed, 17 May 2023 11:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684321350;
        bh=udZ5fUEoZQAq1KqdcQhxNXrsGmbW1h0T2s77Nu3DHBU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=HPxXlB8fjz5i9bHmOhwjFpBvU2AHbSRzNvJyD1wRIIEwXIcSbZBZsl0yTKirldqQw
         hY+mWC84Y6+wG3wNm1o9e9Koxyqj19nAS8/Hrr7dZVU6URbu6P6eDRJtyZKOSVFRPG
         etejP9Q8R9z/bt/lH2AKB10HYnJN2HOKjY5qWsrXKAssHNninJ8N4ZaFW/OeUQV0aP
         TP7WZbpcMn9pIMD2019XJRqmwF3oI7xliofGeMA7RRosLngqnsBs7kRQJywq7D7YVO
         ufGhPAj32xQHduOX5cVm68wo6vr61agWPOrl7vWHcY8GBsP5Ml+5N3I7raqGXbEGmB
         feRiUd11o3yew==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/5] btrfs: change for_rename argument of btrfs_record_unlink_dir() to bool
Date:   Wed, 17 May 2023 12:02:16 +0100
Message-Id: <60e43369efe0f27481d5e2fc6ca1ccc2df64a3f9.1684320689.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1684320689.git.fdmanana@suse.com>
References: <cover.1684320689.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The for_rename argument of btrfs_record_unlink_dir() is defined as an
integer, but the argument is in fact used as a boolean. So change it to
a boolean to make its use more clear.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c    | 8 ++++----
 fs/btrfs/tree-log.c | 2 +-
 fs/btrfs/tree-log.h | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 4f9ef5ca3856..456010f48570 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4414,7 +4414,7 @@ static int btrfs_unlink(struct inode *dir, struct dentry *dentry)
 	}
 
 	btrfs_record_unlink_dir(trans, BTRFS_I(dir), BTRFS_I(d_inode(dentry)),
-			0);
+				false);
 
 	ret = btrfs_unlink_inode(trans, BTRFS_I(dir), BTRFS_I(d_inode(dentry)),
 				 &fname.disk_name);
@@ -8976,9 +8976,9 @@ static int btrfs_rename_exchange(struct inode *old_dir,
 
 	if (old_dentry->d_parent != new_dentry->d_parent) {
 		btrfs_record_unlink_dir(trans, BTRFS_I(old_dir),
-				BTRFS_I(old_inode), 1);
+					BTRFS_I(old_inode), true);
 		btrfs_record_unlink_dir(trans, BTRFS_I(new_dir),
-				BTRFS_I(new_inode), 1);
+					BTRFS_I(new_inode), true);
 	}
 
 	/* src is a subvolume */
@@ -9244,7 +9244,7 @@ static int btrfs_rename(struct mnt_idmap *idmap,
 
 	if (old_dentry->d_parent != new_dentry->d_parent)
 		btrfs_record_unlink_dir(trans, BTRFS_I(old_dir),
-				BTRFS_I(old_inode), 1);
+					BTRFS_I(old_inode), true);
 
 	if (unlikely(old_ino == BTRFS_FIRST_FREE_OBJECTID)) {
 		ret = btrfs_unlink_subvol(trans, BTRFS_I(old_dir), old_dentry);
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 061b132d3f96..98488f6e4e88 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -7309,7 +7309,7 @@ int btrfs_recover_log_trees(struct btrfs_root *log_root_tree)
  */
 void btrfs_record_unlink_dir(struct btrfs_trans_handle *trans,
 			     struct btrfs_inode *dir, struct btrfs_inode *inode,
-			     int for_rename)
+			     bool for_rename)
 {
 	/*
 	 * when we're logging a file, if it hasn't been renamed
diff --git a/fs/btrfs/tree-log.h b/fs/btrfs/tree-log.h
index bdeb5216718f..a550a8a375cd 100644
--- a/fs/btrfs/tree-log.h
+++ b/fs/btrfs/tree-log.h
@@ -100,7 +100,7 @@ void btrfs_end_log_trans(struct btrfs_root *root);
 void btrfs_pin_log_trans(struct btrfs_root *root);
 void btrfs_record_unlink_dir(struct btrfs_trans_handle *trans,
 			     struct btrfs_inode *dir, struct btrfs_inode *inode,
-			     int for_rename);
+			     bool for_rename);
 void btrfs_record_snapshot_destroy(struct btrfs_trans_handle *trans,
 				   struct btrfs_inode *dir);
 void btrfs_log_new_name(struct btrfs_trans_handle *trans,
-- 
2.34.1

