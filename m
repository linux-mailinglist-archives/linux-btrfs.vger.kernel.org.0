Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7B5B168AA2
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2020 01:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729732AbgBVABt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Feb 2020 19:01:49 -0500
Received: from magic.merlins.org ([209.81.13.136]:39556 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgBVABs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Feb 2020 19:01:48 -0500
Received: from merlin by mail1.merlins.org with local (Exim 4.92 #3)
        id 1j5IEo-0000gy-IK by authid <merlin>; Fri, 21 Feb 2020 16:01:42 -0800
Date:   Fri, 21 Feb 2020 16:01:42 -0800
From:   Marc MERLIN <marc@merlins.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Roman Mamedov <rm@romanrm.net>, dsterba@suse.cz,
        Martin Steigerwald <martin@lichtvoll.de>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: btrfs filled up dm-thin and df%: shows 8.4TB of data used when
 I'm only using 10% of that.
Message-ID: <20200222000142.GA31491@merlins.org>
References: <2656316.bop9uDDU3N@merkaba>
 <20200219225051.39ca1082@natsu>
 <20200219153652.GA26873@merlins.org>
 <20200220214649.GD26873@merlins.org>
 <20200221053804.GA7869@merlins.org>
 <20200221104545.6335cbd1@natsu>
 <20200221230740.GQ19481@merlins.org>
 <3e94351d-6f32-1036-ab24-0dc1b843c969@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e94351d-6f32-1036-ab24-0dc1b843c969@toxicpanda.com>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Feb 21, 2020 at 06:43:45PM -0500, Josef Bacik wrote:
> > Well, carap, see how 'used' went from 445.73GiB to 8.42TiB after balance?
> 
> Wtf?  Can you do btrfs filesystem usage on that fs?  I'd like to see the
> breakdown.  I'm super confused about what's happening there.

You and me both :)
gargamel:/mnt/btrfs_pool2/backup/ubuntu# btrfs fi df .
Data, single: total=8.40TiB, used=8.40TiB
System, DUP: total=8.00MiB, used=912.00KiB
Metadata, DUP: total=17.00GiB, used=16.33GiB
GlobalReserve, single: total=512.00MiB, used=0.00B

Looks like used is back to 8.4TB there too.



> > And now for extra points, this also damaged a 2nd of my filesystems on the same VG :(
> > [64723.601630] BTRFS error (device dm-17): bad tree block start, want 5782272294912 have 0
> > [64723.628708] BTRFS error (device dm-17): bad tree block start, want 5782272294912 have 0
> > [64897.028176] BTRFS error (device dm-13): parent transid verify failed on 22724608 wanted 10005 found 10001
> > [64897.080355] BTRFS error (device dm-13): parent transid verify failed on 22724608 wanted 10005 found 10001
> 
> This will happen if the transaction aborts, does it still happen after you
> unmount and remount?  Thanks,

the problematic filesystem mounts fine, but that doesn't mean it's
clean. 
the one that I'd like very much not to be damaged, I'm not touching it
until I can get my VG back to having it's 50% of free space it needs to
have, with 99.9x%, it's not safe to use anything on it.
But thanks for the heads up that my other filesystem may be ok. I'll run
a btrfs check on it later when it's safe.

Back to dm-13, it's now hung on umount, I'm getting a string of these:
[67980.657803] BTRFS info (device dm-13): the free space cache file (4344624709632) is invalid, skip it
[67991.562812] BTRFS info (device dm-13): the free space cache file (4447703924736) is invalid, skip it
[67991.755262] BTRFS info (device dm-13): the free space cache file (4448777666560) is invalid, skip it
[68000.379059] BTRFS info (device dm-13): the free space cache file (4518570885120) is invalid, skip it
[68013.462077] BTRFS info (device dm-13): the free space cache file (4574405459968) is invalid, skip it
[68015.286730] BTRFS info (device dm-13): the free space cache file (4589437845504) is invalid, skip it
[68015.318239] BTRFS info (device dm-13): the free space cache file (4589437845504) is invalid, skip it
[68016.212246] BTRFS info (device dm-13): the free space cache file (4596954038272) is invalid, skip it
[68016.730826] BTRFS info (device dm-13): the free space cache file (4602322747392) is invalid, skip it
[68020.547135] BTRFS info (device dm-13): the free space cache file (4634535002112) is invalid, skip it
[68021.812820] BTRFS info (device dm-13): the free space cache file (4646346162176) is invalid, skip it
[68037.173441] BTRFS info (device dm-13): the free space cache file (4768752730112) is invalid, skip it
[68039.559383] BTRFS info (device dm-13): the free space cache file (4778416406528) is invalid, skip it
[68040.531083] BTRFS info (device dm-13): the free space cache file (4781637632000) is invalid, skip it
[68050.184300] BTRFS info (device dm-13): the free space cache file (4843914657792) is invalid, skip it
[68074.134080] BTRFS info (device dm-13): the free space cache file (4988869804032) is invalid, skip it
[68078.943126] BTRFS info (device dm-13): the free space cache file (5015713349632) is invalid, skip it
[68099.512978] BTRFS info (device dm-13): the free space cache file (5151004819456) is invalid, skip it
[68100.575692] BTRFS info (device dm-13): the free space cache file (5160668495872) is invalid, skip it
[68100.689222] BTRFS info (device dm-13): the free space cache file (5161742237696) is invalid, skip it

I knew that filling up a btrfs filesystem was bad, but filling it the
normal way makes it slow down enough that you usually know and fix it.
Filling it by having an underlying dm-thin deny writes, is much worse (I expected
it wouldn't be pretty though, which is why I had a cronjob to catch this before it
happened, but I missed it due to the df bug).

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
