Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418263C2914
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 20:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbhGISkI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 14:40:08 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:49446 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGISkH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jul 2021 14:40:07 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3C08D1FD8E;
        Fri,  9 Jul 2021 18:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625855843;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KsBvv02jr3TQ9Zw29dB9L0MwUhWXqGfSVKfar+C4eIg=;
        b=Zdgf2BBmFC36t8iBiH84+Ec4ui3pxktAdDTbsnJeqeZyFKUiGq7in2G6H/MyHWV0C/jY22
        4V2sXUt6XENH4YaVcFtZczzcPIjyMk9JXWB8ogltSNwasZE4bvD8j3nbkltgAnO9UtC1Di
        jK0meYzqS8Kqfgt59zz1m9v/g2tztig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625855843;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KsBvv02jr3TQ9Zw29dB9L0MwUhWXqGfSVKfar+C4eIg=;
        b=X5X/yr9joMrwczoRW9D7ZP0DAmG67kro5M5r3lSjT+z6wWjT5+rhugl8X0iyA5e2L/ii4r
        6rs3i6MSZHP0aaDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 339E5A3B9C;
        Fri,  9 Jul 2021 18:37:23 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5BDD6DA8E2; Fri,  9 Jul 2021 20:34:48 +0200 (CEST)
Date:   Fri, 9 Jul 2021 20:34:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v6 10/15] btrfs: reject raid5/6 fs for subpage
Message-ID: <20210709183448.GG2610@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210705020110.89358-1-wqu@suse.com>
 <20210705020110.89358-11-wqu@suse.com>
 <67de8d93-6add-6094-05c6-ae200461ed79@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67de8d93-6add-6094-05c6-ae200461ed79@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 09, 2021 at 05:36:22PM +0800, Anand Jain wrote:
> On 5/7/21 10:01 am, Qu Wenruo wrote:
> > Raid5/6 is not only unsafe due to its write-hole problem, but also has
> > tons of hardcoded PAGE_SIZE.
> > 
> > So disable it for subpage support for now.
> > 
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> >   fs/btrfs/disk-io.c | 10 ++++++++++
> >   fs/btrfs/volumes.c |  8 ++++++++
> >   2 files changed, 18 insertions(+)
> > 
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index b117dd3b8172..3de8e86f3170 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
> > @@ -3402,6 +3402,16 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
> >   			goto fail_alloc;
> >   		}
> >   	}
> > +	if (sectorsize != PAGE_SIZE) {
> > +		if (btrfs_super_incompat_flags(fs_info->super_copy) &
> > +			BTRFS_FEATURE_INCOMPAT_RAID56) {
> > +			btrfs_err(fs_info,
> > +	"raid5/6 is not yet supported for sector size %u with page size %lu",
> > +				sectorsize, PAGE_SIZE);
> > +			err = -EINVAL;
> > +			goto fail_alloc;
> > +		}
> > +	}
> >   
> >   	ret = btrfs_init_workqueues(fs_info, fs_devices);
> >   	if (ret) {
> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 782e16795bc4..3cd876c49446 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -3937,11 +3937,19 @@ static inline int validate_convert_profile(struct btrfs_fs_info *fs_info,
> >   	if (!(bargs->flags & BTRFS_BALANCE_ARGS_CONVERT))
> >   		return true;
> >   
> > +	if (fs_info->sectorsize < PAGE_SIZE &&
> > +		bargs->target & BTRFS_BLOCK_GROUP_RAID56_MASK) {
> > +		btrfs_err(fs_info,
> > +	"RAID5/6 is not supported yet for sectorsize %u with page size %lu",
> > +			  fs_info->sectorsize, PAGE_SIZE);
> > +		goto invalid;
> 
> Just
>   return false;
> is fine.
> 
> The above btrfs_err() will suffice. We don't need additional btrfs_err() 
> at the label invalid.

Agreed, this is the pattern with several checks and any of them can fail
in place as tehre's no common cleanup at the end of the function.
