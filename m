Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 953EF33AB30
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Mar 2021 06:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhCOFjr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 15 Mar 2021 01:39:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:42552 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230192AbhCOFjZ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 15 Mar 2021 01:39:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615786764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uzinRdYuk+08nWVTRNigO39FXprmIxCl1Vym8205MfU=;
        b=iDccJ4p3PMclAxSReVHsRIem5pFy4vXbZ4tgcYZP4gpKkpDlSyuO1oAJYFLR0wnUvMzDyT
        wQqxTXHfUMfRtyky5SehqJ5KuLguf9SUXoVWfkge/IP5LFmVPHMLzHzcKCM5wv64GJh9Wq
        94lsEgXZgDqqAmM3ea6j2a9hgW/N4R4=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 45CD8ABD7
        for <linux-btrfs@vger.kernel.org>; Mon, 15 Mar 2021 05:39:24 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 2/2] btrfs: make reada to be subpage compatible
Date:   Mon, 15 Mar 2021 13:39:15 +0800
Message-Id: <20210315053915.62420-3-wqu@suse.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210315053915.62420-1-wqu@suse.com>
References: <20210315053915.62420-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In readahead infrastructure, we are using a lot of hard coded PAGE_SHIFT
while we're not doing anything specific to PAGE_SIZE.

One of the most affected part is the radix tree operation of
btrfs_fs_info::reada_tree.

If using PAGE_SHIFT, subpage metadata readahead is almost broken and do
no help in reading ahead metadata.

Fix the problem by using btrfs_fs_info::sectorsize_bits so that
readahead could work for subpage.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/reada.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/reada.c b/fs/btrfs/reada.c
index 20fd4aa48a8c..06713a8fe26b 100644
--- a/fs/btrfs/reada.c
+++ b/fs/btrfs/reada.c
@@ -209,7 +209,7 @@ int btree_readahead_hook(struct extent_buffer *eb, int err)
 	/* find extent */
 	spin_lock(&fs_info->reada_lock);
 	re = radix_tree_lookup(&fs_info->reada_tree,
-			       eb->start >> PAGE_SHIFT);
+			       eb->start >> fs_info->sectorsize_bits);
 	if (re)
 		re->refcnt++;
 	spin_unlock(&fs_info->reada_lock);
