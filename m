Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8076A479466
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 19:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbhLQSwd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Dec 2021 13:52:33 -0500
Received: from santino.mail.tiscali.it ([213.205.33.245]:53002 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240507AbhLQSwY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Dec 2021 13:52:24 -0500
Received: from venice.bhome ([78.12.25.242])
        by santino.mail.tiscali.it with 
        id XWnP2601f5DQHji01WnRqt; Fri, 17 Dec 2021 18:47:26 +0000
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
        Paul Jones <paul@pauljones.id.au>,
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 3/6] btrfs: change the device allocation_hint property via sysfs
Date:   Fri, 17 Dec 2021 19:47:19 +0100
Message-Id: <1425d4ea491c4f4b2019bc5e9d2f405a7573b5ed.1639766364.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1639766364.git.kreijack@inwind.it>
References: <cover.1639766364.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1639766846; bh=e5asLBdo8yeqlljTT9u9/0jdcaXV7Wk0RqKoM3r2reM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=nIoNTaz1FAbi7pgTfz/mp8IvZM1QIm/jmISV/iFG4LJw3Rgix6Nx3MzYOKB6uqyKH
         HBw1/+ttGHSlauvTid0o3KeoLQywYoZAL+dkvYZQGmOoOUq9TIL/lkAjcyhbiKEG9i
         BsA3LN1OTFJTU7TzB+4YTby/qMS/zMJEmhgaqzWM=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

Signed-off-by: Goffredo Baroncelli <kreijack@inwind.it>
---
 fs/btrfs/sysfs.c   | 62 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/volumes.c |  2 +-
 fs/btrfs/volumes.h |  2 ++
 3 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index a8d918700d2b..53acc66065dd 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1584,7 +1584,67 @@ static ssize_t btrfs_devinfo_allocation_hint_show(struct kobject *kobj,
 	return scnprintf(buf, PAGE_SIZE, "0x%08llx\n",
 		device->type & BTRFS_DEV_ALLOCATION_HINT_MASK );
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
index a7071f34fe64..806b599c6a46 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2859,7 +2859,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	return ret;
 }
 
-static noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
+noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
 					struct btrfs_device *device)
 {
 	int ret;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 9cf1d93a3d66..5097c0c12a8e 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -638,5 +638,7 @@ int btrfs_bg_type_to_factor(u64 flags);
 const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
 bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
+int btrfs_update_device(struct btrfs_trans_handle *trans,
+                                       struct btrfs_device *device);
 
 #endif
-- 
2.34.1

