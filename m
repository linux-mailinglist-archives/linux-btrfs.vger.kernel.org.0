Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E0244D8CB
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 16:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhKKPDN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 10:03:13 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46248 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbhKKPDJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 10:03:09 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E34BA21B29;
        Thu, 11 Nov 2021 15:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636642819;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C4LGMG5POWX95fsNF9WFMLcvn5fSTvYVGGyDWrfZxxc=;
        b=ZzR0HXTdCWmfHk5wSwFvOTMVXORejtPeatxfYIAEqmnZJ9FcT64LP0rV0EnDo727ax4gOu
        ieTBFSA1f1HPOk+6eI87DOSiNNR58k4wVs1vDtdEYi+l8HwZd62mNEe8VelCfhWBnAequm
        qDvZgfhpskBPaKz9KIIpUAaIlHxo2NA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636642819;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C4LGMG5POWX95fsNF9WFMLcvn5fSTvYVGGyDWrfZxxc=;
        b=wnAZJFUFjuuL+XUATVpyWnJ6bDXf9EGoJMD8Jlk40UnwJmEpdPbJT4e111rM6gkpm2I5t5
        pToMYd7PMJWzvGBg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D51FEA3B91;
        Thu, 11 Nov 2021 15:00:19 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 44C24DA799; Thu, 11 Nov 2021 16:00:19 +0100 (CET)
Date:   Thu, 11 Nov 2021 16:00:19 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/3] btrfs: introduce BTRFS_EXCLOP_BALANCE_PAUSED
 exclusive state
Message-ID: <20211111150019.GE28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Nikolay Borisov <nborisov@suse.com>,
        Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <20211108142820.1003187-1-nborisov@suse.com>
 <20211108142820.1003187-2-nborisov@suse.com>
 <ec5447a6-b9bc-17ac-11a7-4fc14e1c6a82@oracle.com>
 <e6b4d90e-5e5a-37be-24a8-f493451a889b@suse.com>
 <6b09a082-fe67-a6da-7322-1822425e14c0@oracle.com>
 <7563dfb3-5be8-7746-0851-055b849a67da@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7563dfb3-5be8-7746-0851-055b849a67da@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Nov 10, 2021 at 11:31:25AM +0200, Nikolay Borisov wrote:
> 
> 
> On 10.11.21 г. 10:56, Anand Jain wrote:
> > 
> > 
> > On 9/11/21 11:33 pm, Nikolay Borisov wrote:
> >> <snip>
> >>
> >>>
> >>>> +void btrfs_exclop_pause_balance(struct btrfs_fs_info *fs_info)
> >>>> +{
> >>>> +    spin_lock(&fs_info->super_lock);
> >>>> +    ASSERT(fs_info->exclusive_operation == BTRFS_EXCLOP_BALANCE ||
> >>>> +           fs_info->exclusive_operation == BTRFS_EXCLOP_DEV_ADD);
> >>>> +    fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE_PAUSED;
> >>>> +    spin_unlock(&fs_info->super_lock);
> >>>> +}
> >>>> +
> >>>
> >>> This function can be more generic and replace its open coded version
> >>> in a few places.
> >>>
> >>>   btrfs_exclop_balance(fs_info, exclop)
> >>>   {
> >>> ::
> >>>      switch(exclop)
> >>>      {
> >>>          case BTRFS_EXCLOP_BALANCE_PAUSED:
> >>>                ASSERT(fs_info->exclusive_operation ==
> >>>                  BTRFS_EXCLOP_BALANCE ||
> >>>                           fs_info->exclusive_operation ==
> >>>                  BTRFS_EXCLOP_DEV_ADD);
> >>>              break;
> >>>          case BTRFS_EXCLOP_BALANCE:
> >>>              ASSERT(fs_info->exclusive_operation ==
> >>>                  BTRFS_EXCLOP_BALANCE_PAUSED);
> >>>              break;
> >>>      }
> >>> ::
> >>>   }
> >>>
> >>>
> >>>>    static int btrfs_ioctl_getversion(struct file *file, int __user
> >>>> *arg)
> >>>>    {
> >>>>        struct inode *inode = file_inode(file);
> >>>> @@ -4020,6 +4029,10 @@ static long btrfs_ioctl_balance(struct file
> >>>> *file, void __user *arg)
> >>>>                if (fs_info->balance_ctl &&
> >>>>                    !test_bit(BTRFS_FS_BALANCE_RUNNING,
> >>>> &fs_info->flags)) {
> >>>
> >>>
> >>>>                    /* this is (3) */
> >>>> +                spin_lock(&fs_info->super_lock);
> >>>> +                ASSERT(fs_info->exclusive_operation ==
> >>>> BTRFS_EXCLOP_BALANCE_PAUSED);
> >>>> +                fs_info->exclusive_operation = BTRFS_EXCLOP_BALANCE;
> >>>
> >>> Here you set the status to BALANCE running. Why do we do it so early
> >>> without even checking if the user cmd is a resume? Like a few lines
> >>> below?
> >>>
> >>>      4064 if (bargs->flags & BTRFS_BALANCE_RESUME) {
> >>>
> >>> I guess it is because of the legacy balance ioctl.
> >>>
> >>>      4927 case BTRFS_IOC_BALANCE:
> >>>      4928 return btrfs_ioctl_balance(file, NULL);
> >>>
> >>> Could you confirm?
> >>
> >>
> >> Actually no, I thought that just because we are in (3) (based on the
> >> comments) the right thing would be done. However, that's clearly not the
> >> case...
> >>
> >> I wonder whether putting the code under the & BALANCE_RESUME branch is
> >> sufficient because as you pointed out the v1 ioctl doesn't handle args
> >> at all. If I'm reading the code correctly balance ioctl v1 can't really
> >> resume balance because it will always return with :
> >>
> > 
> > 
> >>      20         if (fs_info->balance_ctl) {
> As this part of the code is very confusing I think it is better to split
> the balance v1 and v2 codes into separate functions.
> >>
> >>      19                 ret = -EINPROGRESS;
> >>
> >>      18                 goto out_bargs;
> >>
> >>      17         }
> >>
> >> OTOH if I put the code right before we call btrfs_balance then there's
> >> no way to distinguish we are starting from paused state
> >>
> >> <snip>
> > 
> > Yeah looks like the legacy code did not resume the balance, it supported
> > the pause though or may be the trick was to remount to resume the
> > balance?
> > 
> > As this part of the code is very confusing I think it is better to split
> > the balance v1 and v2 codes into separate functions.
> 
> 
> Actually V1 is going to be deprecated so I think the way forward is to
> move the resume under the & BALANCE_RESUME branch.

I think we don't need to take v1 into account anymore. If the
deprecation goes to 5.16 and the device add / balance pause
compatibility into 5.17, we can actually remove v1 in the same release
so there's not even a chance to get to some weird state.
