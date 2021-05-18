Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A4E43881D5
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 May 2021 23:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242302AbhERVKJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 May 2021 17:10:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:40160 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352353AbhERVKJ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 May 2021 17:10:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 48495B251;
        Tue, 18 May 2021 21:08:50 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 3D00CDB228; Tue, 18 May 2021 23:06:17 +0200 (CEST)
Date:   Tue, 18 May 2021 23:06:17 +0200
From:   David Sterba <dsterba@suse.cz>
To:     waxhead <waxhead@dirtcellar.net>
Cc:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: scrub: per-device bandwidth control
Message-ID: <20210518210617.GU7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, waxhead <waxhead@dirtcellar.net>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20210518144935.15835-1-dsterba@suse.com>
 <45403ea9-221c-c7eb-faa8-50c9da8e38e9@dirtcellar.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45403ea9-221c-c7eb-faa8-50c9da8e38e9@dirtcellar.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 18, 2021 at 10:15:57PM +0200, waxhead wrote:
> Being just the average user I ponder if this feature is an absolute 
> hard-limit or not? E.g. would this limit be applied all the time even if 
> the filesystem is idle? or is it dynamic in the sense that scrub can run 
> a full speed if the filesystem is (reasonably) idle.

The limit is absolute so even if the device is idle, scrub won't go
faster.  Determining the "is it idle" is the hard part and would require
information that the io scheduler has. With that interpret the numbers
(eg. in-flight requests and overall size) and hope that it would match
the actual device performance to make the guesses.

I vaguely remember trying something like that but it became too similar
to a full blown io scheduler, so that's not the right way. There used to
be some kind of block device congestion query but this got removed.

> If this is or could somehow be dynamic would it be possible to set the 
> value to something like for example 30M:15M which may be interpreted as 
> 30MiB/s when not idle and 15MiB/s when not idle.
> 
> I myself would actually much prefer if it was possible to set a reserved 
> bandwidth for all non-scrub related stuff. for example maybe up to max 
> 75% of the bandwidth always reserved for non-scrub related read/writes.
> This would allow the scrub to run at full speed if no other I/O is is 
> taking place in which case the scrub would be limited to 25%.

This looks similar to the md-raid minimum speed setting, for scrub I
picked only the maximum, but there's /proc/sys/dev/raid/speed_limit_min
that in the example would be 15MiB/s (and _max 30MiB/s). This could be
implemented once there's a way to know the idle status. Maybe something
will emerge over time, right now I don't know how to do it.
