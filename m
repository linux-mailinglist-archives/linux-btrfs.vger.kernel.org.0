Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFE6533B1D
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 May 2022 12:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbiEYK7k (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 May 2022 06:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiEYK7j (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 May 2022 06:59:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17375F8C1
        for <linux-btrfs@vger.kernel.org>; Wed, 25 May 2022 03:59:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5DE821F939;
        Wed, 25 May 2022 10:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653476377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=IbMWGs1Q73oJGL6ZP2UwjInKwXny0zDHJFPILXKCMEk=;
        b=FDHW6JEPkR2q/tBfrPrtCm0S8EI22NWAQQcBpPFW4vQagSiJGjb2k2H66rQ6dr9NJZmUpb
        xsIvX6Is+MTF+hDMYYs9FbZV2oH+PfJ1GTLR42LoJzFm3Pn9FMxwMiS3J0j+Jkzs4qA6q9
        G5bqiWLkSOIS4qk1YaMjwDSazWti0GY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 786BA13ADF;
        Wed, 25 May 2022 10:59:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SPdzEBgMjmK0AQAAMHmgww
        (envelope-from <wqu@suse.com>); Wed, 25 May 2022 10:59:36 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 0/7] btrfs: read-repair rework based on bitmap
Date:   Wed, 25 May 2022 18:59:10 +0800
Message-Id: <cover.1653476251.git.wqu@suse.com>
X-Mailer: git-send-email 2.36.1
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

This is the bitmap version revivied, and based on Christoph's
cleanup series.

The branch can be feteched from my repo:
https://github.com/adam900710/linux/tree/read_repair

Changelog:
v2:
- Still go bitmap version to get batched submission

- Instead of using the old failed bio to hold all the pages, here we
  use an oridnary bio to hold only the corrupted sectors.

- Unlike previous bitmap version, this time no memory allocation
  The needed bitmap will be on-stack, and only limit to 32bits.

- Go synchronous submission for read and write

- Only use bitmap for the corrupted range.
  Unlike previous version, which allocate bio for the whole bio.
  That's a waste of memory.

- btrfs_read_repair_sector() will submit the existing repair early
  For uncontinuous new sector or if we have reached size limit
  (due to bitmap size limit, now it's 128K for 4K sectorsize).

  This allow us to use fixed bitmap size.


The core function is still btrfs_read_repair_finish().

But now, btrfs_read_repair_finish() either get called without any
corrupted sectors, or it will only face a continuous range of corrupted
sectors.

Then we handle the range by iterating all the remaining mirrors.

For each mirror we go:

1) Try to add current bad sector into our io_bio.
   If our io_bio is not continuous, we just submit current io_bio and
   wait for it.
   Then add the new sector into it.

2) If the io_bio is not empty, submit it.

By 1) and 2), we will read all bad sectors from the new mirror.

3) Check if the data is fine and update our ctrl::bad_bitmap

We either end with all sectors repaired, or all mirrors exhausted.

The advantage of bitmap method is, we only try at most (num_copies - 1)
times, no matter the corruption pattern.

On the other hand, for the worst case we're still doing sector by sector
repair.
For the best case (aka, continuous corruption cases), we still do
batched bio submission, thus still way better than sector-by-sector
repair.

Furthermore, all loops in the code are regular for() loops, no hacking
on how we loop.

But I have to admit, even the repair_from_mirror() and
btrfs_read_repair_finish() is super easy to read, the details on bio
page adding and submission are all hidden into io_add_or_submit() and
btrfs_read_repair_add_sector().

Although it has better worst case performance, it's no better than
sector-by-sector repair in worst case scenario.

Cc: Christoph Hellwig <hch@lst.de>


Christoph Hellwig (1):
  btrfs: add a btrfs_map_bio_wait helper

Qu Wenruo (6):
  btrfs: save the original bi_iter into btrfs_bio for buffered read
  btrfs: make repair_io_failure available outside of extent_io.c
  btrfs: introduce new read-repair infrastructure
  btrfs: make buffered read path to use the new read repair
    infrastructure
  btrfs: make direct io read path to use the new read repair
    infrastructure
  btrfs: remove io_failure_record infrastructure completely

 fs/btrfs/Makefile            |   2 +-
 fs/btrfs/btrfs_inode.h       |   5 -
 fs/btrfs/extent-io-tree.h    |  15 --
 fs/btrfs/extent_io.c         | 436 +++--------------------------------
 fs/btrfs/extent_io.h         |  28 +--
 fs/btrfs/inode.c             |  60 ++---
 fs/btrfs/read-repair.c       | 328 ++++++++++++++++++++++++++
 fs/btrfs/read-repair.h       |  48 ++++
 fs/btrfs/volumes.c           |  21 ++
 fs/btrfs/volumes.h           |   2 +
 include/trace/events/btrfs.h |   1 -
 11 files changed, 458 insertions(+), 488 deletions(-)
 create mode 100644 fs/btrfs/read-repair.c
 create mode 100644 fs/btrfs/read-repair.h

-- 
2.36.1

