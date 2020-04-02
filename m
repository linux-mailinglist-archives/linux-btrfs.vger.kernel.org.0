Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C949819C6EF
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Apr 2020 18:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389794AbgDBQTE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Apr 2020 12:19:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:58504 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389458AbgDBQTE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 2 Apr 2020 12:19:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 49F72AEAA;
        Thu,  2 Apr 2020 16:19:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 75527DA727; Thu,  2 Apr 2020 18:18:28 +0200 (CEST)
Date:   Thu, 2 Apr 2020 18:18:28 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/39] btrfs: qgroup: Use backref cache based backref
 walk for commit roots
Message-ID: <20200402161828.GD5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200326083316.48847-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326083316.48847-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I went through the patches, overall like the patch separation made it
easy. Thanks.

There are some things that I fixed or updated.

On Thu, Mar 26, 2020 at 04:32:37PM +0800, Qu Wenruo wrote:
> Qu Wenruo (39):
>   btrfs: backref: Introduce the skeleton of btrfs_backref_iter
>   btrfs: backref: Implement btrfs_backref_iter_next()
>   btrfs: relocation: Use btrfs_backref_iter infrastructure
>   btrfs: relocation: Rename mark_block_processed() and
>     __mark_block_processed()
>   btrfs: relocation: Add backref_cache::pending_edge and
>     backref_cache::useless_node members
>   btrfs: relocation: Add backref_cache::fs_info member
>   btrfs: relocation: Make reloc root search specific for relocation
>     backref cache
>   btrfs: relocation: Refactor direct tree backref processing into its
>     own function
>   btrfs: relocation: Refactor indirect tree backref processing into its
>     own function
>   btrfs: relocation: Use wrapper to replace open-coded edge linking
>   btrfs: relocation: Specify essential members for alloc_backref_node()
>   btrfs: relocation: Remove the open-coded goto loop for breadth-first
>     search
>   btrfs: relocation: Refactor the finishing part of upper linkage into
>     finish_upper_links()
>   btrfs: relocation: Refactor the useless nodes handling into its own
>     function
>   btrfs: relocation: Add btrfs_ prefix for backref_node/edge/cache
>   btrfs: Move btrfs_backref_(node|edge|cache) structures to backref.h
>   btrfs: Rename tree_entry to simple_node and export it
>   btrfs: Rename backref_cache_init() to btrfs_backref_cache_init() and
>     move it to backref.c
>   btrfs: Rename alloc_backref_node() to btrfs_backref_alloc_node() and
>     move it backref.c
>   btrfs: Rename alloc_backref_edge() to btrfs_backref_alloc_edge() and
>     move it backref.c
>   btrfs: Rename link_backref_edge() to btrfs_backref_link_edge() and
>     move it backref.h
>   btrfs: Rename free_backref_(node|edge) to
>     btrfs_backref_free_(node|edge) and move them to backref.h
>   btrfs: Rename drop_backref_node() to btrfs_backref_drop_node() and
>     move its needed facilities to backref.h
>   btrfs: Rename remove_backref_node() to btrfs_backref_cleanup_node()
>     and move it to backref.c
>   btrfs: Rename backref_cache_cleanup() to btrfs_backref_release_cache()
>     and move it to backref.c
>   btrfs: Rename backref_tree_panic() to btrfs_backref_panic(), and move
>     it to backref.c
>   btrfs: Rename should_ignore_root() to btrfs_should_ignore_reloc_root()
>     and export it
>   btrfs: relocation: Open-code read_fs_root() for
>     handle_indirect_tree_backref()
>   btrfs: Rename handle_one_tree_block() to btrfs_backref_add_tree_node()
>     and move it to backref.c
>   btrfs: Rename finish_upper_links() to
>     btrfs_backref_finish_upper_links() and move it to backref.c
>   btrfs: relocation: Move error handling of build_backref_tree() to
>     backref.c
>   btrfs: backref: Only ignore reloc roots for indrect backref resolve if
>     the backref cache is for reloction purpose

This subject line is way too long and also quite hard to grasp what's
the patch actually doing. The other subjects about moving functions are
too long as well, I understand you want to put the new name there too,
but it's IMHO not necessary. When the function is 'renamed and moved',
the details are in the patch. So the final list of subject lines I got
to:

  btrfs: backref: introduce the skeleton of btrfs_backref_iter
  btrfs: backref: implement btrfs_backref_iter_next()
  btrfs: reloc: use btrfs_backref_iter infrastructure
  btrfs: reloc: rename mark_block_processed and __mark_block_processed
  btrfs: reloc: add backref_cache::pending_edge and backref_cache::useless_node
  btrfs: reloc: add backref_cache::fs_info member
  btrfs: reloc: make reloc root search-specific for relocation backref cache
  btrfs: reloc: refactor direct tree backref processing into its own function
  btrfs: reloc: refactor indirect tree backref processing into its own function
  btrfs: reloc: use wrapper to replace open-coded edge linking
  btrfs: reloc: pass essential members for alloc_backref_node()
  btrfs: reloc: remove the open-coded goto loop for breadth-first search
  btrfs: reloc: refactor finishing part of upper linkage into finish_upper_links()
  btrfs: reloc: refactor useless nodes handling into its own function
  btrfs: reloc: add btrfs_ prefix for backref_node/edge/cache
  btrfs: move btrfs_backref_(node|edge|cache) structures to backref.h
  btrfs: rename tree_entry to simple_node and export it
  btrfs: rename and move backref_cache_init()
  btrfs: rename and move alloc_backref_node()
  btrfs: rename and move alloc_backref_edge()
  btrfs: rename and move link_backref_edge()
  btrfs: rename and move free_backref_(node|edge)
  btrfs: rename and move drop_backref_node()
  btrfs: rename and move remove_backref_node()
  btrfs: rename and move backref_cache_cleanup()
  btrfs: rename and move backref_tree_panic()
  btrfs: rename and move should_ignore_root()
  btrfs: reloc: open-code read_fs_root() for handle_indirect_tree_backref()
  btrfs: rename and move handle_one_tree_block()
  btrfs: rename and move finish_upper_links()
  btrfs: reloc: move error handling of build_backref_tree() to backref.c
  btrfs: backref: distinguish reloc and non-reloc use of indirect resolution

For a cleanup series I'd really like to see more focus on making the
code also look better, namely when the comments are moved/updated.

There's a common style that the old comments don't follow, eg. no
capital letter at the beginning, or not using the full line width. There
are also grammar mistakes or spelling typos. It's ok to fix that on the
fly.

The function comments should go to the .c file, not the headers (eg.
btrfs_backref_finish_upper_links, btrfs_backref_add_tree_node,
btrfs_backref_cleanup_node).

When you add something to the end of a header file, please keep an empty
line before the last #endif.

For the static inlines I want to do another round, most of them are
acceptable so I'll look for some clear examples where it's misused. A
quick grep over the code base shows there are many so it would be a
wider cleanup.
