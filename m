Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C8B3E24CD
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Aug 2021 10:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243407AbhHFINI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Aug 2021 04:13:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49872 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243391AbhHFINH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Aug 2021 04:13:07 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 60F78223B3
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Aug 2021 08:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1628237570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h7Cp1uzN6ZEjc1EgO4gwtETl9thhmg4TRBA1SN8Lc6s=;
        b=Ocu2H7wKlJBD4DRN9rdVlslp2Mf61TohySCoGEVoNq0mVCAqLUafsYBrbDbSAPLnQKyv4N
        dvVu7FoVKLrI9DvImTbxYNNpBBXeDkQnKEaCJeuwXXKxJieeQhIQF/EhEY8Ok1Rptd7EkX
        0HMSu7jto7SUxjplie2UJk5BwPqmIPA=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 982D11399D
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Aug 2021 08:12:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id MGw5FgHvDGF6IQAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Aug 2021 08:12:49 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v5 03/11] btrfs: defrag: replace hard coded PAGE_SIZE to sectorsize
Date:   Fri,  6 Aug 2021 16:12:34 +0800
Message-Id: <20210806081242.257996-4-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210806081242.257996-1-wqu@suse.com>
References: <20210806081242.257996-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

When testing subpage defrag support, I always find some strange inode
nbytes error, after a lot of debugging, it turns out that
defrag_lookup_extent() is using PAGE_SIZE as size for
lookup_extent_mapping().

Since lookup_extent_mapping() is calling __lookup_extent_mapping() with
@strict == 1, this means any extent map smaller than one page will be
ignored, prevent subpage defrag to grab a correct extent map.

There are quite some PAGE_SIZE usage in ioctl.c, but most of them are
correct usages, and can be one of the following cases:

- ioctl structure size check
  We want ioctl structure be contained inside one page.

- real page operations

The remaining cases in defrag_lookup_extent() and
check_defrag_in_cache() will be addressed in this patch.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/ioctl.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 7c1ea4eed490..5545f33c6a98 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -991,10 +991,11 @@ static int check_defrag_in_cache(struct inode *inode, u64 offset, u32 thresh)
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct extent_map *em = NULL;
 	struct extent_map_tree *em_tree = &BTRFS_I(inode)->extent_tree;
+	const u32 sectorsize = btrfs_sb(inode->i_sb)->sectorsize;
 	u64 end;
 
 	read_lock(&em_tree->lock);
-	em = lookup_extent_mapping(em_tree, offset, PAGE_SIZE);
+	em = lookup_extent_mapping(em_tree, offset, sectorsize);
 	read_unlock(&em_tree->lock);
 
 	if (em) {
@@ -1084,23 +1085,24 @@ static struct extent_map *defrag_lookup_extent(struct inode *inode, u64 start)
 	struct extent_map_tree *em_tree = &BTRFS_I(inode)->extent_tree;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct extent_map *em;
-	u64 len = PAGE_SIZE;
+	const u32 sectorsize = BTRFS_I(inode)->root->fs_info->sectorsize;
 
 	/*
 	 * hopefully we have this extent in the tree already, try without
 	 * the full extent lock
 	 */
 	read_lock(&em_tree->lock);
-	em = lookup_extent_mapping(em_tree, start, len);
+	em = lookup_extent_mapping(em_tree, start, sectorsize);
 	read_unlock(&em_tree->lock);
 
 	if (!em) {
 		struct extent_state *cached = NULL;
-		u64 end = start + len - 1;
+		u64 end = start + sectorsize - 1;
 
 		/* get the big lock and read metadata off disk */
 		lock_extent_bits(io_tree, start, end, &cached);
-		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start, len);
+		em = btrfs_get_extent(BTRFS_I(inode), NULL, 0, start,
+				      sectorsize);
 		unlock_extent_cached(io_tree, start, end, &cached);
 
 		if (IS_ERR(em))
-- 
2.32.0

