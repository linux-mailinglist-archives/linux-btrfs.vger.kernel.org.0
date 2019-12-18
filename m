Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A783123C5E
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 02:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfLRBUB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 20:20:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:49782 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbfLRBUB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 20:20:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9B0E2ABCD
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2019 01:19:59 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 6/6] btrfs-progs: extent-tree: Fix a by-one error in exclude_super_stripes()
Date:   Wed, 18 Dec 2019 09:19:42 +0800
Message-Id: <20191218011942.9830-7-wqu@suse.com>
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
For certain btrfs images, a BUG_ON() can be triggered at open_ctree()
time:
  Opening filesystem to check...
  extent_io.c:158: insert_state: BUG_ON `end < start` triggered, value 1
  btrfs(+0x2de57)[0x560c4d7cfe57]
  btrfs(+0x2e210)[0x560c4d7d0210]
  btrfs(set_extent_bits+0x254)[0x560c4d7d0854]
  btrfs(exclude_super_stripes+0xbf)[0x560c4d7c65ff]
  btrfs(btrfs_read_block_groups+0x29d)[0x560c4d7c698d]
  btrfs(btrfs_setup_all_roots+0x3f3)[0x560c4d7c0b23]
  btrfs(+0x1ef53)[0x560c4d7c0f53]
  btrfs(open_ctree_fs_info+0x90)[0x560c4d7c11a0]
  btrfs(+0x6d3f9)[0x560c4d80f3f9]
  btrfs(main+0x94)[0x560c4d7b60c4]
  /usr/lib/libc.so.6(__libc_start_main+0xf3)[0x7fd189773ee3]
  btrfs(_start+0x2e)[0x560c4d7b635e]

[CAUSE]
This is caused by passing @len == 0 to add_excluded_extent(), which
means one revsere mapped range is just out of the block group range,
normally means a by-one error.

[FIX]
Fix the boundary check on the reserve mapped range against block group
range.
If a reverse mapped super block starts at the end of the block group, it
doesn't cover so we don't need to bother the case.

Issue: #210
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 extent-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/extent-tree.c b/extent-tree.c
index 6288c8a3..7ba80375 100644
--- a/extent-tree.c
+++ b/extent-tree.c
@@ -3640,7 +3640,7 @@ int exclude_super_stripes(struct btrfs_fs_info *fs_info,
 		while (nr--) {
 			u64 start, len;
 
-			if (logical[nr] > cache->key.objectid +
+			if (logical[nr] >= cache->key.objectid +
 			    cache->key.offset)
 				continue;
 
-- 
2.24.1

