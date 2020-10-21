Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070DD29482F
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440752AbgJUG0k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:26:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:42998 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408709AbgJUG0k (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:26:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jXW3Kjt7B4nsuMWk/PyGljcZSq6QqbxJ3d+n0lWHhLY=;
        b=dz/SEozrR5XmE4aiwtHJ7tdHigjRGs361GaFt2NtArRV0ZVUX87KJaTQbfJRhy74j0XKT4
        BI7JYBZxsFYFGMiZdzpM4wTx926UXDizOgnB+oWoSv47RfGwA2Or4H+GpqSaI6mrLEpbha
        NFsHSCTaG4ggE9NVhf2ZCtMVeqvFoUs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F1DD3AC1D;
        Wed, 21 Oct 2020 06:26:38 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v4 19/68] btrfs: extent_io: make btrfs_fs_info::buffer_radix to take sector size devided values
Date:   Wed, 21 Oct 2020 14:25:05 +0800
Message-Id: <20201021062554.68132-20-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For subpage sized sector size support, one page can contain mutliple tree
blocks, thus we can no longer use (eb->start >> PAGE_SHIFT) any more, or
we can easily get extent buffer doesn't belongs to the bytenr.

This patch will use (extent_buffer::start / sectorsize) as index for radix
tree so that we can get correct extent buffer for subpage size support.
While still keep the behavior same for regular sector size.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent_io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6e33fa1645c3..4ac315d8753f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5158,7 +5158,7 @@ struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
 
 	rcu_read_lock();
 	eb = radix_tree_lookup(&fs_info->buffer_radix,
-			       start >> PAGE_SHIFT);
+			       start / fs_info->sectorsize);
 	if (eb && atomic_inc_not_zero(&eb->refs)) {
 		rcu_read_unlock();
 		/*
@@ -5210,7 +5210,7 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 	}
 	spin_lock(&fs_info->buffer_lock);
 	ret = radix_tree_insert(&fs_info->buffer_radix,
-				start >> PAGE_SHIFT, eb);
+				start / fs_info->sectorsize, eb);
 	spin_unlock(&fs_info->buffer_lock);
 	radix_tree_preload_end();
 	if (ret == -EEXIST) {
@@ -5318,7 +5318,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 
 	spin_lock(&fs_info->buffer_lock);
 	ret = radix_tree_insert(&fs_info->buffer_radix,
-				start >> PAGE_SHIFT, eb);
+				start / fs_info->sectorsize, eb);
 	spin_unlock(&fs_info->buffer_lock);
 	radix_tree_preload_end();
 	if (ret == -EEXIST) {
@@ -5374,7 +5374,7 @@ static int release_extent_buffer(struct extent_buffer *eb)
 
 			spin_lock(&fs_info->buffer_lock);
 			radix_tree_delete(&fs_info->buffer_radix,
-					  eb->start >> PAGE_SHIFT);
+					  eb->start / fs_info->sectorsize);
 			spin_unlock(&fs_info->buffer_lock);
 		} else {
 			spin_unlock(&eb->refs_lock);
-- 
2.28.0

