Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D71E2524D2
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 02:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgHZAro (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Aug 2020 20:47:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:45258 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbgHZArn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Aug 2020 20:47:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 29BCCAFFD
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 00:48:13 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs-progs: remove the unused variable in check_chunks_and_extents_lowmem()
Date:   Wed, 26 Aug 2020 08:47:34 +0800
Message-Id: <20200826004734.89905-3-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200826004734.89905-1-wqu@suse.com>
References: <20200826004734.89905-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The variable @root is only set but not utilized, while we only utilize
@root1.

Replace @root1 with @root, then remove the @root1.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/mode-lowmem.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index 3ce119fa0f61..837bacf920ac 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -5399,20 +5399,17 @@ int check_chunks_and_extents_lowmem(void)
 	struct btrfs_path path;
 	struct btrfs_key old_key;
 	struct btrfs_key key;
-	struct btrfs_root *root1;
 	struct btrfs_root *root;
 	struct btrfs_root *cur_root;
 	int err = 0;
 	int ret;
 
-	root = gfs_info->fs_root;
-
-	root1 = gfs_info->chunk_root;
-	ret = check_btrfs_root(root1, 1);
+	root = gfs_info->chunk_root;
+	ret = check_btrfs_root(root, 1);
 	err |= ret;
 
-	root1 = gfs_info->tree_root;
-	ret = check_btrfs_root(root1, 1);
+	root = gfs_info->tree_root;
+	ret = check_btrfs_root(root, 1);
 	err |= ret;
 
 	btrfs_init_path(&path);
@@ -5420,7 +5417,7 @@ int check_chunks_and_extents_lowmem(void)
 	key.offset = 0;
 	key.type = BTRFS_ROOT_ITEM_KEY;
 
-	ret = btrfs_search_slot(NULL, root1, &key, &path, 0, 0);
+	ret = btrfs_search_slot(NULL, root, &key, &path, 0, 0);
 	if (ret) {
 		error("cannot find extent tree in tree_root");
 		goto out;
@@ -5455,7 +5452,7 @@ int check_chunks_and_extents_lowmem(void)
 		if (ret)
 			goto out;
 next:
-		ret = btrfs_next_item(root1, &path);
+		ret = btrfs_next_item(root, &path);
 		if (ret)
 			goto out;
 	}
-- 
2.28.0

