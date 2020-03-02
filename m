Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C579175851
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2020 11:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgCBK33 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 2 Mar 2020 05:29:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:39372 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbgCBK33 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 2 Mar 2020 05:29:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 89746ABDE;
        Mon,  2 Mar 2020 10:29:26 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs: Rename __btrfs_alloc_chunk to btrfs_alloc_chunk
Date:   Mon,  2 Mar 2020 12:29:25 +0200
Message-Id: <20200302102925.359-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Having btrfs_alloc_chunk doesn't bring any value since it
encapsulates a lockdep assert and a call to find_next_chunk. Simply
rename the internal __btrfs_alloc_chunk function to the public one
and remove it's 2nd parameter as all callers always pass the return
value of find_next_chunk. Finally, migrate the call to
lockdep_assert_held so as to not lose the check.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/volumes.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 37e79de3256f..267847c72c22 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5113,8 +5113,7 @@ static int create_chunk(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
-			       u64 start, u64 type)
+int btrfs_alloc_chunk(struct btrfs_trans_handle *trans, u64 type)
 {
 	struct btrfs_fs_info *info = trans->fs_info;
 	struct btrfs_fs_devices *fs_devices = info->fs_devices;
@@ -5122,6 +5121,8 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	struct alloc_chunk_ctl ctl;
 	int ret;
 
+	lockdep_assert_held(&info->chunk_mutex);
+
 	if (!alloc_profile_is_valid(type, 0)) {
 		ASSERT(0);
 		return -EINVAL;
@@ -5139,7 +5140,7 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 		return -EINVAL;
 	}
 
-	ctl.start = start;
+	ctl.start = find_next_chunk(info);
 	ctl.type = type;
 	init_alloc_chunk_ctl(fs_devices, &ctl);
 
@@ -5163,6 +5164,13 @@ static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
+/*
+ * Chunk allocation falls into two parts. The first part does work
+ * that makes the new allocated chunk usable, but does not do any operation
+ * that modifies the chunk tree. The second part does the work that
+ * requires modifying the chunk tree. This division is important for the
+ * bootstrap process of adding storage to a seed btrfs.
+ */
 int btrfs_finish_chunk_alloc(struct btrfs_trans_handle *trans,
 			     u64 chunk_offset, u64 chunk_size)
 {
@@ -5261,39 +5269,19 @@ int btrfs_finish_chunk_alloc(struct btrfs_trans_handle *trans,
 	return ret;
 }
 
-/*
- * Chunk allocation falls into two parts. The first part does work
- * that makes the new allocated chunk usable, but does not do any operation
- * that modifies the chunk tree. The second part does the work that
- * requires modifying the chunk tree. This division is important for the
- * bootstrap process of adding storage to a seed btrfs.
- */
-int btrfs_alloc_chunk(struct btrfs_trans_handle *trans, u64 type)
-{
-	u64 chunk_offset;
-
-	lockdep_assert_held(&trans->fs_info->chunk_mutex);
-	chunk_offset = find_next_chunk(trans->fs_info);
-	return __btrfs_alloc_chunk(trans, chunk_offset, type);
-}
-
 static noinline int init_first_rw_device(struct btrfs_trans_handle *trans)
 {
 	struct btrfs_fs_info *fs_info = trans->fs_info;
-	u64 chunk_offset;
-	u64 sys_chunk_offset;
 	u64 alloc_profile;
 	int ret;
 
-	chunk_offset = find_next_chunk(fs_info);
 	alloc_profile = btrfs_metadata_alloc_profile(fs_info);
-	ret = __btrfs_alloc_chunk(trans, chunk_offset, alloc_profile);
+	ret = btrfs_alloc_chunk(trans, alloc_profile);
 	if (ret)
 		return ret;
 
-	sys_chunk_offset = find_next_chunk(fs_info);
 	alloc_profile = btrfs_system_alloc_profile(fs_info);
-	ret = __btrfs_alloc_chunk(trans, sys_chunk_offset, alloc_profile);
+	ret = btrfs_alloc_chunk(trans, alloc_profile);
 	return ret;
 }
 
-- 
2.17.1

