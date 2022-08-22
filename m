Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3254C59BDE5
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Aug 2022 12:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233774AbiHVKv5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 22 Aug 2022 06:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbiHVKvx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 22 Aug 2022 06:51:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811C13121A
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 03:51:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DF6CB81015
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 10:51:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8077DC433D7
        for <linux-btrfs@vger.kernel.org>; Mon, 22 Aug 2022 10:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661165510;
        bh=xMMo1GFYJ7m6Lbnm9+ridGF3gHkC/kuAQUkyT8oNIWs=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Yf8o6M6OjjnVv8apD7QGmjBlc83MsX4Nbp9ymYu8jaLjrkqeOmVvHEODrcqjbgTMl
         2A7TAq78pdeTfWPxGBfkevZJsOip++TDlEw3hSgR3rNCqEne61YlSYy2EyiU9MCM39
         DXPXw/lILv9kkCOTVaVJMgqwkFon/QUexC5DBJy1hIh8MAmrS7G9cko2z8I/vnmsbT
         +lEv1km/DX+pd87wE0iZeutgJVL4JjjfI4y8CHYrJP8jqQnwkiB5AYuIIeQQUAZ9hp
         gAsWwd93MiSp968I8sg9eaGUpZIqDAe18WFQjsJIDo2AhtDBy9Wt55rqdJRJgttPjX
         U/euWVV1ymIJg==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 02/15] btrfs: remove the root argument from log_new_dir_dentries()
Date:   Mon, 22 Aug 2022 11:51:31 +0100
Message-Id: <3696e99984ac2a21e57bfc2cfe75b8bf7c282b09.1661165149.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1661165149.git.fdmanana@suse.com>
References: <cover.1661165149.git.fdmanana@suse.com>
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

