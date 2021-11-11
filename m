Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3D244D88B
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 15:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhKKOvg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 09:51:36 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:44888 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbhKKOvf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 09:51:35 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C2B9B21B28;
        Thu, 11 Nov 2021 14:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636642125;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bQBNX5dPAOST3fV0noue7cnAhN4EXxHHClg+qyUKW4w=;
        b=Lcczil4EtYorIEUTAe6zkmPrFe4VMV4egscpNjBlo2uBMJxkhmwhnuyGENhoOtUOpbt3f3
        XtsYC61F0x4Z3/MvKDcnaUDeslUQWRQQe5/0VQUrw6I+0u+M0SqWwgOEcMeGzEzMqFedn+
        uFY17i7IjiyoWYDieYK/j82o3TGXleA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636642125;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bQBNX5dPAOST3fV0noue7cnAhN4EXxHHClg+qyUKW4w=;
        b=Rc0uZAhGWtYRj8YuYrTFCU0R6JaNeWvgtzKv7ToUpDFBLqlzW+N3nWD0U5qED9MT60OU/u
        qayPrKgmnvN1NtBA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BBB71A3B93;
        Thu, 11 Nov 2021 14:48:45 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 1D1ECDA799; Thu, 11 Nov 2021 15:48:44 +0100 (CET)
Date:   Thu, 11 Nov 2021 15:48:44 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/3] btrfs: introduce BTRFS_EXCLOP_BALANCE_PAUSED
 exclusive state
Message-ID: <20211111144844.GD28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20211108142820.1003187-1-nborisov@suse.com>
 <20211108142820.1003187-2-nborisov@suse.com>
 <ec5447a6-b9bc-17ac-11a7-4fc14e1c6a82@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec5447a6-b9bc-17ac-11a7-4fc14e1c6a82@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 09, 2021 at 07:35:40PM +0800, Anand Jain wrote:
> On 8/11/21 10:28 pm, Nikolay Borisov wrote:
> > Current set of exclusive operation states is not sufficient to handle all
> > practical use cases. In particular there is a need to be able to add a
> > device to a filesystem that have paused balance. Currently there is no
> > way to distinguish between a running and a paused balance. Fix this by
> > introducing BTRFS_EXCLOP_BALANCE_PAUSED which is going to be set in 2
> > occasions:
> > 
> > 1. When a filesystem is mounted with skip_balance and there is an
> >     unfinished balance it will now be into BALANCE_PAUSED instead of
> >     simply BALANCE state.
> > 
> > 2. When a running balance is paused.
> > 
> > Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> > ---
> >   fs/btrfs/ctree.h   |  3 +++
> >   fs/btrfs/ioctl.c   | 13 +++++++++++++
> >   fs/btrfs/volumes.c | 11 +++++++++--
> >   3 files changed, 25 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index 7553e9dc5f93..8376271bfed1 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -613,6 +613,7 @@ enum {
> >    */
> >   enum btrfs_exclusive_operation {
> >   	BTRFS_EXCLOP_NONE,
> > +	BTRFS_EXCLOP_BALANCE_PAUSED,
> >   	BTRFS_EXCLOP_BALANCE,
> >   	BTRFS_EXCLOP_DEV_ADD,
> >   	BTRFS_EXCLOP_DEV_REMOVE,
> > @@ -3305,6 +3306,8 @@ bool btrfs_exclop_start_try_lock(struct btrfs_fs_info *fs_info,
> >   				 enum btrfs_exclusive_operation type);
> >   void btrfs_exclop_start_unlock(struct btrfs_fs_info *fs_info);
> >   void btrfs_exclop_finish(struct btrfs_fs_info *fs_info);
> > +void btrfs_exclop_pause_balance(struct btrfs_fs_info *fs_info);
> > +
> >   
> >   /* file.c */
> >   int __init btrfs_auto_defrag_init(void);
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index 92424a22d8d6..f4c05a9aab84 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -414,6 +414,15 @@ void btrfs_exclop_finish(struct btrfs_fs_info *fs_info)
> >   	sysfs_notify(&fs_info->fs_devices->fsid_kobj, NULL, "exclusive_operation");
> >   }
> > 
> 
> 
> 
> > +void btrfs_exclop_pause_balance(struct btrfs_fs_info *fs_info)
> > +{
> > +	spin_lock(&fs_info->super_lock);
> > +	ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE ||
> > +	       fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD);
> > +	fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE_PAUSED;
> > +	spin_unlock(&fs_info->super_lock);
> > +}
> > +
> 
> This function can be more generic and replace its open coded version
> in a few places.
> 
>   btrfs_exclop_balance(fs_info, exclop)
>   {
> ::
> 	switch(exclop)
> 	{
> 		case BTRFS_EXCLOP_BALANCE_PAUSED:
> 	  		ASSERT(fs_info->exclusive_operation ==
> 				BTRFS_EXCLOP_BALANCE ||
>                   		fs_info->exclusive_operation ==
> 				BTRFS_EXCLOP_DEV_ADD);
> 			break;
> 		case BTRFS_EXCLOP_BALANCE:
> 			ASSERT(fs_info->exclusive_operation ==
> 				BTRFS_EXCLOP_BALANCE_PAUSED);
> 			break;
> 	}
> ::
>   }

I don't see this comment answered, I think it's a good point to do the
exclusive state change and assertions in the helper, there's too much
code repetition.
