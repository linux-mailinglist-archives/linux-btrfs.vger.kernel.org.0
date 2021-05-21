Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9CB38C644
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 14:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbhEUMKl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 08:10:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:58288 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235110AbhEUMKg (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 08:10:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621598953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7KjEWNma9B2DmA8jlRLoXDuS+0WNwrLULxSJzGU27BQ=;
        b=lhGFheZNtorkCQwyv/wVYSicGisUkPmmtpRNzVPRBBA+MMldcKah+TwD7P2vBdIQXRSYUA
        WNb1RYsdShJP0hb4OGYAOLvjN4K94+taflPepQSC+n3LSyIPWDHidYzngY1KM95g2fV5ix
        PqpjOPhv6w/U50MHuFD/ClZ33XUypZ8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0B4CAAAFD;
        Fri, 21 May 2021 12:09:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BA3FFDA725; Fri, 21 May 2021 14:06:38 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 6/6] btrfs: add device delete cancel
Date:   Fri, 21 May 2021 14:06:38 +0200
Message-Id: <8759a75926d1a48c6092b2055348e35129cafd51.1621526221.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1621526221.git.dsterba@suse.com>
References: <cover.1621526221.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Accept device name "cancel" as a request to cancel running device
deletion operation. The string is literal, in case there's a real device
named "cancel", pass it as full absolute path or as "./cancel"

This works for v1 and v2 ioctls when the device is specified by name.
Moving chunks from the device uses relocation, use the conditional
exclusive operation start and cancelation helpers

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 8be2ca762894..bd56e57c943d 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3206,6 +3206,7 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_ioctl_vol_args_v2 *vol_args;
 	int ret;
+	bool cancel = false;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -3224,18 +3225,22 @@ static long btrfs_ioctl_rm_dev_v2(struct file *file, void __user *arg)
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
+	vol_args->name[BTRFS_SUBVOL_NAME_MAX] = '\0';
+	if (!(vol_args->flags & BTRFS_DEVICE_SPEC_BY_ID) &&
+	    strcmp("cancel", vol_args->name) == 0)
+		cancel = true;
 
-	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_REMOVE)) {
-		ret = BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
+	ret = exclop_start_or_cancel_reloc(fs_info, BTRFS_EXCLOP_DEV_REMOVE,
+					   cancel);
+	if (ret)
 		goto out;
-	}
+	/* Exclusive operation is now claimed */
 
-	if (vol_args->flags & BTRFS_DEVICE_SPEC_BY_ID) {
+	if (vol_args->flags & BTRFS_DEVICE_SPEC_BY_ID)
 		ret = btrfs_rm_device(fs_info, NULL, vol_args->devid);
-	} else {
-		vol_args->name[BTRFS_SUBVOL_NAME_MAX] = '\0';
+	else
 		ret = btrfs_rm_device(fs_info, vol_args->name, 0);
-	}
+
 	btrfs_exclop_finish(fs_info);
 
 	if (!ret) {
@@ -3259,6 +3264,7 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct btrfs_ioctl_vol_args *vol_args;
 	int ret;
+	bool cancel;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -3267,25 +3273,24 @@ static long btrfs_ioctl_rm_dev(struct file *file, void __user *arg)
 	if (ret)
 		return ret;
 
-	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_REMOVE)) {
-		ret = BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
-		goto out_drop_write;
-	}
-
 	vol_args = memdup_user(arg, sizeof(*vol_args));
 	if (IS_ERR(vol_args)) {
 		ret = PTR_ERR(vol_args);
-		goto out;
+		goto out_drop_write;
 	}
-
 	vol_args->name[BTRFS_PATH_NAME_MAX] = '\0';
-	ret = btrfs_rm_device(fs_info, vol_args->name, 0);
+	cancel = (strcmp("cancel", vol_args->name) == 0);
+
+	ret = exclop_start_or_cancel_reloc(fs_info, BTRFS_EXCLOP_DEV_REMOVE,
+					   cancel);
+	if (ret == 0) {
+		ret = btrfs_rm_device(fs_info, vol_args->name, 0);
+		if (!ret)
+			btrfs_info(fs_info, "disk deleted %s", vol_args->name);
+		btrfs_exclop_finish(fs_info);
+	}
 
-	if (!ret)
-		btrfs_info(fs_info, "disk deleted %s", vol_args->name);
 	kfree(vol_args);
-out:
-	btrfs_exclop_finish(fs_info);
 out_drop_write:
 	mnt_drop_write_file(file);
 
-- 
2.29.2

