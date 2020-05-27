Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CB81E3EFB
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 May 2020 12:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387990AbgE0K2d (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 May 2020 06:28:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:44620 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387985AbgE0K2b (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 May 2020 06:28:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6C0A4ABE3
        for <linux-btrfs@vger.kernel.org>; Wed, 27 May 2020 10:28:32 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 5/6] btrfs-progs: image: Don't modify the chunk and device tree if  the source dump is single device
Date:   Wed, 27 May 2020 18:28:09 +0800
Message-Id: <20200527102810.147999-6-wqu@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527102810.147999-1-wqu@suse.com>
References: <20200527102810.147999-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Btrfs-image -r doesn't always create exactly the same fs of the original
fs, this is because btrfs-image can create dump from multi-device, and
restore it to single device.

Thus we need some special modification to chunk and device tree. This
behavior is mostly to handle the old behavior where we always restore
the metadata into SINGLE profile no matter what.

However this is not needed if the source fs only has one device, in that
case, we can use all the metadata as is, no need to modify the fs at
all, resulting an exact copy of metadata.

This patch will do extra check when doing restore, to avoid modify the
restored fs if the source is also single device.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/main.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/image/main.c b/image/main.c
index 10f6182e0eac..48d8fcd5078c 100644
--- a/image/main.c
+++ b/image/main.c
@@ -103,6 +103,7 @@ struct mdrestore_struct {
 	struct rb_root physical_tree;
 	struct list_head list;
 	struct list_head overlapping_chunks;
+	struct btrfs_super_block *original_super;
 	size_t num_items;
 	u32 nodesize;
 	u64 devid;
@@ -1085,6 +1086,12 @@ static int update_super(struct mdrestore_struct *mdres, u8 *buffer)
 	u8 *ptr, *write_ptr;
 	int old_num_stripes;
 
+	/* No need to fix, use all data as is */
+	if (btrfs_super_num_devices(mdres->original_super) == 1) {
+		new_array_size = btrfs_super_sys_array_size(super);
+		goto finish;
+	}
+
 	write_ptr = ptr = super->sys_chunk_array;
 	array_size = btrfs_super_sys_array_size(super);
 
@@ -1135,6 +1142,7 @@ static int update_super(struct mdrestore_struct *mdres, u8 *buffer)
 		cur += btrfs_chunk_item_size(old_num_stripes);
 	}
 
+finish:
 	if (mdres->clear_space_cache)
 		btrfs_set_super_cache_generation(super, 0);
 
@@ -1203,6 +1211,8 @@ static int fixup_chunk_tree_block(struct mdrestore_struct *mdres,
 	u64 bytenr = async->start;
 	int i;
 
+	if (btrfs_super_num_devices(mdres->original_super) == 1)
+		return 0;
 	if (size_left % mdres->nodesize)
 		return 0;
 
@@ -1373,6 +1383,8 @@ static void *restore_worker(void *data)
 
 		if (!mdres->multi_devices) {
 			if (async->start == BTRFS_SUPER_INFO_OFFSET) {
+				memcpy(mdres->original_super, outbuf,
+				       BTRFS_SUPER_INFO_SIZE);
 				if (mdres->old_restore) {
 					update_super_old(outbuf);
 				} else {
@@ -1474,6 +1486,7 @@ static void mdrestore_destroy(struct mdrestore_struct *mdres, int num_threads)
 
 	pthread_cond_destroy(&mdres->cond);
 	pthread_mutex_destroy(&mdres->mutex);
+	free(mdres->original_super);
 }
 
 static int mdrestore_init(struct mdrestore_struct *mdres,
@@ -1500,6 +1513,10 @@ static int mdrestore_init(struct mdrestore_struct *mdres,
 	mdres->last_physical_offset = 0;
 	mdres->alloced_chunks = 0;
 
+	mdres->original_super = malloc(BTRFS_SUPER_INFO_SIZE);
+	if (!mdres->original_super)
+		return -ENOMEM;
+
 	if (!num_threads)
 		return 0;
 
@@ -2606,7 +2623,8 @@ static int restore_metadump(const char *input, FILE *out, int old_restore,
 	}
 	ret = wait_for_worker(&mdrestore);
 
-	if (!ret && !multi_devices && !old_restore) {
+	if (!ret && !multi_devices && !old_restore &&
+	    btrfs_super_num_devices(mdrestore.original_super) != 1) {
 		struct btrfs_root *root;
 		struct stat st;
 
-- 
2.26.2

