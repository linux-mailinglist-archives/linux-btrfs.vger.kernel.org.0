Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D764C387CA0
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 May 2021 17:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350275AbhERPmQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 May 2021 11:42:16 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:32432 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350269AbhERPmN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 May 2021 11:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621352455; x=1652888455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UOEBSTAxSFEvV33A/+UP5iEQIspsEOnmos7f0/DqCJ0=;
  b=OOTf6hNEj8N6rh7fOVIiNuWgnHPBw2HgmI4UnyL5foHohPkbTZyvgVt8
   VUTbVylLuCDFxEVZkzuyKFe9JUU/Z8uWL6cRCn2/7+PhF+QwEUAhhDtrQ
   xZhnQas9j562t70qID3oW+LqZZYj7tlxTa1iZ+ur8OnfT36D2/8KTLHDn
   SCVvQTYfS9FMfkXkh8SBqQBcyivx54E/qIWflNROUH2CeBMHAB0ytXZIE
   A44HYMXauXU3+jD247zY7pcR0Q3o222MpUhSEqbX49mNllE2NDuFvfBK3
   oWVx1s+QfCZkdeQxzXSaermFeJ70ExFM/VAfMW06D3jhqcE+szqtNc1Dx
   g==;
IronPort-SDR: mCUZJ06UftFxEGPPwjjKJTy7GxpIbcI1X/FPMJTKosk9wpYApCj+YrJEY82fTsAFSy+AsDj/rR
 3L66B1+pnqZ7qdsVBZdsDL7hD60ghYEt/kmDAERbblYYOTXR9wpYK3pEvQLbMRjiBq3foF8HuK
 pl+HUKB9A4GCCEwOG3sh9DATEKAWc2orftnNMUkNjnpi0IL1NEZzyt9L04jyeHTy1RC0PDf5I1
 eDeNpcfxXWmXJSU2ILzzp/alTfCPELGTrGr0rEbRG9Ln9fqZDyasIWEF7SilLzQBthOVkxuY8P
 6dg=
X-IronPort-AV: E=Sophos;i="5.82,310,1613404800"; 
   d="scan'208";a="279802252"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 18 May 2021 23:40:55 +0800
IronPort-SDR: HDtbg7adogcA2kkj1WIIPsZ9AmCfUb0wtssJaOfwSF+90Fwrnz+u+47z/H9/j7k9lSTFIBk1bh
 wJwNIJ0+w1mU3XcQ4kn27AOzTkoJHq7xfKijIc3aWNuTI/pzypoewwe/TTHVOjlbokMbhhSh2L
 Ahf03YcGrkTR4PfxJBDqeATgTkP+FYcLWRFDn9s0LYIIzD4zY3xvsL6eX/37MjZ/nKt2EuizWk
 crpHugG7iNWWmprP0CoOuuVpTyR+0lcCfoP7zsr3D9J6348CpADqxzy6Nzrzkq+8sbLP2NXRvP
 ETOzTAFMyWQbplstOZpwsqoO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 08:20:35 -0700
IronPort-SDR: gr6Q7Cqtsn+PZ4FWdLQj7tyYuhiT1zRJXFQc5lTfwE0worYWF/9qKCrP3RMdtCKt7NOwMvK2r1
 H7tWfb/1x32r2yUISNrTXnz8zfXhr/Ejtzh4QK/pNce0QwWK0sYG1nzS4N6acc5z0Kw4tdaUh3
 tfskmaaNvR+DdM6sU3lVzo0/kmW4MAtaUTeGxFlANnVgf9xqFnq60a3kvrnRJYdYy55tBZ8cvF
 kNwzfwznuaJ+f5+dpbYHcO4wHQD3FQ6/K9sCGS+WY3FgJQ1VEzlgNIh4AQwHdWqTKNqBJEdqHu
 s7E=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 May 2021 08:40:55 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 1/3] btrfs: zoned: pass start block to btrfs_use_zone_append
Date:   Wed, 19 May 2021 00:40:27 +0900
Message-Id: <737c912acd7fa3a603af3cd1ec1a582b91064b78.1621351444.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621351444.git.johannes.thumshirn@wdc.com>
References: <cover.1621351444.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

btrfs_use_zone_append only needs the passed in extent_map's block_start
member, so there's no need to pass in the full extent map.

This also enables the use of btrfs_use_zone_append in places where we only
have a start byte but no extent_map.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/extent_io.c | 2 +-
 fs/btrfs/inode.c     | 2 +-
 fs/btrfs/zoned.c     | 4 ++--
 fs/btrfs/zoned.h     | 5 ++---
 4 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 78d3f2ec90e0..ce6364dd1517 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3765,7 +3765,7 @@ static noinline_for_stack int __extent_writepage_io(struct btrfs_inode *inode,
 		/* Note that em_end from extent_map_end() is exclusive */
 		iosize = min(em_end, end + 1) - cur;
 
-		if (btrfs_use_zone_append(inode, em))
+		if (btrfs_use_zone_append(inode, em->block_start))
 			opf = REQ_OP_ZONE_APPEND;
 
 		free_extent_map(em);
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 955d0f5849e3..105deb6a300a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7794,7 +7794,7 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
 	iomap->bdev = fs_info->fs_devices->latest_bdev;
 	iomap->length = len;
 
-	if (write && btrfs_use_zone_append(BTRFS_I(inode), em))
+	if (write && btrfs_use_zone_append(BTRFS_I(inode), em->block_start))
 		iomap->flags |= IOMAP_F_ZONE_APPEND;
 
 	free_extent_map(em);
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index c41373a92476..b9d5579a578d 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -1296,7 +1296,7 @@ void btrfs_free_redirty_list(struct btrfs_transaction *trans)
 	spin_unlock(&trans->releasing_ebs_lock);
 }
 
-bool btrfs_use_zone_append(struct btrfs_inode *inode, struct extent_map *em)
+bool btrfs_use_zone_append(struct btrfs_inode *inode, u64 start)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	struct btrfs_block_group *cache;
@@ -1311,7 +1311,7 @@ bool btrfs_use_zone_append(struct btrfs_inode *inode, struct extent_map *em)
 	if (!is_data_inode(&inode->vfs_inode))
 		return false;
 
-	cache = btrfs_lookup_block_group(fs_info, em->block_start);
+	cache = btrfs_lookup_block_group(fs_info, start);
 	ASSERT(cache);
 	if (!cache)
 		return false;
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 5e41a74a9cb2..e55d32595c2c 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -53,7 +53,7 @@ void btrfs_calc_zone_unusable(struct btrfs_block_group *cache);
 void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 			    struct extent_buffer *eb);
 void btrfs_free_redirty_list(struct btrfs_transaction *trans);
-bool btrfs_use_zone_append(struct btrfs_inode *inode, struct extent_map *em);
+bool btrfs_use_zone_append(struct btrfs_inode *inode, u64 start);
 void btrfs_record_physical_zoned(struct inode *inode, u64 file_offset,
 				 struct bio *bio);
 void btrfs_rewrite_logical_zoned(struct btrfs_ordered_extent *ordered);
@@ -152,8 +152,7 @@ static inline void btrfs_redirty_list_add(struct btrfs_transaction *trans,
 					  struct extent_buffer *eb) { }
 static inline void btrfs_free_redirty_list(struct btrfs_transaction *trans) { }
 
-static inline bool btrfs_use_zone_append(struct btrfs_inode *inode,
-					 struct extent_map *em)
+static inline bool btrfs_use_zone_append(struct btrfs_inode *inode, u64 start)
 {
 	return false;
 }
-- 
2.31.1

