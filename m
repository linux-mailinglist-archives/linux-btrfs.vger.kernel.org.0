Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB88643E70
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Dec 2022 09:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbiLFIYN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 6 Dec 2022 03:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233742AbiLFIX7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 6 Dec 2022 03:23:59 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C2D12619
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 00:23:57 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9257721C04
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 08:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1670315036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=PjdxLHfas3O041If/eWGJUUEDfKOtUnn8wqZHdcawAQ=;
        b=ehvWW1XgWkcm8z+fiqtErSoABAL6ox/Tlt384lJ4SU6vu8jaUlFw8cIpeUKP+PxaHiCChw
        2tP4Ydc5cabk+/PzV9rtprK3hvWFc0Nl+2GFUISRHKeec2h6B8GTa/2ZbHRrjMNRzyajpM
        DxjZrrZv91SJ2j9eah01UFk9wiiHGRE=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 02992132F3
        for <linux-btrfs@vger.kernel.org>; Tue,  6 Dec 2022 08:23:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id L5rRMBv8jmNRbAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 06 Dec 2022 08:23:55 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PoC PATCH 00/11] btrfs: scrub: rework to get rid of the complex bio formshaping
Date:   Tue,  6 Dec 2022 16:23:27 +0800
Message-Id: <cover.1670314744.git.wqu@suse.com>
X-Mailer: git-send-email 2.38.1
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

This is a proof-of-concept patchset, thus don't merge.

This series is mostly a full rework of low level scrub code.

Although I implemented the full support for all profiles, only raid56
code is partially cleaned up (which is already over 1K lines removed).
The estimated full cleanup will be around 1~2K more lines removed
eventually.

The series is sent out for feedback, as the full patchset can be very
large (mostly to remove old codes).

[PROBLEMS OF SCRUB]

TL;DR
The current scrub code is way too complex for future expansion.

Current scrub code has a complex system to manage its in-flight bios.

This behavior is designed to improve scrub performance, but has a lot of
disadvantage too:

- Too many indirect calls/jumps

  To scrub one extent in a simple mirror (like SINGLE), the call chain
  involves the following functions:

  /* Before entering scrub_simple_mirror() */
  scrub_ctx()
  |- INIT_WORK(&sbio->work, scrub_bio_end_io_worker);

  /* In scrub_simple_mirror() */
  scrub_extent()
  |- scrub_sectors()
     |- scrub_add_sector_to_rd_bio()
        |- sbio->bio->bi_end_io = scrub_bio_end_io;

  /* Now it jumps to the endio function */

  scrub_bio_end_io()
  |- queue_work()

  /* Now it jumps to workqueue, which is setup in scrub_ctx() */
  scrub_bio_end_io_worker()
  |- scrub_block_complete()
     |- scrub_handle_errored_block() /* For corruption case */
     |  |- scrub_recheck_block()
     |     |- scrub_repair_block_from_good_copy()
     |- scrub_checksum()
     |- scrub_write_block_to_dev_replace()

  The whole jumps/delayed calls are really a mess to read.
  This makes me wonder if the original code is really designed for human
  to read.

- Complex bio form-shaping
  We have scrub_bio to manage the in-flight bios.

  It has at most 64 bios for one device scrub, and each bio can be as
  large as 128K.

  This is definitely a big performance enhancement.

  But I'm not convinced that scrub performance should be the first thing
  to consider.

- No usage of btrfs_submit_bio()
  This means we're doing a lot of things which can already be handled by
  btrfs_submit_bio().

  This means quite some duplicated code.

[ENHANCEMENT]

This patchset will introduce a new infrasturcture, scrub2_stripe.

The "scrub2" prefix is to avoid naming conflicts.

The overall idea is, we always do scrub in the unit of BTRFS_STRIPE_LEN,
hence the "scrub2_stripe".

Furthermore, all work will done in a submit-and-wait fashion, reducing
the delayed calls/jumps to minimal.

The new scrub entrance in scrub_simple_mirror() would looks like this:

  scrub_simple_mirror()
  |  /* Find a stripe with at least one sector used */
  |- scrub2_find_fill_first_stripe()
  |
  |  /* Submit a read for the whole 64KiB */
  |- scrub2_read_and_wait_stripe()
  |  |- btrfs_submit_bio()
  |  |  /* do the verification for all sectors */
  |  |- scrub2_verify_one_stripe()
  |
  |- scrub2_reapair_one_stripe()
  |  |- scrub2_repair_from_mirror()
  |     |  /* reuse the existing read path */
  |     |- scrub2_read_and_wait_stripe()
  |
  |- scrub2_report_errors()
  |
  |  /*
  |   * For dev-replace and regular scrub repair, the write range
  |   * will be different.
  |   * (replace will writeback all good sectors, repair only writes
  |   *  back repaired sectors).
  |   */
  |- scrub2_writeback_sectors()
  
Everything is done in a submit-and-wait fashion.

Although this will reduce concurrency, the readability will be greatly
improved.

Furthermore since we're already submitting read in 64KiB size, it's less
IOPS intense, thus it's already doing optimization for read.

Even if the performance is not that good, it can be enhanced later by
using scrub2_stripe_group to submit multiple stripes in one go (aka,
enlarge the block size) to improve performance, without damaging
readability.

[CURRENT FEATURES]

- Working scrub/replace for all profiles
  Currently only non-raid56 is tested.

[TODO]

There are a lot of todos:

- Completely remove scrub_bio/scrub_block/scrub_sector
  I estimate that would result further 1~2K lines removed.

  Unfortunately, thus huge cleanup will take way more patches than
  usual.

- Add proper support for zoned devices
  Currently zoned code is not touched, but existing zoned code relies on
  scrub_bio.
  Thus they won't work at all.

- Proper performance benchmarking


Qu Wenruo (11):
  btrfs: scrub: introduce the structure for new BTRFS_STRIPE_LEN based
    interface
  btrfs: scrub: introduce a helper to find and fill the sector info for
    a scrub2_stripe
  btrfs: scrub: introduce a helper to verify one scrub2_stripe
  btrfs: scrub: add the repair function for scrub2_stripe
  btrfs: scrub: add a writeback helper for scrub2_stripe
  btrfs: scrub: add the error reporting for scrub2_stripe
  btrfs: scrub: add raid56 P/Q scrubbing support
  btrfs: scrub: use dedicated super block verification function to scrub
    one super block
  btrfs: scrub: switch to the new scrub2_stripe based infrastructure
  btrfs: scrub: cleanup the old scrub_parity infrastructure
  btrfs: scrub: cleanup scrub_extent() and its related functions

 fs/btrfs/disk-io.c   |   10 +-
 fs/btrfs/disk-io.h   |    2 +
 fs/btrfs/file-item.c |    8 +-
 fs/btrfs/file-item.h |    3 +-
 fs/btrfs/raid56.c    |    2 +-
 fs/btrfs/scrub.c     | 2263 +++++++++++++++++++++++-------------------
 6 files changed, 1238 insertions(+), 1050 deletions(-)

-- 
2.38.1

