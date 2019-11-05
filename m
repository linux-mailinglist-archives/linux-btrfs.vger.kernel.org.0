Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61DC4EF2DD
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2019 02:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387398AbfKEBfm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Nov 2019 20:35:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:48526 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728602AbfKEBfm (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 4 Nov 2019 20:35:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1A966B03D
        for <linux-btrfs@vger.kernel.org>; Tue,  5 Nov 2019 01:35:41 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.cz
Subject: [PATCH 1/2] btrfs: block-group: Fix two rebase errors where assignment for cache is missing
Date:   Tue,  5 Nov 2019 09:35:34 +0800
Message-Id: <20191105013535.14239-2-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191105013535.14239-1-wqu@suse.com>
References: <20191105013535.14239-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Without proper cache->flags, btrfs space info will be screwed up and
report error at mount time.

And without proper cache->used, commit transaction will report -EEXIST
when running delayed refs.

Please fold this into the original patch "btrfs: block-group: Refactor btrfs_read_block_groups()".

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/block-group.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index b5eededaa750..c2bd85d29070 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1713,6 +1713,8 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 	}
 	read_extent_buffer(leaf, &bgi, btrfs_item_ptr_offset(leaf, slot),
 			   sizeof(bgi));
+	cache->used = btrfs_stack_block_group_used(&bgi);
+	cache->flags = btrfs_stack_block_group_flags(&bgi);
 	if (!mixed && ((cache->flags & BTRFS_BLOCK_GROUP_METADATA) &&
 	    (cache->flags & BTRFS_BLOCK_GROUP_DATA))) {
 			btrfs_err(info,
-- 
2.23.0

