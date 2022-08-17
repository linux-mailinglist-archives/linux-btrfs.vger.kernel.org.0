Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4674596D79
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Aug 2022 13:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbiHQLW7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 07:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbiHQLW5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 07:22:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18AB6CF45
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 04:22:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F05D614C9
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 11:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5BCC433B5
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Aug 2022 11:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660735376;
        bh=xMMo1GFYJ7m6Lbnm9+ridGF3gHkC/kuAQUkyT8oNIWs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=S4DAXU1w4+DqxDvRZAEIxbkBOjUnnjzZs0KOocNMbDnmyzyYl/M6i2AQ2onks1jFI
         1VYsVE/5+rdUqZs/RBhN4KVM4YRlnARU6vWNQJoKCrG5X3Y/k+9d+yA0RtTiJ3Vrjw
         r9BYCkDauHea8X9a9qRCKA3eGRj4POTz02zNfw4znVar+HNlDU4dKpHaGcMucpOVhE
         eN+ScDatCHYzx6H4tu0n8W7PN0oJvc0+TgmupZ+0Or3d9yOKyiRC6gNSrWEwDeXg9U
         MagD5O6BOBHxqJIKVXCaF5DROZ6Ng92NOFkF33atQLYcjOu1Tm1lDQNcWxXFGVwFKy
         lK6KjZr/7NAfw==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 02/15] btrfs: remove the root argument from log_new_dir_dentries()
Date:   Wed, 17 Aug 2022 12:22:35 +0100
Message-Id: <c0e3db51951312b3b91ab558f28084df942c8c39.1660735024.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1660735024.git.fdmanana@suse.com>
References: <cover.1660735024.git.fdmanana@suse.com>
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

There's no point in passing a root argument to log_new_dir_dentries()
because it always corresponds to the root of the given inode. So remove
it and extract the root from the given inode.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index cffd15e23614..56fbd3b9f642 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -5969,10 +5969,10 @@ struct btrfs_dir_list {
  *    do_overwrite_item()).
  */
 static int log_new_dir_dentries(struct btrfs_trans_handle *trans,
-				struct btrfs_root *root,
 				struct btrfs_inode *start_inode,
 				struct btrfs_log_ctx *ctx)
 {
+	struct btrfs_root *root = start_inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_path *path;
 	LIST_HEAD(dir_list);
@@ -6199,7 +6199,7 @@ static int btrfs_log_all_parents(struct btrfs_trans_handle *trans,
 			ret = btrfs_log_inode(trans, BTRFS_I(dir_inode),
 					      LOG_INODE_ALL, ctx);
 			if (!ret && ctx->log_new_dentries)
-				ret = log_new_dir_dentries(trans, root,
+				ret = log_new_dir_dentries(trans,
 						   BTRFS_I(dir_inode), ctx);
 			btrfs_add_delayed_iput(dir_inode);
 			if (ret)
@@ -6514,7 +6514,7 @@ static int btrfs_log_inode_parent(struct btrfs_trans_handle *trans,
 		goto end_trans;
 
 	if (log_dentries)
-		ret = log_new_dir_dentries(trans, root, inode, ctx);
+		ret = log_new_dir_dentries(trans, inode, ctx);
 	else
 		ret = 0;
 end_trans:
-- 
2.35.1

