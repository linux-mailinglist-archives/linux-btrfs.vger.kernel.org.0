Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC70621B7C7
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jul 2020 16:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbgGJOFU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jul 2020 10:05:20 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:44327 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgGJOFT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jul 2020 10:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594389918; x=1625925918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l06KmaMxHbL+wbj1Co6GqOu92df8iEoHErDiZ2pTa8Y=;
  b=rS1Xgm9l1SkhkIuYVzBqCv2ywngfhxCh26/KDCtZMfVbVacL9eiQtwS9
   m89HDl6VtyBxEVIU0Ep2v1nEm1Zf17GQFmjToN6iqFplgUYPWCVDBlSFV
   dh1uYEFiOFD9LI6a7qCFsXxmo75lon6xI2wAiwKRQOzA0E1lwhvkGYOaw
   rS3/V+Xbqi6VblhhtfFUQuSVOUUTig6abg+zMxFD6aT1cHNPl8vac0y4T
   kpF8DobUxOVnjK13aELvMaXzbGA3gtERPIyud4CtFNmcHre/m6tm2jJx+
   iYgdxgtPu22LuUtqRa/IOTXP8i8FWHfN7/8EB5LbqLtv13Yd/Gurx1zLZ
   Q==;
IronPort-SDR: axJhN/JmldKUZRucmDS7YOV9OL7YdPMSa2tH097QJc5NWY/rrO/d66C7hs0Xs9EyubM1PfL9td
 1HXQZZFtKQLbA/VUUCMSBD3IwW0Xsr2IpPaiq0WStM8/hAC7eP62W0D99KkgTDccb89JtcBruM
 tIJ3puNPHcpSL4RJIG/I9W4QGoR+BSOJ+552xBFId6cbc02e8ux355w53qtsFtNAQ4BKmRz+jd
 BeopW6StIuaYd3k7XMh2SxlhWcOi7Wx92PZL+WGZypU9PN4nX7G2OGQLXmll6b6tNzLa6nceUG
 GI8=
X-IronPort-AV: E=Sophos;i="5.75,336,1589212800"; 
   d="scan'208";a="143458176"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2020 22:05:18 +0800
IronPort-SDR: 8uDq/yI+0IjE6JyAaGtTkRRSp+2xfVB0gljs66wKfqFDB2so7wyHQUCKXOPrquzpqdIBofWEGz
 ryw4atMlv1FOWlzaSF15BQTF5wCrUh1Ng=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 06:53:52 -0700
IronPort-SDR: 8591wSCWuFjn+hS7bv+qINSzfIa9PPfqdpf4YaQu4FHiTtJOtkFCaMf75C8jLliwXYoZX+vJyI
 Y5bo//svBVXg==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jul 2020 07:05:18 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 3/3] btrfs: assert sizes of ioctl structures
Date:   Fri, 10 Jul 2020 23:05:11 +0900
Message-Id: <20200710140511.30343-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200710140511.30343-1-johannes.thumshirn@wdc.com>
References: <20200710140511.30343-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When expanding ioctl interfaces we want to make sure we're not changing
the size of the structures, otherwise it can lead to incorrect transfers
between kernel and user-space.

Build time assert the size of each structure so we're not running into any
incompatibilities.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/uapi/linux/btrfs.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 0244e700782a..f4007272f302 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -32,6 +32,7 @@ struct btrfs_ioctl_vol_args {
 	__s64 fd;
 	char name[BTRFS_PATH_NAME_MAX + 1];
 };
+static_assert(sizeof(struct btrfs_ioctl_vol_args) == 4096);
 
 #define BTRFS_DEVICE_PATH_NAME_MAX	1024
 #define BTRFS_SUBVOL_NAME_MAX 		4039
@@ -190,6 +191,7 @@ struct btrfs_ioctl_scrub_args {
 	/* pad to 1k */
 	__u64 unused[(1024-32-sizeof(struct btrfs_scrub_progress))/8];
 };
+static_assert(sizeof(struct btrfs_ioctl_scrub_args) == 1024);
 
 #define BTRFS_IOCTL_DEV_REPLACE_CONT_READING_FROM_SRCDEV_MODE_ALWAYS	0
 #define BTRFS_IOCTL_DEV_REPLACE_CONT_READING_FROM_SRCDEV_MODE_AVOID	1
@@ -242,6 +244,7 @@ struct btrfs_ioctl_dev_info_args {
 	__u64 unused[379];			/* pad to 4k */
 	__u8 path[BTRFS_DEVICE_PATH_NAME_MAX];	/* out */
 };
+static_assert(sizeof(struct btrfs_ioctl_dev_info_args) == 4096);
 
 /*
  * Retrieve information about the filesystem
@@ -270,7 +273,7 @@ struct btrfs_ioctl_fs_info_args {
 	__u8 metadata_uuid[BTRFS_FSID_SIZE];	/* out */
 	__u8 reserved[952];			/* pad to 1k */
 };
-
+static_assert(sizeof(struct btrfs_ioctl_fs_info_args) == 1024);
 
 /*
  * feature flags
@@ -453,6 +456,7 @@ struct btrfs_ioctl_balance_args {
 
 	__u64 unused[72];			/* pad to 1k */
 };
+static_assert(sizeof(struct btrfs_ioctl_balance_args) == 1024);
 
 #define BTRFS_INO_LOOKUP_PATH_MAX 4080
 struct btrfs_ioctl_ino_lookup_args {
@@ -460,6 +464,7 @@ struct btrfs_ioctl_ino_lookup_args {
 	__u64 objectid;
 	char name[BTRFS_INO_LOOKUP_PATH_MAX];
 };
+static_assert(sizeof(struct btrfs_ioctl_ino_lookup_args) == 4096);
 
 #define BTRFS_INO_LOOKUP_USER_PATH_MAX (4080 - BTRFS_VOL_NAME_MAX - 1)
 struct btrfs_ioctl_ino_lookup_user_args {
@@ -475,6 +480,7 @@ struct btrfs_ioctl_ino_lookup_user_args {
 	 */
 	char path[BTRFS_INO_LOOKUP_USER_PATH_MAX];
 };
+static_assert(sizeof(struct btrfs_ioctl_ino_lookup_user_args) == 4096);
 
 /* Search criteria for the btrfs SEARCH ioctl family. */
 struct btrfs_ioctl_search_key {
@@ -553,6 +559,7 @@ struct btrfs_ioctl_search_args {
 	struct btrfs_ioctl_search_key key;
 	char buf[BTRFS_SEARCH_ARGS_BUFSIZE];
 };
+static_assert(sizeof(struct btrfs_ioctl_search_args) == 4096);
 
 struct btrfs_ioctl_search_args_v2 {
 	struct btrfs_ioctl_search_key key; /* in/out - search parameters */
@@ -710,6 +717,7 @@ struct btrfs_ioctl_get_dev_stats {
 	 */
 	__u64 unused[128 - 2 - BTRFS_DEV_STAT_VALUES_MAX];
 };
+static_assert(sizeof(struct btrfs_ioctl_get_dev_stats) == 1032);
 
 #define BTRFS_QUOTA_CTL_ENABLE	1
 #define BTRFS_QUOTA_CTL_DISABLE	2
-- 
2.26.2

