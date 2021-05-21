Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C1538C643
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 14:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbhEUMKk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 08:10:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:58204 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235076AbhEUMKe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 08:10:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621598950; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OLmZvY9YdkesSS84C6NOQQu9E+gtt4UFKg9oi82vja8=;
        b=oCXvbZZUhZ/LWwgUJRBIaxNgnkYygcvZ9t6NXUmfiXfSOPPYDzLqjmhOBGksCXVRjYCCQB
        Wo6uUUAOwB5tVYuhiPXRUtS/SoIPQYSroZdL4/wFWII16GR9OqGgs4pGToSIORRGOz64Bk
        tnOVNKdiUER4ArpRjAX2QkHLDfNBMCQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B8327AAA6;
        Fri, 21 May 2021 12:09:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 71524DA725; Fri, 21 May 2021 14:06:36 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 5/6] btrfs: add cancelation to resize
Date:   Fri, 21 May 2021 14:06:36 +0200
Message-Id: <6aabd4e1187d0ce49bad7bf7967148a86b4c56d4.1621526221.git.dsterba@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1621526221.git.dsterba@suse.com>
References: <cover.1621526221.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Accept literal string "cancel" as resize operation and interpret that
as a request to cancel the running operation. If it's running, wait
until it finishes current work and return ECANCELED.

Shrinking resize uses relocation to move the chunks away, use the
conditional exclusive operation start and cancelation helpers.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/ioctl.c | 47 ++++++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index c75ccadf23dc..8be2ca762894 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1659,6 +1659,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 	char *devstr = NULL;
 	int ret = 0;
 	int mod = 0;
+	bool cancel;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -1667,20 +1668,23 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 	if (ret)
 		return ret;
 
-	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_RESIZE)) {
-		mnt_drop_write_file(file);
-		return BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;
-	}
-
+	/*
+	 * Read the arguments before checking exclusivity to be able to
+	 * distinguish regular resize and cancel
+	 */
 	vol_args = memdup_user(arg, sizeof(*vol_args));
 	if (IS_ERR(vol_args)) {
 		ret = PTR_ERR(vol_args);
-		goto out;
+		goto out_drop;
 	}
-
 	vol_args->name[BTRFS_PATH_NAME_MAX] = '\0';
-
 	sizestr = vol_args->name;
+	cancel = (strcmp("cancel", sizestr) == 0);
+	ret = exclop_start_or_cancel_reloc(fs_info, BTRFS_EXCLOP_RESIZE, cancel);
+	if (ret)
+		goto out_free;
+	/* Exclusive operation is now claimed */
+
 	devstr = strchr(sizestr, ':');
 	if (devstr) {
 		sizestr = devstr + 1;
@@ -1688,10 +1692,10 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 		devstr = vol_args->name;
 		ret = kstrtoull(devstr, 10, &devid);
 		if (ret)
-			goto out_free;
+			goto out_finish;
 		if (!devid) {
 			ret = -EINVAL;
-			goto out_free;
+			goto out_finish;
 		}
 		btrfs_info(fs_info, "resizing devid %llu", devid);
 	}
@@ -1701,7 +1705,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 		btrfs_info(fs_info, "resizer unable to find device %llu",
 			   devid);
 		ret = -ENODEV;
-		goto out_free;
+		goto out_finish;
 	}
 
 	if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
@@ -1709,7 +1713,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 			   "resizer unable to apply on readonly device %llu",
 		       devid);
 		ret = -EPERM;
-		goto out_free;
+		goto out_finish;
 	}
 
 	if (!strcmp(sizestr, "max"))
@@ -1725,13 +1729,13 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 		new_size = memparse(sizestr, &retptr);
 		if (*retptr != '\0' || new_size == 0) {
 			ret = -EINVAL;
-			goto out_free;
+			goto out_finish;
 		}
 	}
 
 	if (test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state)) {
 		ret = -EPERM;
-		goto out_free;
+		goto out_finish;
 	}
 
 	old_size = btrfs_device_get_total_bytes(device);
@@ -1739,24 +1743,24 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 	if (mod < 0) {
 		if (new_size > old_size) {
 			ret = -EINVAL;
-			goto out_free;
+			goto out_finish;
 		}
 		new_size = old_size - new_size;
 	} else if (mod > 0) {
 		if (new_size > ULLONG_MAX - old_size) {
 			ret = -ERANGE;
-			goto out_free;
+			goto out_finish;
 		}
 		new_size = old_size + new_size;
 	}
 
 	if (new_size < SZ_256M) {
 		ret = -EINVAL;
-		goto out_free;
+		goto out_finish;
 	}
 	if (new_size > device->bdev->bd_inode->i_size) {
 		ret = -EFBIG;
-		goto out_free;
+		goto out_finish;
 	}
 
 	new_size = round_down(new_size, fs_info->sectorsize);
@@ -1765,7 +1769,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 		trans = btrfs_start_transaction(root, 0);
 		if (IS_ERR(trans)) {
 			ret = PTR_ERR(trans);
-			goto out_free;
+			goto out_finish;
 		}
 		ret = btrfs_grow_device(trans, device, new_size);
 		btrfs_commit_transaction(trans);
@@ -1778,10 +1782,11 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 			"resize device %s (devid %llu) from %llu to %llu",
 			rcu_str_deref(device->name), device->devid,
 			old_size, new_size);
+out_finish:
+	btrfs_exclop_finish(fs_info);
 out_free:
 	kfree(vol_args);
-out:
-	btrfs_exclop_finish(fs_info);
+out_drop:
 	mnt_drop_write_file(file);
 	return ret;
 }
-- 
2.29.2

