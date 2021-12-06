Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4CCC468F1E
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Dec 2021 03:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhLFCd1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 5 Dec 2021 21:33:27 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54746 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbhLFCd1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 5 Dec 2021 21:33:27 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 45B352113A
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 02:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638757798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Cae/LTZYnU2x6nhlgjLSURv5cXtOizH/ideTxulYBTE=;
        b=lCAdjGLwGFIqKWTQeE/UIaF3znQTvBp7pt5ZMMstmygPcUxEXRvVXt9IzKk/9sr1q2gkE2
        1PIuR349GhI8dv3Ff08a/A/VtWqPj68w2hBXZWdMYtboieRcVbD6zowUshhvHnW2jeYBL3
        UzC1PpVIHHrscqJUeR8D5aPk2/rsUAw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8D68D13451
        for <linux-btrfs@vger.kernel.org>; Mon,  6 Dec 2021 02:29:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /GeYNKR1rWFEMgAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 06 Dec 2021 02:29:56 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 00/17] btrfs: split bio at btrfs_map_bio() time
Date:   Mon,  6 Dec 2021 10:29:20 +0800
Message-Id: <20211206022937.26465-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset be fetched from this branch:

https://github.com/adam900710/linux/tree/refactor_chunk_map

[BACKGROUND]

Currently btrfs never uses bio_split() to split its bio against RAID
stripe boundaries.

Instead inside btrfs we check our stripe boundary everytime we allocate
a new bio, and ensure the new bio never cross stripe boundaries.

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

Qu Wenruo (17):
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
  btrfs: unexport btrfs_get_io_geometry()

 fs/btrfs/btrfs_inode.h |  10 +-
 fs/btrfs/compression.c |  70 +++-----------
 fs/btrfs/disk-io.c     |  11 +--
 fs/btrfs/extent_io.c   | 196 ++++++++++++++++++++++++++------------
 fs/btrfs/extent_io.h   |   2 +
 fs/btrfs/inode.c       | 210 ++++++++++++++++-------------------------
 fs/btrfs/raid56.c      |  14 ++-
 fs/btrfs/raid56.h      |   2 +-
 fs/btrfs/scrub.c       |  14 +--
 fs/btrfs/volumes.c     | 144 ++++++++++++++++++++--------
 fs/btrfs/volumes.h     |  74 +++++++++++++--
 11 files changed, 436 insertions(+), 311 deletions(-)

-- 
2.34.1

