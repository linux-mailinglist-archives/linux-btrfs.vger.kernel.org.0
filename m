Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E650920710E
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 12:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388786AbgFXKWL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 06:22:11 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:5861 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387962AbgFXKVq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 06:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592994106; x=1624530106;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n+0tLc60AfZoNZhKMmQffVEvt8paBNuJAZ4jJwWCP9o=;
  b=Ks0fkAQmo/SlmqxgOiSkCXjAFF839o4XzbllnT+ab8t0feFdZfO9MD0n
   6BOJH48rcBfd0hxImFb600qU0JgTtw0ZSAV3VEw/7VtA5DUXXSspxlJvC
   mIf88KotHOcPYVWA6Nnjki5fNkJfoctYQR2AgaEzUpHnfozAr+LTu93qi
   tUaQe3DOg2gZGJEogd4P+MXo3LFAOu3odV3g7jClT4uDuPpyrWygWYneK
   3A8nUbanN8WBV4PgkaK54D+avvvvPkNfm4eJDEWdOG+RTMuBlwY2IsWE2
   o0W6mvBKE/CwjVevOwuCV3nbSU2q1kDgcD8sG7gHqzf77a/03+ispS6mj
   A==;
IronPort-SDR: 1PFJxmaDgkWTw1vcmiORTURNz5D/cnXE8xVlbT2SqRGxrx4T/Rk/fk6Hs4Y4MPIvS/jb8O3Gw9
 E2SWmbrqgU7P53yJqhtgiYwlxlVX+YPCRCnpXcDeCMERptVuDlZFq3yG8v1LgkV5XPs5JGU4GK
 56bVcAbUayAKbHv44E/dub0uHFtWPUT/R9MuO/Ul20FdQh+wsiT+4SgXn+4a2bCYlZTiN2gEu7
 dREh/NtHA8Qk++U6EqpImZ6QjGeOcn62AYllwQvc/bzH2lkUhYoRqXbX3gFMOf6HSSjbzCb4dO
 0QE=
X-IronPort-AV: E=Sophos;i="5.75,274,1589212800"; 
   d="scan'208";a="145114321"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2020 18:21:42 +0800
IronPort-SDR: +u7KUtLtw7O1dCMF5FHtkZk3xrRllLV5VwWNDvJEP4bllXCAPMc4S2X3f+d1+cLMxhhOUW+TjB
 aZWwtqAzajZF58ZiKbTDAg5OBAayF61ic=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2020 03:10:44 -0700
IronPort-SDR: JaBwdqgiJTuJyITXRWPMhHsRpe0WgrdOhgjx62ohOWbLWhNwpXyncqgl3kvIh9WR2UX6hc5g2P
 iPKMrCBvPoLA==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Jun 2020 03:21:42 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: pass checksum type via BTRFS_IOC_FS_INFO ioctl
Date:   Wed, 24 Jun 2020 19:21:36 +0900
Message-Id: <20200624102136.12495-1-johannes.thumshirn@wdc.com>
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

Fixes: 3951e7f050ac ("btrfs: add xxhash64 to checksumming algorithms")
Fixes: 3831bf0094ab ("btrfs: add sha256 to checksumming algorithm")
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ioctl.c           |  3 +++
 include/uapi/linux/btrfs.h | 13 ++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index b3e4c632d80c..16062720f5f3 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3217,6 +3217,9 @@ static long btrfs_ioctl_fs_info(struct btrfs_fs_info *fs_info,
 	fi_args->nodesize = fs_info->nodesize;
 	fi_args->sectorsize = fs_info->sectorsize;
 	fi_args->clone_alignment = fs_info->sectorsize;
+	fi_args->csum_type =
+			le16_to_cpu(btrfs_super_csum_type(fs_info->super_copy));
+	fi_args->flags |= BTRFS_FS_INFO_FLAG_CSUM_TYPE;
 
 	if (copy_to_user(arg, fi_args, sizeof(*fi_args)))
 		ret = -EFAULT;
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index e6b6cb0f8bc6..161d9100c2a6 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -250,10 +250,21 @@ struct btrfs_ioctl_fs_info_args {
 	__u32 nodesize;				/* out */
 	__u32 sectorsize;			/* out */
 	__u32 clone_alignment;			/* out */
+	__u32 flags;				/* out */
+	__u16 csum_type;
+	__u16 reserved16;
 	__u32 reserved32;
-	__u64 reserved[122];			/* pad to 1k */
+	__u64 reserved[121];			/* pad to 1k */
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

