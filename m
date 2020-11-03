Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 773CF2A4680
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 14:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbgKCNbj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 08:31:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:44416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729244AbgKCNbi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 08:31:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604410296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iuB4NnPbCNxEJKoK73LE81+FPvuj8MX14VguYDWoZjA=;
        b=S93NKY5PBCcADiF36VQw6k2iNHJY0++ibNyEmGO3ntE/HluAi4Zf7I0X+0G8bSz/zl2Bfy
        HCvWsDi6ZtDNWR0t96fBo2JaHQM3GSuXfVGrQLOFWxxXBAD+I0rGMbbmQ6/42UEHXLK6i8
        ltxruHOr2vZyR2kjN6sl9UWHMJrUHJM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B851AAB0E;
        Tue,  3 Nov 2020 13:31:36 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 07/32] btrfs: extent_io: make btrfs_fs_info::buffer_radix to take sector size devided values
Date:   Tue,  3 Nov 2020 21:30:43 +0800
Message-Id: <20201103133108.148112-8-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103133108.148112-1-wqu@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

For subpage sized sector size support, one page can contain mutliple tree
blocks, thus we can no longer use (eb->start >> PAGE_SHIFT) any more, or
we can easily get extent buffer doesn't belongs to the bytenr.

This patch will use (extent_buffer::start >> sectorsize_bits) as index
for radix tree so that we can get correct extent buffer for subpage size
support.

While still keep the behavior same for regular sector size.

Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 092d9f69abb2..a90cdcf01b7f 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -5121,7 +5121,7 @@ struct extent_buffer *find_extent_buffer(struct btrfs_fs_info *fs_info,
 
 	rcu_read_lock();
 	eb = radix_tree_lookup(&fs_info->buffer_radix,
-			       start >> PAGE_SHIFT);
+			       start >> fs_info->sectorsize_bits);
 	if (eb && atomic_inc_not_zero(&eb->refs)) {
 		rcu_read_unlock();
 		/*
@@ -5173,7 +5173,7 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
 	}
 	spin_lock(&fs_info->buffer_lock);
 	ret = radix_tree_insert(&fs_info->buffer_radix,
-				start >> PAGE_SHIFT, eb);
+				start >> eb->fs_info->sectorsize_bits, eb);
 	spin_unlock(&fs_info->buffer_lock);
 	radix_tree_preload_end();
 	if (ret == -EEXIST) {
@@ -5281,7 +5281,7 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
 
 	spin_lock(&fs_info->buffer_lock);
 	ret = radix_tree_insert(&fs_info->buffer_radix,
-				start >> PAGE_SHIFT, eb);
+				start >> fs_info->sectorsize_bits, eb);
 	spin_unlock(&fs_info->buffer_lock);
 	radix_tree_preload_end();
 	if (ret == -EEXIST) {
@@ -5337,7 +5337,7 @@ static int release_extent_buffer(struct extent_buffer *eb)
 
 			spin_lock(&fs_info->buffer_lock);
 			radix_tree_delete(&fs_info->buffer_radix,
-					  eb->start >> PAGE_SHIFT);
+					eb->start >> fs_info->sectorsize_bits);
 			spin_unlock(&fs_info->buffer_lock);
 		} else {
 			spin_unlock(&eb->refs_lock);
-- 
2.29.2

