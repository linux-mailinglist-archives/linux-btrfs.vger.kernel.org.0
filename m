Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB8B3E9E1C
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 07:48:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbhHLFsv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 01:48:51 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34394 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbhHLFsu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 01:48:50 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 994F51FF11
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Aug 2021 05:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628747304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MPzkHBOW+BacwdLEm7wtbV2+j4CQfYw/o4xR05ZfomQ=;
        b=eHJsWqeJ2PwGq2cGTWT9O0zTPkQ41XiH3P4wra3M539cKffkl8jdeTSR1zMPzd7coLZ9vH
        TX9hX8t6g5XNFImc40usbQga9dHwU+Ufs52Ca5Gb7kit9/YCUNXA6M/kE569JUL9aT0KWy
        cLTyll48d4d5ezow9v6yx4bX0vWS0NA=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D393613838
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Aug 2021 05:48:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id APQdJSe2FGG4ZwAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Aug 2021 05:48:23 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v6 4/4] btrfs-progs: image: fix restored image size misalignment
Date:   Thu, 12 Aug 2021 13:48:15 +0800
Message-Id: <20210812054815.192405-5-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210812054815.192405-1-wqu@suse.com>
References: <20210812054815.192405-1-wqu@suse.com>
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
index 9af62c98a793..c50bcfde6a36 100644
--- a/image/main.c
+++ b/image/main.c
@@ -2375,6 +2375,7 @@ static int fixup_device_size(struct btrfs_trans_handle *trans,
 	struct btrfs_fs_info *fs_info = trans->fs_info;
 	struct btrfs_dev_item *dev_item;
 	struct btrfs_dev_extent *dev_ext;
+	struct btrfs_device *dev;
 	struct btrfs_path path;
 	struct extent_buffer *leaf;
 	struct btrfs_root *root = fs_info->chunk_root;
@@ -2393,6 +2394,8 @@ static int fixup_device_size(struct btrfs_trans_handle *trans,
 	key.type = BTRFS_DEV_EXTENT_KEY;
 	key.offset = (u64)-1;
 
+	dev = list_first_entry(&fs_info->fs_devices->devices,
+				struct btrfs_device, dev_list);
 	ret = btrfs_search_slot(NULL, fs_info->dev_root, &key, &path, 0, 0);
 	if (ret < 0) {
 		errno = -ret;
@@ -2426,6 +2429,9 @@ static int fixup_device_size(struct btrfs_trans_handle *trans,
 
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

