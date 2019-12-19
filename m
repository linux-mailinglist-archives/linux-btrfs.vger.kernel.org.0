Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0E5F126F95
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2019 22:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfLSVSA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Dec 2019 16:18:00 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42625 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfLSVSA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Dec 2019 16:18:00 -0500
Received: by mail-qk1-f194.google.com with SMTP id z14so4612264qkg.9
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Dec 2019 13:17:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5onm6nDoPgmODEVYT9slq6NiAIJtieZmSJ2zCTU0LVQ=;
        b=oRCBDy8tsjEeBPLftL2UZ3XZyCjp/egZFKIkQzU4Pfrur+89MsgvypjpaoHc4E6vc3
         eB58Shsp7ze11FnHXGRrZNPA6h8ig0euNIXvP5j7eOnXZlt3hzU75AyVnNfzNoNMbJ79
         Rr8GhWj6A7xV29qQwPzT7Ivtmt2ZusIyticBneprlFLn545whldunqYTdIMhIUM5hbL5
         BfYeWxrlFnxH2fRMDSlW035rrfG6ETzLwhlEiR1mEemQkkmpld6peUSSP9n572LQ4MTY
         s4GOQT/8g8idmg35m/+ckS3+05GBm1Os2Zkkmm8l0lhoXLkWRp+l1UfXhxF0R9G6FYfz
         78oQ==
X-Gm-Message-State: APjAAAVfDbd1cCGVF3/6HUsn8JT3y3tZ0TvP/UGKCeS06HVHVUvdqykv
        TmL+oz8UxdUWdEhwHUuCZHY=
X-Google-Smtp-Source: APXvYqwwXpz/r5jY6RJubGibnXegQv9XbbVA8b+33zvmiNATdgdVDb9nFUGGPh0QqReZ+IxsHpkb+A==
X-Received: by 2002:ae9:c011:: with SMTP id u17mr10014796qkk.480.1576790279104;
        Thu, 19 Dec 2019 13:17:59 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:480::7ea5])
        by smtp.gmail.com with ESMTPSA id t29sm1579996qkm.27.2019.12.19.13.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 13:17:58 -0800 (PST)
Date:   Thu, 19 Dec 2019 15:17:55 -0600
From:   Dennis Zhou <dennis@kernel.org>
To:     dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v6 00/22] btrfs: async discard support
Message-ID: <20191219211755.GA38803@dennisz-mbp.dhcp.thefacebook.com>
References: <cover.1576195673.git.dennis@kernel.org>
 <20191217145541.GE3929@suse.cz>
 <20191218000600.GB2823@dennisz-mbp>
 <20191219203438.GS3929@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219203438.GS3929@twin.jikos.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 19, 2019 at 09:34:38PM +0100, David Sterba wrote:
> On Tue, Dec 17, 2019 at 07:06:00PM -0500, Dennis Zhou wrote:
> > > Regarding the slow io submission, I tried to increase the iops value,
> > > default was 10, but 100 and 1000 made no change. Increasing the maximum
> > > discard request size to 128M worked (when there was such long extent
> > > ready). I was expecting a burst of like 4 consecutive IOs after a 600MB
> > > file is deleted.  I did not try to tweak bps_limit because there was
> > > nothing to limit.
> > 
> > Ah so there's actually a max time between discards set to 10 seconds as
> > the maximum timeout is calculated over 6 hours. So if we only have 6
> > extents, we'd discard 1 per hour(ish given it decays), but this is
> > clamped to 10 seconds.
> > 
> > At least on our servers, we seem to discard at a reasonable rate to
> > prevent performance penalties during a large number of reads and writes
> > while maintaining reasonable write amplification performance. Also,
> > metadata blocks aren't tracked, so on freeing of a whole metadata block
> > group (minus relocation), we'll trickle discards slightly slower than
> > expected.
> 
> So after watching the sysfs numbers, my observation is that the overall
> strategy of the async discard is to wait for larger ranges and discard
> one range every 10 seconds. This is a slow process, but this makes sense
> when there are reads or writes going on so the discard IO penalty is
> marginal.
> 

Yeah, (un)fortunately on our systems we're running chef fairly
frequently which results in a lot of IO in addition to package
deployment. This actually drives the system to have a fairly high steady
state number of untrimmed extents and results in a bit faster paced
discarding rate.

> Running full fstrim will flush all the discardable extents so there's a
> way to reset the discardable queue. What I still don't see as optimal is
> the single discard request sent per one period. Namely because there's
> the iops_limit knob.
> 

Yeah, it's not really ideal at the moment for much slower paced systems
such as our own laptops. Adding persistence would also make a big
difference here.

> My idea is that each timeout, 'iops_limit' times 'max_discard_size' is
> called, so the discard batches are large in total. However, this has
> impact on reads and writes and also on the device itself, I'm not sure
> if the too frequent discards are not making things worse (as this is a
> known problem).
> 

I spent a bit of time looking at the impact of discard on some drives
and my conclusion was that the iops rate is more impactful than the size
of the discards (within reason, which is why there's the
max_discard_size). On a particular drive, I noticed if I went over 10
iops of discards on a sustained simple read write workload, the
latencies would double. That's kind of where the 10 iops limit comes
from. Given the latency impact, that's why this more or less trickles it
down in pieces rather than as a larger batch.

> I'm interested in more strategies that you could have tested in your
> setups, either bps based or rate limited etc. The current one seems ok
> for first implementation but we might want to tune it once we get
> feedback from more users.

Definitely, one of the things I want to do is experiment with different
limits and see how this all correlates with write amplification. I'm
sure there's some happy medium that we can identify that's a lot less
arbitrary than what's current set forth. I imagine it should result in
some graph that we can correlate delay and rate of discarding to a
particular write amp given a fixed workload.

Thanks,
Dennis
