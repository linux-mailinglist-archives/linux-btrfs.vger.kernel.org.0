Return-Path: <linux-btrfs+bounces-298-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A907F4E1B
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 18:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5B2EB20E59
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Nov 2023 17:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CD5958ABA;
	Wed, 22 Nov 2023 17:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="lAa4zHnj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EE2197
	for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:11 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-dae0ab8ac3eso21204276.0
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Nov 2023 09:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1700673490; x=1701278290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fc1jP1f2IupLr1kIYSPLSEVGQP7LjPerVE2u7Ks+ZiE=;
        b=lAa4zHnjojhWa1QwGYmyacMYOfmsMskCAYwUenCLCJIfFPRWLqe+2HKdODgVEGTb6b
         urQcSbvcup69NwomYGyQ0CbuawNnC46kRrb4d6+8EIo/U4MznZZ0HMJeLROowfp+9OHh
         zSDkEQTCdsUXpR3y3YYwE4+A05uER1uFFPddeoo5ahYEPSw3Q88oyKksb6y6blnyLoi6
         CkPxkZDRasfPqOM0hH45P+DGgDTBmpwetQgRXYIoN7f2lSaK2amIBuotQtx8aWcGfY1V
         P1jRRhlfqxz5BsPbInQDvTKrbCmMuqcT9iWusi0IvhNG9lOE3R/B8eRang2L9DbhprK7
         abog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673490; x=1701278290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fc1jP1f2IupLr1kIYSPLSEVGQP7LjPerVE2u7Ks+ZiE=;
        b=De7yqzDAgAOrgQTmrD1j3lSBc+7xez5DdGUiM8eooUH31ssifE4+2pb+BtIqSNZfZj
         OWH0MrVWMUWhhY+kcceCtxkR5M9znZCcZlu6Bfy1pi4rd2WLm6PP6PjpMoiAKWbyVRLp
         0DCJ2bgR8HHwA81ZhzdZskYiZgl3vw3xLfAfhwurwe5CDeeydA/y0X737kGT1gmviRD6
         djKSaWQfo4R6GhgNXButMv5+u/tshANmLGii47AFnTg5Ztuwpc9F8Qg8Byr+Qik2pZ/j
         oc16g6kzceZOre3Q930iiP4u8UORHwiIKeNh2HDfd2gd2J3/3kylYZvsORekioc1iJrL
         LJBw==
X-Gm-Message-State: AOJu0Yx+icSzXsbfqiZNBqUUqHmoDTTW0fLSYgIx1Zj5MJsFxmCXcrWk
	dZY9ESje+BVdZ7eBP2tz1//JWjlQaLzLpR1JSmOhsFF7
X-Google-Smtp-Source: AGHT+IFubRPRJ9wl4qrJfTD6gMjP//GVWJi9OSu/VdQUhO8dU/Ipac8OyCRu2/RT+5w/AlS+lm5tkQ==
X-Received: by 2002:a05:6902:533:b0:db3:fca3:76ea with SMTP id y19-20020a056902053300b00db3fca376eamr2814958ybs.0.1700673489897;
        Wed, 22 Nov 2023 09:18:09 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id t12-20020a056902018c00b00d81479172f8sm1444353ybh.5.2023.11.22.09.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:18:09 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v3 06/19] btrfs: split out ro->rw and rw->ro helpers into their own functions
Date: Wed, 22 Nov 2023 12:17:42 -0500
Message-ID: <8b209e6c48780284a2b7cfd4979783ab909b8011.1700673401.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1700673401.git.josef@toxicpanda.com>
References: <cover.1700673401.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When we remount ro->rw or rw->ro we have some cleanup tasks that have to
be managed.  Split these out into their own function to make
btrfs_remount smaller.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 233 ++++++++++++++++++++++++-----------------------
 1 file changed, 120 insertions(+), 113 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d3b66e9c2679..e4ac09bfe0fc 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -1676,6 +1676,119 @@ static inline void btrfs_remount_cleanup(struct btrfs_fs_info *fs_info,
 		btrfs_set_free_space_cache_v1_active(fs_info, cache_opt);
 }
 
