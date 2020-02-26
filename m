Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71D4E16F7B0
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Feb 2020 06:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgBZF5A (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 26 Feb 2020 00:57:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:36558 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgBZF5A (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 26 Feb 2020 00:57:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C93E2AC65
        for <linux-btrfs@vger.kernel.org>; Wed, 26 Feb 2020 05:56:57 +0000 (UTC)
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Subject: [PATCH 00/10] btrfs: relocation: Refactor build_backref_tree()
Date:   Wed, 26 Feb 2020 13:56:42 +0800
Message-Id: <20200226055652.24857-1-wqu@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This branch can be fetched from github:
https://github.com/adam900710/linux/tree/backref_cache_new

The main objective of this patchset is to refactor build_backref_tree()
and get myself more familiar with the backref cache.

The refactor also add quite some comments explaining how the backref
cache is built, but I'm also working on crafting a new dev doc for the
backref cache.

As some more example would greatly help reader to go through the
somewhat weird code.

Patch 1~8 haven already been sent to the mail list. This time they are
included for a better review.

There are 3 main structures involved:
- backref_cache
  The main cache structure, store all the existing cached map.

- backref_node
  Represent one tree block.
  It can have multiple parent and multiple children backref_edges
  related.

- backref_edge
  Represent one parent-child relationship between two backref_node.
  Both parent (upper) and child (lower) backref_node can iterate through
  their list to locate the edge.

The objective build_backref_cache() is to build a map, starting from
specified node, to reach all its parents. E.g:

  build_backref_tree() is called on bytenr X, then the following map
  is added to backref_cache:
     Root 257   Root 258
	  A      B
          |    /
          |  /
	  |/  
	  C
	  |
	  X
  We will have backref_nodes for X, A, B, C in the backref_cache, and
  3 edges between (X, C), (C, A), (C, B).


The short workflow of build_backref_tree() is:

- Iterate through all parent nodes of the specified node
  (ITERATION)

  Here we go breadth first search. We go through direct parent of
  current node. The iteration is bottom-up.

  For how each backref item is handled, check handle_one_tree_backref()
  for details.

  When a direct parent is found, we check if the direct parent is
  cached:
  * Cached:
    Allocate the edge between this node and parent. Call it a day, and
    process next parent.
  * Not cached:
    Allocate both edges and nodes. And queue the parent node for
    iteration.

  During this stage, new nodes are only allocated, not yet added to
  cache, and new edges are only linked to lower nodes.

  After this step, we have reached all roots referring to the specified
  node.
  Some root nodes may be useless (reloc tree root), they will be queued
  for later cleanup.

- Finish the linkage between newly added nodes and edges.
  (WEAVING)
  Since previous step only allocated new nodes, and only linked edges
  with its lower node, we still need to add the nodes to cache, and
  finish the linkage.

  See finish_upper_links() for details.

- Cleanup the useless trees
  (CLEANUP)
  For reloc trees, we only cache the backref nodes for higher tree
  nodes. And don't keep any edges. So such backref nodes are marked
  detached.
  Tree leaves for reloc trees are not cached.

  Such behavior is to reduce memory usage for useless trees, but still
  allow backref cache hit, to avoid unnecessary cache search.

  And also mark the useless nodes as processed for relocation.


With the refactor, only the CLEANUP part of build_backref_tree() is
coupled with relocation.
And now build_backref_tree() is only 125 lines, it's a pretty good start
point for us to reuse backref_cache for other workload, like qgroups.

Qu Wenruo (10):
  btrfs: backref: Introduce the skeleton of btrfs_backref_iter
  btrfs: backref: Implement btrfs_backref_iter_next()
  btrfs: relocation: Use btrfs_backref_iter infrastructure
  btrfs: relocation: Rename mark_block_processed() and
    __mark_block_processed()
  btrfs: relocation: Refactor tree backref processing into its own
    function
  btrfs: relocation: Use wrapper to replace open-coded edge linking
  btrfs: relocation: Specify essential members for alloc_backref_node()
  btrfs: relocation: Remove the open-coded goto loop for breadth-first
    search
  btrfs: relocation: Refactor the finishing part of upper linkage into
    finish_upper_links()
  btrfs: relocation: Refactor the useless nodes handling into its own
    function

 fs/btrfs/backref.c    | 145 +++++++
 fs/btrfs/backref.h    |  94 +++++
 fs/btrfs/relocation.c | 959 ++++++++++++++++++++++--------------------
 3 files changed, 750 insertions(+), 448 deletions(-)

-- 
2.25.1

