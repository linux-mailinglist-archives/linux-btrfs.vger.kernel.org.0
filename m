Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E88E36C080
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jul 2019 19:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388159AbfGQRjW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Jul 2019 13:39:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49652 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfGQRjV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Jul 2019 13:39:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6EA9589AD0
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jul 2019 17:39:21 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 44F5D5C257
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jul 2019 17:39:21 +0000 (UTC)
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
From:   Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] btrfs: use common vfs LABEL ioctl definitions
Message-ID: <6e074252-3d02-9436-0ae9-a6e034acda43@redhat.com>
Date:   Wed, 17 Jul 2019 12:39:20 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Wed, 17 Jul 2019 17:39:21 +0000 (UTC)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I lifted the btrfs label get/set ioctls to the vfs some time ago, but
never followed up to use those common definitions directly in btrfs.

This patch does that.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 56ae2f659b6d..65aeb418aa9d 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -5547,6 +5547,10 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return btrfs_ioctl_setflags(file, argp);
 	case FS_IOC_GETVERSION:
 		return btrfs_ioctl_getversion(file, argp);
+	case FS_IOC_GETFSLABEL:
+		return btrfs_ioctl_get_fslabel(file, argp);
+	case FS_IOC_SETFSLABEL:
+		return btrfs_ioctl_set_fslabel(file, argp);
 	case FITRIM:
 		return btrfs_ioctl_fitrim(file, argp);
 	case BTRFS_IOC_SNAP_CREATE:
@@ -5658,10 +5662,6 @@ long btrfs_ioctl(struct file *file, unsigned int
 		return btrfs_ioctl_quota_rescan_wait(file, argp);
 	case BTRFS_IOC_DEV_REPLACE:
 		return btrfs_ioctl_dev_replace(fs_info, argp);
-	case BTRFS_IOC_GET_FSLABEL:
-		return btrfs_ioctl_get_fslabel(file, argp);
-	case BTRFS_IOC_SET_FSLABEL:
-		return btrfs_ioctl_set_fslabel(file, argp);
 	case BTRFS_IOC_GET_SUPPORTED_FEATURES:
 		return btrfs_ioctl_get_supported_features(argp);
 	case BTRFS_IOC_GET_FEATURES:
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index c195896d478f..7885d79f7515 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -917,10 +917,8 @@ enum btrfs_err_code {
 #define BTRFS_IOC_QUOTA_RESCAN_STATUS _IOR(BTRFS_IOCTL_MAGIC, 45, \
 			       struct btrfs_ioctl_quota_rescan_args)
 #define BTRFS_IOC_QUOTA_RESCAN_WAIT _IO(BTRFS_IOCTL_MAGIC, 46)
-#define BTRFS_IOC_GET_FSLABEL _IOR(BTRFS_IOCTL_MAGIC, 49, \
-				   char[BTRFS_LABEL_SIZE])
-#define BTRFS_IOC_SET_FSLABEL _IOW(BTRFS_IOCTL_MAGIC, 50, \
-				   char[BTRFS_LABEL_SIZE])
+#define BTRFS_IOC_GET_FSLABEL 	FS_IOC_GETFSLABEL
+#define BTRFS_IOC_SET_FSLABEL	FS_IOC_SETFSLABEL
 #define BTRFS_IOC_GET_DEV_STATS _IOWR(BTRFS_IOCTL_MAGIC, 52, \
 				      struct btrfs_ioctl_get_dev_stats)
 #define BTRFS_IOC_DEV_REPLACE _IOWR(BTRFS_IOCTL_MAGIC, 53, \

