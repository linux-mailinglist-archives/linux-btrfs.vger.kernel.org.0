Return-Path: <linux-btrfs+bounces-3651-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6523A88DEBF
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 13:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87A9B1C26A8F
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 12:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EDB12F5AF;
	Wed, 27 Mar 2024 12:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXWGIEe1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE77013A275;
	Wed, 27 Mar 2024 12:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541334; cv=none; b=AbX1KrNTUTklYiaIv7zx5YynHIT8WhPX/33UYzB7/o0jua617oZuag0JatNh6hqIzyZSngkPnVJqymQjnYYvRrN6hxryIyy/O9RpAgG32B9lf+jm1oXhRWVpC1BpDjg/SwMfcq0em0HKHPIb0GMMqhrVSkeycA68y9ANSyiydow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541334; c=relaxed/simple;
	bh=qCIfrQv6L/NmySDUQJa7UGmqVlyWT+qWBMeAk9rSuEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mc6wmSh7G123xB+reJOJ6nUyA5AXzd3TUN6Eb8tEH6zZyW7mw2iY6fcD4hjwC8rnESuLAoCdR6a2INbzslK+AfNoTmgldIKNYmvjL+vqtdx4XhI9Vzg5XTNj+eWNQVTBS41Dspphl+ajlr/S7JaqGwnd9bSJaWIfOEpQ6/9prKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXWGIEe1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32687C433C7;
	Wed, 27 Mar 2024 12:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541333;
	bh=qCIfrQv6L/NmySDUQJa7UGmqVlyWT+qWBMeAk9rSuEg=;
	h=From:To:Cc:Subject:Date:From;
	b=qXWGIEe14SXcPJL1cGWSYMWp4KT4M82PDXLZZf2GCCHuaxil1kbDTSUAIoCM/nT9F
	 t+BTNf9PjVtrgPv/NxR4B6t2flV1xznhTja6THvCtjuuN9VuJpkLHxcNgeTwzXQLxX
	 O/bxD2GLBhCSYAssKBYOMfRF5AFDRa/nkluuq5NiT03YASOGZ6F1u3EChIodhlEvDM
	 cPP6B9QpZo+YcGW7an18fwfbsA2dpURnXHZMbbOwL6rKANwNGBtZKl3XrTngsFTAk4
	 Fjko5VbM0w/+S08+pH2HJ9WKN/xC3pxIVzPhVUwZkVmXPAF1/pJjjC5aPSK2z6WlBS
	 CtUATXatH7Zag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	wqu@suse.com
Cc: David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "btrfs: qgroup: validate btrfs_qgroup_inherit parameter" failed to apply to 6.7-stable tree
Date: Wed, 27 Mar 2024 08:08:51 -0400
Message-ID: <20240327120852.2826572-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.7-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 86211eea8ae1676cc819d2b4fdc8d995394be07d Mon Sep 17 00:00:00 2001
From: Qu Wenruo <wqu@suse.com>
Date: Tue, 27 Feb 2024 13:45:35 +1030
Subject: [PATCH] btrfs: qgroup: validate btrfs_qgroup_inherit parameter

[BUG]
Currently btrfs can create subvolume with an invalid qgroup inherit
without triggering any error:

  # mkfs.btrfs -O quota -f $dev
  # mount $dev $mnt
  # btrfs subvolume create -i 2/0 $mnt/subv1
  # btrfs qgroup show -prce --sync $mnt
  Qgroupid    Referenced    Exclusive   Path
  --------    ----------    ---------   ----
  0/5           16.00KiB     16.00KiB   <toplevel>
  0/256         16.00KiB     16.00KiB   subv1

[CAUSE]
We only do a very basic size check for btrfs_qgroup_inherit structure,
but never really verify if the values are correct.

Thus in btrfs_qgroup_inherit() function, we have to skip non-existing
qgroups, and never return any error.

[FIX]
Fix the behavior and introduce extra checks:

- Introduce early check for btrfs_qgroup_inherit structure
  Not only the size, but also all the qgroup ids would be verified.

  And the timing is very early, so we can return error early.
  This early check is very important for snapshot creation, as snapshot
  is delayed to transaction commit.

- Drop support for btrfs_qgroup_inherit::num_ref_copies and
  num_excl_copies
  Those two members are used to specify to copy refr/excl numbers from
  other qgroups.
  This would definitely mark qgroup inconsistent, and btrfs-progs has
  dropped the support for them for a long time.
  It's time to drop the support for kernel.

- Verify the supported btrfs_qgroup_inherit::flags
  Just in case we want to add extra flags for btrfs_qgroup_inherit.

Now above subvolume creation would fail with -ENOENT other than silently
ignore the non-existing qgroup.

