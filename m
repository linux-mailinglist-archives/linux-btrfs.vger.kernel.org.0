Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22C7048692B
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jan 2022 18:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242465AbiAFRtp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 12:49:45 -0500
Received: from santino.mail.tiscali.it ([213.205.33.245]:56256 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S242413AbiAFRte (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jan 2022 12:49:34 -0500
Received: from venice.bhome ([84.220.25.125])
        by santino.mail.tiscali.it with 
        id fVpV2600Z2hwt0401VpZV9; Thu, 06 Jan 2022 17:49:33 +0000
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
Subject: [PATCH 3/6] btrfs: change the device allocation_hint property via sysfs
Date:   Thu,  6 Jan 2022 18:49:20 +0100
Message-Id: <d66746986ed424bc8f9af1c21cfbefbb01a3e5f6.1641486794.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1641486794.git.kreijack@inwind.it>
References: <cover.1641486794.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1641491373; bh=Nuep3DTCEyx94voMz97HYZ0r/jYkfcJtrKSYF0LaLLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=TlUmE+bvc29UWyjmrVtoK6qFHgTHsrnFFDbfyrUi8aFofEOO4DUr6+jnsiOrZeM/j
         Uj0z300Rt8aCjfNlttDaxylGEU1dfrUNsDa1wJFTH4m59ivkKqGh4dceBcoyNZHiLL
         RuwvHo0iHxcHIwH7ecT4OYbksIlXG4ojz7vmX924=
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
index b07d382d53a8..643ba7cac22c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2857,7 +2857,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	return ret;
 }
 
-static noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
+noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
 					struct btrfs_device *device)
 {
 	int ret;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 005c9e2a491a..4ac3114f5eae 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -631,5 +631,7 @@ int btrfs_bg_type_to_factor(u64 flags);
 const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
 bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
+int btrfs_update_device(struct btrfs_trans_handle *trans,
+			struct btrfs_device *device);
 
 #endif
-- 
2.34.1

