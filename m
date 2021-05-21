Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB37138C9EF
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 May 2021 17:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbhEUPUS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 May 2021 11:20:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:54226 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234054AbhEUPUM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 May 2021 11:20:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621610327;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3N2PUHGxNFtqL17T5oc1TOpT1nz6cla7cbqvtLWhevg=;
        b=KFZastnGdCEXZrlOqAnzT4syC45AmB/ZYZl4OqTt5ERMjwaZevP2mpU0QImWSliNHxuvvk
        pn+RD6237Hf5mdW8SO0qOf4WJ2J4u0BizN3S/iQVk7geGI+L3JT8xgQAN8JoPQtfV8onY2
        8f6ortDqmbwpka1LqX6484giz9i/Id8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621610327;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3N2PUHGxNFtqL17T5oc1TOpT1nz6cla7cbqvtLWhevg=;
        b=KvTIHw2DJ6jwIyfQzOTPqNN+P4r2uvc5CJFvSJsw7y/kkfqJx/q2GpLPilHFLJ1fcu9O97
        lB2vGzQqMJzHrTBA==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C586EACF5;
        Fri, 21 May 2021 15:18:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 5C013DA72C; Fri, 21 May 2021 17:16:13 +0200 (CEST)
Date:   Fri, 21 May 2021 17:16:13 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: scrub: per-device bandwidth control
Message-ID: <20210521151613.GN7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210518144935.15835-1-dsterba@suse.com>
 <alpine.DEB.2.22.394.2105200927570.1771368@ramsan.of.borg>
 <CAK8P3a3_O5CdbUqvJsnTh5p0RbSCsXyFhkO6afaLsnwf176Kiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3_O5CdbUqvJsnTh5p0RbSCsXyFhkO6afaLsnwf176Kiw@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 20, 2021 at 03:14:03PM +0200, Arnd Bergmann wrote:
> On Thu, May 20, 2021 at 9:43 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, 18 May 2021, David Sterba wrote:
> > > +     /* Start new epoch, set deadline */
> > > +     now = ktime_get();
> > > +     if (sctx->throttle_deadline == 0) {
> > > +             sctx->throttle_deadline = ktime_add_ms(now, time_slice / div);
> >
> > ERROR: modpost: "__udivdi3" [fs/btrfs/btrfs.ko] undefined!
> >
> > div_u64(bwlimit, div)
> 
> If 'time_slice' is in nanoseconds, the best interface to use
> is ktime_divns().

It's in miliseconds and the division above is int/int, the problematic
one is below.
> 
> > > +             sctx->throttle_sent = 0;
> > > +     }
> > > +
> > > +     /* Still in the time to send? */
> > > +     if (ktime_before(now, sctx->throttle_deadline)) {
> > > +             /* If current bio is within the limit, send it */
> > > +             sctx->throttle_sent += sbio->bio->bi_iter.bi_size;
> > > +             if (sctx->throttle_sent <= bwlimit / div)
> > > +                     return;
> 
> Doesn't this also need to be changed?
> 
> > > +             /* We're over the limit, sleep until the rest of the slice */
> > > +             delta = ktime_ms_delta(sctx->throttle_deadline, now);
> > > +     } else {
> > > +             /* New request after deadline, start new epoch */
> > > +             delta = 0;
> > > +     }
> > > +
> > > +     if (delta)
> > > +             schedule_timeout_interruptible(delta * HZ / 1000);
> >
> > ERROR: modpost: "__divdi3" [fs/btrfs/btrfs.ko] undefined!
> >
> > I'm a bit surprised gcc doesn't emit code for the division by the
> > constant 1000, but emits a call to __divdi3().  So this has to become
> > div_u64(), too.
> 
> There is schedule_hrtimeout(), which takes a ktime_t directly
> but has slightly different behavior. There is also an msecs_to_jiffies
> helper that should produce a fast division.

I'll use msecs_to_jiffies, thanks. If 'hr' in schedule_hrtimeout stands
for high resolution, it's not necessary here.
