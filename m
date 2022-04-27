Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE165511243
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Apr 2022 09:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358678AbiD0HW3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 27 Apr 2022 03:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357783AbiD0HW1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 27 Apr 2022 03:22:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83A45D5CE
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 00:19:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6495E1F380
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651043956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UpifccS/B0BpiUqPyiKZqQxaGD13VggDMzYqPi4UUPo=;
        b=S1Utw9cEhdTFUsAk1d09TSC1rbBIqJ2Qd58n8e1Sp+MlSJjp2KAsjh80en8ykfBZN8j9sF
        8vqyhdEc0W/hbVEC4InzOkrRFrZPOiBTjdErUP/CPZ96Q5TeQpFSYXJSZOWMmUyZEb0NrH
        l07m5M3qOu3C89ZBmZKrkxuRpCr6zqM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A7AFD13A39
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nEL3GnPuaGIbJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 27 Apr 2022 07:19:15 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC v2 00/12] btrfs: make read repair work in synchronous mode
Date:   Wed, 27 Apr 2022 15:18:46 +0800
Message-Id: <cover.1651042800.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[CHANGELOG]
RFC v1 -> RFC v2:
- Assemble a bio list for read/write bios and submit them in one go
  This allows less submit bio hooks, while still allow us to wait
  for them all to finish.

- Completely remove io_failure_tree infrastructure
  Now we don't need to remember which mirror we hit error.
  At end_bio_extent_readpage() we either get good data and done the
  repair already, or we there aren't enough mirrors for us to recover
  all data.

  This is mostly trading on-stack memory of end_bio_extent_readpage()
  with btrfs_inode::io_failure_tree.
  The latter tree has a much longer lifespan, thus I think it's still a
  win overall

[RFC POINTS]
- How to improve read_repair_get_sector()?
  Currently we always iterate the whole bio to grab the target
  page/pgoff.

  Is there any better cached method to avoid such iteration?

- Is this new code logically more reader-friendly?
  It's more for sure straight-forward, but I doubt if it's any easier to
  read compared to the old code.

- btrfs/157 failure
  Need extra check to find out why btrfs/157 failed.
  In theory, we should just iterate through all mirrors, I guess it's we
  have no way to exhaust all combinations, thus the extra 2 "mirrors"
  can gave us wrong result for RAID6.

[BEFORE]
For corrupted sectors, we just record the logical bytenr and mirror
number into io_failure_tree, then re-queue the same block with different
mirror number and call it a day.

The re-queued read will trigger enter the same endio function, with
extra failrec handling to either continue re-queue (csum mismatch/read
failure), or clear the current failrec and submit a write to fix the
corrupted mirror (read succeeded and csum match/no csum).

This is harder to read, as we need to enter the same river twice or even
more.

[AFTER]
For corrupted sectors, we record the following things into an on-stack
structure in end_bio_extent_readpage():

- The original bio

- The original file offset of the bio
  This is for direct IO case, as we can not grab file offset just using
  page_offset()

- Offset inside the bio of the corrupted sector

- Corrupted mirror

Then in the new btrfs_read_repair_ctrl structure, we hold those info
like:

Original bio logical = X, file_offset = Y, inode=(R/I)

Offset inside bio: 0  4k 8K 12K 16K
cur_bad_bitmap     | X| X|  | X|

Each set bit will indicate we have a corrupted sector inside the
original bio.

During endio function, we only populate the cur_bad_bitmap.

After we have iterated all sectors of the original bio, then we call
btrfs_read_repair_finish() to do the real repair by:

- Build a list of bios for cur_bad_bitmap
  For above case, bio offset [0, 8K) will be inside one bio, while another bio
  for bio offset [12K, 16K).

  And the page/pgoff will be extracted from the orignial bio.

  This is a little different from the old behavior, as old behavior will
  submit a new bio for each sector.
  The new behavior will save some btrfs_map_bio() calls.

- Submit all the bios in the bio list and wait them to finish

- Re-verify the read result

- Submit write for the corrupted mirror
  Currently the write is still submitted for each sector and we will
  wait for each sector to finish.
  This needs some optimization.

  And for repaired sectors, remove them from @cur_bad_bitmap.

- Do the same loop until either 1) we tried all mirrors, or 2) no more
  corrupted sectors
  
- Handle the remaining corrupted sectors
  Either mark them error for buffered read, or just return an error for
  direct IO.

By this we can:
- Remove the re-entry behavior of endio function
  Now everything is handled inside end_bio_extent_readpage().

- Remove the io_failure_tree completely
  As we don't need to record which mirror has failed.

- Slightly reduced overhead on read repair
  Now we won't call btrfs_map_bio() for each corrupted sector, as we can
  merge the sectors into a much larger bio.


Qu Wenruo (12):
  btrfs: introduce a pure data checksum checking helper
  btrfs: always save bio::bi_iter into btrfs_bio::iter before submitting
  btrfs: remove duplicated parameters from submit_data_read_repair()
  btrfs: add btrfs_read_repair_ctrl to record corrupted sectors
  btrfs: add a helper to queue a corrupted sector for read repair
  btrfs: introduce a helper to repair from one mirror
  btrfs: allow btrfs read repair to submit all writes in one go
  btrfs: switch buffered read to the new btrfs_read_repair_* based
    repair routine
  btrfs: switch direct IO routine to use btrfs_read_repair_ctrl
  btrfs: cleanup btrfs_repair_one_sector()
  btrfs: remove io_failure_record infrastructure completely
  btrfs: remove btrfs_inode::io_failure_tree

 fs/btrfs/btrfs_inode.h       |   5 -
 fs/btrfs/compression.c       |  12 +-
 fs/btrfs/ctree.h             |   2 +
 fs/btrfs/extent-io-tree.h    |  15 -
 fs/btrfs/extent_io.c         | 744 ++++++++++++++++++-----------------
 fs/btrfs/extent_io.h         |  89 +++--
 fs/btrfs/inode.c             | 108 +++--
 include/trace/events/btrfs.h |   1 -
 8 files changed, 518 insertions(+), 458 deletions(-)

-- 
2.36.0