+static int btrfs_remount_rw(struct btrfs_fs_info *fs_info)
+{
+	int ret;
+
+	if (BTRFS_FS_ERROR(fs_info)) {
+		btrfs_err(fs_info,
+			  "Remounting read-write after error is not allowed");
+		return -EINVAL;
+	}
+
+	if (fs_info->fs_devices->rw_devices == 0)
+		return -EACCES;
+
+	if (!btrfs_check_rw_degradable(fs_info, NULL)) {
+		btrfs_warn(fs_info,
+			   "too many missing devices, writable remount is not allowed");
+		return -EACCES;
+	}
+
+	if (btrfs_super_log_root(fs_info->super_copy) != 0) {
+		btrfs_warn(fs_info,
+			   "mount required to replay tree-log, cannot remount read-write");
+		return -EINVAL;
+	}
+
+	/*
+	 * NOTE: when remounting with a change that does writes, don't put it
+	 * anywhere above this point, as we are not sure to be safe to write
+	 * until we pass the above checks.
+	 */
+	ret = btrfs_start_pre_rw_mount(fs_info);
+	if (ret)
+		return ret;
+
+	btrfs_clear_sb_rdonly(fs_info->sb);
+
+	set_bit(BTRFS_FS_OPEN, &fs_info->flags);
+
+	/*
+	 * If we've gone from readonly -> read/write, we need to get our
+	 * sync/async discard lists in the right state.
+	 */
+	btrfs_discard_resume(fs_info);
+
+	return 0;
+}
+
+static int btrfs_remount_ro(struct btrfs_fs_info *fs_info)
+{
+	/*
+	 * this also happens on 'umount -rf' or on shutdown, when
+	 * the filesystem is busy.
+	 */
+	cancel_work_sync(&fs_info->async_reclaim_work);
+	cancel_work_sync(&fs_info->async_data_reclaim_work);
+
+	btrfs_discard_cleanup(fs_info);
+
+	/* wait for the uuid_scan task to finish */
+	down(&fs_info->uuid_tree_rescan_sem);
+	/* avoid complains from lockdep et al. */
+	up(&fs_info->uuid_tree_rescan_sem);
+
+	btrfs_set_sb_rdonly(fs_info->sb);
+
+	/*
+	 * Setting SB_RDONLY will put the cleaner thread to
+	 * sleep at the next loop if it's already active.
+	 * If it's already asleep, we'll leave unused block
+	 * groups on disk until we're mounted read-write again
+	 * unless we clean them up here.
+	 */
+	btrfs_delete_unused_bgs(fs_info);
+
+	/*
+	 * The cleaner task could be already running before we set the
+	 * flag BTRFS_FS_STATE_RO (and SB_RDONLY in the superblock).
+	 * We must make sure that after we finish the remount, i.e. after
+	 * we call btrfs_commit_super(), the cleaner can no longer start
+	 * a transaction - either because it was dropping a dead root,
+	 * running delayed iputs or deleting an unused block group (the
+	 * cleaner picked a block group from the list of unused block
+	 * groups before we were able to in the previous call to
+	 * btrfs_delete_unused_bgs()).
+	 */
+	wait_on_bit(&fs_info->flags, BTRFS_FS_CLEANER_RUNNING,
+		    TASK_UNINTERRUPTIBLE);
+
+	/*
+	 * We've set the superblock to RO mode, so we might have made
+	 * the cleaner task sleep without running all pending delayed
+	 * iputs. Go through all the delayed iputs here, so that if an
+	 * unmount happens without remounting RW we don't end up at
+	 * finishing close_ctree() with a non-empty list of delayed
+	 * iputs.
+	 */
+	btrfs_run_delayed_iputs(fs_info);
+
+	btrfs_dev_replace_suspend_for_unmount(fs_info);
+	btrfs_scrub_cancel(fs_info);
+	btrfs_pause_balance(fs_info);
+
+	/*
+	 * Pause the qgroup rescan worker if it is running. We don't want
+	 * it to be still running after we are in RO mode, as after that,
+	 * by the time we unmount, it might have left a transaction open,
+	 * so we would leak the transaction and/or crash.
+	 */
+	btrfs_qgroup_wait_for_completion(fs_info, false);
+
+	return btrfs_commit_super(fs_info);
+}
+
 static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
@@ -1729,120 +1842,14 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 		}
 	}
 
-	if ((bool)(*flags & SB_RDONLY) == sb_rdonly(sb))
-		goto out;
+	ret = 0;
+	if (!sb_rdonly(sb) && (*flags & SB_RDONLY))
+		ret = btrfs_remount_ro(fs_info);
+	else if (sb_rdonly(sb) && !(*flags & SB_RDONLY))
+		ret = btrfs_remount_rw(fs_info);
+	if (ret)
+		goto restore;
 
