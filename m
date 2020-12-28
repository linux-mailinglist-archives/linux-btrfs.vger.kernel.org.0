Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1D352E3356
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Dec 2020 01:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgL1Ac6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Dec 2020 19:32:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:53922 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbgL1Ac5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Dec 2020 19:32:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1609115531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T8RhIHzpTvsgk7MPWeeWe+s0X3fhVB5HewRPi65ypX8=;
        b=Y2iUKaJAI8zl1D3LDL73hkB3ZfFTjmu8YWw9EWG1fsusTBpx+IiBoLWjz0TRqFNnFa7XhX
        c6CVtbiGalkRLGT9E506utiEQ3q9sgwjR1w03NSFF671BW5y281uLxWqN6J8v0NnOX5mS5
        Bb35nzGygT/rp+mZv//XLCdi6Ic+SYE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E523CB73F
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Dec 2020 00:32:10 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v5 4/4] btrfs-progs: image: fix restored image size misalignment
Date:   Mon, 28 Dec 2020 08:31:59 +0800
Message-Id: <20201228003159.115343-5-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201228003159.115343-1-wqu@suse.com>
References: <20201228003159.115343-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Thankfully since commit 73dd4e3c87c9 ("btrfs-progs: image: Don't modify
the chunk and device tree if the source dump is single device") single
device dump won't have such problem, but it's still worthy for
multi-device dump.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 image/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/image/main.c b/image/main.c
index 5fa6fa5aba17..42564b1d2f44 100644
--- a/image/main.c
+++ b/image/main.c
@@ -2374,6 +2374,7 @@ static int fixup_device_size(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_dev_item *dev_item;
 	struct btrfs_dev_extent *dev_ext;
+	struct btrfs_device *dev;
 	struct btrfs_path path;
 	struct extent_buffer *leaf;
 	struct btrfs_root *root = fs_info->chunk_root;
@@ -2392,6 +2393,8 @@ static int fixup_device_size(struct btrfs_trans_handle *trans,
 	key.type = BTRFS_DEV_EXTENT_KEY;
 	key.offset = (u64)-1;
 
+	dev = list_first_entry(&fs_info->fs_devices->devices,
+				struct btrfs_device, dev_list);
 	ret = btrfs_search_slot(NULL, fs_info->dev_root, &key, &path, 0, 0);
 	if (ret < 0) {
 		errno = -ret;
@@ -2425,6 +2428,9 @@ static int fixup_device_size(struct btrfs_trans_handle *trans,
 
 	btrfs_set_stack_device_total_bytes(dev_item, dev_size);
 	btrfs_set_stack_device_bytes_used(dev_item, mdres->alloced_chunks);
+	dev->total_bytes = dev_size;
+	dev->bytes_used = mdres->alloced_chunks;
+	btrfs_set_super_total_bytes(fs_info->super_copy, dev_size);
 	ret = fstat(out_fd, &buf);
 	if (ret < 0) {
 		error("failed to stat result image: %m");
-- 
2.29.2

