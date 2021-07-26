Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBED3D5942
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jul 2021 14:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbhGZLhW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Jul 2021 07:37:22 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:57992 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbhGZLhV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Jul 2021 07:37:21 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A0B701FE75;
        Mon, 26 Jul 2021 12:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1627301869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=P+gwaORr8f2nAj7HfaN9/SPXmo3oIRxSwUF5LlTN4mg=;
        b=SkZTGusi4byb0R0k6QDA+HFKFV7pfOUI5sGyZSZC6G6Iwmlb5jhcTUHhTpFP0Hoq0KJY6p
        8i3m+ViL3rEii3Cmn6NsUK0n7VEdlk8QGsjS2U6W1oB+eYCtYQ7GM4pqu2uoOJlyDvBxun
        phkvKCQ75wO9nBM9kLijA7rIV289N0E=
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 98F10A3BCD;
        Mon, 26 Jul 2021 12:17:49 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id DE2D9DA8D8; Mon, 26 Jul 2021 14:15:05 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 00/10] Misc small cleanups
Date:   Mon, 26 Jul 2021 14:15:05 +0200
Message-Id: <cover.1627300614.git.dsterba@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Mix of type fixups, helper cleanups and minor optimizations.

Overall impact on binary size:

   text    data     bss     dec     hex filename
1163320   19157   14912 1197389  12454d pre/btrfs.ko
1160800   19157   14912 1194869  123b75 post/btrfs.ko

DELTA: -2520

David Sterba (10):
  btrfs: switch uptodate to bool in btrfs_writepage_endio_finish_ordered
  btrfs: remove uptodate parameter from
    btrfs_dec_test_first_ordered_pending
  btrfs: make btrfs_next_leaf static inline
  btrfs: tree-checker: use table values for stripe checks
  btrfs: tree-checker: add missing stripe checks for raid1c3/4 profiles
  btrfs: uninline btrfs_bg_flags_to_raid_index
  btrfs: merge alloc_device helpers
  btrfs: simplify data stripe calculation helpers
  btrfs: constify and cleanup variables comparators
  btrfs: add and use simple page/bio to inode/fs_info helpers

 fs/btrfs/ctree.c        |  10 ----
 fs/btrfs/ctree.h        |  15 +++++-
 fs/btrfs/disk-io.c      |  24 +++++----
 fs/btrfs/extent_io.c    |  41 ++++++++-------
 fs/btrfs/inode.c        |  10 ++--
 fs/btrfs/misc.h         |   4 ++
 fs/btrfs/ordered-data.c |   5 +-
 fs/btrfs/ordered-data.h |   2 +-
 fs/btrfs/raid56.c       |   8 +--
 fs/btrfs/send.c         |   6 +--
 fs/btrfs/super.c        |  13 +++--
 fs/btrfs/tree-checker.c |  21 +++++---
 fs/btrfs/tree-log.c     |   2 +-
 fs/btrfs/volumes.c      | 109 ++++++++++++++++++++--------------------
 fs/btrfs/volumes.h      |  27 +---------
 15 files changed, 141 insertions(+), 156 deletions(-)

-- 
2.31.1

