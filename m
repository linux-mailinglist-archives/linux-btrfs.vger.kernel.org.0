Return-Path: <linux-btrfs+bounces-2934-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA4786D265
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 19:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AB0DB22B37
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 18:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A84978270;
	Thu, 29 Feb 2024 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="WM6FS2KC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KxCA8EBL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEE22A8D7
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 18:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231705; cv=none; b=MSBcyICH2Z4p1GMet5c5kcEjwARwpfrIlUA/bughVZMte1ILPwY972BQZdwSz+ASB9iTIGiyn77CvJCaAr/HlNixr+tGk3SJGFzHBHuHAdRXen8g6KMRHbXA/9Fqw3xKCYgsZzmavfHdchuivb/UOAkTckSeoQUkasgNDTMbIWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231705; c=relaxed/simple;
	bh=8cjH9XKm4OPpaevvsx5ABeuzzZFXPj+Pu0aMfYFNU+M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ApQ4HXzrqVJO/9XVQcXpglgW64hWSp55inaSzmeoypF/J6QcW70t46khgksnlYs8EdYHz38Id7durum5Bwbmqnavn2Z/6RF7dGOjruFGqKNVflmYWAoYI4ACiRX1gCocs3SQEb0LY+8Ev85gxMPxd57C8qHul8yDjAhYxO/Zgx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=WM6FS2KC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KxCA8EBL; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id B192E32003D3;
	Thu, 29 Feb 2024 13:35:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 29 Feb 2024 13:35:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1709231701; x=1709318101; bh=Lo2u21PdO/jeb4ey3Phfq
	fZ25f2Zlx7vLYcemXco06k=; b=WM6FS2KC0AuWe6IkVxViazkfoIhl2jbV6HsC7
	fFDJWpQZeWB2hiOiDHUNbVwmcB/4mIIFmXTUZqR+Yv6Obm5YL3dKE0DgIZ/b76DP
	1ZOgqW1cDki9iKkSvVyELY/whqe8ZBGg5NPtYe1WpaNntIiLQ+G5xSe9vZj4/kMf
	aD9002hAtCFeoZbjqfmDLu47vxp20wct+WrHLSiV5n8Qlc1cDHvrQJsD/8yqZfU5
	0qcBbl5CZBZ+IJtw4DFf7YQ4nXUTncl/PlegiaEWzu/mQyjO1zD8p0kWNo4/KnK9
	fpJp9HNukzUm02fgGt11BOf4waZ5T8uWIJZFMf6XIyI3N/z6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709231701; x=1709318101; bh=Lo2u21PdO/jeb4ey3PhfqfZ25f2Z
	lx7vLYcemXco06k=; b=KxCA8EBLivE3501T4fcYsb0F6Nt7hlVaSW55pGSkjVu8
	nxBQLhgqWGjzVzrAPTzkUqc3pMwpRYHDoGA8ZGbAJBQL/r+YM92DIaWqeWFmYH3N
	mMyvHLAFsFGzAdVGA7cBnORPdP8Jb2XqUIzX4GzDcMi0acmpf1mdGjVff6MOSvoJ
	X2BvQHqQkZPcBY8kaBEVL9+0qZgPiWnx0sHWJn3sxUW1whzr2/S2bcJu6mbxSDl9
	iw44jb10cZsl7F4nQp8ZsILiCL6CbP8HmnIU/sb+Y4+axwQIBJHzCnsDB5sRJQI/
	38p0FaVx2qaBGTFDiKFjwAqKOvi7wIA9418UiNdAwg==
X-ME-Sender: <xms:VM7gZU6D1rmx2ShLvYh5lyPIKm7oOWsbrUgI-8Kswrar0l3fLIgTxw>
    <xme:VM7gZV4YLNKMTVI2YFc99c8raiPfdfzVDD5ZsHlhJ66NuIQAkkqVZNeg2DLPVXXWz
    HvAsYSFCRWwEkn-VWE>
