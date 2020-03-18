Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0CB18965E
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Mar 2020 08:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgCRHyy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Mar 2020 03:54:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:58648 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbgCRHyx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Mar 2020 03:54:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2134BAC37
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Mar 2020 07:54:52 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 4/4] btrfs: image: Fix restored image size misalignment
Date:   Wed, 18 Mar 2020 15:54:34 +0800
Message-Id: <20200318075434.27258-5-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200318075434.27258-1-wqu@suse.com>
References: <20200318075434.27258-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
There is a small device size misalignment between the super block device
size and the device extent size:
total_bytes             10737418240 	<<<
bytes_used              15097856
dev_item.total_bytes    10737418240
dev_item.bytes_used     1094713344

        item 0 key (DEV_ITEMS DEV_ITEM 1) itemoff 16185 itemsize 98
                devid 1 total_bytes 1095761920 bytes_used 1094713344
				    ^^^^^^^^^^

[CAUSE]
In fixup_device_size(), we only reset superblock device item size, which
will be overwritten in write_dev_supers() using
btrfs_device::total_bytes.

And it doesn't touch btrfs_superblock::total_bytes either.

[FIX]
So fix the small mismatch by also resetting btrfs_device::total_bytes,
btrfs_device::bytes_used and btrfs_superblock::total_bytes.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/image/main.c b/image/main.c
index 47d30584e0f1..04e347afe11d 100644
--- a/image/main.c
+++ b/image/main.c
@@ -2357,6 +2357,7 @@ static int fixup_device_size(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_dev_item *dev_item;
 	struct btrfs_dev_extent *dev_ext;
+	struct btrfs_device *dev;
 	struct btrfs_path path;
 	struct extent_buffer *leaf;
 	struct btrfs_root *root = fs_info->chunk_root;
@@ -2375,6 +2376,8 @@ static int fixup_device_size(struct btrfs_trans_handle *trans,
 	key.type = BTRFS_DEV_EXTENT_KEY;
 	key.offset = (u64)-1;
 
+	dev = list_first_entry(&fs_info->fs_devices->devices,
+				struct btrfs_device, dev_list);
 	ret = btrfs_search_slot(NULL, fs_info->dev_root, &key, &path, 0, 0);
 	if (ret < 0) {
 		errno = -ret;
@@ -2408,6 +2411,9 @@ static int fixup_device_size(struct btrfs_trans_handle *trans,
 
 	btrfs_set_stack_device_total_bytes(dev_item, dev_size);
 	btrfs_set_stack_device_bytes_used(dev_item, mdres->alloced_chunks);
+	dev->total_bytes = dev_size;
+	dev->bytes_used = mdres->alloced_chunks;
+	btrfs_set_super_total_bytes(fs_info->super_copy, dev_size);
 	ret = fstat(out_fd, &buf);
 	if (ret < 0) {
 		error("failed to stat result image: %m");
-- 
2.25.1

