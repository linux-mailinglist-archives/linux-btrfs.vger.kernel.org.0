Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928063A58BB
	for <lists+linux-btrfs@lfdr.de>; Sun, 13 Jun 2021 15:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhFMNmP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 13 Jun 2021 09:42:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:55380 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbhFMNmN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 13 Jun 2021 09:42:13 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E88D81FD32;
        Sun, 13 Jun 2021 13:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3af5kMw7B67kqD1PWVbxZh/Jo3GD1EbCYn0NnRFsQyg=;
        b=a2/20eULzyC4PxvEwQID5sWxlrfMiTCVDRxhS7igTxAtd0WcB6wXNz5TGW9Wd3dJYufkRD
        J+8t5cy7tIQZskDK+0WTO4I1WqD0+0QzQgSBm7Vs8kmqsJnl5X9eg+OrXdIUp5s3nwY4l9
        BM8cqITG89CGRts1ltNmvh6EntBn6xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591610;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3af5kMw7B67kqD1PWVbxZh/Jo3GD1EbCYn0NnRFsQyg=;
        b=AKFt4B7Wn3EDMn4osrN2U5uDj2YC1oGseQd51E95L+5UMQjmnw0z4sNxUEwiSNV075lu0N
        5zXEWBb1bXawmbBQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 94776118DD;
        Sun, 13 Jun 2021 13:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623591610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3af5kMw7B67kqD1PWVbxZh/Jo3GD1EbCYn0NnRFsQyg=;
        b=a2/20eULzyC4PxvEwQID5sWxlrfMiTCVDRxhS7igTxAtd0WcB6wXNz5TGW9Wd3dJYufkRD
        J+8t5cy7tIQZskDK+0WTO4I1WqD0+0QzQgSBm7Vs8kmqsJnl5X9eg+OrXdIUp5s3nwY4l9
        BM8cqITG89CGRts1ltNmvh6EntBn6xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623591610;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=3af5kMw7B67kqD1PWVbxZh/Jo3GD1EbCYn0NnRFsQyg=;
        b=AKFt4B7Wn3EDMn4osrN2U5uDj2YC1oGseQd51E95L+5UMQjmnw0z4sNxUEwiSNV075lu0N
        5zXEWBb1bXawmbBQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id SliiG7oKxmAoJAAALh3uQQ
        (envelope-from <rgoldwyn@suse.de>); Sun, 13 Jun 2021 13:40:10 +0000
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [RFC PATCH 00/31] btrfs buffered iomap support
Date:   Sun, 13 Jun 2021 08:39:28 -0500
Message-Id: <cover.1623567940.git.rgoldwyn@suse.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

This is an attempt to perform the bufered read and write using iomap on btrfs.
I propose these changes as an RFC because I would like to know on your comments on the feasibility of going ahead with the design. It is not feature complete
with the most important support missing is multi-device and compression.
Sending to BTRFS mailing only for perspective from btrfs developers first.

Locking sequence change
One of the biggest architecture changes is locking extents before pages.
writepage(), called during memory pressure provides the page which is locked
already. Perform a best effort locking and work with what is feasible.
For truncate->invalidatepage(), lock the pages before calling setsize().
Are there any other areas which need to be covered?

TODO
====

Bio submission for multi-device
  Multi-device submission would require some work with respect to asynchronous
  completions. iomap can merge bio's making it larger than extent_map's
  map_length. There is a check in btrfs_map_bio which WARN()s on this.
  Perhaps a more modular approach of having callbacks would be easier to
  deal with.

Compression
  This would require extra flags to iomap, say type IOMAP_ENCODED, which would
  require iomap to read/write complete extents as opposed to performing I/O on
  only what is requested. An additional field io_size would be required to
  know how much of compressed size maps to uncompressed size.


Known issues
============
 BIO Submission: described above
 Random WARN_ON in kernel/locking/lockdep.c:895 points to memory corruption.

Finally, I have added some questions in the patch headers as well.


-- 
Goldwyn


Goldwyn Rodrigues (31):
  iomap: Check if blocksize == PAGE_SIZE in to_iomap_page()
  iomap: Add submit_io to writepage_ops
  iomap: Export iomap_writepage_end_bio()
  iomap: Introduce iomap_readpage_ops
  btrfs: writepage() lock extent before pages
  btrfs: lock extents while truncating
  btrfs: write() perform extent locks before locking page
  btrfs: btrfs_em_to_iomap () to convert em to iomap
  btrfs: Don't process pages if locked_page is NULL
  btrfs: Add btrfs_map_blocks to for iomap_writeback_ops
  btrfs: Use submit_io to submit btrfs writeback bios
  btrfs: endio sequence for writepage
  btrfs: do not checksum for free space inode
  btrfs: end EXTENT_MAP_INLINE writeback early
  btrfs: Switch to iomap_writepages()
  btrfs: remove force_page_uptodate
  btrfs: Introduce btrfs_iomap
  btrfs: Add btrfs_iomap_release()
  btrfs: Add reservation information to btrfs_iomap
  btrfs: Carve out btrfs_buffered_iomap_begin() from write path
  btrfs: Carve out btrfs_buffered_iomap_end from the write path
  btrfs: Set extents delalloc in iomap_end
  btrfs: define iomap_page_ops
  btrfs: Switch to iomap_file_buffered_write()
  btrfs: remove all page related functions
  btrfs: use srcmap for read-before-write cases
  btrfs: Rename end_bio_extent_readpage to btrfs_readpage_endio
  btrfs: iomap_begin() for buffered read
  btrfs: Use iomap_readpage_ops to allocate and submit bio
  btrfs: Do not call btrfs_io_bio_free_csum() if BTRFS_INODE_NODATASUM
    is not set
  btrfs: Switch to iomap_readpage() and iomap_readahead()

 fs/btrfs/ctree.h       |   3 +
 fs/btrfs/disk-io.c     |   9 +-
 fs/btrfs/extent_io.c   | 103 +++++--
 fs/btrfs/extent_io.h   |   4 +
 fs/btrfs/file.c        | 642 ++++++++++++++---------------------------
 fs/btrfs/inode.c       | 219 ++++++++++++--
 fs/gfs2/aops.c         |   4 +-
 fs/iomap/buffered-io.c |  80 +++--
 fs/xfs/xfs_aops.c      |   4 +-
 fs/zonefs/super.c      |   4 +-
 include/linux/iomap.h  |  26 +-
 11 files changed, 601 insertions(+), 497 deletions(-)

-- 
2.31.1

