Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D5152E1FE
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 May 2022 03:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344502AbiETBcP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 May 2022 21:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344489AbiETBcN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 May 2022 21:32:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A25278937
        for <linux-btrfs@vger.kernel.org>; Thu, 19 May 2022 18:32:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 541D821AA3
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 01:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653010329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=PKFiXSblHtQGUomL9F1tuloQiGE+a+Grz2FuO800vso=;
        b=eIc0DVL6skwQNHL1YMfXYGucV7Zmn9GgAVoZreT+Xiod+JSklzmseXy8c8aP+ZYtuuWjHE
        Ipty/LLVndtyGfQqz4UKu/eUElDtDW0aRx2acRoWgD8eByLB3hvWTT4PDxzRbzC3aRb61X
        pDi1IYixc5s1PVTHqyzAzfUTn9l2ZBA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BBC3413A5F
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 01:32:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qJpGIpjvhmKXOQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Fri, 20 May 2022 01:32:08 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/2] btrfs-progs: free space tree fixes
Date:   Fri, 20 May 2022 09:31:49 +0800
Message-Id: <cover.1653009947.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I was debugging a weird behavior that btrfs kernel chooses not to
allocate a new data extent at an empty data block group.

And when checking the free space tree, it turned out that, we always
use bitmaps in btrfs-progs no matter what.

This results some every concerning free space tree after mkfs:

  $ mkfs.btrfs  -f -m raid1 -d raid0 /dev/test/scratch[1234]
  btrfs-progs v5.17
  [...]
  Block group profiles:
    Data:             RAID0             4.00GiB
    Metadata:         RAID1           256.00MiB
    System:           RAID1             8.00MiB
  [..]

  $ btrfs ins dump-tree -t free-space /dev/test/scratch1
  btrfs-progs v5.17
  free space tree key (FREE_SPACE_TREE ROOT_ITEM 0)
  node 30441472 level 1 items 10 free space 483 generation 6 owner FREE_SPACE_TREE
  node 30441472 flags 0x1(WRITTEN) backref revision 1
  fs uuid deddccae-afd0-4160-9a12-48fe7b526fb1
  chunk uuid 68f6cf98-afe3-4f47-9797-37fd9c610219
          key (1048576 FREE_SPACE_INFO 4194304) block 30457856 gen 6
          key (475004928 FREE_SPACE_BITMAP 8388608) block 30703616 gen 5
          key (953155584 FREE_SPACE_BITMAP 8388608) block 30720000 gen 5
          key (1431306240 FREE_SPACE_BITMAP 8388608) block 30736384 gen 5
          key (1909456896 FREE_SPACE_BITMAP 8388608) block 30752768 gen 5
          key (2387607552 FREE_SPACE_BITMAP 8388608) block 30769152 gen 5
          key (2865758208 FREE_SPACE_BITMAP 8388608) block 30785536 gen 5
          key (3343908864 FREE_SPACE_BITMAP 8388608) block 30801920 gen 5
          key (3822059520 FREE_SPACE_BITMAP 8388608) block 30818304 gen 5
          key (4300210176 FREE_SPACE_BITMAP 8388608) block 30834688 gen 5
  [...]
  ^^^ So many bitmaps that an empty fs will have two levels for free
      space tree already

Thankfully, kernel can properly merge those bitmaps into a large extent
at mount, so it won't be that scary forever.

It turns out that, we never set btrfs_block_group::bitmap_high_thresh,
thus we always convert free space extents to bitmaps, and waste space
unnecessarily.

Fix it by cross-port the needed function
set_free_space_tree_thresholds() from kernel and call it at correct
timing.

And finally add a test case for it.

Unfortunately, even with this fixed, kernel is still doing its weird
behavior, as it's the cached un-clustered allocation code causing the
problem...

Qu Wenruo (2):
  btrfs-progs: properly initialize btrfs_block_group::bitmap_high_thresh
  btrfs-progs: mkfs-tests: add test case to make sure we don't create
    bitmaps for empty fs

 kernel-shared/extent-tree.c              |  2 ++
 kernel-shared/free-space-tree.c          | 29 ++++++++++++++++++++
 kernel-shared/free-space-tree.h          |  2 ++
 tests/mkfs-tests/024-fst-bitmaps/test.sh | 35 ++++++++++++++++++++++++
 4 files changed, 68 insertions(+)
 create mode 100755 tests/mkfs-tests/024-fst-bitmaps/test.sh

-- 
2.36.1

