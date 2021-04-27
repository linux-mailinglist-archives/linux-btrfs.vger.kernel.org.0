Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40FE36CF36
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Apr 2021 01:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239491AbhD0XGD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Apr 2021 19:06:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:37522 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239492AbhD0XGB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Apr 2021 19:06:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1619564716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pZbJArx+BKZl+n1/x7UnTxgXfeNT70jcJUPjbASCSZc=;
        b=B78Ksfkt4h1Z3T8oQLEFw8UhTurDcOsjj8BBBxGKEW8TOz44u2tlQdSmoe/GOCk9NmVkNe
        AT/mH7nOlpscHcbvl1CLeuWNkePs9IL3pZ6SF/sT24yteypb4whpALaV4SSpRJyWeAUScA
        KMcGRVT22raKAcYdM+Ae4v2P0iVAor8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 610A6B168
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Apr 2021 23:05:16 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [Patch v2 37/42] btrfs: skip validation for subpage read repair
Date:   Wed, 28 Apr 2021 07:03:44 +0800
Message-Id: <20210427230349.369603-38-wqu@suse.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210427230349.369603-1-wqu@suse.com>
References: <20210427230349.369603-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Unlike PAGE_SIZE == sectorsize case, read in subpage btrfs are always
merged if the range is in the same page:

E.g:
For regular sectorsize case, if we want to read range [0, 16K) of a
file, the bio will look like:

 0	 4K	 8K	 12K	 16K
 | bvec 1| bvec 2| bvec 3| bvec 4|

But for subpage case, above 16K can be merged into one bvec:

 0	 4K	 8K	 12K	 16K
 | 		bvec 1		 |

This means our bvec is no longer 1:1 mapped to btrfs sector.

This makes repair much harder to do, if we want to do sector perfect
repair.

For now, just skip validation for subpage read repair, this means:
- We will submit extra range to repair
  Even if we only have one sector error for above read, we will
  still submit full 16K to over-write the bad copy

- Less chance to get good copy
  Now the repair granularity is much lower, we need a copy with
  all sectors correct to be able to submit a repair.

Sector perfect repair needs more modification, but for now the new
behavior should be good enough for us to test the basis of subpage
support.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 697f65e4fe8f..c4615e087446 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2654,6 +2654,19 @@ static bool btrfs_io_needs_validation(struct inode *inode, struct bio *bio)
 	if (bio->bi_status == BLK_STS_OK)
 		return false;
 
+	/*
+	 * For subpage case, read bio are always submitted as multiple-sector
+	 * bio if the range is in the same page.
+	 * For now, let's just skip the validation, and do page sized repair.
+	 *
+	 * This reduce the granularity for repair, meaning if we have two
+	 * copies with different csum mismatch at different location, we're
+	 * unable to repair in subpage case.
+	 *
+	 * TODO: Make validation code to be fully subpage compatible
+	 */
+	if (blocksize < PAGE_SIZE)
+		return false;
 	/*
 	 * We need to validate each sector individually if the failed I/O was
 	 * for multiple sectors.
-- 
2.31.1

