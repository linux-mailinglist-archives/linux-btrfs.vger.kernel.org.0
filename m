Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41AB45B770
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Nov 2021 10:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbhKXJeF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Nov 2021 04:34:05 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:32168 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbhKXJeF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Nov 2021 04:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637746255; x=1669282255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c4gGog+LgsDNgxi4alHY9QYk/10w4SZ+umwubWCDLxE=;
  b=DSkLGtiA9vWTVspzkzV7YGBTVOnvG28oRfNFM+X6GPGi+SoVB3p3wu0k
   5VzozkqzK5wB6IDJwg1GYlFQzEUVn8tOanAt6Z7Rds5kvyt6OTCyFmTbb
   BfU14vygf5xfMffE2cS2SBDJ4SzbOEwmh48m1UvgyyjkyRDsOI/ZnuISf
   JiRtBA29kWXWDgqqdPlTcXXdF64+Ie2Ldo7cHVFkPZURl4dkmODVEg1u1
   p67vr1QpMlGYoC0YUMZSK+e5WwhprtYgQmgClQfJ9yHJXWI6DiKmbP5TY
   rsoXJtdJYvL2CLwYKR1rv99OdqjRAZg0xyb0CcwRVPFgWXbXVya/mW3CC
   g==;
X-IronPort-AV: E=Sophos;i="5.87,260,1631548800"; 
   d="scan'208";a="185499352"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Nov 2021 17:30:55 +0800
IronPort-SDR: 9QLnV5qxdyv3ibS31JhKgjOcbK63Ytx9GLD2xDlAnHuf+UcBklHKQctujh591TnDq5HCz2r3tj
 nAt1ZGLieeYZSkJCNL0O5owWQ3YTC+TjOb+drZ0b5BA8rsgSMjTqgbWzFn0DEUXsO+obta2W4F
 QiGUr7WpEQt0BK20xVKn9lYXT6GZkOKNCm/fI17hUVENZdUunrCmg5CFt/u8Nggq76f4Cf+/m7
 NVeVME7hNy7lR7DWEQvu5Xkw0PfJIF0pqtLujEvt6ItzVRtasm4cUwEPegTKKTl+XkB79xBSZZ
 T5uJ43Wv19jcExKIcwOUgV8/
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 01:05:48 -0800
IronPort-SDR: wXj1wx3DobyRrzdb/WQYhpHSxnpEdn0bT5tgFh/RJVAWCsIPZKQqo9oSM57wRAZlbUio8JwEKb
 pAEjixSTP75+vmfrV4lpOSiWCHStqa5zy9wMeohABo8eK9HdUx5ofBciqNWGDiUs2/brM2O2AV
 3fAPZSlVABuhVtKgYeXUS5RYtSUd5XReREzIHOXXy81Ann4n/ylEyn6Wpyp9pclggoTZFXUPik
 qhAl8Jfk09KDclvo2161+JY2Lzl78vg03Z+SUSENGxEm7Wpnv/ukccQBi2UZaJUWC2IXwQ0l5X
 DAk=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Nov 2021 01:30:54 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        linux-btrfs@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: [PATCH 01/21] btrfs: zoned: encapsulate inode locking for zoned relocation
Date:   Wed, 24 Nov 2021 01:30:27 -0800
Message-Id: <72f9609c598815e757de1ea275511149ce861246.1637745470.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1637745470.git.johannes.thumshirn@wdc.com>
References: <cover.1637745470.git.johannes.thumshirn@wdc.com>
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
---
 fs/btrfs/extent_io.c |  8 ++------
 fs/btrfs/zoned.h     | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b289d26aca0d5..1654c611d2002 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5170,8 +5170,6 @@ int extent_writepages(struct address_space *mapping,
 		      struct writeback_control *wbc)
 {
 	struct inode *inode = mapping->host;
-	const bool data_reloc = btrfs_is_data_reloc_root(BTRFS_I(inode)->root);
-	const bool zoned = btrfs_is_zoned(BTRFS_I(inode)->root->fs_info);
 	int ret = 0;
 	struct extent_page_data epd = {
 		.bio_ctrl = { 0 },
@@ -5183,11 +5181,9 @@ int extent_writepages(struct address_space *mapping,
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
index 4344f48183898..e3eaf03a34222 100644
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

