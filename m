Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6160A9F85F
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2019 04:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfH1CdW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 22:33:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:39878 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726232AbfH1CdV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 22:33:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B556DAF80;
        Wed, 28 Aug 2019 02:33:19 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v3 2/2] btrfs: tree-checker: Fix wrong check on max devid
Date:   Wed, 28 Aug 2019 10:33:13 +0800
Message-Id: <20190828023313.22417-2-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190828023313.22417-1-wqu@suse.com>
References: <20190828023313.22417-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
The following script will cause false alert on devid check.
  #!/bin/bash

  dev1=/dev/test/test
  dev2=/dev/test/scratch1
  mnt=/mnt/btrfs

  umount $dev1 &> /dev/null
  umount $dev2 &> /dev/null
  umount $mnt &> /dev/null

  mkfs.btrfs -f $dev1

  mount $dev1 $mnt

  _fail()
  {
          echo "!!! FAILED !!!"
          exit 1
  }

  for ((i = 0; i < 4096; i++)); do
          btrfs dev add -f $dev2 $mnt || _fail
          btrfs dev del $dev1 $mnt || _fail
          dev_tmp=$dev1
          dev1=$dev2
          dev2=$dev_tmp
  done

[CAUSE]
Tree-checker uses BTRFS_MAX_DEVS() and BTRFS_MAX_DEVS_SYS_CHUNK() as
upper limit for devid.
But we can have devid holes just like above script.

So the check for devid is incorrect and could cause false alert.

[FIX]
Just remove the whole devid check.
We don't have any hard requirement for devid assignment.

Furthermore, even devid get corrupted by bitflip, we still have dev
extents verification at mount time, so corrupted data won't sneak into
kernel.

Reported-by: Anand Jain <anand.jain@oracle.com>
Fixes: ab4ba2e13346 ("btrfs: tree-checker: Verify dev item")
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
Changelog:
v2:
- Remove devid check completely
  As we already have verify_one_dev_extent().
v3:
- Unexport BTRFS_MAX_DEVS() and BTRFS_MAX_DEVS_SYS_CHUNK macros
- Update commit message to include the reproducer.
---
 fs/btrfs/tree-checker.c | 8 --------
 fs/btrfs/volumes.c      | 9 +++++++++
 fs/btrfs/volumes.h      | 9 ---------
 3 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index ccd5706199d7..15d1aa7cef1f 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -686,9 +686,7 @@ static void dev_item_err(const struct extent_buffer *eb, int slot,
 static int check_dev_item(struct extent_buffer *leaf,
 			  struct btrfs_key *key, int slot)
 {
-	struct btrfs_fs_info *fs_info = leaf->fs_info;
 	struct btrfs_dev_item *ditem;
-	u64 max_devid = max(BTRFS_MAX_DEVS(fs_info), BTRFS_MAX_DEVS_SYS_CHUNK);
 
 	if (key->objectid != BTRFS_DEV_ITEMS_OBJECTID) {
 		dev_item_err(leaf, slot,
@@ -696,12 +694,6 @@ static int check_dev_item(struct extent_buffer *leaf,
 			     key->objectid, BTRFS_DEV_ITEMS_OBJECTID);
 		return -EUCLEAN;
 	}
-	if (key->offset > max_devid) {
-		dev_item_err(leaf, slot,
-			     "invalid devid: has=%llu expect=[0, %llu]",
-			     key->offset, max_devid);
-		return -EUCLEAN;
-	}
 	ditem = btrfs_item_ptr(leaf, slot, struct btrfs_dev_item);
 	if (btrfs_device_id(leaf, ditem) != key->offset) {
 		dev_item_err(leaf, slot,
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 8b72d03738d9..56f751192a6c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4901,6 +4901,15 @@ static void check_raid56_incompat_flag(struct btrfs_fs_info *info, u64 type)
 	btrfs_set_fs_incompat(info, RAID56);
 }
 
+#define BTRFS_MAX_DEVS(info) ((BTRFS_MAX_ITEM_SIZE(info)	\
+			- sizeof(struct btrfs_chunk))		\
+			/ sizeof(struct btrfs_stripe) + 1)
+
+#define BTRFS_MAX_DEVS_SYS_CHUNK ((BTRFS_SYSTEM_CHUNK_ARRAY_SIZE	\
+				- 2 * sizeof(struct btrfs_disk_key)	\
+				- 2 * sizeof(struct btrfs_chunk))	\
+				/ sizeof(struct btrfs_stripe) + 1)
+
 static int __btrfs_alloc_chunk(struct btrfs_trans_handle *trans,
 			       u64 start, u64 type)
 {
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 7f6aa1816409..789f983a98c5 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -273,15 +273,6 @@ struct btrfs_fs_devices {
 
 #define BTRFS_BIO_INLINE_CSUM_SIZE	64
 
-#define BTRFS_MAX_DEVS(info) ((BTRFS_MAX_ITEM_SIZE(info)	\
-			- sizeof(struct btrfs_chunk))		\
-			/ sizeof(struct btrfs_stripe) + 1)
-
-#define BTRFS_MAX_DEVS_SYS_CHUNK ((BTRFS_SYSTEM_CHUNK_ARRAY_SIZE	\
-				- 2 * sizeof(struct btrfs_disk_key)	\
-				- 2 * sizeof(struct btrfs_chunk))	\
-				/ sizeof(struct btrfs_stripe) + 1)
-
 /*
  * we need the mirror number and stripe index to be passed around
  * the call chain while we are processing end_io (especially errors).
-- 
2.23.0

