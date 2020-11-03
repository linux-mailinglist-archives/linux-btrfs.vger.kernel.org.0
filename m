Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF392A4695
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 14:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729394AbgKCNcT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 08:32:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:45220 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729390AbgKCNcT (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Nov 2020 08:32:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604410338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g1ulKSmOKA6d57hB4MS+x8tRPpb2vDmRWp+msi4XznY=;
        b=LCT2qFEKf1URrBDH1uRP3EJd1HqMgqlARAnaoxWnYOPlhD6oXNYGj3bEvTylxQSWYk5ICz
        xU8Tzu75JWaBD94RHQznp4VSlAd/BzcbYnMrWUT/Z6bBKOWR4TTVM+dl5h/bnFDXde+VUM
        ejR/txLhZWc7Gec3Bz003D8e7o5RUQQ=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 067F9ABF4
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Nov 2020 13:32:18 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 22/32] btrfs: file-item: use nodesize to determine whether we need readahead for btrfs_lookup_bio_sums()
Date:   Tue,  3 Nov 2020 21:30:58 +0800
Message-Id: <20201103133108.148112-23-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201103133108.148112-1-wqu@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
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

For the most common btrfs setup, CRC32 csum and 4K sectorsize,
it means just 32K read would kick readahead, while the csum itself is
only 32 bytes in size.

Now let's be more reasonable by taking both csum size and node size into
consideration.

If the csum size for the bio is larger than one leaf, then we kick the
readahead.
This means for current default btrfs, the threshold will be 16M.

This change should not change performance observably, thus this is mostly
a readability enhancement.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/file-item.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
index 5f3096ea69af..4bf139983282 100644
--- a/fs/btrfs/file-item.c
+++ b/fs/btrfs/file-item.c
@@ -298,7 +298,11 @@ blk_status_t btrfs_lookup_bio_sums(struct inode *inode, struct bio *bio,
 		csum = dst;
 	}
 
-	if (bio->bi_iter.bi_size > PAGE_SIZE * 8)
+	/*
+	 * If needed number of sectors is larger than one leaf can contain,
+	 * kick the readahead for csum tree would be a good idea.
+	 */
+	if (nblocks > fs_info->csums_per_leaf)
 		path->reada = READA_FORWARD;
 
 	/*
-- 
2.29.2

