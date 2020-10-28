Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98F9D29D29F
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Oct 2020 22:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgJ1Vdo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 17:33:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:58260 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbgJ1Vdn (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 17:33:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603869879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sSxAAiojQg4WtgUjngHPfBfxoieX0dE2a75p6+YQCzQ=;
        b=Z1/KH/UW83xFFdpabGDkOODYgLN4NcB/iXGd+tfkfbB33zdN6X1+CGV7POrmEdS4+50wnA
        DIenvKWu8RdRYn/Q6DlTsRvwrVgvEc72woonk884+MUVJdBkssy/81n/VBHIuGAHF0PFqV
        PQy6oT8sEhibCfU7hdh8BCJ+FIuOrig=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3A771ADE4
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Oct 2020 07:24:39 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 1/3] btrfs: file-item: use nodesize to determine whether we need readhead for btrfs_lookup_bio_sums()
Date:   Wed, 28 Oct 2020 15:24:30 +0800
Message-Id: <20201028072432.86907-2-wqu@suse.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028072432.86907-1-wqu@suse.com>
References: <20201028072432.86907-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In btrfs_lookup_bio_sums() if the bio is pretty large, we want to
readahead the csum tree.

However the threshold is an immediate number, (PAGE_SIZE * 8), from the
initial btrfs merge.

The value itself is pretty hard to guess the meaning, especially when
the immediate number is from the age where 4K sectorsize is the default
and only CRC32 is supported.

For the most common btrfs setup, CRC32 csum algorithme 4K sectorsize,
it means just 32K read would kick readahead, while the csum itself is
only 32 bytes in size.

Now let's be more reasonable by taking both csum size and node size into
consideration.

If the csum size for the bio is larger than one node, then we kick the
readahead.
This means for current default btrfs, the threshold will be 16M.

This change should not change performance observably, thus this is mostly
a readability enhancement.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file-item.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 7d5ec71615b8..fbc60948b2c4 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -295,7 +295,11 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
 		csum = dst;
 	}
 
-	if (bio->bi_iter.bi_size > PAGE_SIZE * 8)
+	/*
+	 * If needed csum size is larger than a node, kick the readahead for
+	 * csum tree would be a good idea.
+	 */
+	if (nblocks * csum_size > fs_info->nodesize)
 		path->reada = READA_FORWARD;
 
 	/*
-- 
2.29.1

