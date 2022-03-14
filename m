Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 969C74D7E1F
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 10:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiCNJJC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 05:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbiCNJJB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 05:09:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7364D13F27
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 02:07:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2F32C1F388
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647248870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=O08ywcveG50wpqPLdF1vtzLH1+YpG4ME/4aL7wVO9To=;
        b=NxWvXWj9rpFa85eu2HNgWQe9jqI28X9yUNu67IVqxskrgg3O1uhQlbzFyuyi2HIfH7RBI/
        R28ExbEHoJqPrGq8IOEv9w4G+5/ZSQo5UqsDwIbtZhbNRls+pufFzXU5/nr2NsluZBVV6I
        +PJUxX0bu/XKfJMcTRHp/YJfrSuhoKU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 838B013B9A
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:07:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KsWMEuUFL2IaYgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 09:07:49 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 00/18] btrfs: split bio at btrfs_map_bio() time
Date:   Mon, 14 Mar 2022 17:07:13 +0800
Message-Id: <cover.1647248613.git.wqu@suse.com>
X-Mailer: git-send-email 2.35.1
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

This patchset be fetched from this branch:

https://github.com/adam900710/linux/tree/bio_split

[CHANGELOG]
RFC->v1:
- Better patch split
  Now patch 01~06 are refactors/cleanups/preparations.
  While 07~13 are the patches that doing the conversion while can handle
  both old and new bio split timings.
  Finally patch 14~16 convert the bio split call sites one by one to
  newer facility.
  The final patch is just a small clean up.

- Various bug fixes
  During the full fstests run, various stupid bugs are exposed and
  fixed.

v2:
- Fix the error paths for allocated but never submitted bios
  There are tons of error path that we allocate a bio but it goes
  bio_endio() directly without going through btrfs_map_bio().
  New ASSERTS() in endio functions require a populated btrfs_bio::iter,
  thus for such bios we still need to call btrfs_bio_save_iter() to
  populate btrfs_bio::iter to prevent such ASSERT()s get triggered.

- Fix scrub_stripe_index_and_offset() which abuses stripe_len and
  mapped_length

v3:
- Rebased to latest misc-next
  Now add extra patch to remove the btrfs_get_io_geometry() call used by
  encoded read.

[BACKGROUND]

Currently btrfs never uses bio_split() to split its bio against RAID
stripe boundaries.

Instead inside btrfs we check our stripe boundary every time we allocate
a new bio, and ensure the new bio never cross stripe boundaries.

This will make later iomap integration much easier, currently Goldwyn is
using btrfs_bio_clone() to clone bio from iomap, then using the cloned
bio to do buffered read/write.

With this patchset, it will be much easier to integrate later iomap
work.

[PROBLEMS]

Although this behavior works fine, it's against the common practice used in
stacked drivers, and is making the effort to convert to iomap harder.

There is also an hidden burden, every time we allocate a new bio, we uses
BIO_MAX_BVECS, but since we know the boundaries, for RAID0/RAID10 we can
only fit at most 16 pages (fixed 64K stripe size, and 4K page size),
wasting the 256 slots we allocated.

[CHALLENGES]

To change the situation, this patchset attempts to improve the situation
by moving the bio split into btrfs_map_bio() time, so upper layer should
no longer bother the bio split against RAID stripes or even chunk
boundaries.

But there are several challenges:

- Conflicts in various endio functions
  We want the existing granularity, instead of chained endio, thus we
  must make the involved endio functions to handle split bios.

  Although most endio functions are already doing their works
  independent of the bio size, they are not yet fully handling split
  bio.

  This patch will convert them to use saved bi_iter and only iterate
  the split range instead of the whole bio.
  This change involved 3 types of IOs:

  * Buffered IO
    Including both data and metadata
  * Direct IO
  * Compressed IO

  Their endio functions needs different level of updates to handle split
  bios.

  Furthermore, there is another endio, end_workqueue_bio(), it can't
  handle split bios at all, thus we change the timing so that
  btrfs_bio_wq_end_io() is only called after the bio being split.

