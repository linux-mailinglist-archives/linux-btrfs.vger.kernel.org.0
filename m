Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5891C190B8A
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Mar 2020 11:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgCXKxV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Mar 2020 06:53:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:33642 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbgCXKxV (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Mar 2020 06:53:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0E295AF39
        for <linux-btrfs@vger.kernel.org>; Tue, 24 Mar 2020 10:53:19 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 0/6] btrfs-progs: Fixes for valgrind errors during fsck-tests
Date:   Tue, 24 Mar 2020 18:53:09 +0800
Message-Id: <20200324105315.136569-1-wqu@suse.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This patchset can be fetched from github:
https://github.com/adam900710/btrfs-progs/tree/valgrind_fixes

Inspired by that long-existing-but-I-can't-reproduce v5.1 bug, I will
never trust D=asan/D=uban anymore, and run valgrind on all fsck-tests.

The patchset is the result from the latest valgrind runs.

The first patch is to make "make INSTRUMENT=valgrind test-fsck" run
smoothly without false alerts due to mount/umount failure with valgrind.

The rest are the fixes for the error reports.

There are 2 more error reports, which I tend to believe they are just
false alerts.
Both are from fsck/012:
==122119== Syscall param pwrite64(buf) points to uninitialised byte(s)
==122119==    at 0x49F303A: pwrite (in /usr/lib/libpthread-2.31.so)
==122119==    by 0x1A5CA1: write_extent_to_disk (extent_io.c:816)
==122119==    by 0x1B2523: write_and_map_eb (disk-io.c:512)
==122119==    by 0x1B26C3: write_tree_block (disk-io.c:545)
==122119==    by 0x1D481B: __commit_transaction (transaction.c:148)
==122119==    by 0x1D4A9B: btrfs_commit_transaction (transaction.c:213)
==122119==    by 0x16360D: fixup_extent_refs (main.c:7662)
==122119==    by 0x16449F: check_extent_refs (main.c:8033)
==122119==    by 0x166199: check_chunks_and_extents (main.c:8786)
==122119==    by 0x166441: do_check_chunks_and_extents (main.c:8842)
==122119==    by 0x169D13: cmd_check (main.c:10324)
==122119==    by 0x11CDC6: cmd_execute (commands.h:125)
==122119==  Address 0x4e8aeb0 is 128 bytes inside a block of size 4,224 alloc'd
==122119==    at 0x483BB65: calloc (vg_replace_malloc.c:762)
==122119==    by 0x1A54C5: __alloc_extent_buffer (extent_io.c:609)
==122119==    by 0x1A5AED: alloc_extent_buffer (extent_io.c:753)
==122119==    by 0x1B1A26: btrfs_find_create_tree_block (disk-io.c:222)
==122119==    by 0x1BD4BE: btrfs_alloc_free_block (extent-tree.c:2538)
==122119==    by 0x1A8CFF: __btrfs_cow_block (ctree.c:322)
==122119==    by 0x1A91E2: btrfs_cow_block (ctree.c:415)
==122119==    by 0x1AB188: btrfs_search_slot (ctree.c:1185)
==122119==    by 0x160BBC: delete_extent_records (main.c:6652)
==122119==    by 0x16343F: fixup_extent_refs (main.c:7629)
==122119==    by 0x16449F: check_extent_refs (main.c:8033)
==122119==    by 0x166199: check_chunks_and_extents (main.c:8786)
==122119==

These 128 bytes are just the extent buffer in-memory header, which is
properly initialized, and we don't write that in-memory header on to
disk.

==122119== Conditional jump or move depends on uninitialised value(s)
==122119==    at 0x1B63A9: warning_trace (kerncompat.h:102)
==122119==    by 0x1BBF74: __free_extent (extent-tree.c:2042)
==122119==    by 0x1C0501: run_delayed_tree_ref (extent-tree.c:3758)
==122119==    by 0x1C058D: run_one_delayed_ref (extent-tree.c:3778)
==122119==    by 0x1C079F: btrfs_run_delayed_refs (extent-tree.c:3862)
==122119==    by 0x1D4903: btrfs_commit_transaction (transaction.c:172)
==122119==    by 0x1581AC: repair_btree (main.c:3508)
==122119==    by 0x158A76: check_fs_root (main.c:3671)
==122119==    by 0x158EAB: check_fs_roots (main.c:3771)
==122119==    by 0x159291: do_check_fs_roots (main.c:3888)
==122119==    by 0x169EFB: cmd_check (main.c:10364)
==122119==    by 0x11CDC6: cmd_execute (commands.h:125)
==122119==

I checked all related members, from the delayed tree ref to related
members, can't really find out what's wrong, as all memory looks
initialized without problem.

With this patchset applied (along with that fix for v5.1), fsck tests
all passes without valgrind error except mentioned fsck/012 above.

Qu Wenruo (6):
  btrfs-progs: tests/common: Don't call INSTRUMENT on mount command
  btrfs-progs: check/original: Fix uninitialized stack memory access for
    deal_root_from_list()
  btrfs-progs: check/original: Fix uninitialized memory for newly
    allocated data_backref
  btrfs-progs: check/original: Fix uninitialized return value from
    btrfs_write_dirty_block_groups()
  btrfs-progs: check/original: Fix uninitialized extent buffer contents
  btrfs-progs: extent-tree: Fix wrong post order rb tree cleanup for
    block groups

 check/main.c  | 4 ++--
 extent-tree.c | 3 +--
 extent_io.c   | 1 +
 tests/common  | 8 +++++++-
 4 files changed, 11 insertions(+), 5 deletions(-)

-- 
2.25.2

