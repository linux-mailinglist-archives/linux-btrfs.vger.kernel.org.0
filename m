Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312AC4024A0
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 Sep 2021 09:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241105AbhIGHoM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 Sep 2021 03:44:12 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43552 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242156AbhIGHnz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 Sep 2021 03:43:55 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C4D701FD49
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Sep 2021 07:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1631000568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=esBsCqB6JFchbncFE5t3FtnB8NkrxwbcdmiLcNXVzdI=;
        b=MiBXdN1tsr6jqGhUed5bt1OKsa/3zfHVriILZPzi9LZ7VDaODTvukIKYexHF8VnkQGHLbx
        ENG4qn0yhafUjIqRlhfeLk2CHP+p1BkrIxEFHlKIb0fm7bouZkFOIwM8DnVJqLpqFrcvjl
        PY6P1+maLa7HoTjQurXl87pM5xHottA=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 6BE0F132FD
        for <linux-btrfs@vger.kernel.org>; Tue,  7 Sep 2021 07:42:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id lC3dCvUXN2GTFQAAGKfGzw
        (envelope-from <wqu@suse.com>)
        for <linux-btrfs@vger.kernel.org>; Tue, 07 Sep 2021 07:42:45 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/3] btrfs: btrfs_bio and btrfs_io_bio rename
Date:   Tue,  7 Sep 2021 15:42:39 +0800
Message-Id: <20210907074242.103438-1-wqu@suse.com>
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

While btrfs_io_bio acts more like a phyical mapping, mapping logical
bytenr to real devices.

Such naming is completely anti-human.

So this patchset will rename btrfs_io_bio to btrfs_logical_bio and
rename btrfs_bio to btrfs_physical_bio.

This acts as the first step towards chunk layer code refactor, the
ultimate goals include:

- Move bio split code into chunk layer
  Currently btrfs_map_bio() requires the bio passed in not to cross
  stripe boundaries.

  Thus it requires submit_extent_page() to do bio splitting.

  In fact higher layer code shouldn't bother that at all, chunk layer
  code should do the bio splitting.

- Hide btrfs_physical_bio
  In fact for certain types, like SINGLE it doesn't need complex
  btrfs_physical_bio, and can do its IO just remapping the existing bio.

  In fact, each chunk type should have their own bio mapping and
  physical bio tracing code.
  They can share some common infrastructure, but definitely not
  exporting the whole btrfs_physical_bio as a core structure.

- Create fs/btrfs/raid/*.[ch] for each chunk type
  Some chunk mapping can definitely share some code, but we definitely
  don't want to put all chunk mapping code into volumes.[ch]/scrub.[ch].

- Provide better exported chunk layer interface.
  Can't we just use bytenr + mirror_num to handle most things?

  For device map code, we never bother whatever the underlying layer is.

  If we can unify the interface to bare minimal, we can really separate
  the chunk mapping code from higher layer code.

  Although I'm not that optimistic since we still have scrub to bother.


Qu Wenruo (3):
  btrfs: rename btrfs_io_bio_alloc() to btrfs_bio_alloc_iovecs()
  btrfs: rename struct btrfs_io_bio to struct btrfs_logical_bio
  btrfs: rename struct btrfs_bio to btrfs_physical_bio

 fs/btrfs/check-integrity.c |   4 +-
 fs/btrfs/compression.c     |  16 +--
 fs/btrfs/ctree.h           |   5 +-
 fs/btrfs/disk-io.c         |   2 +-
 fs/btrfs/disk-io.h         |   2 +-
 fs/btrfs/extent-tree.c     |  14 +-
 fs/btrfs/extent_io.c       |  96 +++++++-------
 fs/btrfs/extent_io.h       |  11 +-
 fs/btrfs/file-item.c       |  12 +-
 fs/btrfs/inode.c           |  57 ++++----
 fs/btrfs/raid56.c          | 126 +++++++++---------
 fs/btrfs/raid56.h          |   8 +-
 fs/btrfs/reada.c           |  26 ++--
 fs/btrfs/scrub.c           | 130 +++++++++---------
 fs/btrfs/volumes.c         | 263 +++++++++++++++++++------------------
 fs/btrfs/volumes.h         |  67 +++++++---
 fs/btrfs/zoned.c           |  16 +--
 17 files changed, 446 insertions(+), 409 deletions(-)

-- 
2.33.0

