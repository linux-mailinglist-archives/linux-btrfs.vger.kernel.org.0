Return-Path: <linux-btrfs+bounces-2942-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C0886D2B9
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 19:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 237AC1C21FEA
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Feb 2024 18:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B17134435;
	Thu, 29 Feb 2024 18:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b="orUnbxQ3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g2Wtad23"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA0913442F
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Feb 2024 18:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709233116; cv=none; b=ex5zkSSQzgVX4ngzphpYZJr5LMbn85lz6AKLonVPr/q5Aju0hDehrgdZRbdTPMH8R0kJRy0qBP2M3cOhg7iryWsKnp+iO0eYLfYWttiyIRdRcWBb7kR1Zo2SCjmAYR2AYEgtoJaGyT4B0zrC09HCPii5MRhHdd56RqgKadbsA+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709233116; c=relaxed/simple;
	bh=rhyDnta5a/SxkSdhdrvbg/SUcpBsMCQxlaTb9G6EZfs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZP1qN251kR9ZkiN1LoDOxKX3qrZS+UI3BjMZMcBZ5yblbBbLiOjcujmyqmlmjdOkvVB3PoM2wYxQRxwZfaX4cMA3nO8e0KWmw5si4GWt/azieB5Kfw4s3gMj+AW+obP7zT7WF4QOSzrQWamVS1rYlS9b2Gs6xNJ+qh/eTiQ0wQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io; spf=pass smtp.mailfrom=bur.io; dkim=pass (2048-bit key) header.d=bur.io header.i=@bur.io header.b=orUnbxQ3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g2Wtad23; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bur.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bur.io
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id 545E23200302;
	Thu, 29 Feb 2024 13:58:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 29 Feb 2024 13:58:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bur.io; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1709233112; x=1709319512; bh=icPkbhHUfSHmLZpurlbEf
	WeT0u3EYlg1cmQ9BXgCjR4=; b=orUnbxQ3OkvaNrfGRqf9rM1qRNiCdkC7zalir
	M7iDv9LwzjZnShx6nS6GlqEe9cz6BH5VjFGrTmqL5rjUf1KXbU4DnYPF5TYzTnm/
	fWvgF51nQjgHf4sJYH9+FS/49ckxYlXCErHzXdZx/0E3IsDlLF/58Jjd+fUXhA7g
	m/tSYi6x9YtocT1y4fLxj51P3foiau6CnLvNDgrMPjxVMXowL/dwpuuEy3rQ6Aer
	FcxLv+3MoMqQ541oS4Ep+YsVxmDaQdEfxJWIhH3ph/S7PWI9Tpeh8m7ggq/xgtVk
	3BAzwkyJ67qp4QJayvKOezT7gtAMpeR5u/1ppFUuoszugKUYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709233112; x=1709319512; bh=icPkbhHUfSHmLZpurlbEfWeT0u3E
	Ylg1cmQ9BXgCjR4=; b=g2Wtad23tt9aJmJr/vlg7bP9KhfLmWgvE03yHZktbymS
	YVaERpgSlam6xA4IVtd+9UyJYGjXxn6KUrv3wdrssONKnQehWmvXbiLUQ0VXkCkn
	6kU2fXpjgm37ZB8GBAQrA4J6lI1sBagGssS9k6Tvfgnymhte9FDYKtDR9gzkGiqg
	Zd7pHlNshIEbTw+wepdMr/tMB6L8ifFBg9gA5xptXWai+qvti/m0pQ4I36W8M/vo
	z3FWP7Dc/8/xvsCxsYgcH7Yke7uaID19NmGSx2hMTWTyo+mdpMVYrOKkvdVmUP/4
	2gF0I15lyy2+Cj+yZJnBOH9r7rFPNo763fjQTee47w==
X-ME-Sender: <xms:2NPgZV0JfB2eCq3y1DlKxzK5aW-l2TqaMUWpb2C2JsltBKOEpS0Z3g>
    <xme:2NPgZcGm642zgZmBSyOmYd9XcDxlufXkdMoYrVRvgzYK8J2RXnM2L8C-Oa60-kliW
    pfsxO-NwGyCNWnDRb8>
X-ME-Received: <xmr:2NPgZV6-czRh0meV_f8WSymIcGj4uCFEglFTIXO_nFX1C6JVBbmCiKW7eUACOsTewMcaAsL9znUlYmIsYRIYCQDnDBo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeelgdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomhepuehorhhishcuuehurhhkohhvuceosghorhhishessghurhdrihho
    qeenucggtffrrghtthgvrhhnpeduiedtleeuieejfeelffevleeifefgjeejieegkeduud
    etfeekffeftefhvdejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpegsohhrihhssegsuhhrrdhioh
X-ME-Proxy: <xmx:2NPgZS3u25lyG_YBNU6APt93tKxsgj1OWeTxCB7XgHyGlNhtcyPLvg>
    <xmx:2NPgZYGbYO69EU1H8fwVmM2a_TI1TUPReliAInrvb8Nvf0Z-IOWwIA>
    <xmx:2NPgZT-4qgSaar9Ha73Wzgg_8qwCmC0wNvSGXI75E7ITKztfEzKH0Q>
    <xmx:2NPgZTMJC7RcAlBuPXJ-dnDtA8yBRSdg-rGElDygA8qAx7-Kj8Sm9w>
Feedback-ID: i083147f8:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Feb 2024 13:58:32 -0500 (EST)
From: Boris Burkov <boris@bur.io>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com
Subject: [PATCH v2] btrfs: support device name lookup in forget
Date: Thu, 29 Feb 2024 10:59:34 -0800
Message-ID: <40d13cb5a18a2fcb5e667ee0bc61f2b7a12c93e4.1709233065.git.boris@bur.io>
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

Reproducing the underlying issue is a bit of a boondoggle, but can be
done with a script like the following. It assumes three devices we can
run parted on safely, for which I have been making loop devices. I sent
a parallel patch in fstests with this script fully fleshed out.

==========================
DEV0=<dev0> # primary device we will be corruptin
DEV1=<dev1> # second partition device to trigger devt swap
DEV2=<dev2> # second device to mount, to trick temp_fsid code
D0P1=$DEV0"p1"
D1P1=$DEV1"p1"
MNT=$TEST_DIR/mnt
BIND=$TEST_DIR/bind

parted $DEV0 'mktable gpt' --script
parted $DEV1 'mktable gpt' --script
parted $DEV0 'mkpart mypart 1M 100%' --script # devt A
parted $DEV1 'mkpart mypart 1M 100%' --script # devt B

$MKFS_BTRFS_PROG -f -msingle -dsingle $D0P1 $DEV2 &>/dev/null

mkdir -p $MNT
mount $D0P1 $MNT
umount $MNT # multi-device, no cache freeing

do_rmpart $DEV0
do_rmpart $DEV1
do_mkpart $DEV1 # devt A
do_mkpart $DEV0 # devt B

mount $D0P1 $MNT
$BTRFS_UTIL_PROG device remove $DEV2 $MNT # open us up to temp_fsid

mkdir -p $BIND
mount $D0P1 $BIND # crazy dangerous duplicate mount on same dev
doStuffThatCorruptsTheDisk $BIND
==========================

Signed-off-by: Boris Burkov <boris@bur.io>
---
Changelog:
v2:
- updated commit message to include repro script

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


