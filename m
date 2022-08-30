Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95795A5C1C
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Aug 2022 08:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiH3GuK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Aug 2022 02:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiH3GuH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Aug 2022 02:50:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DA226137
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Aug 2022 23:50:05 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 20BB522374
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Aug 2022 06:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661842204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HDg3eRAnaGOzcPR9i47EzrlMv2lX6m/MzbfWhxVvTHs=;
        b=cM+DPkbxQkEaois8qMvVzIavoTX7UOHQx8AqLwlt2CwwjMsaMlJoZnAFVXj5pCQYVgti2o
        BhEthZ5/mclKQG1MUZMyZK6cHXhA+0jFKbi4GYBul04SaXJ+L2pu/AUjwv/mxlQ8GPgmit
        +rQw58rgxxQxYUZmY75GnJaEDoVTQT4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 090A413ACF
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Aug 2022 06:50:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +NFKMRqzDWO7JgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Aug 2022 06:50:02 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs-progs: check: verify the underlying block device size is valid
Date:   Tue, 30 Aug 2022 14:49:42 +0800
Message-Id: <2f2e8155a27ed83785493c20a2c480d5105daf0c.1661841983.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1661841983.git.wqu@suse.com>
References: <cover.1661841983.git.wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is a bug report that, one btrfs got its underlying device shrinked
accidently.

Fortunately the user has no data at the truncated range.

However kernel will reject such fs, while btrfs-check reports nothing
wrong with it.

This can be easily reproduced by:

  # truncate -s 1G test.img
  # mkfs.btrfs test.img
  # truncate -s 996M test.img
  # btrfs check test.img
  Opening filesystem to check...
  Checking filesystem on test.img
  UUID: dbf0a16d-f158-4383-9025-29d7f4c43f17
  [1/7] checking root items
  [2/7] checking extents
  [3/7] checking free space tree
  [4/7] checking fs roots
  [5/7] checking only csums items (without verifying data)
  [6/7] checking root refs
  [7/7] checking quota groups skipped (not enabled on this FS)
  found 16527360 bytes used, no error found
                             ^^^^^^^^^^^^^^
  total csum bytes: 13836
  total tree bytes: 2359296
  total fs tree bytes: 2162688
  total extent tree bytes: 65536
  btree space waste bytes: 503569
  file data blocks allocated: 14168064
   referenced 14168064

[CAUSE]
Btrfs check really only check the metadata cross references, not really
bothering if the underly device has correct size.

Thus we completely ignored such size mismatch.

[FIX]
For both regular and lowmem mode, add extra check against the underlying
block device size.
If the block device size is smaller than its total_bytes, gives a error
message and error out.

Now the check looks like this for both modes:

  ...
  [2/7] checking extents
  ERROR: block device size is smaller than total_bytes in device item, has 1046478848 expect >= 1073741824
  ERROR: errors found in extent allocation tree or chunk allocation
  [3/7] checking free space tree
  ...
  found 16527360 bytes used, error(s) found

Issue: #504
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 check/main.c        | 28 ++++++++++++++++++++++++++++
 check/mode-lowmem.c | 22 ++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/check/main.c b/check/main.c
index 0c5716a51ad1..dc5b4e57140c 100644
--- a/check/main.c
+++ b/check/main.c
@@ -33,6 +33,7 @@
 #include "kernel-shared/disk-io.h"
 #include "kernel-shared/print-tree.h"
 #include "common/task-utils.h"
+#include "common/device-utils.h"
 #include "kernel-shared/transaction.h"
 #include "common/utils.h"
 #include "cmds/commands.h"
@@ -91,6 +92,8 @@ struct device_record {
 	u64 byte_used;
 
 	u64 real_used;
+
+	bool bad_block_dev_size;
 };
 
 static int compare_data_backref(struct rb_node *node1, struct rb_node *node2)