-	if (*flags & SB_RDONLY) {
-		/*
-		 * this also happens on 'umount -rf' or on shutdown, when
-		 * the filesystem is busy.
-		 */
-		cancel_work_sync(&fs_info->async_reclaim_work);
-		cancel_work_sync(&fs_info->async_data_reclaim_work);
-
-		btrfs_discard_cleanup(fs_info);
-
-		/* wait for the uuid_scan task to finish */
-		down(&fs_info->uuid_tree_rescan_sem);
-		/* avoid complains from lockdep et al. */
-		up(&fs_info->uuid_tree_rescan_sem);
-
-		btrfs_set_sb_rdonly(sb);
-
-		/*
-		 * Setting SB_RDONLY will put the cleaner thread to
-		 * sleep at the next loop if it's already active.
-		 * If it's already asleep, we'll leave unused block
-		 * groups on disk until we're mounted read-write again
-		 * unless we clean them up here.
-		 */
-		btrfs_delete_unused_bgs(fs_info);
-
-		/*
-		 * The cleaner task could be already running before we set the
-		 * flag BTRFS_FS_STATE_RO (and SB_RDONLY in the superblock).
-		 * We must make sure that after we finish the remount, i.e. after
-		 * we call btrfs_commit_super(), the cleaner can no longer start
-		 * a transaction - either because it was dropping a dead root,
-		 * running delayed iputs or deleting an unused block group (the
-		 * cleaner picked a block group from the list of unused block
-		 * groups before we were able to in the previous call to
-		 * btrfs_delete_unused_bgs()).
-		 */
-		wait_on_bit(&fs_info->flags, BTRFS_FS_CLEANER_RUNNING,
-			    TASK_UNINTERRUPTIBLE);
-
-		/*
-		 * We've set the superblock to RO mode, so we might have made
-		 * the cleaner task sleep without running all pending delayed
-		 * iputs. Go through all the delayed iputs here, so that if an
-		 * unmount happens without remounting RW we don't end up at
-		 * finishing close_ctree() with a non-empty list of delayed
-		 * iputs.
-		 */
-		btrfs_run_delayed_iputs(fs_info);
-
-		btrfs_dev_replace_suspend_for_unmount(fs_info);
-		btrfs_scrub_cancel(fs_info);
-		btrfs_pause_balance(fs_info);
-
-		/*
-		 * Pause the qgroup rescan worker if it is running. We don't want
-		 * it to be still running after we are in RO mode, as after that,
-		 * by the time we unmount, it might have left a transaction open,
-		 * so we would leak the transaction and/or crash.
-		 */
-		btrfs_qgroup_wait_for_completion(fs_info, false);
-
-		ret = btrfs_commit_super(fs_info);
-		if (ret)
-			goto restore;
-	} else {
-		if (BTRFS_FS_ERROR(fs_info)) {
-			btrfs_err(fs_info,
-				"Remounting read-write after error is not allowed");
-			ret = -EINVAL;
-			goto restore;
-		}
-		if (fs_info->fs_devices->rw_devices == 0) {
-			ret = -EACCES;
-			goto restore;
-		}
-
-		if (!btrfs_check_rw_degradable(fs_info, NULL)) {
-			btrfs_warn(fs_info,
-		"too many missing devices, writable remount is not allowed");
-			ret = -EACCES;
-			goto restore;
-		}
-
-		if (btrfs_super_log_root(fs_info->super_copy) != 0) {
-			btrfs_warn(fs_info,
-		"mount required to replay tree-log, cannot remount read-write");
-			ret = -EINVAL;
-			goto restore;
-		}
-
-		/*
-		 * NOTE: when remounting with a change that does writes, don't
-		 * put it anywhere above this point, as we are not sure to be
-		 * safe to write until we pass the above checks.
-		 */
-		ret = btrfs_start_pre_rw_mount(fs_info);
-		if (ret)
-			goto restore;
-
-		btrfs_clear_sb_rdonly(sb);
-
-		set_bit(BTRFS_FS_OPEN, &fs_info->flags);
-
-		/*
-		 * If we've gone from readonly -> read/write, we need to get
-		 * our sync/async discard lists in the right state.
-		 */
-		btrfs_discard_resume(fs_info);
-	}
-out:
 	/*
 	 * We need to set SB_I_VERSION here otherwise it'll get cleared by VFS,
 	 * since the absence of the flag means it can be toggled off by remount.
-- 
2.41.0


