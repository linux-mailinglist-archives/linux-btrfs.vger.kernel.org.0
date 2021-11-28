Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 212834604C2
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Nov 2021 06:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbhK1F6f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Nov 2021 00:58:35 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35600 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbhK1F4f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Nov 2021 00:56:35 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CC2B1212FE;
        Sun, 28 Nov 2021 05:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638078798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=R5VqbzqFLYhWPzWWAG74/Iyhe9WC86tkvhs07IhqDPA=;
        b=ag/ZTDWAApyaSCJX+ttf8l9j+GLkAAX870dPBfVn5LDwC5ZNgMhhRPeCEc1RQ1YcDBarPy
        5uOafDPTLOtI7hRLFCrtREt439GrCwX8qtdbmILbWfKAaW2v55+l2PzYtRojj7c3RNKSo/
        cSLGSti/DzBV/SjP2+PyjrvA/DAlPxQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5BCCD13446;
        Sun, 28 Nov 2021 05:53:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id puH8Ck0Zo2G7fAAAMHmgww
        (envelope-from <wqu@suse.com>); Sun, 28 Nov 2021 05:53:17 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com
Subject: [PATCH RFC 00/11] btrfs: split bio at btrfs_map_bio() time
Date:   Sun, 28 Nov 2021 13:52:48 +0800
Message-Id: <20211128055259.39249-1-wqu@suse.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

[BACKGROUND]

Currently btrfs never uses bio_split() to split its bio against RAID
stripe boundaries.

Instead inside btrfs we check our stripe boundary everytime we allocate
a new bio, and ensure the new bio never cross stripe boundaries.

[PROBLEMS]

Although this works fine, it's against the common practice used in
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
  There is a special endio function, end_workqueue_bio(), that if a bio
  has this endio function, and get split, we will double free the
  btrfs_end_io_wq_cache.

  And some hidden RAID56 endio also has this problem.

  For RAID56 problems, it's remaining to be solved in the v1 version.
  But for end_workqueue_bio() it can be moved after bios been split.

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
  read every sectors, to handle the following case:

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

[RFC]
The patchset is only lightly tested, as there is still some endio
conflicts in the ancient RAID56 code.

But despite that, regular buffered read/write and repair should work
without problem.

This patchset is sent because above mentioned challenges, all the
solutions need extra review/feedback, not only from btrfs community but
also block layer community, to determine if this is really the best
solution.

Qu Wenruo (11):
  btrfs: update an stale comment on btrfs_submit_bio_hook()
  btrfs: refactor btrfs_map_bio()
  btrfs: move btrfs_bio_wq_end_io() calls into submit_stripe_bio()
  btrfs: introduce btrfs_bio_split() helper
  btrfs: save bio::bi_iter into btrfs_bio::iter before submitting
  btrfs: make end_bio_extent_readpage() to handle split bio properly
  btrfs: make end_bio_extent_*_writepage() to handle split biot properly
  btrfs: allow btrfs_map_bio() to split bio according to chunk stripe
    boundaries
  btrfs: remove bio split operations in btrfs_submit_direct()
  btrfs: remove btrfs_bio_ctrl::len_to_stripe_boundary
  btrfs: temporarily disable RAID56

 fs/btrfs/compression.c |   7 +-
 fs/btrfs/ctree.h       |   5 +-
 fs/btrfs/disk-io.c     |   9 +-
 fs/btrfs/extent_io.c   | 183 +++++++++++++++++++++++++++--------------
 fs/btrfs/extent_io.h   |   3 +-
 fs/btrfs/inode.c       | 153 +++++++++++-----------------------
 fs/btrfs/raid56.c      |   2 +
 fs/btrfs/volumes.c     | 138 ++++++++++++++++++++++++-------
 fs/btrfs/volumes.h     |  72 +++++++++++++++-
 9 files changed, 358 insertions(+), 214 deletions(-)

-- 
2.34.0

