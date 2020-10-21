Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2EE329481D
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 08:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440688AbgJUG0C (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Oct 2020 02:26:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:42424 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440496AbgJUG0C (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 02:26:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1603261560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DrRbpVF/5vthz1rTFsGhZ0kkdAn5jEC49CjFpBGtrEo=;
        b=oFeS3o4F0ema0/TcfFrQb23TuMxwnSTxlOVAYPVE6j0gqJrFfkNrNp3d/4dFjloDlkMIQf
        LzYkFAvoQsz97rgeK+E5UHmpSRXfz0hJlQK5xaQsdGgTEUaEQBzTuNmcFuRZXk4JQ92mHO
        8yC+SgOyX/vO+lMVxU9ojg4L9F1QW4Q=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D635BAC35
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Oct 2020 06:26:00 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 01/68] btrfs: extent-io-tests: remove invalid tests
Date:   Wed, 21 Oct 2020 14:24:47 +0800
Message-Id: <20201021062554.68132-2-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021062554.68132-1-wqu@suse.com>
References: <20201021062554.68132-1-wqu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

In extent-io-test, there are two invalid tests:
- Invalid nodesize for test_eb_bitmaps()
  Instead of the sectorsize and nodesize combination passed in, we're
  always using hand-crafted nodesize.
  Although it has some extra check for 64K page size, we can still hit
  a case where PAGE_SIZE == 32K, then we got 128K nodesize which is
  larger than max valid node size.

  Thankfully most machines are either 4K or 64K page size, thus we
  haven't yet hit such case.

- Invalid extent buffer bytenr
  For 64K page size, the only combination we're going to test is
  sectorsize = nodesize = 64K.
  In that case, we'll try to create an extent buffer with 32K bytenr,
  which is not aligned to sectorsize thus invalid.

This patch will fix both problems by:
- Honor the sectorsize/nodesize combination
  Now we won't bother to hand-craft a strange length and use it as
  nodesize.

- Use sectorsize as the 2nd run extent buffer start
  This would test the case where extent buffer is aligned to sectorsize
  but not always aligned to nodesize.

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
2.28.0

