Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73FB21B7C5
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jul 2020 16:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgGJOFS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jul 2020 10:05:18 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:44323 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgGJOFR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jul 2020 10:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594389917; x=1625925917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YK2ZrRMj6Fv+dGi0W72apCKS4QRuM0aiaj3tcQPTMyg=;
  b=QWgqD96Hf/aD/PrpAIyxM9ztwvYeHpkeOgWLo+zrj6Jqv0DfUGSVlOaK
   HVi3UH/XfsimM8ONEY6FWRbwyBP7J2rXR2OM+rktX8SBOf9PWQ0v+bXzW
   Q0p639g1DHGKwYr18q7fi/vOvCt52wA25IAQ27mGbIXn8O0FZTK/KGuFA
   QpTf/woeRCvWUA5M5gw+OQtM+wX2wUvfTE3uiQv4NarE927V90bsidt70
   /gWgvyJ0EAuGUncu7/zLsOk713HNLFlWQdr3DtbNDFkIqADZHXCMYXy7o
   DQJdKDtHJfmLi4rf1MG/MY0vd1oHfySEjPyw4DrQM5/xCyTiliwrXTIxq
   g==;
IronPort-SDR: DHWveoK6cTEMOa3Ll/LcTYEsMDZrZIGuW/qqOQBaYHiPtDRvJLbAK/IiFmcRpFvykzCgfxiwQd
 ecT/Fjo2tbHQRxdDBSwRUCGy+fmkJHwEtbK+CqmOLk56gCfUc1V2kDWvZjs9PzbMxaStkcxF5N
 UWZmYY42R8gLTZKhDNijFnusmV8Nf8MqVKL03QHAFbrKBxRrMZAzZCpIbN0nl3wstX5B7kthcg
 2/06Hdc9uNZJdBFSymut/MBnGjAtnd3c+q3F6A+9iqa5YMKRf9IisqPIgeTwniuRlFMzNokZUy
 Rwk=
X-IronPort-AV: E=Sophos;i="5.75,336,1589212800"; 
   d="scan'208";a="143458173"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2020 22:05:17 +0800
IronPort-SDR: 7IrlYVYky6/KoqoyBpKtqOhJKxKcNr0uGuK9nin4j5H5XjV7/WwLzj0i2qGWUFQ8kPnbIQhKzy
 n+5WlUp2fT8Jtygt6QKHUbowSSZJfwCFo=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 06:53:51 -0700
IronPort-SDR: QihaPjOkParyz9+3wb1LwHzQqf9cL0ehrvOj87DZjphejaXb9FVOt7ScRvr9ha2CuocOSSEgxH
 JMSu/PLirn9w==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jul 2020 07:05:16 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 1/3] btrfs: add filesystem generation to fsinfo ioctl
Date:   Fri, 10 Jul 2020 23:05:09 +0900
Message-Id: <20200710140511.30343-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200710140511.30343-1-johannes.thumshirn@wdc.com>
References: <20200710140511.30343-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add retrieval of the filesystem's generation to the fsinfo ioctl. This is
driven by setting the BTRFS_FS_INFO_FLAG_GENERATION flag in
btrfs_ioctl_fs_info_args::flags.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ioctl.c           | 5 +++++
 include/uapi/linux/btrfs.h | 6 +++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 3a566cf71fc6..f1b433ec09e8 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3247,6 +3247,11 @@ static long btrfs_ioctl_fs_info(struct btrfs_fs_info *fs_info,
 		fi_args->flags |= BTRFS_FS_INFO_FLAG_CSUM_INFO;
 	}
 
+	if (flags_in & BTRFS_FS_INFO_FLAG_GENERATION) {
+		fi_args->generation = fs_info->generation;
+		fi_args->flags |= BTRFS_FS_INFO_FLAG_GENERATION;
+	}
+
 	if (copy_to_user(arg, fi_args, sizeof(*fi_args)))
 		ret = -EFAULT;
 
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 0f81f69dbe22..19609dd5db18 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -250,6 +250,9 @@ struct btrfs_ioctl_dev_info_args {
 /* Request information about checksum type and size */
 #define BTRFS_FS_INFO_FLAG_CSUM_INFO			(1 << 0)
 
+/* Request information about filesystem generation */
+#define BTRFS_FS_INFO_FLAG_GENERATION			(1 << 1)
+
 struct btrfs_ioctl_fs_info_args {
 	__u64 max_id;				/* out */
 	__u64 num_devices;			/* out */
@@ -261,7 +264,8 @@ struct btrfs_ioctl_fs_info_args {
 	__u32 flags;				/* in/out */
 	__u16 csum_type;			/* out */
 	__u16 csum_size;			/* out */
-	__u8 reserved[972];			/* pad to 1k */
+	__u32 generation;			/* out */
+	__u8 reserved[968];			/* pad to 1k */
 };
 
 
-- 
2.26.2

