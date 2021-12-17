Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07137478E63
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Dec 2021 15:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237562AbhLQOsq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Dec 2021 09:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237531AbhLQOsn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Dec 2021 09:48:43 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610ACC06173E
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Dec 2021 06:48:43 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id p3so2536021qvj.9
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Dec 2021 06:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2ggfJ9U6oUOBYbWhIUlZH6DOhP/ZohknODpQm3sbOs0=;
        b=hxswZSzSp+zRzuQldB2s/cGpdPJXhYhRW7ro/7MC0NUaaplTZvvvDPOSQncVcs6IDx
         Fx5Y0zSwpR7MiI+20e9lxcScw2+aWjxSAQ1glev00cZjaqrPSVKklCIp1KGbRx36jinh
         BmcFAIXpKxIvWE6mwYtlEvOpi6KWypaf3RGDxumGVh4U2fC2uePjdULW8Z8W+5WSDIaN
         VP3PjvkNnQV+vwDvRlpgKqMuIrVhDJ729c/jOlwoOuSzBnmMK5/APClKNRlAuNsO3ziV
         Ek0OQOLLNIQ4BXU/Eo5SwMfrE0ilYl94+GDEgI5CCJPDkpTVdYovT82euZjW7F68k/du
         LXrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2ggfJ9U6oUOBYbWhIUlZH6DOhP/ZohknODpQm3sbOs0=;
        b=eTNtE7PsB3l44N+p3DvWJp7KSK1z4PwEiXRZF8YHVwfRQASvQxos1RatNP3Ef/WfMw
         ms+V1tHrIYuUu3zZpXEHOgU5u7GToY1GwcDvdTTJRT2NZpjl9+31imURb5d0ac281H43
         jixI0Ep/BjF8tQMFTJo/APUzd60cgJvaXHukTpqkED+jJA0F5RNWpjT/FTWnLYVbpgGh
         /caZQYqRQ6K19MLlTQ0gVElCi8C5B7ZMa3T0k9/W5fhzzYU/GszaZ2hnZhuelizKI7fp
         +5ujsXiS8GxmjsLdxc2eU0EKS98P5na0574a4ehSJ0NPGp/PMbNOej58PXUzX8rfyK6m
         pYEA==
X-Gm-Message-State: AOAM530LlmvRZERDHq+Olv/n9O+llmv7FtwebeNZELkGZ8+UkrREo6Lg
        4RioWJGAW+NnRZRbX8YUlbll0ryjbttXxw==
X-Google-Smtp-Source: ABdhPJyZR/0eA+/sVVGIlEdavVTl9aGjpkiq4koU3X19wN9g1o/ReWVcTX4pU01n9Ws++v4jR04quQ==
X-Received: by 2002:ad4:5cef:: with SMTP id iv15mr2476163qvb.102.1639752522219;
        Fri, 17 Dec 2021 06:48:42 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e20sm7446083qty.14.2021.12.17.06.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 06:48:41 -0800 (PST)
Date:   Fri, 17 Dec 2021 09:48:40 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     kreijack@inwind.it, David Sterba <dsterba@suse.cz>,
        Sinnamohideen Shafeeq <shafeeqs@panasas.com>,
        Paul Jones <paul@pauljones.id.au>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RFC][V8][PATCH 0/5] btrfs: allocation_hint mode
Message-ID: <YbyjSBX3tbpLax7P@localhost.localdomain>
References: <Ybe34gfrxl8O89PZ@localhost.localdomain>
 <YbfN8gXHsZ6KZuil@hungrycats.org>
 <71e523dc-2854-ca9b-9eee-e36b0bd5c2cb@libero.it>
 <Ybj40IuxdaAy75Ue@hungrycats.org>
 <Ybj/0ITsCQTBLkQF@localhost.localdomain>
 <be4e6028-7d1d-6ba9-d16f-f5f38a79866f@libero.it>
 <Ybn0aq548kQsQu+z@localhost.localdomain>
 <633ccf8f-3118-1dda-69d2-0398ef3ffdb7@libero.it>
 <YbqOwN7SW7NWm5/S@localhost.localdomain>
 <Ybwi58Uivf29oGhw@hungrycats.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ybwi58Uivf29oGhw@hungrycats.org>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Dec 17, 2021 at 12:40:55AM -0500, Zygo Blaxell wrote:
