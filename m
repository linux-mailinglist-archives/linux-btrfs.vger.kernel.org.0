Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45E1B21D5EF
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 14:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbgGMM3L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 08:29:11 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:19772 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbgGMM3L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 08:29:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594643350; x=1626179350;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CUKhAJ1tQoDa8nujkZUVHJztYhKoDRlqd/pD4jO0HKs=;
  b=NlESBrr3jD2vGSOvDj5WgcjZAPZnpM+8grsSxKY5qFBaSIE8rLZEvV4g
   jkg49DiZV6/I+Uq7jREjcdltwGJjdxo5F5Xima17wJT8uVhfW2Ak2oXaF
   x+q6/ZImUk53iLGqHKFKphoFRhA3+g1/gVDyJNusVX2BFKFp2Vg3IMlx+
   1y7KKcmibT0Eqt0y5ArJQ0dmvkInEx5mygPJ/8RFcciedk/HU27W4G7Lw
   Oqz0gGGty2MugtUxcFQLQRb/OEaXZ8G3Gbq9ZrreLuzN2SnjGzYq4fcrW
   LT/LkpsDBsk/wRrYtS1SIwg+TnlOrScdSyrghMKY5NUcg588j5Qm4pB2Q
   A==;
IronPort-SDR: c/kkOf6hid6wIHIxl2vM29x5wzzhHyce5yjZqNqK9UjQC/i1efyDXEi2OT6bkXqJ61uDxzfvQV
 hg7ws1pWzxJv77406Sd62caLMWEDVyd4tdwtcSrvHSBXp5ZdGLzbwiMFZjfVsC67rxLtq21tbh
 u9QcTn7vGIzVMG2U/5DoCMQFfHdD51Afevr0vuF30LKh7CTlb2gl/Iajx5ncaWs2aRKPyFo0Zg
 8M52HCEWctBn6sfggnlzylL5hR3E6+71A22UtvelsIDfypszeAgZi66XJPlYNhGcJ+/dWo6MTu
 M04=
X-IronPort-AV: E=Sophos;i="5.75,347,1589212800"; 
   d="scan'208";a="142312954"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2020 20:29:10 +0800
IronPort-SDR: 8PFbZIVxLBU0kR8busD5rfzyISQLRh6orSCZ0Nw9IyGNRW2cFfWTdw3sII+2OBq/cmFmbetcKc
 LlUHpQJazm0kaLN304qfYJxCI1Gjc3S24=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 05:17:39 -0700
IronPort-SDR: 4xTtActgkdkSOHTIONV5BXEliGhx9rLhm2ecd4GoPk+i4PURpHigiLmo2ul3rIbiq5VOpJunrz
 LV/vmg/X2rCQ==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Jul 2020 05:29:09 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 4/4] btrfs: assert sizes of ioctl structures
Date:   Mon, 13 Jul 2020 21:29:01 +0900
Message-Id: <20200713122901.1773-5-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200713122901.1773-1-johannes.thumshirn@wdc.com>
References: <20200713122901.1773-1-johannes.thumshirn@wdc.com>
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
index 69b88f6cb57f..d3c363398e10 100644
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
 	__u8 reserved[944];			/* pad to 1k */
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