X-ME-Received: <xmr:VM7gZTcsswwDWAsK-vINvLZJ2nUP_S3N4GemVH_fBNgMwjTelRlpKWFEQNDuMeGeADZfVXWxsu3roBRN8rwWHWXInJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeelgdduudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:VM7gZZKpmhvfK68BeUa5Uk-zMuCfu657zL4FG3Kt8_9HQMKHvdexgg>
    <xmx:VM7gZYIjD-CZ2ZKM-4N4uwQ3h_UJ8zvhaEjbvX6cfQgjPQVZ6zloFA>
    <xmx:VM7gZayGF_mdQYS9Ih4InEcE-Xl5QCwGKD5ebHTw8b0M8PxCDifCOw>
    <xmx:Vc7gZSz5zqAPy48mKrX0BdnoCGDxjjYne493McAECSe_aySmV4gRWg>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Feb 2024 13:35:00 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH] btrfs: support device name lookup in forget
Date: Thu, 29 Feb 2024 10:36:06 -0800
Message-ID: <659b811232f9c647e8a2250f6d4acd6a12751b6c.1709231726.git.boris@bur.io>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btrfs forget assumes the device still exists in the block layer and
that we can lookup its dev_t. For handling some tricky cases with
changing devt across device recreation, we need udev rules that run on
device removal. However, at that point, there is no node to lookup, so
we need to rely on the cached name. Refactor the forget code to handle
this case, while still preferring to use dev_t when possible.

Tested by a new fstest btrfs/303 which uses parted to trigger a
partition to take on different devts between remounts. That test passing
also assumes btrfs-progs patches which takes advantage of this kernel
change in `device scan -u` and udev.

