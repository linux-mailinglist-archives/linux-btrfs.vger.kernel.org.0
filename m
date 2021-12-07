Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11F346BDAE
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Dec 2021 15:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbhLGOcb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Dec 2021 09:32:31 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:19470 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237927AbhLGOcN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Dec 2021 09:32:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638887323; x=1670423323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jvZxxsiFkLOQFYwWHJVH4rb3l2IijlgtP1W4yG4cL6c=;
  b=ZWD8puwoBFO8wg+Xhdc0Aiaoplwk4EfSS2ZgXH35NUTBo841EpDUPTXI
   swagyvfDLosYggZXRRSHdJAVnuTogb5BJHGzGJQ7DDzo+asP5Q/R66vdL
   sz3Dk7BHt2vuz1ThLzuhO+MmQzjFa7h4U24aRoN1ea2GljjFctvVV+CUU
   uxeGU2hOlJrZIGDhqh1Ye4O2BvjJBoZzn9oanVwl942LG7yeoRr2ogzTm
   eLD8K872D36jgh3bRqfYbqnZUCsSjKF2ZOXYZrrape2jIKFZDyW54b8qc
   nopNj61jmqE0xojdatlDUaOigNBf+DG7ydOm/wMV1NwqknERu8tmuaujN
   A==;
X-IronPort-AV: E=Sophos;i="5.87,293,1631548800"; 
   d="scan'208";a="299501476"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 07 Dec 2021 22:28:43 +0800
IronPort-SDR: ujzh26xGoCsM82gQVd6wRhjLLoslPVnBi3WNQl9ghNZr0OPKSwPoY6qRBsR2LSmLmzLL/kKypb
 jvt66wRB8Hx9UBNfJLZpzkGNSFKefF4y0M1BbULj3sYg7s4yEVzEMTmoDfxMFFHNrjMDGyPJP0
 qTYjaLNBUVnDvcjMnlpkmu9wN6dchWR60Rj8tpCuVse53ZL2nKYCYXlpfao83AyI6TytXP3bVJ
 QsQooIfBSxSdevdf/Ie0P+7/4RiRZJMoza+tPr39NXFEUI9ADvxqfZZuGYg/AxnKvqlmANVoxe
 uZA8hSovQvExvCKkaBuM2fnQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 06:01:48 -0800
IronPort-SDR: DNqSvWwoHjXElzo5HIGdsyiFXng+D6Qh6itAZqLlWOGtKRUGJA1FSnMfsBYR3FIZHwkn5O470H
 +IecJDW9jfYwdmJFbYNGlSOVDnfLc27crURN2YTi0X1qynw9GLUq70jA4bghKnMMwe8pBi79AK
 AZcWAOgK53isIAp2C+OKWLciLznCbOwWZvssssmY2FBwe0lsA1grJNkosEGzv4QDNGPMTpG3uC
 RlQxt1cphetRFiF3DjDjdskrjB13rqZ15OKazo6nvXfNotgPl4T1b78UU2kI59o6RTOnbVpvVr
 3jM=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip02.wdc.com with ESMTP; 07 Dec 2021 06:28:43 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v2 1/4] btrfs: zoned: encapsulate inode locking for zoned relocation
Date:   Tue,  7 Dec 2021 06:28:34 -0800
Message-Id: <b1d1bab106ddc4456224c0bf1c1bfcfaea4844b7.1638886948.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1638886948.git.johannes.thumshirn@wdc.com>
References: <cover.1638886948.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Encapsulate the inode lock needed for serializing the data relocation
writes on a zoned filesystem into a helper.

This streamlines the code reading flow and hides special casing for
zoned filesystems.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/extent_io.c |  8 ++------
 fs/btrfs/zoned.h     | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 1a67f4b3986b..cc27e6e6d6ce 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5184,8 +5184,6 @@ int extent_writepages(struct address_space *mapping,
 		      struct writeback_control *wbc)
 {
 	struct inode *inode = mapping->host;
-	const bool data_reloc = btrfs_is_data_reloc_root(BTRFS_I(inode)->root);
-	const bool zoned = btrfs_is_zoned(BTRFS_I(inode)->root->fs_info);
 	int ret = 0;
 	struct extent_page_data epd = {
 		.bio_ctrl = { 0 },
@@ -5197,11 +5195,9 @@ int extent_writepages(struct address_space *mapping,
 	 * Allow only a single thread to do the reloc work in zoned mode to
 	 * protect the write pointer updates.
 	 */
-	if (data_reloc && zoned)
-		btrfs_inode_lock(inode, 0);
+	btrfs_zoned_data_reloc_lock(inode);
 	ret = extent_write_cache_pages(mapping, wbc, &epd);
-	if (data_reloc && zoned)
-		btrfs_inode_unlock(inode, 0);
+	btrfs_zoned_data_reloc_unlock(inode);
 	ASSERT(ret <= 0);
 	if (ret < 0) {
 		end_write_bio(&epd, ret);
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 4344f4818389..e3eaf03a3422 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -8,6 +8,7 @@
 #include "volumes.h"
 #include "disk-io.h"
 #include "block-group.h"
+#include "btrfs_inode.h"
 
 /*
  * Block groups with more than this value (percents) of unusable space will be
@@ -354,4 +355,20 @@ static inline void btrfs_clear_treelog_bg(struct btrfs_block_group *bg)
 	spin_unlock(&fs_info->treelog_bg_lock);
 }
 
+static inline void btrfs_zoned_data_reloc_lock(struct inode *inode)
+{
+	struct btrfs_root *root = BTRFS_I(inode)->root;
+
+	if (btrfs_is_data_reloc_root(root) && btrfs_is_zoned(root->fs_info))
+		btrfs_inode_lock(inode, 0);
+}
+
+static inline void btrfs_zoned_data_reloc_unlock(struct inode *inode)
+{
+	struct btrfs_root *root = BTRFS_I(inode)->root;
+
+	if (btrfs_is_data_reloc_root(root) && btrfs_is_zoned(root->fs_info))
+		btrfs_inode_unlock(inode, 0);
+}
+
 #endif
-- 
2.31.1

