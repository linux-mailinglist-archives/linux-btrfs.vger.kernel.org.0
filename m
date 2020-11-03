Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5372A2A5A6A
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Nov 2020 00:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729575AbgKCXFy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Nov 2020 18:05:54 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:40696 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729275AbgKCXFy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Nov 2020 18:05:54 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id EF1F788C37C; Tue,  3 Nov 2020 18:05:51 -0500 (EST)
Date:   Tue, 3 Nov 2020 18:05:51 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Hendrik Friedel <hendrik@friedels.name>
Cc:     lakshmipathi.ganapathi@collabora.com,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: parent transid verify failed: Fixed but re-appearing
Message-ID: <20201103230550.GC28049@hungrycats.org>
References: <em85884e42-e959-40f1-9eae-cd818450c26d@ryzen>
 <20201021193246.GE21815@hungrycats.org>
 <em33511ef4-7da1-4e7c-8b0c-8b8d7043164c@desktop-g0r648m>
 <20201021212229.GF21815@hungrycats.org>
 <emeabab400-3f6d-4105-a4fd-67b0b832f97a@desktop-g0r648m>
 <20201021213854.GG21815@hungrycats.org>
 <em26d5dfe8-37cb-454c-9c03-a69cfb035949@desktop-g0r648m>
 <emf9252c3e-00b0-4c4a-a607-b61df779742f@desktop-g0r648m>
 <20201103194045.GB28049@hungrycats.org>
 <em37950c9c-2dbf-41b9-89cd-2390bc503bd1@desktop-g0r648m>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <em37950c9c-2dbf-41b9-89cd-2390bc503bd1@desktop-g0r648m>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 03, 2020 at 08:40:40PM +0000, Hendrik Friedel wrote:
> Hello Zygo, hello Lakshmipathi,
> 
> @Lakshmipathi: as you suggested I consulted the BTRFS-Mailing list on this
> issue:
> https://github.com/Lakshmipathi/dduper/issues/39
> 
> Zygo was so kind to help me and he suspects the error to lie within dduper.
> > >  > > Sure, more scrubs are better.  They are supposed to be run regularly
> > >  > > to detect drives going bad.
> > >  > btrfs scrub start -Bd /dev/sda1
> > >  >
> > >  >
> > >  > scrub device /dev/sda1 (id 1) done
> > >  >         scrub started at Wed Oct 21 23:38:36 2020 and finished after 13:45:29
> > >  >         total bytes scrubbed: 6.56TiB with 0 errors
> > >  >
> > >  > But then again:
> > >  > dduper --device /dev/sda1 --dir /srv/dev-disk-by-label-DataPool1/dduper_test/testfiles -r --dry-run
> > >  > parent transid verify failed on 16500741947392 wanted 358407 found 358409
> > >  > Ignoring transid failure
> > 
> > Wait...is that the kernel log, or the output of the dduper command?
> > 
> It is on the commandline once I run the command; thus I suspect it is the
> dduper output. But of course sometimes the Kernel-Messages appear directly
> on the commandline. I do not know how to tell.

Kernel logs usually have timestamps, and will also be logged in files
like /var/log/kern.log and /var/log/dmesg (depending on the distro).
You can also review past kernel logs with the 'dmesg' utility.

The output of the command will just appear in the terminal window, or a
log file if you redirect stdout and stderr to a file.

> > commit 3e5f67f45b553045a34113cafb3c22180210a19f (tag: v0.04, origin/dockerbuild)
> > Author: Lakshmipathi <lakshmipathi.ganapathi@collabora.com>
> > Date:   Fri Sep 18 11:51:42 2020 +0530
> > 
> > file deduper:
> > 
> >     194 def btrfs_dump_csum(filename):
> >     195     global device_name
> >     196
> >     197     btrfs_bin = "/usr/sbin/btrfs.static"
> >     198     if os.path.exists(btrfs_bin) is False:
> >     199         btrfs_bin = "btrfs"
> >     200
> >     201     out = subprocess.Popen(
> >     202         [btrfs_bin, 'inspect-internal', 'dump-csum', filename, device_name],
> >     203         stdout=subprocess.PIPE,
> >     204         close_fds=True).stdout.readlines()
> >     205     return out
> > 
> > OK there's the problem:  it's dumping csums from a mounted filesystem by
> > reading the block device instead of using the TREE_SEARCH_V2 ioctl.
> > Don't do that, because it won't work.  ;)
> I trust you on this ;-) But I am surprised I am the only one reporting this
> issue. 

