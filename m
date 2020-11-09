Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BC62AC165
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Nov 2020 17:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730580AbgKIQwP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Nov 2020 11:52:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:50246 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730130AbgKIQwN (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 9 Nov 2020 11:52:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BD22AAB95;
        Mon,  9 Nov 2020 16:52:11 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C103BDA7D7; Mon,  9 Nov 2020 17:50:30 +0100 (CET)
Date:   Mon, 9 Nov 2020 17:50:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 00/14][REBASED] Set the lockdep class on eb's at
 allocation time
Message-ID: <20201109165030.GY6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1604591048.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1604591048.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Nov 05, 2020 at 10:45:07AM -0500, Josef Bacik wrote:
> We've had a lockdep splat show up a few times recently where the extent buffer
> doesn't have it's lockdep class set properly.  This can happen if you have
> concurrent readers hitting the same block that's not in cache.
> 
> This is sort of straightforward to fix, but unfortunately requires quite a bit
> of code churn to do it cleanly.  The bulck of these patches are replacing open
> coded calls of btrfs_read_node_slot() with the helper to cut down on the number
> of people directly calling read_tree_block().  I also cleaned up the readahead
> helpers because passing all these arguments around would be unweildy.  The last
> patch in the series is the actual fix for what Filipe and Fedora QA saw.
> 
> The patches that actually have meaningful changes are
> 
>   btrfs: remove lockdep classes for the fs tree
>   btrfs: cleanup extent buffer readahead
>   btrfs: set the lockdep class for ebs on creation
> 
> The rest are cleanups or adding arguments to various functions, so aren't too
> tricky.  I've put this through a quick xfstest run for sanity sake, it didn't
> appear to break anything, but the full run is still going.  Thanks,
> 
> Josef
> 
> Josef Bacik (14):
>   btrfs: remove lockdep classes for the fs tree
>   btrfs: cleanup extent buffer readahead
>   btrfs: use btrfs_read_node_slot in btrfs_realloc_node
>   btrfs: use btrfs_read_node_slot in walk_down_reloc_tree
>   btrfs: use btrfs_read_node_slot in do_relocation
>   btrfs: use btrfs_read_node_slot in replace_path
>   btrfs: use btrfs_read_node_slot in walk_down_tree
>   btrfs: use btrfs_read_node_slot in qgroup_trace_extent_swap
>   btrfs: use btrfs_read_node_slot in qgroup_trace_new_subtree_blocks
>   btrfs: use btrfs_read_node_slot in btrfs_qgroup_trace_subtree
>   btrfs: pass root owner to read_tree_block
>   btrfs: pass the root owner and level around for reada
>   btrfs: pass the owner_root and level to alloc_extent_buffer
>   btrfs: set the lockdep class for ebs on creation

Added to misc-next, thanks.
