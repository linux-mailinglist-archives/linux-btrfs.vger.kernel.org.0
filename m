Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8A561484E
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Nov 2022 12:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbiKALQV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Nov 2022 07:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiKALQT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Nov 2022 07:16:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831C717E20
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 04:16:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 008D033883
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 11:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667301375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=0aqS6AhZvS56ijxy9Y8tBxR1UGIhumnqXA+BofyT/vw=;
        b=n4ila/jEAHm2u60ELpA+bPb8lN9nGp9P3pKftzwhGLvjxG2OcivQlBN0OZmMiKUmG+J453
        ULO55OLLxX5nXcbWiz+yFoyh1vjda9FPw60rW9YUxIqvprYwkzOsoBwxS0Cz5Vsh64TPA8
        Ep501NbPjT9nju4/F0nUuyeE0AzFZN8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6DDFE1346F
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Nov 2022 11:16:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 31Q/EP7/YGMIawAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Nov 2022 11:16:14 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 00/12] btrfs: raid56: use submit-and-wait method to handle raid56 worload
Date:   Tue,  1 Nov 2022 19:16:00 +0800
Message-Id: <cover.1667300355.git.wqu@suse.com>
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

[CHANGELOG]
v2:
- Add coverage for raid56 recover and scrub paths
  In fact, with full coverage we can do better cleanups, which gets
  reflected to the changed lines.

- Better naming schemes
  We now have 3 main entrances:
  * recover_rbio()
  * rmw_rbio()
  * scrub_rbio()

  And their work related functions will be called:
  * {recover|rmw|scrub}_rbio_work()
  * {recover|rmw|scrub}_rbio_work_locked()

  The later is for unlock_stripe() to call, where we hold the full
  stripe lock.

- More extracted helpers
  Now we have the following helpers:
  * {recover|rmw|scrub}_assemble_{read|write}_bios()
  * submit_read_bios()
  * submit_write_bios()

Currently btrfs raid56 has very chaotic jumps using endio functions:

E.g. for raid_parity_write(), if we go sub-stripe, the function jumps
would be:

  raid_parity_write()
   |
   v
  __raid56_parity_write()
   |
   v
  partial_stripe_write()
   |
   v
  start_async_work(rmw_work) <<< Delayed work
   |
   v
  raid56_rmw_stripe()
   |
   v
  raid56_rmw_end_io_work() <<< End io jump
   |
   v
  validate_rbio_for_rmw()
   |
   v
  finish_rmw()
   |
   v
  raid_write_end_io() <<< End io jump
   |
   v
  rbio_orig_end_io()

During a simple sub-stripe write, we have to go through over 10
functions, two end_io jump, at least one delayed work.

With this patchset, we only go like this:

  raid_parity_write()
   |
   v
  rmw_rbio_work() <<< Delayed work
   |
   v
  rbio_work()
   |
   v
  rbio_orig_end_io()

And inside rbio_work(), there is no more end io jumps or extra delayed
work.
Everything except IO is single threaded, and the IO is just
submit-and-wait.

This patchset will rework the raid56 write path (recover and scrub path
is not touched yet) by:

- Introduce a single entrance for recover/rmw/scrub.
  The main function will be called {recover|rmw|scrub}_rbio(),
  executed in rmw_worker workqueue.

- Unified handling for all writes (full/sub-stripe, cached/non-cached,
  degraded or not), recover (dedicated, and in writes/scrub path) and
  scrub.

- No special handling for cases we can skip some workload
  E.g. for sub-stripe write, if we have a cached rbio, we can skip the
  read.

  Now we just assemble the read bio list, submit all bios (none in
  this case) and wait for the IO to finish.

  Since we submitted zero bios, the rbio::stripes_pending is 0, the
  wait immediately returned, needing no extra handling.

- No more need for end_io_work or raid56_endio_workers
  Since we don't rely on endio functions to jump to the next step.

By this, we have unified entrance for all raid56 writes, and no extra
jumping/workqueue mess to interrupt the workflow.

This would make later destructive RMW fix much easier to add, as the
timing of each step in RMW cycle should be very easy to grasp.

Thus I hope this series can be merged before the previous RFC series of
destructive RMW fix.

Qu Wenruo (12):
  btrfs: raid56: extract the vertical stripe recovery code into
    recover_vertical()
  btrfs: raid56: extract the pq generation code into a helper
  btrfs: raid56: extract the recovery bio list build code into a helper
  btrfs: raid56: extract sector recovery code into a helper
  btrfs: raid56: switch recovery path to a single function
  btrfs: raid56: extract the rmw bio list build code into a helper
  btrfs: raid56: extract rwm write bios assembly into a helper
  btrfs: raid56: introduce the a main entrance for rmw path
  btrfs: raid56: switch write path to rmw_rbio()
  btrfs: raid56: extract scrub read bio list assembly code into a helper
  btrfs: raid56: switch scrub path to use a single function
  btrfs: remove the unused btrfs_fs_info::endio_raid56_workers and
    btrfs_raid_bio::end_io_work

 fs/btrfs/disk-io.c |    6 +-
 fs/btrfs/fs.h      |    1 -
 fs/btrfs/raid56.c  | 1422 ++++++++++++++++++++------------------------
 fs/btrfs/raid56.h  |    2 +-
 4 files changed, 631 insertions(+), 800 deletions(-)

-- 
2.38.1

