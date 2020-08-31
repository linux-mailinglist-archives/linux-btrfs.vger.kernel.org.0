Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A147E2578C3
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 13:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgHaLyE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 07:54:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:40248 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbgHaLyD (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 07:54:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5F83EB8E6;
        Mon, 31 Aug 2020 11:53:54 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH 08/12] btrfs: Make get_extent_skip_holes take btrfs_inode
Date:   Mon, 31 Aug 2020 14:42:45 +0300
Message-Id: <20200831114249.8360-9-nborisov@suse.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200831114249.8360-1-nborisov@suse.com>
References: <20200831114249.8360-1-nborisov@suse.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/extent_io.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 3b8df647c0dc..efe6b0cbc435 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -4552,10 +4552,10 @@ int try_release_extent_mapping(struct page *page, gfp_t mask)
  * helper function for fiemap, which doesn't want to see any holes.
  * This maps until we find something past 'last'
  */
-static struct extent_map *get_extent_skip_holes(struct inode *inode,
+static struct extent_map *get_extent_skip_holes(struct btrfs_inode *inode,
 						u64 offset, u64 last)
 {
-	u64 sectorsize = btrfs_inode_sectorsize(BTRFS_I(inode));
+	u64 sectorsize = btrfs_inode_sectorsize(inode);
 	struct extent_map *em;
 	u64 len;
 
@@ -4567,7 +4567,7 @@ static struct extent_map *get_extent_skip_holes(struct inode *inode,
 		if (len == 0)
 			break;
 		len = ALIGN(len, sectorsize);
-		em = btrfs_get_extent_fiemap(BTRFS_I(inode), offset, len);
+		em = btrfs_get_extent_fiemap(inode, offset, len);
 		if (IS_ERR_OR_NULL(em))
 			return em;
 
@@ -4787,7 +4787,7 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	lock_extent_bits(&BTRFS_I(inode)->io_tree, start, start + len - 1,
 			 &cached_state);
 
-	em = get_extent_skip_holes(inode, start, last_for_get_extent);
+	em = get_extent_skip_holes(BTRFS_I(inode), start, last_for_get_extent);
 	if (!em)
 		goto out;
 	if (IS_ERR(em)) {
@@ -4876,7 +4876,8 @@ int extent_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		}
 
 		/* now scan forward to see if this is really the last extent. */
-		em = get_extent_skip_holes(inode, off, last_for_get_extent);
+		em = get_extent_skip_holes(BTRFS_I(inode), off,
+					   last_for_get_extent);
 		if (IS_ERR(em)) {
 			ret = PTR_ERR(em);
 			goto out;
-- 
2.17.1

