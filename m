Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5325ADA3E8
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 04:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387681AbfJQCip (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Oct 2019 22:38:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:59860 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727233AbfJQCio (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Oct 2019 22:38:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7B890B1EE
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Oct 2019 02:38:43 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 1/2] btrfs: qgroup: Fix wrong parameter order for trace events
Date:   Thu, 17 Oct 2019 10:38:36 +0800
Message-Id: <20191017023837.32264-2-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191017023837.32264-1-wqu@suse.com>
References: <20191017023837.32264-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
For btrfs:qgroup_meta_reserve event, the trace event can output garbage:
qgroup_meta_reserve: 9c7f6acc-b342-4037-bc47-7f6e4d2232d7: refroot=5(FS_TREE) type=DATA diff=2

The diff should always be alinged to sector size (4k), so there is
definitely something wrong.

[CAUSE]
For the wrong @diff, it's caused by wrong parameter order.
The correct parameters are:
  struct btrfs_root, s64 diff, int type.

However the parameters used are:
  struct btrfs_root, int type, s64 diff.

[FIX]
Fix the super stupid bug.

Fixes: 4ee0d8832c2e ("btrfs: qgroup: Update trace events for metadata reservation")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index c4bb69941c77..3ad151655eb8 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3629,7 +3629,7 @@ int __btrfs_qgroup_reserve_meta(struct btrfs_root *root, int num_bytes,
 		return 0;
 
 	BUG_ON(num_bytes != round_down(num_bytes, fs_info->nodesize));
-	trace_qgroup_meta_reserve(root, type, (s64)num_bytes);
+	trace_qgroup_meta_reserve(root, (s64)num_bytes, type);
 	ret = qgroup_reserve(root, num_bytes, enforce, type);
 	if (ret < 0)
 		return ret;
@@ -3676,7 +3676,7 @@ void __btrfs_qgroup_free_meta(struct btrfs_root *root, int num_bytes,
 	 */
 	num_bytes = sub_root_meta_rsv(root, num_bytes, type);
 	BUG_ON(num_bytes != round_down(num_bytes, fs_info->nodesize));
-	trace_qgroup_meta_reserve(root, type, -(s64)num_bytes);
+	trace_qgroup_meta_reserve(root, -(s64)num_bytes, type);
 	btrfs_qgroup_free_refroot(fs_info, root->root_key.objectid,
 				  num_bytes, type);
 }
-- 
2.23.0

