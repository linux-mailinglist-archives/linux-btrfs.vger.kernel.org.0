Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAF54FDCAF
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Apr 2022 13:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349586AbiDLKh4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 Apr 2022 06:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354227AbiDLKdi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 Apr 2022 06:33:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8BE5B3DA
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 02:33:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 359CA1F858
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649756006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=2udZ2HmHsgwTcPOIQQ4S5st8odxT+4H0H5RBNuzGIx8=;
        b=Hnna1t8h+psu/aLgPN8iabs9nsjSeRcMDp0R4olsP/mF94PWi585bUZ452L2rXp7wl2LhQ
        sDjXLRFev1Kjs43esWxdwqDDhUBhlt6Oo7kwR9SsDY2YZBPem5sck8WXLmF22xbRvkvKiH
        gz1b5SIvgT9HhbNszHDgmwIUHYUauhk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F54C13A99
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SNeqEWVHVWI8LwAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 12 Apr 2022 09:33:25 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 00/17] btrfs: add subpage support for RAID56
Date:   Tue, 12 Apr 2022 17:32:50 +0800
Message-Id: <cover.1649753690.git.wqu@suse.com>
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

The branch can be fetched from github, based on latest misc-next branch
(with bio and memory allocation refactors):
https://github.com/adam900710/linux/tree/subpage_raid56

[CHANGELOG]
v2:
- Rebased to latest misc-next
  There are several conflicts caused by bio interface change and page
  allocation update.

- A new patch to reduce the width of @stripe_len to u32
  Currently @stripe_len is fixed to 64K, and even in the future we
  choose to enlarge the value, I see no reason to go beyond 4G for
  stripe length.

  Thus change it u32 to avoid some u64-divided-by-u32 situations.

  This will reduce memory usage for map_lookup (which has a lifespan as
  long as the mounted fs) and btrfs_io_geometry (which only has a very
  short lifespan, mostly bounded to bio).

  Furthermore, add some extra alignment check and use right bit shift
  to replace involved division to avoid possible problems on 32bit
  systems.

- Pack sector_ptr::pgoff and sector_ptr::uptodate into one u32
  This will reduce memory usage and reduce unaligned memory access

  Please note that, even with it packed, we still have a 4 bytes padding
  (it's u64 + u32, thus not perfectly aligned).
  Without packed attribute, it will cost more memory usage anyway.

- Call kunmap_local() using address with pgoff
  As it can handle it without problem, no need to bother extra search
  just for pgoff.

- Use "= { 0 }" for structure initialization

- Reduce comment updates to minimal
  If one comment line is not really touched, then don't touch it just to
  fix some bad styles.

[DESIGN]
To make RAID56 code to support subpage, we need to make every sector of
a RAID56 full stripe (including P/Q) to be addressable.

Previously we use page pointer directly for things like stripe_pages:

Full stripe is 64K * 3, 2 data stripes, one P stripe (RAID5)

stripe_pages:   | 0 | 1 | 2 |  .. | 46 | 47 |

Those 48 pages all points to a page we allocated.


The new subpage support will introduce a sector layer, based on the old
stripe_pages[] array:

The same 64K * 3, RAID5 layout, but 64K page size and 4K sector size:

stripe_sectors: | 0 | 1 | .. |15 |16 |  ...  |31 |32 | ..    |47 |
stripe_pages:   |      Page 0    |     Page 1    |    Page 2     |

Each stripe_ptr of stripe_sectors[] will include:

- One page pointer
  Points back the page inside stripe_pages[].

- One pgoff member
  To indicate the offset inside the page

- One uptodate member
  To indicate if the sector is uptodate, replacing the old PageUptodate
  flag.
  As introducing btrfs_subpage structure to stripe_pages[] looks a
  little overkilled, as we only care Uptodate flag.

The same applies to bio_sectors[] array, which is going to completely
replace the old bio_pages[] array.

[SIDE EFFECT]
Despite the obvious new ability for subpage to utilize btrfs RAID56
profiles, it will cause more memory usage for real btrfs_raid_bio
structure.

We allocate extra memory based on the stripe size and number of stripes,
and update the pointer arrays to utilize the extra memory.

To compare, we use a pretty standard setup, 3 disks raid5, 4K page size
on x86_64:

 Before: 1176
 After:  2320 (+97.8%)

The reason for such a big bump is:

- Extra size for sector_ptr.
  Instead of just a page pointer, now it's twice the size of a pointer
  (a page pointer + 2 * unsigned int)

  This means although we replace bio_pages[] with bio_sectors[], we are
  still enlarging the size.

- A completely new array for stripe_sectors[]
  And the array itself is also twice the size of the old stripe_pages[].

- Extra padding for sector_ptr
  Since we don't have packed attribute anymore, the real size of
  a sector_ptr is 16 bytes, not 12 bytes.

There is some attempt to reduce the size of btrfs_raid_bio itself, but
the big impact still comes from the new sector_ptr arrays.

Without exotic macros or packed attribute, I don't have any better ideas
on reducing the real size of btrfs_raid_bio.

[TESTS]
Now due to recent new error path exposed in generic/475, only btrfs
groups are tested. Or it will always hang at generic/475 due to
unrelated bugs.

Both x86_64 and aarch64 (64K page size) pass the full btrfs test cases
without new regression.

[PATCHSET LAYOUT]
The patchset layout puts several things into consideration:

- Every patch can be tested independently on x86_64
  No more tons of unused helpers then a big switch.
  Every change can be verified on x86_64.

- More temporary sanity checks than previous code
  For example, when rbio_add_io_page() is converted to be subpage
  compatible, extra ASSERT() is added to ensure no subpage range
  can even be added.

  Such temporary checks are removed in the last enablement patch.
  This is to make testing on x86_64 more comprehensive.

- Mostly small change in each patch
  The only exception is the conversion for rbio_add_io_page().
  But the most change in that patch comes from variable renaming.
  The overall line changed in each patch should still be small enough
  for review.

Qu Wenruo (17):
  btrfs: reduce width for stripe_len from u64 to u32
  btrfs: open-code rbio_nr_pages()
  btrfs: make btrfs_raid_bio more compact
  btrfs: introduce new cached members for btrfs_raid_bio
  btrfs: introduce btrfs_raid_bio::stripe_sectors
  btrfs: introduce btrfs_raid_bio::bio_sectors
  btrfs: make rbio_add_io_page() subpage compatible
  btrfs: make finish_parity_scrub() subpage compatible
  btrfs: make __raid_recover_endio_io() subpage compatibable
  btrfs: make finish_rmw() subpage compatible
  btrfs: open-code rbio_stripe_page_index()
  btrfs: make raid56_add_scrub_pages() subpage compatible
  btrfs: remove btrfs_raid_bio::bio_pages array
  btrfs: make set_bio_pages_uptodate() subpage compatible
  btrfs: make steal_rbio() subpage compatible
  btrfs: make alloc_rbio_essential_pages() subpage compatible
  btrfs: enable subpage support for RAID56

 fs/btrfs/disk-io.c |   8 -
 fs/btrfs/raid56.c  | 749 +++++++++++++++++++++++++++------------------
 fs/btrfs/raid56.h  |   8 +-
 fs/btrfs/scrub.c   |   6 +-
 fs/btrfs/volumes.c |  27 +-
 fs/btrfs/volumes.h |   8 +-
 6 files changed, 479 insertions(+), 327 deletions(-)

-- 
2.35.1

