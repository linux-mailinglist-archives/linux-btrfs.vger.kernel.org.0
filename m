Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8ED021D5EE
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 14:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbgGMM3K (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 08:29:10 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:19772 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729769AbgGMM3K (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 08:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594643349; x=1626179349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yLKb+mCSypdsSYO1VUcVdZJ1EIwC9TT+rrZ82dWZOKc=;
  b=Q4hqcYbS+urvPCXP0lFMgAiX0nvlIVts4WSaKLQ0KQnRJXNI9SNmEvUX
   oWW97yN9mil6ZXE9+QkkhP2fDJsqO97WGWj8MQDIkLIcEBZtdj89y5VMe
   gPN3TNZqdyFd/wRqzJlKC9UUJyl7dybL+EEW3HS6qlpRc/mLg1Y6QjrlP
   uItgIn6xFAIVNKmYp+MSPya5Zh4WUMWyKgbpVUqr0kSpdf4tF0nqcrjC+
   D1QS63GeP05ca/pPVtvADsQwWF3bhrx8qs/hfFrZXa8tWNCaiK0ZAB/Pa
   uqWgxuxwbi9Qm5BLCnWBRble2M2Xvo6i2j2+1F24G2Z7b78lsVxbfz5jw
   Q==;
IronPort-SDR: ps04Zn0a4TmCPTD790RbvG9AcaBaSQMcAMhkBBo3AlvoSIjFHrwRl86Z4tRM++opu0oWxtM/ww
 UH7tnSfplc79o8+dqocQJdqwUponM0G67+qpEBBhZVsgQ/MjW7PZ5MTb6RGDJsG3cTknHqpNB0
 BS2HpW94yZ8sYnOSmewmbcN6d2FiOwLIyhqxYfNgzzrNbJWk0z6/BZLSxoQ8Kt97FKR0bIDzYt
 GywYVmwxSKQhmSpPIysKRFXvPCDSbFum7vvknwvGuajXWqBaQhLkq9UlW3ZN7neysyzkar/NVB
 gWE=
X-IronPort-AV: E=Sophos;i="5.75,347,1589212800"; 
   d="scan'208";a="142312953"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2020 20:29:09 +0800
IronPort-SDR: wz5ds+RLWeztpTJVYWEfPhcYRGZG0jiIs/bfY0EPX8Ax900eYoWDMSQOPF9O1GjrDU4qPzjhAW
 QKVmHMxwDeX02z670vCvEPWF1EQO61hqs=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 05:17:38 -0700
IronPort-SDR: /B6J6a5EbdkySiPYfUTuGXxkRBAz/IIUwT7A//YAyehzfYF6bi9LzTkRrdbPpYWF4scoFP/mQA
 s39ChjmNEX5g==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Jul 2020 05:29:09 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 3/4] btrfs: add metadata_uuid to fsinfo ioctl
Date:   Mon, 13 Jul 2020 21:29:00 +0900
Message-Id: <20200713122901.1773-4-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200713122901.1773-1-johannes.thumshirn@wdc.com>
References: <20200713122901.1773-1-johannes.thumshirn@wdc.com>
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
index b8373723eb4a..69b88f6cb57f 100644
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
 	__u16 csum_size;			/* out */
 	__u64 flags;				/* in/out */
 	__u64 generation;			/* out */
-	__u8 reserved[960];			/* pad to 1k */
+	__u8 metadata_uuid[BTRFS_FSID_SIZE];	/* out */
+	__u8 reserved[944];			/* pad to 1k */
 };
 
 
-- 
2.26.2

