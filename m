Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEEA0193ADD
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Mar 2020 09:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgCZIdX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 26 Mar 2020 04:33:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:48950 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgCZIdX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 26 Mar 2020 04:33:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E3362AD08
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Mar 2020 08:33:19 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH v2 00/39] btrfs: qgroup: Use backref cache based backref walk for commit roots
Date:   Thu, 26 Mar 2020 16:32:37 +0800
Message-Id: <20200326083316.48847-1-wqu@suse.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset is based on misc-5.7 branch.

The branch can be fetched from github for review/testing.
https://github.com/adam900710/linux/tree/backref_cache_all

The patchset survives all the existing qgroup/volume/replace/balance tests.


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


=== PATCHSET STRUCTURE ===
Patch 01~14 are refactors of relocation backref.
Patch 15~31 are code move.
Patch 32 is the patch that is already in misc-next.
Patch 33 is the final preparation for qgroup backref.
Patch 34~40 are the qgroup backref cache implementation.

=== CHANGELOG ===
v1:
- Use btrfs_backref_ prefix for exported structure/function
- Add one extra patch to rename backref_(node/edge/cache)
  The renaming itself is not small, thus better to do the rename
  first then move them to backref.[ch].
- Add extra Reviewed-by tags.

v2:
- Rebased to misc-next branch
- Add new reviewed-by tags from v1.

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
  btrfs: relocation: Add btrfs_ prefix for backref_node/edge/cache
  btrfs: Move btrfs_backref_(node|edge|cache) structures to backref.h
  btrfs: Rename tree_entry to simple_node and export it
  btrfs: Rename backref_cache_init() to btrfs_backref_cache_init() and
    move it to backref.c
  btrfs: Rename alloc_backref_node() to btrfs_backref_alloc_node() and
    move it backref.c
  btrfs: Rename alloc_backref_edge() to btrfs_backref_alloc_edge() and
    move it backref.c
  btrfs: Rename link_backref_edge() to btrfs_backref_link_edge() and
    move it backref.h
  btrfs: Rename free_backref_(node|edge) to
    btrfs_backref_free_(node|edge) and move them to backref.h
  btrfs: Rename drop_backref_node() to btrfs_backref_drop_node() and
    move its needed facilities to backref.h
  btrfs: Rename remove_backref_node() to btrfs_backref_cleanup_node()
    and move it to backref.c
  btrfs: Rename backref_cache_cleanup() to btrfs_backref_release_cache()
    and move it to backref.c
  btrfs: Rename backref_tree_panic() to btrfs_backref_panic(), and move
    it to backref.c
  btrfs: Rename should_ignore_root() to btrfs_should_ignore_reloc_root()
    and export it
  btrfs: relocation: Open-code read_fs_root() for
    handle_indirect_tree_backref()
  btrfs: Rename handle_one_tree_block() to btrfs_backref_add_tree_node()
    and move it to backref.c
  btrfs: Rename finish_upper_links() to
    btrfs_backref_finish_upper_links() and move it to backref.c
  btrfs: relocation: Move error handling of build_backref_tree() to
    backref.c
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

 fs/btrfs/backref.c    |  808 ++++++++++++++++++++++++++++
 fs/btrfs/backref.h    |  319 +++++++++++
 fs/btrfs/ctree.h      |    5 +
 fs/btrfs/disk-io.c    |    1 +
 fs/btrfs/misc.h       |   54 ++
 fs/btrfs/qgroup.c     |  516 +++++++++++++++++-
 fs/btrfs/relocation.c | 1187 ++++++++---------------------------------
 7 files changed, 1925 insertions(+), 965 deletions(-)

-- 
2.26.0

