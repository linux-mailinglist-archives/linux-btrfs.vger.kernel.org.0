Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E528294843
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440811AbgJUG11 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:27:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:43996 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440808AbgJUG1Z (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:27:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z73rGowfb+sS0owO39aX70dawhN8LD7wCaX353w+TJI=;
        b=pClc9fsFT9vedr1iWZayIbvOGyS0cBHFW/rmtlk+Cre79/aO9yVK825WTZMIE4WnCT7vxn
        qUInWmVVWXmGsLFIEGBItP0B9oDaCUHux7f3zB/JeAMlsRXyWQ8FAs/Kgvet79eT7+xV30
        sqSwyQTs3F1m+9K8+ZzZtPqHxnYKvL0=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 61C7AAC1D
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:27:23 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 39/68] btrfs: extent_io: extra the core of test_range_bit() into test_range_bit_nolock()
Date:   Wed, 21 Oct 2020 14:25:25 +0800
Message-Id: <20201021062554.68132-40-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This allows later function to utilize test_range_bit_nolock() with
caller handling the lock.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/extent_io.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 6a34b33be1fc..37593b599522 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2213,20 +2213,16 @@ struct io_failure_record *get_state_failrec(struct extent_io_tree *tree, u64 sta
 	return failrec;
 }
 
-/*
- * searches a range in the state tree for a given mask.
- * If 'filled' == 1, this returns 1 only if every extent in the tree
- * has the bits set.  Otherwise, 1 is returned if any bit in the
- * range is found set.
- */
-int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
-		   u32 bits, int filled, struct extent_state *cached)
+static int test_range_bit_nolock(struct extent_io_tree *tree, u64 start,
+				 u64 end, u32 bits, int filled,
+				 struct extent_state *cached)
 {
 	struct extent_state *state = NULL;
 	struct rb_node *node;
 	int bitset = 0;
 
-	spin_lock(&tree->lock);
+	assert_spin_locked(&tree->lock);
+
 	if (cached && extent_state_in_tree(cached) && cached->start <= start &&
 	    cached->end > start)
 		node = &cached->rb_node;
@@ -2265,10 +2261,26 @@ int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
 			break;
 		}
 	}
-	spin_unlock(&tree->lock);
 	return bitset;
 }
 
+/*
+ * searches a range in the state tree for a given mask.
+ * If 'filled' == 1, this returns 1 only if every extent in the tree
+ * has the bits set.  Otherwise, 1 is returned if any bit in the
+ * range is found set.
+ */
+int test_range_bit(struct extent_io_tree *tree, u64 start, u64 end,
+		   u32 bits, int filled, struct extent_state *cached)
+{
+	int ret;
+
+	spin_lock(&tree->lock);
+	ret = test_range_bit_nolock(tree, start, end, bits, filled, cached);
+	spin_unlock(&tree->lock);
+	return ret;
+}
+
 /*
  * helper function to set a given page up to date if all the
  * extents in the tree for that page are up to date
-- 
2.28.0

