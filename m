Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABA45FFF48
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Nov 2019 08:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfKRHFf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 Nov 2019 02:05:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:48002 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726483AbfKRHFf (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 Nov 2019 02:05:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 681B1AFBF;
        Mon, 18 Nov 2019 07:05:33 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nathan Dehnel <ncdehnel@gmail.com>
Subject: [PATCH] btrfs: resize: Allow user to shrink missing device
Date:   Mon, 18 Nov 2019 15:05:25 +0800
Message-Id: <20191118070525.62844-1-wqu@suse.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

One user reported an use case where one device can't be replaced due to
tiny device size difference.

Since it's a RAID10 fs, if we go regular "remove missing" it can take a
long time and even not be possible due to lack of space.

So here we work around this situation by allowing user to shrink missing
device.
Then user can go shrink the device first, then replace it.

Reported-by: Nathan Dehnel <ncdehnel@gmail.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index de730e56d3f5..ebd2f40aca6f 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -1604,6 +1604,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 	char *sizestr;
 	char *retptr;
 	char *devstr = NULL;
+	bool missing;
 	int ret = 0;
 	int mod = 0;
 
@@ -1651,7 +1652,10 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 		goto out_free;
 	}
 
-	if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state)) {
+
+	missing = test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
+	if (!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
+	    !missing) {
 		btrfs_info(fs_info,
 			   "resizer unable to apply on readonly device %llu",
 		       devid);
@@ -1659,13 +1663,24 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 		goto out_free;
 	}
 
-	if (!strcmp(sizestr, "max"))
+	if (!strcmp(sizestr, "max")) {
+		if (missing) {
+			btrfs_info(fs_info,
+				"'max' can't be used for missing device %llu",
+				   devid);
+			ret = -EPERM;
+			goto out_free;
+		}
 		new_size = device->bdev->bd_inode->i_size;
-	else {
+	} else {
 		if (sizestr[0] == '-') {
 			mod = -1;
 			sizestr++;
 		} else if (sizestr[0] == '+') {
+			if (missing)
+				btrfs_info(fs_info,
+				"'+size' can't be used for missing device %llu",
+					   devid);
 			mod = 1;
 			sizestr++;
 		}
@@ -1694,6 +1709,12 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 			ret = -ERANGE;
 			goto out_free;
 		}
+		if (missing) {
+			ret = -EINVAL;
+			btrfs_info(fs_info,
+			"can not increase device size for missing device %llu",
+				   devid);
+		}
 		new_size = old_size + new_size;
 	}
 
@@ -1701,7 +1722,7 @@ static noinline int btrfs_ioctl_resize(struct file *file,
 		ret = -EINVAL;
 		goto out_free;
 	}
-	if (new_size > device->bdev->bd_inode->i_size) {
+	if (!missing && new_size > device->bdev->bd_inode->i_size) {
 		ret = -EFBIG;
 		goto out_free;
 	}
-- 
2.24.0

