Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6FF2524D1
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Aug 2020 02:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHZArm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Aug 2020 20:47:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:45252 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbgHZArm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Aug 2020 20:47:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4CF24B024
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Aug 2020 00:48:11 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs-progs: fix compile warning due to global fs_info cleanup
Date:   Wed, 26 Aug 2020 08:47:33 +0800
Message-Id: <20200826004734.89905-2-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200826004734.89905-1-wqu@suse.com>
References: <20200826004734.89905-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
Compiler gives the following warning:

  check/main.c: In function 'check_chunks_and_extents':
  check/main.c:8712:30: warning: assignment to 'int (*)(struct btrfs_fs_info *, u64,  u64,  u64,  u64,  u64,  u64,  int)' {aka 'int (*)(struct btrfs_fs_info *, long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  int)'} from incompatible pointer type 'int (*)(u64,  u64,  u64,  u64,  u64,  u64,  int)' {aka 'int (*)(long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  long long unsigned int,  int)'} [-Wincompatible-pointer-types]
   8712 |   gfs_info->free_extent_hook = free_extent_hook;

And obviously, this would screwup original mode repair.

[CAUSE]
Commit b91222b3 ("btrfs-progs: check: drop unused fs_info") removes the
fs_info parameter for free_extent_hook(), but didn't remove the
parameter for the definition.

[FIX]
Also remove the fs_info parameter for the hook definition.

Fixes: b91222b3 ("btrfs-progs: check: drop unused fs_info")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 kernel-shared/ctree.h       | 3 +--
 kernel-shared/extent-tree.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
index 78d268e226fd..7683b8bbf0b4 100644
--- a/kernel-shared/ctree.h
+++ b/kernel-shared/ctree.h
@@ -1201,8 +1201,7 @@ struct btrfs_fs_info {
 
 	int transaction_aborted;
 
-	int (*free_extent_hook)(struct btrfs_fs_info *fs_info,
-				u64 bytenr, u64 num_bytes, u64 parent,
+	int (*free_extent_hook)(u64 bytenr, u64 num_bytes, u64 parent,
 				u64 root_objectid, u64 owner, u64 offset,
 				int refs_to_drop);
 	struct cache_tree *fsck_extent_cache;
diff --git a/kernel-shared/extent-tree.c b/kernel-shared/extent-tree.c
index e29ff433196f..5b1fbe10283a 100644
--- a/kernel-shared/extent-tree.c
+++ b/kernel-shared/extent-tree.c
@@ -1921,7 +1921,7 @@ static int __free_extent(struct btrfs_trans_handle *trans,
 		btrfs_fs_incompat(extent_root->fs_info, SKINNY_METADATA);
 
 	if (trans->fs_info->free_extent_hook) {
-		trans->fs_info->free_extent_hook(trans->fs_info, bytenr, num_bytes,
+		trans->fs_info->free_extent_hook(bytenr, num_bytes,
 						parent, root_objectid, owner_objectid,
 						owner_offset, refs_to_drop);
 
-- 
2.28.0

