Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EC92B1B5A
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Nov 2020 13:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgKMMwI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Nov 2020 07:52:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:46408 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgKMMwI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Nov 2020 07:52:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1605271926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gpFE8oGKjNhFNSUbDpxsQVFqw9g+A6pSux2uUhMC+HE=;
        b=aAq5vTW0eav4JauUdSq2xM44JZws8IK/qL84k909J8Iv5ASf0up3C6f9jsoPjEhYNgb7ST
        mtPHSADUYcymXc+xIXJwLLvlpYz4oDauIVf02xrvS3Aa7fuHMNWk+4k+L8VJXqaRoKhjKr
        yIs6dMpva0O2DoGo3/WrU3RdT3wfQxA=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 35445ABD6
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Nov 2020 12:52:06 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 02/24] btrfs: extent-io-tests: remove invalid tests
Date:   Fri, 13 Nov 2020 20:51:27 +0800
Message-Id: <20201113125149.140836-3-wqu@suse.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201113125149.140836-1-wqu@suse.com>
References: <20201113125149.140836-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In extent-io-test, there are two invalid tests:
- Invalid nodesize for test_eb_bitmaps()
  Instead of the sectorsize and nodesize combination passed in, we're
  always using hand-crafted nodesize, e.g:

	len = (sectorsize < BTRFS_MAX_METADATA_BLOCKSIZE)
		? sectorsize * 4 : sectorsize;

  In above case, if we have 32K page size, then we will get a length of
  128K, which is beyond max node size, and obviously invalid.

  Thankfully most machines are either 4K or 64K page size, thus we
  haven't yet hit such case.

- Invalid extent buffer bytenr
  For 64K page size, the only combination we're going to test is
  sectorsize = nodesize = 64K.
  However in that case, we will try to test an eb which bytenr is not
  sectorsize aligned:

	/* Do it over again with an extent buffer which isn't page-aligned. */
	eb = __alloc_dummy_extent_buffer(fs_info, nodesize / 2, len);

  Sector alignedment is a hard requirement for any sector size.
  The only exception is superblock. But anything else should follow
  sector size alignment.

  This is definitely an invalid test case.

This patch will fix both problems by:
- Honor the sectorsize/nodesize combination
  Now we won't bother to hand-craft a strange length and use it as
  nodesize.

- Use sectorsize as the 2nd run extent buffer start
  This would test the case where extent buffer is aligned to sectorsize
  but not always aligned to nodesize.

Please note that, later subpage related cleanup will reduce
extent_buffer::pages[] to exact what we need, making the sector
unaligned extent buffer operations to cause problem.

Since only extent_io self tests utilize this invalid feature, this
patch is required for all later cleanup/refactors.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/btrfs/tests/extent-io-tests.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/tests/extent-io-tests.c b/fs/btrfs/tests/extent-io-tests.c
index df7ce874a74b..73e96d505f4f 100644
--- a/fs/btrfs/tests/extent-io-tests.c
+++ b/fs/btrfs/tests/extent-io-tests.c
@@ -379,54 +379,50 @@ static int __test_eb_bitmaps(unsigned long *bitmap, struct extent_buffer *eb,
 static int test_eb_bitmaps(u32 sectorsize, u32 nodesize)
 {
 	struct btrfs_fs_info *fs_info;
-	unsigned long len;
 	unsigned long *bitmap = NULL;
 	struct extent_buffer *eb = NULL;
 	int ret;
 
 	test_msg("running extent buffer bitmap tests");
 
-	/*
-	 * In ppc64, sectorsize can be 64K, thus 4 * 64K will be larger than
-	 * BTRFS_MAX_METADATA_BLOCKSIZE.
-	 */
-	len = (sectorsize < BTRFS_MAX_METADATA_BLOCKSIZE)
-		? sectorsize * 4 : sectorsize;
-
-	fs_info = btrfs_alloc_dummy_fs_info(len, len);
+	fs_info = btrfs_alloc_dummy_fs_info(nodesize, sectorsize);
 	if (!fs_info) {
 		test_std_err(TEST_ALLOC_FS_INFO);
 		return -ENOMEM;
 	}
 
-	bitmap = kmalloc(len, GFP_KERNEL);
+	bitmap = kmalloc(nodesize, GFP_KERNEL);
 	if (!bitmap) {
 		test_err("couldn't allocate test bitmap");
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	eb = __alloc_dummy_extent_buffer(fs_info, 0, len);
+	eb = __alloc_dummy_extent_buffer(fs_info, 0, nodesize);
 	if (!eb) {
 		test_std_err(TEST_ALLOC_ROOT);
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	ret = __test_eb_bitmaps(bitmap, eb, len);
+	ret = __test_eb_bitmaps(bitmap, eb, nodesize);
 	if (ret)
 		goto out;
 
-	/* Do it over again with an extent buffer which isn't page-aligned. */
 	free_extent_buffer(eb);
-	eb = __alloc_dummy_extent_buffer(fs_info, nodesize / 2, len);
+
+	/*
+	 * Test again for case where the tree block is sectorsize aligned but
+	 * not nodesize aligned.
+	 */
+	eb = __alloc_dummy_extent_buffer(fs_info, sectorsize, nodesize);
 	if (!eb) {
 		test_std_err(TEST_ALLOC_ROOT);
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	ret = __test_eb_bitmaps(bitmap, eb, len);
+	ret = __test_eb_bitmaps(bitmap, eb, nodesize);
 out:
 	free_extent_buffer(eb);
 	kfree(bitmap);
-- 
2.29.2

