Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E9C421ED3
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Oct 2021 08:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhJEGZ0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 Oct 2021 02:25:26 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:61155 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbhJEGZW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 Oct 2021 02:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1633415012; x=1664951012;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8a0p9tHuZEgvLVcGi902v3FJhMIjJqUyXJToqh9LM5I=;
  b=MX1aTuV9ct/0R4KG0zHHPfru+XamslQHtytKJHgShBnel/uwfVsh0KCo
   cvMIPmb714OUwukMkJkyxnzjvekVSu+xyk2gDJY2F7FC2lKAQefErElST
   qrnOlBRIUM0oh6Pw+87/ogcpsO33FqoUJ7JvfHAqs0c8pITfvBRPnCcfV
   ZQaV/r39FqKaANpMwpHlrGxvF7rE6YQJLTC/tEzrC1HXNhkys2+e9jo6G
   8gk6DlLG9O45/oOcoxgblBiTpr9eRAI7GIoZ/uFpeDy3aBvvhyJm/Jl+C
   8l7a5RluAqJS09t7tI0Q1RbHZWzed/TcE+dNLsZ8x5ZnIOgwP1QVEas1k
   g==;
X-IronPort-AV: E=Sophos;i="5.85,347,1624291200"; 
   d="scan'208";a="186648916"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2021 14:23:32 +0800
IronPort-SDR: /dfe4MjhQrTlY44vqpVkYtOShHIFxjkGki0uhl0804aYTkTbe/5ySDo56/HGTmjtdO79GTwN8X
 lqiCOojxl30ZX2LXgLLKTKIsCzyhhd23QACRMpCOURXg2gvshKKejWx6QyYnT59p39LPb04nuH
 BFVf6d7Wcqoi5eb6qb2Iw8PuTzk23Qje3lTuk4T8Ww2lCJUgnBSYEs9049akxv5At2ht6QruOB
 Q9Q8XN0f2lawK37FSBKVKSr10TWP2zkwMYweDQxwv5s7rETNrZWDqq90/0B0rSThram98XhC6x
 U/MIsbqPwzxiR1RJ9cn0o6Kl
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 22:57:56 -0700
IronPort-SDR: 9w98P12zR0AGdu5LwEivnV2QmThAkWDusjy8qJ+NeXVvkuZtSGiVZjelNffmMDzJhuru+Qs0Ub
 LcKiqZ/Wt/ylNWpQ/7wUKQgmtkULP/sgI/KO3a4FahZVrzM5lCdqcM4Tav4VwbPG3qZfn2aQw/
 A1j3lviV9iedUI7sLPzi+hu0c7+stOjTAbQBKBqzrTbb1ZfnVnbwy6jDHe/VATwL3eKbYXjSXR
 HphJQm/i/qrYarw3KCdyrOhgBmKoKIlIBaKAzDaxyMpkA6erfl8NfIqQ501Lfo9VIdPo+LMuOH
 4hE=
WDCIronportException: Internal
Received: from g8961f3.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.178])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Oct 2021 23:23:32 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 5/7] btrfs-progs: introduce btrfs_pread wrapper for pread
Date:   Tue,  5 Oct 2021 15:23:03 +0900
Message-Id: <20211005062305.549871-6-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211005062305.549871-1-naohiro.aota@wdc.com>
References: <20211005062305.549871-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Wrap pread with btrfs_pread as well.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 common/device-utils.h     | 10 ++++++++++
 kernel-shared/disk-io.c   |  4 +++-
 kernel-shared/extent_io.c |  7 ++++---
 kernel-shared/zoned.c     |  2 +-
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/common/device-utils.h b/common/device-utils.h
index 767dab4370e1..f79e746840fc 100644
--- a/common/device-utils.h
+++ b/common/device-utils.h
@@ -60,9 +60,19 @@ static inline ssize_t btrfs_pwrite(int fd, void *buf, size_t count,
 
 	return btrfs_direct_pio(WRITE, fd, buf, count, offset);
 }
+static inline ssize_t btrfs_pread(int fd, void *buf, size_t count, off_t offset,
+				  bool direct)
+{
+	if (!direct)
+		return pread(fd, buf, count, offset);
+
+	return btrfs_direct_pio(READ, fd, buf, count, offset);
+}
 #else
 #define btrfs_pwrite(fd, buf, count, offset, direct) \
 	({ (void)(direct); pwrite(fd, buf, count, offset); })
+#define btrfs_pread(fd, buf, count, offset, direct) \
+	({ (void)(direct); pread(fd, buf, count, offset); })
 #endif
 
 #endif
diff --git a/kernel-shared/disk-io.c b/kernel-shared/disk-io.c
index 1cda6f3a98af..740500f9fdc9 100644
--- a/kernel-shared/disk-io.c
+++ b/kernel-shared/disk-io.c
@@ -35,6 +35,7 @@
 #include "kernel-shared/print-tree.h"
 #include "common/rbtree-utils.h"
 #include "common/device-scan.h"
+#include "common/device-utils.h"
 #include "crypto/hash.h"
 
 /* specified errno for check_tree_block */
@@ -476,7 +477,8 @@ int read_extent_data(struct btrfs_fs_info *fs_info, char *data, u64 logical,
 		goto err;
 	}
 
-	ret = pread64(device->fd, data, *len, multi->stripes[0].physical);
+	ret = btrfs_pread(device->fd, data, *len, multi->stripes[0].physical,
+			  fs_info->zoned);
 	if (ret != *len)
 		ret = -EIO;
 	else
diff --git a/kernel-shared/extent_io.c b/kernel-shared/extent_io.c
index b5984949f431..af09ade4025f 100644
--- a/kernel-shared/extent_io.c
+++ b/kernel-shared/extent_io.c
@@ -793,7 +793,8 @@ int read_extent_from_disk(struct extent_buffer *eb,
 			  unsigned long offset, unsigned long len)
 {
 	int ret;
-	ret = pread(eb->fd, eb->data + offset, len, eb->dev_bytenr);
+	ret = btrfs_pread(eb->fd, eb->data + offset, len, eb->dev_bytenr,
+			  eb->fs_info->zoned);
 	if (ret < 0) {
 		ret = -errno;
 		goto out;
@@ -850,8 +851,8 @@ int read_data_from_disk(struct btrfs_fs_info *info, void *buf, u64 offset,
 			return -EIO;
 		}
 
-		ret = pread(device->fd, buf + total_read, read_len,
-			    multi->stripes[0].physical);
+		ret = btrfs_pread(device->fd, buf + total_read, read_len,
+				  multi->stripes[0].physical, info->zoned);
 		kfree(multi);
 		if (ret < 0) {
 			fprintf(stderr, "Error reading %llu, %d\n", offset,
diff --git a/kernel-shared/zoned.c b/kernel-shared/zoned.c
index c2cce3b5f366..f5d2299fc744 100644
--- a/kernel-shared/zoned.c
+++ b/kernel-shared/zoned.c
@@ -593,7 +593,7 @@ size_t btrfs_sb_io(int fd, void *buf, off_t offset, int rw)
 		return ret;
 
 	if (rw == READ)
-		ret_sz = pread64(fd, buf, count, mapped);
+		ret_sz = btrfs_pread(fd, buf, count, mapped, true);
 	else
 		ret_sz = btrfs_pwrite(fd, buf, count, mapped, true);
 
-- 
2.33.0

