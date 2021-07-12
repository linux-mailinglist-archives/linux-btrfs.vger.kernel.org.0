Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 571173C57AF
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Jul 2021 12:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244817AbhGLIgg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Jul 2021 04:36:36 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49252 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357809AbhGLIdV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Jul 2021 04:33:21 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A86191FF5A
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jul 2021 08:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626078631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=JxgJAQ4z08xqL6LaBWWXQxKOTexxOdgIa2MWjnd5830=;
        b=tGnkm7P0DSkLqpmqBxd3MLK7YaAJi2iKUhbNDFA/uI2om4MK5UXGpdVS66eNF625hgF5E8
        QxBDcAFoyoZtNIi0vgKkryQBwunO/zQyIi+sUXnH3EBNAbc6jiylUXi1/jGR01W2Di/+1U
        LCKWxwgqNs5MpeRIpq5NlBD2xq/oYtU=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D562B13455
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jul 2021 08:30:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id Q7BBJKb962ByEAAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Jul 2021 08:30:30 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v7 00/17] btrfs: add data write support for subpage
Date:   Mon, 12 Jul 2021 16:30:10 +0800
Message-Id: <20210712083027.212734-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This much smaller patchset can be fetched from github:
https://github.com/adam900710/linux/tree/subpage

And thanks him again for fixing up the small typos and style problem in
my old patches. Almost no patch is no untouched, really appreciate the
effort.

These patchset is targeted at v5.15 merge window.
There are 11 subpage enablment patches pending for a while, and not
touched, thus they should be pretty stable and safe.

While there are 6 new patches, 4 of them are straightforward small
fixes, the remaining 2 are a little scary as they reworked the core code
of compression.

But the rework should improve the readabilty thus make reviewing a
little easier (as least I hope so).

This should be the last time I send all subpage enablement patches with
compression read patch fixes.

Newer subpage compression read path fixes will then be sent as
individual fixes.

=== Current stage ===
The tests on x86 pass without new failure, and generic test group on
arm64 with 64K page size passes except known failure and defrag group.

For btrfs test group, all pass except compression/raid56/defrag.

For anyone who is interested in testing, please use btrfs-progs v5.12 to
avoid false alert at mkfs time.

=== Limitation ===
There are several limitations introduced just for subpage:
- No compressed write support
  Read is no problem, but compression write path has more things left to
  be modified.

  WIP, currently working on fixing all problems exposed by fsstress with
  compress mount option.
  Currently the remaining bugs are all in write path, hopes not to hit
  read path related bugs.

- No inline extent will be created
  This is mostly due to the fact that filemap_fdatawrite_range() will
  trigger more write than the range specified.
  In fallocate calls, this behavior can make us to writeback which can
  be inlined, before we enlarge the isize, causing inline extent being
  created along with regular extents.

  In fact, even on x86_64, we can still have fsstress to create inodes
  with mixed inline and regular extents.
  Thus there is a much bigger problem to address.

- No support for RAID56
  There are still too many hardcoded PAGE_SIZE in raid56 code.
  Considering it's already considered unsafe due to its write-hole
  problem, disabling RAID56 for subpage looks sane to me.

- No defrag support for subpage
  The support for subpage defrag has already an initial version
  submitted to the mail list.
  Thus the correct support won't be included in this patchset.

  Currently I'm not pushing defrag patchset, as it's really not
  the priority, and still has rare bugs related to EXTENT_DELALLOC_NEW
  extent bit.

=== Patchset structure ===
Patch 01~06:	Subpage fixes for compression read path
Patch 07~07:	Support for subpage relocation
Patch 09~16:	Subpage specific fixes and extra limitations
Patch 17:	Enable subpage support

=== Changelog ===
v2:
- Rebased to latest misc-next
  Now metadata write patches are removed from the series, as they are
  already merged into misc-next.

- Added new Reviewed-by/Tested-by/Reported-by tags

- Use separate endio functions to subpage metadata write path

- Re-order the patches, to make refactors at the top of the series
  One refactor, the submit_extent_page() one, should benefit 4K page
  size more than 64K page size, thus it's worthy to be merged early

- New bug fixes exposed by Ritesh Harjani on Power

- Reject RAID56 completely
  Exposed by btrfs test group, which caused BUG_ON() for various sites.
  Considering RAID56 is already not considered safe, it's better to
  reject them completely for now.

- Fix subpage scrub repair failure
  Caused by hardcoded PAGE_SIZE

- Fix free space cache inode size
  Same cause as scrub repair failure

v3:
- Rebased to remove write path prepration patches

- Properly enable btrfs defrag
  Previsouly, btrfs defrag is in fact just disabled.
  This makes tons of tests in btrfs/defrag to fail.

