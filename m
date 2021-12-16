Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B528476729
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Dec 2021 01:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhLPA4h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 19:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhLPA4g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 19:56:36 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65289C061574
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 16:56:36 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id l25so12562077qkl.5
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Dec 2021 16:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WlbzKA0Dh0y167HEVyQ3OV93bMyva7n73RzMDGybT/8=;
        b=hqdGAcVyOXR0fU9c1BICtMmlzcIAEgEhc+imIPNBL3fB1Kh/Zw367vXNgrFNh8cFYP
         Ra9iScbvMnvQGzsQwsLuhJ1bNMWYj7rN7VLgmuz1GDIhhyZcAbfHcjrcrvauqeEVkxQb
         nJ1rT79v1V0ChYwhYbBgMGXaWuVO0GTbM2GnMpQuRsc3I7ErlF94h/vcX0tG3SEWGkGr
         IstU30UY1iT5jKWBCFZNUjlX7PIY2g65T0s4hmj4oOr6jgckBcsOFWVK1b/wyCG4lovY
         hP8HC5NKWC9aVtEqLA8J4/iCkqGXmBIP8qUh0eWqbuWST8brhfjvdk9g+W1Pg4QYNUMc
         7Zkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WlbzKA0Dh0y167HEVyQ3OV93bMyva7n73RzMDGybT/8=;
        b=U47qYr0iuhKsAW3jdYlD27OH0PwYPiSNRVsL4KYJokJgMzN//qpY8R45KsuaFlL91b
         qLIqluhcq1PM1WqpU+SgaKq+hhXsNMk7ExJIIl06hTag4jNafwJ+VFIcwr+OgnlY9O9W
         erO+FLy3ataLsoV0ETjNPT/6pz+HgpIQ1P7C5JlaZJfr4izqvbqRnepwoQK6OOdy2ESJ
         HeFzYFabg5QIumbzPRT1c6FWsIAL8Gx2WwOM9afxMcK/DHNoRZl/K/nQaj+n7IoJEJ8j
         V2Jmn7ZOgmpf8w1vyF6a1NGqJE2oPVKQheSEXLnrqKyyQOlT3DkuNiGf8uJWm4XQN6Nm
         KYqg==
X-Gm-Message-State: AOAM533SVqrd64qaQ+lOHfrXuNqwpiuvhLSwJ65XGlXGSSIFXEmKH35J
        pAGYsrxNiST8zLy1QBc19BrurA==
X-Google-Smtp-Source: ABdhPJyvWsSmAE7sJr56JGz5ZAD0++Uth0FNsIXGWeqrEeolcADOFxX9mWoWnlta4SfWX5AUajU6OA==
X-Received: by 2002:a05:620a:c47:: with SMTP id u7mr10956227qki.568.1639616195355;
        Wed, 15 Dec 2021 16:56:35 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s126sm1950991qkf.7.2021.12.15.16.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 16:56:34 -0800 (PST)
Date:   Wed, 15 Dec 2021 19:56:32 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     kreijack@inwind.it
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC][V8][PATCH 0/5] btrfs: allocation_hint mode
Message-ID: <YbqOwN7SW7NWm5/S@localhost.localdomain>
References: <SYXPR01MB1918689AF49BE6E6E031C8B69E749@SYXPR01MB1918.ausprd01.prod.outlook.com>
 <1d725df7-b435-4acf-4d17-26c2bd171c1a@libero.it>
 <Ybe34gfrxl8O89PZ@localhost.localdomain>
 <YbfN8gXHsZ6KZuil@hungrycats.org>
 <71e523dc-2854-ca9b-9eee-e36b0bd5c2cb@libero.it>
 <Ybj40IuxdaAy75Ue@hungrycats.org>
 <Ybj/0ITsCQTBLkQF@localhost.localdomain>
 <be4e6028-7d1d-6ba9-d16f-f5f38a79866f@libero.it>
 <Ybn0aq548kQsQu+z@localhost.localdomain>
 <633ccf8f-3118-1dda-69d2-0398ef3ffdb7@libero.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <633ccf8f-3118-1dda-69d2-0398ef3ffdb7@libero.it>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Dec 15, 2021 at 07:53:40PM +0100, Goffredo Baroncelli wrote:
> On 12/15/21 14:58, Josef Bacik wrote:
> > On Tue, Dec 14, 2021 at 09:41:21PM +0100, Goffredo Baroncelli wrote:
> > > On 12/14/21 21:34, Josef Bacik wrote:
> > > > On Tue, Dec 14, 2021 at 03:04:32PM -0500, Zygo Blaxell wrote:
> > > > > On Tue, Dec 14, 2021 at 08:03:45PM +0100, Goffredo Baroncelli wrote:
> > > 
> > > > > 
> > > > > I don't have a strong preference for either sysfs or ioctl, nor am I
> > > > > opposed to simply implementing both.  I'll let someone who does have
> > > > > such a preference make their case.
> > > > 
> > > > I think echo'ing a name into sysfs is better than bits for sure.  However I want
> > > > the ability to set the device properties via a btrfs-progs command offline so I
> > > > can setup the storage and then mount the file system.  I want
> > > > 
> > > > 1) The sysfs interface so you can change things on the fly.  This stays
> > > >      persistent of course, so the way it works is perfect.
> > > > 
> > > > 2) The btrfs-progs command sets it on offline devices.  If you point it at a
> > > >      live mounted fs it can simply use the sysfs thing to do it live.
> > > 
> > > #2 is currently not implemented. However I think that we should do.
> > > 
> > > The problem is that we need to update both:
> > > 
> > > - the superblock		(simple)
> > > - the dev_item item		(not so simple...)
> > > 
> > > What about using only bits from the superblock to store this property ?
> > 
> > I'm looking at the patches and you only are updating the dev_item, am I missing
> > something for the super block?
> 
> When btrfs write the superblocks (see write_all_supers() in disk-io.c), it copies
> the dev_item fields (contained in fs_info->fs_devices->devices lists) in each
> superblock before updating it.
> 

Oh right.  Still, I hope we're doing this correctly in btrfs-progs, if not
that's a problem.

> > 
> > For offline all you would need to do is do the normal open_ctree,
> > btrfs_search_slot to the item and update the device item type, that's
> > straightforward.
> > 
> > For online if you use btrfs prop you can see if the fs is mounted and just find
> > the sysfs file to modify and do it that way.
> > 
> > But this also brings up another point, we're going to want a compat bit for
> > this.  It doesn't make the fs unusable for old kernels, so just a normal
> > BTRFS_FS_COMPAT_<whatever> flag is fine.  If the setting gets set you set the
> > compat flag.
> 
> Why we need a "compact" bit ? The new kernels know how treat the dev_item_type field.
> The old kernels ignore it. The worst thing is that a filesystem may require a balance
> before reaching a good shape (i.e. the metadata on ssd and the data on a spinning disk)
> 

So you can do the validation below, tho I'm thinking I care about it less, if we
just make sure that type is correct regardless of the compat bit then that's
fine.  Thanks,

Josef
