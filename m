Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBBE33376A0
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Mar 2021 16:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbhCKPNi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Mar 2021 10:13:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:36480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234019AbhCKPNd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Mar 2021 10:13:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0228A64FAA
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Mar 2021 15:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615475613;
        bh=C2zoMqnI1M7FIRXKHFt1SIZ3x7s0R2ftTUlI+3ttcVs=;
        h=From:To:Subject:Date:From;
        b=HAD0QuyzT3SoyaB9xrQujrBCT7Np67TbYbjLNLhY/9+lUwfddv5/iWlD1syr2i0ly
         aEDMGJSSEnc5TWmjLvYlcb8M9nWcGF5xbF6Hx6XT9yXIqASCxAO1N2QHn25CqZz3MT
         MpmXIVw9KhAKB9l+Q6onaro5YOF8T5PqHJqICUrVyqonIxZIlymFfG+qAjPNWfw7Pr
         Hiaft5QWK//eznMcjL2nQL6eDCHH78kqCwYNqfEa6o94bakR7WS4+1qZSSlKUGiRGh
         4bBwUo5WTTks+Sv/wIJIDPNNcDKzD84RQ1uHlS7tc2nusIc+fYeXRsfm8HQ2dnUvcC
         vjrH/k5EAUHzA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: zoned: fix linked list corruption after log root tree allocation failure
Date:   Thu, 11 Mar 2021 15:13:30 +0000
Message-Id: <b4746dac89274ef11314a6abacc58a27c5935a1f.1615475093.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

When using a zoned filesystem, while syncing the log, if we fail to
allocate the root node for the log root tree, we are not removing the
log context we allocated on stack from the list of log contextes of the
log root tree. This means after the return from btrfs_sync_log() we get
a corrupted linked list.

Fix this by allocating the node before adding our stack allocated context
to the list of log contextes of the log root tree.

Fixes: 3ddebf27fcd3a9 ("btrfs: zoned: reorder log node allocation on zoned filesystem")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/tree-log.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 2f1acc9aea9e..92a368627791 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3169,10 +3169,6 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 
 	mutex_lock(&log_root_tree->log_mutex);
 
-	index2 = log_root_tree->log_transid % 2;
-	list_add_tail(&root_log_ctx.list, &log_root_tree->log_ctxs[index2]);
-	root_log_ctx.log_transid = log_root_tree->log_transid;
-
 	if (btrfs_is_zoned(fs_info)) {
 		if (!log_root_tree->node) {
 			ret = btrfs_alloc_log_tree_node(trans, log_root_tree);
@@ -3183,6 +3179,10 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 		}
 	}
 
+	index2 = log_root_tree->log_transid % 2;
+	list_add_tail(&root_log_ctx.list, &log_root_tree->log_ctxs[index2]);
+	root_log_ctx.log_transid = log_root_tree->log_transid;
+
 	/*
 	 * Now we are safe to update the log_root_tree because we're under the
 	 * log_mutex, and we're a current writer so we're holding the commit
-- 
2.28.0

