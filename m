Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8566319E5F4
	for <lists+linux-btrfs@lfdr.de>; Sat,  4 Apr 2020 16:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgDDO6s convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-btrfs@lfdr.de>); Sat, 4 Apr 2020 10:58:48 -0400
Received: from james.kirk.hungrycats.org ([174.142.39.145]:35660 "EHLO
        james.kirk.hungrycats.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgDDO6r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 4 Apr 2020 10:58:47 -0400
Received: by james.kirk.hungrycats.org (Postfix, from userid 1002)
        id 9B74564FFBA; Sat,  4 Apr 2020 10:58:46 -0400 (EDT)
Date:   Sat, 4 Apr 2020 10:58:46 -0400
From:   Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
To:     Andrea Gelmini <andrea.gelmini@gmail.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, fdmanana@gmail.com,
        linux-btrfs <linux-btrfs@vger.kernel.org>, neilb@suse.de
Subject: Re: RAID5/6 permanent corruption of metadata and data extents
Message-ID: <20200404145846.GK13306@hungrycats.org>
References: <CAL3q7H4oa70DUhOFE7kot62KjxcbvvZKxu62VfLpAcmgsinBFw@mail.gmail.com>
 <7b4f5744-0e22-3691-6470-b35908ab2c2c@gmx.com>
 <20200402211415.GH13306@hungrycats.org>
 <CAK-xaQbbadKhN75FhVeMkfDOBvY0N_=CaUVLs0HxYKyVLFyx4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAK-xaQbbadKhN75FhVeMkfDOBvY0N_=CaUVLs0HxYKyVLFyx4g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Apr 03, 2020 at 09:20:22AM +0200, Andrea Gelmini wrote:
> Il giorno gio 2 apr 2020 alle ore 23:23 Zygo Blaxell
> <ce3g8jdj@umail.furryterror.org> ha scritto:
> > mdadm raid5/6 has no protection against the kinds of silent data
> > corruption that btrfs can detect.  If the drive has a write error and
> > reports it to the host, mdadm will eject the entire disk from the array,
> > and a resync is required to put it back into the array (correcting the
> > error in the process).  If the drive silently drops a write or the data
> 
> That's not true.
> mdadm has a lot of logic of retries/wait and different "reactions" on what is
> happening.
> You can have spare blocks to use just in case, to avoid to kick the
> entire drive just
> by one bad block.

None of that helps.  Well, OK, it would have prevented Filipe's specific
test case from corrupting data in the specific way it did, but that test
setup is overly complicated for this bug.  'cat /dev/urandom > /dev/sda'
is a much clearer test setup that avoids having people conflate Filipe's
bug with distracting and _totally unrelated_ bugs like raid 5/6 write
hole and a bunch of missing mdadm features.

mdadm has no protection against silent data corruption in lower
levels of the storage stack.  mdadm relies on the lower level device
to indicate errors in data integrity.  If you run mdadm on top of
multiple dm-integrity devices in journal mode (double all writes!),
then dm-integrity transforms silent data corruption into EIO errors,
and mdadm can handle everything properly after that.

Without dm-integrity (or equivalent) underneath mdadm, if one of the
lower-level devices corrupts data, mdadm can't tell which version of the
data is correct, and propagates that corruption to mirror and parity
devices.  The only way to recover is to somehow know which devices
are corrupted (difficult because mdadm can't tell you which device,
and even has problems telling you that _any_ device is corrupted) and
force those devices to be resynced (which is usually a full-device sync,
unless you have some way to know where the corruption is).  And you have
to do all that manually, before mdadm writes anywhere _near_ the data
you want to keep.

btrfs has integrity checks built in, so in the event of a data corruption,
btrfs can decide whether the data or parity/mirror blocks are correct,
and btrfs can avoid propagating corruption between devices (*).  The bug
in this case is that btrfs is currently not doing the extra checks
needed for raid5/6, so we currently get mdadm-style propagation of data
corruption to parity blocks.  Later, btrfs detects the data csum failure
but by then parity has been corrupted and it is too late to recover.

(*) except nodatasum files, they can be no better than mdadm, and are
currently substantially worse in btrfs.  These files are where the missing
pieces of mdadm in btrfs are most obvious.  But that's a separate issue
that is also _totally unrelated_ to the bug(s) Filipe and I found, since
all the data we are trying to recover has csums and can be recovered
without any of the mdadm device-state-tracking stuff.

> It has a write journal log, to avoid RAID5/6 write hole (since years,
> but people keep
> saying there's no way to avoid it on mdadm...)

Yeah, if btrfs is going to copy the broken parts of mdadm, it should
also copy the fixes...

> Also, the greatest thing to me, Neil Brown did an incredible job
> constantly (year by year)
> improving the logic of mdadm (tools and kernel) to make it more robust against
> users mistakes and protective/proactive on failing setup/operations
> emerging from reports on
> mailig list.
> 
> Until I read the mdadm mailing list, the flow was: user complains for
> software/hardware problem,
> after a while Neil commit to avoid the same problem in the future.

mdadm does one thing very well, but only the one thing.  I don't imagine
Neil would extend mdadm to the point where it can handle handle silent
data corruption on cheap SSDs or workaround severe firmware bugs in
write caching.  That sounds more like a feature I'd expect to come out
of VDO or bcachefs work.

> Very costructive and useful way to manage the project.
> 
> A few times I was saved by the tools warning: "you're doing a stupid
> thing, that could loose your
> date. But if you are sure, you can use --force".
> Or the kernel complaining about: "I'm not going to assemble this. Use
> --force if you're sure".
> 
> On BTRFS, Qu is doing the same great job. Lots of patches to address
> users problems.
> 
> Kudos to Qu!
