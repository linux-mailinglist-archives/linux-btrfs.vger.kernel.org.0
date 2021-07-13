Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE023C6A44
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Jul 2021 08:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbhGMGSL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Jul 2021 02:18:11 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:36316 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbhGMGSK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Jul 2021 02:18:10 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 60CC5221EF
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626156920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=G/0Q9YzmiPPsncK3AvzqZC/l11tQcqbe4gRCM1c6O64=;
        b=BXmPArR5rYmWNywbnUcDC7yAZScBfHwdGuLvbc279OBbdRcxIdl0VBKbrlWuoWBeJnYmKl
        LlttrDqAsRpEu/Vbza5VHVDhzbgAgIoAT03NxFXkOoWnEC8jNqwrvXlIemvBtF/kWDdgpD
        EJEZ1cvRA4tF6yaGgh5pnYXsmJis9qI=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 9DC68139AC
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id x/MDGHcv7WB0XgAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Jul 2021 06:15:19 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 00/27] btrfs: limited subpage compressed write support
Date:   Tue, 13 Jul 2021 14:14:49 +0800
Message-Id: <20210713061516.163318-1-wqu@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The patchset can be fetched from github:
https://github.com/adam900710/linux/tree/compression

The branch is based on the previously submitted subpage enablement
patchset.
The target merge window is v5.16 or v5.17.

=== What's working ===

Delalloc range which is fully page aligned can be compressed with
64K page size and 4K sector size (AKA, subpage).

With current patchset, it can pass most "compress" test group, except
btrfs/106, whose golden output is bound to 4K page size, thus test case
needs to be updated.

And as a basic requirement, 4K page size systems still pass the regular
fstests runs.

=== What's not working ===
Delalloc range not fully page aligned will not go through compression.

That's to say, the following inode will go through different write path:

	0	32K	64K	96K	128K
	|///////////////|	|///////|
			|		\- Will not be compressed
			|
			\- Will be compressed

This will reduce the chance of compression obviously.

But all involved patches will be the basis for later sector perfect
compression support.

The limitation is mostly introduced by two factors:

- How we handle the locked page of a async cow delalloc range
  Currently we unlock the first page unconditionally.
  Even with the patchset, we still follows the behavior.

  This means we can't have two async cow range shares the same
  page.
  This can be enhanced to use subpage::writers, but the next
  problem will prevent us doing so.

- No way to ensure an async cow range not to unlock the page while
  we still have delalloc range in the page

  This is caused by how we run delalloc range in a page.
  For regular sectorsize, it's not a problem as we have at most one
  sector for a page.

  But for subpage case, we can have multiple sectors in one page.
  If we submit an async cow, it may try to unlock the page while
  we are still running the next delalloc range of the page.

  The correct way here is to find and lock all delalloc range inside a
  page, update the subpage::writers properly, then run each delalloc
  range, so that the page won't be unlocked half way.

=== Patch structure ===

Patch 01~04:	Small and safe cleanups
Patch 05:	Make compressed readahead to be subpage compatble
Patch 06~14:	Optimize compressed read/write path to determine stripe
		boundary in a per-bio base
Patch 15~16:	Extra code refactor/cleanup for compressed path

Patch 17~26:	Make compressed write path to be subpage compatible
Patch 27:	Enable limited subpage compressed write support

Patch 01~16 may be a good candidate for early merge, as real heavy
lifting part starts at patch 17.

While patch 01~04 are really small and safe cleanups, which can be
merged even earlier than subpage enablement patchset.


Qu Wenruo (27):
  btrfs: remove unused parameter @nr_pages in add_ra_bio_pages()
  btrfs: remove unnecessary parameter @delalloc_start for
    writepage_delalloc()
  btrfs: use async_chunk::async_cow to replace the confusing pending
    pointer
  btrfs: don't pass compressed pages to
    btrfs_writepage_endio_finish_ordered()
  btrfs: make add_ra_bio_pages() to be subpage compatible
  btrfs: introduce compressed_bio::pending_sectors to trace compressed
    bio more elegantly
  btrfs: add subpage checked_bitmap to make PageChecked flag to be
    subpage compatible
  btrfs: handle errors properly inside btrfs_submit_compressed_read()
  btrfs: handle errors properly inside btrfs_submit_compressed_write()
  btrfs: introduce submit_compressed_bio() for compression
  btrfs: introduce alloc_compressed_bio() for compression
  btrfs: make btrfs_submit_compressed_read() to determine stripe
    boundary at bio allocation time
  btrfs: make btrfs_submit_compressed_write() to determine stripe
    boundary at bio allocation time
  btrfs: remove unused function btrfs_bio_fits_in_stripe()
  btrfs: refactor submit_compressed_extents()
  btrfs: cleanup for extent_write_locked_range()
  btrfs: make compress_file_range() to be subpage compatible
  btrfs: make btrfs_submit_compressed_write() to be subpage compatible
  btrfs: make end_compressed_bio_writeback() to be subpage compatble
  btrfs: make extent_write_locked_range() to be subpage compatible
  btrfs: extract uncompressed async extent submission code into a new
    helper
  btrfs: rework lzo_compress_pages() to make it subpage compatible
  btrfs: teach __extent_writepage() to handle locked page differently
  btrfs: allow page to be unlocked by btrfs_page_end_writer_lock() even
    if it's locked by plain page_lock()
  btrfs: allow subpage to compress a range which only covers one page
  btrfs: don't run delalloc range which is beyond the locked_page to
    prevent deadlock for subpage compression
  btrfs: only allow subpage compression if the range is fully page
    aligned

 fs/btrfs/compression.c           | 678 ++++++++++++++++++-------------
 fs/btrfs/compression.h           |   4 +-
 fs/btrfs/ctree.h                 |   2 -
 fs/btrfs/extent_io.c             | 123 ++++--
 fs/btrfs/extent_io.h             |   3 +-
 fs/btrfs/file.c                  |  20 +-
 fs/btrfs/free-space-cache.c      |   6 +-
 fs/btrfs/inode.c                 | 455 +++++++++++----------
 fs/btrfs/lzo.c                   | 280 ++++++-------
 fs/btrfs/reflink.c               |   2 +-
 fs/btrfs/subpage.c               |  85 ++++
 fs/btrfs/subpage.h               |  10 +
 fs/btrfs/tests/extent-io-tests.c |  12 +-
 13 files changed, 996 insertions(+), 684 deletions(-)

-- 
2.32.0