- Checksum verification
  Currently we rely on btrfs_bio::csum to contain the checksum for the
  whole bio.
  If one bio get split, csum will no longer points to the correct
  location for the split bio.

  This can be solved by introducing btrfs_bio::offset_to_original, and
  use that new member to calculate where we should read csum from.

  For the parent bio, it still has btrfs_bio::csum for the whole bio,
  thus it can still free it correctly.

- Independent endio for each split bio
  Unlike stack drivers, for RAID10 btrfs needs to try its best effort to
  read every sectors, to handle the following case: (X means bad, either
  unable to read or failed to pass checksum verification, V means good)

  Dev 1	(missing) | D1 (X) |
  Dev 2 (OK)	  | D1 (V) |
  Dev 3 (OK)	  | D2 (V) |
  Dev 4 (OK)	  | D2 (X) |

  In the above RAID10 case, dev1 is missing, and although dev4 is fine,
  its D2 sector is corrupted (by bit rot or whatever).

  If we use bio_chain(), read bio for both D1 and D2 will be split, and
  since D1 is missing, the whole D1 and D2 read will be marked as error,
  thus we will try to read from dev2 and dev4.

  But D2 in dev4 has csum mismatch, we can only rebuild D1 and D2
  correctly from dev2:D1 and dev3:D2.

  This patchset resolve this by saving bi_iter into btrfs_bio::iter, and
  uses that at endio to iterate only the split part of an bio.
  Other than this, existing read/write page endio functions can handle
  them properly without problem.

- Bad RAID56 naming/functionality
  There are quite some RAID56 call sites relies on specific behavior on
  __btrfs_map_block(), like returning @map_length as stripe_len other
  than real mapped length.

  This is handled by some small cleanups specific for RAID56.

Qu Wenruo (18):
  btrfs: update an stale comment on btrfs_submit_bio_hook()
  btrfs: save bio::bi_iter into btrfs_bio::iter before any endio
  btrfs: use correct bio size for error message in btrfs_end_dio_bio()
  btrfs: refactor btrfs_map_bio()
  btrfs: move btrfs_bio_wq_end_io() calls into submit_stripe_bio()
  btrfs: replace btrfs_dio_private::refs with
    btrfs_dio_private::pending_bytes
  btrfs: introduce btrfs_bio_split() helper
  btrfs: make data buffered read path to handle split bio properly
  btrfs: make data buffered write endio function to be split bio
    compatible
  btrfs: make metadata write endio functions to be split bio compatible
  btrfs: make dec_and_test_compressed_bio() to be split bio compatible
  btrfs: return proper mapped length for RAID56 profiles in
    __btrfs_map_block()
  btrfs: allow btrfs_map_bio() to split bio according to chunk stripe
    boundaries
  btrfs: remove buffered IO stripe boundary calculation
  btrfs: remove stripe boundary calculation for compressed IO
  btrfs: remove the stripe boundary calculation for direct IO
  btrfs: remove the stripe boundary calcluation for encoded IO
  btrfs: unexport btrfs_get_io_geometry()

 fs/btrfs/btrfs_inode.h |  10 +-
 fs/btrfs/compression.c |  70 +++----------
 fs/btrfs/disk-io.c     |  11 +-
 fs/btrfs/extent_io.c   | 214 ++++++++++++++++++++++++++------------
 fs/btrfs/extent_io.h   |   2 +
 fs/btrfs/inode.c       | 230 +++++++++++++++--------------------------
 fs/btrfs/raid56.c      |  14 ++-
 fs/btrfs/raid56.h      |   2 +-
 fs/btrfs/scrub.c       |  14 +--
 fs/btrfs/volumes.c     | 144 +++++++++++++++++++-------
 fs/btrfs/volumes.h     |  74 +++++++++++--
 11 files changed, 452 insertions(+), 333 deletions(-)

-- 
2.35.1

