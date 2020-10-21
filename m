Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516C2294859
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440862AbgJUG2R (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:28:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:44864 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440851AbgJUG2R (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:28:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T/F2x1+by7YMZaOSu1fPNAzmJOL+4oCazbpqrhg3Rag=;
        b=DjU8G9hmQ+5t3Zp0ZuExdv6PYh4+2hp9g8rNsOFmrMTATzc5U7Nrk3FJsg9ptkCm6wVfGA
        rohaQgb1gyLjfWLDCuPEhXp1ki0xna/+APnUOVMkNa9KonlnXSeGcRRGtWZwaA76kckdnn
        wS+f1L1RkhB2o4uMDOwTGuqjw3+7PuY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AE5BCAC1D
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:28:15 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 61/68] btrfs: inode: make btrfs_truncate_block() to do page alignment
Date:   Wed, 21 Oct 2020 14:25:47 +0800
Message-Id: <20201021062554.68132-62-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is mostly for subpage write back, as we still can only submit full
page write, we can't truncate the subpage sector.

Thus here we truncate the whole page other than each sector.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 8551815c4d65..f3bc894611e0 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4529,7 +4529,6 @@ int btrfs_truncate_inode_items(struct btrfs_trans_handle *trans,
 int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
 			int front)
 {
-	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	struct address_space *mapping = inode->i_mapping;
 	struct extent_io_tree *io_tree = &BTRFS_I(inode)->io_tree;
 	struct btrfs_ordered_extent *ordered;
@@ -4537,7 +4536,7 @@ int btrfs_truncate_block(struct inode *inode, loff_t from, loff_t len,
 	struct extent_changeset *data_reserved = NULL;
 	char *kaddr;
 	bool only_release_metadata = false;
-	u32 blocksize = fs_info->sectorsize;
+	u32 blocksize = PAGE_SIZE;
 	pgoff_t index = from >> PAGE_SHIFT;
 	unsigned offset = from & (blocksize - 1);
 	struct page *page;
-- 
2.28.0

