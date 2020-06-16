Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C331FC286
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Jun 2020 02:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgFQAAC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Jun 2020 20:00:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:54438 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbgFQAAB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Jun 2020 20:00:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C0B76AD04
        for <linux-btrfs@vger.kernel.org>; Wed, 17 Jun 2020 00:00:03 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v4 0/5] btrfs: qgroup: detect and fix leaked data reserved space
Date:   Wed, 17 Jun 2020 07:59:50 +0800
Message-Id: <20200616235955.21385-1-wqu@suse.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

There is an internal report complaining that qgroup is only half of the
limit, but they still get EDQUOT errors.

With some extra debugging patch added, it turns out that even fsstress
with 10 steps can sometimes cause qgroup reserved data space to leak.

The root cause is the chaotic lifespan of qgroup data rsv.
Here is the chart explaining the difference between the old and new
lifespan of qgroup data rsv:
  ||: Qgroup data rsv is reserved
   |: Qgroup data rsv is released but not freed
    : Qgroup data rsv is freed

	The old		The new

	   TT		   TT		Page get dirtied
 	   ||		   ||
           ||		   ||
  	   || ------------ || --------- btrfs_run_delalloc_range()
	   ||		    |		|- btrfs_add_ordered_extent()
	   ||		    |
	    | ------------  | --------- btrfs_finish_ordered_io()
	    |		    |
	      ------------    --------- btrfs_account_extents()

Since there is a large window between btrfs_add_ordered_extent() and
btrfs_finish_ordered_io(), during which page can be released and clear
the QGROUP_RESERVED bit.

In fact during dio, dio will try to flush the range, and then invalidate
the pages before submitting direct IO.

Due to the fact that filemap_write_and_wait_range() will only wait for
page writeback get cleared, not page dirty cleared, so it will release
pages before btrfs_finish_ordered_io() get executed, and clearing
QGROUP_RESERVED bit without triggering qgroup rsv release, leading to
qgroup data rsv leakage.

With the new timing, QGROUP_RESERVED bit is cleared before
filemap_write_and_wait_range() returns, and doing proper qgroup rsv
releasing, so there is no window to screw up qgroup rsv anymore.

Although to co-operate the timing change, quite some existing chaotic
btrfs_qgroup_release/free_data() calls must be modified/removed to
follow the more restrict calling protocol.

But overall, this make the qgroup data rsv lifespan more clear, so it
should be still worthy.

After all the big timing change and fixes, add an extra and hopefully
final safe net to catch qgroup data rsv leakage.
Now extent io tree based QGROUP_RESERVED bit should detect case like
missing btrfs_qgroup_release/free_data() call, while the unmount check
should detect unexpected QGROUP_RESERVED bit clearing.

The existing test case btrfs/022 can already catch the bug pretty
reliably.

Changelog:
v2:
- Change the lifespan of qgroup data rsv
  From the original whac-a-mole method to a more proper timing, to
  use ordered extents as the proper owner of qgroup data rsv.

- Add commit message for the final patch

- Adds extra refactor to make insert_reserved_file_extent() use less
  parameters

v3:
- Remove the redundant WARN() message

- Reduce the scope of struct btrfs_qgroup in btrfs_qgroup_has_leak()

v4:
- Pure changelog update to co-operate with the dio iomap revert
  Only the 1st and the 4th patches get updated.

Qu Wenruo (5):
  btrfs: inode: refactor the parameters of insert_reserved_file_extent()
  btrfs: inode: move qgroup reserved space release to the callers of
    insert_reserved_file_extent()
  btrfs: file: reserve qgroup space after the hole punch range is locked
  btrfs: change the timing for qgroup reserved space for ordered extents
    to fix reserved space leak
  btrfs: qgroup: catch reserved space leakage at unmount time

 fs/btrfs/ctree.h        |   6 +-
 fs/btrfs/disk-io.c      |   5 ++
 fs/btrfs/file.c         |   8 +--
 fs/btrfs/inode.c        | 119 +++++++++++++++++++++++-----------------
 fs/btrfs/ordered-data.c |  22 +++++++-
 fs/btrfs/ordered-data.h |   3 +
 fs/btrfs/qgroup.c       |  43 +++++++++++++++
 fs/btrfs/qgroup.h       |   1 +
 8 files changed, 151 insertions(+), 56 deletions(-)

-- 
2.27.0

