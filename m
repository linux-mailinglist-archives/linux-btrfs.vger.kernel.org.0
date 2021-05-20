Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CAB389F0D
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 May 2021 09:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhETHoh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 20 May 2021 03:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhETHog (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 20 May 2021 03:44:36 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E2AC06175F
        for <linux-btrfs@vger.kernel.org>; Thu, 20 May 2021 00:43:13 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:9cc6:7165:bcc2:1e70])
        by xavier.telenet-ops.be with bizsmtp
        id 6vjB2500531btb901vjBWU; Thu, 20 May 2021 09:43:11 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1ljdKo-007R7k-PS; Thu, 20 May 2021 09:43:10 +0200
Date:   Thu, 20 May 2021 09:43:10 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     David Sterba <dsterba@suse.com>
cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] btrfs: scrub: per-device bandwidth control
In-Reply-To: <20210518144935.15835-1-dsterba@suse.com>
Message-ID: <alpine.DEB.2.22.394.2105200927570.1771368@ramsan.of.borg>
References: <20210518144935.15835-1-dsterba@suse.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

 	Hi David,

On Tue, 18 May 2021, David Sterba wrote:
> Add sysfs interface to limit io during scrub. We relied on the ionice
> interface to do that, eg. the idle class let the system usable while
> scrub was running. This has changed when mq-deadline got widespread and
> did not implement the scheduling classes. That was a CFQ thing that got
> deleted. We've got numerous complaints from users about degraded
> performance.
>
> Currently only BFQ supports that but it's not a common scheduler and we
> can't ask everybody to switch to it.
>
> Alternatively the cgroup io limiting can be used but that also a
> non-trivial setup (v2 required, the controller must be enabled on the
> system). This can still be used if desired.
>
> Other ideas that have been explored: piggy-back on ionice (that is set
> per-process and is accessible) and interpret the class and classdata as
> bandwidth limits, but this does not have enough flexibility as there are
> only 8 allowed and we'd have to map fixed limits to each value. Also
> adjusting the value would need to lookup the process that currently runs
> scrub on the given device, and the value is not sticky so would have to
> be adjusted each time scrub runs.
>
> Running out of options, sysfs does not look that bad:
>
> - it's accessible from scripts, or udev rules
> - the name is similar to what MD-RAID has
>  (/proc/sys/dev/raid/speed_limit_max or /sys/block/mdX/md/sync_speed_max)
> - the value is sticky at least for filesystem mount time
> - adjusting the value has immediate effect
> - sysfs is available in constrained environments (eg. system rescue)
> - the limit also applies to device replace
>
> Sysfs:
>
> - raw value is in bytes
> - values written to the file accept suffixes like K, M
> - file is in the per-device directory /sys/fs/btrfs/FSID/devinfo/DEVID/scrub_speed_max
> - 0 means use default priority of IO
>
> The scheduler is a simple deadline one and the accuracy is up to nearest
> 128K.
>
> Signed-off-by: David Sterba <dsterba@suse.com>

Thanks for your patch, which is now commit b4a9f4bee31449bc ("btrfs:
scrub: per-device bandwidth control") in linux-next.

noreply@ellerman.id.au reported the following failures for e.g.
m68k/defconfig:

ERROR: modpost: "__udivdi3" [fs/btrfs/btrfs.ko] undefined!
ERROR: modpost: "__divdi3" [fs/btrfs/btrfs.ko] undefined!

> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1988,6 +1993,60 @@ static void scrub_page_put(struct scrub_page *spage)
> 	}
> }
>
> +/*
> + * Throttling of IO submission, bandwidth-limit based, the timeslice is 1
> + * second.  Limit can be set via /sys/fs/UUID/devinfo/devid/scrub_speed_max.
> + */
> +static void scrub_throttle(struct scrub_ctx *sctx)
> +{
> +	const int time_slice = 1000;
> +	struct scrub_bio *sbio;
> +	struct btrfs_device *device;
> +	s64 delta;
> +	ktime_t now;
> +	u32 div;
> +	u64 bwlimit;
> +
> +	sbio = sctx->bios[sctx->curr];
> +	device = sbio->dev;
> +	bwlimit = READ_ONCE(device->scrub_speed_max);
> +	if (bwlimit == 0)
> +		return;
> +
> +	/*
> +	 * Slice is divided into intervals when the IO is submitted, adjust by
> +	 * bwlimit and maximum of 64 intervals.
> +	 */
> +	div = max_t(u32, 1, (u32)(bwlimit / (16 * 1024 * 1024)));
> +	div = min_t(u32, 64, div);
> +
> +	/* Start new epoch, set deadline */
> +	now = ktime_get();
> +	if (sctx->throttle_deadline == 0) {
> +		sctx->throttle_deadline = ktime_add_ms(now, time_slice / div);

ERROR: modpost: "__udivdi3" [fs/btrfs/btrfs.ko] undefined!

div_u64(bwlimit, div)

> +		sctx->throttle_sent = 0;
> +	}
> +
> +	/* Still in the time to send? */
> +	if (ktime_before(now, sctx->throttle_deadline)) {
> +		/* If current bio is within the limit, send it */
> +		sctx->throttle_sent += sbio->bio->bi_iter.bi_size;
> +		if (sctx->throttle_sent <= bwlimit / div)
> +			return;
> +
> +		/* We're over the limit, sleep until the rest of the slice */
> +		delta = ktime_ms_delta(sctx->throttle_deadline, now);
> +	} else {
> +		/* New request after deadline, start new epoch */
> +		delta = 0;
> +	}
> +
> +	if (delta)
> +		schedule_timeout_interruptible(delta * HZ / 1000);

ERROR: modpost: "__divdi3" [fs/btrfs/btrfs.ko] undefined!

I'm a bit surprised gcc doesn't emit code for the division by the
constant 1000, but emits a call to __divdi3().  So this has to become
div_u64(), too.

> +	/* Next call will start the deadline period */
> +	sctx->throttle_deadline = 0;
> +}

BTW, any chance you can start adding lore Link: tags to your commits, to
make it easier to find the email thread to reply to when reporting a
regression?

Thanks!

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
