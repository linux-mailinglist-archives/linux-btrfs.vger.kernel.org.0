Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A8438AF64
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 14:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241314AbhETNAL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 09:00:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:35674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243088AbhETM7H (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 08:59:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 81D43AC5B;
        Thu, 20 May 2021 12:57:42 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 9767EDA7F9; Thu, 20 May 2021 14:55:08 +0200 (CEST)
Date:   Thu, 20 May 2021 14:55:08 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] btrfs: scrub: per-device bandwidth control
Message-ID: <20210520125508.GA7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
References: <20210518144935.15835-1-dsterba@suse.com>
 <alpine.DEB.2.22.394.2105200927570.1771368@ramsan.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2105200927570.1771368@ramsan.of.borg>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 20, 2021 at 09:43:10AM +0200, Geert Uytterhoeven wrote:
> > - values written to the file accept suffixes like K, M
> > - file is in the per-device directory /sys/fs/btrfs/FSID/devinfo/DEVID/scrub_speed_max
> > - 0 means use default priority of IO
> >
> > The scheduler is a simple deadline one and the accuracy is up to nearest
> > 128K.
> >
> > Signed-off-by: David Sterba <dsterba@suse.com>
> 
> Thanks for your patch, which is now commit b4a9f4bee31449bc ("btrfs:
> scrub: per-device bandwidth control") in linux-next.
> 
> noreply@ellerman.id.au reported the following failures for e.g.
> m68k/defconfig:
> 
> ERROR: modpost: "__udivdi3" [fs/btrfs/btrfs.ko] undefined!
> ERROR: modpost: "__divdi3" [fs/btrfs/btrfs.ko] undefined!

I'll fix it, thanks for the report.

> > +static void scrub_throttle(struct scrub_ctx *sctx)
> > +{
> > +	const int time_slice = 1000;
> > +	struct scrub_bio *sbio;
> > +	struct btrfs_device *device;
> > +	s64 delta;
> > +	ktime_t now;
> > +	u32 div;
> > +	u64 bwlimit;
> > +
> > +	sbio = sctx->bios[sctx->curr];
> > +	device = sbio->dev;
> > +	bwlimit = READ_ONCE(device->scrub_speed_max);
> > +	if (bwlimit == 0)
> > +		return;
> > +
> > +	/*
> > +	 * Slice is divided into intervals when the IO is submitted, adjust by
> > +	 * bwlimit and maximum of 64 intervals.
> > +	 */
> > +	div = max_t(u32, 1, (u32)(bwlimit / (16 * 1024 * 1024)));
> > +	div = min_t(u32, 64, div);
> > +
> > +	/* Start new epoch, set deadline */
> > +	now = ktime_get();
> > +	if (sctx->throttle_deadline == 0) {
> > +		sctx->throttle_deadline = ktime_add_ms(now, time_slice / div);
> 
> ERROR: modpost: "__udivdi3" [fs/btrfs/btrfs.ko] undefined!
> 
> div_u64(bwlimit, div)
> 
> > +		sctx->throttle_sent = 0;
> > +	}
> > +
> > +	/* Still in the time to send? */
> > +	if (ktime_before(now, sctx->throttle_deadline)) {
> > +		/* If current bio is within the limit, send it */
> > +		sctx->throttle_sent += sbio->bio->bi_iter.bi_size;
> > +		if (sctx->throttle_sent <= bwlimit / div)
> > +			return;
> > +
> > +		/* We're over the limit, sleep until the rest of the slice */
> > +		delta = ktime_ms_delta(sctx->throttle_deadline, now);
> > +	} else {
> > +		/* New request after deadline, start new epoch */
> > +		delta = 0;
> > +	}
> > +
> > +	if (delta)
> > +		schedule_timeout_interruptible(delta * HZ / 1000);
> 
> ERROR: modpost: "__divdi3" [fs/btrfs/btrfs.ko] undefined!
> 
> I'm a bit surprised gcc doesn't emit code for the division by the
> constant 1000, but emits a call to __divdi3().  So this has to become
> div_u64(), too.
> 
> > +	/* Next call will start the deadline period */
> > +	sctx->throttle_deadline = 0;
> > +}
> 
> BTW, any chance you can start adding lore Link: tags to your commits, to
> make it easier to find the email thread to reply to when reporting a
> regression?

Well, no I'm not going to do that, sorry. It should be easy enough to
paste the patch subject to the search field on lore.k.org and click the
link leading to the mail, I do that all the time. Making sure that
patches have all the tags and information takes time already so I'm not
too keen to spend time on adding links.
