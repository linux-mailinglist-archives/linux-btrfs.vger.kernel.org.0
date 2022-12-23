Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9DF6553A3
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 Dec 2022 19:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbiLWS3F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Dec 2022 13:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbiLWS3C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Dec 2022 13:29:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0821F636
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Dec 2022 10:28:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7DA5CB820F7
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Dec 2022 18:28:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C23FDC433D2
        for <linux-btrfs@vger.kernel.org>; Fri, 23 Dec 2022 18:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671820137;
        bh=6oQJ50t5Qu8IsCh690sPpcsbfgc719Wo4PmhabatujI=;
        h=From:To:Subject:Date:From;
        b=OLBEPfVxi4QHepI8w1urRv0o3EWH0z/E75j44Ms5Uza9U5c6EjtBGS2EmX58WQlzf
         CkH+NXQodlMMLU7UygIcMH+dcOZu3i8z/69FsosbyCHwmrk0Ns6DPVUQf7X3J4qDlW
         BtdJIkP4c8icILFlq/SHCR3PdD3GYUsn+4gIauNH0QIov3omVhuvSDCOvVvTpICHN0
         9hRYBOp/HEcqhieXbNtZZVmfO8UIZoZmfscfvL9jNOuVOwFjmxm9hFAFQIdKv2+wpz
         2606rEzmvhpds13Y3YbPNUX6G3jYS39BJ1E9yc6EzhTNrduxP4Q8/e66OotFMTs+cG
         wNw4eI/F1p3NA==
From:   fdmanana@kernel.org
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH] btrfs: fix off-by-one in delalloc search during lseek
Date:   Fri, 23 Dec 2022 18:28:53 +0000
Message-Id: <da314182610b43632ca81ba78ff73fac5ae1bf06.1671820088.git.fdmanana@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Filipe Manana <fdmanana@suse.com>

During lseek, when searching for delalloc in a range that represents a
hole and that range has a length of 1 byte, we end up not doing the actual
delalloc search in the inode's io tree, resulting in not correctly
reporting the offset with data or a hole. This actually only happens when
the start offset is 0 because with any other start offset we round it down
by sector size.

Reproducer:

  $ mkfs.btrfs -f /dev/sdc
  $ mount /dev/sdc /mnt/sdc

  $ xfs_io -f -c "pwrite -q 0 1" /mnt/sdc/foo

  $ xfs_io -c "seek -d 0" /mnt/sdc/foo
  Whence   Result
  DATA	   EOF

It should have reported an offset of 0 instead of EOF.

Fix this by updating btrfs_find_delalloc_in_range() and count_range_bits()
to deal with inclusive ranges properly. These functions are already
suppossed to work with inclusive end offsets, they just got it wrong in a
couple places due to off-by-one mistakes.

A test case for fstests will be added later.

Reported-by: Joan Bruguera Micó <joanbrugueram@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/20221223020509.457113-1-joanbrugueram@gmail.com/
Fixes: b6e833567ea1 ("btrfs: make hole and data seeking a lot more efficient")
Signed-off-by: Filipe Manana <fdmanana@suse.com>
---
 fs/btrfs/extent-io-tree.c | 2 +-
 fs/btrfs/file.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.c b/fs/btrfs/extent-io-tree.c
index 9ae9cd1e7035..3c7766dfaa69 100644
--- a/fs/btrfs/extent-io-tree.c
+++ b/fs/btrfs/extent-io-tree.c
@@ -1551,7 +1551,7 @@ u64 count_range_bits(struct extent_io_tree *tree,
 	u64 last = 0;
 	int found = 0;
 
-	if (WARN_ON(search_end <= cur_start))
+	if (WARN_ON(search_end < cur_start))
 		return 0;
 
 	spin_lock(&tree->lock);
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 91b00eb2440e..834bbcb91102 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -3354,7 +3354,7 @@ bool btrfs_find_delalloc_in_range(struct btrfs_inode *inode, u64 start, u64 end,
 	bool search_io_tree = true;
 	bool ret = false;
 
-	while (cur_offset < end) {
+	while (cur_offset <= end) {
 		u64 delalloc_start;
 		u64 delalloc_end;
 		bool delalloc;
-- 
2.35.1

