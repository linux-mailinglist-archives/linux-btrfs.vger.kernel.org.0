Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB859D7F2A
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Oct 2019 20:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389190AbfJOSlh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Oct 2019 14:41:37 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44538 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfJOSlh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Oct 2019 14:41:37 -0400
Received: by mail-qk1-f195.google.com with SMTP id u22so20133778qkk.11
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Oct 2019 11:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dirL0qXg3IuXzTlIgH05tqhb8dmTAQ3ivvv9Pwxv41I=;
        b=R3/0HzG6TVB9TctRg/fUAeRFRNRwYtpXRqx2nl4koTIzLGNgF/3H159LJQaoFin77u
         GdAtt57zw3mIvFeO+UpGf/6/eYkd47ZHF5kdpU5MQ5WEKaquV8jbeBNyXrDnNpCa6dZM
         vxfzKeNfgGRmFoGDwBWFPIccYWsaiY1bWKzjBUOeidG63mGLo6eKEwqV1jHuZjkAl2lw
         dw8dpMuev8Up93s/vgd5OqW1Ox5Ko7cPBHKVP0uuPiGkuMOqblsG56JAe+BrgqLJocoP
         QJshzOv4+uzUjNRPZ7cqsAAGe3tNi5zX+9fGvLjzNyj5T4pBkSYIr/Ek4GMCdsRJbJtN
         kNOg==
X-Gm-Message-State: APjAAAU/WMnRRlrF++Pc6WMsOQN4dKg1MXmGso3e6Q4otHKxqzJfdYpG
        C/y+dphkqiOsqNyBPpYYJxg=
X-Google-Smtp-Source: APXvYqzopnxKdq8jCV4u+SB2H5S0vAIXx7SReao0mHZq357wLn8qBnRneKRX2QJPvF/yP8Kv9mZHbg==
X-Received: by 2002:a37:4e44:: with SMTP id c65mr36989234qkb.357.1571164896739;
        Tue, 15 Oct 2019 11:41:36 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:500::c97c])
        by smtp.gmail.com with ESMTPSA id a190sm11392192qkf.118.2019.10.15.11.41.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 11:41:36 -0700 (PDT)
Date:   Tue, 15 Oct 2019 14:41:34 -0400
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 08/19] btrfs: track discardable extents for asnyc discard
Message-ID: <20191015184134.GB82683@dennisz-mbp.dhcp.thefacebook.com>
References: <cover.1570479299.git.dennis@kernel.org>
 <31c4f29228c76df72cc92112e397db648e9b9ab9.1570479299.git.dennis@kernel.org>
 <20191015131217.GX2751@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015131217.GX2751@twin.jikos.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 15, 2019 at 03:12:17PM +0200, David Sterba wrote:
> On Mon, Oct 07, 2019 at 04:17:39PM -0400, Dennis Zhou wrote:
> > The number of discardable extents will serve as the rate limiting metric
> > for how often we should discard. This keeps track of discardable extents
> > in the free space caches by maintaining deltas and propagating them to
> > the global count.
> > 
> > This also setups up a discard directory in btrfs sysfs and exports the
> > total discard_extents count.
> 
> Please put the discard directory under debug/ for now.
> 

Just double checking, but you mean to have it be:
/sys/fs/btrfs/<uuid>/debug/discard/*?

> > Signed-off-by: Dennis Zhou <dennis@kernel.org>
> > ---
> >  fs/btrfs/ctree.h            |  2 +
> >  fs/btrfs/discard.c          |  2 +
> >  fs/btrfs/discard.h          | 19 ++++++++
> >  fs/btrfs/free-space-cache.c | 93 ++++++++++++++++++++++++++++++++++---
> >  fs/btrfs/free-space-cache.h |  2 +
> >  fs/btrfs/sysfs.c            | 33 +++++++++++++
> >  6 files changed, 144 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index c328d2e85e4d..43e515939b9c 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -447,6 +447,7 @@ struct btrfs_discard_ctl {
> >  	spinlock_t lock;
> >  	struct btrfs_block_group_cache *cache;
> >  	struct list_head discard_list[BTRFS_NR_DISCARD_LISTS];
> > +	atomic_t discard_extents;
> 
> At the end of the series this becomes
> 
> 452         atomic_t discard_extents;
> 453         atomic64_t discardable_bytes;
> 454         atomic_t delay;
> 455         atomic_t iops_limit;
> 456         atomic64_t bps_limit;
> 457         atomic64_t discard_extent_bytes;
> 458         atomic64_t discard_bitmap_bytes;
> 459         atomic64_t discard_bytes_saved;
> 
> raising many eyebrows. What's the reason to use so many atomics? As this
> is purely for accounting and perhaps not contended, add one spinlock
> protecting all of them.
> 
> None of delay, bps_limit and iops_limit use the atomict_t semantics at
> all, it's just _set and _read.
> 
> As this seem to cascade to all other patches, I'll postpone my review
> until I see V2.

Yeah... I think the following 3 would be nice to keep as atomics as the
first two are propagated per block group and are protected via the
free_space_ctl's lock. Then multiple allocations can go through
concurrently. discard_bytes_saved is also something that can be
incremented by multiple block groups at once for the same reason, so an
atomic makes life simple.

> 452         atomic_t discard_extents;
> 453         atomic64_t discardable_bytes;
> 459         atomic64_t discard_bytes_saved;

The others I'll flip over to the proper type.

Thanks, 
Dennis
