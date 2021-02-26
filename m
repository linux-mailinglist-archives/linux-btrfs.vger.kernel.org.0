Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A822326735
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Feb 2021 20:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhBZTGP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Feb 2021 14:06:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:38054 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230188AbhBZTGM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Feb 2021 14:06:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CB0E5AD5C;
        Fri, 26 Feb 2021 19:05:30 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 69F61DA7FF; Fri, 26 Feb 2021 20:03:37 +0100 (CET)
Date:   Fri, 26 Feb 2021 20:03:37 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v7 02/38] btrfs: return an error from
 btrfs_record_root_in_trans
Message-ID: <20210226190337.GQ7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        Qu Wenruo <wqu@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1608135849.git.josef@toxicpanda.com>
 <0b7c322b530735e98a2c6e9db4fc024c9e137546.1608135849.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b7c322b530735e98a2c6e9db4fc024c9e137546.1608135849.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 16, 2020 at 11:26:18AM -0500, Josef Bacik wrote:
> We can create a reloc root when we record the root in the trans, which
> can fail for all sorts of different reasons.  Propagate this error up
> the chain of callers.  Future patches will fix the callers of
> btrfs_record_root_in_trans() to handle the error.
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/transaction.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index f51f9e39bcee..eba48578159e 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -400,6 +400,7 @@ static int record_root_in_trans(struct btrfs_trans_handle *trans,
>  			       int force)
>  {
>  	struct btrfs_fs_info *fs_info = root->fs_info;
> +	int ret = 0;
>  
>  	if ((test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
>  	    root->last_trans < trans->transid) || force) {
> @@ -448,11 +449,11 @@ static int record_root_in_trans(struct btrfs_trans_handle *trans,
>  		 * lock.  smp_wmb() makes sure that all the writes above are
>  		 * done before we pop in the zero below
>  		 */
> -		btrfs_init_reloc_root(trans, root);
> +		ret = btrfs_init_reloc_root(trans, root);

This is patch 2 from the series and got me curious if it's ok to add the
error value check here, because that would mean that the whole callgraph
from btrfs_init_reloc_root is also error handling clean (ie. no
BUG_ONs).

And it's not until patch 19.

btrfs_init_reloc_root
  create_reloc_root
    kmalloc + BUG_ON
    btrfs_copy_root + BUG_ON, twice
    btrfs_insert_root + BUG_ON
    btrfs_read_tree_root + BUG_ON
  __add_reloc_root
    ...

All the patches in between add handling the record_root_in_trans errors,
which is fine as end result, but the proper error handling needs to be
pushed upwards from all leaf functions. That way it's cleaner and an
understandable pattern as we can review one step in the callgraph,
assuming that the calless are OK.

After reading the whole patchset it looks like the end result is more
or less what it should be but it's not a sequence of reviewable steps
patch-to-patch.

So it's patch ordering and maybe some context fixups, where the leaf
functions are BUG_ON-free and then all individual callers are updated.

Roughly in that order:

- __add_reloc_root
- create_reloc_root
- btrfs_init_reloc_root
- record_root_in_trans
- select_reloc_root

>  		smp_mb__before_atomic();
>  		clear_bit(BTRFS_ROOT_IN_TRANS_SETUP, &root->state);
>  	}
> -	return 0;
> +	return ret;
>  }
>  
>  
> -- 
> 2.26.2
