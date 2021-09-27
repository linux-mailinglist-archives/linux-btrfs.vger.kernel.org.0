Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB31E418E1B
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Sep 2021 06:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbhI0ERp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Sep 2021 00:17:45 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:56793 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhI0ERp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Sep 2021 00:17:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632716167; x=1664252167;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1mT84zWYTQOJVs8RO+eD/0Y9ALT8W91lxu0YhkGD1SY=;
  b=WelWK9Io7e1FB4PcFxEyEkXZQSaWPyKkLdZgADsMgK9WmK8s57Zq6PS0
   9lnE9jU6+snPj5w04qXBDRozv8r02hVAfNo0ZruyYSfVudWCvAEoaWBae
   +skzfgWoL81rDelbTrSgPTwslSAJSHRX5G4NlQcWiyM/U2qVCBVGMH5Es
   XAca0nqT0r7tebMDUD4wM/Jfppnug5Yw1rdQQpd+mMC41p0XGj0XAeeGr
   LnZvqfqFb6D+x6uc3CaUVVtntRh6LKcTqA8JcYYkoNXoFFu72kUXPfczv
   OK5B6rF4famQUEzwZxha79F4eBdYH1Gs2bqCtwZ4ydKpbue7X4tVKwdkj
   g==;
X-IronPort-AV: E=Sophos;i="5.85,325,1624291200"; 
   d="scan'208";a="180095513"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2021 12:16:07 +0800
IronPort-SDR: Btpih6xdWyYUoJsbw3xwBdVJ9ZGY3GkySQwaciui64VEiaQZ/A2t1LUd+5V068ylLp89kzTsbC
 vYFZHQooupYdetKj7SZy0lOerI2ZGMrpDXfaa7mu2s8qG3RSpb9bJaX2Acyd3KqLYHah2ofPH7
 pJTxArZthJnZOe7dQx+EimsKZ6IgC6PL9aDk1SSMt0bLbEKoiiAh7PUKch28zwYs+YahpiB89G
 xDzO6JdZhche5Dy2lhfEjw2Y0dvTktDjCKCMQ3ZI+PgT3Fu1eHaneff+Y0zO/IIBCgvjVUU6Ay
 rqQrCHOb/Vqj9Np/sbNTtb91
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 20:50:41 -0700
IronPort-SDR: aOncc9ORqT98Kjktl5Kds0xrDNG9R+C4q8AjV8/7qTTs909ZMiigORAxGLeCYk+W2VsuB/0g/m
 m/TimdD3ajw1eIKJNXfgmcWEQX5J4r9OgykE4jGrtp2rOxjMgvB+x6I+OR/bseSWbkLqL+MopT
 C4dSsbRQzQRBDKE8JbNQ6MpZQWNgto0anrR5QU1DJqDIpfrhJQCCQFwd+dHdCpf7jrZ/QDEeLY
 E7MVETt5+kGL/hr6yHzSjrLNMixPiW/58xnfV6kQbJC30e+BK6gW8JN1NpxyxAQxtNlVzOIuT+
 POw=
WDCIronportException: Internal
Received: from 1r3v0f3.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.32])
  by uls-op-cesaip02.wdc.com with ESMTP; 26 Sep 2021 21:16:08 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 3/5] btrfs-progs: introduce btrfs_pread wrapper for pread
Date:   Mon, 27 Sep 2021 13:15:52 +0900
Message-Id: <20210927041554.325884-4-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210927041554.325884-1-naohiro.aota@wdc.com>
References: <20210927041554.325884-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Wrap pread with btrfs_pread as well.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
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

