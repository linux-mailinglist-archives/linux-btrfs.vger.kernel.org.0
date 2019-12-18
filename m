Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98E20123C5C
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 02:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbfLRBT6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 20:19:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:49756 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbfLRBT5 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 20:19:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 70722ABCD
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2019 01:19:55 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 4/6] btrfs-progs: Add extra chunk item size check
Date:   Wed, 18 Dec 2019 09:19:40 +0800
Message-Id: <20191218011942.9830-5-wqu@suse.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218011942.9830-1-wqu@suse.com>
References: <20191218011942.9830-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BUG]
For one fuzzed image, `btrfs check` both modes will trigger a BUG_ON():
  Opening filesystem to check...
  Checking filesystem on issue_208.raw
  UUID: 99e50868-0bda-4d89-b0e4-7e8560312ef9
  [1/7] checking root items
  [2/7] checking extents
  ctree.h:320: btrfs_chunk_item_size: BUG_ON `num_stripes == 0` triggered, value 1
  btrfs(+0x2f712)[0x55829afa6712]
  btrfs(+0x322e5)[0x55829afa92e5]
  btrfs(+0x6892a)[0x55829afdf92a]
  btrfs(+0x69099)[0x55829afe0099]
  btrfs(+0x69c68)[0x55829afe0c68]
  btrfs(+0x6dc27)[0x55829afe4c27]
  btrfs(main+0x94)[0x55829af8b0c4]
  /usr/lib/libc.so.6(__libc_start_main+0xf3)[0x7f3edc715ee3]
  btrfs(_start+0x2e)[0x55829af8b35e]

[CAUSE]
The fuzzed image has an invalid chunk item in chunk tree:
  item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 13631488) itemoff 16105 itemsize 80
  invalid num_stripes: 0

Which triggers that BUG_ON().

[FIX]
Here we enhance the verification of btrfs_check_chunk_valid(), to check
the num_stripes and item size.

Issue: #208
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 volumes.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/volumes.c b/volumes.c
index 44789f20..0f618978 100644
--- a/volumes.c
+++ b/volumes.c
@@ -1858,12 +1858,36 @@ int btrfs_check_chunk_valid(struct btrfs_fs_info *fs_info,
 	u32 chunk_ondisk_size;
 	u32 sectorsize = fs_info->sectorsize;
 
+	/*
+	 * Basic chunk item size check.
+	 * Note btrfs_chunk has already contained one stripe, so no == check.
+	 */
+	if (slot >= 0 &&
+	    btrfs_item_size_nr(leaf, slot) < sizeof(struct btrfs_chunk)) {
+		error("invalid chunk item size, have %u expect [%zu, %lu)",
+			btrfs_item_size_nr(leaf, slot),
+			sizeof(struct btrfs_chunk),
+			BTRFS_LEAF_DATA_SIZE(fs_info));
+		return -EUCLEAN;
+	}
 	length = btrfs_chunk_length(leaf, chunk);
 	stripe_len = btrfs_chunk_stripe_len(leaf, chunk);
 	num_stripes = btrfs_chunk_num_stripes(leaf, chunk);
 	sub_stripes = btrfs_chunk_sub_stripes(leaf, chunk);
 	type = btrfs_chunk_type(leaf, chunk);
 
+	if (num_stripes == 0) {
+		error("invalid num_stripes, have %u expect non-zero",
+			num_stripes);
+		return -EUCLEAN;
+	}
+	if (slot >= 0 && btrfs_chunk_item_size(num_stripes) !=
+	    btrfs_item_size_nr(leaf, slot)) {
+		error("invalid chunk item size, have %u expect %lu",
+			btrfs_item_size_nr(leaf, slot),
+			btrfs_chunk_item_size(num_stripes));
+		return -EUCLEAN;
+	}
 	/*
 	 * These valid checks may be insufficient to cover every corner cases.
 	 */
-- 
2.24.1

