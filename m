Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316F33BEDA0
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jul 2021 19:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhGGSCi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jul 2021 14:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhGGSCh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jul 2021 14:02:37 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE11FC061760
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jul 2021 10:59:56 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id w15so3066074pgk.13
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jul 2021 10:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UuByXwl/ZggLuZLxjRPi2ENFNnrGhzIfjH6PqbhGc+Q=;
        b=WoDkouFglcxUePWvEApdKmxPTVFS96FsfNYDMIzyLfghU4aZ6c7z7QJxehINkONY/e
         b2ZQKf22q1y/84DTaOWCrv8BhYbGRbkNDgzBungaIZ0yBqUaJtdLNK9q/Dp5Gf6BAMsA
         6YmGH3RpqmJCRGlJW5cUIqEHH+S72md0kk8NGot8RPSp+IndPM0sECgifngGpGdrdzeq
         22A5152QisRl9Sw7iWZMv8JZbSofqlYb9FX0YYrRZAWxBQjQJC42iqGNmQ2DzhXo9RVQ
         7fZnUhwgtVjxxjTr6Q+v+tzUhRAN7XLQ4NyhsaY0gObww7s/UAc/ROihXllf0NdJSnqN
         TuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UuByXwl/ZggLuZLxjRPi2ENFNnrGhzIfjH6PqbhGc+Q=;
        b=W2q5E4GQ0HkR70MYtY2FN8SpXXgs4+3pAIKGjFMqGAikmY0n8o8umaQ5vRWIjx2JBB
         //g2FC4s/27fxGJgGmUeqqj6HYzc/+Oi0BwkOYECAxh+rnQqik3XxUcF7EdRlSwKp5QO
         crXoyombpkXJo8p8Ed3VI5EFu2mXN8/AFmR5r277qVi6XZMFmqvTI4cqszT/e2JwU40E
         ybs0e7iow0W62f7RJshunvnLg8CHS4edVU4/1KWi5g/jfInI+21wOtQi2WKyZTtTL+lb
         O2sNW2MqxniblaZGvYpQOU2QQr0F3hrY2txbWoXVpxIhEvXH/IRFZqoJEOt1zgPDx3u6
         2GDA==
X-Gm-Message-State: AOAM530Aqh/IKaSgCl6u3FuPVm0EHnsqRQwIpcdHeg9OmR+HfTxObJ0g
        J29iLZmxdbiDcW35KlSgrHiOqUkf0xwDgw==
X-Google-Smtp-Source: ABdhPJw2Ny6eY+qM9e9CB9jKdPUq2ELTuNxLaXr9A0ujWoYKCkdnJO9JcDw/ctABKjNsgpFUktehog==
X-Received: by 2002:a63:580a:: with SMTP id m10mr16481833pgb.254.1625680796038;
        Wed, 07 Jul 2021 10:59:56 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:e1b5])
        by smtp.gmail.com with ESMTPSA id u16sm10571142pfh.205.2021.07.07.10.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 10:59:55 -0700 (PDT)
Date:   Wed, 7 Jul 2021 10:59:53 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
Message-ID: <YOXrmbi81Fr14fUV@relinquished.localdomain>
References: <YNOuiMfRO51kLcOE@relinquished.localdomain>
 <YNPnRyasHVq9NF79@casper.infradead.org>
 <YNQi3vgCLVs/ExiK@relinquished.localdomain>
 <CAHk-=whmRQWm_gVek32ekPqBi3zAKOsdK6_6Hx8nHp3H5JAMew@mail.gmail.com>
 <YNTO1T6BEzmG6Uj5@relinquished.localdomain>
 <CAHk-=wi37_ccWmq1EKTduS8ms_=KpyY2LwJV7roD+s=ZkBkjCw@mail.gmail.com>
 <yq1tulmoqxf.fsf@ca-mkp.ca.oracle.com>
 <YNVPp/Pgqshami3U@casper.infradead.org>
 <CAHk-=wgH5pUbrL7CM5v6TWyNzDYpVM9k1qYCEgmY+b3Gx9nEAA@mail.gmail.com>
 <YNZFr7oJj1nkrwJY@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YNZFr7oJj1nkrwJY@relinquished.localdomain>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jun 25, 2021 at 02:07:59PM -0700, Omar Sandoval wrote:
> On Fri, Jun 25, 2021 at 09:16:15AM -0700, Linus Torvalds wrote:
> > On Thu, Jun 24, 2021 at 8:38 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > Does it make any kind of sense to talk about doing this for buffered I/O,
> > > given that we can't generate them for (eg) mmaped files?
> > 
> > Sure we can.
> > 
> > Or rather, some people might very well like to do it even for mutable
> > data. In fact, _especially_ for mutable data.
> > 
> > You might want to do things like "write out the state I verified just
> > a moment ago", and if it has changed since then, you *want* the result
> > to be invalid because the checksums no longer match - in case somebody
> > else changed the data you used for the state calculation and
> > verification in the meantime. It's very much why you'd want a separate
> > checksum in the first place.
> > 
> > Yeah, yeah,  you can - and people do - just do things like this with a
> > separate checksum. But if you know that the filesystem has internal
> > checksumming support _anyway_, you might want to use it, and basically
> > say "use this checksum, if the data doesn't match when I read it back
> > I want to get an IO error".
> > 
> > (The "data doesn't match" _could_ be just due to DRAM corruption etc,
> > of course. Some people care about things like that. You want
> > "verified" filesystem contents - it might not be about security, it
> > might simply be about "I have validated this data and if it's not the
> > same data any more it's useless and I need to re-generate it").
> > 
> > Am I a big believer in this model? No. Portability concerns (across
> > OS'es, across filesystems, even just across backups on the same exact
> > system) means that even if we did this, very few people would use it.
> > 
> > People who want this end up using an external checksum instead and do
> > it outside of and separately from the actual IO, because then they can
> > do it on existing systems.
> > 
> > So my argument is not "we want this". My argument is purely that some
> > buffered filesystem IO case isn't actually any different from the
> > traditional "I want access to the low-level sector hardware checksum
> > data". The use cases are basically exactly the same.
> > 
> > Of course, basically nobody does that hw sector checksum either, for
> > all the same reasons, even if it's been around for decades.
> > 
> > So my "checksum metadata interface" is not something I'm a big
> > believer in, but I really don't think it's really all _that_ different
> > from the whole "compressed format interface" that this whole patch
> > series is about. They are pretty much the same thing in many ways.
> 
> I see the similarity in the sense that we basically want to pass some
> extra metadata down with the read or write. So then do we want to add
> preadv3/pwritev3 for encoded I/O now so that checksums can use it in the
> future? The encoding metadata could go in this "struct io_how", either
> directly or in a separate structure with a pointer in "struct io_how".
> It could get messy with compat syscalls.

Ping. What's the path forward here? At this point, it seems like an
ioctl is the path of least resistance.
