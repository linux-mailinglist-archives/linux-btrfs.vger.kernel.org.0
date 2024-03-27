Return-Path: <linux-btrfs+bounces-3650-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2CD88DE7E
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 13:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9851F2B8DC
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 12:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC33212F58B;
	Wed, 27 Mar 2024 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TL+goa6L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB951386C8;
	Wed, 27 Mar 2024 12:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541314; cv=none; b=jk9WikkQHxtcfhphnQGJpZO38c/lOsBY1CQ6c5dUBJH/UmwTYTd0gdV9qGFGzkdqge2tSLx8+lqjYpC1QZeILhtdyqP9zMeCoKj0nZGjE4P0vmOn2Y7wCzm4eU+nn13y0eYZ52+j02t3oTcNQQzvVIxPOc+b2vEgvxXpjpZ4bJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541314; c=relaxed/simple;
	bh=Zr46nRlYjoUsEVPBenqevJUPJNe1JhAQWxh0vKrZIDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o/OE6oG9DjH44n/u/xKp3cr3xhcnfWh/PIodQPRUnauYeN1N8KDYL3Dwq+pt0zBiIBaM3qnul5fNBfneX1veMhhUK7bcO0BbHld1p6r1aChfAn2X/MK5P/niE+OxKiKJqozgHr/SIJyipDTD9Yjp3TcKToeidQfU/Et2rGwkQc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TL+goa6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EDEC433A6;
	Wed, 27 Mar 2024 12:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711541313;
	bh=Zr46nRlYjoUsEVPBenqevJUPJNe1JhAQWxh0vKrZIDM=;
	h=From:To:Cc:Subject:Date:From;
	b=TL+goa6Lkr4ij6SsEBWqosdnbFQBus/U4zZvWCUNSnfyb6/6L0UBPsBUBXfQBC7lW
	 /9ESGmW+3mGKqnAuNoAfSUbMaijtVOe5232vjsgeaJxDBv2rFKCtf7IQqYl/sPsMd9
	 9pTy7quxIcTbaITYYyUmVPKM/VAe9SYygvlXllik2LkuFh6D9yDuYiNc3JtD19LxBA
	 5sul+3a9Yq2h9iWBXgkU5U3DvKo5UxJvELe5BU2A0XZtgRpVe+b9TvnPHpjpGrNI5h
	 uIusAE3wTKAbNIq7FDYb1vPFzm/Y14bQygz1KIkEmVZBQzI7YoMmm2BayVF3eJSbzx
	 8rJkWF4LV5FGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	anand.jain@oracle.com
Cc: Alex Romosan <aromosan@gmail.com>,
	CHECK_1234543212345@protonmail.com,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "btrfs: do not skip re-registration for the mounted device" failed to apply to 6.7-stable tree
Date: Wed, 27 Mar 2024 08:08:31 -0400
Message-ID: <20240327120831.2826276-1-sashal@kernel.org>
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

From d565fffa68560ac540bf3d62cc79719da50d5e7a Mon Sep 17 00:00:00 2001
From: Anand Jain <anand.jain@oracle.com>
Date: Tue, 13 Feb 2024 09:13:56 +0800
Subject: [PATCH] btrfs: do not skip re-registration for the mounted device

There are reports that since version 6.7 update-grub fails to find the
device of the root on systems without initrd and on a single device.

This looks like the device name changed in the output of
/proc/self/mountinfo:

6.5-rc5 working

  18 1 0:16 / / rw,noatime - btrfs /dev/sda8 ...

6.7 not working:

  17 1 0:15 / / rw,noatime - btrfs /dev/root ...

and "update-grub" shows this error:

  /usr/sbin/grub-probe: error: cannot find a device for / (is /dev mounted?)

This looks like it's related to the device name, but grub-probe
recognizes the "/dev/root" path and tries to find the underlying device.
However there's a special case for some filesystems, for btrfs in
particular.