> On Wed, Dec 15, 2021 at 07:56:32PM -0500, Josef Bacik wrote:
> > On Wed, Dec 15, 2021 at 07:53:40PM +0100, Goffredo Baroncelli wrote:
> > > On 12/15/21 14:58, Josef Bacik wrote:
> > > > On Tue, Dec 14, 2021 at 09:41:21PM +0100, Goffredo Baroncelli wrote:
> > > > > On 12/14/21 21:34, Josef Bacik wrote:
> > > > > > On Tue, Dec 14, 2021 at 03:04:32PM -0500, Zygo Blaxell wrote:
> > > > > > > On Tue, Dec 14, 2021 at 08:03:45PM +0100, Goffredo Baroncelli wrote:
> > > > > 
> > > > > > > 
> > > > > > > I don't have a strong preference for either sysfs or ioctl, nor am I
> > > > > > > opposed to simply implementing both.  I'll let someone who does have
> > > > > > > such a preference make their case.
> > > > > > 
> > > > > > I think echo'ing a name into sysfs is better than bits for sure.  However I want
> > > > > > the ability to set the device properties via a btrfs-progs command offline so I
> > > > > > can setup the storage and then mount the file system.  I want
> > > > > > 
> > > > > > 1) The sysfs interface so you can change things on the fly.  This stays
> > > > > >      persistent of course, so the way it works is perfect.
> > > > > > 
> > > > > > 2) The btrfs-progs command sets it on offline devices.  If you point it at a
> > > > > >      live mounted fs it can simply use the sysfs thing to do it live.
> > > > > 
> > > > > #2 is currently not implemented. However I think that we should do.
> > > > > 
> > > > > The problem is that we need to update both:
> > > > > 
> > > > > - the superblock		(simple)
> > > > > - the dev_item item		(not so simple...)
> > > > > 
> > > > > What about using only bits from the superblock to store this property ?
> > > > 
> > > > I'm looking at the patches and you only are updating the dev_item, am I missing
> > > > something for the super block?
> > > 
> > > When btrfs write the superblocks (see write_all_supers() in disk-io.c), it copies
> > > the dev_item fields (contained in fs_info->fs_devices->devices lists) in each
> > > superblock before updating it.
> > > 
> > 
> > Oh right.  Still, I hope we're doing this correctly in btrfs-progs, if not
> > that's a problem.
> > 
> > > > 
> > > > For offline all you would need to do is do the normal open_ctree,
> > > > btrfs_search_slot to the item and update the device item type, that's
> > > > straightforward.
> > > > 
> > > > For online if you use btrfs prop you can see if the fs is mounted and just find
> > > > the sysfs file to modify and do it that way.
> > > > 
> > > > But this also brings up another point, we're going to want a compat bit for
> > > > this.  It doesn't make the fs unusable for old kernels, so just a normal
> > > > BTRFS_FS_COMPAT_<whatever> flag is fine.  If the setting gets set you set the
> > > > compat flag.
> > > 
> > > Why we need a "compact" bit ? The new kernels know how treat the dev_item_type field.
> > > The old kernels ignore it. The worst thing is that a filesystem may require a balance
> > > before reaching a good shape (i.e. the metadata on ssd and the data on a spinning disk)
> > 
> > So you can do the validation below, tho I'm thinking I care about it less, if we
> > just make sure that type is correct regardless of the compat bit then that's
> > fine.  Thanks,
> 
> In theory if you get stuck in an impossible allocation situation (like all
> your disks are data-only and you run out of metadata space) then one way
> to recover from it is to mount with an old kernel which doesn't respect
> the type bits.  Another way to recover would be to flip the type bits
> while the filesystem is offline with btrfs-progs.  A third way would be to
> have a mount option for newer kernels to ignore the allocation bits like
> old kernels do (yes I know I already said I didn't like that idea).
> 

This is the "preferred" vs "only" category.  You set "preferred" if you want to
be able to handle failures cleanly, you set "only" if you'd rather reprovision a
box than lose performance.

> If we have a bit that says "old kernels don't mount this filesystem any
> more" then we lose one of those recovery options, and the other options
> aren't implemented yet.
> 
> While I think of it, the metadata reservation system eventually needs
> to know that it can't use data-only devices for metadata, the same way
> that df eventually needs to know about metadata-only devices.
> 

Yeah, I'm willing to throw that into the power user bucket.  It really only
affects overcommit, because once we've allocated all our chunks we'll stop
overcommitting.  There may be some corners that need to be addressed, but we can
burn those bridges when we get to them.  Thanks,

Josef
