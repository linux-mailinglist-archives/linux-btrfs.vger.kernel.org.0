Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1BF5B6013
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 20:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiILSS7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 14:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiILSS4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 14:18:56 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFA142AD4
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 11:18:55 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id d17so5895406qko.13
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 11:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=SJ3k3T/6SJCNdl7ZEkURWBuHbIxklLyE8QPYsx60RAA=;
        b=lWhA3P8aqbvXhfE6oIU/M/li5da3J8m6FP6E36iPMyTrYz2i8m4WaI5GWPn+95J+Nk
         pqnf7+2krMhxEtxgOQc8rl89wve+VKsy12qCZWjGbt2ThJn95VHYD2tnoymNUy7boDT5
         aevoOjFMqF0tDg9Y201oQx/hdnegznlQs7cTuOmN7mb39aHN9zASEkZq8jaipkTZinvW
         o5L8QfBpwuaHPLzgHLa8W+QA/a3Z//WTGmOEfgslGam1aRntv55dymBrMz5zQ0Z2/DBZ
         FYCICwEcP47iT8LNpIlOJrPY6X41fRN/jhJZFVOwaow4XrP1kHSV3DObQEcbjhpJVtmw
         lNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=SJ3k3T/6SJCNdl7ZEkURWBuHbIxklLyE8QPYsx60RAA=;
        b=ZVjzgKdrg9cyDhM5ggClNy+8XGcCwM2UvFtJFZU3Au/DBG4ssuL96k0b+rPrIUmXIg
         KKq0TupwRaGrWjvrx/GAj+zVZMHl5r8rpkg6732WjIe2ICNR9ViG5jj/kJ8GbZKQVG05
         l+dksMVj7QSTDepqCHTdb7B0MHkeh73di+c45wGvyl3ubxmMYCHlFOPe4IvpOldh02e1
         L24eoejEayzV8+rxz+RtnIiYstPtbQNZiQqTk1FcHPmGMzdk3Nl/zxB5hBzn14LPVSFI
         hXbNPVOE7MgoyeHtzqPKDGYRV398ZNbkd+YlBX6Ch8dmWmxHL73uOZStisOTzzfhKraa
         /H6w==
X-Gm-Message-State: ACgBeo0j1s/ghfQGtAJNJVQVUGzfsuvvhX17UXJVsZKLgMVzlDMcxglJ
        xx4qKnkDGSSHmmPeXwUN23+SxFWEYZji3g==
X-Google-Smtp-Source: AA6agR6T0EVcEXW9NXpp+PzQUi5+bn5yc46CbJ26wN9zOnqG9gLtgehzfIdVIjYnka+mbyT7mafKbg==
X-Received: by 2002:a05:620a:198e:b0:6bb:7651:fc7 with SMTP id bm14-20020a05620a198e00b006bb76510fc7mr19428242qkb.376.1663006734244;
        Mon, 12 Sep 2022 11:18:54 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w14-20020a05620a0e8e00b006b5c061844fsm7553265qkm.49.2022.09.12.11.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 11:18:53 -0700 (PDT)
Date:   Mon, 12 Sep 2022 14:18:52 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] btrfs: introduce BTRFS_RESERVE_FLUSH_EMERGENCY
Message-ID: <Yx94DA75iNdsZUGX@localhost.localdomain>
References: <d1da73f6ed291d53d4cc7dcab142ebfb0541f06e.1662730491.git.josef@toxicpanda.com>
 <20220912095907.GA269395@falcondesktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912095907.GA269395@falcondesktop>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Sep 12, 2022 at 10:59:07AM +0100, Filipe Manana wrote:
