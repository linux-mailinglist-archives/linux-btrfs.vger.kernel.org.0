Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C372A504A
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Nov 2020 20:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgKCTli convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Tue, 3 Nov 2020 14:41:38 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:48370 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgKCTli (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Nov 2020 14:41:38 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 961DF88B602; Tue,  3 Nov 2020 14:41:04 -0500 (EST)
Date:   Tue, 3 Nov 2020 14:40:53 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Hendrik Friedel <hendrik@friedels.name>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: parent transid verify failed: Fixed but re-appearing
Message-ID: <20201103194045.GB28049@hungrycats.org>
References: <em2ffec6ef-fe64-4239-b238-ae962d1826f6@ryzen>
 <20201021134635.GT5890@hungrycats.org>
 <em85884e42-e959-40f1-9eae-cd818450c26d@ryzen>
 <20201021193246.GE21815@hungrycats.org>
 <em33511ef4-7da1-4e7c-8b0c-8b8d7043164c@desktop-g0r648m>
 <20201021212229.GF21815@hungrycats.org>
 <emeabab400-3f6d-4105-a4fd-67b0b832f97a@desktop-g0r648m>
 <20201021213854.GG21815@hungrycats.org>
 <em26d5dfe8-37cb-454c-9c03-a69cfb035949@desktop-g0r648m>
 <emf9252c3e-00b0-4c4a-a607-b61df779742f@desktop-g0r648m>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <emf9252c3e-00b0-4c4a-a607-b61df779742f@desktop-g0r648m>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 03, 2020 at 06:19:41PM +0000, Hendrik Friedel wrote:
> Hello Zygo,
> 
> can you further me help on this?
> 
> Regards,
> Hendrik
> 
> ------ Originalnachricht ------
> Von: "Hendrik Friedel" <hendrik@friedels.name>
> An: "Zygo Blaxell" <ce3g8jdj@umail.furryterror.org>
> Cc: "Btrfs BTRFS" <linux-btrfs@vger.kernel.org>
> Gesendet: 22.10.2020 21:30:14
> Betreff: Re[2]: parent transid verify failed: Fixed but re-appearing
> 
> > Hello Zygo,
> > 
> > thanks for your reply.
> > 
> > > >  [/dev/sda1].generation_errs  1
> > > >  [/dev/sdj1].generation_errs  0
> > > >  >
> > > >  So, on one of the drives only.
> > > 
> > > If one drive is silently dropping writes then it would explain the
> > > behavior so far; however, it's relatively rare to have a drive fail
> > > that specifically and quietly (and only when you use one particular
> > > application).
> > Well, we do not know that it occurs when I use one particular application. It could also occur a before and just become visible when using dduper.
> > 
> > > >  > scrub already reports pretty much everything it finds.  'btrfs scrub
> > > >  > start -Bd' will present a per-disk error count at the end.
> > > >  >
> > > > 
> > > >  So, should I do that now/next?
> > > 
> > > Sure, more scrubs are better.  They are supposed to be run regularly
> > > to detect drives going bad.
> > btrfs scrub start -Bd /dev/sda1
> > 
> > 
> > scrub device /dev/sda1 (id 1) done
> >         scrub started at Wed Oct 21 23:38:36 2020 and finished after 13:45:29
> >         total bytes scrubbed: 6.56TiB with 0 errors
> > 
> > But then again:
> > dduper --device /dev/sda1 --dir /srv/dev-disk-by-label-DataPool1/dduper_test/testfiles -r --dry-run
> > parent transid verify failed on 16500741947392 wanted 358407 found 358409
> > Ignoring transid failure

Wait...is that the kernel log, or the output of the dduper command?

commit 3e5f67f45b553045a34113cafb3c22180210a19f (tag: v0.04, origin/dockerbuild)
Author: Lakshmipathi <lakshmipathi.ganapathi@collabora.com>
Date:   Fri Sep 18 11:51:42 2020 +0530

file deduper:

    194 def btrfs_dump_csum(filename):
    195     global device_name
    196 
    197     btrfs_bin = "/usr/sbin/btrfs.static"
    198     if os.path.exists(btrfs_bin) is False:
    199         btrfs_bin = "btrfs"
    200 
    201     out = subprocess.Popen(
    202         [btrfs_bin, 'inspect-internal', 'dump-csum', filename, device_name],
    203         stdout=subprocess.PIPE,
    204         close_fds=True).stdout.readlines()
    205     return out

OK there's the problem:  it's dumping csums from a mounted filesystem by
reading the block device instead of using the TREE_SEARCH_V2 ioctl.
Don't do that, because it won't work.  ;)

The "parent transid verify failed" errors are harmless.  They are due
to the fact that a process reading the raw block device can never build
an accurate model of a live filesystem that is changing underneathi it.

If you manage to get some dedupe to happen, then that's a bonus.


> > 
> > > >  Anything else, I can do?
> > > 
> > > It looks like sda1 might be bad and it is working by replacing lost
> > > data from the mirror on sdj.  But this replacement should be happening
> > > automatically on read (and definitely on scrub), so you shouldn't ever
> > > see the same error twice, but it seems that you do.
> > 
> > Well, it is not the same error twice.

Earlier you quoted some duplicate lines.  Normally those get fixed after the
first line, so you never see the second.

> > Both the first ("on") value as well as the following two values change each time.
> > What's consistent is, that the wanted vs found always differ by two.
> > Here some samples:
> > parent transid verify failed on 9332119748608 wanted 204976 found 204978
> > parent transid verify failed on 9332147879936 wanted 204979 found 204981
> > parent transid verify failed on 16465691033600 wanted 352083 found 352085
> > parent transid verify failed on 16500741947392 wanted 358407 found 358409
> > 
> > > That makes it sound more like you've found a kernel bug.
> > 
> > And what do we do in order to narrow it down?
> > 
> > Regards,
> > Hendrik
> > 
> > > 
> 
> 
