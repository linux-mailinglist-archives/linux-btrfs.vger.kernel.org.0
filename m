Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE624E5328
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 14:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238875AbiCWNez (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Mar 2022 09:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244305AbiCWNey (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Mar 2022 09:34:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179231F616
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 06:33:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5D51B81F16
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Mar 2022 13:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8E3C340E9;
        Wed, 23 Mar 2022 13:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648042398;
        bh=nH9b93/vHGzeNIq86T3S4Az1yhVVWu4TQlQAAkeEPJw=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=kHZRxaxvWtrlbgevW6oWzFjaAnzSEQZFeGrJ6QGM/jXwY5NEsFGcGbVwVEzyCnYvf
         MSEDms2Q29GypF8Pp3tecpiRadI4yGX5yf8kQEz5mcpF71cOYPC9JojBTDAxtZ87B9
         AZ0KZfepx1g/KwhOu5IQ6tMZpHQSzBAzlPZ+OYPGTI5Z5vICX4rjcmMBqwn+0mh7AM
         rZcuBmSOKeAMy4FjhXUXotVVzdnaF0IEoYY8oBu9b/m6YDmTc0eBGHGEItMy5HpKQg
         B3T0sLcyK+aBWz5T7gO8qJLA9aC24p8aCWqc+h9Sjkr8OY6o+xaaalB47HjE1fUCXQ
         xN/7cGzSKnuOA==
Date:   Wed, 23 Mar 2022 13:33:10 +0000
From:   Filipe Manana <fdmanana@kernel.org>
To:     dsterba@suse.cz, Kaiwen Hu <kevinhu@synology.com>,
        quwenruo.btrfs@gmx.com, linux-btrfs@vger.kernel.org,
        robbieko@synology.com, cccheng@synology.com, seanding@synology.com
Subject: Re: [PATCH v2] btrfs: prevent subvol with swapfile from being deleted
Message-ID: <YjshlpsQxGnxZVwX@debian9.Home>
References: <89f67d6a-2574-0ad0-625c-c921adf3a4f6@gmx.com>
 <20220323071031.1398152-1-kevinhu@synology.com>
 <20220323123429.GK12643@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323123429.GK12643@twin.jikos.cz>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 23, 2022 at 01:34:29PM +0100, David Sterba wrote:
> On Wed, Mar 23, 2022 at 03:10:32PM +0800, Kaiwen Hu wrote:
> > This patch prevent subvol being deleted when the subvol contains
> > any active swapfile.
> > 
> > Since the subvolume is deleted, we cannot swapoff the swapfile in
> > this deleted subvolume.  However, the swapfile is still active,
> > we unable to unmount this volume.  Let it into some deadlock
> > situation.
> > 
> > The test looks like this:
> > 	mkfs.btrfs -f $dev > /dev/null
> > 	mount $dev $mnt
> > 
> > 	btrfs sub create $mnt/subvol
> > 	touch $mnt/subvol/swapfile
> > 	chmod 600 $mnt/subvol/swapfile
> > 	chattr +C $mnt/subvol/swapfile
> > 	dd if=/dev/zero of=$mnt/subvol/swapfile bs=1K count=4096
> > 	mkswap $mnt/subvol/swapfile
> > 	swapon $mnt/subvol/swapfile
> > 
> > 	btrfs sub delete $mnt/subvol
> > 	swapoff $mnt/subvol/swapfile  // failed: No such file or directory
> > 	swapoff --all
> > 
> > 	unmount $mnt  // target is busy.
> > 
> > To prevent above issue, we simply check that whether the subvolume
> > contains any active swapfile, and stop the deleting process.  This
> > behavior is like snapshot ioctl dealing with a swapfile.
> > 
> > Reviewed-by: Robbie Ko <robbieko@synology.com>
> > Signed-off-by: Kaiwen Hu <kevinhu@synology.com>
> > ---
> > 
> > Add comment on it.
> > 
> >  fs/btrfs/inode.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 5bbea5ec31fc..b32def311f44 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -4460,6 +4460,12 @@ int btrfs_delete_subvolume(struct inode *dir, struct dentry *dentry)
> >  			   dest->root_key.objectid);
> >  		return -EPERM;
> >  	}
> > +	if (atomic_read(&dest->nr_swapfiles)) {
> 
> This is under the root_item_lock and the increment in
> btrfs_swap_activate as well, but reading and decrementing nr_swapfiles
> is not, so this is inconsistent. It may not be wrong although still
> racy. The case where I think it could be racing is:
> 
>                                              btrfs_swap_activate
> create_snapshot
>   atomic_read(&root->nr_swapfiles)
>     <continue snapshot>
>                                                atomic_inc(&root->nr_swapfiles)
> 					       <activate swapfile>
> 
> and this patch would not prevent it.

That race can not happen due to the protection of the snapshot lock.
In fact that race used to exist, but it was fixed last year by
commit dd0734f2a866f9 ("btrfs: fix race between swap file activation and snapshot creation").

 
> If it turns out that the root_item_lock is necessary then it would also
> make sense to switch the type of nr_swapfiles to a plain int if we don't
> use the semantics of atomic_t.
