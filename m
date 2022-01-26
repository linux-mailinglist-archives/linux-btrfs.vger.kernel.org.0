Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0759C49D375
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Jan 2022 21:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiAZUcX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Jan 2022 15:32:23 -0500
Received: from michael.mail.tiscali.it ([213.205.33.246]:59436 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230391AbiAZUcV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Jan 2022 15:32:21 -0500
Received: from venice.bhome ([78.14.151.50])
        by michael.mail.tiscali.it with 
        id nYYG2600e15VSme01YYKLA; Wed, 26 Jan 2022 20:32:20 +0000
X-Spam-Final-Verdict: clean
X-Spam-State: 0
X-Spam-Score: -100
X-Spam-Verdict: clean
x-auth-user: kreijack@tiscali.it
From:   Goffredo Baroncelli <kreijack@tiscali.it>
To:     linux-btrfs@vger.kernel.org
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>, Boris Burkov <boris@bur.io>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 3/7] btrfs: change the device allocation_hint property via sysfs
Date:   Wed, 26 Jan 2022 21:32:10 +0100
Message-Id: <13dc3d2d0a220fcc85533199b289b4a0dfcaf204.1643228177.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643228177.git.kreijack@inwind.it>
References: <cover.1643228177.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1643229140; bh=guhxZ1eAMzUJH7Br7Fc9G1Bkw/gHyGzbbaWcwUQTbBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=M7uyDSvtVPYpAx5R9k3MLlo+yJeqTq4mP2zmlMZWmyKbGH8AH1GE62v0ZSITMBKaI
         jpL+v1PYusP20jQVuE1okBHWaStRAOigeyzjflkjhop/h68g066h325/s7JRHXidim
         oQMODJTyfedxQryU2xbtKbGtYUZyLwrer/wloTfs=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

This patch allow to change the allocation_hint property writing
a numerical value in the file.

/sysfs/fs/btrfs/<UUID>/devinfo/<devid>/allocation_hint

To update this field it is added the property "allocation_hint" in
btrfs-prog too.

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 fs/btrfs/sysfs.c   | 62 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/volumes.c |  2 +-
 fs/btrfs/volumes.h |  2 ++
 3 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index c1c903187e19..9070d0370343 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1584,7 +1584,67 @@ static ssize_t btrfs_devinfo_allocation_hint_show(struct kobject *kobj,
 	return scnprintf(buf, PAGE_SIZE, "0x%08llx\n",
 		device->type & BTRFS_DEV_ALLOCATION_HINT_MASK);
 }
-BTRFS_ATTR(devid, allocation_hint, btrfs_devinfo_allocation_hint_show);
+
+static ssize_t btrfs_devinfo_allocation_hint_store(struct kobject *kobj,
+				 struct kobj_attribute *a,
+				 const char *buf, size_t len)
+{
+	struct btrfs_fs_info *fs_info;
+	struct btrfs_root *root;
+	struct btrfs_device *device;
+	int ret;
+	struct btrfs_trans_handle *trans;
+
+	u64 type, prev_type;
+
+	device = container_of(kobj, struct btrfs_device, devid_kobj);
+	fs_info = device->fs_info;
+	if (!fs_info)
+		return -EPERM;
+
+	root = fs_info->chunk_root;
+	if (sb_rdonly(fs_info->sb))
+		return -EROFS;
+
+	ret = kstrtou64(buf, 0, &type);
+	if (ret < 0)
+		return -EINVAL;
+
+	/* for now, allow to touch only the 'allocation hint' bits */
+	if (type & ~BTRFS_DEV_ALLOCATION_HINT_MASK)
+		return -EINVAL;
+
+	/* check if a change is really needed */
+	if ((device->type & BTRFS_DEV_ALLOCATION_HINT_MASK) == type)
+		return len;
+
+	trans = btrfs_start_transaction(root, 1);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+
+	prev_type = device->type;
+	device->type = (device->type & ~BTRFS_DEV_ALLOCATION_HINT_MASK) | type;
+
+	ret = btrfs_update_device(trans, device);
+
+	if (ret < 0) {
+		btrfs_abort_transaction(trans, ret);
+		btrfs_end_transaction(trans);
+		goto abort;
+	}
+
+	ret = btrfs_commit_transaction(trans);
+	if (ret < 0)
+		goto abort;
+
+	return len;
+abort:
+	device->type = prev_type;
+	return  ret;
+}
+BTRFS_ATTR_RW(devid, allocation_hint, btrfs_devinfo_allocation_hint_show,
+				      btrfs_devinfo_allocation_hint_store);
+
 
 /*
  * Information about one device.
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index a91e51b0ca81..c43a8a36ff5b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2841,7 +2841,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	return ret;
 }
 
-static noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
+noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
 					struct btrfs_device *device)
 {
 	int ret;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index bd297f23d19e..93ac27d8097c 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -636,5 +636,7 @@ int btrfs_bg_type_to_factor(u64 flags);
 const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
 bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
+int btrfs_update_device(struct btrfs_trans_handle *trans,
+			struct btrfs_device *device);
 
 #endif
-- 
2.34.1

