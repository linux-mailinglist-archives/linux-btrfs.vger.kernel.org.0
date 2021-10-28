Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87F743E3B0
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Oct 2021 16:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhJ1OaI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Oct 2021 10:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbhJ1OaH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Oct 2021 10:30:07 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919ECC061570
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Oct 2021 07:27:40 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id bk35so5941357qkb.6
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Oct 2021 07:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9RBzZuKdjLywiMyzHtwnRq0mwH6IjIkhMDGZQuBCxQs=;
        b=ksz9Dp5olxm0Tliimd++5eamaCpGjOjKZCc+fRatZE5m1KBzrTquL3feGlUpOTQR85
         LjWznZwbWZCm0W+YRJ5YDIO+F+uYzFusmgF3ujyudWURyES6U3T+cfSAj1Un7wuqLsOp
         SOb+LwJ7AjkRvldO50W0dURMNkCNiGnUpByFPePE01/7pi6BTM5ia6+I4P2qkDoS5Fvb
         M9jx1eIMQ+Btewj0xYNky2hjBPUt2VXjHVebj8tB0reba+5z6pCXLv8NqFmKdHM9u3Z6
         gIYVrTDcPeiEsvykvU50WFbCjFBavvN0W52ILMlQwnz3NFxrIEdXDfeFPAC95HxbQVUv
         +PXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9RBzZuKdjLywiMyzHtwnRq0mwH6IjIkhMDGZQuBCxQs=;
        b=gHdA60bw04P+iIa5vQNMixis7Xtv0HIT3gtNrrW25MSW+aa114bWj5/nNPstztmbHe
         M4ebKAWD3NQWp3fw74ayWgkgcLRlKIADjmDq4dT/0MMxuDdUdALmjx6zgHWrAUoUXXJF
         asIcDMLjI/6HeVDGCJRmXqHg0WloApNMbka/xXfElt6yWgk7uLSTDGrj1O2dYfML2hRs
         NdD1ugMx7YGP+tdPDl7oZy4xPawrUo0sUpXexUYLVT+1zYGdvmiQBK6sTKoVaXHfNGRo
         l45hE+U2H3cB0kTXaMUM53hESaf1oInnR8pCASMCk1GO3VS94Uw8g01gasET1Jjxa+p8
         pXAQ==
X-Gm-Message-State: AOAM533pNaj+VReWVcaZDWmxUOlvK7LJwN1ZZX8HktewYa5dHAfTYGrq
        gKxASm+xNmhU7J5/ys3OfjvAyPu+c0Q0Wg==
X-Google-Smtp-Source: ABdhPJzwwl74gKMNHtgA8LRtY5fmDda7hZSk9Le7iIPD0VIWAuOBGLgDP2qJgyqYiRlHoV0lm0aRkw==
X-Received: by 2002:a37:f902:: with SMTP id l2mr3709368qkj.511.1635431259597;
        Thu, 28 Oct 2021 07:27:39 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id t11sm1983694qkm.92.2021.10.28.07.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 07:27:39 -0700 (PDT)
Date:   Thu, 28 Oct 2021 10:27:38 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Stefan Roesch <shr@fb.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 0/4] btrfs: sysfs: set / query btrfs stripe size
Message-ID: <YXqzWv7t77ZpKIig@localhost.localdomain>
References: <20211027201441.3813178-1-shr@fb.com>
 <YXqpFxiAVrC92io6@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXqpFxiAVrC92io6@localhost.localdomain>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 28, 2021 at 09:43:51AM -0400, Josef Bacik wrote:
> On Wed, Oct 27, 2021 at 01:14:37PM -0700, Stefan Roesch wrote:
> > Motivation:
> > The btrfs allocator is currently not ideal for all workloads. It tends
> > to suffer from overallocating data block groups and underallocating
> > metadata block groups. This results in filesystems becoming read-only
> > even though there is plenty of "free" space.
> > 
> > This is naturally confusing and distressing to users.
> > 
> > Patches:
> > 1) Store the stripe and chunk size in the btrfs_space_info structure
> > 2) Add a sysfs entry to expose the above information
> > 3) Add a sysfs entry to force a space allocation
> > 4) Increase the default size of the metadata chunk allocation to 5GB
> >    for volumes greater than 50GB.
> > 
> > Testing:
> >   A new test is being added to the xfstest suite. For reference the
> >   corresponding patch has the title:
> >     [PATCH] btrfs: Test chunk allocation with different sizes
> > 
> >   In addition also manual testing has been performed.
> >     - Run xfstests with the changes and the new test. It does not
> >       show new diffs.
> >     - Test with storage devices 10G, 20G, 30G, 50G, 60G
> >       - Default allocation
> >       - Increase of chunk size
> >       - If the stripe size is > the free space, it allocates
> >         free space - 1MB. The 1MB is left as free space.
> >       - If the device has a storage size > 50G, it uses a 5GB
> >         chunk size for new allocations.
> > 
> > Stefan Roesch (4):
> >   btrfs: store stripe size and chunk size in space-info struct.
> >   btrfs: expose stripe and chunk size in sysfs.
> >   btrfs: add force_chunk_alloc sysfs entry to force allocation
> >   btrfs: increase metadata alloc size to 5GB for volumes > 50GB
> >
> 
> Sorry, I had this thought previously but it got lost when I started doing the
> actual code review.
> 
> We have conflated stripe size and chunk size here, and unfortunately "stripe
> size" means different things to different people.  What you are actually trying
> to do here is to allow us to allocate a larger logical chunk size.
> 
> In terms of how this works out in the code you are changing the correct thing,
> generally the stripe_size is what dictates the actual block group chunk size we
> end up with at the end.
> 
> But this is sort of confusing when it comes to the interface, because people are
> going to think it means something different.
> 
> Instead we should name the sysfs file chunk_size, and then keep the code you
> have the way it is, just with the new name.  That way it's clear to the user
> that they're changing how large of a chunk we're allocating at any given time.
> 
> Make that change, and I have a few other code comments, and then that should be
> good.  Thanks,
> 

In fact I talked about this with Johannes just now.  We sort of conflate the two
things, max_chunk_size and max_stripe_size, to get the answer we want.  But
these aren't well named and don't really behave in a way you'd expect.

Currently, we set max_stripe_size to make sure we clamp down on any dev extents
we find.  So if the whole disk is free we clearly don't want to allocate the
whole thing, so we clamp it down to max_stripe_size.  This, in effect, ends up
being our actual chunk_size.  We have this max_chunk_size thing but it doesn't
really do anything in practice because our stripe_size is already clamped down
so it'll be <= max_chunk_size.

All this is to say we should simply set max_stripe_size = max_chunk_size, but
call max_chunk_size default_chunk_size, because that's really what it is.  So
you should

1) Change the sysfs file to be chunk_size or something similar.
2) Don't expose stripe_size via sysfs, it's just a function of chunk_size.
3) Set stripe_size == chunk_size.
4) Get rid of the max_chunk_size logic, it's unneeded.

I think that's the proper way to deal with everything, if there are any corners
I'm missing then feel free to point them out, but I'm pretty sure 1-3 are
correct.  Thanks,

Josef
