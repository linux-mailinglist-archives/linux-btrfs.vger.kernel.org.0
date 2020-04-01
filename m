Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 121DB19AF03
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Apr 2020 17:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733033AbgDAPs4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Apr 2020 11:48:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:44484 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbgDAPs4 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 1 Apr 2020 11:48:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A9E7EAC46;
        Wed,  1 Apr 2020 15:48:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id E6854DA727; Wed,  1 Apr 2020 17:48:20 +0200 (CEST)
Date:   Wed, 1 Apr 2020 17:48:20 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 17/39] btrfs: Rename tree_entry to simple_node and
 export it
Message-ID: <20200401154820.GT5920@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20200326083316.48847-1-wqu@suse.com>
 <20200326083316.48847-18-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326083316.48847-18-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 26, 2020 at 04:32:54PM +0800, Qu Wenruo wrote:
> Structure tree_entry provides a very simple rb_tree which only uses
> bytenr as search index.
> 
> That tree_entry is used in 3 structures: backref_node, mapping_node and
> tree_block.
> 
> Since we're going to make backref_node independnt from relocation, it's
> a good time to extract the tree_entry into simple_node, and export it
> into misc.h.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/backref.h    |   6 ++-
>  fs/btrfs/misc.h       |  54 +++++++++++++++++++++
>  fs/btrfs/relocation.c | 109 +++++++++++++-----------------------------
>  3 files changed, 90 insertions(+), 79 deletions(-)
> 
> diff --git a/fs/btrfs/backref.h b/fs/btrfs/backref.h
> index 76858ec099d9..f3eae9e9f84b 100644
> --- a/fs/btrfs/backref.h
> +++ b/fs/btrfs/backref.h
> @@ -162,8 +162,10 @@ btrfs_backref_iter_release(struct btrfs_backref_iter *iter)
>   * present a tree block in the backref cache
>   */
>  struct btrfs_backref_node {
> -	struct rb_node rb_node;
> -	u64 bytenr;
> +	struct {
> +		struct rb_node rb_node;
> +		u64 bytenr;
> +	}; /* Use simple_node for search/insert */

Why is this anonymous struct? This should be the simple_node as I see
below. For some simple rb search API.

>  
>  	u64 new_bytenr;
>  	/* objectid of tree block owner, can be not uptodate */
> diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
> index 72bab64ecf60..d199bfdb210e 100644
> --- a/fs/btrfs/misc.h
> +++ b/fs/btrfs/misc.h
> @@ -6,6 +6,7 @@
>  #include <linux/sched.h>
>  #include <linux/wait.h>
>  #include <asm/div64.h>
> +#include <linux/rbtree.h>
>  
>  #define in_range(b, first, len) ((b) >= (first) && (b) < (first) + (len))
>  
> @@ -58,4 +59,57 @@ static inline bool has_single_bit_set(u64 n)
>  	return is_power_of_two_u64(n);
>  }
>  
> +/*
> + * Simple bytenr based rb_tree relate structures
> + *
> + * Any structure wants to use bytenr as single search index should have their
> + * structure start with these members.

This is not very clean coding style, relying on particular placement and
order in another struct.

> + */
> +struct simple_node {
> +	struct rb_node rb_node;
> +	u64 bytenr;
> +};
> +
> +static inline struct rb_node *simple_search(struct rb_root *root, u64 bytenr)

simple_search is IMHO too vague, it's related to a rb-tree so this could
be reflected in the name somehow.

I think it's ok if you do this as a middle step before making it a
proper struct hook and API but I don't like the end result as it's not
really an improvement.
