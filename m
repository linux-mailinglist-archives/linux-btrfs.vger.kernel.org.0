Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D01E519BBC2
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Apr 2020 08:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgDBGhm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Apr 2020 02:37:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:47896 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726214AbgDBGhm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Apr 2020 02:37:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B8084AC22
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Apr 2020 06:37:39 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: qgroup: Mark qgroup inconsistent if we're inherting snapshot to a new qgroup
Date:   Thu,  2 Apr 2020 14:37:35 +0800
Message-Id: <20200402063735.32808-1-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
For the following operation, qgroup is guaranteed to be screwed up due
to snapshot adding to a new qgroup:

  # mkfs.btrfs -f $dev
  # mount $dev $mnt
  # btrfs qgroup en $mnt
  # btrfs subv create $mnt/src
  # xfs_io -f -c "pwrite 0 1m" $mnt/src/file
  # sync
  # btrfs qgroup create 1/0 $mnt/src
  # btrfs subv snapshot -i 1/0 $mnt/src $mnt/snapshot
  # btrfs qgroup show -prce $mnt/src
  qgroupid         rfer         excl     max_rfer     max_excl parent  child
  --------         ----         ----     --------     -------- ------  -----
  0/5          16.00KiB     16.00KiB         none         none ---     ---
  0/257         1.02MiB     16.00KiB         none         none ---     ---
  0/258         1.02MiB     16.00KiB         none         none 1/0     ---
  1/0             0.00B        0.00B         none         none ---     0/258
	        ^^^^^^^^^^^^^^^^^^^^

[CAUSE]
The problem is in btrfs_qgroup_inherit(), we don't have good enough
check to determine if the new relation ship would break the existing
accounting.

Unlike btrfs_add_qgroup_relation(), which has proper check to determine
if we can do quick update without a rescan, in btrfs_qgroup_inherit() we
can even assign a snapshot to multiple qgroups.

[FIX]
Fix the problem by manually marking qgroup inconsistent for snapshot
inheritance.

For subvolume creation, since all its extents are exclusively owned by
itself, we don't need to rescan.

In theory, we should call relationship check like quick_update_accounting()
when doing qgroup inheritance and inform user about qgroup inconsistent.

But we don't have good enough mechanism to inform user in the snapshot
creation context, thus we can only silently mark the qgroup
inconsistent.

Anyway, user shouldn't use qgroup inheritance during snapshot creation,
and should add qgroup relationship after snapshot creation by 'btrfs
qgroup assign', which has a much better UI to inform user about qgroup
inconsistent and kick in rescan automatically.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/qgroup.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index c3888fb367e7..81b2efca48b4 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2622,6 +2622,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 	struct btrfs_root *quota_root;
 	struct btrfs_qgroup *srcgroup;
 	struct btrfs_qgroup *dstgroup;
+	bool need_rescan = false;
 	u32 level_size = 0;
 	u64 nums;
 
@@ -2765,6 +2766,13 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 				goto unlock;
 		}
 		++i_qgroups;
+
+		/*
+		 * If we're doing a snapshot, and adding the snapshot to a new
+		 * qgroup, the numbers are guaranteed to be incorrect.
+		 */
+		if (srcid)
+			need_rescan = true;
 	}
 
 	for (i = 0; i <  inherit->num_ref_copies; ++i, i_qgroups += 2) {
@@ -2784,6 +2792,9 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 
 		dst->rfer = src->rfer - level_size;
 		dst->rfer_cmpr = src->rfer_cmpr - level_size;
+
+		/* Manually tweaking numbers? No way to keep qgroup sane */
+		need_rescan = true;
 	}
 	for (i = 0; i <  inherit->num_excl_copies; ++i, i_qgroups += 2) {
 		struct btrfs_qgroup *src;
@@ -2802,6 +2813,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 
 		dst->excl = src->excl + level_size;
 		dst->excl_cmpr = src->excl_cmpr + level_size;
+		need_rescan = true;
 	}
 
 unlock:
@@ -2809,6 +2821,8 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 out:
 	if (!committing)
 		mutex_unlock(&fs_info->qgroup_ioctl_lock);
+	if (need_rescan)
+		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
 	return ret;
 }
 
-- 
2.26.0

