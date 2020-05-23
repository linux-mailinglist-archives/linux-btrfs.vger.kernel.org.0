Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3D21DF7D0
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 May 2020 16:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387834AbgEWOiy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 May 2020 10:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387799AbgEWOix (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 May 2020 10:38:53 -0400
Received: from mxa2.seznam.cz (mxa2.seznam.cz [IPv6:2a02:598:2::90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29602C061A0E
        for <linux-btrfs@vger.kernel.org>; Sat, 23 May 2020 07:38:53 -0700 (PDT)
Received: from email.seznam.cz
        by email-smtpc10a.ng.seznam.cz (email-smtpc10a.ng.seznam.cz [10.23.11.45])
        id 0df9ecac770d867d0df9eedb;
        Sat, 23 May 2020 16:38:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=beta;
        t=1590244728; bh=mK59N2O/GLVSXRiqbDcSP+dRlz7RSx+slI684QFVWhc=;
        h=Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
         References:Content-Type:X-Mailer:Mime-Version:
         Content-Transfer-Encoding;
        b=W4fHwqKEUtRtnH97r693fWJ4dibMayhm88Ti76lfFKg98sv1il7VUryq8F5nLkCWG
         r3SCuIUfJqFWLZeTuIo28Pwefqs7r8tbGVMgkS/EyEh/vd1yC1780e7uxNBd2hWG3D
         PMEU9NJASccg/b1JXhQyqxs3rTx5RzpeTu7/pKKY=
Received: from lisicky.cdnet.czf (82-150-191-10.client.rionet.cz [82.150.191.10])
        by email-relay18.ng.seznam.cz (Seznam SMTPD 1.3.114) with ESMTP;
        Sat, 23 May 2020 16:38:45 +0200 (CEST)  
Message-ID: <3bc39223e567b7a4eca13bc554c74ef0c36fbaf2.camel@seznam.cz>
Subject: Re: I can't mount image
From:   =?UTF-8?Q?Ji=C5=99=C3=AD_Lisick=C3=BD?= <jiri_lisicky@seznam.cz>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Date:   Sat, 23 May 2020 16:38:43 +0200
In-Reply-To: <CAJCQCtQXBphGneiHJT_O7VHgZkfqfHaxmkAwFEzGPXY5E7U_cA@mail.gmail.com>
References: <1e6bc0e299901f90613550570446777fbccdc21e.camel@seznam.cz>
         <CAJCQCtSWX0J69SokSOgAhdcQ6qkKHfaPVhbF4anjCtVFACOVnQ@mail.gmail.com>
         <139f40a70cf37da2fef682c5c3d660671d8af88d.camel@seznam.cz>
         <CAJCQCtQXBphGneiHJT_O7VHgZkfqfHaxmkAwFEzGPXY5E7U_cA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-8.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Chris Murphy píše v St 20. 05. 2020 v 15:54 -0600:
> On Wed, May 20, 2020 at 3:12 PM Jiří Lisický <jiri_lisicky@seznam.cz> wrote:
> > 
> > 
> > btrfs insp dump-s -fa /dev/loop4
> > 
> > superblock: bytenr=65536, device=/dev/loop4
> > ---------------------------------------------------------
> > csum_type               0 (crc32c)
> > csum_size               4
> > csum                    0xdc2c003a [match]
> > bytenr                  65536
> > flags                   0x1
> >                         ( WRITTEN )
> > magic                   _BHRfS_M [match]
> > fsid                    86180ca0-d351-4551-b262-22b49e1adf47
> > metadata_uuid           86180ca0-d351-4551-b262-22b49e1adf47
> > label                   sailfish
> > generation              2727499
> > root                    30703616
> > sys_array_size          226
> > chunk_root_generation   2342945
> > root_level              1
> > chunk_root              20971520
> > chunk_root_level        0
> > log_root                94920704
> 
> There's a log tree being referenced, but in an earlier step you zero'd
> the log. There might be some data loss for whatever was being written
> at the time it was last rw mounted.
Yes, zeroed, but only in first mail. I took a new one copy in this round - without zero-log. Image in /dev/loop4 is without any modification.

> 
> > log_root_transid        0
> > log_root_level          0
> > total_bytes             14761832448
> > bytes_used              5075300352
> > sectorsize              4096
> > nodesize                4096
> > leafsize (deprecated)   4096
> > stripesize              4096
> > root_dir                6
> > num_devices             1
> > compat_flags            0x0
> > compat_ro_flags         0x0
> > incompat_flags          0x3
> >                         ( MIXED_BACKREF |
> >                           DEFAULT_SUBVOL )
> 
> Must be a very early btrfs-progs. Default these days is 0x161.
> 
> 
> > / # uname -a
> > Linux (none) 3.4.108.20190506.1 #1 SMP PREEMPT Sat Nov 30 21:25:45 UTC
> > 2019 armv7l GNU/Linux
> > / # btrfs --version
> > Btrfs v3.16
> 
> To attempt a repair, you need something much newer. I suggest 5.6 or
> 5.6.1 since they're recent. Arch and Fedora Rawhide images will have
> one of those. I'm not certain v3.16 can reliably tell us what's wrong
> with the file system, in particular since quotas are enabled. Please
> update and then repost 'btrfs check' without options.
Yes, versions above are from Jolla phone. I do all the work in Fedora 31 Live. Outputs from suggested commands are bellow.


> This is promising though:
> 
> > parent transid verify failed on 94920704 wanted 2727500 found 2727499
> 
> Weird - why does it want that generation when the super block says the
> root tree generation is 2727499? Can you also include output from:
> 
> # btrfs rescue super -v /dev/
> 
> It might be as simple as 'mount -o ro,recovery' with that older kernel
> if it can roll back to the previous transid. If not, then a more
> recent btrfs progs might be able to confirm whether the older state
> can be repaired. That looks like this:
> 
> # btrfs check /dev/
> # btrfs check -r 48250880 /dev/
> # btrfs check -r 114339840 /dev/
> # btrfs check -r 102043648 /dev/
> # btrfs check -r 90173440 /dev/
> 
> 
> The first two are most likely to succeed. All of these are still read
> only, gathering information. There are no repairs yet even though
> you're working on a backup image (good idea).

[root@localhost-live tmp] # btrfs rescue super -v /dev/loop4
All Devices:
	Device: id = 1, name = /dev/loop4

Before Recovering:
	[All good supers]:
		device name = /dev/loop4
		superblock bytenr = 65536

		device name = /dev/loop4
		superblock bytenr = 67108864

	[All bad supers]:

All supers are valid, no need to recover



[root@localhost-live tmp]# mount -o ro,recovery /dev/loop4 ./mnt
mount: /home/jirka/tmp/mnt: can't read superblock on /dev/loop4.


[root@localhost-live tmp]# btrfs check /dev/loop4
Opening filesystem to check...
parent transid verify failed on 94920704 wanted 2727500 found 2727499
parent transid verify failed on 94920704 wanted 2727500 found 2727499
parent transid verify failed on 94920704 wanted 2727500 found 2727499
Ignoring transid failure
Checking filesystem on /dev/loop4
UUID: 86180ca0-d351-4551-b262-22b49e1adf47
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
cache and super generation don't match, space cache will be invalidated
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups
Rescan hasn't been initialized, a difference in qgroup accounting is expected
Counts for qgroup id: 0/264 are different
our:		referenced 876449792 referenced compressed 876449792
disk:		referenced 876449792 referenced compressed 876449792
our:		exclusive 872464384 exclusive compressed 872464384
disk:		exclusive 4096 exclusive compressed 4096
diff:		exclusive 872460288 exclusive compressed 872460288
Counts for qgroup id: 0/265 are different
our:		referenced 73646080 referenced compressed 73646080
disk:		referenced 73646080 referenced compressed 73646080
our:		exclusive 15380480 exclusive compressed 15380480
disk:		exclusive 4096 exclusive compressed 4096
diff:		exclusive 15376384 exclusive compressed 15376384
ERROR: transid errors in file system
found 5075300352 bytes used, error(s) found
total csum bytes: 4715584
total tree bytes: 235204608
total fs tree bytes: 214499328
total extent tree bytes: 12795904
btree space waste bytes: 70058462
file data blocks allocated: 4970160128
 referenced 4793737216


[root@localhost-live tmp]# btrfs check -r 48250880 /dev/loop4
Opening filesystem to check...
parent transid verify failed on 48250880 wanted 2727499 found 2727498
parent transid verify failed on 48250880 wanted 2727499 found 2727498
parent transid verify failed on 48250880 wanted 2727499 found 2727498
Ignoring transid failure
parent transid verify failed on 94920704 wanted 2727500 found 2727499
parent transid verify failed on 94920704 wanted 2727500 found 2727499
parent transid verify failed on 94920704 wanted 2727500 found 2727499
Ignoring transid failure
Checking filesystem on /dev/loop4
UUID: 86180ca0-d351-4551-b262-22b49e1adf47
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
cache and super generation don't match, space cache will be invalidated
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups
Rescan hasn't been initialized, a difference in qgroup accounting is expected
Counts for qgroup id: 0/264 are different
our:		referenced 876449792 referenced compressed 876449792
disk:		referenced 876449792 referenced compressed 876449792
our:		exclusive 872464384 exclusive compressed 872464384
disk:		exclusive 4096 exclusive compressed 4096
diff:		exclusive 872460288 exclusive compressed 872460288
Counts for qgroup id: 0/265 are different
our:		referenced 73646080 referenced compressed 73646080
disk:		referenced 73646080 referenced compressed 73646080
our:		exclusive 15380480 exclusive compressed 15380480
disk:		exclusive 4096 exclusive compressed 4096
diff:		exclusive 15376384 exclusive compressed 15376384
ERROR: transid errors in file system
found 5075300352 bytes used, error(s) found
total csum bytes: 4715584
total tree bytes: 235204608
total fs tree bytes: 214499328
total extent tree bytes: 12795904
btree space waste bytes: 70058462
file data blocks allocated: 4970160128
 referenced 4793737216


[root@localhost-live tmp]# btrfs check -r 114339840 /dev/loop4
Opening filesystem to check...
parent transid verify failed on 114339840 wanted 2727499 found 2727497
parent transid verify failed on 114339840 wanted 2727499 found 2727497
parent transid verify failed on 114339840 wanted 2727499 found 2727497
Ignoring transid failure
parent transid verify failed on 94920704 wanted 2727500 found 2727499
parent transid verify failed on 94920704 wanted 2727500 found 2727499
parent transid verify failed on 94920704 wanted 2727500 found 2727499
Ignoring transid failure
Checking filesystem on /dev/loop4
UUID: 86180ca0-d351-4551-b262-22b49e1adf47
[1/7] checking root items
parent transid verify failed on 50991104 wanted 2727494 found 2727499
parent transid verify failed on 50991104 wanted 2727494 found 2727499
parent transid verify failed on 50991104 wanted 2727494 found 2727499
Ignoring transid failure
parent transid verify failed on 51003392 wanted 2727494 found 2727499
parent transid verify failed on 51003392 wanted 2727494 found 2727499
parent transid verify failed on 51003392 wanted 2727494 found 2727499
Ignoring transid failure
parent transid verify failed on 57032704 wanted 2727494 found 2727499
parent transid verify failed on 57032704 wanted 2727494 found 2727499
parent transid verify failed on 57032704 wanted 2727494 found 2727499
Ignoring transid failure
parent transid verify failed on 57069568 wanted 2727494 found 2727499
parent transid verify failed on 57069568 wanted 2727494 found 2727499
parent transid verify failed on 57069568 wanted 2727494 found 2727499
Ignoring transid failure
parent transid verify failed on 57253888 wanted 2727494 found 2727499
parent transid verify failed on 57253888 wanted 2727494 found 2727499
parent transid verify failed on 57253888 wanted 2727494 found 2727499
Ignoring transid failure
parent transid verify failed on 58953728 wanted 2727494 found 2727499
parent transid verify failed on 58953728 wanted 2727494 found 2727499
parent transid verify failed on 58953728 wanted 2727494 found 2727499
Ignoring transid failure
parent transid verify failed on 45047808 wanted 2727493 found 2727499
parent transid verify failed on 45047808 wanted 2727493 found 2727499
parent transid verify failed on 45047808 wanted 2727493 found 2727499
Ignoring transid failure
parent transid verify failed on 59351040 wanted 2727494 found 2727499
parent transid verify failed on 59351040 wanted 2727494 found 2727499
parent transid verify failed on 59351040 wanted 2727494 found 2727499
Ignoring transid failure
parent transid verify failed on 44269568 wanted 2727493 found 2727499
parent transid verify failed on 44269568 wanted 2727493 found 2727499
parent transid verify failed on 44269568 wanted 2727493 found 2727499
Ignoring transid failure
parent transid verify failed on 31113216 wanted 2727493 found 2727499
parent transid verify failed on 31113216 wanted 2727493 found 2727499
parent transid verify failed on 31113216 wanted 2727493 found 2727499
Ignoring transid failure
parent transid verify failed on 45645824 wanted 2727493 found 2727499
parent transid verify failed on 45645824 wanted 2727493 found 2727499
parent transid verify failed on 45645824 wanted 2727493 found 2727499
Ignoring transid failure
parent transid verify failed on 50700288 wanted 2727492 found 2727499
parent transid verify failed on 50700288 wanted 2727492 found 2727499
parent transid verify failed on 50700288 wanted 2727492 found 2727499
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=109846528 item=58 parent level=1 child level=1
ERROR: failed to repair root items: Input/output error


[root@localhost-live tmp]# btrfs check -r 102043648 /dev/loop4
Opening filesystem to check...
parent transid verify failed on 102043648 wanted 2727499 found 2727496
parent transid verify failed on 102043648 wanted 2727499 found 2727496
parent transid verify failed on 102043648 wanted 2727499 found 2727496
Ignoring transid failure
parent transid verify failed on 94920704 wanted 2727500 found 2727499
parent transid verify failed on 94920704 wanted 2727500 found 2727499
parent transid verify failed on 94920704 wanted 2727500 found 2727499
Ignoring transid failure
Checking filesystem on /dev/loop4
UUID: 86180ca0-d351-4551-b262-22b49e1adf47
[1/7] checking root items
parent transid verify failed on 50991104 wanted 2727494 found 2727499
parent transid verify failed on 50991104 wanted 2727494 found 2727499
parent transid verify failed on 50991104 wanted 2727494 found 2727499
Ignoring transid failure
parent transid verify failed on 51003392 wanted 2727494 found 2727499
parent transid verify failed on 51003392 wanted 2727494 found 2727499
parent transid verify failed on 51003392 wanted 2727494 found 2727499
Ignoring transid failure
parent transid verify failed on 57032704 wanted 2727494 found 2727499
parent transid verify failed on 57032704 wanted 2727494 found 2727499
parent transid verify failed on 57032704 wanted 2727494 found 2727499
Ignoring transid failure
parent transid verify failed on 57069568 wanted 2727494 found 2727499
parent transid verify failed on 57069568 wanted 2727494 found 2727499
parent transid verify failed on 57069568 wanted 2727494 found 2727499
Ignoring transid failure
parent transid verify failed on 57212928 wanted 2727494 found 2727499
parent transid verify failed on 57212928 wanted 2727494 found 2727499
parent transid verify failed on 57212928 wanted 2727494 found 2727499
Ignoring transid failure
parent transid verify failed on 57253888 wanted 2727494 found 2727499
parent transid verify failed on 57253888 wanted 2727494 found 2727499
parent transid verify failed on 57253888 wanted 2727494 found 2727499
Ignoring transid failure
parent transid verify failed on 43192320 wanted 2727493 found 2727498
parent transid verify failed on 43192320 wanted 2727493 found 2727498
parent transid verify failed on 43192320 wanted 2727493 found 2727498
Ignoring transid failure
parent transid verify failed on 58257408 wanted 2727494 found 2727499
parent transid verify failed on 58257408 wanted 2727494 found 2727499
parent transid verify failed on 58257408 wanted 2727494 found 2727499
Ignoring transid failure
ERROR: child eb corrupted: parent bytenr=98955264 item=10 parent level=1 child level=1
ERROR: failed to repair root items: Input/output error


[root@localhost-live tmp]# btrfs check -r 90173440 /dev/loop4
Opening filesystem to check...
ERROR: could not setup extent tree
ERROR: cannot open file system

