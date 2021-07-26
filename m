Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 385803D5945
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 14:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbhGZLh2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 07:37:28 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58008 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbhGZLh2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 07:37:28 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7C26F1FE75;
        Mon, 26 Jul 2021 12:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627301876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WWY5msVN9sv9Ijd4bWaqzqPxokSFLzC50zluN9HmWBc=;
        b=HyXqgFfJn6M3WIoxyfb7k5ZXOoZ2KVxWM6JFxvHeUhQG/fA+R+WVninIYGg+QFrrObai0t
        Xooi7q2nRT6wMghtaetyrDvg7Bj+jZkTGWR/bVjaudmZ8p5rXiNiQUTWxLCvunHAkIMNDs
        siMymG1P4b41jytGANEJtxG30r4JoRw=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 75470A3BF4;
        Mon, 26 Jul 2021 12:17:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C71D6DA8D8; Mon, 26 Jul 2021 14:15:12 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 03/10] btrfs: make btrfs_next_leaf static inline
Date:   Mon, 26 Jul 2021 14:15:12 +0200
Message-Id: <23099d2508b778b3169926538cb495213db327a9.1627300614.git.dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627300614.git.dsterba@suse.com>
References: <cover.1627300614.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_next_leaf is a simple wrapper for btrfs_next_old_leaf so move it
to header to avoid the function call overhead.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ctree.c | 10 ----------
 fs/btrfs/ctree.h | 13 ++++++++++++-
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
index 63c026495193..99b33a5b33c8 100644
--- a/fs/btrfs/ctree.c
+++ b/fs/btrfs/ctree.c
@@ -4357,16 +4357,6 @@ int btrfs_find_next_key(struct btrfs_root *root, struct btrfs_path *path,
 	return 1;
 }
 
-/*
- * search the tree again to find a leaf with greater keys
- * returns 0 if it found something or 1 if there are no greater leaves.
- * returns < 0 on io errors.
- */
-int btrfs_next_leaf(struct btrfs_root *root, struct btrfs_path *path)
-{
-	return btrfs_next_old_leaf(root, path, 0);
-}
-
 int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 			u64 time_seq)
 {
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a822404eeaee..04779e3d3ab5 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -2899,7 +2899,6 @@ static inline int btrfs_insert_empty_item(struct btrfs_trans_handle *trans,
 	return btrfs_insert_empty_items(trans, root, path, key, &data_size, 1);
 }
 
-int btrfs_next_leaf(struct btrfs_root *root, struct btrfs_path *path);
 int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path);
 int btrfs_next_old_leaf(struct btrfs_root *root, struct btrfs_path *path,
 			u64 time_seq);
@@ -2911,6 +2910,18 @@ static inline int btrfs_next_old_item(struct btrfs_root *root,
 		return btrfs_next_old_leaf(root, p, time_seq);
 	return 0;
 }
+
+/*
+ * Search the tree again to find a leaf with greater keys.
+ *
+ * Returns 0 if it found something or 1 if there are no greater leaves.
+ * Returns < 0 on error.
+ */
+static inline int btrfs_next_leaf(struct btrfs_root *root, struct btrfs_path *path)
+{
+	return btrfs_next_old_leaf(root, path, 0);
+}
+
 static inline int btrfs_next_item(struct btrfs_root *root, struct btrfs_path *p)
 {
 	return btrfs_next_old_item(root, p, 0);
-- 
2.31.1

