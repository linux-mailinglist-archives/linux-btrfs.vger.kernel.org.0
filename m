Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E3C26C5F7
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Sep 2020 19:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgIPR1f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Sep 2020 13:27:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:32944 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbgIPR0v (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Sep 2020 13:26:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 82602B22B;
        Wed, 16 Sep 2020 17:26:44 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3211BDA7C7; Wed, 16 Sep 2020 19:25:17 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 2/3] btrfs: free-space-cache: use unaligned helpers to access data
Date:   Wed, 16 Sep 2020 19:25:17 +0200
Message-Id: <5dc6828b2e7c5dad11181f1fa6b00f0fbc8c91bb.1600276853.git.dsterba@suse.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1600276853.git.dsterba@suse.com>
References: <cover.1600276853.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The free space inode stores the tracking data, checksums etc, using the
io_ctl structure and moving the pointers. The data are generally aligned
to at least 4 bytes (u32 for CRC) so it's not completely unaligned but
for clarity we should use the proper helpers whenever a struct is
initialized from io_ctl->cur pointer.

Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/free-space-cache.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
index 8759f5a1d6a0..af0013d3df63 100644
--- a/fs/btrfs/free-space-cache.c
+++ b/fs/btrfs/free-space-cache.c
@@ -413,8 +413,6 @@ static int io_ctl_prepare_pages(struct btrfs_io_ctl *io_ctl, bool uptodate)
 
 static void io_ctl_set_generation(struct btrfs_io_ctl *io_ctl, u64 generation)
 {
-	__le64 *val;
-
 	io_ctl_map_page(io_ctl, 1);
 
 	/*
@@ -429,14 +427,13 @@ static void io_ctl_set_generation(struct btrfs_io_ctl *io_ctl, u64 generation)
 		io_ctl->size -= sizeof(u64) * 2;
 	}
 
-	val = io_ctl->cur;
-	*val = cpu_to_le64(generation);
+	put_unaligned_le64(generation, io_ctl->cur);
 	io_ctl->cur += sizeof(u64);
 }
 
 static int io_ctl_check_generation(struct btrfs_io_ctl *io_ctl, u64 generation)
 {
-	__le64 *gen;
+	u64 cache_gen;
 
 	/*
 	 * Skip the crc area.  If we don't check crcs then we just have a 64bit
@@ -451,11 +448,11 @@ static int io_ctl_check_generation(struct btrfs_io_ctl *io_ctl, u64 generation)
 		io_ctl->size -= sizeof(u64) * 2;
 	}
 
-	gen = io_ctl->cur;
-	if (le64_to_cpu(*gen) != generation) {
+	cache_gen = get_unaligned_le64(io_ctl->cur);
+	if (cache_gen != generation) {
 		btrfs_err_rl(io_ctl->fs_info,
 			"space cache generation (%llu) does not match inode (%llu)",
-				*gen, generation);
+				cache_gen, generation);
 		io_ctl_unmap_page(io_ctl);
 		return -EIO;
 	}
@@ -525,8 +522,8 @@ static int io_ctl_add_entry(struct btrfs_io_ctl *io_ctl, u64 offset, u64 bytes,
 		return -ENOSPC;
 
 	entry = io_ctl->cur;
-	entry->offset = cpu_to_le64(offset);
-	entry->bytes = cpu_to_le64(bytes);
+	put_unaligned_le64(offset, &entry->offset);
+	put_unaligned_le64(bytes, &entry->bytes);
 	entry->type = (bitmap) ? BTRFS_FREE_SPACE_BITMAP :
 		BTRFS_FREE_SPACE_EXTENT;
 	io_ctl->cur += sizeof(struct btrfs_free_space_entry);
@@ -599,8 +596,8 @@ static int io_ctl_read_entry(struct btrfs_io_ctl *io_ctl,
 	}
 
 	e = io_ctl->cur;
-	entry->offset = le64_to_cpu(e->offset);
-	entry->bytes = le64_to_cpu(e->bytes);
+	entry->offset = get_unaligned_le64(&e->offset);
+	entry->bytes = get_unaligned_le64(&e->bytes);
 	*type = e->type;
 	io_ctl->cur += sizeof(struct btrfs_free_space_entry);
 	io_ctl->size -= sizeof(struct btrfs_free_space_entry);
-- 
2.25.0

