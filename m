Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C97842DFF4
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Oct 2021 19:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhJNRNR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Oct 2021 13:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbhJNRNO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Oct 2021 13:13:14 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB8CC061753
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 10:11:07 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id i1so6392384qtr.6
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Oct 2021 10:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=lLIr1cCHtmatuH5Ofh4bP6wtCMbMN1RWOxYOc2wRyjM=;
        b=27ep4A+5Q58MI/VhCrwyv4pDuLLApS2cPq39btbTauMOpXVvHvkxIZWG9ytCcHPAQ2
         nVBpuz3KyhTz65sxBb46LgBE5qkU3jJALlLXVWs8JwbTJotYD8sS2TutPf0nc73SkM+B
         nxgD56EdwKa+UEXaoKwQd18ThmaN2inxyloCVLecK5de3be6fCu1B4usGJFwmi7gNr2C
         US0iNrmY8Y5nYA8wSDQLE9E1AjxmpU7Sdd6pTPDVVGVa88Dw0/pDYyV5EJpmcuwhMDPq
         s7xBZcz6JlNZ/kV0oNnIHttgV3nuhZwzMGplWtGhHTplBGiF1E8mRjdhnoDCaa0b/qb3
         ML/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lLIr1cCHtmatuH5Ofh4bP6wtCMbMN1RWOxYOc2wRyjM=;
        b=eKzW5HvgVnvJvYtvPEJynl1ytP1CXPVX32hOiGJ8Ktu2t1HH5a0Ztwcl/k9FN9EzXX
         9lwgCDCLOY4S8e4RUEv0k1CWIgYtDa9yIl8RSPE43wsbLiOkHd0l+FvipgwUZnJVCufW
         SM9Y90f6UIIMw2WwzPnonSl88Xo+WZL/+5dwaFcbYJNYZMnFzoG6+LuoDn4sgahGTzz8
         jhbrQYufReoi3Npbqbaf9xGajT6vAnvEIiSfA3BRw2OQvGysG8BAnBq4Ecei0b8ZjGFS
         9s+0YwzujcKxz9cxEwgKmhzIQODVgGvfxYqvjnZnrEP7izTRtrDzIJSWOsZXMl/LxzWo
         tvNA==
X-Gm-Message-State: AOAM533vmOCXtZaQBofU95OVYQo8FTt/BziKHl/4mkL3XiKVhJ5owc2V
        Ndki/Bh7YP/TaNxlvZ81rjjtVA==
X-Google-Smtp-Source: ABdhPJwGBCp61nerDCGvX7b8zUUz9ncCyMwvrPSnI+uJub9bfrWiK0AyWnoPrcwRraHhLlS3TTDueQ==
X-Received: by 2002:a05:622a:170f:: with SMTP id h15mr8312225qtk.176.1634231465819;
        Thu, 14 Oct 2021 10:11:05 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id r186sm1514209qkf.128.2021.10.14.10.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 10:11:05 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     hch@lst.de, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v2 2/2] btrfs: update device path inode time instead of bd_inode
Date:   Thu, 14 Oct 2021 13:11:01 -0400
Message-Id: <fd9dfa50bbe1ac9a9f0c0dbeb4b59ef5d9fe9d60.1634231213.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1634231213.git.josef@toxicpanda.com>
References: <cover.1634231213.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Christoph pointed out that I'm updating bdev->bd_inode for the device
time when we remove block devices from a btrfs file system, however this
isn't actually exposed to anything.  The inode we want to update is the
one that's associated with the path to the device, usually on devtmpfs,
so that blkid notices the difference.

We still don't want to do the blkdev_open, so use kern_path() to get the
path to the given device and do the update time on that inode.

Fixes: 8f96a5bfa150 ("btrfs: update the bdev time directly when closing")
Reported-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/volumes.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 3262e75fbb1c..34729f0e4a9b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -14,6 +14,7 @@
 #include <linux/semaphore.h>
 #include <linux/uuid.h>
 #include <linux/list_sort.h>
+#include <linux/namei.h>
 #include "misc.h"
 #include "ctree.h"
 #include "extent_map.h"
@@ -1886,18 +1887,22 @@ static int btrfs_add_dev_item(struct btrfs_trans_handle *trans,
 /*
  * Function to update ctime/mtime for a given device path.
  * Mainly used for ctime/mtime based probe like libblkid.
+ *
+ * We don't care about errors here, this is just to be kind to userspace.
  */
-static void update_dev_time(struct block_device *bdev)
+static void update_dev_time(const char *device_path)
 {
-	struct inode *inode = bdev->bd_inode;
+	struct path path;
 	struct timespec64 now;
+	int ret;
 
-	/* Shouldn't happen but just in case. */
-	if (!inode)
+	ret = kern_path(device_path, LOOKUP_FOLLOW, &path);
+	if (ret)
 		return;
 
-	now = current_time(inode);
-	generic_update_time(inode, &now, S_MTIME | S_CTIME);
+	now = current_time(d_inode(path.dentry));
+	inode_update_time(d_inode(path.dentry), &now, S_MTIME | S_CTIME);
+	path_put(&path);
 }
 
 static int btrfs_rm_dev_item(struct btrfs_device *device)
@@ -2073,7 +2078,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
 	btrfs_kobject_uevent(bdev, KOBJ_CHANGE);
 
 	/* Update ctime/mtime for device path for libblkid */
-	update_dev_time(bdev);
+	update_dev_time(device_path);
 }
 
 int btrfs_rm_device(struct btrfs_fs_info *fs_info,
@@ -2767,7 +2772,7 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	btrfs_forget_devices(device_path);
 
 	/* Update ctime/mtime for blkid or udev */
-	update_dev_time(bdev);
+	update_dev_time(device_path);
 
 	return ret;
 
-- 
2.26.3

