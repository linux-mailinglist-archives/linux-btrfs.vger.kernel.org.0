Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2737B184AC9
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Mar 2020 16:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgCMPbr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Mar 2020 11:31:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:46456 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgCMPbr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Mar 2020 11:31:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4D526AE35;
        Fri, 13 Mar 2020 15:31:45 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     osandov@osandov.com, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] btrfs-progs: Remove support for BTRFS_SUBVOL_CREATE_ASYNC
Date:   Fri, 13 Mar 2020 17:31:43 +0200
Message-Id: <20200313153143.23613-1-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Kernel has removed support for this feature in 5.7 so let's remove
support from progs as well.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 ioctl.h                  | 4 +---
 libbtrfsutil/btrfs.h     | 4 +---
 libbtrfsutil/subvolume.c | 4 ----
 3 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/ioctl.h b/ioctl.h
index d3dfd6375de1..93a19a5789b6 100644
--- a/ioctl.h
+++ b/ioctl.h
@@ -49,14 +49,12 @@ BUILD_ASSERT(sizeof(struct btrfs_ioctl_vol_args) == 4096);
 
 #define BTRFS_DEVICE_PATH_NAME_MAX 1024
 
-#define BTRFS_SUBVOL_CREATE_ASYNC	(1ULL << 0)
 #define BTRFS_SUBVOL_RDONLY		(1ULL << 1)
 #define BTRFS_SUBVOL_QGROUP_INHERIT	(1ULL << 2)
 #define BTRFS_DEVICE_SPEC_BY_ID		(1ULL << 3)
 
 #define BTRFS_VOL_ARG_V2_FLAGS_SUPPORTED		\
-			(BTRFS_SUBVOL_CREATE_ASYNC |	\
-			BTRFS_SUBVOL_RDONLY |		\
+			(BTRFS_SUBVOL_RDONLY |		\
 			BTRFS_SUBVOL_QGROUP_INHERIT |	\
 			BTRFS_DEVICE_SPEC_BY_ID)
 
diff --git a/libbtrfsutil/btrfs.h b/libbtrfsutil/btrfs.h
index 944d50132456..03ac58372104 100644
--- a/libbtrfsutil/btrfs.h
+++ b/libbtrfsutil/btrfs.h
@@ -38,8 +38,7 @@ struct btrfs_ioctl_vol_args {
 #define BTRFS_DEVICE_SPEC_BY_ID		(1ULL << 3)
 
 #define BTRFS_VOL_ARG_V2_FLAGS_SUPPORTED		\
-			(BTRFS_SUBVOL_CREATE_ASYNC |	\
-			BTRFS_SUBVOL_RDONLY |		\
+			(BTRFS_SUBVOL_RDONLY |		\
 			BTRFS_SUBVOL_QGROUP_INHERIT |	\
 			BTRFS_DEVICE_SPEC_BY_ID)
 
@@ -101,7 +100,6 @@ struct btrfs_ioctl_qgroup_limit_args {
  * - BTRFS_IOC_SUBVOL_GETFLAGS
  * - BTRFS_IOC_SUBVOL_SETFLAGS
  */
-#define BTRFS_SUBVOL_CREATE_ASYNC	(1ULL << 0)
 #define BTRFS_SUBVOL_RDONLY		(1ULL << 1)
 #define BTRFS_SUBVOL_QGROUP_INHERIT	(1ULL << 2)
 
diff --git a/libbtrfsutil/subvolume.c b/libbtrfsutil/subvolume.c
index 3f8343a245e9..27a6bb8130ed 100644
--- a/libbtrfsutil/subvolume.c
+++ b/libbtrfsutil/subvolume.c
@@ -716,8 +716,6 @@ PUBLIC enum btrfs_util_error btrfs_util_create_subvolume_fd(int parent_fd,
 		return BTRFS_UTIL_ERROR_INVALID_ARGUMENT;
 	}
 
-	if (async_transid)
-		args.flags |= BTRFS_SUBVOL_CREATE_ASYNC;
 	if (qgroup_inherit) {
 		args.flags |= BTRFS_SUBVOL_QGROUP_INHERIT;
 		args.qgroup_inherit = (struct btrfs_qgroup_inherit *)qgroup_inherit;
@@ -1153,8 +1151,6 @@ PUBLIC enum btrfs_util_error btrfs_util_create_snapshot_fd2(int fd,
 
 	if (flags & BTRFS_UTIL_CREATE_SNAPSHOT_READ_ONLY)
 		args.flags |= BTRFS_SUBVOL_RDONLY;
-	if (async_transid)
-		args.flags |= BTRFS_SUBVOL_CREATE_ASYNC;
 	if (qgroup_inherit) {
 		args.flags |= BTRFS_SUBVOL_QGROUP_INHERIT;
 		args.qgroup_inherit = (struct btrfs_qgroup_inherit *)qgroup_inherit;
-- 
2.17.1

