Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93C828C69C
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Oct 2020 03:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgJMBGI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Oct 2020 21:06:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:60932 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbgJMBGI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Oct 2020 21:06:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602551166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vt/cCSxNUmc6t6cQffcsCX74jae0X5cLfBAjBMO5sKs=;
        b=MVbHxuUCrRCT2Qh2S/2B1E8ySwWR5m+SR29JGCROPBHw/DjhJDEIug5cX4L6iER0+NU/pj
        uadZSnJu+Ih3EC0Z2uyNWAT3TgTDNq7IqZZ0L4QkAN6ClTEDhrX3suyuDidlyI/rDxSnu/
        ViBkqhJ3Mr0dOfeEA4GNI6sPsxdbkLI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5CCD1AB91
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Oct 2020 01:06:06 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs-progs: mkfs: refactor how we handle sectorsize override
Date:   Tue, 13 Oct 2020 09:06:02 +0800
Message-Id: <20201013010602.11605-1-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There are several problems for current sectorsize check:
- No check at all for sectorsize
  This means you can even specify "-s 62k".

- No way to specify sectorsize smaller than page size

Fix all these problems by:
- Introduce btrfs_check_sectorsize()
  To do:
  * power of 2 check for sectorsize
  * lower and upper boundary check for sectorsize
  * warn about sectorsize mismatch with page size

- Remove the max() between page size and sectorsize
  This allows us to override the sectorsize for 64K page systems.

- Make nodesize calculation based on sectorsize
  No need to use page size any more.
  Users who specify sectorsize manually really know what they are doing,
  and we have warned them already.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 common/fsfeatures.c | 21 +++++++++++++++++++++
 common/fsfeatures.h |  1 +
 mkfs/main.c         | 14 ++++++++++----
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/common/fsfeatures.c b/common/fsfeatures.c
index 469b6b17589f..0ce1a8213e5e 100644
--- a/common/fsfeatures.c
+++ b/common/fsfeatures.c
@@ -17,6 +17,7 @@
 #include "kerncompat.h"
 #include <sys/utsname.h>
 #include <linux/version.h>
+#include <unistd.h>
 #include "common/fsfeatures.h"
 #include "kernel-shared/ctree.h"
 #include "common/utils.h"
@@ -326,6 +327,26 @@ u32 get_running_kernel_version(void)
 
 	return version;
 }
+int btrfs_check_sectorsize(u32 sectorsize)
+{
+	u32 page_size = (u32)sysconf(_SC_PAGESIZE);
+
+	if (!is_power_of_2(sectorsize)) {
+		error("illegal sectorsize %u, expect value power of 2",
+		      sectorsize);
+		return -EUCLEAN;
+	}
+	if (sectorsize < SZ_4K || sectorsize > SZ_64K) {
+		error("illegal sectorsize %u, expect range [4K, 64K]",
+		      sectorsize);
+		return -EUCLEAN;
+	}
+	if (page_size != sectorsize)
+		warning(
+"the fs may not be mountable, sectorsize %u doesn't match page size %u",
+			sectorsize, page_size);
+	return 0;
+}
 
 int btrfs_check_nodesize(u32 nodesize, u32 sectorsize, u64 features)
 {
diff --git a/common/fsfeatures.h b/common/fsfeatures.h
index f76fc0994a18..74ec2a21caf6 100644
--- a/common/fsfeatures.h
+++ b/common/fsfeatures.h
@@ -53,5 +53,6 @@ void btrfs_parse_runtime_features_to_string(char *buf, u64 flags);
 void print_kernel_version(FILE *stream, u32 version);
 u32 get_running_kernel_version(void);
 int btrfs_check_nodesize(u32 nodesize, u32 sectorsize, u64 features);
+int btrfs_check_sectorsize(u32 sectorsize);
 
 #endif
diff --git a/mkfs/main.c b/mkfs/main.c
index 3eb74821a85e..4317cfaf0e63 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -922,9 +922,8 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 	u64 dev_block_count = 0;
 	u64 metadata_profile = 0;
 	u64 data_profile = 0;
-	u32 nodesize = max_t(u32, sysconf(_SC_PAGESIZE),
-			BTRFS_MKFS_DEFAULT_NODE_SIZE);
-	u32 sectorsize = 4096;
+	u32 nodesize = 0;
+	u32 sectorsize = 0;
 	u32 stripesize = 4096;
 	int zero_end = 1;
 	int fd = -1;
@@ -1092,7 +1091,14 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
 		printf("See %s for more information.\n\n", PACKAGE_URL);
 	}
 
-	sectorsize = max(sectorsize, (u32)sysconf(_SC_PAGESIZE));
+	if (!sectorsize)
+		sectorsize = (u32)sysconf(_SC_PAGESIZE);
+	if (btrfs_check_sectorsize(sectorsize))
+		goto error;
+
+	if (!nodesize)
+		nodesize = max_t(u32, sectorsize, BTRFS_MKFS_DEFAULT_NODE_SIZE);
+
 	stripesize = sectorsize;
 	saved_optind = optind;
 	dev_cnt = argc - optind;
-- 
2.28.0

