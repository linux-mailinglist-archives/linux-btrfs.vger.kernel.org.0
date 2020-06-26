Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54ADD20AD27
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jun 2020 09:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728751AbgFZHaZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jun 2020 03:30:25 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:48113 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgFZHaZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jun 2020 03:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593156625; x=1624692625;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gn/2UNIvcfAtMOfhqJFG5Q3ZcYHcf2dIhGkDKpA8yQM=;
  b=U6R7cz4Kgg1GwGSxG1SC9FU7Rqv0q2rJ5jUotS2VdHd2+gLjED+s8Ej0
   9bCXTr8q3DzXNo55vxhS+DojeOgDCCJcDRRpOq4TACLB2cCcTlGb047aP
   Dn3fsvATtg3i47KQ2M87gKNP+iuuIsHb1BRZeBf5J81Tlc9kLajJz2Z5/
   J0DXCVBQOsE1au2UpBD5mYq5DasE3iha3VaWMj2IK2dMzA6jxIrFhNSI6
   9LAHuFECtqRDLLzCrlDV4dv0w+JsS79th4H6VZUSZE5t+Eachy3ps4mww
   b7p+6XNB0MHI/WTwFvfxqJNUkkDAu+XI8frKu1ll1ZLbo1QmCt/WIRD5K
   g==;
IronPort-SDR: /9DlAYr3DtTZRyMg0eAicoV1TH7+68rwN0WMPbgfoeJvw4OAwl7o+7F8BBGYc1FPIVyyNgBXwo
 2pMOjddB5LyYrfEWz4jT3CJy1heCXwnonvBYos9OLWwPsp1jTQwcTsOlbvOmUX04coaRRPHDEq
 Hyws89gAG7FNHQKt6w0z0ZDaxqUiJksyTfjNT2dOCHY+Lz0Mx0mq8LdCczE9LO/qvEOBRnOQnF
 A0d0l8LGH4922w+HH/chBBLg30za5jg1uoGMHbTF3hXneDIJV0UoYyXz7wCiyCL52sFRNdAMmc
 a84=
X-IronPort-AV: E=Sophos;i="5.75,282,1589212800"; 
   d="scan'208";a="145308206"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 15:30:25 +0800
IronPort-SDR: s7ncAIIoyNs2Ez90d138r04isK31o+M5ttyibCYuKGs5mvO6vHgJ8lkINtyAz8WSaaLSot7ttR
 173j+x9phN7yyrsEVZrvJxTLv8pmzPSZA=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 00:19:23 -0700
IronPort-SDR: EunSxXfBau/ANQog4ij3z/GncjMZQNLhnI/kSdlgL7BMphHSy0Z7ZNWCPbgt0OcleaLzc3LZiM
 WWSc6ON66lnw==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Jun 2020 00:30:25 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2] btrfs: pass checksum type via BTRFS_IOC_FS_INFO ioctl
Date:   Fri, 26 Jun 2020 16:30:19 +0900
Message-Id: <20200626073019.24003-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

With the recent addition of filesystem checksum types other than CRC32c,
it is not anymore hard-coded which checksum type a btrfs filesystem uses.

Up to now there is no good way to read the filesystem checksum, apart from
reading the filesystem UUID and then query sysfs for the checksum type.

Add a new csum_type field to the BTRFS_IOC_FS_INFO ioctl command which
usually is used to query filesystem features. Also add a flags member
indicating that the kernel responded with a set csum_type field.

To simplify further additions to the ioctl, also switch the padding to a
u8 array. Pahole was used to verify the result of this switch:

pahole -C btrfs_ioctl_fs_info_args fs/btrfs/btrfs.ko
struct btrfs_ioctl_fs_info_args {
        __u64                      max_id;               /*     0     8 */
        __u64                      num_devices;          /*     8     8 */
        __u8                       fsid[16];             /*    16    16 */
        __u32                      nodesize;             /*    32     4 */
        __u32                      sectorsize;           /*    36     4 */
        __u32                      clone_alignment;      /*    40     4 */
        __u32                      flags;                /*    44     4 */
        __u16                      csum_type;            /*    48     2 */
        __u8                       reserved[974];        /*    50   974 */

        /* size: 1024, cachelines: 16, members: 9 */
};

Fixes: 3951e7f050ac ("btrfs: add xxhash64 to checksumming algorithms")
Fixes: 3831bf0094ab ("btrfs: add sha256 to checksumming algorithm")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
Changes to v1:
* add 'out' comment to be consistent (Hans)
* remove le16_to_cpu() (kbuild robot)
* switch padding to be all u8 (David)
---
 fs/btrfs/ioctl.c           |  2 ++
 include/uapi/linux/btrfs.h | 13 +++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index b3e4c632d80c..6c9d0c3a5e7e 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3217,6 +3217,8 @@ static long btrfs_ioctl_fs_info(struct btrfs_fs_info *fs_info,
 	fi_args->nodesize = fs_info->nodesize;
 	fi_args->sectorsize = fs_info->sectorsize;
 	fi_args->clone_alignment = fs_info->sectorsize;
+	fi_args->csum_type = btrfs_super_csum_type(fs_info->super_copy);
+	fi_args->flags |= BTRFS_FS_INFO_FLAG_CSUM_TYPE;
 
 	if (copy_to_user(arg, fi_args, sizeof(*fi_args)))
 		ret = -EFAULT;
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index e6b6cb0f8bc6..ee15ece4f477 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -250,10 +250,19 @@ struct btrfs_ioctl_fs_info_args {
 	__u32 nodesize;				/* out */
 	__u32 sectorsize;			/* out */
 	__u32 clone_alignment;			/* out */
-	__u32 reserved32;
-	__u64 reserved[122];			/* pad to 1k */
+	__u32 flags;				/* out */
+	__u16 csum_type;			/* out */
+	__u8 reserved[974];			/* pad to 1k */
 };
 
+/*
+ * fs_info ioctl flags
+ *
+ * Used by:
+ * struct btrfs_ioctl_fs_info_args
+ */
+#define BTRFS_FS_INFO_FLAG_CSUM_TYPE			(1 << 0)
+
 /*
  * feature flags
  *
-- 
2.26.2

