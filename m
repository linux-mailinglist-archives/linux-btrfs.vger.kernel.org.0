Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50599125973
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2019 03:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfLSCDm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 Dec 2019 21:03:42 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:42956 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfLSCDl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 Dec 2019 21:03:41 -0500
Received: by mail-qv1-f65.google.com with SMTP id dc14so1596169qvb.9
        for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2019 18:03:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ffemreUv4Y1pYnI36p3CCnbe6AfKqhgTeFHVOCjLPck=;
        b=CAxDM3erXHJLsYzxtR5V6fciznDwRhs1BloMMVlybs5DGYczYCX6EyHRjIDj3qz7F9
         tO26hnegeSyySWgnAvcXX+2TyZr2+xROXnIOdsciPEV9tKOV9jZM6VTxo7g25jN6lBdR
         tJBXZAoJ2TuUc/jyRAsOWf7yYzZPTXBSN0hFEPGswf8SEv5aOrtQFpc/C05te2DRto2j
         XInPMq1WyjWOusBL+1UaZp3sLoJ+EUMsvaM/AYk0gjLp2QUJ9nDfvXvBZedppQ2X9w72
         jjv8x6pTd2j6WaR3nLPh0EIVIEoSEX0EZF0IQ9pJfsrhYfLbCW4nIvCrUaGkBIaVR7Bi
         UqYg==
X-Gm-Message-State: APjAAAU0n3Cq898250+EKdiM9aZDowk3xTRNxHKithPG41W+YNg9U4HP
        lrJB0NLhI3aiMPW+RgO43HB+304Quax8GA==
X-Google-Smtp-Source: APXvYqwdFg4r/gVwDaiTbp5dcDgrKRLFVH3b8xGnHJRw+R2ExBZo8hqaxDGy//Mu6lyIg0m6O5aiqg==
X-Received: by 2002:a05:6214:11ab:: with SMTP id u11mr5222013qvv.193.1576721020682;
        Wed, 18 Dec 2019 18:03:40 -0800 (PST)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:480::1c63])
        by smtp.gmail.com with ESMTPSA id d5sm1284357qke.130.2019.12.18.18.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2019 18:03:40 -0800 (PST)
Date:   Wed, 18 Dec 2019 20:03:37 -0600
From:   Dennis Zhou <dennis@kernel.org>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     David Sterba <dsterba@suse.cz>, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v6 00/22] btrfs: async discard support
Message-ID: <20191219020337.GA25072@dennisz-mbp.dhcp.thefacebook.com>
References: <cover.1576195673.git.dennis@kernel.org>
 <20191217145541.GE3929@suse.cz>
 <20191218000600.GB2823@dennisz-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191218000600.GB2823@dennisz-mbp>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 17, 2019 at 07:06:00PM -0500, Dennis Zhou wrote:
> On Tue, Dec 17, 2019 at 03:55:41PM +0100, David Sterba wrote:
> > On Fri, Dec 13, 2019 at 04:22:09PM -0800, Dennis Zhou wrote:
> > > Hello,
> > > 
> > > Dave reported a lockdep issue [1]. I'm a bit surprised as I can't repro
> > > it, but it obviously is right. I believe I fixed the issue by moving the
> > > fully trimmed check outside of the block_group lock.  I mistakingly
> > > thought the btrfs_block_group lock subsumed btrfs_free_space_ctl
> > > tree_lock. This clearly isn't the case.
> > > 
> > > Changes in v6:
> > >  - Move the fully trimmed check outside of the block_group lock.
> > 
> > v6 passed fstests, with some weird test failures that don't seem to be
> > related to the patchset.
> 
> Yay!
> 
> > 
> > Meanwhile I did manual test how the discard behaves. The workload was
> > a series of linux git checkouts of various release tags (ie. this should
> > provide some freed extents and coalesce them eventually to get larger
> > chunks to discard), then a simple large file copy, sync, remove, sync.
> > 
> > The discards going down to the device were followin the maximum default
> > size (64M) but I observed that only one range was discarded per 10
> > seconds, while the other stats there are many more extents to discard.
> > 
> > For the large file it took like 5-10 cycles to send all the trimmed
> > ranges, the discardable_extents decreased by one each time until it
> > reached ... -1. At this point the discardable bytes were -16384, so
> > thre's some accounting problem.
> > 
> > This happened also when I deleted everything from the filesystem and ran
> > full balance.
> > 

Also were these both on fresh file systems so it seems reproducible for
you?

> 
> Oh no :(. I've been trying to repro with some limited checking out and
> syncing, then subsequently removing everything and calling balance. It
> is coming out to be 0 for me. I'll try harder to repro this and fix it.
> 
> > Regarding the slow io submission, I tried to increase the iops value,
> > default was 10, but 100 and 1000 made no change. Increasing the maximum
> > discard request size to 128M worked (when there was such long extent
> > ready). I was expecting a burst of like 4 consecutive IOs after a 600MB
> > file is deleted.  I did not try to tweak bps_limit because there was
> > nothing to limit.
> > 
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
> 
> 
> > So this is something to fix but otherwise the patchset seems to be ok
> > for adding to misc-next. Due to the timing of the end of the year and
> > that we're already at rc2, this will be the main feature in 5.6.
> 
> I'll report back if I continue having trouble reproing it.
> 

I spent the day trying to repro against ext/dzhou-async-discard-v6
without any luck... I've been running the following:

$ mkfs.btrfs -f /dev/nvme0n1
$ mount -t btrfs -o discard=async /dev/nvme0n1 mnt
$ cd mnt
$ bash ../age_btrfs.sh .

where age_btrfs.sh is from [1].

If I delete arbitrary subvolumes, sync, and then run balance:
$ btrfs balance start --full-balance .
It all seems to resolve to 0 after some time. I haven't seen a negative
case on either of my 2 boxes. I've also tried unmounting and then
remounting, deleting and removing more free space items.

I'm still considering how this can happen. Possibly bad load of free
space cache and then freeing of the block group? Because being off by
just 1 and it not accumulating seems to be a real corner case here.

Adding asserts in btrfs_discard_update_discardable() might give us
insight to which callsite is responsible for going below 0.

[1] https://github.com/osandov/osandov-linux/blob/master/scripts/age_btrfs.sh

Thanks,
Dennis
