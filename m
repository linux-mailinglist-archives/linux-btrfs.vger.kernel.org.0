Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 955F610A974
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2019 05:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfK0EoL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Nov 2019 23:44:11 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:48384 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfK0EoK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Nov 2019 23:44:10 -0500
X-Envelope-Mail-From: zblaxell@waya.furryterror.org
X-Envelope-Mail-From: zblaxell@waya.furryterror.org
Received: from waya.furryterror.org (waya.vpn7.hungrycats.org [10.132.226.63])
        by james.kirk.hungrycats.org (Postfix) with ESMTP id ED2D54F8A77;
        Tue, 26 Nov 2019 23:37:44 -0500 (EST)
Received: from zblaxell by waya.furryterror.org with local (Exim 4.92)
        (envelope-from <zblaxell@waya.furryterror.org>)
        id 1iZp5E-0003PF-E0; Tue, 26 Nov 2019 23:37:44 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/6] btrfs-progs: libbtrfsutil: add LOGICAL_INO_V2
Date:   Tue, 26 Nov 2019 22:55:05 -0500
Message-Id: <20191127035509.15011-3-ce3g8jdj@umail.furryterror.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191127035509.15011-1-ce3g8jdj@umail.furryterror.org>
References: <20191127035509.15011-1-ce3g8jdj@umail.furryterror.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Update the args structure, add the flags constant and the ioctl magic
number.

Signed-off-by: Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
---
 libbtrfsutil/btrfs.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/libbtrfsutil/btrfs.h b/libbtrfsutil/btrfs.h
index 944d5013..daa769fd 100644
--- a/libbtrfsutil/btrfs.h
+++ b/libbtrfsutil/btrfs.h
@@ -624,10 +624,14 @@ struct btrfs_ioctl_ino_path_args {
 struct btrfs_ioctl_logical_ino_args {
 	__u64				logical;	/* in */
 	__u64				size;		/* in */
-	__u64				reserved[4];
+	__u64				reserved[3];
+	__u64				flags;		/* in */
 	/* struct btrfs_data_container	*inodes;	out   */
 	__u64				inodes;
 };
+/* Return every ref to the extent, not just those containing logical block.
+ * Requires logical == extent bytenr. */
+#define BTRFS_LOGICAL_INO_ARGS_IGNORE_OFFSET    (1ULL << 0)
 
 enum btrfs_dev_stat_values {
 	/* disk I/O failure stats */
@@ -927,6 +931,8 @@ enum btrfs_err_code {
 				   struct btrfs_ioctl_feature_flags[3])
 #define BTRFS_IOC_RM_DEV_V2 _IOW(BTRFS_IOCTL_MAGIC, 58, \
 				   struct btrfs_ioctl_vol_args_v2)
+#define BTRFS_IOC_LOGICAL_INO_V2 _IOWR(BTRFS_IOCTL_MAGIC, 59, \
+                                     struct btrfs_ioctl_logical_ino_args)
 #define BTRFS_IOC_GET_SUBVOL_INFO _IOR(BTRFS_IOCTL_MAGIC, 60, \
 				struct btrfs_ioctl_get_subvol_info_args)
 #define BTRFS_IOC_GET_SUBVOL_ROOTREF _IOWR(BTRFS_IOCTL_MAGIC, 61, \
-- 
2.20.1

