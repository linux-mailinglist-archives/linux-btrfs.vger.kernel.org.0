Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC274E5343
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 14:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242770AbiCWNjc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 09:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241030AbiCWNjb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 09:39:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB115F8D6
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 06:37:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F18BB81F51
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 13:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6B61C340E8;
        Wed, 23 Mar 2022 13:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648042677;
        bh=37XROx/KIHxxCD0k+bMsS4ZhTrfNdoEL3+w18jXfJ4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dQiBgfaZ06CgyKOLxjk3EyZJEeSzNYE/9q9T/95K//tsh8lE/us/uRFv1yTGcB5TY
         7RkslKy983H/eigghi2ZDkEHjkZ1lgPg2NF/Fdh7QxZUSTNczdg3lPLp8+H35KSVLq
         Cjsc8M+P9BV2RShfJ/xRKGdF9DIllFOr0I9w5vVMrrHxnXZzVRbnQn46EAyfMVnRnH
         hWAojQ9rmPMI0BAC/VYEB2Z0Vw35z1C2d+cmwTIovtCy73DFZsUQjT3gv+kJK/11tJ
         FF9+dGTkK1E3wLSWRgDGeTPr2GES4bosPGU9snXS41dfG0tJEhOMXRrXQvnQGWoPIz
         i2J5fdQZRGtXw==
Date:   Wed, 23 Mar 2022 13:37:54 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     Kaiwen Hu <kevinhu@synology.com>
Cc:     quwenruo.btrfs@gmx.com, linux-btrfs@vger.kernel.org,
        dsterba@suse.cz, robbieko@synology.com, cccheng@synology.com,
        seanding@synology.com
Subject: Re: [PATCH v2] btrfs: prevent subvol with swapfile from being deleted
Message-ID: <YjsisrHNWoRyyfCu@debian9.Home>
References: <89f67d6a-2574-0ad0-625c-c921adf3a4f6@gmx.com>
 <20220323071031.1398152-1-kevinhu@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323071031.1398152-1-kevinhu@synology.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 23, 2022 at 03:10:32PM +0800, Kaiwen Hu wrote:
> This patch prevent subvol being deleted when the subvol contains
> any active swapfile.
> 
> Since the subvolume is deleted, we cannot swapoff the swapfile in
> this deleted subvolume.  However, the swapfile is still active,
> we unable to unmount this volume.  Let it into some deadlock
> situation.
> 
> The test looks like this:
> 	mkfs.btrfs -f $dev > /dev/null
> 	mount $dev $mnt
> 
> 	btrfs sub create $mnt/subvol
> 	touch $mnt/subvol/swapfile
> 	chmod 600 $mnt/subvol/swapfile
> 	chattr +C $mnt/subvol/swapfile
> 	dd if=/dev/zero of=$mnt/subvol/swapfile bs=1K count=4096
> 	mkswap $mnt/subvol/swapfile
> 	swapon $mnt/subvol/swapfile
> 
> 	btrfs sub delete $mnt/subvol
> 	swapoff $mnt/subvol/swapfile  // failed: No such file or directory
> 	swapoff --all
> 
> 	unmount $mnt  // target is busy.
> 
> To prevent above issue, we simply check that whether the subvolume
> contains any active swapfile, and stop the deleting process.  This
> behavior is like snapshot ioctl dealing with a swapfile.
> 
> Reviewed-by: Robbie Ko <robbieko@synology.com>
> Signed-off-by: Kaiwen Hu <kevinhu@synology.com>

Looks good.

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Are you planning on sending in a test case for fstests as well?
It's great to have a reproducer in a changelog, but unless it is
turned into a test case for fstests, it doesn't prevent a regression
in the future.

Thanks.

> ---
> 
> Add comment on it.
> 
>  fs/btrfs/inode.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 5bbea5ec31fc..b32def311f44 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -4460,6 +4460,12 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
>  			   dest->root_key.objectid);
>  		return -EPERM;
>  	}
> +	if (atomic_read(&dest->nr_swapfiles)) {
> +		spin_unlock(&dest->root_item_lock);
> +		btrfs_warn(fs_info,
> +			   "attempt to delete subvolume with active swapfile");
> +		return -ETXTBSY;
> +	}
>  	root_flags = btrfs_root_flags(&dest->root_item);
>  	btrfs_set_root_flags(&dest->root_item,
>  			     root_flags | BTRFS_ROOT_SUBVOL_DEAD);
> @@ -10418,8 +10424,22 @@ static int btrfs_swap_activate(struct swap_info_struct *sis, struct file *file,
>  	 * set. We use this counter to prevent snapshots. We must increment it
>  	 * before walking the extents because we don't want a concurrent
>  	 * snapshot to run after we've already checked the extents.
> +	 *
> +	 * It is possible that subvolume is marked for deletion but still not
> +	 * remove yet. To prevent this race, we check the root's mark before
> +	 * activating swapfile.
>  	 */
> +	spin_lock(&root->root_item_lock);
> +	if (btrfs_root_dead(root)) {
> +		spin_unlock(&root->root_item_lock);
> +		btrfs_exclop_finish(fs_info);
> +		btrfs_warn(fs_info,
> +	   "cannot activate swapfile because subvolume is marked for deletion");
> +		return -EINVAL;
> +	}
>  	atomic_inc(&root->nr_swapfiles);
> +	spin_unlock(&root->root_item_lock);
> +
>  
>  	isize = ALIGN_DOWN(inode->i_size, fs_info->sectorsize);
>  
> -- 
> 2.25.1
> 
