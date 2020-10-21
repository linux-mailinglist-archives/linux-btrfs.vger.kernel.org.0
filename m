Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6881C294857
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436674AbgJUG2O (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:28:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:44814 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440851AbgJUG2N (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:28:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d11CJsT4jQd84lTlqKCsSk+MdjWRruj4TBWwolM+36o=;
        b=cvzhwFP0jHVavxImGub9QoTIQktOa6rCrt6EJjwYmFwO5HlkRKSKdrXzhgg43ERzlZKTyl
        4XBYBSsiUWy6KYbDNa/qCx5ylN5EL78V2WYknFYuulXVipLyzOFnbPFeQlCVZaR5U1snHa
        zexRzDhU9wVm3yDpHX680b/kuuPQ7N8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3B657AC1D
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:28:12 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 59/68] btrfs: delalloc-space: make data space reservation to be page aligned
Date:   Wed, 21 Oct 2020 14:25:45 +0800
Message-Id: <20201021062554.68132-60-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is for initial subpage data write support.
Currently we don't yet support full subpage data write, but still full
page data writeback.

Thus change data reserve and release code to be page aligned.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/delalloc-space.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/delalloc-space.c b/fs/btrfs/delalloc-space.c
index 0e354e9e57d0..1f2b324485f5 100644
--- a/fs/btrfs/delalloc-space.c
+++ b/fs/btrfs/delalloc-space.c
@@ -116,13 +116,14 @@ int btrfs_alloc_data_chunk_ondemand(struct btrfs_inode *inode, u64 bytes)
 	struct btrfs_root *root = inode->root;
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_space_info *data_sinfo = fs_info->data_sinfo;
+	u32 blocksize = PAGE_SIZE;
 	u64 used;
 	int ret = 0;
 	int need_commit = 2;
 	int have_pinned_space;
 
-	/* Make sure bytes are sectorsize aligned */
-	bytes = ALIGN(bytes, fs_info->sectorsize);
+	/* Make sure bytes are aligned */
+	bytes = round_up(bytes, blocksize);
 
 	if (btrfs_is_free_space_inode(inode)) {
 		need_commit = 0;
@@ -241,12 +242,12 @@ int btrfs_check_data_free_space(struct btrfs_inode *inode,
 			struct extent_changeset **reserved, u64 start, u64 len)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	u32 blocksize = PAGE_SIZE;
 	int ret;
 
 	/* align the range */
-	len = round_up(start + len, fs_info->sectorsize) -
-	      round_down(start, fs_info->sectorsize);
-	start = round_down(start, fs_info->sectorsize);
+	len = round_up(start + len, blocksize) - round_down(start, blocksize);
+	start = round_down(start, blocksize);
 
 	ret = btrfs_alloc_data_chunk_ondemand(inode, len);
 	if (ret < 0)
@@ -293,11 +294,11 @@ void btrfs_free_reserved_data_space(struct btrfs_inode *inode,
 			struct extent_changeset *reserved, u64 start, u64 len)
 {
 	struct btrfs_fs_info *fs_info = inode->root->fs_info;
+	u32 blocksize = PAGE_SIZE;
 
-	/* Make sure the range is aligned to sectorsize */
-	len = round_up(start + len, fs_info->sectorsize) -
-	      round_down(start, fs_info->sectorsize);
-	start = round_down(start, fs_info->sectorsize);
+	/* Make sure the range is aligned */
+	len = round_up(start + len, blocksize) - round_down(start, blocksize);
+	start = round_down(start, blocksize);
 
 	btrfs_free_reserved_data_space_noquota(fs_info, len);
 	btrfs_qgroup_free_data(inode, reserved, start, len);
-- 
2.28.0

