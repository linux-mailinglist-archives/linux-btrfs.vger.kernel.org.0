Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1770B131753
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2020 19:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgAFSPi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 6 Jan 2020 13:15:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:50786 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgAFSPi (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 6 Jan 2020 13:15:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 206AFAFC2;
        Mon,  6 Jan 2020 18:15:36 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 73671DA78B; Mon,  6 Jan 2020 19:15:26 +0100 (CET)
Date:   Mon, 6 Jan 2020 19:15:25 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH] btrfs: relocation: Fix KASAN reports caused by extended
 reloc tree lifespan
Message-ID: <20200106181525.GR3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.com>
References: <20200104135602.34601-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200104135602.34601-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 04, 2020 at 09:56:02PM +0800, Qu Wenruo wrote:
>  }
>  
> +/*
> + * Check if this subvolume tree has valid reloc(*) tree.
> + *
> + * *: Reloc tree after swap is considered dead, thus not considered as valid.
> + *    This is enough for most callers, as they don't distinguish dead reloc
> + *    root from no reloc root.
> + *    But should_ignore_root() below is a special case.
> + */
> +static bool have_reloc_root(struct btrfs_root *root)
> +{
> +	smp_mb__before_atomic();

That one should be the easiest, to get an up to date value of the bit,
sync before reading it. Similar to smp_rmb.

> +	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
> +		return false;
> +	if (!root->reloc_root)
> +		return false;
> +	return true;
> +}
>  
>  static int should_ignore_root(struct btrfs_root *root)
>  {
> @@ -525,6 +542,11 @@ static int should_ignore_root(struct btrfs_root *root)
>  	if (!test_bit(BTRFS_ROOT_REF_COWS, &root->state))
>  		return 0;
>  
> +	/* This root has been merged with its reloc tree, we can ignore it */
> +	smp_mb__before_atomic();

This could be replaced by have_reloc_root but the reloc_root has to be
check twice in that function. Here it was slightly optimized as it
partially opencodes have_reloc_root. For clarity and fewer standalone
barriers using the helper might be better.

> +	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
> +		return 1;
> +
>  	reloc_root = root->reloc_root;
>  	if (!reloc_root)
>  		return 0;
> @@ -1439,6 +1461,7 @@ int btrfs_init_reloc_root(struct btrfs_trans_handle *trans,
>  	 * The subvolume has reloc tree but the swap is finished, no need to
>  	 * create/update the dead reloc tree
>  	 */
> +	smp_mb__before_atomic();

Another partial have_reloc_root, could be used here as well with
additional reloc_tree check.

>  	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state))
>  		return 0;
>  
> @@ -1478,8 +1501,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
>  	struct btrfs_root_item *root_item;
>  	int ret;
>  
> -	if (test_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state) ||
> -	    !root->reloc_root)
> +	if (!have_reloc_root(root))
>  		goto out;
>  
>  	reloc_root = root->reloc_root;
> @@ -1489,6 +1511,7 @@ int btrfs_update_reloc_root(struct btrfs_trans_handle *trans,
>  	if (fs_info->reloc_ctl->merge_reloc_tree &&
>  	    btrfs_root_refs(root_item) == 0) {
>  		set_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);

First set the bit, so anybody who properly uses barriers before checking
the bit will see it set

> +		smp_mb__after_atomic();

since the reloc_root pointer is not safe to be accessed since this point

>  		__del_reloc_root(reloc_root);
>  	}
>  
> @@ -2202,6 +2225,7 @@ static int clean_dirty_subvols(struct reloc_control *rc)
>  					ret = ret2;
>  			}
>  			clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);

This one looks misplaced and reverse, root->reloc_root is set to NULL a
few lines before and the barrier must be between this and clear_bit.
This was not in my proposed version, why did you change that?



> +			smp_mb__after_atomic();
>  			btrfs_put_fs_root(root);
>  		} else {
>  			/* Orphan reloc tree, just clean it up */
> @@ -4717,7 +4741,7 @@ void btrfs_reloc_pre_snapshot(struct btrfs_pending_snapshot *pending,
>  	struct btrfs_root *root = pending->root;
>  	struct reloc_control *rc = root->fs_info->reloc_ctl;
>  
> -	if (!root->reloc_root || !rc)
> +	if (!rc || !have_reloc_root(root))
>  		return;
>  
>  	if (!rc->merge_reloc_tree)
> @@ -4751,7 +4775,7 @@ int btrfs_reloc_post_snapshot(struct btrfs_trans_handle *trans,
>  	struct reloc_control *rc = root->fs_info->reloc_ctl;
>  	int ret;
>  
> -	if (!root->reloc_root || !rc)
> +	if (!rc || !have_reloc_root(root))
>  		return 0;
>  
>  	rc = root->fs_info->reloc_ctl;
> -- 
> 2.24.1
