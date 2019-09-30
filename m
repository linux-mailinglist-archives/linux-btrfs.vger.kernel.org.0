Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1443BC2860
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Sep 2019 23:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbfI3VNv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Sep 2019 17:13:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:49928 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732098AbfI3VNu (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Sep 2019 17:13:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 78478ADCF;
        Mon, 30 Sep 2019 17:51:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AE831DA88C; Mon, 30 Sep 2019 19:51:59 +0200 (CEST)
Date:   Mon, 30 Sep 2019 19:51:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: relocation: Hunt down BUG_ON() in
 merge_reloc_roots()
Message-ID: <20190930175159.GB2751@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20190926063545.20403-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190926063545.20403-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 26, 2019 at 02:35:45PM +0800, Qu Wenruo wrote:
> [BUG]
> There is one BUG_ON() report where a transaction is aborted during
> balance, then kernel BUG_ON() in merge_reloc_roots():

Do you have details from the report, eg. what's the error code?

>   void merge_reloc_roots(struct reloc_control *rc)
>   {
> 	...
> 	BUG_ON(!RB_EMPTY_ROOT(&rc->reloc_root_tree.rb_root)); <<<
>   }
> 
> [CAUSE]
> It's still uncertain why we can get to such situation.
> As all __add_reloc_root() calls will also link that reloc root to
> rc->reloc_roots, and in merge_reloc_roots() we cleanup rc->reloc_roots.
> 
> So the root cause is still uncertain.
> 
> [FIX]
> But we can still hunt down all the BUG_ON() in merge_reloc_roots().
> 
> There are 3 BUG_ON()s in it:
> - BUG_ON() for read_fs_root() result
> - BUG_ON() for root->reloc_root != reloc_root case
> - BUG_ON() for the non-empty reloc_root_tree

relocation.c is worst regarding number of BUG_ONs, some of them look
like runtime assertions of the invariants but some of them are
substituting for error handling.

The first one BUG_ON(IS_ERR(root)); is clearly the latter, the other are
assertions

> 
> For the first two, just grab the return value and goto out tag for
> cleanup.
> 
> For the last one, make it more graceful by:
> - grab the lock before doing read/write
> - warn instead of panic
> - cleanup the nodes in rc->reloc_root_tree
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Reason for RFC:
> The root cause to leak nodes in reloc_root_tree is still unknown.
> ---
>  fs/btrfs/relocation.c | 39 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 655f1d5a8c27..d562b5c52a40 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -2484,11 +2484,26 @@ void merge_reloc_roots(struct reloc_control *rc)
>  		if (btrfs_root_refs(&reloc_root->root_item) > 0) {
>  			root = read_fs_root(fs_info,
>  					    reloc_root->root_key.offset);
> -			BUG_ON(IS_ERR(root));
> -			BUG_ON(root->reloc_root != reloc_root);
> +			if (IS_ERR(root)) {

This is bug_on -> error handling, ok

> +				ret = PTR_ERR(root);
> +				btrfs_err(fs_info,
> +					  "failed to read root %llu: %d",
> +					  reloc_root->root_key.offset, ret);
> +				goto out;
> +			}
> +			if (root->reloc_root != reloc_root) {

With this one I'm not sure it could happen but replacing the bug on is
still good.

> +				btrfs_err(fs_info,
> +					"reloc root mismatch for root %llu",

Would be good to print the number of the other root as well.

> +					root->root_key.objectid);
> +				ret = -EINVAL;
> +				goto out;
> +			}
>  
>  			ret = merge_reloc_root(rc, root);
>  			if (ret) {
> +				btrfs_err(fs_info,
> +			"failed to merge reloc tree for root %llu: %d",
> +					  root->root_key.objectid, ret);
>  				if (list_empty(&reloc_root->root_list))
>  					list_add_tail(&reloc_root->root_list,
>  						      &reloc_roots);
> @@ -2520,7 +2535,25 @@ void merge_reloc_roots(struct reloc_control *rc)
>  			free_reloc_roots(&reloc_roots);
>  	}
>  
> -	BUG_ON(!RB_EMPTY_ROOT(&rc->reloc_root_tree.rb_root));

This one looks more like the invariant, the tree should be really empty
here. While the cleanup is trying to make things work despite there's a
problem, I think the warning should not be debugging only.

> +	spin_lock(&rc->reloc_root_tree.lock);
> +	/* Cleanup dirty reloc tree nodes */
> +	if (!RB_EMPTY_ROOT(&rc->reloc_root_tree.rb_root)) {
> +		struct mapping_node *node;
> +		struct mapping_node *next;
> +
> +		WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));

...
