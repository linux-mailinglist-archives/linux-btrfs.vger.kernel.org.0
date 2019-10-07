Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64359CECE9
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Oct 2019 21:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfJGTh2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Oct 2019 15:37:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:44396 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728079AbfJGTh2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 7 Oct 2019 15:37:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 17852AE6E;
        Mon,  7 Oct 2019 19:37:27 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 72CDADA7FB; Mon,  7 Oct 2019 21:37:42 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 1/5] btrfs: assert extent_map bdevs and lookup_map and split
Date:   Mon,  7 Oct 2019 21:37:42 +0200
Message-Id: <e33892bd3aa6d477277ab41af8757dd9797882c0.1570474492.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1570474492.git.dsterba@suse.com>
References: <cover.1570474492.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is a preparatory patch for removing extent_map::bdev. There's some
history behind the code so this is only precaution to catch if things
break before the actual removal happens.

Logically, comparing a raw low-level block device (bdev) does not make
sense for extent maps (high-level objects). This had no effect in
practice but was quite confusing in the code.  The lookup_map is set iff
EXTENT_FLAG_FS_MAPPING is set.

The two pointers were stored in the same bytes and used potentially in
two meanings. Now they're split, so the asserts are in place to check
that the condition will not change.

The lookup map pointer misused bdev, this has been changed in commit
95617d69326c ("btrfs: cleanup, stop casting for extent_map->lookup
everywhere") to the explicit type. But the semantics hasn't changed and
bdev was not actually used to decide if maps are mergeable.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_map.c | 9 ++++++++-
 fs/btrfs/extent_map.h | 2 +-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
index 9d30acca55e1..9f99dccbc3ca 100644
--- a/fs/btrfs/extent_map.c
+++ b/fs/btrfs/extent_map.c
@@ -214,9 +214,16 @@ static int mergable_maps(struct extent_map *prev, struct extent_map *next)
 	ASSERT(next->block_start != EXTENT_MAP_DELALLOC &&
 	       prev->block_start != EXTENT_MAP_DELALLOC);
 
+	if (prev->map_lookup || next->map_lookup)
+		ASSERT(test_bit(EXTENT_FLAG_FS_MAPPING, &prev->flags) &&
+		       test_bit(EXTENT_FLAG_FS_MAPPING, &next->flags));
+
+	if (prev->bdev || next->bdev)
+		ASSERT(prev->bdev == next->bdev);
+
 	if (extent_map_end(prev) == next->start &&
 	    prev->flags == next->flags &&
-	    prev->bdev == next->bdev &&
+	    prev->map_lookup == next->map_lookup &&
 	    ((next->block_start == EXTENT_MAP_HOLE &&
 	      prev->block_start == EXTENT_MAP_HOLE) ||
 	     (next->block_start == EXTENT_MAP_INLINE &&
diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
index 473f039fcd7c..3eb9c596b445 100644
--- a/fs/btrfs/extent_map.h
+++ b/fs/btrfs/extent_map.h
@@ -42,7 +42,7 @@ struct extent_map {
 	u64 block_len;
 	u64 generation;
 	unsigned long flags;
-	union {
+	struct {
 		struct block_device *bdev;
 
 		/*
-- 
2.23.0

