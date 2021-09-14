Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D97F40A275
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 03:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbhINB1F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 21:27:05 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:36296 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbhINB1E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 21:27:04 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 37097200B9
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Sep 2021 01:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631582747; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=2kJr/I1iAZhXTWzAG1s+TQqUqDmwUlsmFxR+by4tZOc=;
        b=sCGHdP8ETd8Z6d4TFtYaE57hcTuR+0FUWLqOOx539jGcx4n+tYvBFMf/18GQ4POweLldQT
        ovhsPSLE/OIqBidT3K7FnGK2mBdrlEnsTp4LJ2W4/8gFyx+0ocWmCEcITnSVDGbNFy/RO7
        9kNLXMLuzuelK/E3wXf6sWHjyPfVIak=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4BE3E139E0
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Sep 2021 01:25:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yM2MAhr6P2HafQAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Sep 2021 01:25:46 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 0/3] btrfs: btrfs_bio and btrfs_io_bio rename
Date:   Tue, 14 Sep 2021 09:25:40 +0800
Message-Id: <20210914012543.12746-1-wqu@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The branch can be fetched from github, and is the preferred way to grab
the code, as this patchset changed quite a lot of code.
https://github.com/adam900710/linux/tree/chunk_refactor

There are two structure, btrfs_io_bio and btrfs_bio, which have very
similar names but completely different meanings.

Btrfs_io_bio mostly works at logical bytenr layer (its
bio->bi_iter.bi_sector points to btrfs logical bytenr), and just
contains extra info like csum and mirror_num.

And btrfs_io_bio is in fact the most utilized bio, as all data/metadata
IO is using btrfs_io_bio.

While btrfs_bio is completely a helper structure for stripe IO
submission (RAID56 doesn't utilize it for IO submission).

Such naming is completely anti-human.

So this patchset will do the following renaming:

- btrfs_bio -> btrfs_io_context
  Since it's not really used by all bios (only mirrored profiles utilize
  it), and it contains extra info for RAID56, it's not proper to name it
  with _bio suffix.

  Later we can integrate btrfs_io_context pointer into the new
  btrfs_bio.

- btrfs_io_bio -> btrfs_bio
  I originally plan to rename it to btrfs_logical_bio, but it's a little
  too long for a lot of functions.

Changelog:
v2:
- Rename btrfs_bio to btrfs_io_context (bioc)
- Rename btrfs_io_bio to btrfs_bio
  Both suggested by Nikolay


Qu Wenruo (3):
  btrfs: rename btrfs_bio to btrfs_io_context
  btrfs: remove btrfs_bio_alloc() helper
  btrfs: rename struct btrfs_io_bio to btrfs_bio

 fs/btrfs/check-integrity.c |   4 +-
 fs/btrfs/compression.c     |  20 +--
 fs/btrfs/ctree.h           |   3 +-
 fs/btrfs/disk-io.c         |   2 +-
 fs/btrfs/disk-io.h         |   2 +-
 fs/btrfs/extent-tree.c     |  18 +--
 fs/btrfs/extent_io.c       | 108 ++++++++-------
 fs/btrfs/extent_io.h       |   3 +-
 fs/btrfs/extent_map.c      |   4 +-
 fs/btrfs/file-item.c       |  12 +-
 fs/btrfs/inode.c           |  42 +++---
 fs/btrfs/raid56.c          | 130 +++++++++----------
 fs/btrfs/raid56.h          |   8 +-
 fs/btrfs/reada.c           |  26 ++--
 fs/btrfs/scrub.c           | 130 +++++++++----------
 fs/btrfs/volumes.c         | 260 ++++++++++++++++++-------------------
 fs/btrfs/volumes.h         |  48 +++----
 fs/btrfs/zoned.c           |  16 +--
 18 files changed, 416 insertions(+), 420 deletions(-)

-- 
2.33.0

