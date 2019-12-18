Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87C6F123B49
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2019 01:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfLRAGE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Dec 2019 19:06:04 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33852 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfLRAGE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Dec 2019 19:06:04 -0500
Received: by mail-qt1-f193.google.com with SMTP id 5so475468qtz.1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Dec 2019 16:06:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LV8Em1NqTWTZLn4IRndNhrGNntDJ72y3qWoNiPMBKnc=;
        b=myoijaMwIxB9NC1dN1lk4vJaqspkx+06rtwO2LH+Qi+bmKBOFtfFBlt1SMJzG46CLj
         q2v46JFS1EMNWMmH9GIOut9mIYFWHuQZYLLDU8cCDtpzz1B8ag8h8MRMekejt8eie2M0
         9Gfy4OeR4Ce2wxjIVql+Ci78bBHBZc4H8yWBJWKVV5Ax5BIKxrCLy1jJ8NNkDFtu6uGu
         paMt9G+YCtE+y3t6n7VYDIqV8Zx1ErzUUyQuMWySSfcYH+uY9O0oJaGaVuKxdRpnl/Mr
         ybxTw69qat+8URfakm/iGdFNQ9K01k7wb2s+Evqw73swo1CEoclwsfkF/0jjgCBlqPJf
         uJiA==
X-Gm-Message-State: APjAAAXuJuACYXwqejTSPnKkjuxMpyCIKAdTa0jOHl8j1lmorcKi8VdJ
        /4McNhviIyjfZsgRi1aM6JM=
X-Google-Smtp-Source: APXvYqxHM+RQzei3qp/9qaY7D2Cb1LFA/IOJh7Ik+Hlx58bEgRqRGm9a4EG1Tc1zk3IUdTVL76QpTw==
X-Received: by 2002:ac8:86b:: with SMTP id x40mr586367qth.366.1576627563264;
        Tue, 17 Dec 2019 16:06:03 -0800 (PST)
Received: from dennisz-mbp ([2620:10d:c091:500::1246])
        by smtp.gmail.com with ESMTPSA id s20sm75932qkj.100.2019.12.17.16.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2019 16:06:02 -0800 (PST)
Date:   Tue, 17 Dec 2019 19:06:00 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     David Sterba <dsterba@suse.cz>
Cc:     David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Omar Sandoval <osandov@osandov.com>, kernel-team@fb.com,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v6 00/22] btrfs: async discard support
Message-ID: <20191218000600.GB2823@dennisz-mbp>
References: <cover.1576195673.git.dennis@kernel.org>
 <20191217145541.GE3929@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217145541.GE3929@suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 17, 2019 at 03:55:41PM +0100, David Sterba wrote:
> On Fri, Dec 13, 2019 at 04:22:09PM -0800, Dennis Zhou wrote:
> > Hello,
> > 
> > Dave reported a lockdep issue [1]. I'm a bit surprised as I can't repro
> > it, but it obviously is right. I believe I fixed the issue by moving the
> > fully trimmed check outside of the block_group lock.  I mistakingly
> > thought the btrfs_block_group lock subsumed btrfs_free_space_ctl
> > tree_lock. This clearly isn't the case.
> > 
> > Changes in v6:
> >  - Move the fully trimmed check outside of the block_group lock.
> 
> v6 passed fstests, with some weird test failures that don't seem to be
> related to the patchset.

Yay!

> 
> Meanwhile I did manual test how the discard behaves. The workload was
> a series of linux git checkouts of various release tags (ie. this should
> provide some freed extents and coalesce them eventually to get larger
> chunks to discard), then a simple large file copy, sync, remove, sync.
> 
> The discards going down to the device were followin the maximum default
> size (64M) but I observed that only one range was discarded per 10
> seconds, while the other stats there are many more extents to discard.
> 
> For the large file it took like 5-10 cycles to send all the trimmed
> ranges, the discardable_extents decreased by one each time until it
> reached ... -1. At this point the discardable bytes were -16384, so
> thre's some accounting problem.
> 
> This happened also when I deleted everything from the filesystem and ran
> full balance.
> 

Oh no :(. I've been trying to repro with some limited checking out and
syncing, then subsequently removing everything and calling balance. It
is coming out to be 0 for me. I'll try harder to repro this and fix it.

> Regarding the slow io submission, I tried to increase the iops value,
> default was 10, but 100 and 1000 made no change. Increasing the maximum
> discard request size to 128M worked (when there was such long extent
> ready). I was expecting a burst of like 4 consecutive IOs after a 600MB
> file is deleted.  I did not try to tweak bps_limit because there was
> nothing to limit.
> 

Ah so there's actually a max time between discards set to 10 seconds as
the maximum timeout is calculated over 6 hours. So if we only have 6
extents, we'd discard 1 per hour(ish given it decays), but this is
clamped to 10 seconds.

At least on our servers, we seem to discard at a reasonable rate to
prevent performance penalties during a large number of reads and writes
while maintaining reasonable write amplification performance. Also,
metadata blocks aren't tracked, so on freeing of a whole metadata block
group (minus relocation), we'll trickle discards slightly slower than
expected.


> So this is something to fix but otherwise the patchset seems to be ok
> for adding to misc-next. Due to the timing of the end of the year and
> that we're already at rc2, this will be the main feature in 5.6.

I'll report back if I continue having trouble reproing it.

Thanks v5.6 sounds good to me!
Dennis
