Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 103C16E136
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2019 08:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfGSGv4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 19 Jul 2019 02:51:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:38666 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727102AbfGSGvw (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 19 Jul 2019 02:51:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 91F16AEF7
        for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2019 06:51:51 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 3/4] btrfs: extent-tree: Add comment for inc_block_group_ro()
Date:   Fri, 19 Jul 2019 14:51:43 +0800
Message-Id: <20190719065144.15263-4-wqu@suse.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190719065144.15263-1-wqu@suse.com>
References: <20190719065144.15263-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

inc_block_group_ro() is only designed to mark one block group read-only,
it doesn't really care if other block groups have enough free space to
contain the used space in the block group.

However due to the close connection between this function and
relocation, sometimes we can be confused and think this function is
responsible for balance space reservation, which is not true.

Add some comment to make the functionality clear.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent-tree.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5faf057f6f37..156ef906885f 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -9586,6 +9586,19 @@ static u64 update_block_group_flags(struct btrfs_fs_info *fs_info, u64 flags)
 	return flags;
 }
 
+/*
+ * Mark block group @cache read-only, so later write won't happen to block
+ * group @cache.
+ *
+ * If @force is not set, this function will only mark the block group readonly
+ * if we have enough free space (1M) in other metadata/system block groups.
+ * If @force is not set, this function will mark the block group readonly
+ * without checking free space.
+ *
+ * NOTE: This function doesn't care if other block groups can contain all the
+ * data in this block group. That check should be done by relocation routine,
+ * not this function.
+ */
 static int inc_block_group_ro(struct btrfs_block_group_cache *cache, int force)
 {
 	struct btrfs_space_info *sinfo = cache->space_info;
@@ -9619,6 +9632,12 @@ static int inc_block_group_ro(struct btrfs_block_group_cache *cache, int force)
 		    cache->bytes_super - btrfs_block_group_used(&cache->item);
 	sinfo_used = btrfs_space_info_used(sinfo, true);
 
+	/*
+	 * sinfo_used + num_bytes should always <= sinfo->total_bytes.
+	 *
+	 * Here we make sure if we mark this bg RO, we still have enough
+	 * free space as buffer (if min_allocable_bytes is not 0).
+	 */
 	if (sinfo_used + num_bytes + min_allocable_bytes <=
 	    sinfo->total_bytes) {
 		sinfo->bytes_readonly += num_bytes;
-- 
2.22.0

