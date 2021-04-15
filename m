Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0EF36019E
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Apr 2021 07:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhDOFak (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Apr 2021 01:30:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:59094 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229560AbhDOFai (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Apr 2021 01:30:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1618464615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=QNinT3Q0efuONN2a0cNfdfHv0mSLRs+s1n+JoXbevMY=;
        b=BruTDmqx0vZa073B70uGqViJdlUPFFFTcRIErlR9jFwPFNns4NUKj+BH7UBAnUqbyIpQci
        gowt85aNcxmgXzCQ+C2EB/C7KEPXg0LP0jbVt8H6aTZb9kYy/YycMeZwZdUPbHOFDRUxI6
        qtHAhAUkFZWp3eES5PCWU1WTWj8TPX4=
Received: from relay1.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 35209B1E6
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Apr 2021 05:30:15 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: mkfs: only output the warning if the sectorsize is not supported
Date:   Thu, 15 Apr 2021 13:30:11 +0800
Message-Id: <20210415053011.275099-1-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently mkfs.btrfs will output a warning message if the sectorsize is
not the same as page size:
  WARNING: the filesystem may not be mountable, sectorsize 4096 doesn't match page size 65536

But since btrfs subpage support for 64K page size is comming, this
output is populating the golden output of fstests, causing tons of false
alerts.

This patch will make teach mkfs.btrfs to check
/sys/fs/btrfs/features/supported_sectorsizes, and compare if the sector
size is supported.

Then only output above warning message if the sector size is not
supported.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/fsfeatures.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 569208a9e5b1..13b775da9c72 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -16,6 +16,8 @@
 
 #include "kerncompat.h"
 #include <sys/utsname.h>
+#include <sys/stat.h>
+#include <fcntl.h>
 #include <linux/version.h>
 #include <unistd.h>
 #include "common/fsfeatures.h"
@@ -327,8 +329,15 @@ u32 get_running_kernel_version(void)
 
 	return version;
 }
+
+/*
+ * The buffer size if strlen("4096 8192 16384 32768 65536"),
+ * which is 28, then round up to 32.
+ */
+#define SUPPORTED_SECTORSIZE_BUF_SIZE	32
 int btrfs_check_sectorsize(u32 sectorsize)
 {
+	bool sectorsize_checked = false;
 	u32 page_size = (u32)sysconf(_SC_PAGESIZE);
 
 	if (!is_power_of_2(sectorsize)) {
@@ -340,7 +349,32 @@ int btrfs_check_sectorsize(u32 sectorsize)
 		      sectorsize);
 		return -EINVAL;
 	}
-	if (page_size != sectorsize)
+	if (page_size == sectorsize) {
+		sectorsize_checked = true;
+	} else {
+		/*
+		 * Check if the sector size is supported
+		 */
+		char supported_buf[SUPPORTED_SECTORSIZE_BUF_SIZE] = { 0 };
+		char sectorsize_buf[SUPPORTED_SECTORSIZE_BUF_SIZE] = { 0 };
+		int fd;
+		int ret;
+
+		fd = open("/sys/fs/btrfs/features/supported_sectorsizes",
+			  O_RDONLY);
+		if (fd < 0)
+			goto out;
+		ret = read(fd, supported_buf, sizeof(supported_buf));
+		close(fd);
+		if (ret < 0)
+			goto out;
+		snprintf(sectorsize_buf, SUPPORTED_SECTORSIZE_BUF_SIZE,
+			 "%u", page_size);
+		if (strstr(supported_buf, sectorsize_buf))
+			sectorsize_checked = true;
+	}
+out:
+	if (!sectorsize_checked)
 		warning(
 "the filesystem may not be mountable, sectorsize %u doesn't match page size %u",
 			sectorsize, page_size);
-- 
2.31.1

