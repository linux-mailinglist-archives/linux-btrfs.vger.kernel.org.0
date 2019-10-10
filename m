Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4B4FD2D44
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2019 17:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbfJJPGw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Oct 2019 11:06:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:53134 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725991AbfJJPGw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Oct 2019 11:06:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7FC91B1AD;
        Thu, 10 Oct 2019 15:06:50 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 2/3] btrfs: Don't use objectid_mutex during mount
Date:   Thu, 10 Oct 2019 18:06:46 +0300
Message-Id: <20191010150647.20940-3-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191010150647.20940-1-nborisov@suse.com>
References: <20191010150647.20940-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Since the filesystem is not well formed and no trees are loaded it's
pointless holding the objectid_mutex. Just remove its usage.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/disk-io.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index b850988023aa..72580eb6b706 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2603,17 +2603,14 @@ int __cold init_tree_roots(struct btrfs_fs_info *fs_info)
 		tree_root->commit_root = btrfs_root_node(tree_root);
 		btrfs_set_root_refs(&tree_root->root_item, 1);
 
-		mutex_lock(&tree_root->objectid_mutex);
 		ret = btrfs_find_highest_objectid(tree_root,
 						&tree_root->highest_objectid);
 		if (ret) {
-			mutex_unlock(&tree_root->objectid_mutex);
 			handle_error = true;
 			continue;
 		}
 
 		ASSERT(tree_root->highest_objectid <= BTRFS_LAST_FREE_OBJECTID);
-		mutex_unlock(&tree_root->objectid_mutex);
 
 		ret = btrfs_read_roots(fs_info);
 		if (ret) {
-- 
2.17.1

