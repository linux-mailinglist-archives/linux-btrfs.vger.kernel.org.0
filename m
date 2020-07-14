Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72F8821ECEB
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Jul 2020 11:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgGNJdA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jul 2020 05:33:00 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:2446 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgGNJc7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jul 2020 05:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594719180; x=1626255180;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fTeXNalSzUuChYYTbHuHdYabQyrNK8nnJw9zPqa1Zk8=;
  b=pYTo4M51CDTdFtRoWTUdOlhWvpDiMvEY3ZaY2P1BVDT9YlNECrCGMjXa
   GOAvZ1Iv3jyq9QZEL2KG0Cg7n+Dh6eQDf6HBoetNxyh6aSuv1BhWk62LG
   XzamlnNPiF7ejquyWT7ck+AaQ3KHeEl3fijwjYEBmZp2fxx4vKnNm452+
   oE8v9BfI0bEfzIvuKO2bNy17Ew3HCWhY07VhFtOjY7SBSBOIQALy7QdJc
   OeQUmIJWK6jPafFt739Zwgl9UGrYTY7QLffSOYrcjULQeztT/7BZJIX/+
   yTOS7LiX8yNPkMq6R641mGk/SIdl0kcSQvrIGzWckfLxrOuco75VIYW+C
   Q==;
IronPort-SDR: v4pT7V9LSfxbOXfzorenqgUWUAuqgkiMEKtPX54YbuUEu72z6TU4uoq5TELGBu5XFBn2HzGzDA
 ez7vNVm+63giLkD7XXSq/M8tRcyViCl156X8heOVR8l+nRmqcx19qCRIuKxLlh8rdDU7Mg4fsM
 AiF3GG1JJLYYyqJcaRbhtbcybNxe1ML6AOpEMBBs39ZTgPZlm8fjyiRUVd+TBYJn7ajw6DifnD
 w+IZAxGx727HxMKXffSBHbcwZbHSpw0k5WJW/YqEdJj7ED3hehKqgQWG3yrdJ2XWP8ss0FKhw5
 u2w=
X-IronPort-AV: E=Sophos;i="5.75,350,1589212800"; 
   d="scan'208";a="142550249"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2020 17:32:46 +0800
IronPort-SDR: kR1d4jUx2TO8EMb9IJNm89Sxxq7LpIEK2j7OFvecAfd1SXj1MnB5LhuJqufPCfX9rjqSP4vTZA
 oFdBL1eTo5a/P2FdXDI/4W26oy1rwfspY=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 02:20:40 -0700
IronPort-SDR: mIYSYESTJceZaVg5ux1boW8rIAJVPyyi39TVnKsVGe9TuWiGvzL32cnG+B6z7ftj6iU5sg5GjS
 lKjDaTiua4Qw==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 14 Jul 2020 02:32:45 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2] btrfs: assert sizes of ioctl structures
Date:   Tue, 14 Jul 2020 18:32:36 +0900
Message-Id: <20200714093236.6107-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
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
Changes to v1:
- Stub out static_assert() for user-space (0day Bot)
- Sync asserts with the ones from btrfs-progs (David)
---
 include/uapi/linux/btrfs.h | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 69b88f6cb57f..dc7205972f1c 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -22,6 +22,10 @@
 #include <linux/types.h>
 #include <linux/ioctl.h>
 
+#ifndef static_assert
+#define static_assert(x)
+#endif
+
 #define BTRFS_IOCTL_MAGIC 0x94
 #define BTRFS_VOL_NAME_MAX 255
 #define BTRFS_LABEL_SIZE 256
@@ -32,6 +36,7 @@ struct btrfs_ioctl_vol_args {
 	__s64 fd;
 	char name[BTRFS_PATH_NAME_MAX + 1];
 };
+static_assert(sizeof(struct btrfs_ioctl_vol_args) == 4096);
 
 #define BTRFS_DEVICE_PATH_NAME_MAX	1024
 #define BTRFS_SUBVOL_NAME_MAX 		4039
@@ -78,6 +83,7 @@ struct btrfs_qgroup_limit {
 	__u64	rsv_rfer;
 	__u64	rsv_excl;
 };
+static_assert(sizeof(struct btrfs_qgroup_limit) == 40);
 
 /*
  * flags definition for qgroup inheritance
@@ -95,11 +101,13 @@ struct btrfs_qgroup_inherit {
 	struct btrfs_qgroup_limit lim;
 	__u64	qgroups[0];
 };
+static_assert(sizeof(struct btrfs_qgroup_inherit) == 72);
 
 struct btrfs_ioctl_qgroup_limit_args {
 	__u64	qgroupid;
 	struct btrfs_qgroup_limit lim;
 };
+static_assert(sizeof(struct btrfs_ioctl_qgroup_limit_args) == 48);
 
 /*
  * Arguments for specification of subvolumes or devices, supporting by-name or
@@ -142,6 +150,7 @@ struct btrfs_ioctl_vol_args_v2 {
 		__u64 subvolid;
 	};
 };
+static_assert(sizeof(struct btrfs_ioctl_vol_args_v2) == 4096);
 
 /*
  * structure to report errors and progress to userspace, either as a
@@ -190,6 +199,7 @@ struct btrfs_ioctl_scrub_args {
 	/* pad to 1k */
 	__u64 unused[(1024-32-sizeof(struct btrfs_scrub_progress))/8];
 };
