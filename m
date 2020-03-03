Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7F3176FC8
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2020 08:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbgCCHOP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Mar 2020 02:14:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:56520 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727516AbgCCHOP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 3 Mar 2020 02:14:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E31FAB1A2
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2020 07:14:13 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 00/19] btrfs: Move generic backref cache build functions to backref.c
Date:   Tue,  3 Mar 2020 15:13:50 +0800
Message-Id: <20200303071409.57982-1-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The patchset is based on previous backref_cache_refactor branch, which
is further based on misc-next.

The whole series can be fetched from github:
https://github.com/adam900710/linux/tree/backref_cache_code_move

All the patches in previous branch is not touched at all, thus they are
not re-sent in this patchset.


Currently there are 3 major parts of build_backref_tree():
- ITERATION
  This will do a breadth-first search, starts from the target bytenr,
  and queue all parents into the backref cache.
  The result is a temporary map, which is only single-directional, and
  involved new backref nodes are not yet inserted into the cache.

- WEAVING
  Finish the map to make it bi-directional, and insert new nodes into
  the cache.

- CLEANUP
  Cleanup the useless nodes, either remove it completely or add them
  into the cache as detached.

For the ITERATION part, there are only limited locations coupled with
relocation.
And WEAVING part is completely independent from relocation.
While the CLEANUP part, although it has some relocation related code,
it's not a big hunk of code after all.

So, this patchset will move the ITERATION part, extracted as
backref_cache_add_one_tree_block(), and the WEAVING part, extracted as
backref_cache_finish_upper_links(), to backref.c, as the basis for later
reuse of backref_cache.

Qu Wenruo (19):
  btrfs: Move backref node/edge/cache structure to backref.h
  btrfs: Rename tree_entry to simple_node and export it
  btrfs: relocation: Make reloc root search specific for relocation
    backref cache
  btrfs: relocation: Add backref_cache::pending_edge and
    backref_cache::useless_node members
  btrfs: relocation: Add backref_cache::fs_info member
  btrfs: Move backref_cache_init() to backref.c
  btrfs: Move alloc_backref_node() to backref.c
  btrfs: Move alloc_backref_edge() to backref.c
  btrfs: Move link_backref_edge() to backref.c
  btrfs: Move free_backref_node() and free_backref_edge() to backref.h
  btrfs: Move drop_backref_node() and needed facilities to backref.h
  btrfs: Rename remove_backref_node() to cleanup_backref_node() and move
    it to backref.c
  btrfs: Move backref_cache_cleanup() to backref.c
  btrfs: Rename backref_tree_panic() to backref_cache_panic(), and move
    it to backref.c
  btrfs: Rename should_ignore_root() to should_ignore_reloc_root() and
    export it
  btrfs: relocation: Open-code read_fs_root() for
    handle_one_tree_backref()
  btrfs: Rename handle_one_tree_block() to
    backref_cache_add_one_tree_block() and move it to backref.c
  btrfs: relocation: Move the target backref node insert code into
    finish_upper_links()
  btrfs: Rename finish_upper_links() to
    backref_cache_finish_upper_links() and move it to backref.c

 fs/btrfs/backref.c    | 534 ++++++++++++++++++++++++++
 fs/btrfs/backref.h    | 226 +++++++++++
 fs/btrfs/ctree.h      |   3 +
 fs/btrfs/misc.h       |  54 +++
 fs/btrfs/relocation.c | 870 ++++--------------------------------------
 5 files changed, 892 insertions(+), 795 deletions(-)

-- 
2.25.1