- More bug fixes for rare race/crashes
  * Fix relocation false alert on csum mismatch
  * Fix relocation data corruption
  * Fix a rare case of false ASSERT()
    The fix already get merged into the prepration patches, thus no
    longer in this patchset though.
  
  Mostly reported by Ritesh from IBM.

v4:
- Disable subpage defrag completely
  As full page defrag can race with fsstress in btrfs/062, causing
  strange ordered extent bugs.
  The full subpage defrag will be submitted as an indepdent patchset.

v5:
- Rebased to latest misc-next branch

v6:
- Rebased to latest misc-next branch
  The 11 existing patches have no conflicts at all.

- Added four patches related to compression read path
  This involves:
  * One small fix for extent map grabbing
  * One preparation to remove GFP_HIGHMEM
    kmap()/kunmap() is not removed yet, as it's only for later
    subpage related decompression path rework.
  * Rework btrfs_decompress_buf2page() and lzo_decompress_bio()
    btrfs_decompress_buf2page() handles the copying of decompressed data
    to inode pages, without proper subpage handling, we can copy
    decompressed data to wrong location
    lzo_decompress_bio() needs a sectorsize related fix to handle
    padding zeros.
    Since we're here, I just reworked the code to make more rooms for
    proper comments.

    These two rework looks scary, and touches the core functions of
    compression, thus Josef gave me extra tests runs on them and no
    regression found.

    But still they definitely deserve more review.

v7:
- Rebased to latest misc-next branch
  With HIGHMEM cleanup already in misc-next, one patch can be dropped.

  With extra Reviewed-by: tags and fixes.

- Added 3 more fixes for subpage compression read path:
  * Sticky @this_bio_flag
    Preivoulys in btrfs_do_readpage() @this_bio_flag is only used once
    as one page only contains one sector.
    But for subpage case, we need to reset this flag, or after reading
    one compressed extent, next uncompressed extent will be treated as
    compressed and causing problems.

  * NULL pointer fix for csum verification for compressed extent
    For compressed extent, we rely on PageChecked to skip csum
    verification for compressed read.
    But that flag only works for full page, no subpage helper yet.
    Thankfully we can easily skip compressed read as it never populate
    io_bio::csum.

  * Disable readahead for compressed read
    It will be properly enabled in write path, since for 64K page size,
    we at most readahead two pages, the readahead is way less effective,
    and we can afford to skip the readahead completely for subpage case.

Qu Wenruo (17):
  btrfs: properly reset @this_bio_flag in btrfs_do_readpage() to avoid
    inheriting old bio flags to next extent
  btrfs: fix NULL pointer dereference when reading two compressed extent
    inside the same page
  btrfs: disable compressed readahead for subpage
  btrfs: grab correct extent map for subpage compressed extent read
  btrfs: rework btrfs_decompress_buf2page()
  btrfs: rework lzo_decompress_bio() to make it subpage compatible
  btrfs: extract relocation page read and dirty part into its own
    function
  btrfs: make relocate_one_page() to handle subpage case
  btrfs: fix wild subpage writeback which does not have ordered extent.
  btrfs: disable inline extent creation for subpage
  btrfs: allow submit_extent_page() to do bio split for subpage
  btrfs: reject raid5/6 fs for subpage
  btrfs: fix a crash caused by race between prepare_pages() and
    btrfs_releasepage()
  btrfs: fix a use-after-free bug in writeback subpage helper
  btrfs: fix a subpage false alert for relocating partial preallocated
    data extents
  btrfs: fix a subpage relocation data corruption
  btrfs: allow read-write for 4K sectorsize on 64K page size systems

 fs/btrfs/compression.c | 160 +++++++++++----------
 fs/btrfs/compression.h |   5 +-
 fs/btrfs/disk-io.c     |  13 +-
 fs/btrfs/extent_io.c   | 211 ++++++++++++++++++++--------
 fs/btrfs/file.c        |  13 +-
 fs/btrfs/inode.c       |  92 ++++++++++--
 fs/btrfs/ioctl.c       |   6 +
 fs/btrfs/lzo.c         | 196 ++++++++++++--------------
 fs/btrfs/relocation.c  | 308 +++++++++++++++++++++++++++--------------
 fs/btrfs/subpage.c     |  20 ++-
 fs/btrfs/subpage.h     |   7 +
 fs/btrfs/super.c       |   7 -
 fs/btrfs/sysfs.c       |   5 +
 fs/btrfs/volumes.c     |   7 +
 fs/btrfs/zlib.c        |  12 +-
 fs/btrfs/zstd.c        |   6 +-
 16 files changed, 676 insertions(+), 392 deletions(-)

-- 
2.32.0

