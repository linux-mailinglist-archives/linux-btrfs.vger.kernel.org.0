Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A853D594B
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 14:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbhGZLhm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 07:37:42 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58046 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbhGZLhm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 07:37:42 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5CB561FE75;
        Mon, 26 Jul 2021 12:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627301890; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FuKtVIM0V9rmDHKVnxiWtapvNYcdy+7ZvEh/Fgg2Z6M=;
        b=U1ZSa34tuo+44+VUp4yUBVJJvsD4IUNBH1HqkVGzhc7oLOVasI00CQaP+g9zex8r4oIjfH
        qraL9oLUMgLg3AzPnIbZxcMEGYWM2ukk7+cDivhS0q1IFXFINzEdyj2MsrSatOXOekP/x4
        +Z4SSWL0P9tigIPjtTjhVS7NIdpYzWU=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 5565AA3C43;
        Mon, 26 Jul 2021 12:18:10 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A90F6DA8D8; Mon, 26 Jul 2021 14:15:26 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 09/10] btrfs: constify and cleanup variables comparators
Date:   Mon, 26 Jul 2021 14:15:26 +0200
Message-Id: <e0e380a43f52a9cb43ba040479ae35eee6533900.1627300614.git.dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627300614.git.dsterba@suse.com>
References: <cover.1627300614.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Comparators just read the data and thus get const parameters. This
should be also preserved by the local variables, update all comparators
passed to sort or bsearch.

Cleanups:

- unnecessary casts are dropped
- btrfs_cmp_device_free_bytes is cleaned up to follow the common pattern
  and 'inline' is dropped as the function address is taken

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/raid56.c   |  8 ++++----
 fs/btrfs/send.c     |  6 +++---
 fs/btrfs/super.c    | 13 ++++++-------
 fs/btrfs/tree-log.c |  2 +-
 fs/btrfs/volumes.c  |  2 +-
 5 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index a40a45a007d4..d8d268ca8aa7 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1636,10 +1636,10 @@ struct btrfs_plug_cb {
 static int plug_cmp(void *priv, const struct list_head *a,
 		    const struct list_head *b)
 {
-	struct btrfs_raid_bio *ra = container_of(a, struct btrfs_raid_bio,
-						 plug_list);
-	struct btrfs_raid_bio *rb = container_of(b, struct btrfs_raid_bio,
-						 plug_list);
+	const struct btrfs_raid_bio *ra = container_of(a, struct btrfs_raid_bio,
+						       plug_list);
+	const struct btrfs_raid_bio *rb = container_of(b, struct btrfs_raid_bio,
+						       plug_list);
 	u64 a_sector = ra->bio_list.head->bi_iter.bi_sector;
 	u64 b_sector = rb->bio_list.head->bi_iter.bi_sector;
 
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 6ac37ae6c811..75cff564dedf 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -1198,7 +1198,7 @@ struct backref_ctx {
 static int __clone_root_cmp_bsearch(const void *key, const void *elt)
 {
 	u64 root = (u64)(uintptr_t)key;
-	struct clone_root *cr = (struct clone_root *)elt;
+	const struct clone_root *cr = elt;
 
 	if (root < cr->root->root_key.objectid)
 		return -1;
@@ -1209,8 +1209,8 @@ static int __clone_root_cmp_bsearch(const void *key, const void *elt)
 
 static int __clone_root_cmp_sort(const void *e1, const void *e2)
 {
-	struct clone_root *cr1 = (struct clone_root *)e1;
-	struct clone_root *cr2 = (struct clone_root *)e2;
+	const struct clone_root *cr1 = e1;
+	const struct clone_root *cr2 = e2;
 
 	if (cr1->root->root_key.objectid < cr2->root->root_key.objectid)
 		return -1;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index d07b18b2b250..35ff142ad242 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2096,16 +2096,15 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
 }
 
 /* Used to sort the devices by max_avail(descending sort) */
-static inline int btrfs_cmp_device_free_bytes(const void *dev_info1,
-				       const void *dev_info2)
+static int btrfs_cmp_device_free_bytes(const void *a, const void *b)
 {
-	if (((struct btrfs_device_info *)dev_info1)->max_avail >
-	    ((struct btrfs_device_info *)dev_info2)->max_avail)
+	const struct btrfs_device_info *dev_info1 = a;
+	const struct btrfs_device_info *dev_info2 = b;
+
+	if (dev_info1->max_avail > dev_info2->max_avail)
 		return -1;
-	else if (((struct btrfs_device_info *)dev_info1)->max_avail <
-		 ((struct btrfs_device_info *)dev_info2)->max_avail)
+	else if (dev_info1->max_avail < dev_info2->max_avail)
 		return 1;
-	else
 	return 0;
 }
 
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index c2ebe700d6e2..d3630f404544 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -4191,7 +4191,7 @@ static noinline int copy_items(struct btrfs_trans_handle *trans,
 static int extent_cmp(void *priv, const struct list_head *a,
 		      const struct list_head *b)
 {
-	struct extent_map *em1, *em2;
+	const struct extent_map *em1, *em2;
 
 	em1 = list_entry(a, struct extent_map, list);
 	em2 = list_entry(b, struct extent_map, list);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 78dd013d0ee3..e60e084763b0 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1215,7 +1215,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
 static int devid_cmp(void *priv, const struct list_head *a,
 		     const struct list_head *b)
 {
-	struct btrfs_device *dev1, *dev2;
+	const struct btrfs_device *dev1, *dev2;
 
 	dev1 = list_entry(a, struct btrfs_device, dev_list);
 	dev2 = list_entry(b, struct btrfs_device, dev_list);
-- 
2.31.1

