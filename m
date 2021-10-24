Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF714389F2
	for <lists+linux-btrfs@lfdr.de>; Sun, 24 Oct 2021 17:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhJXPl7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 Oct 2021 11:41:59 -0400
Received: from michael.mail.tiscali.it ([213.205.33.246]:57668 "EHLO
        smtp.tiscali.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230016AbhJXPl6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 Oct 2021 11:41:58 -0400
Received: from venice.bhome ([78.14.151.87])
        by michael.mail.tiscali.it with 
        id 9rXD2600J1tPKGW01rXFca; Sun, 24 Oct 2021 15:31:15 +0000
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
        Goffredo Baroncelli <kreijack@inwind.it>
Subject: [PATCH 3/4] btrfs: change the DEV_ITEM 'type' field via sysfs
Date:   Sun, 24 Oct 2021 17:31:06 +0200
Message-Id: <70a591dce249dbcc8e86139ba83d0b8f0b3465be.1635089352.git.kreijack@inwind.it>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1635089352.git.kreijack@inwind.it>
References: <cover.1635089352.git.kreijack@inwind.it>
Reply-To: Goffredo Baroncelli <kreijack@libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tiscali.it; s=smtp;
        t=1635089475; bh=dtwkFRGKeQuGzjZqpd+g8LObFId8h6P83RGpoURs2jo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=QG+iTl3W1XkpIq/uxEnCNjPSllDkIFKVozCG8RgQKcgBUqgPIVx4DEMJDEHO5MKfi
         0vR8/hjPAOvqmiuEr12anZQaokOYQOU9c0ldyzTMYimEDzsxu/O+/TLMBz8ZtRKgUu
         y7WzRAeolitGC9YNCNzlxnNmJIF6N7tS9U1IregU=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goffredo Baroncelli <kreijack@inwind.it>

---
 fs/btrfs/sysfs.c   | 56 +++++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/volumes.c |  2 +-
 fs/btrfs/volumes.h |  3 ++-
 3 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 402b98acf2aa..2eb74656f61f 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -1518,7 +1518,61 @@ static ssize_t btrfs_devinfo_type_show(struct kobject *kobj,
 
 	return scnprintf(buf, PAGE_SIZE, "0x%08llx\n", device->type);
 }
-BTRFS_ATTR(devid, type, btrfs_devinfo_type_show);
+
+static ssize_t btrfs_devinfo_type_store(struct kobject *kobj,
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
+	if (type & ~((1 << BTRFS_DEV_ALLOCATION_MASK_BIT_COUNT) - 1))
+		return -EINVAL;
+
+	trans = btrfs_start_transaction(root, 1);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+
+	prev_type = device->type;
+	device->type = type;
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
+BTRFS_ATTR_RW(devid, type, btrfs_devinfo_type_show, btrfs_devinfo_type_store);
 
 static struct attribute *devid_attrs[] = {
 	BTRFS_ATTR_PTR(devid, error_stats),
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 19c780242e12..8ac99771f43c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2836,7 +2836,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	return ret;
 }
 
-static noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
+noinline int btrfs_update_device(struct btrfs_trans_handle *trans,
 					struct btrfs_device *device)
 {
 	int ret;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index f77f869dfd2c..b8250f29df6e 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -608,5 +608,6 @@ int btrfs_bg_type_to_factor(u64 flags);
 const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
 int btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
-
+int btrfs_update_device(struct btrfs_trans_handle *trans,
+                                       struct btrfs_device *device);
 #endif
-- 
2.33.0

