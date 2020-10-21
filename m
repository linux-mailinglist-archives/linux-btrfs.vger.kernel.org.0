Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C91C295414
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Oct 2020 23:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506068AbgJUVWb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Wed, 21 Oct 2020 17:22:31 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:40438 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440933AbgJUVWb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Oct 2020 17:22:31 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id C6CFC867D87; Wed, 21 Oct 2020 17:22:29 -0400 (EDT)
Date:   Wed, 21 Oct 2020 17:22:29 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Hendrik Friedel <hendrik@friedels.name>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: parent transid verify failed: Fixed but re-appearing
Message-ID: <20201021212229.GF21815@hungrycats.org>
References: <em2ffec6ef-fe64-4239-b238-ae962d1826f6@ryzen>
 <20201021134635.GT5890@hungrycats.org>
 <em85884e42-e959-40f1-9eae-cd818450c26d@ryzen>
 <20201021193246.GE21815@hungrycats.org>
 <em33511ef4-7da1-4e7c-8b0c-8b8d7043164c@desktop-g0r648m>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <em33511ef4-7da1-4e7c-8b0c-8b8d7043164c@desktop-g0r648m>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Oct 21, 2020 at 09:15:06PM +0000, Hendrik Friedel wrote:
> > That would mean either that recovery already happened (if the corruption
> > was on disk and has been removed), or the problem never reached a disk
> > (if it is only in memory).
> Ok.
> Good news.
> 
> But it's still there:
> dduper --device /dev/sda1 --dir
> /srv/dev-disk-by-label-DataPool1/dduper_test/testfiles -r --dry-run
> parent transid verify failed on 8333716668416 wanted 357026 found 357028
> parent transid verify failed on 8333716668416 wanted 357026 found 357028
> parent transid verify failed on 8333716668416 wanted 357026 found 357028

> > >  > only one of your disks is silently dropping writes.  In that case
> > >  > btrfs will recover from ptvf by replacing the missing block from the
> > >  > other drive.  But there are no scrub errors or kernel messages related
> > >  > to this, so there aren't any symptoms of that happening, so it seems
> > >  > these ptvf are not coming from the disk.
> > >  And can this be confirmed somehow? Would be good to replace that disk
> > >  then...
> > 
> > These normally appear in 'btrfs dev stats', although there are various
> > coverage gaps with raid5/6 and (until recently) compressed data blocks.
> I do not use raid5/6 and I think I do not use compressed data.
> 
> btrfs dev stats /dev/sda1
> [/dev/sda1].write_io_errs    0
> [/dev/sda1].read_io_errs     0
> [/dev/sda1].flush_io_errs    0
> [/dev/sda1].corruption_errs  0
> [/dev/sda1].generation_errs  1
> 
> So, what does the generation_errs tell us?

Try btrfs dev stats on the filesystem mount point instead of the device.
We want to see if there are generation errors on both disks or just one.

This indicates there was a parent transid verify failure observed on
that disk in the past.

If there is one on the other drive too then the filesystem may be broken,
though I'm not sure how you're getting scrub to work in that case.

It's also possible you're hitting some other kernel bug, possibly a new
one.

> > 'btrfs scrub status -d' will give a per-drive error breakdown.
> 
> btrfs scrub status -d /dev/sda1
> scrub status for c4a6a2c9-5cf0-49b8-812a-0784953f9ba3
> scrub device /dev/sda1 (id 1) history
>         scrub started at Mon Oct 19 21:07:13 2020 and finished after
> 15:11:10
>         total bytes scrubbed: 6.56TiB with 0 errors
> 
> btrfs scrub status -d /dev/sdj1
> scrub status for c4a6a2c9-5cf0-49b8-812a-0784953f9ba3
> scrub device /dev/sdj1 (id 2) history
>         scrub started at Mon Oct 19 21:07:13 2020 and finished after
> 17:06:15
>         total bytes scrubbed: 6.56TiB with 0 errors
> 
> 
> > I haven't seen spurious ptvf errors on my test machines since the 5.4.30s,
> > but 5.4 has a lot of fixes that between-LTS kernels like 5.6 do not
> > always get.
> 
> Ok, I am compiling 5.9.1 now.
> 
> Apart from switching to the latest Kernel - what next step do you recommend?
> I tend to run a scrub again. Is it possible/useful to make it more verbose?
> What else?

scrub already reports pretty much everything it finds.  'btrfs scrub
start -Bd' will present a per-disk error count at the end.

> Greetings,
> Hendrik
> 
> 