+static_assert(sizeof(struct btrfs_ioctl_scrub_args) == 1024);
 
 #define BTRFS_IOCTL_DEV_REPLACE_CONT_READING_FROM_SRCDEV_MODE_ALWAYS	0
 #define BTRFS_IOCTL_DEV_REPLACE_CONT_READING_FROM_SRCDEV_MODE_AVOID	1
@@ -200,6 +210,7 @@ struct btrfs_ioctl_dev_replace_start_params {
 	__u8 srcdev_name[BTRFS_DEVICE_PATH_NAME_MAX + 1];	/* in */
 	__u8 tgtdev_name[BTRFS_DEVICE_PATH_NAME_MAX + 1];	/* in */
 };
+static_assert(sizeof(struct btrfs_ioctl_dev_replace_start_params) == 2072);
 
 #define BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED	0
 #define BTRFS_IOCTL_DEV_REPLACE_STATE_STARTED		1
@@ -214,6 +225,7 @@ struct btrfs_ioctl_dev_replace_status_params {
 	__u64 num_write_errors;	/* out */
 	__u64 num_uncorrectable_read_errors;	/* out */
 };
+static_assert(sizeof(struct btrfs_ioctl_dev_replace_status_params) == 48);
 
 #define BTRFS_IOCTL_DEV_REPLACE_CMD_START			0
 #define BTRFS_IOCTL_DEV_REPLACE_CMD_STATUS			1
@@ -233,6 +245,7 @@ struct btrfs_ioctl_dev_replace_args {
 
 	__u64 spare[64];
 };
+static_assert(sizeof(struct btrfs_ioctl_dev_replace_args) == 2600);
 
 struct btrfs_ioctl_dev_info_args {
 	__u64 devid;				/* in/out */
@@ -242,6 +255,7 @@ struct btrfs_ioctl_dev_info_args {
 	__u64 unused[379];			/* pad to 4k */
 	__u8 path[BTRFS_DEVICE_PATH_NAME_MAX];	/* out */
 };
+static_assert(sizeof(struct btrfs_ioctl_dev_info_args) == 4096);
 
 /*
  * Retrieve information about the filesystem
@@ -270,7 +284,7 @@ struct btrfs_ioctl_fs_info_args {
 	__u8 metadata_uuid[BTRFS_FSID_SIZE];	/* out */
 	__u8 reserved[944];			/* pad to 1k */
 };
-
+static_assert(sizeof(struct btrfs_ioctl_fs_info_args) == 1024);
 
 /*
  * feature flags
@@ -314,6 +328,7 @@ struct btrfs_ioctl_feature_flags {
 	__u64 compat_ro_flags;
 	__u64 incompat_flags;
 };
+static_assert(sizeof(struct btrfs_ioctl_feature_flags) == 24);
 
 /* balance control ioctl modes */
 #define BTRFS_BALANCE_CTL_PAUSE		1
@@ -453,6 +468,7 @@ struct btrfs_ioctl_balance_args {
 
 	__u64 unused[72];			/* pad to 1k */
 };
