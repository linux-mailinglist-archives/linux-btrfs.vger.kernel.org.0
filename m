Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0A36CB256
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 01:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjC0Xb1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 19:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0XbZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 19:31:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D693CA6
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 16:31:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A0BE1219CB
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 23:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679959881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=9O/o+mBMEz6MzAi9mYppKaMujc1iX4XEDLLeaUxppo0=;
        b=sq74E0gyv+V6c8LQDDppxGjsjLhC+dfBEzkrAWi4Ugn+sPsWF+DYEq0Di0AQ4fXu42Qp80
        NW7TR/vNpiQyjGiThkJH1HoQw6KpaefbkdyjnZLXqbvyC7BW4yBNUQiJUO1wmRjbLekAwf
        rWl1xVrY8QMRzBXQO+iCi8fhSom87JU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F30C13482
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 23:31:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P3XJM0gnImTaaAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 23:31:20 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v5 00/13] btrfs: scrub: use a more reader friendly code to implement scrub_simple_mirror()
Date:   Tue, 28 Mar 2023 07:30:50 +0800
Message-Id: <cover.1679959770.git.wqu@suse.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
v5:
- Fix a bug that unconditionally repairs a zoned block group
  Only trigger the repair if we had any initial read failure

  Huge thanks to Johannes for the initial ZNS tests.

v4:
- Add a dedicated patch to add btrfs_bio::fs_info
  Along with dedicated allocator for scrub btrfs bios.
  The dedicated allocator is due to the fact that scrub and regular
  btrfs bios have very different mandatory members (fs_info vs inode +
  file_offset).
  For now I believe a different allocator would be better.

- Some code style change
  * No more single letter temporray structure copied from old scrub code
  * Use "for (int i = 0; ...)" when possible
  * Some new lines fixes
  * Extra brackets for tenrary operators
  * A new macro for (BTRFS_STRIPE_LEN >> PAGE_SHIFT)
  * Use enum for scrub_stripe::state bit flags
  * Use extra brackets for double shifting
  * Use explicit != 0 or == 0 comparing memcmp() results
  * Remove unnecessary ASSERT()s after btrfs_bio allocation

v3:
- Add a dedicated @fs_info member for btrfs_bio
  Unfortunately although we have a 32 bytes hole between @end_io_work and @bio,
  compiler still choose not to use that hole for whatever reasons.
  Thus this would increase the size of btrfs_bio by 4 bytes.

- Rebased to lastest misc-next

- Fix various while space error not caught by btrfs-workflow

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


Qu Wenruo (13):
  btrfs: scrub: use dedicated super block verification function to scrub
    one super block
  btrfs: introduce a new allocator for scrub specific btrfs_bio
  btrfs: introduce a new helper to submit read bio for scrub
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

 fs/btrfs/bio.c       |  165 ++++-
 fs/btrfs/bio.h       |   22 +-
 fs/btrfs/file-item.c |    9 +-
 fs/btrfs/file-item.h |    3 +-
 fs/btrfs/raid56.c    |    2 +-
 fs/btrfs/scrub.c     | 1655 ++++++++++++++++++++++++++++++------------
 6 files changed, 1371 insertions(+), 485 deletions(-)

-- 
2.39.2

