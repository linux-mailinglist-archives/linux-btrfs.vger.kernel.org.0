Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79056015F9
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Oct 2022 20:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbiJQSIJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Oct 2022 14:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiJQSII (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Oct 2022 14:08:08 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC89174B9C
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 11:08:04 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id df9so7887592qvb.9
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Oct 2022 11:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=59phmNvq6dyn6FNqT7e7ZeZ2gCVjuX0SVKqwC3FuvIo=;
        b=rr2Ut7WDbVdz7xY2WNCYL0EhBWh3KK0gPOnVs2dOKdgs2q6oIPxt9bu6DD0S9BvPgc
         LLcF9PzcBu/Ym3ruiECSEr8OK6b2QcNOunREljZWN+FpEvAXQ7KbrMWo/SmazlvIE408
         ZBVFoU0W2oORTGddtvOCU65+Gv0x88F39erxMbgIxoRn7ECqQ6qwyE4jhmr4pZ6hgJ9i
         PSVFdn8T7IQXWx2ajnKx6Tn74r35utKeUew9nuXXE9LbamK5a2yvZNgKcJfFV1w4XeG4
         AUJTPNPHeiybNXi1Cqz7Dzj6GYYqq5YeETH79MPWCjtfUjgkcyS1pHyIQ2qjhRoQKT9B
         6GEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=59phmNvq6dyn6FNqT7e7ZeZ2gCVjuX0SVKqwC3FuvIo=;
        b=Q7ZFL1HLPjmX1E08h6rYr0aox8BkBTSiF1xYZDUq0ISNCBVB6WTOK6Hb59chw4K9gH
         B/LGXDGVgkuXojDIOch/eJ8PJZX9opytkQ8xVVuQqbi0GzNjIPcr22yUxAkpB4kIfsXb
         CVdcvWzcgKDJCAp6vV80pz3WFaZpBNDBTlIhU/vD/p1BNyZQP5lR/iWHcN/m6iYR/IpQ
         IHekKgxviBZa4QIbIsnYfqCQbieXCH+si/96X1DoGQvFc2ZitXHdj8EvJ68r94eo/RtZ
         F8VO9ZrsaDNeFndFrVTREna2+CNWC4/4HpQ3gs666cIOZjYnibl2KPwikJUi3HI65LlK
         TIVQ==
X-Gm-Message-State: ACrzQf1NoLaOM3FjSQ4O7++EjjA1iBYPIyojn4nMy/iNcCqy8tYlF/9N
        Ce6HuCp+bw6PeNZVdy0AdrFGOQ==
X-Google-Smtp-Source: AMsMyM7jvqZcDTike22ditmHmeNJCPFZwxwYP3pMnKordEkyKZ73+DN3hH0qDy6CQdEh2P7xJ3/ytw==
X-Received: by 2002:a0c:f550:0:b0:4b1:7af4:eece with SMTP id p16-20020a0cf550000000b004b17af4eecemr9290810qvm.110.1666030083722;
        Mon, 17 Oct 2022 11:08:03 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id oo12-20020a05620a530c00b006eeae49537bsm295184qkn.98.2022.10.17.11.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 11:08:03 -0700 (PDT)
Date:   Mon, 17 Oct 2022 14:08:02 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/3] btrfs: avoid GFP_ATOMIC allocation failures during
 endio
Message-ID: <Y02aAoQDtAoit8xL@localhost.localdomain>
References: <cover.1665755095.git.josef@toxicpanda.com>
 <20221017142516.GQ13389@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017142516.GQ13389@twin.jikos.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Oct 17, 2022 at 04:25:16PM +0200, David Sterba wrote:
> On Fri, Oct 14, 2022 at 10:00:38AM -0400, Josef Bacik wrote:
> > Hello,
> > 
> > As you can imagine we have workloads that don't behave super well sometimes, and
> > they'll OOM the box in a really spectacular fashion.  Sometimes these trip the
> > BUG_ON(!prealloc) things inside of the extent io tree code.
> > 
> > We've talked about switching these allocations to mempools for a while, but
> > that's going to require some extra work.  We can drastically reduce the
> > likelihood of failing these allocations by simply dropping the tree lock and
> > attempting to make the allocation with the original gfp_mask.
> > 
> > The main problem with that approach is we've been using GFP_ATOMIC in the endio
> > path for....reasons?  I *think* the read endio work used to happen in IRQ
> > context, but it hasn't for at least a decade, and in fact if we get read
> > failures we do our failrec allocations with GFP_NOFS, so clearly GFP_ATOMIC
> > isn't really required in this path.
> 
> Up to my possibly dated knowledge endio is done in irq context so we
> need to verify that. I did a quick check in block/ but the bare bio->end_io()
> is not called unser obvious irq protection (spin lock or local_irq
> save/restore), but I could be mistaken due to the maze of block layer.
> 

I went through and read all the code, every path that does a REQ_READ does the
actual endio work in an async worker, only some of the write path happens in IRQ
context.  Additionally we've been allocating failrec's in this context for
years, so if it was actually happening in IRQ context we would have noticed by
now.  I definitely went and looked tho because I was super confused.

> > So kill the GFP_ATOMIC allocations in the endio path, which is where we see
> > these panics, and then change the extent io code to simply do the loop again if
> > it can't allocate the prealloc extent with GFP_ATOMIC so we can make the
> > allocation with the callers gfp_mask.
> > 
> > This is perfectly safe, we'll drop the tree lock and loop around any time we
> > have to re-search the tree after modifying part of our range, we don't need to
> > hold the lock for our entire operation.
> > 
> > The only drawback here is that we could infinite loop if we can't make our
> > allocation.  This is why a mempool would be the proper solution, as we can't
> > fail these allocations without brining the box down, which is what we currently
> > do anyway.
> 
> Aren't the mempools shifting the possibly infinite loop one layer down
> only? With some added bonus of creating indirect dependencies of the
> allocating and freeing threads.

bio's use mempools for the same reason, the emergency reserve exists so that we
always are able to make our allocations.  Clearly we could still end up in a bad
situation if we exhaust the emergency reserve, but the extent states in this
particular case don't get allocated a bunch.  Thanks,

Josef