+static_assert(sizeof(struct btrfs_ioctl_balance_args) == 1024);
 
 #define BTRFS_INO_LOOKUP_PATH_MAX 4080
 struct btrfs_ioctl_ino_lookup_args {
@@ -460,6 +476,7 @@ struct btrfs_ioctl_ino_lookup_args {
 	__u64 objectid;
 	char name[BTRFS_INO_LOOKUP_PATH_MAX];
 };
+static_assert(sizeof(struct btrfs_ioctl_ino_lookup_args) == 4096);
 
 #define BTRFS_INO_LOOKUP_USER_PATH_MAX (4080 - BTRFS_VOL_NAME_MAX - 1)
 struct btrfs_ioctl_ino_lookup_user_args {
@@ -475,6 +492,7 @@ struct btrfs_ioctl_ino_lookup_user_args {
 	 */
 	char path[BTRFS_INO_LOOKUP_USER_PATH_MAX];
 };
+static_assert(sizeof(struct btrfs_ioctl_ino_lookup_user_args) == 4096);
 
 /* Search criteria for the btrfs SEARCH ioctl family. */
 struct btrfs_ioctl_search_key {
@@ -553,6 +571,7 @@ struct btrfs_ioctl_search_args {
 	struct btrfs_ioctl_search_key key;
 	char buf[BTRFS_SEARCH_ARGS_BUFSIZE];
 };
+static_assert(sizeof(struct btrfs_ioctl_search_args) == 4096);
 
 struct btrfs_ioctl_search_args_v2 {
 	struct btrfs_ioctl_search_key key; /* in/out - search parameters */
@@ -561,12 +580,14 @@ struct btrfs_ioctl_search_args_v2 {
 					    *       to store item */
 	__u64 buf[0];                       /* out - found items */
 };
+static_assert(sizeof(struct btrfs_ioctl_search_args_v2) == 112);
 
 struct btrfs_ioctl_clone_range_args {
   __s64 src_fd;
   __u64 src_offset, src_length;
   __u64 dest_offset;
 };
+static_assert(sizeof(struct btrfs_ioctl_clone_range_args) == 32);
 
 /*
  * flags definition for the defrag range ioctl
@@ -606,7 +627,7 @@ struct btrfs_ioctl_defrag_range_args {
 	/* spare for later */
 	__u32 unused[4];
 };
-
+static_assert(sizeof(struct btrfs_ioctl_defrag_range_args) == 48);
 
 #define BTRFS_SAME_DATA_DIFFERS	1
 /* For extent-same ioctl */
@@ -632,6 +653,7 @@ struct btrfs_ioctl_same_args {
 	__u32 reserved2;
 	struct btrfs_ioctl_same_extent_info info[0];
 };
+static_assert(sizeof(struct btrfs_ioctl_same_args) == 24);
 
 struct btrfs_ioctl_space_info {
 	__u64 flags;
@@ -644,6 +666,7 @@ struct btrfs_ioctl_space_args {
 	__u64 total_spaces;
 	struct btrfs_ioctl_space_info spaces[0];
 };
+static_assert(sizeof(struct btrfs_ioctl_space_args) == 16);
 
 struct btrfs_data_container {
 	__u32	bytes_left;	/* out -- bytes not needed to deliver output */
@@ -660,6 +683,7 @@ struct btrfs_ioctl_ino_path_args {
 	/* struct btrfs_data_container	*fspath;	   out */
 	__u64				fspath;		/* out */
 };
+static_assert(sizeof(struct btrfs_ioctl_ino_path_args) == 56);
 
 struct btrfs_ioctl_logical_ino_args {
 	__u64				logical;	/* in */
@@ -710,6 +734,7 @@ struct btrfs_ioctl_get_dev_stats {
 	 */
 	__u64 unused[128 - 2 - BTRFS_DEV_STAT_VALUES_MAX];
 };
+static_assert(sizeof(struct btrfs_ioctl_get_dev_stats) == 1032);
 
 #define BTRFS_QUOTA_CTL_ENABLE	1
 #define BTRFS_QUOTA_CTL_DISABLE	2
@@ -718,12 +743,14 @@ struct btrfs_ioctl_quota_ctl_args {
 	__u64 cmd;
 	__u64 status;
 };
+static_assert(sizeof(struct btrfs_ioctl_quota_ctl_args) == 16);
 
 struct btrfs_ioctl_quota_rescan_args {
 	__u64	flags;
 	__u64   progress;
 	__u64   reserved[6];
 };
+static_assert(sizeof(struct btrfs_ioctl_quota_rescan_args) == 64);
 
 struct btrfs_ioctl_qgroup_assign_args {
 	__u64 assign;
@@ -735,6 +762,8 @@ struct btrfs_ioctl_qgroup_create_args {
 	__u64 create;
 	__u64 qgroupid;
 };
+static_assert(sizeof(struct btrfs_ioctl_qgroup_create_args) == 16);
+
 struct btrfs_ioctl_timespec {
 	__u64 sec;
 	__u32 nsec;
@@ -749,6 +778,7 @@ struct btrfs_ioctl_received_subvol_args {
 	__u64	flags;			/* in */
 	__u64	reserved[16];		/* in */
 };
+static_assert(sizeof(struct btrfs_ioctl_received_subvol_args) == 200);
 
 /*
  * Caller doesn't want file data in the send stream, even if the
@@ -783,6 +813,7 @@ struct btrfs_ioctl_send_args {
 	__u64 flags;			/* in */
 	__u64 reserved[4];		/* in */
 };
+static_assert(sizeof(struct btrfs_ioctl_send_args) == 72);
 
 /*
  * Information about a fs tree root.
@@ -859,6 +890,7 @@ struct btrfs_ioctl_get_subvol_rootref_args {
 		__u8 num_items;
 		__u8 align[7];
 };
+static_assert(sizeof(struct btrfs_ioctl_get_subvol_rootref_args) == 4096);
 
 /* Error codes as returned by the kernel */
 enum btrfs_err_code {
-- 
2.26.2

