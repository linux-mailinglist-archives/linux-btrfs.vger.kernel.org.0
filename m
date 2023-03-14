Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C8A6B8C08
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Mar 2023 08:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjCNHfx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Mar 2023 03:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjCNHfa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Mar 2023 03:35:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0576588ED9
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 00:35:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6BAAC1F88C
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 07:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678779325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=1Tmrk8vTBj4vcMoqDrb/JeedtDa0UFkNOAbhmL6Cwnc=;
        b=GZ2p6Q72t9qzb8Wx6FQHnoNU2V36iZI9f2EpZY2TLT7ADQSINl0+mDtOKkz8HGoDmI2PaL
        le0o+2hCFoKABvdvX8M0VtJiBzGlLhk8svjRRmV+l0VNLwPcBVu3dDW4KYburgllP+9VGu
        O5z5L1xJrPDfnGiHlRiR9Vplcrkg8UE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CDF7013A26
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 07:35:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id CZiBJrwjEGTvJAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Mar 2023 07:35:24 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 00/12] btrfs: scrub: use a more reader friendly code to implement scrub_simple_mirror()
Date:   Tue, 14 Mar 2023 15:34:55 +0800
Message-Id: <cover.1678777941.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This series can be found in my github repo:

https://github.com/adam900710/linux/tree/scrub_stripe

It's recommended to fetch from the repo, as our misc-next seems to
change pretty rapidly.

[Changelog]
v2:
- Use batched scrub_stripe submission
  This allows much better performance compared to the old scrub code

- Add scrub specific bio layer helpers
  This makes the scrub code to be completely rely on logical bytenr +
  mirror_num.

[PROBLEMS OF OLD SCRUB]

- Too many delayed jumps, making it hard to read
  Even starting from scrub_simple_mirror(), we have the following
  functions:

  scrub_extent()
       |
       v
  scrub_sectors()
       |
       v
  scrub_add_sector_to_rd_bio()
       | endio function
       v
  scrub_bio_end_io()
       | delayed work
       v
  scrub_bio_end_io_worker()
       |
       v
  scrub_block_complete()
       |
       v
  scrub_handle_errored_blocks()
       |
       v
  scrub_recheck_block()
       |
       v
  scrub_repair_sector_from_good_copy()

  Not to mention the hidden jumps in certain branches.

- IOPS inefficient for fragmented extents

  The real block size of scrub read is between 4K and 128K.
  If the extents are not adjacent, the blocksize drops to 4K and would
  be an IOPS disaster.

- All hardcoded to do the logical -> physical mapping by scrub itself
  No usage of any existing bio facilities.
  And even implemented a RAID56 recovery wrapper.

[NEW SCRUB_STRIPE BASED SOLUTION]

- Overall streamlined code base

  queue_scrub_stripe()
     |
     v
  scrub_find_fill_first_stripe()
     |
     v
  done

  Or

  queue_scrub_stripe()
     |
     v
  flush_scrub_stripes()
     |
     v
  scrub_submit_initial_read()
     | endio function
     v
  scrub_read_endio()
     | delayed work
     v
  scrub_stripe_read_repair_worker()
     |
     v
  scrub_verify_one_stripe()
     |
     v
  scrub_stripe_submit_repair_read()
     |
     v
  scrub_write_sectors()
     |
     v
  scrub_stripe_report_errors()

  Only one endio and delayed work, all other work are properly done in a
  sequential workflow.

- Always read in 64KiB block size
  The real blocksize of read starts at 64KiB, and ends at 512K.
  This already results a better performance even for the worst case:

  With patchset:	404.81MiB/s
  Without patchset:	369.30MiB/s

  Around 10% performance improvement on an SATA SSD.

- All logical bytenr/mirror_num based read and write

  With the new single stripe fast path in btrfs_submit_bio(), scrub can
  reuse most of the bio layer code, result much simpler scrub code.

[TODO]

- More testing on zoned devices
  Now the patchset can already pass all scrub/replace groups with
  regular devices.

- More cleanup on RAID56 path
  Now RAID56 still uses some old facility, resulting things like
  scrub_sector and scrub_bio can not be fully cleaned up.

Qu Wenruo (12):
  btrfs: scrub: use dedicated super block verification function to scrub
    one super block
  btrfs: introduce a new helper to submit bio for scrub
  btrfs: introduce a new helper to submit write bio for scrub
  btrfs: scrub: introduce the structure for new BTRFS_STRIPE_LEN based
    interface
  btrfs: scrub: introduce a helper to find and fill the sector info for
    a scrub_stripe
  btrfs: scrub: introduce a helper to verify one metadata
  btrfs: scrub: introduce a helper to verify one scrub_stripe
  btrfs: scrub: introduce the main read repair worker for scrub_stripe
  btrfs: scrub: introduce a writeback helper for scrub_stripe
  btrfs: scrub: introduce error reporting functionality for scrub_stripe
  btrfs: scrub: introduce the helper to queue a stripe for scrub
  btrfs: scrub: switch scrub_simple_mirror() to scrub_stripe
    infrastructure

 fs/btrfs/bio.c       |  142 +++-
 fs/btrfs/bio.h       |   22 +-
 fs/btrfs/file-item.c |    9 +-
 fs/btrfs/file-item.h |    3 +-
 fs/btrfs/raid56.c    |    2 +-
 fs/btrfs/scrub.c     | 1656 ++++++++++++++++++++++++++++++------------
 6 files changed, 1348 insertions(+), 486 deletions(-)

-- 
2.39.2

