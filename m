Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 134AF295451
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 23:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506292AbgJUVi5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 21 Oct 2020 17:38:57 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:43080 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506290AbgJUVi5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 17:38:57 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 9097B867E03; Wed, 21 Oct 2020 17:38:54 -0400 (EDT)
Date:   Wed, 21 Oct 2020 17:38:54 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Hendrik Friedel <hendrik@friedels.name>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: parent transid verify failed: Fixed but re-appearing
Message-ID: <20201021213854.GG21815@hungrycats.org>
References: <em2ffec6ef-fe64-4239-b238-ae962d1826f6@ryzen>
 <20201021134635.GT5890@hungrycats.org>
 <em85884e42-e959-40f1-9eae-cd818450c26d@ryzen>
 <20201021193246.GE21815@hungrycats.org>
 <em33511ef4-7da1-4e7c-8b0c-8b8d7043164c@desktop-g0r648m>
 <20201021212229.GF21815@hungrycats.org>
 <emeabab400-3f6d-4105-a4fd-67b0b832f97a@desktop-g0r648m>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <emeabab400-3f6d-4105-a4fd-67b0b832f97a@desktop-g0r648m>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 21, 2020 at 09:26:24PM +0000, Hendrik Friedel wrote:
> Hello,
> 
> thanks for your reply.
> 
> > >  So, what does the generation_errs tell us?
> > 
> > Try btrfs dev stats on the filesystem mount point instead of the device.
> > We want to see if there are generation errors on both disks or just one.
> > 
> > This indicates there was a parent transid verify failure observed on
> > that disk in the past.
> > 
> btrfs dev stats /srv/DataPool
> [/dev/sda1].write_io_errs    0
> [/dev/sda1].read_io_errs     0
> [/dev/sda1].flush_io_errs    0
> [/dev/sda1].corruption_errs  0
> [/dev/sda1].generation_errs  1
> [/dev/sdj1].write_io_errs    0
> [/dev/sdj1].read_io_errs     0
> [/dev/sdj1].flush_io_errs    0
> [/dev/sdj1].corruption_errs  0
> [/dev/sdj1].generation_errs  0
> > 
> So, on one of the drives only.

If one drive is silently dropping writes then it would explain the
behavior so far; however, it's relatively rare to have a drive fail
that specifically and quietly (and only when you use one particular
application).  Not impossible, but only one in 10,000.

> > If there is one on the other drive too then the filesystem may be broken,
> > though I'm not sure how you're getting scrub to work in that case.
> > 
> So, we are lucky, it seems?

Filesystems are supposed to be deterministic.  Luck has no place here.  ;)

> > scrub already reports pretty much everything it finds.  'btrfs scrub
> > start -Bd' will present a per-disk error count at the end.
> > 
> 
> So, should I do that now/next?

Sure, more scrubs are better.  They are supposed to be run regularly
to detect drives going bad.

> Anything else, I can do?

It looks like sda1 might be bad and it is working by replacing lost
data from the mirror on sdj.  But this replacement should be happening
automatically on read (and definitely on scrub), so you shouldn't ever
see the same error twice, but it seems that you do.

That makes it sound more like you've found a kernel bug.

> Regards,
> Hendrik
> 
> > 
> > >  Greetings,
> > >  Hendrik
> > > 
> > > 
> 
> 
