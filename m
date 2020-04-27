Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0DF1BA3A2
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Apr 2020 14:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgD0Mci (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Apr 2020 08:32:38 -0400
Received: from mail.nethype.de ([5.9.56.24]:43057 "EHLO mail.nethype.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbgD0Mci (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Apr 2020 08:32:38 -0400
Received: from [10.0.0.5] (helo=doom.schmorp.de)
        by mail.nethype.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1jT2w7-001Lu5-KP; Mon, 27 Apr 2020 12:32:35 +0000
Received: from [10.0.0.1] (helo=cerebro.laendle)
        by doom.schmorp.de with esmtp (Exim 4.92)
        (envelope-from <schmorp@schmorp.de>)
        id 1jT2w7-0007dY-Er; Mon, 27 Apr 2020 12:32:35 +0000
Received: from root by cerebro.laendle with local (Exim 4.92)
        (envelope-from <root@schmorp.de>)
        id 1jT2w7-0002Cn-EZ; Mon, 27 Apr 2020 14:32:35 +0200
Date:   Mon, 27 Apr 2020 14:32:35 +0200
From:   Marc Lehmann <schmorp@schmorp.de>
To:     Roman Mamedov <rm@romanrm.net>
Cc:     Hugo Mills <hugo@carfax.org.uk>, linux-btrfs@vger.kernel.org
Subject: Re: questoin about Data=single on multi-device fs
Message-ID: <20200427123235.GA8243@schmorp.de>
References: <20200426100405.GA5270@schmorp.de>
 <20200426102547.GM32577@savella.carfax.org.uk>
 <20200427112946.GA3648@schmorp.de>
 <20200427164436.05c5c257@natsu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427164436.05c5c257@natsu>
OpenPGP: id=904ad2f81fb16978e7536f726dea2ba30bc39eb6;
 url=http://pgp.schmorp.de/schmorp-pgpkey.txt; preference=signencrypt
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Apr 27, 2020 at 04:44:36PM +0500, Roman Mamedov <rm@romanrm.net> wrote:
> With backups it is at least clear enough to anyone that only the data that has
> been backed up will be recoverable from the backup;
> 
> On the other hand you follow a much more dangerous theory, that a low-level
> JBOD-style merging of disks can be of any significant "help" in case of a
> device failure.

I'm not sure why you are trying to derail this discussion - in any case, I
am not sure what you means with dangerous, or even theory: it's a trivial
fact that losing half of every file is obviously a bigger data loss than
losing half your files, for practically all scenarios (but admittededly
not all).

> devices, or MD Linear, or in this case Btrfs "single". In all of those cases I
> have to wonder how getting to keep a few chunks of what some time ago was a
> filesystem, or in your case, *random pieces of random files* being luckily
> intact, will be of any help and alleviate the need to restore from backups.

Well, to give you a practical example, I once had to rescue an extremely
damaged reiserfs filesystem, given chunk-md4 checksums of all files, and
md5 checksums of all files. This allowed me to recover practically all
files, except a few big ones that were probably too fragmented.

Here is another practical example which shows your assumptions are simply
wrong: Restoring 100GB from backup takes a very long time hereabouts. If
btrfs behaves as it apparently traditionally did with Data=single, you
can instantly stay online even after losing one or more disks (with fewer
files), repair the metadata, delete the broken files, restore those much
more quickly, and be only practically all the time.

So with traditional Data=single behaviour, you can potentially save a lot
of time - for example, in a multi-device fs with 10x10TB, this can make a
10x difference in downtime, which is significant, especially if your to
storage allows a certain amount of downtime (being not raided in the irst
place).

> If you really want a JBOD-style storage merged into a single pool, with device
> failures having impact limited only to that device, better look into FUSE
> file-level overlay filesystems, such as MergerFS and MHDDFS.

Funnily enough, I actually did look into mergerfs, unfortnately, it is
extremely buggy (as in, crashes, memory leaks and simply wrong behaviour).
Btrfs is absolutley the better alternative at the moment :)

> At least with those you are guaranteed to have whole files intact on
> still running devices.  Exactly what Btrfs doesn't guarantee you now
> (seemingly even more so), but most importantly never did, not even on
> any prior kernel version.

I haven't asked/requested/expected any guarantees, but since making wrong
assumptions about backups is so common here, let's give it another use
case, power saving - you can save power by limiting activity to fewer
disks (and also reduce latency due to disk spin-up), at the cost of
performance by not striping data.

-- 
                The choice of a       Deliantra, the free code+content MORPG
      -----==-     _GNU_              http://www.deliantra.net
      ----==-- _       generation
      ---==---(_)__  __ ____  __      Marc Lehmann
      --==---/ / _ \/ // /\ \/ /      schmorp@schmorp.de
      -=====/_/_//_/\_,_/ /_/\_\
