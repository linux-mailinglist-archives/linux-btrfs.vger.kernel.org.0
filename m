Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09FF5ED7E5
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Sep 2022 10:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbiI1IgO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Sep 2022 04:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiI1IgL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Sep 2022 04:36:11 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0695101C6
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 01:36:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2EBD821DB4
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 08:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664354166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=N/PYCAj4YYgPfnY15jUK2B2geyOjkjraflVCY0oiT8Q=;
        b=Oe2ST2gE2ksQvOLyDx+kW0vBruHcXp61h4BA/WfNnB1jLZvivq4WafwjVmbZY1plZQERwI
        yZPOUhctpADzSg1ia0Vn/XQFoWucAvPBf49FfgjOGLLRs49n7b2q5gYsw10JecM4VSDNKk
        g6iwhVLfM844t+3HAe2mpriNNQuha1k=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7245213A84
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 08:36:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id C9HuDXUHNGO2VgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 08:36:05 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH PoC v2 00/10] btrfs: scrub: introduce a new family of ioctl, scrub_fs
Date:   Wed, 28 Sep 2022 16:35:37 +0800
Message-Id: <cover.1664353497.git.wqu@suse.com>
X-Mailer: git-send-email 2.37.3
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
POC v2:
- Move the per-stripe verification to endio function
  This is to improve the performance, since my previous testing shows
  my Ryzen 5900X can only achieve ~2GiB/s CRC32 per-core, the old
  verification in main thread can be a bottleneck for fast storage.

- Add repair (writeback) support
  Now the corrupted sectors which also have good copy in the veritical
  stripes can be written back to repair.

- Change stat::data_nocsum_uncertain to stat::data_nocsum
  The main problem here is we have no way to distinguish preallocated
  extents with real NODATASUM extents.
  (Without doing complex backref walk and pre-alloc checks).

  Thus comparing the NODATASUM ranges inside the same veritical stripe
  doesn't make that much sense.

  So here we just report how many bytes don't have csum.

[BACKGROUND]
Depite the write-hole problem of RAID56, scrub is neither RAID56
friendly in the following points:

- Extra IO for RAID56 scrub
  Currently data strips of RAID56 can be read 2x (RAID5) or 3x (RAID6).

  This is caused by the fact we do one-thread per-device scrub.

  Dev 1    |  Data 1  | P(3 + 4) |
  Dev 2    |  Data 2  |  Data 3  |
  Dev 3    | P(1 + 2) |  Data 4  |

  When scrubbing Dev 1, we will read Data 1 (treated no differently than
  SINGLE), then read Parity (3 + 4).
  But to determine if Parity (3 + 4) is correct, we have to read Data 3
  and Data 4.

  On the other hand, Data 3 will also be read by scrubbing Dev 2,
  and Data 4 will also be read by scrubbing Dev 3.

  Thus all data stripes will be read twice, causing slow down in RAID56
  scrubbing.

- No proper progress report for P/Q stripes
  The scrub_progress has no member for P/Q error reporting at all.

  Thus even if we fixed some P/Q error, it will not be reported at all.

To address the above problems, this patchset will introduce a new
family of ioctl, scrub_fs ioctls.

[CORE DESIGN]
The new scrub_fs ioctl will go block group by block group, to scrub the
full fs.

Inside each block group, we go BTRFS_STRIPE_LEN as one scrub unit (will
be enlarged later to improve parallel for RAID0/10).

Then we read the full BTRFS_STRIPE_LEN bytes from each mirror (if there
is an extent inside the range).

The read bios will be submitted to each device at once, so we can still
take advantage of parallel IOs.

But the verification part still only happens inside the scrub thread, no
parallel csum check.

Also this ioctl family will rely on a much larger progress structure,
it's padded to 256 bytes, with parity specific error reporting (not yet
implemented though).

[THE GOOD]
- Every stripe will be iterated at most once
  No double read for data stripes.

- Better error reports for parity mismatch

- No need for complex bio form shaping
  Since we already submit read bios in BTRFS_STRIPE_LEN unit, and wait
  for them to finish, there are only at most nr_copies bios at fly.
  (For later RAID0/10 optimization, it will be nr_stripes)

  This behavior will reduce the IOPS usage by nature, thus no need to
  do any bio form shaping.

  This greatly reduce the code size, just check how much code are spent
  for bio form shaping in the old scrub code.

- Less block groups marked for read-only
  Now there is at most one block group marked read-only for scrub,
  reducing the possibility of ENOSPC during scrub.

[THE BAD]
- Slower for SINGLE profile
  If some one is using SINGLE profile on multiple devices, scrub_fs will
  slower.

  Dev 1:   | SINGLE BG 1 |
  Dev 2:   | SINGLE BG 2 |
  Dev 3:   | SINGLE BG 3 |

  The existing scrub code will scrub single BG 1~3 at the same time.
  But the new scrub_fs will scrub single BG 1 first, then 2, then 3.
  Causing much slower scrub for such case.

  Although I'd argue, for above case, the user should go RAID0 anyway.

[THE UGLY]
Since this is just a proof-of-concept patchset, it lacks the following
functionality/optimization:

- Slower RAID0/RAID10 scrub.
  Since we only scrub BTRFS_STRIPE_LEN, it will not utilize all devices
  from RAID0/10.
  Although it can be easily enhanced by enlarging the scrub unit to a
  full stripe.

- No RAID56 support
  Ironically.

- Very basic btrfs-progs support
  Really only calls the ioctl and gives an output.
  No background scrub or scrub status file support.

- No drop-in full fstests run yet


Qu Wenruo (10):
  btrfs: introduce BTRFS_IOC_SCRUB_FS family of ioctls
  btrfs: scrub: introduce place holder for btrfs_scrub_fs()
  btrfs: scrub: introduce a place holder helper scrub_fs_iterate_bgs()
  btrfs: scrub: introduce place holder helper scrub_fs_block_group()
  btrfs: scrub: add helpers to fulfill csum/extent_generation
  btrfs: scrub: submit and wait for the read of each copy
  btrfs: scrub: implement metadata verification code for scrub_fs
  btrfs: scrub: implement data verification code for scrub_fs
  btrfs: scrub: implement the later stage of verification
  btrfs: scrub: implement the repair (writeback) functionality

 fs/btrfs/ctree.h           |    4 +
 fs/btrfs/disk-io.c         |   83 ++-
 fs/btrfs/disk-io.h         |    2 +
 fs/btrfs/ioctl.c           |   45 ++
 fs/btrfs/scrub.c           | 1372 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/btrfs.h |  174 +++++
 6 files changed, 1654 insertions(+), 26 deletions(-)

-- 
2.37.3

