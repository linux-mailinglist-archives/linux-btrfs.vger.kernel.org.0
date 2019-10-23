Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB8C7E14C0
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Oct 2019 10:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390627AbfJWIvE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Oct 2019 04:51:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:37894 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390608AbfJWIu7 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Oct 2019 04:50:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E2B19B1D63
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Oct 2019 08:50:54 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: volumes: Return the mapped length for discard
Date:   Wed, 23 Oct 2019 16:50:36 +0800
Message-Id: <20191023085037.14838-2-wqu@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191023085037.14838-1-wqu@suse.com>
References: <20191023085037.14838-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For btrfs_map_block(), if we pass @op == BTRFS_MAP_DISCARD, the @length
parameter will not be updated to reflect the real mapped length.

This means for discard operation, we won't know how many bytes are
really mapped.

Fix this by changing assigning the mapped range length to @length
pointer, so btrfs_map_block() for BTRFS_MAP_DISCARD also return mapped
length.

During the change, also do a minor modification to make the length
calculation a little more straightforward.
Instead of previously calculated @offset, use "em->end - bytenr" to
calculate the actually mapped length.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index cdd7af424033..f66bd0d03f44 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5578,12 +5578,13 @@ void btrfs_put_bbio(struct btrfs_bio *bbio)
  * replace.
  */
 static int __btrfs_map_block_for_discard(struct btrfs_fs_info *fs_info,
-					 u64 logical, u64 length,
+					 u64 logical, u64 *length_ret,
 					 struct btrfs_bio **bbio_ret)
 {
 	struct extent_map *em;
 	struct map_lookup *map;
 	struct btrfs_bio *bbio;
+	u64 length = *length_ret;
 	u64 offset;
 	u64 stripe_nr;
 	u64 stripe_nr_end;
@@ -5616,7 +5617,8 @@ static int __btrfs_map_block_for_discard(struct btrfs_fs_info *fs_info,
 	}
 
 	offset = logical - em->start;
-	length = min_t(u64, em->len - offset, length);
+	length = min_t(u64, em->start + em->len - logical, length);
+	*length_ret = length;
 
 	stripe_len = map->stripe_len;
 	/*
@@ -6031,7 +6033,7 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 
 	if (op == BTRFS_MAP_DISCARD)
 		return __btrfs_map_block_for_discard(fs_info, logical,
-						     *length, bbio_ret);
+						     length, bbio_ret);
 
 	ret = btrfs_get_io_geometry(fs_info, op, logical, *length, &geom);
 	if (ret < 0)
-- 
2.23.0

