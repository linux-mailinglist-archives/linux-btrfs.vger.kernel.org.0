Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35764BD0AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Sep 2019 19:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404155AbfIXRc6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Sep 2019 13:32:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:58046 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730714AbfIXRc6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Sep 2019 13:32:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 943EFAF57;
        Tue, 24 Sep 2019 17:32:56 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4CF48DA835; Tue, 24 Sep 2019 19:33:17 +0200 (CEST)
From:   David Sterba <dsterba@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>
Subject: [PATCH 0/4] Minor cleanups in locking helpers
Date:   Tue, 24 Sep 2019 19:33:16 +0200
Message-Id: <cover.1569345962.git.dsterba@suse.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Reorganizing code wrt locking helpers, minor text and stack savings.

Debugging build
~~~~~~~~~~~~~~~

   text    data     bss     dec     hex filename
1513898  146192   27496 1687586  19c022 pre/btrfs.ko
1514206  146768   27496 1688470  19c396 post/btrfs.ko
DELTA: +308
^^^^^^^^^^^ the increase is caused by inlining the
            btrfs_assert_tree_locked itself, IMO acceptable for debugging build

Stack report:

btrfs_clean_tree_block                                             -8 (24 -> 16)
btrfs_drop_subtree                                                 +8 (104 -> 112)
btrfs_mark_buffer_dirty                                            -8 (32 -> 24)
insert_ptr                                                         -8 (80 -> 72)

LOST (64):
        btrfs_assert_tree_read_locked                               8
        btrfs_assert_spinning_writers_get                          16
        btrfs_assert_spinning_readers_put                          16
        btrfs_assert_spinning_writers_put                          16
        btrfs_assert_tree_locked                                    8

NEW (0):
LOST/NEW DELTA:      -64
PRE/POST DELTA:      -80


Release build
~~~~~~~~~~~~~

   text    data     bss     dec     hex filename
1079643   17304   14912 1111859  10f733 pre/btrfs.ko
1079468   17316   14912 1111696  10f690 post/btrfs.ko
DELTA: -175
^^^^^^^^^^^ that's what counts

Stack report:

btrfs_drop_subtree                                                 -8 (80 -> 72)
btrfs_clean_tree_block                                             -8 (24 -> 16)
btrfs_mark_buffer_dirty                                            -8 (32 -> 24)
insert_ptr                                                         -8 (80 -> 72)

LOST (8):
        btrfs_assert_tree_locked                                    8

NEW (0):
LOST/NEW DELTA:       -8
PRE/POST DELTA:      -4

David Sterba (4):
  btrfs: make locking assertion helpers static inline
  btrfs: make btrfs_assert_tree_locked static inline
  btrfs: move btrfs_set_path_blocking to other locking functions
  btrfs: move btrfs_unlock_up_safe to other locking functions

 fs/btrfs/ctree.c         | 51 --------------------------
 fs/btrfs/ctree.h         |  1 -
 fs/btrfs/delayed-inode.c |  1 +
 fs/btrfs/locking.c       | 78 +++++++++++++++++++++++++++++++---------
 fs/btrfs/locking.h       | 13 ++++++-
 5 files changed, 75 insertions(+), 69 deletions(-)

-- 
2.23.0

