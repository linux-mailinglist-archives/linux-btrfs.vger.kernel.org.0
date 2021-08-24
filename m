Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14ACC3F593B
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 09:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbhHXHnR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 03:43:17 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55636 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbhHXHmK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 03:42:10 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CBD8120045
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Aug 2021 07:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629790879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+bvDyA9GJ+JddJun3Uq/N+G3PTIr28MA+wnLFZUE/nw=;
        b=t/mvndioRHjrYxGEGN6QbR4B/7yGfPXnnudwisCA8XvEFJhiwWRXTVJf2RXsxTZKQuFUoI
        jhhrg5lL3pyN0BjtIFHqHvPTwXkF5QuudVW/R0avMh/R/EAGK4W8jYF6tYoAXmMMEMlblw
        StnBAkWfV0Hkbd5fVm/SRefpFL7hS1Q=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id C350113942
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Aug 2021 07:41:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id OJdgG56iJGF8bwAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Aug 2021 07:41:18 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v7 4/4] btrfs-progs: image: fix restored image size misalignment
Date:   Tue, 24 Aug 2021 15:41:08 +0800
Message-Id: <20210824074108.44759-5-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210824074108.44759-1-wqu@suse.com>
References: <20210824074108.44759-1-wqu@suse.com>
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
index c622c544b5d3..bf4c62dafbaa 100644
--- a/image/main.c
+++ b/image/main.c
@@ -2377,6 +2377,7 @@ static int fixup_device_size(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_dev_item *dev_item;
 	struct btrfs_dev_extent *dev_ext;
+	struct btrfs_device *dev;
 	struct btrfs_path path;
 	struct extent_buffer *leaf;
 	struct btrfs_root *root = fs_info->chunk_root;
@@ -2395,6 +2396,8 @@ static int fixup_device_size(struct btrfs_trans_handle *trans,
 	key.type = BTRFS_DEV_EXTENT_KEY;
 	key.offset = (u64)-1;
 
+	dev = list_first_entry(&fs_info->fs_devices->devices,
+				struct btrfs_device, dev_list);
 	ret = btrfs_search_slot(NULL, fs_info->dev_root, &key, &path, 0, 0);
 	if (ret < 0) {
 		errno = -ret;
@@ -2428,6 +2431,9 @@ static int fixup_device_size(struct btrfs_trans_handle *trans,
 
 	btrfs_set_stack_device_total_bytes(dev_item, dev_size);
 	btrfs_set_stack_device_bytes_used(dev_item, mdres->alloced_chunks);
+	dev->total_bytes = dev_size;
+	dev->bytes_used = mdres->alloced_chunks;
+	btrfs_set_super_total_bytes(fs_info->super_copy, dev_size);
 	ret = fstat(out_fd, &buf);
 	if (ret < 0) {
 		error("failed to stat result image: %m");
-- 
2.32.0

