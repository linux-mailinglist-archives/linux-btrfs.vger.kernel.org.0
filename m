Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2B84E5252
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 13:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242760AbiCWMkD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 08:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242773AbiCWMkC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 08:40:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6726028997
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 05:38:33 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 269BB1F387;
        Wed, 23 Mar 2022 12:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648039112;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=REUYTxiGOV1MzFN7V3kyZFelG0MsAVlRSbDtJBBbaKM=;
        b=CSdMCbHFK7rwCgGfXB+8V2yUm6xutE9ec+Br8+r0CbeHLcqIdz44uUUlKAnN6UiIuzPNLL
        jfXoB8EY68wgwx5/xlfPKoOcKptLCDIlBP56CoLDZGzt3HfgC4K/z8W5OMExoovyL7TcNq
        771gPeVDxkYJXy+FdfZ7eB+FwRFKHrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648039112;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=REUYTxiGOV1MzFN7V3kyZFelG0MsAVlRSbDtJBBbaKM=;
        b=IPFNatnEnHyMp7J6u8YCWaSG7RkUnw7yz7g4Ucf01jkxEWkA3pW8sT4CGn5UpEhyY/Woh5
        NblzlN3YPsJuDfBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 1CBDFA3B81;
        Wed, 23 Mar 2022 12:38:32 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 48152DA7FB; Wed, 23 Mar 2022 13:34:29 +0100 (CET)
Date:   Wed, 23 Mar 2022 13:34:29 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Kaiwen Hu <kevinhu@synology.com>
Cc:     quwenruo.btrfs@gmx.com, linux-btrfs@vger.kernel.org,
        dsterba@suse.cz, robbieko@synology.com, cccheng@synology.com,
        seanding@synology.com
Subject: Re: [PATCH v2] btrfs: prevent subvol with swapfile from being deleted
Message-ID: <20220323123429.GK12643@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Kaiwen Hu <kevinhu@synology.com>,
        quwenruo.btrfs@gmx.com, linux-btrfs@vger.kernel.org,
        robbieko@synology.com, cccheng@synology.com, seanding@synology.com
References: <89f67d6a-2574-0ad0-625c-c921adf3a4f6@gmx.com>
 <20220323071031.1398152-1-kevinhu@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323071031.1398152-1-kevinhu@synology.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

This is under the root_item_lock and the increment in
btrfs_swap_activate as well, but reading and decrementing nr_swapfiles
is not, so this is inconsistent. It may not be wrong although still
racy. The case where I think it could be racing is:

                                             btrfs_swap_activate
create_snapshot
  atomic_read(&root->nr_swapfiles)
    <continue snapshot>
                                               atomic_inc(&root->nr_swapfiles)
					       <activate swapfile>

and this patch would not prevent it.

If it turns out that the root_item_lock is necessary then it would also
make sense to switch the type of nr_swapfiles to a plain int if we don't
use the semantics of atomic_t.
