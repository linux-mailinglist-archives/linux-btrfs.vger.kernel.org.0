Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3952D126EFA
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2019 21:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfLSUen (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Dec 2019 15:34:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:51456 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726981AbfLSUem (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Dec 2019 15:34:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 217B5B3F2;
        Thu, 19 Dec 2019 20:34:41 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id A5EBEDA939; Thu, 19 Dec 2019 21:34:38 +0100 (CET)
Date:   Thu, 19 Dec 2019 21:34:38 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.cz>, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v6 00/22] btrfs: async discard support
Message-ID: <20191219203438.GS3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Dennis Zhou <dennis@kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
References: <cover.1576195673.git.dennis@kernel.org>
 <20191217145541.GE3929@suse.cz>
 <20191218000600.GB2823@dennisz-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218000600.GB2823@dennisz-mbp>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 17, 2019 at 07:06:00PM -0500, Dennis Zhou wrote:
> > Regarding the slow io submission, I tried to increase the iops value,
> > default was 10, but 100 and 1000 made no change. Increasing the maximum
> > discard request size to 128M worked (when there was such long extent
> > ready). I was expecting a burst of like 4 consecutive IOs after a 600MB
> > file is deleted.  I did not try to tweak bps_limit because there was
> > nothing to limit.
> 
> Ah so there's actually a max time between discards set to 10 seconds as
> the maximum timeout is calculated over 6 hours. So if we only have 6
> extents, we'd discard 1 per hour(ish given it decays), but this is
> clamped to 10 seconds.
> 
> At least on our servers, we seem to discard at a reasonable rate to
> prevent performance penalties during a large number of reads and writes
> while maintaining reasonable write amplification performance. Also,
> metadata blocks aren't tracked, so on freeing of a whole metadata block
> group (minus relocation), we'll trickle discards slightly slower than
> expected.

So after watching the sysfs numbers, my observation is that the overall
strategy of the async discard is to wait for larger ranges and discard
one range every 10 seconds. This is a slow process, but this makes sense
when there are reads or writes going on so the discard IO penalty is
marginal.

Running full fstrim will flush all the discardable extents so there's a
way to reset the discardable queue. What I still don't see as optimal is
the single discard request sent per one period. Namely because there's
the iops_limit knob.

My idea is that each timeout, 'iops_limit' times 'max_discard_size' is
called, so the discard batches are large in total. However, this has
impact on reads and writes and also on the device itself, I'm not sure
if the too frequent discards are not making things worse (as this is a
known problem).

I'm interested in more strategies that you could have tested in your
setups, either bps based or rate limited etc. The current one seems ok
for first implementation but we might want to tune it once we get
feedback from more users.