It means the code isn't being adequately tested by anyone who is currently
using it.  A common problem for new software projects.

The text "never run this" and "don't run this" appears in several places
in dduper's README.md, along with "Please be aware that dduper is largely
un-tesed tool." After reading advice like that, if I had stumbled across
this behavior myself, I wouldn't have bothered to report it--I'd say to
myself "hey, the README was right!" and then I'd move on to the next
candidate project on my list.  If other people do the same, that may
account for the low defect report rate.

I was able to quickly reproduce the parent transid verify failure by
running dduper on a test VM:

	# dduper -p /dev/vgtest/tvdb -r -s -d /media/testfs
	parent transid verify failed on 35179391188992 wanted 3743662 found 3743762
	parent transid verify failed on 35179391188992 wanted 3743662 found 3743762
	parent transid verify failed on 35179391188992 wanted 3743662 found 3743762
	Ignoring transid failure
	ERROR: child eb corrupted: parent bytenr=4414666997760 item=278 parent level=2 child level=0
	ERROR: failed to read block groups: Input/output error
	unable to open /dev/vgtest/tvdb
	Traceback (most recent call last):
	  File "./dduper", line 594, in <module>
	    main(results)
	  File "./dduper", line 465, in main
	    dedupe_dir(results.dir_path, results.dry_run, results.recurse)
	  File "./dduper", line 456, in dedupe_dir
	    dedupe_files(file_list, dry_run)
	  File "./dduper", line 410, in dedupe_files
	    ret = do_dedupe(src_file, dst_file, dry_run)
	  File "./dduper", line 224, in do_dedupe
	    assert len(out1) != 0
	AssertionError

The test VM runs 100 rsync processes, balance, snapshot create and
delete, scrub and bees continuously.  dduper survived almost 10 minutes.

Nothing else in the VM was disturbed by the test, which confirms that
the "parent transid verify failure" messages are not indicative of a
filesystem failure, and only dduper is affected by them.

> Will it *always* not work, or does it not work in some cases and my
> situation is making it extremely unlikely to work?

A short run (e.g. a small file on a small filesystem) could extract all
the needed data from the csum tree before a transaction commit removes
old parts of the csum tree from the filesystem.  dduper seems to invoke
dump-csum on every individual input file, so it is probably avoiding the
issue most of the time.  By starting over for every new file, the amount
of time that stale pages are held in dump-csum's memory is minimized.

dump-csum will always fail if it runs too long and there are concurrent
filesystem updates (including the changes dduper makes to the filesystem
itself).  It will fail more often on larger files than on smaller ones
(they take longer to read), and also more often on files that straddle
metadata page boundaries (they require more tree searches and validate
more tree node parents) or have data blocks scattered across the
disk (these will require reading more metadata tree interior nodes).
You might see some semi-repeatable behavior that seems data-dependent
(and is in fact dependent on the structure of the data on disk), but
it'll break eventually no matter what you do.

The kernel provides TREE_SEARCH_V2, an ioctl which can provide a map
from file to extent address, and also retrieve the csum tree items by
extent address from a mounted filesystem.  Accessing the csums through the
filesystem's ioctl interface instead of the block device will eliminate
the race condition leading to parent transid verify failure.  Switching to
this ioctl in dduper would also remove the dependency on non-upstream
btrfs-progs and probably make it run considerably faster, especially on
filesystems with many small files.  I'd recommend using python-btrfs for
that--no need to invent the wheel twice in the same programming language.

> > The "parent transid verify failed" errors are harmless.  They are due
> > to the fact that a process reading the raw block device can never build
> > an accurate model of a live filesystem that is changing underneathi it.

Well, almost harmless.  It seems dduper will abort as soon as it sees
a dump-csum error, without doing any further dedupe.

> > If you manage to get some dedupe to happen, then that's a bonus.
> > 
> > 
> > >  >
> > >  > > >  Anything else, I can do?
> > >  > >
> > >  > > It looks like sda1 might be bad and it is working by replacing lost
> > >  > > data from the mirror on sdj.  But this replacement should be happening
> > >  > > automatically on read (and definitely on scrub), so you shouldn't ever
> > >  > > see the same error twice, but it seems that you do.
> > >  >
> > >  > Well, it is not the same error twice.
> > 
> > Earlier you quoted some duplicate lines.  Normally those get fixed after the
> > first line, so you never see the second.
> > 
> I see.
> 
> Regards,
> Hendrik
> 
> 
