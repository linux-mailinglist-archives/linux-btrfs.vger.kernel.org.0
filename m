Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E0C415809
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 08:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239246AbhIWGBp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 02:01:45 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47186 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhIWGBp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 02:01:45 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2EBA420276
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Sep 2021 06:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1632376813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=dTs0M/k9vP72S4pMIPCI4yFtIavBVCv8lL6/6Z0v6Ig=;
        b=TAEbuZ1l3wyhGDDpJsP7u2pZa9CgVU0XPTtojPmrzCG7nVn3DJy/xarDA/biJd/sgcw5p2
        DDObJqlWbihikb1p+9AUw+7430vIMmFsXrSvt8eLeJd+aO8hN+RdCFDPQuStSzqYZrt3E8
        RB8KemcMGZl4q9b1D6j7N9bZyLh3JiM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 647A213DBC
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Sep 2021 06:00:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SGFdCewXTGGfUgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Sep 2021 06:00:12 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/2] btrfs: make sure btrfs_io_context::fs_info is always initialized
Date:   Thu, 23 Sep 2021 14:00:08 +0800
Message-Id: <20210923060009.53821-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs_io_context::fs_info is only initialized in
btrfs_map_block(), but there are call sites like btrfs_map_sblock()
which calls __btrfs_map_block() directly, leaving bioc::fs_info
uninitialized (NULL).

Currently this is fine, but later cleanup will rely on bioc::fs_info to
grab fs_info, and this can be a hidden problem for such usage.

This patch will remove such hidden uninitialized member by always
assigning bioc::fs_info at alloc_btrfs_io_context().

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/volumes.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d7cc24ed9620..89c802f8b35b 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5807,7 +5807,8 @@ static void sort_parity_stripes(struct btrfs_io_context *bioc, int num_stripes)
 	}
 }
 
-static struct btrfs_io_context *alloc_btrfs_io_context(int total_stripes,
+static struct btrfs_io_context *alloc_btrfs_io_context(struct btrfs_fs_info *fs_info,
+						       int total_stripes,
 						       int real_stripes)
 {
 	struct btrfs_io_context *bioc = kzalloc(
@@ -5827,6 +5828,7 @@ static struct btrfs_io_context *alloc_btrfs_io_context(int total_stripes,
 	atomic_set(&bioc->error, 0);
 	refcount_set(&bioc->refs, 1);
 
+	bioc->fs_info = fs_info;
 	bioc->tgtdev_map = (int *)(bioc->stripes + total_stripes);
 	bioc->raid_map = (u64 *)(bioc->tgtdev_map + real_stripes);
 
@@ -5941,7 +5943,7 @@ static int __btrfs_map_block_for_discard(struct btrfs_fs_info *fs_info,
 					&stripe_index);
 	}
 
-	bioc = alloc_btrfs_io_context(num_stripes, 0);
+	bioc = alloc_btrfs_io_context(fs_info, num_stripes, 0);
 	if (!bioc) {
 		ret = -ENOMEM;
 		goto out;
@@ -6463,7 +6465,8 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 		tgtdev_indexes = num_stripes;
 	}
 
-	bioc = alloc_btrfs_io_context(num_alloc_stripes, tgtdev_indexes);
+	bioc = alloc_btrfs_io_context(fs_info, num_alloc_stripes,
+				      tgtdev_indexes);
 	if (!bioc) {
 		ret = -ENOMEM;
 		goto out;
@@ -6699,7 +6702,6 @@ blk_status_t btrfs_map_bio(struct btrfs_fs_info *fs_info, struct bio *bio,
 	bioc->orig_bio = first_bio;
 	bioc->private = first_bio->bi_private;
 	bioc->end_io = first_bio->bi_end_io;
-	bioc->fs_info = fs_info;
 	atomic_set(&bioc->stripes_pending, bioc->num_stripes);
 
 	if ((bioc->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK) &&
-- 
2.33.0