CC: stable@vger.kernel.org # 6.7+
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c           | 16 +++---------
 fs/btrfs/qgroup.c          | 51 ++++++++++++++++++++++++++++++++++++++
 fs/btrfs/qgroup.h          |  3 +++
 include/uapi/linux/btrfs.h |  1 +
 4 files changed, 58 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 29e2b8e233637..38459a89b27c4 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1382,7 +1382,7 @@ static noinline int btrfs_ioctl_snap_create_v2(struct file *file,
 	if (vol_args->flags & BTRFS_SUBVOL_RDONLY)
 		readonly = true;
 	if (vol_args->flags & BTRFS_SUBVOL_QGROUP_INHERIT) {
-		u64 nums;
+		struct btrfs_fs_info *fs_info = inode_to_fs_info(file_inode(file));
 
 		if (vol_args->size < sizeof(*inherit) ||
 		    vol_args->size > PAGE_SIZE) {
@@ -1395,19 +1395,9 @@ static noinline int btrfs_ioctl_snap_create_v2(struct file *file,
 			goto free_args;
 		}
 
-		if (inherit->num_qgroups > PAGE_SIZE ||
-		    inherit->num_ref_copies > PAGE_SIZE ||
-		    inherit->num_excl_copies > PAGE_SIZE) {
-			ret = -EINVAL;
-			goto free_inherit;
-		}
-
-		nums = inherit->num_qgroups + 2 * inherit->num_ref_copies +
-		       2 * inherit->num_excl_copies;
-		if (vol_args->size != struct_size(inherit, qgroups, nums)) {
-			ret = -EINVAL;
+		ret = btrfs_qgroup_check_inherit(fs_info, inherit, vol_args->size);
+		if (ret < 0)
 			goto free_inherit;
-		}
 	}
 
 	ret = __btrfs_ioctl_snap_create(file, file_mnt_idmap(file),
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index b3bf08fc2a396..af241aaa654a2 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -3046,6 +3046,57 @@ int btrfs_run_qgroups(struct btrfs_trans_handle *trans)
 	return ret;
 }
 
+int btrfs_qgroup_check_inherit(struct btrfs_fs_info *fs_info,
+			       struct btrfs_qgroup_inherit *inherit,
+			       size_t size)
+{
+	if (inherit->flags & ~BTRFS_QGROUP_INHERIT_FLAGS_SUPP)
+		return -EOPNOTSUPP;
+	if (size < sizeof(*inherit) || size > PAGE_SIZE)
+		return -EINVAL;
+
+	/*
+	 * In the past we allowed btrfs_qgroup_inherit to specify to copy
+	 * rfer/excl numbers directly from other qgroups.  This behavior has
+	 * been disabled in userspace for a very long time, but here we should
+	 * also disable it in kernel, as this behavior is known to mark qgroup
+	 * inconsistent, and a rescan would wipe out the changes anyway.
+	 *
+	 * Reject any btrfs_qgroup_inherit with num_ref_copies or num_excl_copies.
+	 */
+	if (inherit->num_ref_copies > 0 || inherit->num_excl_copies > 0)
+		return -EINVAL;
+
+	if (inherit->num_qgroups > PAGE_SIZE)
+		return -EINVAL;
+
+	if (size != struct_size(inherit, qgroups, inherit->num_qgroups))
+		return -EINVAL;
+
+	/*
+	 * Now check all the remaining qgroups, they should all:
+	 *
+	 * - Exist
+	 * - Be higher level qgroups.
+	 */
+	for (int i = 0; i < inherit->num_qgroups; i++) {
+		struct btrfs_qgroup *qgroup;
+		u64 qgroupid = inherit->qgroups[i];
+
+		if (btrfs_qgroup_level(qgroupid) == 0)
+			return -EINVAL;
+
+		spin_lock(&fs_info->qgroup_lock);
+		qgroup = find_qgroup_rb(fs_info, qgroupid);
+		if (!qgroup) {
+			spin_unlock(&fs_info->qgroup_lock);
+			return -ENOENT;
+		}
+		spin_unlock(&fs_info->qgroup_lock);
+	}
+	return 0;
+}
+
 static int qgroup_auto_inherit(struct btrfs_fs_info *fs_info,
 			       u64 inode_rootid,
 			       struct btrfs_qgroup_inherit **inherit)
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 1f664261c064e..706640be0ec24 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -350,6 +350,9 @@ int btrfs_qgroup_account_extent(struct btrfs_trans_handle *trans, u64 bytenr,
 				struct ulist *new_roots);
 int btrfs_qgroup_account_extents(struct btrfs_trans_handle *trans);
 int btrfs_run_qgroups(struct btrfs_trans_handle *trans);
+int btrfs_qgroup_check_inherit(struct btrfs_fs_info *fs_info,
+			       struct btrfs_qgroup_inherit *inherit,
+			       size_t size);
 int btrfs_qgroup_inherit(struct btrfs_trans_handle *trans, u64 srcid,
 			 u64 objectid, u64 inode_rootid,
 			 struct btrfs_qgroup_inherit *inherit);
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index f8bc34a6bcfa2..cdf6ad872149c 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -92,6 +92,7 @@ struct btrfs_qgroup_limit {
  * struct btrfs_qgroup_inherit.flags
  */
 #define BTRFS_QGROUP_INHERIT_SET_LIMITS	(1ULL << 0)
+#define BTRFS_QGROUP_INHERIT_FLAGS_SUPP (BTRFS_QGROUP_INHERIT_SET_LIMITS)
 
 struct btrfs_qgroup_inherit {
 	__u64	flags;
-- 
2.43.0





