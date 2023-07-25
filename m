Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35364761990
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jul 2023 15:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjGYNQW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jul 2023 09:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjGYNQS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jul 2023 09:16:18 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F25AE74
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 06:16:14 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5701eaf0d04so65439467b3.2
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jul 2023 06:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1690290973; x=1690895773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qfef7T1y3mPvKiZiUsyRDLxvLO7ZLysxQEgMrbX0580=;
        b=ypu9Gn4KDjX0fhGfHb0rcW2o0mNflLDXdOnNaVk+osbkSWcwHdqYdmshoivCc8Fa1f
         yY3CPIT0IPoqCImRkHD62MzwJTlBAvnyoS4+QT/4pxgu2YCBXpakJhtG+0JWGRmHV3ut
         Qp3we9pqBp051iQ7qKZlGqYLHllT/psgTSwyTkJbWEsgjx8mRwd0CF2CMfyKm0RM2qkW
         I98hBU9eqA4Cb+ZlyWJ8F+ApaIiVcXFAZ5d0ymcvnN1xRfa/AXMCZdZxXheIBeqiFpf2
         2lUeJfVRLOSp89FcK6KwBcdlIHt+NZAMMAZhWg4V/nlPeZZuglzqxNAhB9ssa8op6HRj
         ic8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690290973; x=1690895773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qfef7T1y3mPvKiZiUsyRDLxvLO7ZLysxQEgMrbX0580=;
        b=XZSieKSOeC1z6EiFcGLaDOV4lnH7AUxHNi9bF5ls97Aa0pFIKrshEJ+HjP1j25IqMu
         5oKcXLDNYbnoJ+DJzsnx9avSwveUYZ77djIMglpKBf97HbMxRZFXy3R4GZtNsoFl13jl
         uAP0sVt6YgBtXqw8p1WJNLJaPLA+JL3ghZHDi8jJRssCr+w14nYU4ESXsHUrRkogkvBa
         HUu1bimRoTzp9VyZs1Vi+/jSY5/hAJFUhFlSJoQ+zsfCLF6vA7WBjIww0PSk73D08pA4
         27wHPukOZsAie92dpvmgFsSPvxbLkTve5rPdXAZ8ZOdIgFQLvXfNWsZeYxMtgO2XL9KM
         X+RA==
X-Gm-Message-State: ABy/qLbPC4x+59lgkR2xgufWwQeAygKpC97esO8zrEUiveIeTjpq7WOF
        FFrMX8nUnCL6uV16YVJ6MlPRQURTOkW7U8LyZjf+XQ==
X-Google-Smtp-Source: APBJJlHzIeRwOqZ6PNS8efbRuaH0+OJUEW3IJEbuebo4Fm5wPrQCw5KTMQoi8SVCrX7iZWSszS7e2g==
X-Received: by 2002:a81:6ec3:0:b0:562:1850:bbf0 with SMTP id j186-20020a816ec3000000b005621850bbf0mr9302283ywc.21.1690290972994;
        Tue, 25 Jul 2023 06:16:12 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id z191-20020a0dd7c8000000b00583f8f41cb8sm1346903ywd.63.2023.07.25.06.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 06:16:12 -0700 (PDT)
Date:   Tue, 25 Jul 2023 09:16:11 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Boris Burkov <boris@bur.io>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2] btrfs: wait for actual caching progress during
 allocation
Message-ID: <20230725131611.GA1433285@perftesting>
References: <5b2f035fed89ad01183916d606e5735ffc2cf9c1.1689970027.git.josef@toxicpanda.com>
 <20230721202817.GA558185@zen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721202817.GA558185@zen>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 21, 2023 at 01:28:17PM -0700, Boris Burkov wrote:
> On Fri, Jul 21, 2023 at 04:09:43PM -0400, Josef Bacik wrote:
> > Recently we've been having mysterious hangs while running generic/475 on
> > the CI system.  This turned out to be something like this
> > 
> > Task 1
> > dmsetup suspend --nolockfs
> > -> __dm_suspend
> >  -> dm_wait_for_completion
> >   -> dm_wait_for_bios_completion
> >    -> Unable to complete because of IO's on a plug in Task 2
> > 
> > Task 2
> > wb_workfn
> > -> wb_writeback
> >  -> blk_start_plug
> >   -> writeback_sb_inodes
> >    -> Infinite loop unable to make an allocation
> > 
> > Task 3
> > cache_block_group
> > ->read_extent_buffer_pages
> >  ->Waiting for IO to complete that can't be submitted because Task 1
> >    suspended the DM device
> > 
> > The problem here is that we need Task 2 to be scheduled completely for
> > the blk plug to flush.  Normally this would happen, we normally wait for
> > the block group caching to finish (Task 3), and this schedule would
> > result in the block plug flushing.
> > 
> > However if there's enough free space available from the current caching
> > to satisfy the allocation we won't actually wait for the caching to
> > complete.  This check however just checks that we have enough space, not
> > that we can make the allocation.  In this particular case we were trying
> > to allocate 9mib, and we had 10mib of free space, but we didn't have
> > 9mib of contiguous space to allocate, and thus the allocation failed and
> > we looped.
> > 
> > We specifically don't cycle through the FFE loop until we stop finding
> > cached block groups because we don't want to allocate new block groups
> > just because we're caching, so we short circuit the normal loop once we
> > hit LOOP_CACHING_WAIT and we found a caching block group.
> > 
> > This is normally fine, except in this particular case where the caching
> > thread can't make progress because the dm device has been suspended.
> > 
> > Fix this by not only waiting for free space to >= the amount of space we
> > want to allocate, but also that we make some progress in caching from
> > the time we start waiting.  This will keep us from busy looping when the
> > caching is taking a while but still theoretically has enough space for
> > us to allocate from, and fixes this particular case by forcing us to
> > actually sleep and wait for forward progress, which will flush the plug.
> > 
> > With this fix we're no longer hanging with generic/475.
> > 
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> Reviewed-by: Boris Burkov <boris@bur.io>
> 
> I like this fix a lot! I had missed we already block on a form of
> caching progress.
> 
> One question, though:
> is the logic in release_block_group() to clear the retry bools enough to
> make sure we keep waiting on this through multiple passes so that we
> don't just fix the most common case while failing to guarantee that we
> truly always wait for forward progress?

Yes, because the bit in the update loop where if we find a block group that was
caching we'll return and keep searching through, so we won't actually progress
the loop until after all of the block groups have been completely cached.
Thanks,

Josef
