Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FB545B783
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 10:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbhKXJef (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 04:34:35 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32204 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbhKXJe2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 04:34:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637746279; x=1669282279;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G5DiJWfo13BPZMR9s6+9e4Lq+UZNL9VfxPP+u7rMMbc=;
  b=PB/j32WLPAHgNBlKeEf1ZJwEIsPODVzyKhVfHLLSJI+YrfT//8MMDCQ3
   J70ewiBtZy4s5qgZhCTrkx5yWoOeiJFeiOJEVr3Fklz/D8EQ7eg4DrguT
   PO/lOEbgZU4T7eRQxAlKp9oXOCC3tWKS5oKqqlVZlbpS/FfPnbuPxLGo1
   Stkk16VipI6BsHH2t1Ynz+fOAPvtL399q2RJX7UfmOOYnG1xFgCtLo9XM
   Pw1I4oyCFq/+BsRwjg5FR+5TjH3lV3Sp7auZhLbTsP7DpKcTo6xg7qsJ/
   4MgHdkbKLPJnKb0eH8LTeN52ugxVUQu4liAUYOr+q2uHncEI6C7COxafG
   A==;
X-IronPort-AV: E=Sophos;i="5.87,260,1631548800"; 
   d="scan'208";a="185499407"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2021 17:31:18 +0800
IronPort-SDR: YeuiVJN/2Od5msLaQ662COCyc0d+X8KSzdTP9ClNExap1aFqvQoYBIqJINBjik1Rq1U7i5xNzE
 7QiEynay78A1bQQ8CGz8dFGgg10f7UFdyifxQLLV49Y4cT8ZlOdiL+swANMLps6YudTumQeZqZ
 6x0aSVI/F3AvjoeIjof4u9ntE8ZvkLtoPpGn3ZLkWwlYJOQ3xD9EhWrxQELX9gMWPV+/FPjuq6
 T6Slo/BJUn/zEB3ZyN3nqGUr8PDtlPubulqcrkR6Jua0j6MIG7g/VsLqSaA20hXTDYpKZiV76f
 /Scv/MVtvNI1kqYKEm0pkQGb
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 01:06:11 -0800
IronPort-SDR: nif4NVEwDOzLSw7iy3c+rs2+QYaa2FNEyHEENGb3k40LxSIrea1AbGlcrwIAb/I/3S8JAUbOMK
 0xiphiUK1KcuKxF3zBm/3EGU21OfQHjGVboiX4lAYumIy81HYw1pgk8UqkjhUZpjQRwwREWTF7
 Kb8Pmc6y7B8O7Gj1YqhWUdXasYCBrovvp9CZgcDLHHot/dGQvuDC4aKvKK245KWDjOJaZdOZTe
 LX4aUqqp8Nkgfofl5IvoZcchHVR0c4QjZYgjhwfUyMJJa2QdQatR4ZUBu/hi7IGw6dPOfwh28j
 xlE=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2021 01:31:18 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH 19/21] btrfs: move btrfs_scrub_cancel() definition to scrub.h
Date:   Wed, 24 Nov 2021 01:30:45 -0800
Message-Id: <920c97c926801337618f0dc11e20b464d56220e7.1637745470.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1637745470.git.johannes.thumshirn@wdc.com>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Now that we have a scrub.h move btrfs_scrub_cancel()'s definition there.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/ctree.h   | 1 -
 fs/btrfs/disk-io.c | 1 +
 fs/btrfs/scrub.h   | 1 +
 fs/btrfs/super.c   | 1 +
 4 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 064281a700ff1..7ab88e67e3510 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -3801,7 +3801,6 @@ struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info,
 int btrfs_should_ignore_reloc_root(struct btrfs_root *root);
 
 /* scrub.c */
-int btrfs_scrub_cancel(struct btrfs_fs_info *info);
 int btrfs_scrub_cancel_dev(struct btrfs_device *dev);
 int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
 			 struct btrfs_scrub_progress *progress);
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 9d66d48945c6a..19afbd4afc792 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -43,6 +43,7 @@
 #include "space-info.h"
 #include "zoned.h"
 #include "subpage.h"
+#include "scrub.h"
 
 #define BTRFS_SUPER_FLAG_SUPP	(BTRFS_HEADER_FLAG_WRITTEN |\
 				 BTRFS_HEADER_FLAG_RELOC |\
diff --git a/fs/btrfs/scrub.h b/fs/btrfs/scrub.h
index 69da2e49732df..c511c310d55ea 100644
--- a/fs/btrfs/scrub.h
+++ b/fs/btrfs/scrub.h
@@ -55,4 +55,5 @@ int btrfs_scrub_dev(struct btrfs_fs_info *fs_info, u64 devid, u64 start,
 		    int readonly, int is_dev_replace);
 void btrfs_scrub_pause(struct btrfs_fs_info *fs_info);
 void btrfs_scrub_continue(struct btrfs_fs_info *fs_info);
+int btrfs_scrub_cancel(struct btrfs_fs_info *info);
 #endif /* BTRFS_SCRUB_H */
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index a1c54a2c787c5..aa8c62e594a84 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -49,6 +49,7 @@
 #include "block-group.h"
 #include "discard.h"
 #include "qgroup.h"
+#include "scrub.h"
 #define CREATE_TRACE_POINTS
 #include <trace/events/btrfs.h>
 
-- 
2.31.1