@@ -5285,6 +5288,7 @@ static int process_chunk_item(struct cache_tree *chunk_cache,
 static int process_device_item(struct rb_root *dev_cache,
 		struct btrfs_key *key, struct extent_buffer *eb, int slot)
 {
+	struct btrfs_device *device;
 	struct btrfs_dev_item *ptr;
 	struct device_record *rec;
 	int ret = 0;
@@ -5308,7 +5312,29 @@ static int process_device_item(struct rb_root *dev_cache,
 	rec->devid = btrfs_device_id(eb, ptr);
 	rec->total_byte = btrfs_device_total_bytes(eb, ptr);
 	rec->byte_used = btrfs_device_bytes_used(eb, ptr);
+	rec->bad_block_dev_size = false;
+
+	device = btrfs_find_device_by_devid(gfs_info->fs_devices, rec->devid, 0);
+	if (device && device->fd >= 0) {
+		struct stat st;
+		u64 block_dev_size;
 
+		ret = fstat(device->fd, &st);
+		if (ret < 0) {
+			warning(
+		"unable to open devid %llu, skipping its block device size check",
+				device->devid);
+			goto skip;
+		}
+		block_dev_size = btrfs_device_size(device->fd, &st);
+		if (block_dev_size < rec->total_byte) {
+			error(
+"block device size is smaller than total_bytes in device item, has %llu expect >= %llu",
+			      block_dev_size, rec->total_byte);
+			rec->bad_block_dev_size = true;
+		}
+	}
+skip:
 	ret = rb_insert(dev_cache, &rec->node, device_record_compare);
 	if (ret) {
 		fprintf(stderr, "Device[%llu] existed.\n", rec->devid);
@@ -8737,6 +8763,8 @@ static int check_devices(struct rb_root *dev_cache,
 
 		check_dev_size_alignment(dev_rec->devid, dev_rec->total_byte,
 					 gfs_info->sectorsize);
+		if (dev_rec->bad_block_dev_size && !ret)
+			ret = 1;
 		dev_node = rb_next(dev_node);
 	}
 	list_for_each_entry(dext_rec, &dev_extent_cache->no_device_orphans,
diff --git a/check/mode-lowmem.c b/check/mode-lowmem.c
index fa324506dd5d..051c52626434 100644
--- a/check/mode-lowmem.c
+++ b/check/mode-lowmem.c
@@ -23,6 +23,7 @@
 #include "kernel-shared/backref.h"
 #include "common/internal.h"
 #include "common/utils.h"
+#include "common/device-utils.h"
 #include "kernel-shared/volumes.h"
 #include "check/mode-common.h"
 #include "check/mode-lowmem.h"
@@ -4495,6 +4496,9 @@ static int check_dev_item(struct extent_buffer *eb, int slot,
 	struct btrfs_path path;
 	struct btrfs_key key;
 	struct btrfs_dev_extent *ptr;
+	struct btrfs_device *dev;
+	struct stat st;
+	u64 block_dev_size;
 	u64 total_bytes;
 	u64 dev_id;
 	u64 used;
@@ -4590,6 +4594,24 @@ next:
 	}
 	check_dev_size_alignment(dev_id, total_bytes, gfs_info->sectorsize);
 
+	dev = btrfs_find_device_by_devid(gfs_info->fs_devices, dev_id, 0);
+	if (!dev || dev->fd < 0)
+		return 0;
+
+	ret = fstat(dev->fd, &st);
+	if (ret < 0) {
+		warning(
+	"unable to open devid %llu, skipping its block device size check",
+			dev->devid);
+		return 0;
+	}
+	block_dev_size = btrfs_device_size(dev->fd, &st);
+	if (block_dev_size < total_bytes) {
+		error(
+"block device size is smaller than total_bytes in device item, has %llu expect >= %llu",
+		      block_dev_size, total_bytes);
+		return ACCOUNTING_MISMATCH;
+	}
 	return 0;
 }
 
-- 
2.37.2

