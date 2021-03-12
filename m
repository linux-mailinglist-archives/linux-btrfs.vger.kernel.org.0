Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6973B338488
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Mar 2021 05:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhCLECu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Mar 2021 23:02:50 -0500
Received: from james.kirk.hungrycats.org ([174.142.39.145]:48004 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhCLECR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Mar 2021 23:02:17 -0500
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 2610F9C7C64; Thu, 11 Mar 2021 23:02:16 -0500 (EST)
Date:   Thu, 11 Mar 2021 23:02:16 -0500
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Martin Raiber <martin@urbackup.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Multiple files with the same name in one directory
Message-ID: <20210312040215.GP32440@hungrycats.org>
References: <010201781d22d3e9-78ba2d74-fc45-4455-813d-367e789d3e9b-000000@eu-west-1.amazonses.com>
 <CAL3q7H79BO0qgTUVmbW2kzcUqtp4vgRLK8vNT95+Sz7tgWDdMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H79BO0qgTUVmbW2kzcUqtp4vgRLK8vNT95+Sz7tgWDdMQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 11, 2021 at 02:43:26PM +0000, Filipe Manana wrote:
> On Wed, Mar 10, 2021 at 5:18 PM Martin Raiber <martin@urbackup.org> wrote:
> >
> > Hi,
> >
> > I have this in a btrfs directory. Linux kernel 5.10.16, no errors in dmesg, no scrub errors:
> >
> > ls -lh
> > total 19G
> > -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> > -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> > -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> > -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> > -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> > -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> > -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> > -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> > -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> > -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> > -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> > -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> > -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> > -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> > ...
> >
> > disk_config.dat gets written to using fsync rename ( write new version to disk_config.dat.new, fsync disk_config.dat.new, then rename to disk_config.dat -- it is missing the parent directory fsync).
> 
> That's interesting.
> 
> I've just tried something like the following on 5.10.15 (and 5.12-rc2):
> 
> create disk_config.dat
> sync
> for ((i = 0; i < 10; i++)); do
>     create disk_config.dat.new
>     write to disk_config.dat.new
>     fsync disk_config.dat.new
>     mv -f disk_config.dat.new disk_config.dat
> done
> <power fail>
> mount fs
> list directory
> 
> I only get one file with the name disk_config.dat and one file with
> the name disk_config.dat.new.
> File disk_config.dat has the data written at iteration 9 and
> disk_config.dat.new has the data written at iteration 10 (expected).
> 
> You haven't mentioned, but I suppose you had a power failure / unclean
> shutdown somewhere after an fsync, right?
> Is this something you can reproduce at will?

I've seen this off and on as far back as kernel 4.4.  Usually
(only?) happens on machines with metadata-heavy write loads at the
time of the fsync.  Very easy to reproduce if you hit a transaction
deadlock bug (which happened to be a lot more common a few years ago),
these inodeless filenames would show up almost every time if fsync was
called before rename.

Somewhere between 4.9 and 4.14, it became possible to create new files
with the same names as the inodeless filenames, and the bug became much
less annoying (the filenames would even go away by themselves sometimes).
Then the bug became harder to spot--earler versions of the bug would
stop an application dead with a filename that could never be used again.
Later versions didn't break anything, so they could only be found by
looking for errors when running e.g. 'find' or 'rsync'.

The issue never got near the top of my bug list, and until today I thought
it had been quietly fixed before 5.1.  I guess it's still active, or a
new bug has replaced it.

The last instance I recorded of this issue was found on a filesystem in
late 2019, although I don't know which kernel was running at the time
the inodeless filename was created (could have been anything between
4.4 and 5.0, though probably not before 4.14 because I would have been
forced to burn the subvol if it happened on an earlier kernel).

> > So far no negative consequences... (except that programs might get confused).
> >
> > echo 3 > /proc/sys/vm/drop_caches doesn't help.
> >
> > Regards,
> > Martin Raiber
> >
> 
> 
> -- 
> Filipe David Manana,
> 
> “Whether you think you can, or you think you can't — you're right.”
