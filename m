Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D48A2A4688
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 14:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgKCNb5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 08:31:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:44784 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729352AbgKCNb4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 08:31:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604410315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YC171oiQDQFyI5d1NRMI8ZQTGYda/w0ebv6AUusJSyE=;
        b=cZCykw3JvZsBe7re3wtkDpTGEYn0XVtpdDOQ3Dkex1ENeJC/jCtsUjq625H1M/0UCth1BJ
        SXSB9IYvbwBepFVwWrR5XHCgHDAwYRBTE49Frj8Rn+ZakPbOReLNpUrMq7jx6XAefvEJAx
        PB+9UG5EdhuYxaQRV7dJce7xrGd3KZg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AAC9FABF4
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Nov 2020 13:31:55 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 13/32] btrfs: disk-io: accept bvec directly for csum_dirty_buffer()
Date:   Tue,  3 Nov 2020 21:30:49 +0800
Message-Id: <20201103133108.148112-14-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103133108.148112-1-wqu@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Currently csum_dirty_buffer() uses page to grab extent buffer, but that
only works for regular sector size == PAGE_SIZE case.

For subpage we need page + page_offset to grab extent buffer.

This patch will change csum_dirty_buffer() to accept bvec directly so
that we can extract both page and page_offset for later subpage support.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/disk-io.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index de9132564f10..3259a5b32caf 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -449,8 +449,9 @@ static int btree_read_extent_buffer_pages(struct extent_buffer *eb,
  * we only fill in the checksum field in the first page of a multi-page block
  */
 
-static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct page *page)
+static int csum_dirty_buffer(struct btrfs_fs_info *fs_info, struct bio_vec *bvec)
 {
+	struct page *page = bvec->bv_page;
 	u64 start = page_offset(page);
 	u64 found_start;
 	u8 result[BTRFS_CSUM_SIZE];
@@ -794,7 +795,7 @@ static blk_status_t btree_csum_one_bio(struct bio *bio)
 	ASSERT(!bio_flagged(bio, BIO_CLONED));
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		root = BTRFS_I(bvec->bv_page->mapping->host)->root;
-		ret = csum_dirty_buffer(root->fs_info, bvec->bv_page);
+		ret = csum_dirty_buffer(root->fs_info, bvec);
 		if (ret)
 			break;
 	}
-- 
2.29.2

