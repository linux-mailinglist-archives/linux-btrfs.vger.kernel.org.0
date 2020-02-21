Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD35168A3C
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2020 00:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgBUXHr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 18:07:47 -0500
Received: from magic.merlins.org ([209.81.13.136]:38838 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgBUXHr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 18:07:47 -0500
Received: from [104.132.1.106] (port=49208 helo=saruman.merlins.org)
        by mail1.merlins.org with esmtpsa 
        (Cipher TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128) (Exim 4.92 #3)
        id 1j5HOX-00056y-MW by authid <merlins.org> with srv_auth_plain; Fri, 21 Feb 2020 15:07:41 -0800
Received: from merlin by saruman.merlins.org with local (Exim 4.80)
        (envelope-from <marc@merlins.org>)
        id 1j5HOW-0008R5-Q1; Fri, 21 Feb 2020 15:07:40 -0800
Date:   Fri, 21 Feb 2020 15:07:40 -0800
From:   Marc MERLIN <marc@merlins.org>
To:     Roman Mamedov <rm@romanrm.net>
Cc:     dsterba@suse.cz, Martin Steigerwald <martin@lichtvoll.de>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: btrfs filled up dm-thin and df%: shows 8.4TB of data used when I'm
 only using 10% of that.
Message-ID: <20200221230740.GQ19481@merlins.org>
References: <2656316.bop9uDDU3N@merkaba>
 <20200219225051.39ca1082@natsu>
 <20200219153652.GA26873@merlins.org>
 <20200220214649.GD26873@merlins.org>
 <20200221053804.GA7869@merlins.org>
 <20200221104545.6335cbd1@natsu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221104545.6335cbd1@natsu>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-No-Run: Yes
X-Broken-Reverse-DNS: no host name for IP address 104.132.1.106
X-SA-Exim-Connect-IP: 104.132.1.106
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ok, first I'll update the subject line

On Fri, Feb 21, 2020 at 10:45:45AM +0500, Roman Mamedov wrote:
> On Thu, 20 Feb 2020 21:38:04 -0800
> Marc MERLIN <marc@merlins.org> wrote:
> 
> > I had a closer look, and even with 5.4.20, my whole lv is full now:
> >   LV Name                thinpool2
> >   Allocated pool data    99.99%
> >   Allocated metadata     59.88%
> 
> Oversubscribing thin storage should be done carefully and only with a very
> good reason, and when you run out of something you didn't have in the first
> place, seems hard to blame Btrfs or anyone else for it.

let's rewind.
It's a backup server, I used to have everything in a single 14TB
filesystem, I had too many snapshots, and was told to break it up in
smaller filesystems to work around btrfs' inability to scale properly
past a hundred snapshots or so (and that many snapshots blowing up both
kinds of btrfs check --repair, one of them forced me to buy 16GB of RAM
to max out my server until it still ran out of RAM and now I can't add
any).

I'm obviously not going to the olden days of making actual partitions
and guessing wrong every time how big each partition should be, so my
only solution left was to use dm-thin and subscribe the entire space to
all LVs.
I then have a cronjob that warns me if I start running low on in the
global VG pool.

Now, where it got confusing is that around the time I put the 5.4 with
the df problem, is the same time df filled up to 100% and started
mailing me. I ignored it because I knew about the bug.
However, I just found out that my LV actually filled up due to another
bug that was actually my fault.

Now, I triggered some real bugs in btrfs, see:
gargamel:/mnt/btrfs_pool2/backup/ubuntu# btrfs fi show .
Label: 'ubuntu'  uuid: 905c90db-8081-4071-9c79-57328b8ac0d5
        Total devices 1 FS bytes used 445.73GiB
        devid    1 size 14.00TiB used 8.44TiB path /dev/mapper/vgds2-ubuntu

Ok, I'm using 445GB, but losing 8.4TB, sigh.
  LV Path                /dev/vgds2/ubuntu
  LV Name                ubuntu
  LV Pool name           thinpool2
  LV Size                14.00 TiB
  Mapped size            60.25%  <= this is all the space free in my VG, so it's full now

We talked about fstrim, let's try that:
gargamel:/mnt/btrfs_pool2/backup/ubuntu# fstrim -v .
.: 5.6 TiB (6116423237632 bytes) trimmed

Oh, great. Except this freed up nothing in LVM.

gargamel:/mnt/btrfs_pool2/backup/ubuntu# btrfs balance start -musage=0 -v .  
Dumping filters: flags 0x6, state 0x0, force is off
  METADATA (flags 0x2): balancing, usage=0
  SYSTEM (flags 0x2): balancing, usage=0
ERROR: error during balancing '.': Read-only file system

Ok, right, need to unmount/remount to clear read-only;
gargamel:/mnt/btrfs_pool2/backup/ubuntu# btrfs balance start -musage=0 -v .  
Dumping filters: flags 0x6, state 0x0, force is off
  METADATA (flags 0x2): balancing, usage=0
  SYSTEM (flags 0x2): balancing, usage=0
Done, had to relocate 0 out of 8624 chunks
gargamel:/mnt/btrfs_pool2/backup/ubuntu# btrfs balance start -dusage=0 -v .  
Dumping filters: flags 0x1, state 0x0, force is off
  DATA (flags 0x2): balancing, usage=0
Done, had to relocate 0 out of 8624 chunks
gargamel:/mnt/btrfs_pool2/backup/ubuntu# btrfs fi show .
Label: 'ubuntu'  uuid: 905c90db-8081-4071-9c79-57328b8ac0d5
        Total devices 1 FS bytes used 8.42TiB
        devid    1 size 14.00TiB used 8.44TiB path /dev/mapper/vgds2-ubuntu


Well, carap, see how 'used' went from 445.73GiB to 8.42TiB after balance?

I ran du to make sure my data is indeed only using 445GB.

So now, I'm pretty much hosed, the fielsystem seems to have been damaged in interesting ways.

I'll wait until tomorrow in case someone wants something from it, and I'll delete the entire
LV and start over.

And now for extra points, this also damaged a 2nd of my filesystems on the same VG :(
[64723.601630] BTRFS error (device dm-17): bad tree block start, want 5782272294912 have 0
[64723.628708] BTRFS error (device dm-17): bad tree block start, want 5782272294912 have 0
[64897.028176] BTRFS error (device dm-13): parent transid verify failed on 22724608 wanted 10005 found 10001
[64897.080355] BTRFS error (device dm-13): parent transid verify failed on 22724608 wanted 10005 found 10001

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