> On Fri, Sep 09, 2022 at 09:35:01AM -0400, Josef Bacik wrote:
> > Inside of FB, as well as some user reports, we've had a consistent
> > problem of occasional ENOSPC transaction aborts.  Inside FB we were
> > seeing ~100-200 ENOSPC aborts per day in the fleet, which is a really
> > low occurrence rate given the size of our fleet, but it's not nothing.
> > 
> > There are two causes of this particular problem.
> > 
> > First is delayed allocation.  The reservation system for delalloc
> > assumes that contiguous dirty ranges will result in 1 file extent item.
> > However if there is memory pressure that results in fragmented writeout,
> > or there is fragmentation in the block groups, this won't necessarily be
> > true.  Consider the case where we do a single 256MiB write to a file and
> > then close it.  We will have 1 reservation for the inode update, the
> > reservations for the checksum updates, and 1 reservation for the file
> > extent item.  At some point later we decide to write this entire range
> > out, but we're so fragmented that we break this into 100 different file
> > extents.  Since we've already closed the file and are no longer writing
> > to it there's nothing to trigger a refill of the delalloc block rsv to
> > satisfy the 99 new file extent reservations we need.  At this point we
> > exhaust our delalloc reservation, and we begin to steal from the global
> > reserve.  If you have enough of these cases going in parallel you can
> > easily exhaust the global reserve, get an ENOSPC at
> > btrfs_alloc_tree_block() time, and then abort the transaction.
> 
> There's also another problem I pointed out in the past regarding delalloc
> reservations. The thing is that we assume for each ordered extent, the new
> file extent item will require changing only 1 leaf in the subvolume tree.
> 
> If our new extent has a size of 128M and currently for that range we
> have 32768 extents each with a size of 4K, then we need to touch 157
> leaves in order to drop those file extent items before inserting the new
> one at ordered extent completion. And our reservation that happened at
> buffered write time only accounted for 1 leaf/path for file extent items
> (plus 1 for the inode item). This is assuming the default leaf size of 16K,
> where we can have at most 208 file extent items per leaf.
> 

Yeah I should have been less absolute in my descriptions, as you point out
there's a few other situations.  This one is another good one, and is even more
annoying because there isn't even the "oh we're going to allocate another file
extent at some point in the future" buffer, it happens right as you're
completing that ordered extent.

> 
> That's another elephant in the room. We assume that if a task reserves
> space, it will be able to allocate that space later.
> 
> There are several things that can happen which will result in not being
> able to allocate space we reserved before:
> 
> 1) Discard/fitrim - it removes a free space entry, does the discard, and
>    after that it adds back the free space entry. If all the available space
>    is in such an entry being discarded, the task fails to allocate space;
> 

Yup I've worried this was happening before, however when I tracked down the
actual problem this wasn't actually the issue we were seeing, so I set aside
fixing it.  For this I want to have another pass through the allocator that
waits for all discards to finish and doesn't allow new ones to start so we know
we can actually make our allocation.

> 2) fsync - it joins a transaction, doesn't reserve space and starts allocating
>    space for tree blocks, without ever reserving space (because we want it
>    to be fast and for most cases we don't know in advance, or can estimate,
>    how many tree blocks we will need to allocate). So it can steal space that
>    was reserved by some other task;

I'm far less worried about this than I used to be.  Before we had all these
hueristics about when we would commit the tranaction for ENOSPC flushing.  Now
we unconditionally commit it and thus free all this space.  We may need to add
another "wait for the tree log freeing code to finish running" wait, but this
should be straightforward to address.

> 
> 3) Scrub - scrub temporarily turns a block group into RO mode - if all the
>    available space was in that block group, than when the task tries to
>    allocate it will fail because the block group is now RO;
> 

Another thing we could add to the ENOSPC flushing thing, probably as a last
ditch "stop scrub, we're really in trouble here".  It could even go in the
allocator loop like discard where we definitely have the space, it's just
temporarily tied up.

> 4) During space reservation we only check if free space counters. There
>    may be block groups with plenty of free space but their profile is not
>    compatible, so when trying to allocate an extent we are forced to allocate
>    a new block group with the necessary profile, which will fail if there's
>    not enough unallocated space.
>    This mostly affects degraded mode only (hopefully).

Yeah this really shouldn't happen, everything should be the same profile.  Which
is to say all discrete types should be on the same profile, if we had some on
dupe metadata but some on single metadata mixed into the same space_info we're
going to have a bad time.  We could probalby address this by making the
space_info's completely tied to their profile and their data/metadata type, but
that might be hairy.

Degraded is special, but I'm happy slapping a "try not to use degraded mode
heavily in production" warning label on it.  Thanks,

Josef
