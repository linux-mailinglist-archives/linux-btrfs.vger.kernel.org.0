Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6F719DA74
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Apr 2020 17:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgDCPpU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Apr 2020 11:45:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:46076 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727998AbgDCPpU (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 3 Apr 2020 11:45:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D8F88ABF4;
        Fri,  3 Apr 2020 15:45:17 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 82236DA727; Fri,  3 Apr 2020 17:44:43 +0200 (CEST)
Date:   Fri, 3 Apr 2020 17:44:43 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/39] btrfs: qgroup: Use backref cache based backref
 walk for commit roots
Message-ID: <20200403154443.GE5920@twin.jikos.cz>
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

Patches 1-32 are in misc-next.
