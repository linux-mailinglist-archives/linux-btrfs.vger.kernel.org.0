Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3386E517DA9
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 May 2022 08:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiECGzo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 May 2022 02:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiECGxs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 May 2022 02:53:48 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87F52614
        for <linux-btrfs@vger.kernel.org>; Mon,  2 May 2022 23:50:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A65F31F38D
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 06:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651560615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=NG3BepjjdvyZu+5/Lu4lrEXYH87xSqkMqnqAn5XPsFs=;
        b=FuBToLhX+DVpJcbSA0bSbWL3JCOONzEzmjx0GsdKwxEgZ5v3HaiPsLuaSq/DllrqqbslyF
        m4SBx6kwwDsbIDFa0k2+UCEchVOIU1TMn82QdgsIm1wiy0Omo6zAy6tyOVce8FMY0rH2+l
        67UXkL2Lm9TTY4YE+MNjvguoiVSJSn0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0EC3A13AA3
        for <linux-btrfs@vger.kernel.org>; Tue,  3 May 2022 06:50:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PkM9NKbQcGIZDAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 03 May 2022 06:50:14 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 00/13] btrfs: make read repair work in synchronous mode
Date:   Tue,  3 May 2022 14:49:44 +0800
Message-Id: <cover.1651559986.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[CHANGELOG]
RFC v2 -> v1:
Most updates are to reduce the memory deadlock in endio function
context.

- Allocate a new mempool for read_repair_bio
  This is to avoid allocating the same btrfs_bio while we're still
  holding one btrfs_bio in its endio function.

  The problem is there for a long time in the existing code, only
  recently Christoph mentioned the possible deadlock scenario.

  Furthermore, our new read_repair_bio is much smaller than btrfs_bio,
  avoid wasting memory on unused members.

- Submit the assembled bio immediate if the next sector is not mergeable
  Instead of holding them in a bio list, this gives us higher chance to
  reclaim the space allocated for the read_repair_bio.

- Pre-allocate needed two bitmaps inside btrfs_submit_data_bio()
  If we failed to allocated the memory, we just fail the bio, and VFS
  layer will re-try with much smaller range, and we will have a much
  higher chance to allocate the needed memory in the next try.

- Fix the btrfs/157 failure by introducing RAID56 specific repair
  The old repair_io_failure() can handle it pretty well, although in
  that case we will lose the async bio submission, but that should still
  be acceptable just for RAID56.

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

Before submitting a data read bio, we will pre-allocate the bitmaps used
by read repair first.
If we have no memory, we just fail and let VFS layer to retry with
smaller range, and we will have a larger chance to get the memory in
next try.

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

After we have iterated all sectors of the original bio, then we call
btrfs_read_repair_finish() to do the real repair by:

- Assemble and submit read bios
  For above case, bio offset [0, 8K) will be inside one bio, while another bio
  for bio offset [12K, 16K).

  And the page/pgoff will be extracted from the original bio.

  This is a little different from the old behavior, as old behavior will
  submit a new bio for each sector.
  The new behavior will save some btrfs_map_bio() calls.

- Submit the last read bio and wait them to finish

- Re-verify the read result

- Submit write for the corrupted mirror
  We do the same behavior just like read bios, assemble and submit them.

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

Qu Wenruo (13):
  btrfs: introduce a pure data checksum checking helper
  btrfs: quit early if the fs has no RAID56 support for raid56 related
    checks
  btrfs: save the original bi_iter into btrfs_bio for buffered read
  btrfs: remove duplicated parameters from submit_data_read_repair()
  btrfs: add btrfs_read_repair_ctrl to record corrupted sectors
  btrfs: add a helper to queue a corrupted sector for read repair
  btrfs: introduce a helper to repair from one mirror
  btrfs: allow btrfs read repair to submit writes in asynchronous mode
  btrfs: handle RAID56 read repair differently
  btrfs: switch buffered read to the new read repair routine
  btrfs: switch direct IO routine to use btrfs_read_repair_ctrl
  btrfs: remove io_failure_record infrastructure completely
  btrfs: remove btrfs_inode::io_failure_tree

 fs/btrfs/Makefile            |   2 +-
 fs/btrfs/btrfs_inode.h       |   5 -
 fs/btrfs/compression.c       |  10 +-
 fs/btrfs/ctree.h             |   2 +
 fs/btrfs/extent-io-tree.h    |  15 --
 fs/btrfs/extent_io.c         | 490 +++++------------------------------
 fs/btrfs/extent_io.h         |  28 +-
 fs/btrfs/inode.c             | 121 +++++----
 fs/btrfs/read-repair.c       | 459 ++++++++++++++++++++++++++++++++
 fs/btrfs/read-repair.h       |  84 ++++++
 fs/btrfs/super.c             |   9 +-
 fs/btrfs/volumes.c           |   6 +
 fs/btrfs/volumes.h           |   4 +
 include/trace/events/btrfs.h |   1 -
 14 files changed, 695 insertions(+), 541 deletions(-)
 create mode 100644 fs/btrfs/read-repair.c
 create mode 100644 fs/btrfs/read-repair.h

-- 
2.36.0

