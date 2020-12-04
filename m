Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2C72CF26D
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Dec 2020 17:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731002AbgLDQyd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Dec 2020 11:54:33 -0500
Received: from mx2.suse.de ([195.135.220.15]:58512 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgLDQyd (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Dec 2020 11:54:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9A595ACC3;
        Fri,  4 Dec 2020 16:53:51 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 045ACDA7E3; Fri,  4 Dec 2020 17:52:17 +0100 (CET)
Date:   Fri, 4 Dec 2020 17:52:17 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: fix error handling in commit_fs_roots
Message-ID: <20201204165217.GV6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <29f468ffe7b19dbebae2201f10307ec4f34f1c88.1606834393.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29f468ffe7b19dbebae2201f10307ec4f34f1c88.1606834393.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 01, 2020 at 09:53:23AM -0500, Josef Bacik wrote:
> While doing error injection I would sometimes get a corrupt file system.
> This is because I was injecting errors at btrfs_search_slot, but would
> only do it one time per stack.  This uncovered a problem in
> commit_fs_roots, where if we get an error we would just break.  However
> we're in a second loop, the first loop being a loop to find all the
> dirty fs roots, and then subsequent root updates would succeed clearing
> the error value.
> 
> This isn't likely to happen in real scenarios, however we could
> potentially get a random ENOMEM once and then not again, and we'd end up
> with a corrupted file system.  Fix this by moving the error checking
> around a bit to the main loop, as this is the only place where something
> will fail, and return the error as soon as it occurs.
> 
> With this patch my reproducer no longer corrupts the file system.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/transaction.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 1dac76b7ea96..b05f75654b16 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1328,7 +1328,6 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
>  	struct btrfs_root *gang[8];
>  	int i;
>  	int ret;
> -	int err = 0;
>  
>  	spin_lock(&fs_info->fs_roots_radix_lock);
>  	while (1) {
> @@ -1340,6 +1339,8 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
>  			break;
>  		for (i = 0; i < ret; i++) {
>  			struct btrfs_root *root = gang[i];
> +			int err;

I'd rather get rid of 'err' for the return values, in this case we can
reuse 'ret'.

> +
>  			radix_tree_tag_clear(&fs_info->fs_roots_radix,
>  					(unsigned long)root->root_key.objectid,
>  					BTRFS_ROOT_TRANS_TAG);
> @@ -1366,14 +1367,14 @@ static noinline int commit_fs_roots(struct btrfs_trans_handle *trans)
>  			err = btrfs_update_root(trans, fs_info->tree_root,
>  						&root->root_key,
>  						&root->root_item);
> -			spin_lock(&fs_info->fs_roots_radix_lock);
>  			if (err)
> -				break;
> +				return err;
> +			spin_lock(&fs_info->fs_roots_radix_lock);
>  			btrfs_qgroup_free_meta_all_pertrans(root);

Do we need to call btrfs_qgroup_free_meta_all_pertrans before returning?

>  		}
>  	}
>  	spin_unlock(&fs_info->fs_roots_radix_lock);
> -	return err;
> +	return 0;
>  }
>  
>  /*
> -- 
> 2.26.2
