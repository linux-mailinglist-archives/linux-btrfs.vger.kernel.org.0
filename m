Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00807AC8E5
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Sep 2023 15:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjIXNUx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Sep 2023 09:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjIXNUg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Sep 2023 09:20:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6511708;
        Sun, 24 Sep 2023 06:18:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 186F7C433CC;
        Sun, 24 Sep 2023 13:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561496;
        bh=5ujdhPWUNHx2w+EQMhZKEX4tzMcePKTCMd6wRe9Zbss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mhRIZq5NIsduuKBTTSzB5t2r/3ka0OBliY1oh4MvTkTNCy7b/ybO8pF6kY+53RPub
         LxpHlvrfZHaNB0WCAJuNBi2JF0rY6THON8CDox8Wou9/+4/TPcu46eqqRdNkj49X/I
         jiOONnnD6yr70zDCO5ArMyd+fpxA97TPTTEwcMgPZUFLMUJkyZLZ0AlYGfzvwL5F+s
         6da7FylmFPhpKV9N/TqHob2NHuP6l6lmNnfESNH7fDAqkSLlN0Yr0s+bGifHn0vpip
         t6bb9r7hQDROoFjmB+YQ2qK9ygFSIKY3fitM0FXIdHcFFy8bwkM6vxTDXlNGsbJax1
         dXFp/VN8hvfng==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 11/28] btrfs: improve error message after failure to add delayed dir index item
Date:   Sun, 24 Sep 2023 09:17:28 -0400
Message-Id: <20230924131745.1275960-11-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131745.1275960-1-sashal@kernel.org>
References: <20230924131745.1275960-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.55
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 91bfe3104b8db0310f76f2dcb6aacef24c889366 ]

If we fail to add a delayed dir index item because there's already another
item with the same index number, we print an error message (and then BUG).
However that message isn't very helpful to debug anything because we don't
know what's the index number and what are the values of index counters in
the inode and its delayed inode (index_cnt fields of struct btrfs_inode
and struct btrfs_delayed_node).

So update the error message to include the index number and counters.

We actually had a recent case where this issue was hit by a syzbot report
(see the link below).

Link: https://lore.kernel.org/linux-btrfs/00000000000036e1290603e097e0@google.com/
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/delayed-inode.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
index cac5169eaf8de..221d34f2ddf9a 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1493,9 +1493,10 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 	ret = __btrfs_add_delayed_item(delayed_node, delayed_item);
 	if (unlikely(ret)) {
 		btrfs_err(trans->fs_info,
-			  "err add delayed dir index item(name: %.*s) into the insertion tree of the delayed node(root id: %llu, inode id: %llu, errno: %d)",
-			  name_len, name, delayed_node->root->root_key.objectid,
-			  delayed_node->inode_id, ret);
+"error adding delayed dir index item, name: %.*s, index: %llu, root: %llu, dir: %llu, dir->index_cnt: %llu, delayed_node->index_cnt: %llu, error: %d",
+			  name_len, name, index, btrfs_root_id(delayed_node->root),
+			  delayed_node->inode_id, dir->index_cnt,
+			  delayed_node->index_cnt, ret);
 		BUG();
 	}
 	mutex_unlock(&delayed_node->mutex);
-- 
2.40.1