Signed-off-by: Boris Burkov <boris@bur.io>
---
 fs/btrfs/super.c   | 11 ++++-------
 fs/btrfs/volumes.c | 46 +++++++++++++++++++++++++++++++++++++---------
 fs/btrfs/volumes.h |  1 +
 3 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 7e44ccaf348f..3609b9a773f7 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2192,7 +2192,7 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 {
 	struct btrfs_ioctl_vol_args *vol;
 	struct btrfs_device *device = NULL;
-	dev_t devt = 0;
+	char *name = NULL;
 	int ret = -ENOTTY;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -2217,12 +2217,9 @@ static long btrfs_control_ioctl(struct file *file, unsigned int cmd,
 		mutex_unlock(&uuid_mutex);
 		break;
 	case BTRFS_IOC_FORGET_DEV:
-		if (vol->name[0] != 0) {
-			ret = lookup_bdev(vol->name, &devt);
-			if (ret)
-				break;
-		}
-		ret = btrfs_forget_devices(devt);
+		if (vol->name[0] != 0)
+			name = vol->name;
+		ret = btrfs_forget_devices_by_name(name);
 		break;
 	case BTRFS_IOC_DEVICES_READY:
 		mutex_lock(&uuid_mutex);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3cc947a42116..68fb0b64ab3f 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -503,11 +503,13 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
 }
 
 /*
- *  Search and remove all stale devices (which are not mounted).  When both
+ *  Search and remove all stale devices (which are not mounted).  When all
  *  inputs are NULL, it will search and release all stale devices.
  *
  *  @devt:         Optional. When provided will it release all unmounted devices
- *                 matching this devt only.
+ *                 matching this devt only. Don't set together with name.
+ *  @name:         Optional. When provided will it release all unmounted devices
+ *                 matching this name only. Don't set together with devt.
  *  @skip_device:  Optional. Will skip this device when searching for the stale
  *                 devices.
  *
@@ -515,14 +517,16 @@ btrfs_get_bdev_and_sb(const char *device_path, blk_mode_t flags, void *holder,
  *		-EBUSY if @devt is a mounted device.
  *		-ENOENT if @devt does not match any device in the list.
  */
-static int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device)
+static int btrfs_free_stale_devices(dev_t devt, char *name, struct btrfs_device *skip_device)
 {
 	struct btrfs_fs_devices *fs_devices, *tmp_fs_devices;
 	struct btrfs_device *device, *tmp_device;
 	int ret;
 	bool freed = false;
+	bool searching = devt || name;
 
 	lockdep_assert_held(&uuid_mutex);
+	ASSERT(!(devt && name));
 
 	/* Return good status if there is no instance of devt. */
 	ret = 0;
@@ -533,14 +537,18 @@ static int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device
 					 &fs_devices->devices, dev_list) {
 			if (skip_device && skip_device == device)
 				continue;
+			if (!searching)
+				goto found;
 			if (devt && devt != device->devt)
 				continue;
+			if (name && device->name && strcmp(device->name->str, name))
+				continue;
+found:
 			if (fs_devices->opened) {
-				if (devt)
+				if (searching)
 					ret = -EBUSY;
 				break;
 			}
-
 			/* delete the stale device */
 			fs_devices->num_devices--;
 			list_del(&device->dev_list);
@@ -561,7 +569,7 @@ static int btrfs_free_stale_devices(dev_t devt, struct btrfs_device *skip_device
 	if (freed)
 		return 0;
 
-	return ret;
+	return ret ? ret : -ENODEV;
 }
 
 static struct btrfs_fs_devices *find_fsid_by_device(
@@ -1288,12 +1296,32 @@ static struct btrfs_super_block *btrfs_read_disk_super(struct block_device *bdev
 	return disk_super;
 }
 
+int btrfs_forget_devices_by_name(char *name)
+{
+	int ret;
+	dev_t devt = 0;
+
+	/*
+	 * Ideally, use devt, but if not, use name.
+	 * Note: Assumes lookup_bdev handles NULL name gracefully.
+	 */
+	ret = lookup_bdev(name, &devt);
+	if (!ret)
+		name = NULL;
+
+	mutex_lock(&uuid_mutex);
+	ret = btrfs_free_stale_devices(devt, name, NULL);
+	mutex_unlock(&uuid_mutex);
+
+	return ret;
+}
+
 int btrfs_forget_devices(dev_t devt)
 {
 	int ret;
 
 	mutex_lock(&uuid_mutex);
-	ret = btrfs_free_stale_devices(devt, NULL);
+	ret = btrfs_free_stale_devices(devt, NULL, NULL);
 	mutex_unlock(&uuid_mutex);
 
 	return ret;
@@ -1364,7 +1392,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 			btrfs_warn(NULL, "lookup bdev failed for path %s: %d",
 				   path, ret);
 		else
-			btrfs_free_stale_devices(devt, NULL);
+			btrfs_free_stale_devices(devt, NULL, NULL);
 
 		pr_debug("BTRFS: skip registering single non-seed device %s\n", path);
 		device = NULL;
@@ -1373,7 +1401,7 @@ struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 
 	device = device_list_add(path, disk_super, &new_device_added);
 	if (!IS_ERR(device) && new_device_added)
-		btrfs_free_stale_devices(device->devt, device);
+		btrfs_free_stale_devices(device->devt, NULL, device);
 
 free_disk_super:
 	btrfs_release_disk_super(disk_super);
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index feba8d53526c..a5388a6b2969 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -681,6 +681,7 @@ int btrfs_open_devices(struct btrfs_fs_devices *fs_devices,
 		       blk_mode_t flags, void *holder);
 struct btrfs_device *btrfs_scan_one_device(const char *path, blk_mode_t flags,
 					   bool mount_arg_dev);
+int btrfs_forget_devices_by_name(char *name);
 int btrfs_forget_devices(dev_t devt);
 void btrfs_close_devices(struct btrfs_fs_devices *fs_devices);
 void btrfs_free_extra_devids(struct btrfs_fs_devices *fs_devices);
-- 
2.43.0


