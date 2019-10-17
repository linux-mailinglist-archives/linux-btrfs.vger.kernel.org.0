Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51EE1DA3A7
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Oct 2019 04:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733042AbfJQCXg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Oct 2019 22:23:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:55420 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727328AbfJQCXg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Oct 2019 22:23:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 87BE6B235;
        Thu, 17 Oct 2019 02:23:33 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: [PATCH v2] btrfs: qgroup: Fix wrong parameter order for trace events
Date:   Thu, 17 Oct 2019 10:23:29 +0800
Message-Id: <20191017022329.31545-1-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
For btrfs:qgroup_meta_reserve event, the trace event can output garbage:
qgroup_meta_reserve: 9c7f6acc-b342-4037-bc47-7f6e4d2232d7: refroot=5(FS_TREE) type=DATA diff=2
qgroup_meta_reserve: 9c7f6acc-b342-4037-bc47-7f6e4d2232d7: refroot=5(FS_TREE) type=0x258792 diff=2

Since we're in qgroup_meta_reserve() trace event, the @type should never
be DATA, while diff must be aligned to sectorsize (4K in this case).

Only UUID and refroot is correct.

[CAUSE]
There are two causes for this bug:

- Bad parameter order
  For trace event btrfs:qgroup_meta_reserve, we're passing wrong
  parameters.

  The correct parameters are:
  struct btrfs_root, s64 diff, int type.

  However the used order is:
  struct btrfs_root, int type, s64 diff.

- @type is not even assigned
  What I was doing !? /facepalm

[FIX]
Fix the super stupid bug.

Now everything works fine:
qgroup_meta_reserve: 0477ad60-9aeb-4040-8a03-1900844d46ba: refroot=5(FS_TREE) type=META_PERTRANS diff=81920
qgroup_meta_reserve: 0477ad60-9aeb-4040-8a03-1900844d46ba: refroot=5(FS_TREE) type=META_PREALLOC diff=16384
qgroup_meta_reserve: 0477ad60-9aeb-4040-8a03-1900844d46ba: refroot=5(FS_TREE) type=META_PREALLOC diff=0
qgroup_meta_reserve: 0477ad60-9aeb-4040-8a03-1900844d46ba: refroot=5(FS_TREE) type=META_PREALLOC diff=16384
qgroup_meta_reserve: 0477ad60-9aeb-4040-8a03-1900844d46ba: refroot=5(FS_TREE) type=META_PREALLOC diff=-16384
qgroup_meta_reserve: 0477ad60-9aeb-4040-8a03-1900844d46ba: refroot=5(FS_TREE) type=META_PREALLOC diff=16384
qgroup_meta_reserve: 0477ad60-9aeb-4040-8a03-1900844d46ba: refroot=5(FS_TREE) type=META_PREALLOC diff=-16384
qgroup_meta_reserve: 0477ad60-9aeb-4040-8a03-1900844d46ba: refroot=5(FS_TREE) type=META_PREALLOC diff=16384
qgroup_meta_reserve: 0477ad60-9aeb-4040-8a03-1900844d46ba: refroot=5(FS_TREE) type=META_PREALLOC diff=-16384

Fixes: 4ee0d8832c2e ("btrfs: qgroup: Update trace events for metadata reservation")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Use more accurate comment about the fintuning options
- Use more elegant method to output uuid
---
 fs/btrfs/qgroup.c            | 4 ++--
 include/trace/events/btrfs.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

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
diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 5df604de4f11..0ebcaa153f93 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -1710,6 +1710,7 @@ TRACE_EVENT(qgroup_meta_reserve,
 	TP_fast_assign_btrfs(root->fs_info,
 		__entry->refroot	= root->root_key.objectid;
 		__entry->diff		= diff;
+		__entry->type		= type;
 	),
 
 	TP_printk_btrfs("refroot=%llu(%s) type=%s diff=%lld",
-- 
2.23.0

