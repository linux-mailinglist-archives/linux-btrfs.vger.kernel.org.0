Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 802961F2504
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jun 2020 01:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731641AbgFHXYh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jun 2020 19:24:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:50728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387508AbgFHXYf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 8 Jun 2020 19:24:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF1BC20899;
        Mon,  8 Jun 2020 23:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658674;
        bh=Ljoi6SPtp9BQsszabiJzv6FOpQKYVjz22TNrx7xiH/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ejASoqjemsbEHFaqD9mmmftna/M6mOvEPCS4OBNBUVuG331pa4Th9gdDRc6HJx/JG
         g2wZitxGYlHqIudqo6TYCXh+TD626p/vUYyaey4f7BFQ6AvnLT5O3wfGyKyjs3TAMh
         QVFW6h7pv6IP+Qyzqe7zgxug5hdSdi5qg78fxewQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>, linux-btrfs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 086/106] btrfs: qgroup: mark qgroup inconsistent if we're inherting snapshot to a new qgroup
Date:   Mon,  8 Jun 2020 19:22:18 -0400
Message-Id: <20200608232238.3368589-86-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232238.3368589-1-sashal@kernel.org>
References: <20200608232238.3368589-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit cbab8ade585a18c4334b085564d9d046e01a3f70 ]

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
check to determine if the new relation would break the existing
accounting.

Unlike btrfs_add_qgroup_relation(), which has proper check to determine
if we can do quick update without a rescan, in btrfs_qgroup_inherit() we
can even assign a snapshot to multiple qgroups.

[FIX]
Fix it by manually marking qgroup inconsistent for snapshot inheritance.

For subvolume creation, since all its extents are exclusively owned, we
don't need to rescan.

In theory, we should call relation check like quick_update_accounting()
when doing qgroup inheritance and inform user about qgroup accounting
inconsistency.

But we don't have good mechanism to relay that back to the user in the
snapshot creation context, thus we can only silently mark the qgroup
inconsistent.

Anyway, user shouldn't use qgroup inheritance during snapshot creation,
and should add qgroup relationship after snapshot creation by 'btrfs
qgroup assign', which has a much better UI to inform user about qgroup
inconsistent and kick in rescan automatically.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/qgroup.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index cbd40826f5dc..c8ed4db73b84 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2259,6 +2259,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 	struct btrfs_root *quota_root;
 	struct btrfs_qgroup *srcgroup;
 	struct btrfs_qgroup *dstgroup;
+	bool need_rescan = false;
 	u32 level_size = 0;
 	u64 nums;
 
@@ -2402,6 +2403,13 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
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
@@ -2421,6 +2429,9 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 
 		dst->rfer = src->rfer - level_size;
 		dst->rfer_cmpr = src->rfer_cmpr - level_size;
+
+		/* Manually tweaking numbers certainly needs a rescan */
+		need_rescan = true;
 	}
 	for (i = 0; i <  inherit->num_excl_copies; ++i, i_qgroups += 2) {
 		struct btrfs_qgroup *src;
@@ -2439,6 +2450,7 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 
 		dst->excl = src->excl + level_size;
 		dst->excl_cmpr = src->excl_cmpr + level_size;
+		need_rescan = true;
 	}
 
 unlock:
@@ -2446,6 +2458,8 @@ int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 out:
 	if (!committing)
 		mutex_unlock(&fs_info->qgroup_ioctl_lock);
+	if (need_rescan)
+		fs_info->qgroup_flags |= BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT;
 	return ret;
 }
 
-- 
2.25.1

