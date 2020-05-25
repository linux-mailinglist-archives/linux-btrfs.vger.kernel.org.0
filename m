Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8321E0501
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 May 2020 05:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388219AbgEYDBR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 24 May 2020 23:01:17 -0400
Received: from magic.merlins.org ([209.81.13.136]:44554 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388178AbgEYDBR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 24 May 2020 23:01:17 -0400
Received: from merlin by mail1.merlins.org with local (Exim 4.92 #3)
        id 1jd3MY-0006jw-6O by authid <merlin>; Sun, 24 May 2020 20:01:14 -0700
Date:   Sun, 24 May 2020 20:01:14 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Su Yue <Damenly_Su@gmx.com>, linux-btrfs@vger.kernel.org,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     Su Yue <suy.fnst@cn.fujitsu.com>
Subject: Re: 5.5 kernel and btrfs-progs v5.6 create and cannot fix 'root
 204162 inode 14058737 errors 1000, some csum missing'
Message-ID: <20200525030114.GA23688@merlins.org>
References: <20200524213059.GI23519@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524213059.GI23519@merlins.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: marc@merlins.org
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I forgot to add:

I'll keep my system in the broken state for maybe a day or two at most,
but given that this is my root filesystem and that I'm booted off a
backup media, I can't stay in that state too long.

This may not be nothing new and if it's already known that the way out
is to wipe and restore backups, let me know.

Thnaks,
Marc

On Sun, May 24, 2020 at 02:30:59PM -0700, Marc MERLIN wrote:
> My data is fine, it's double backed up and the filesystem is still mountable without issues.
> But I had an error that broke btrfs send, and after fixing it with repair, I'm stuck with thses 'csum missing'
> 
> Any idea if I can fix them without deleting the filesystem?
> 
> Current state:
> saruman:~# btrfs check --repair /dev/mapper/cr
> enabling repair mode
> Starting repair.
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/cr
> UUID: 4cb82363-e833-444e-b23e-1597a14a8aab
> [1/7] checking root items
> Fixed 0 roots.
> [2/7] checking extents
> No device size related problem found
> [3/7] checking free space cache
> cache and super generation don't match, space cache will be invalidated
> [4/7] checking fs roots
> root 356 inode 14058737 errors 1000, some csum missing
> root 197362 inode 14058737 errors 1000, some csum missing
> root 199551 inode 14058737 errors 1000, some csum missing
> (snip)
> root 204167 inode 14058737 errors 1000, some csum missing
> root 204168 inode 14058737 errors 1000, some csum missing
> ERROR: errors found in fs roots
> found 112392159232 bytes used, error(s) found
> total csum bytes: 105763716
> total tree bytes: 4036018176
> total fs tree bytes: 3666313216
> total extent tree bytes: 214728704
> btree space waste bytes: 875560453
> file data blocks allocated: 207903920128
>  referenced 206918037504
> 
> I can run multiple times, 'some csum missing' does not get fixed.
> 
> Lowmem does not fix it either:
> saruman:~# btrfs check --mode=lowmem --repair /dev/mapper/cr
> Starting repair.
> WARNING: low-memory mode repair support is only partial
> Opening filesystem to check...
> Checking filesystem on /dev/mapper/cr
> UUID: 4cb82363-e833-444e-b23e-1597a14a8aab
> [1/7] checking root items
> Fixed 0 roots.
> [2/7] checking extents
> No device size related problem found
> [3/7] checking free space cache
> cache and super generation don't match, space cache will be invalidated
> [4/7] checking fs roots
> ERROR: root 356 EXTENT_DATA[14058737 0] csum missing, have: 0, expected: 8192
> ERROR: root 356 EXTENT_DATA[14058737 0] compressed extent must have csum, but only 0 bytes have, expect 8192
> Add a hole [0, 4096] in inode [33037178]
> Add a hole [0, 4096] in inode [33037180]
> Add a hole [0, 4096] in inode [33037181]
> Add a hole [0, 4096] in inode [33037188]
> Add a hole [0, 4096] in inode [33037189]
> Add a hole [0, 4096] in inode [33037191]
> ERROR: root 197362 EXTENT_DATA[14058737 0] csum missing, have: 0, expected: 8192
> ERROR: root 197362 EXTENT_DATA[14058737 0] compressed extent must have csum, but only 0 bytes have, expect 8192
> Add a hole [0, 4096] in inode [33037178]
> Add a hole [0, 4096] in inode [33037180]
> (...)
> Add a hole [0, 4096] in inode [33037189]
> Add a hole [0, 4096] in inode [33037191]
> ERROR: errors found in fs roots
> found 112392294400 bytes used, error(s) found
> total csum bytes: 105763716
> total tree bytes: 4035985408
> total fs tree bytes: 3666313216
> total extent tree bytes: 214728704
> btree space waste bytes: 875550920
> file data blocks allocated: 207903920128
>  referenced 206918037504
> 
> 
> This originally started with:
> BTRFS error (device dm-0): did not find backref in send_root. inode=14058737, offset=0, disk_byte=2694234112 found extent=2694234112
> 
> which I was able to fix with the repair below, but now I'm stuck with the 'some csum missing'.
> Checking filesystem on /dev/mapper/cr
> UUID: 4cb82363-e833-444e-b23e-1597a14a8aab
> [1/7] checking root items
> [2/7] checking extents
> data backref 2694234112 root 356 owner 14058737 offset 0 num_refs 0 not found in extent tree
> incorrect local backref count on 2694234112 root 356 owner 14058737 offset 0 found 1 wanted 0 back 0x55e7383a3a00
> incorrect local backref count on 2694234112 root 2147484004 owner 14058737 offset 0 found 0 wanted 1 back 0x55e733d1c2b0
> backref disk bytenr does not match extent record, bytenr=2694234112, ref bytenr=0
> backpointer mismatch on [2694234112 8192]
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space cache
> [4/7] checking fs roots
> root 356 inode 33037179 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 8192
> root 203332 inode 33037179 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 8192
> root 203669 inode 33037179 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 8192
> root 204006 inode 33037179 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 8192
> root 204010 inode 33037179 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 8192
> root 204024 inode 33037179 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 8192
> root 204037 inode 33037179 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 8192
> root 204049 inode 33037179 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 8192
> root 204167 inode 33037179 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 8192
> root 204168 inode 33037179 errors 100, file extent discount
> Found file extent holes:
>         start: 0, len: 8192
> ERROR: errors found in fs roots
> found 111202623488 bytes used, error(s) found
> total csum bytes: 105763728
> total tree bytes: 2846048256
> total fs tree bytes: 2485485568
> total extent tree bytes: 205619200
> btree space waste bytes: 668593131
> file data blocks allocated: 149272375296
>  referenced 140124020736
> -- 
> "A mouse is a device used to point at the xterm you want to type in" - A.S.R.
>  
> Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
> 

-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/  
