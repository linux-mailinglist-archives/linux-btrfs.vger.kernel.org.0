Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF3021B7C6
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jul 2020 16:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgGJOFT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jul 2020 10:05:19 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:44323 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgGJOFS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jul 2020 10:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594389918; x=1625925918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HWugiaPwn3sJIxbqz7Wu7VpJi9FU8Di0FfBW2wUBvyY=;
  b=f4+Ig0KIJ/7r5RFXhvD9sKYNm4TJJ/OlSrbXutPEF4mUf2BzQFHsrHSD
   089z6WADbkC88+TdUHAzC/TO0Ad7T8ay/DF8hKM4H1FBIgEXuqMqBnFam
   cRZ5jvPkS2fGpcviFeRG3hN0myQm0kGbEFu6Iz0AiQiq4L3587/Itc79K
   58/msUT1oLhALXFHv0RK9AO3nDpML2i3pxgCEWiBspaqq30vx8eIiKnJa
   Jr6K1KCgYiYRw2IhTpktoD+0Z7fblmm9so4eR1vrhC0GUTWz08gSEZgr4
   CQmYH6+tjZYjJ3vRquf8869Cvnfa775umjl7tj9cMbqi+Gnr09I7vlBR4
   g==;
IronPort-SDR: adnPtdX0fGT9jpc7aGXAAmOg6WdKf9Pq69sERAro+V8uwY+mNavcZClnStxclq4scJT1lCS44L
 b/tpFMiFMIO7irACD+I8+3rpw/jyiS9fIqfOosW6OFncFzsWY6gkjyPiJlChVGF2SqarJsLKET
 9x9waKE4LFz+pQTqEmjBq5RQOgUqZkwEddRMtpgZ+iq5spDdJGhFvEzCY5qUsWstMZyRsk1Plm
 aXNPgDMJjZAmHEYcknHdufdyF7SiyYYB7PdnyczfVis/LKDY9ZW3Erq9jDam/Rr1CFIbAkJv6y
 87Y=
X-IronPort-AV: E=Sophos;i="5.75,336,1589212800"; 
   d="scan'208";a="143458175"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jul 2020 22:05:17 +0800
IronPort-SDR: hIzoEJYY+1P33OpgFTL5gzSiK5ayFyKmgb7aSVRu0OhmGNhnI8T2+EglSyPftTP3Xt6g1xFpXZ
 3jvVDtviDbZzxGQbDsAsjGQ8fU+ZeYxhw=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2020 06:53:51 -0700
IronPort-SDR: 6/FgUn+YEbLvdc0RBo/o4J5Rw8P/pB3Kw4NQxo1db72Ipebzt4HkZ4uJ3Bm7rzZLzOGt60mwzQ
 z68V5IiUtYiA==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Jul 2020 07:05:17 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 2/3] btrfs: add metadata_uuid to fsinfo ioctl
Date:   Fri, 10 Jul 2020 23:05:10 +0900
Message-Id: <20200710140511.30343-3-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200710140511.30343-1-johannes.thumshirn@wdc.com>
References: <20200710140511.30343-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Add retrieval of the filesystem's metadata UUID to the fsinfo ioctl. This is
driven by setting the BTRFS_FS_INFO_FLAG_METADATA_UUID flag in
btrfs_ioctl_fs_info_args::flags.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ioctl.c           | 6 ++++++
 include/uapi/linux/btrfs.h | 5 ++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index f1b433ec09e8..9e4d6915b6c9 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -3252,6 +3252,12 @@ static long btrfs_ioctl_fs_info(struct btrfs_fs_info *fs_info,
 		fi_args->flags |= BTRFS_FS_INFO_FLAG_GENERATION;
 	}
 
+	if (flags_in & BTRFS_FS_INFO_FLAG_METADATA_UUID) {
+		memcpy(&fi_args->metadata_uuid, fs_devices->metadata_uuid,
+		       sizeof(fi_args->metadata_uuid));
+		fi_args->flags |= BTRFS_FS_INFO_FLAG_METADATA_UUID;
+	}
+
 	if (copy_to_user(arg, fi_args, sizeof(*fi_args)))
 		ret = -EFAULT;
 
diff --git a/include/uapi/linux/btrfs.h b/include/uapi/linux/btrfs.h
index 19609dd5db18..0244e700782a 100644
--- a/include/uapi/linux/btrfs.h
+++ b/include/uapi/linux/btrfs.h
@@ -252,6 +252,8 @@ struct btrfs_ioctl_dev_info_args {
 
 /* Request information about filesystem generation */
 #define BTRFS_FS_INFO_FLAG_GENERATION			(1 << 1)
+/* Request information about filesystem metadata UUID */
+#define BTRFS_FS_INFO_FLAG_METADATA_UUID		(1 << 2)
 
 struct btrfs_ioctl_fs_info_args {
 	__u64 max_id;				/* out */
@@ -265,7 +267,8 @@ struct btrfs_ioctl_fs_info_args {
 	__u16 csum_type;			/* out */
 	__u16 csum_size;			/* out */
 	__u32 generation;			/* out */
-	__u8 reserved[968];			/* pad to 1k */
+	__u8 metadata_uuid[BTRFS_FSID_SIZE];	/* out */
+	__u8 reserved[952];			/* pad to 1k */
 };
 
 
-- 
2.26.2