The generic root device detection heuristic is not done and it all
relies on reading the device infos by a btrfs specific ioctl. This ioctl
returns the device name as it was saved at the time of device scan (in
this case it's /dev/root).

The change in 6.7 for temp_fsid to allow several single device
filesystem to exist with the same fsid (and transparently generate a new
UUID at mount time) was to skip caching/registering such devices.

This also skipped mounted device. One step of scanning is to check if
the device name hasn't changed, and if yes then update the cached value.

This broke the grub-probe as it always read the device /dev/root and
couldn't find it in the system. A temporary workaround is to create a
symlink but this does not survive reboot.

The right fix is to allow updating the device path of a mounted
filesystem even if this is a single device one.

In the fix, check if the device's major:minor number matches with the
cached device. If they do, then we can allow the scan to happen so that
device_list_add() can take care of updating the device path. The file
descriptor remains unchanged.

This does not affect the temp_fsid feature, the UUID of the mounted
filesystem remains the same and the matching is based on device major:minor
which is unique per mounted filesystem.

This covers the path when the device (that exists for all mounted
devices) name changes, updating /dev/root to /dev/sdx. Any other single
device with filesystem and is not mounted is still skipped.

Note that if a system is booted and initial mount is done on the
/dev/root device, this will be the cached name of the device. Only after
the command "btrfs device scan" it will change as it triggers the
rename.

The fix was verified by users whose systems were affected.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218353
Link: https://lore.kernel.org/lkml/CAKLYgeJ1tUuqLcsquwuFqjDXPSJpEiokrWK2gisPKDZLs8Y2TQ@mail.gmail.com/
Fixes: bc27d6f0aa0e ("btrfs: scan but don't register device on single device filesystem")
CC: stable@vger.kernel.org # 6.7+
Tested-by: Alex Romosan <aromosan@gmail.com>
Tested-by: CHECK_1234543212345@protonmail.com
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/volumes.c | 58 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a2d07fa3cfdff..1dc1f1946ae0e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1303,6 +1303,47 @@ int btrfs_forget_devices(dev_t devt)
 	return ret;
 }
 
+static bool btrfs_skip_registration(struct btrfs_super_block *disk_super,
+				    const char *path, dev_t devt,
+				    bool mount_arg_dev)
+{
+	struct btrfs_fs_devices *fs_devices;
+
+	/*
+	 * Do not skip device registration for mounted devices with matching
+	 * maj:min but different paths. Booting without initrd relies on
+	 * /dev/root initially, later replaced with the actual root device.
+	 * A successful scan ensures grub2-probe selects the correct device.
+	 */
+	list_for_each_entry(fs_devices, &fs_uuids, fs_list) {
+		struct btrfs_device *device;
+
+		mutex_lock(&fs_devices->device_list_mutex);
+
+		if (!fs_devices->opened) {
+			mutex_unlock(&fs_devices->device_list_mutex);
+			continue;
+		}
+
+		list_for_each_entry(device, &fs_devices->devices, dev_list) {
+			if (device->bdev && (device->bdev->bd_dev == devt) &&
+			    strcmp(device->name->str, path) != 0) {
+				mutex_unlock(&fs_devices->device_list_mutex);
+
+				/* Do not skip registration. */
+				return false;
+			}
+		}
+		mutex_unlock(&fs_devices->device_list_mutex);
+	}
+
+	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
+	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING))
+		return true;
+
+	return false;
+}
+
 /*
  * Look for a btrfs signature on a device. This may be called out of the mount path
  * and we are not allowed to call set_blocksize during the scan. The superblock
@@ -1320,6 +1361,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 	struct btrfs_device *device = NULL;
 	struct file *bdev_file;
 	u64 bytenr, bytenr_orig;
+	dev_t devt;
 	int ret;
 
 	lockdep_assert_held(&uuid_mutex);
@@ -1359,19 +1401,13 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 		goto error_bdev_put;
 	}
 
-	if (!mount_arg_dev && btrfs_super_num_devices(disk_super) == 1 &&
-	    !(btrfs_super_flags(disk_super) & BTRFS_SUPER_FLAG_SEEDING)) {
-		dev_t devt;
+	devt = file_bdev(bdev_file)->bd_dev;
+	if (btrfs_skip_registration(disk_super, path, devt, mount_arg_dev)) {
+		pr_debug("BTRFS: skip registering single non-seed device %s (%d:%d)\n",
+			  path, MAJOR(devt), MINOR(devt));
 
-		ret = lookup_bdev(path, &devt);
-		if (ret)
-			btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
-				   path, ret);
-		else
-			btrfs_free_stale_devices(devt, NULL);
+		btrfs_free_stale_devices(devt, NULL);
 
-	pr_debug("BTRFS: skip registering single non-seed device %s (%d:%d)\n",
-			path, MAJOR(devt), MINOR(devt));
 		device = NULL;
 		goto free_disk_super;
 	}
-- 
2.43.0





