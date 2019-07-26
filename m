Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 560D17675D
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2019 15:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfGZNZs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Jul 2019 09:25:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:49438 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726074AbfGZNZp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Jul 2019 09:25:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1EE14AF1D;
        Fri, 26 Jul 2019 13:25:44 +0000 (UTC)
Subject: Re: BTRFS: Kmemleak errrors with do_sys_ftruncate
To:     Paul Menzel <pmenzel@molgen.mpg.de>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-btrfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <8c9b2f4e-252c-fee7-ef52-4ec2b9b54042@molgen.mpg.de>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c02fc5c2-2c1d-48c1-5e16-522a1756daed@suse.com>
Date:   Fri, 26 Jul 2019 16:25:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8c9b2f4e-252c-fee7-ef52-4ec2b9b54042@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 26.07.19 г. 16:16 ч., Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On a Power 8 server
> 
>     Linux power 5.3.0-rc1+ #1 SMP Fri Jul 26 11:34:28 CEST 2019 ppc64le ppc64le ppc64le GNU/Linux
> 
> Kmemleak reports the warnings below.
> 
> ```
> $ sudo more /sys/kernel/debug/kmemleak
> unreferenced object 0xc00000f290866130 (size 80):
>   comm "networkd-dispat", pid 7630, jiffies 4294903138 (age 6540.748s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 ff ff 00 00 00 00 00 00  ................
>     40 61 86 90 f2 00 00 c0 00 00 00 00 00 00 00 00  @a..............
>   backtrace:
>     [<00000000ecec0137>] alloc_extent_state+0x4c/0x1b0 [btrfs]
>     [<000000003f22a890>] __set_extent_bit+0x330/0x790 [btrfs]
>     [<0000000020fcf70f>] lock_extent_bits+0x98/0x320 [btrfs]
>     [<000000001d1d0f77>] btrfs_lock_and_flush_ordered_range+0xf0/0x1b0 [btrfs]
>     [<00000000195c001c>] btrfs_cont_expand+0x14c/0x600 [btrfs]
>     [<00000000f280c100>] btrfs_setattr+0x130/0x770 [btrfs]
>     [<000000008f89382e>] notify_change+0x218/0x5b0
>     [<00000000fc1ffb03>] do_truncate+0x9c/0x140
>     [<000000008b736052>] do_sys_ftruncate+0x1e4/0x210
>     [<00000000f67bba86>] system_call+0x5c/0x70
> unreferenced object 0xc000007f9cc555f0 (size 80):
>   comm "unattended-upgr", pid 8069, jiffies 4294903488 (age 6539.396s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 ff ff 00 00 00 00 00 00  ................
>     00 56 c5 9c 7f 00 00 c0 00 00 00 00 00 00 00 00  .V..............
>   backtrace:
>     [<00000000ecec0137>] alloc_extent_state+0x4c/0x1b0 [btrfs]
>     [<000000003f22a890>] __set_extent_bit+0x330/0x790 [btrfs]
>     [<0000000020fcf70f>] lock_extent_bits+0x98/0x320 [btrfs]
>     [<000000001d1d0f77>] btrfs_lock_and_flush_ordered_range+0xf0/0x1b0 [btrfs]
>     [<00000000195c001c>] btrfs_cont_expand+0x14c/0x600 [btrfs]
>     [<00000000f280c100>] btrfs_setattr+0x130/0x770 [btrfs]
>     [<000000008f89382e>] notify_change+0x218/0x5b0
>     [<00000000fc1ffb03>] do_truncate+0x9c/0x140
>     [<000000008b736052>] do_sys_ftruncate+0x1e4/0x210
>     [<00000000f67bba86>] system_call+0x5c/0x70
> unreferenced object 0xc000007fa1431fe0 (size 80):
>   comm "lxd", pid 8347, jiffies 4294904066 (age 6537.104s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 ff ff 00 00 00 00 00 00  ................
>     f0 1f 43 a1 7f 00 00 c0 00 00 00 00 00 00 00 00  ..C.............
>   backtrace:
>     [<00000000ecec0137>] alloc_extent_state+0x4c/0x1b0 [btrfs]
>     [<000000003f22a890>] __set_extent_bit+0x330/0x790 [btrfs]
>     [<0000000020fcf70f>] lock_extent_bits+0x98/0x320 [btrfs]
>     [<000000001d1d0f77>] btrfs_lock_and_flush_ordered_range+0xf0/0x1b0 [btrfs]
>     [<00000000195c001c>] btrfs_cont_expand+0x14c/0x600 [btrfs]
>     [<00000000f280c100>] btrfs_setattr+0x130/0x770 [btrfs]
>     [<000000008f89382e>] notify_change+0x218/0x5b0
>     [<00000000fc1ffb03>] do_truncate+0x9c/0x140
>     [<000000008b736052>] do_sys_ftruncate+0x1e4/0x210
>     [<00000000f67bba86>] system_call+0x5c/0x70
> unreferenced object 0xc000007f98359470 (size 80):
>   comm "lxd", pid 8347, jiffies 4294904738 (age 6534.416s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 ff ff 00 00 00 00 00 00  ................
>     80 94 35 98 7f 00 00 c0 00 00 00 00 00 00 00 00  ..5.............
>   backtrace:
>     [<00000000ecec0137>] alloc_extent_state+0x4c/0x1b0 [btrfs]
>     [<000000003f22a890>] __set_extent_bit+0x330/0x790 [btrfs]
>     [<0000000020fcf70f>] lock_extent_bits+0x98/0x320 [btrfs]
>     [<000000001d1d0f77>] btrfs_lock_and_flush_ordered_range+0xf0/0x1b0 [btrfs]
>     [<00000000195c001c>] btrfs_cont_expand+0x14c/0x600 [btrfs]
>     [<00000000f280c100>] btrfs_setattr+0x130/0x770 [btrfs]
>     [<000000008f89382e>] notify_change+0x218/0x5b0
>     [<00000000fc1ffb03>] do_truncate+0x9c/0x140
>     [<000000008b736052>] do_sys_ftruncate+0x1e4/0x210
>     [<00000000f67bba86>] system_call+0x5c/0x70
> unreferenced object 0xc000007f9e7078f0 (size 80):
>   comm "landscape-sysin", pid 10187, jiffies 4295061226 (age 5908.520s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 ff ff 00 00 00 00 00 00  ................
>     00 79 70 9e 7f 00 00 c0 00 00 00 00 00 00 00 00  .yp.............
>   backtrace:
>     [<00000000ecec0137>] alloc_extent_state+0x4c/0x1b0 [btrfs]
>     [<000000003f22a890>] __set_extent_bit+0x330/0x790 [btrfs]
>     [<0000000020fcf70f>] lock_extent_bits+0x98/0x320 [btrfs]
>     [<000000001d1d0f77>] btrfs_lock_and_flush_ordered_range+0xf0/0x1b0 [btrfs]
>     [<00000000195c001c>] btrfs_cont_expand+0x14c/0x600 [btrfs]
>     [<00000000f280c100>] btrfs_setattr+0x130/0x770 [btrfs]
>     [<000000008f89382e>] notify_change+0x218/0x5b0
>     [<00000000fc1ffb03>] do_truncate+0x9c/0x140
>     [<000000008b736052>] do_sys_ftruncate+0x1e4/0x210
>     [<00000000f67bba86>] system_call+0x5c/0x70
> unreferenced object 0xc00000f29b4f48d0 (size 80):
>   comm "landscape-sysin", pid 14433, jiffies 4295569439 (age 3876.396s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 ff ff 00 00 00 00 00 00  ................
>     e0 48 4f 9b f2 00 00 c0 00 00 00 00 00 00 00 00  .HO.............
>   backtrace:
>     [<00000000ecec0137>] alloc_extent_state+0x4c/0x1b0 [btrfs]
>     [<000000003f22a890>] __set_extent_bit+0x330/0x790 [btrfs]
>     [<0000000020fcf70f>] lock_extent_bits+0x98/0x320 [btrfs]
>     [<000000001d1d0f77>] btrfs_lock_and_flush_ordered_range+0xf0/0x1b0 [btrfs]
>     [<00000000195c001c>] btrfs_cont_expand+0x14c/0x600 [btrfs]
>     [<00000000f280c100>] btrfs_setattr+0x130/0x770 [btrfs]
>     [<000000008f89382e>] notify_change+0x218/0x5b0
>     [<00000000fc1ffb03>] do_truncate+0x9c/0x140
>     [<000000008b736052>] do_sys_ftruncate+0x1e4/0x210
>     [<00000000f67bba86>] system_call+0x5c/0x70
> ```
> 
> I believe these have been present for some releases already, but Kmemleak
> was broken until now on that system, so that I could only report them now.

the lock and flush ordered range  leaks were fixed just today  by patch :

 btrfs: fix extent_state leak in btrfs_lock_and_flush_ordered_range

So either get it and retest or wait until the RC2 pull req gets merged.


> 
> 
> Kind regards,
> 
> Paul
> 
