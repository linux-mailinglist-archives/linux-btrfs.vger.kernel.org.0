Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FC67AC940
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Sep 2023 15:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjIXN3W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Sep 2023 09:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjIXN27 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Sep 2023 09:28:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3157B1FE1;
        Sun, 24 Sep 2023 06:19:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7AA5C433B9;
        Sun, 24 Sep 2023 13:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561557;
        bh=mkNO1vi1nAK+2SSQNEOGgvfs9MWPgbfJ68Qb1fHOSBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RpT2J/eccxdMkzZzOcHod9mzVC5zw1kBke+cI4jWzGmuCLvf/T7RQb7I/XgmvDaBP
         946M96o67sVT4WO8qj+Nfzcw2+kewARYEr8tAIVfukTkiDLOQc8B9mlGgJ3y+urjrm
         nVffnMFKVZIMgJprgLjvECUhVuqSAdL/Cu7BIylnH4oVBWnQcDAsjhLN3UZX81myxC
         Ml3mULZ+uG3W31qtMDa42ITwPNa6TirOHNMSFDqQXSelvP+O4ZWAhJxHKVNomgew63
         SnM5m391OLtl2v7cKxKTteZwcuJhkCJ02ZilCl+ptxbBmx54/Q47GHHdHwC5h4o4A6
         F82zZ7+6iWEZQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, clm@fb.com,
        josef@toxicpanda.com, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 09/18] btrfs: improve error message after failure to add delayed dir index item
Date:   Sun, 24 Sep 2023 09:18:46 -0400
Message-Id: <20230924131857.1276330-9-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131857.1276330-1-sashal@kernel.org>
References: <20230924131857.1276330-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.133
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
index 1e08eb2b27f0c..429a571435a5b 100644
--- a/fs/btrfs/delayed-inode.c
+++ b/fs/btrfs/delayed-inode.c
@@ -1388,9 +1388,10 @@ int btrfs_insert_delayed_dir_index(struct btrfs_trans_handle *trans,
 	ret = __btrfs_add_delayed_insertion_item(delayed_node, delayed_item);
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

