Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC76D7AAFAB
	for <lists+linux-btrfs@lfdr.de>; Fri, 22 Sep 2023 12:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbjIVKhv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 22 Sep 2023 06:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbjIVKhr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 22 Sep 2023 06:37:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C20C2
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 03:37:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83963C433CA
        for <linux-btrfs@vger.kernel.org>; Fri, 22 Sep 2023 10:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695379057;
        bh=TXEcJ5cXY5nBd7zG0LE6Yrm5/eIMTS0pnCgsOdUM4pg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=CzVf5JcjLKg3aOYj6lHRdIizhHk+cHW4uVb1WTAg1lJxnknNIsjNYO56v4tcLYtJl
         CUoZqwa49X1Wa6xZ2okNKbOOeV5d+1mXvhjLSGZAiFUQA896Z2DwQNycvFnNRqkQ4x
         BVgtNGShnhf7+kQJFWpLUWtDnVKGm6VTLcQ2o71DbLATsdJ4kT39UCZ3BrOui2/gqH
         Af++rNCdfhyNHCF/ZXe25eOMT3laYHCdWYT3CPCuRMQYLCJ3bkBNsXW7wmy2o0I5AZ
         jqqY4q0Suy1Pfa5O7CWDvBQ/KCEG2Up3SkvIRJd0dgr9JOEW8h1uzAceFVJ0yFROSx
         7fC2pBiJEJVTQ==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 7/8] btrfs: remove redundant root argument from maybe_insert_hole()
Date:   Fri, 22 Sep 2023 11:37:25 +0100
Message-Id: <6f3a5b0048ea27c88a69e4861e2b6b86afd284f9.1695333082.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1695333082.git.fdmanana@suse.com>
References: <cover.1695333082.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

The root argument for maybe_insert_hole() always matches the root of the
given inode, so remove the root argument and get it from the inode
argument.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 54647b7fb600..52576deda654 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4800,9 +4800,9 @@ int btrfs_truncate_block(struct btrfs_inode *inode, loff_t from, loff_t len,
 	return ret;
 }
 
-static int maybe_insert_hole(struct btrfs_root *root, struct btrfs_inode *inode,
-			     u64 offset, u64 len)
+static int maybe_insert_hole(struct btrfs_inode *inode, u64 offset, u64 len)
 {
+	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_trans_handle *trans;
 	struct btrfs_drop_extents_args drop_args = { 0 };
@@ -4898,8 +4898,7 @@ int btrfs_cont_expand(struct btrfs_inode *inode, loff_t oldsize, loff_t size)
 		if (!test_bit(EXTENT_FLAG_PREALLOC, &em->flags)) {
 			struct extent_map *hole_em;
 
-			err = maybe_insert_hole(root, inode, cur_offset,
-						hole_size);
+			err = maybe_insert_hole(inode, cur_offset, hole_size);
 			if (err)
 				break;
 
-- 
2.40.1

