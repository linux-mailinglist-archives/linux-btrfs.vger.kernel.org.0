Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A30F23FE21
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Aug 2020 14:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgHIMJc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Aug 2020 08:09:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:56124 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgHIMJb (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 9 Aug 2020 08:09:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DAEF7AD0B;
        Sun,  9 Aug 2020 12:09:48 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Jungyeon Yoon <jungyeon.yoon@gmail.com>
Subject: [PATCH v3 0/5] btrfs: Enhanced runtime defence against fuzzed images
Date:   Sun,  9 Aug 2020 20:09:14 +0800
Message-Id: <20200809120919.85271-1-wqu@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patch is revived after one year, as one internal report has hit one
BUG_ON() with real world fs, so I believe this patchset still makes sense.

- Enhanced eb accessors
  Not really needed for the fuzzed images, as 448de471cd4c
  ("btrfs: Check the first key and level for cached extent buffer")
  already fixed half of the reported images.
  Just add a final layer of safe net.

  Just to complain here, two experienced btrfs developer have got
  confused by @start, @len in functions like read_extent_buffer() with
  logical address.
  The best example to solve the confusion is to check the
  read_extent_buffer() call in btree_read_extent_buffer_pages().

  I'm not sure why this confusion happens or even get spread.
  My guess is the extent_buffer::start naming causing the problem.

  If so, I would definitely rename extent_buffer::start to
  extent_buffer::bytenr at any cost.
  Hopes the new commend will address the problem for now.

- BUG_ON() hunt in __btrfs_free_extent()
  Kill BUG_ON()s in __btrfs_free_extent(), replace with error reporting
  and why it shouldn't happen.

  Also add comment on what __btrfs_free_extent() is designed to do, with
  two dump-tree examples for newcomers.

- BUG_ON() hunt in __btrfs_inc_extent_ref()
  Just like __btrfs_free_extent(), but less comment as
  comment for __btrfs_free_extent() should also work for
  __btrfs_inc_extent_ref(), and __btrfs_inc_extent_ref() has a better
  structure than __btrfs_free_extent().

- Defence against unbalanced empty leaf

- Defence against bad key order across two tree blocks

The last two cases can't be rejected by tree-checker and they are all
cross-eb cases.
Thankfully we can reuse existing first_key check against unbalanced
empty leaf, but needs extra check deep into ctree.c for tree block
merging time check.

Reported-by: Jungyeon Yoon <jungyeon.yoon@gmail.com>
[ Not to mail bombarding the report, thus only RB tag in cover letter ]

Changelog:
v2:
- Remove duplicated error message in WARN() call.
  Changed to WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG))
  Also move WARN() after btrfs error message.

- Fix a comment error in __btrfs_free_extent()
  It's not adding refs to a tree block, but adding the same refs
  to an existing tree block ref.
  It's impossible a btrfs tree owning the same tree block directly twice.

- Add comment for eb accessors about @start and @len
  If anyone could tell me why such confusion between @start @len and
  logical address is here, I will definitely solve the root cause no
  matter how many codes need to be modified.

- Use bool to replace int where only two values are returned
  Also rename to follow the bool type.

- Remove one unrelated change for the error handler in
  btrfs_inc_extent_ref()

- Add Reviewed-by tag

v3:
- Rebased to latest misc-next branch
  All conflicts can be auto-merged.

Qu Wenruo (5):
  btrfs: extent_io: Do extra check for extent buffer read write
    functions
  btrfs: extent-tree: Kill BUG_ON() in __btrfs_free_extent() and do
    better comment
  btrfs: Detect unbalanced tree with empty leaf before crashing btree
    operations
  btrfs: extent-tree: Kill the BUG_ON() in
    insert_inline_extent_backref()
  btrfs: ctree: Checking key orders before merged tree blocks

 fs/btrfs/ctree.c       |  68 +++++++++++++++++
 fs/btrfs/disk-io.c     |   8 ++
 fs/btrfs/extent-tree.c | 164 +++++++++++++++++++++++++++++++++++++----
 fs/btrfs/extent_io.c   |  76 +++++++++----------
 4 files changed, 265 insertions(+), 51 deletions(-)

-- 
2.28.0

