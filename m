Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8550A294854
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436689AbgJUG2I (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:28:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:44718 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440851AbgJUG2I (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:28:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FOZr88Po7inmI4ttt7ESAbG8o9zUqzpmk8rxtRYGKzY=;
        b=VzI5KJzoD3gT+2+AQRG6B5+vhFSnKx1vm+aAEG3r9HH5x3DTNkXX8z+87scTyiyOOUA6KT
        9D+sdhz35glXugFy/DgQh2d1n0C8fkctcesX/pQ5PvZ/eVYKUAa2//8LhH6ayNdJghkVu5
        mItKjCL9D3uMZ6OVi7D4eLWuGlF5fm0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D0EE5AC1D
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:28:06 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 56/68] btrfs: file: make btrfs_dirty_pages() follow page size to mark extent io tree
Date:   Wed, 21 Oct 2020 14:25:42 +0800
Message-Id: <20201021062554.68132-57-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently btrfs_dirty_pages() follows sector size to mark extent io
tree, but since we currently don't follow subpage data writeback, this
could cause extra problem for subpage support.

Change it to do page alignement.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index cb8f2b04ccd8..30b22303ad2c 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -504,9 +504,9 @@ int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
 		      size_t num_pages, loff_t pos, size_t write_bytes,
 		      struct extent_state **cached)
 {
-	struct btrfs_fs_info *fs_info = inode->root->fs_info;
 	int err = 0;
 	int i;
+	u32 blocksize = PAGE_SIZE;
 	u64 num_bytes;
 	u64 start_pos;
 	u64 end_of_last_block;
@@ -514,9 +514,8 @@ int btrfs_dirty_pages(struct btrfs_inode *inode, struct page **pages,
 	loff_t isize = i_size_read(&inode->vfs_inode);
 	unsigned int extra_bits = 0;
 
-	start_pos = pos & ~((u64) fs_info->sectorsize - 1);
-	num_bytes = round_up(write_bytes + pos - start_pos,
-			     fs_info->sectorsize);
+	start_pos = round_down(pos, blocksize);
+	num_bytes = round_up(write_bytes + pos - start_pos, blocksize);
 
 	end_of_last_block = start_pos + num_bytes - 1;
 
-- 
2.28.0

