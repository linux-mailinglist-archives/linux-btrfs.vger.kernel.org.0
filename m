Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3320B40C04E
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Sep 2021 09:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236486AbhIOHSl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Sep 2021 03:18:41 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53834 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbhIOHSl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Sep 2021 03:18:41 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BFF202219D
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Sep 2021 07:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631690241; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=GWGeUjGH1IzKXKjMROy4M/o5nmh+fhrmnc4+lxrxW2w=;
        b=H/QCPoogNiGSXvQpyxDOQBr2olpIfEzFMH0AjDcFrk1y3MCrzlF5FyUY3Xey6Zj7psAErK
        8uTc160Wbu4rC2gu1+ynqN0JKqPNy+T9FB8xbGuXSEz2PXNmwFrVY3zc5E7HBL2so4fZ8B
        Q4ktfAsEna9Ymkk51Uz8APnuzRFV7m4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED38913C1A
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Sep 2021 07:17:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gcMaKwCeQWGxEAAAMHmgww
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Sep 2021 07:17:20 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v3 0/3]  btrfs: btrfs_bio and btrfs_io_bio rename
Date:   Wed, 15 Sep 2021 15:17:15 +0800
Message-Id: <20210915071718.59418-1-wqu@suse.com>
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

While btrfs_bio is completely a helper structure for mirrored IO
submission (utilized by SINGLE/DUP/RAID1/RAID10), and contains RAID56
maps for RAID56 (it doesn't utilize this structure for IO submission
tracking).

Such naming is completely anti-human.

So this patchset will do the following renaming:

- btrfs_bio -> btrfs_io_context
  Since it's not really used by all bios (only mirrored profiles utilize
  it), and it contains extra info for RAID56, it's not proper to name it
  with _bio suffix.

  Later we can integrate btrfs_io_context pointer into the new
  btrfs_bio.

- btrfs_io_bio -> btrfs_logical_bio
  It is intentional not to reuse "btrfs_bio", which could cause
  confusion for later backport.

Changelog:
v2:
- Rename btrfs_bio to btrfs_io_context (bioc)
- Rename btrfs_io_bio to btrfs_bio
  Both suggested by Nikolay

v3:
- Fixes whiespace problems
  Caused by "dwi" vim commands

- Update several modified comments

- Rename btrfs_io_bio to btrfs_logical_bio
  To avoid backport confusion.


Qu Wenruo (3):
  btrfs: rename btrfs_bio to btrfs_io_context
  btrfs: remove btrfs_bio_alloc() helper
  btrfs: rename struct btrfs_io_bio to btrfs_logical_bio

 fs/btrfs/check-integrity.c |   4 +-
 fs/btrfs/compression.c     |  20 +--
 fs/btrfs/ctree.h           |   6 +-
 fs/btrfs/disk-io.c         |   2 +-
 fs/btrfs/disk-io.h         |   2 +-
 fs/btrfs/extent-tree.c     |  19 ++-
 fs/btrfs/extent_io.c       | 116 ++++++++--------
 fs/btrfs/extent_io.h       |   8 +-
 fs/btrfs/extent_map.c      |   4 +-
 fs/btrfs/file-item.c       |  12 +-
 fs/btrfs/inode.c           |  50 +++----
 fs/btrfs/raid56.c          | 135 +++++++++---------
 fs/btrfs/raid56.h          |   8 +-
 fs/btrfs/reada.c           |  26 ++--
 fs/btrfs/scrub.c           | 130 +++++++++---------
 fs/btrfs/volumes.c         | 272 ++++++++++++++++++-------------------
 fs/btrfs/volumes.h         |  63 +++++----
 fs/btrfs/zoned.c           |  16 +--
 18 files changed, 455 insertions(+), 438 deletions(-)

-- 
2.33.0

