Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B737187AD5
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Mar 2020 09:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725916AbgCQILi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Mar 2020 04:11:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:42238 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgCQILi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Mar 2020 04:11:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 91C8EAE3C
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Mar 2020 08:11:34 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH RFC 00/39] btrfs: qgroup: Use backref cache based backref walk for commit roots
Date:   Tue, 17 Mar 2020 16:10:46 +0800
Message-Id: <20200317081125.36289-1-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset is based on an OLD misc-next branch, please inform me
before trying to merge, so I can rebase it to latest misc-next.
(There will be tons of conflicts)

The branch can be fetched from github for review/testing.
https://github.com/adam900710/linux/tree/backref_cache_all

The patchset survives all the existing qgroup tests.


=== BACKGROUND ===
One of the biggest problem for qgroup is its performance impact.
Although we have improved it in since v5.0 kernel, there is still
something slowing down qgroup, the backref walk.

Before this patchset, we use btrfs_find_all_roots() to iterate all roots
referring to one extent.
That function is doing a pretty good job, but it doesn't has any cache,
which means even we're looking up the same extent, we still need to do
the full backref walk.

On the other hand, relocation is doing its own backref cache, and
provides a much faster backref walk.

So the patchset is mostly trying to make qgroup backref walk (at least
commit root backref walk) to use the same mechanism provided by
relocation.

=== BENCHMARK ===
For the performance improvement, the last patch has a benchmark.
The following content is completely copied from that patch:
------
Here is a small script to test it:

  mkfs.btrfs -f $dev
  mount $dev -o space_cache=v2 $mnt

  btrfs subvolume create $mnt/src

  for ((i = 0; i < 64; i++)); do
          for (( j = 0; j < 16; j++)); do
                  xfs_io -f -c "pwrite 0 2k" $mnt/src/file_inline_$(($i * 16 + $j)) > /dev/null
          done
          xfs_io -f -c "pwrite 0 1M" $mnt/src/file_reg_$i > /dev/null
          sync
          btrfs subvol snapshot $mnt/src $mnt/snapshot_$i
  done
  sync

  btrfs quota enable $mnt
  btrfs quota rescan -w $mnt

Here is the benchmark for above small tests.
The performance material is the total execution time of get_old_roots()
for patched kernel (*), and find_all_roots() for original kernel.

*: With CONFIG_BTRFS_FS_CHECK_INTEGRITY disabled, as get_old_roots()
   will call find_all_roots() to verify the result if that config is
   enabled.

		|  Number of calls | Total exec time |
------------------------------------------------------
find_all_roots()|  732		   | 529991034ns
get_old_roots() |  732		   | 127998312ns
------------------------------------------------------
diff		|  0.00 %	   | -75.8 %
------


Patch 01~30 are mostly refactors and code movement, which exposes no
behavior change.

Patch 31~32 are small behavior change only for qgroup backref cache.
Patch 33~39 are the implementation of qgroup backref cache.


=== REASON FOR RFC ===
The naming is currently my biggest concern.

Since the code movement involves exporting quite a lot of functions, in
theory they should have btrfs_ prefix.
(For all newly exported functions in backref.h)

But some functions like alloc_backref_node(), adding "btrfs_" prefix
doesn't make it more clear, but just making it unnecessary long.

My current plan is to rename them using "btrfs_brc_" prefix (BackRef
Cache), and remove the "cache" in the original name.

E.g:
alloc_backref_node => btrfs_brc_alloc_node()
backref_cache_release => btrfs_brc_release()
link_backref_edge => btrfs_brc_link_edge()

But the abbr "brc" is pretty confusing and makes no sense by itself, so
I'm not sure what's the best practice here.

Qu Wenruo (39):
  btrfs: backref: Introduce the skeleton of btrfs_backref_iter
  btrfs: backref: Implement btrfs_backref_iter_next()
  btrfs: relocation: Use btrfs_backref_iter infrastructure
  btrfs: relocation: Rename mark_block_processed() and
    __mark_block_processed()
  btrfs: relocation: Add backref_cache::pending_edge and
    backref_cache::useless_node members
  btrfs: relocation: Add backref_cache::fs_info member
  btrfs: relocation: Make reloc root search specific for relocation
    backref cache
  btrfs: relocation: Refactor direct tree backref processing into its
    own function
  btrfs: relocation: Refactor indirect tree backref processing into its
    own function
  btrfs: relocation: Use wrapper to replace open-coded edge linking
  btrfs: relocation: Specify essential members for alloc_backref_node()
  btrfs: relocation: Remove the open-coded goto loop for breadth-first
    search
  btrfs: relocation: Refactor the finishing part of upper linkage into
    finish_upper_links()
  btrfs: relocation: Refactor the useless nodes handling into its own
    function
  btrfs: Move backref node/edge/cache structure to backref.h
  btrfs: Rename tree_entry to simple_node and export it
  btrfs: Move backref_cache_init() to backref.c
  btrfs: Move alloc_backref_node() to backref.c
  btrfs: Move alloc_backref_edge() to backref.c
  btrfs: Move link_backref_edge() to backref.c
  btrfs: Move free_backref_node() and free_backref_edge() to backref.h
  btrfs: Move drop_backref_node() and needed facilities to backref.h
  btrfs: Rename remove_backref_node() to cleanup_backref_node() and move
    it to backref.c
  btrfs: Rename backref_cache_cleanup() to backref_cache_release() and
    move it to backref.c
  btrfs: Rename backref_tree_panic() to backref_cache_panic(), and move
    it to backref.c
  btrfs: Rename should_ignore_root() to should_ignore_reloc_root() and
    export it
  btrfs: relocation: Open-code read_fs_root() for
    handle_indirect_tree_backref()
  btrfs: Rename handle_one_tree_block() to
    backref_cache_add_one_tree_block() and move it to backref.c
  btrfs: Rename finish_upper_links() to
    backref_cache_finish_upper_links() and move it to backref.c
  btrfs: relocation: Move error handling of build_backref_tree() to
    backref.c
  btrfs: relocation: Use btrfs_find_all_leaves() to locate parent tree
    leaves of a data extent
  btrfs: backref: Only ignore reloc roots for indrect backref resolve if
    the backref cache is for reloction purpose
  btrfs: qgroup: Introduce qgroup backref cache
  btrfs: qgroup: Introduce qgroup_backref_cache_build() function
  btrfs: qgroup: Introduce a function to iterate through backref_cache
    to find all parents for specified node
  btrfs: qgroup: Introduce helpers to get needed tree block info
  btrfs: qgroup: Introduce verification for function to ensure old roots
    ulist matches btrfs_find_all_roots() result
  btrfs: qgroup: Introduce a new function to get old_roots ulist using
    backref cache
  btrfs: qgroup: Use backref cache to speed up old_roots search

 fs/btrfs/backref.c    |  826 ++++++++++++++++++++++++-
 fs/btrfs/backref.h    |  305 +++++++++
 fs/btrfs/ctree.h      |    5 +
 fs/btrfs/disk-io.c    |    1 +
 fs/btrfs/misc.h       |   54 ++
 fs/btrfs/qgroup.c     |  511 +++++++++++++++-
 fs/btrfs/relocation.c | 1356 +++++++----------------------------------
 7 files changed, 1903 insertions(+), 1155 deletions(-)

-- 
2.25.1