@@ -240,7 +240,7 @@ static struct reada_zone *reada_find_zone(struct btrfs_device *dev, u64 logical,
 	zone = NULL;
 	spin_lock(&fs_info->reada_lock);
 	ret = radix_tree_gang_lookup(&dev->reada_zones, (void **)&zone,
-				     logical >> PAGE_SHIFT, 1);
+				     logical >> fs_info->sectorsize_bits, 1);
 	if (ret == 1 && logical >= zone->start && logical <= zone->end) {
 		kref_get(&zone->refcnt);
 		spin_unlock(&fs_info->reada_lock);
@@ -283,13 +283,13 @@ static struct reada_zone *reada_find_zone(struct btrfs_device *dev, u64 logical,
 
 	spin_lock(&fs_info->reada_lock);
 	ret = radix_tree_insert(&dev->reada_zones,
-				(unsigned long)(zone->end >> PAGE_SHIFT),
-				zone);
+			(unsigned long)(zone->end >> fs_info->sectorsize_bits),
+			zone);
 
 	if (ret == -EEXIST) {
 		kfree(zone);
 		ret = radix_tree_gang_lookup(&dev->reada_zones, (void **)&zone,
-					     logical >> PAGE_SHIFT, 1);
+					logical >> fs_info->sectorsize_bits, 1);
 		if (ret == 1 && logical >= zone->start && logical <= zone->end)
 			kref_get(&zone->refcnt);
 		else
@@ -315,7 +315,7 @@ static struct reada_extent *reada_find_extent(struct btrfs_fs_info *fs_info,
 	u64 length;
 	int real_stripes;
 	int nzones = 0;
-	unsigned long index = logical >> PAGE_SHIFT;
+	unsigned long index = logical >> fs_info->sectorsize_bits;
 	int dev_replace_is_ongoing;
 	int have_zone = 0;
 
@@ -497,7 +497,7 @@ static void reada_extent_put(struct btrfs_fs_info *fs_info,
 			     struct reada_extent *re)
 {
 	int i;
-	unsigned long index = re->logical >> PAGE_SHIFT;
+	unsigned long index = re->logical >> fs_info->sectorsize_bits;
 
 	spin_lock(&fs_info->reada_lock);
 	if (--re->refcnt) {
@@ -538,11 +538,12 @@ static void reada_extent_put(struct btrfs_fs_info *fs_info,
 static void reada_zone_release(struct kref *kref)
 {
 	struct reada_zone *zone = container_of(kref, struct reada_zone, refcnt);
+	struct btrfs_fs_info *fs_info = zone->device->fs_info;
 
-	lockdep_assert_held(&zone->device->fs_info->reada_lock);
+	lockdep_assert_held(&fs_info->reada_lock);
 
 	radix_tree_delete(&zone->device->reada_zones,
-			  zone->end >> PAGE_SHIFT);
+			  zone->end >> fs_info->sectorsize_bits);
 
 	kfree(zone);
 }
@@ -593,7 +594,7 @@ static int reada_add_block(struct reada_control *rc, u64 logical,
 static void reada_peer_zones_set_lock(struct reada_zone *zone, int lock)
 {
 	int i;
-	unsigned long index = zone->end >> PAGE_SHIFT;
+	unsigned long index = zone->end >> zone->device->fs_info->sectorsize_bits;
 
 	for (i = 0; i < zone->ndevs; ++i) {
 		struct reada_zone *peer;
@@ -628,7 +629,7 @@ static int reada_pick_zone(struct btrfs_device *dev)
 					     (void **)&zone, index, 1);
 		if (ret == 0)
 			break;
-		index = (zone->end >> PAGE_SHIFT) + 1;
+		index = (zone->end >> dev->fs_info->sectorsize_bits) + 1;
 		if (zone->locked) {
 			if (zone->elems > top_locked_elems) {
 				top_locked_elems = zone->elems;
@@ -709,7 +710,7 @@ static int reada_start_machine_dev(struct btrfs_device *dev)
 	 * plugging to speed things up
 	 */
 	ret = radix_tree_gang_lookup(&dev->reada_extents, (void **)&re,
-				     dev->reada_next >> PAGE_SHIFT, 1);
+				dev->reada_next >> fs_info->sectorsize_bits, 1);
 	if (ret == 0 || re->logical > dev->reada_curr_zone->end) {
 		ret = reada_pick_zone(dev);
 		if (!ret) {
@@ -718,7 +719,7 @@ static int reada_start_machine_dev(struct btrfs_device *dev)
 		}
 		re = NULL;
 		ret = radix_tree_gang_lookup(&dev->reada_extents, (void **)&re,
-					dev->reada_next >> PAGE_SHIFT, 1);
+				dev->reada_next >> fs_info->sectorsize_bits, 1);
 	}
 	if (ret == 0) {
 		spin_unlock(&fs_info->reada_lock);
@@ -885,7 +886,7 @@ static void dump_devs(struct btrfs_fs_info *fs_info, int all)
 				pr_cont(" curr off %llu",
 					device->reada_next - zone->start);
 			pr_cont("\n");
-			index = (zone->end >> PAGE_SHIFT) + 1;
+			index = (zone->end >> fs_info->sectorsize_bits) + 1;
 		}
 		cnt = 0;
 		index = 0;
@@ -910,7 +911,7 @@ static void dump_devs(struct btrfs_fs_info *fs_info, int all)
 				}
 			}
 			pr_cont("\n");
-			index = (re->logical >> PAGE_SHIFT) + 1;
+			index = (re->logical >> fs_info->sectorsize_bits) + 1;
 			if (++cnt > 15)
 				break;
 		}
@@ -926,7 +927,7 @@ static void dump_devs(struct btrfs_fs_info *fs_info, int all)
 		if (ret == 0)
 			break;
 		if (!re->scheduled) {
-			index = (re->logical >> PAGE_SHIFT) + 1;
+			index = (re->logical >> fs_info->sectorsize_bits) + 1;
 			continue;
 		}
 		pr_debug("re: logical %llu size %u list empty %d scheduled %d",
@@ -942,7 +943,7 @@ static void dump_devs(struct btrfs_fs_info *fs_info, int all)
 			}
 		}
 		pr_cont("\n");
-		index = (re->logical >> PAGE_SHIFT) + 1;
+		index = (re->logical >> fs_info->sectorsize_bits) + 1;
 	}
 	spin_unlock(&fs_info->reada_lock);
 }
-- 
2.30.1

