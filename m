Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0833D415572
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 04:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238919AbhIWCdI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Sep 2021 22:33:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:58945 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238859AbhIWCdI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Sep 2021 22:33:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
        s=badeba3b8450; t=1632364262;
        bh=KB5ty1qLGgOUSJ01Uplt75ITqAkGDkvEfaUi1HBoiyg=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=WupzdjdJfUqBBbEjpbuZwpBAWPKE07wj16alof25FGOGd6ZG4lKJ+7+ltT3xLczY4
         KTLpanIcJKAGv4YI5E9RyDd+JYpn4DTth0/XyOCyFlGkJAVHFo3D8t66d6vxYNA4Wo
         CAs0QwzLj52fmsNzoopvTSFw98pZM/ChqUackeYE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M7Jza-1mWYR80z0e-007i8Z; Thu, 23
 Sep 2021 04:31:02 +0200
Message-ID: <1c1f0f00-cb9a-af0a-2662-bb144e353aa0@gmx.com>
Date:   Thu, 23 Sep 2021 10:30:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: kernel BUG in __clear_extent_bit
Content-Language: en-US
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     clm@fb.com, dsterba@suse.com, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CACkBjsYjkubyQBvBy7aaQStk_i1UuCu7oPNYXhZhvhWvBCM3ag@mail.gmail.com>
 <145029f0-5bc5-73fd-14ee-75b5829a3334@gmx.com>
 <CACkBjsauCShYkOdNU2snmJyLNSmdMvK7C0HbtMfKhoEXuUOSJg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CACkBjsauCShYkOdNU2snmJyLNSmdMvK7C0HbtMfKhoEXuUOSJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Hi/5JfdTbWsUQSBlII1cbJvqXVjXIRK87Fanh5OPkB5+wBcf3xp
 eoAC05n5TofkRGNVTx7M98IWp7cl3DVbOhkbGUeKIToVtB4nmD9HdulcdG9Jiy1B+JuNq2w
 iPmbtFmRrGpjgBtI3M7uI7/NbbsLwbHKlrZCnQT1SDWJjbK1QfZlIZi9OVQoOtGaccBVrA0
 JgmuITuQwCAvL6ZmIxK5w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TEk9plFl97k=:zPAS4UQWMO24bnIDim4SNy
 YXGX1n6//JVmDD1mnkbKNaw2Yl9FrfwcsWHCVfAbndrgOtYz8RqI5ZUnSarZuU4NZ5VGWN4C4
 WlEc1rXglflEnqyKyh3kEKdOM1QezrGFc7lt5RoCsZH82sd1CwZzEDz2TKM+rV1NVtECtRL7a
 EQDekH7GI6oy/WRKzCLjOJX+eQDkzxRCR8FDiuOrFqGtjBIQpF8TzxYt7ZRX+hTQSTbeyeopD
 Zx2u7M95ILKbgxH+K0CYWMQs3S3TXIy93cjIRXAeao9Phvc2DzYhVGEC2m0pr5SbsRQYYsc7a
 8SjlYchScMw17qmCcfP5CzL4rX2WMqCHCS8FBDeXZg5ZaME1oT8oxp1zLgL9D05hhHPb7Yb0Q
 uuOaFGrktqjF0Z/dIHiReMrQwp9Fm05duWgm1F+seRpOTeGmuZ7JyXAbRKzpoIYLCDdjZMeBG
 zwXeuMkH6OzHS380d6PA4BXV9y8Es2BQxVnb8I6RI5TscALPYy9xNvOXumEzOI6no3z0POviu
 01d7+MBQOofddbhi8mb5chj08vS0Zs4kuWA0o+yqt0RNZa3ypy3nIj5AIOPPvUI1P8o6LxmkK
 GCcH9ClA0m3gJq981wgY996XFuARLXZuQFLinGHu1JM5WqKtB7EFjkATGhHu11m4izpREfTkn
 KVglsmZbS4GuFXiEjaq9QyD6Z6Eg9uiygfA0NcytubQLWZYxXm5jMPWF8TJhzYgys2UYny+xP
 4XTXuSaATkrtO62zr1W7ooEqB7j2g2pZy/25PHCxjC5+Hhja6A/dKoIcTkD8kweXETf5l5d0n
 3Y1ZHD4IT6XAHvqK3fDCvXgN1mh9jdnN8XkjOfQl5FLX9PLqXzbThgcaLKp5MVeVv8+CHCxt5
 lsNMQodx+8d0zoemNbUEbxj7+puiMYN+t1dl9Jlh1YImjX+Un+Sr/kfTDOWTRnIhQ8uUDnGbR
 A8olEC7cFh7BoLu3EoYNjho+wwuXaRrU87Prp7hWcWHRhttOrrbAas5HNHWggzbZWb0l7kii2
 daO5snlylTCrtuw3S1g9Wum9D1jwdwjKcoYWIlbIKWdq/kqLTPI4y0wIcXSdE6QFJsjdtSgb7
 jbfuHoqN1WFjLh559DawNwb8HMICJSpWxdym61nwbJlK6dO2cqTBtuKNOoFUOQ2lB7Sks51yR
 Oyuz7STpYiImxB4hIplAAR4cMh
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/23 10:24, Hao Sun wrote:
> Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=8815=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=881:33=E5=86=99=E9=81=93=EF=BC=9A
>>
>>
>>
>> On 2021/9/15 =E4=B8=8A=E5=8D=8810:20, Hao Sun wrote:
>>> Hello,
>>>
>>> When using Healer to fuzz the latest Linux kernel, the following crash
>>> was triggered.
>>>
>>> HEAD commit: 6880fa6c5660 Linux 5.15-rc1
>>> git tree: upstream
>>> console output:
>>> https://drive.google.com/file/d/1-9wwV6-OmBcJvHGCbMbP5_uCVvrUdTp3/view=
?usp=3Dsharing
>>> kernel config: https://drive.google.com/file/d/1rUzyMbe5vcs6khA3tL9EHT=
LJvsUdWcgB/view?usp=3Dsharing
>>> C reproducer: https://drive.google.com/file/d/1eXePTqMQ5ZA0TWtgpTX50Ez=
4q9ZKm_HE/view?usp=3Dsharing
>>> Syzlang reproducer:
>>> https://drive.google.com/file/d/11s13louoKZ7Uz0mdywM2jmE9B1JEIt8U/view=
?usp=3Dsharing
>>>
>>> If you fix this issue, please add the following tag to the commit:
>>> Reported-by: Hao Sun <sunhao.th@gmail.com>
>>>
>>> loop1: detected capacity change from 0 to 32768
>>> BTRFS info (device loop1): disk space caching is enabled
>>> BTRFS info (device loop1): has skinny extents
>>> BTRFS info (device loop1): enabling ssd optimizations
>>> FAULT_INJECTION: forcing a failure.
>>> name failslab, interval 1, probability 0, space 0, times 0
>>> CPU: 1 PID: 25852 Comm: syz-executor Not tainted 5.15.0-rc1 #16
>>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>>> rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
>>> Call Trace:
>>>    __dump_stack lib/dump_stack.c:88 [inline]
>>>    dump_stack_lvl+0x8d/0xcf lib/dump_stack.c:106
>>>    fail_dump lib/fault-inject.c:52 [inline]
>>>    should_fail+0x13c/0x160 lib/fault-inject.c:146
>>>    should_failslab+0x5/0x10 mm/slab_common.c:1328
>>>    slab_pre_alloc_hook.constprop.99+0x4e/0xc0 mm/slab.h:494
>>>    slab_alloc_node mm/slub.c:3120 [inline]
>>>    slab_alloc mm/slub.c:3214 [inline]
>>>    kmem_cache_alloc+0x44/0x280 mm/slub.c:3219
>>>    alloc_extent_state+0x1e/0x1c0 fs/btrfs/extent_io.c:340
>>
>> This is the one of the core systems btrfs uses, and we really don't wan=
t
>> that to fail.
>>
>> Thus in fact it does some preallocation to prevent failure.
>>
>> But for error injection case, we can still hit BUG_ON() which is used t=
o
>> catch ENOMEM.
>>
>
> Hello,
>
> Fuzzer triggered following crashes repeatedly when the `fault
> injection` was enabled.
>
> HEAD commit: 92477dd1faa6 Merge tag 's390-5.15-ebpf-jit-fixes'
> git tree: upstream
> kernel config: https://drive.google.com/file/d/1KgvcM8i_3hQiOL3fUh3JFpYN=
QM4itvV4/view?usp=3Dsharing
> [1] kernel BUG in btrfs_free_tree_block (fs/btrfs/extent-tree.c:3297):
> https://paste.ubuntu.com/p/ZtzVKWbcGm/
> [2] kernel BUG in clear_state_bit (fs/btrfs/extent_io.c:658!):
> https://paste.ubuntu.com/p/hps2wXPG2b/
> [3] kernel BUG in set_extent_bit (fs/btrfs/extent_io.c:1021):
> https://paste.ubuntu.com/p/dcptjYYxgd/
> [4] kernel BUG in set_state_bits (fs/btrfs/extent_io.c:939):
> https://paste.ubuntu.com/p/NV9qtKB4KZ/
>
> All the above crashes were triggered directly by the `BUG_ON()` macro
> in the corresponding location.
> Most `BUG_ON()` was hit due to `ENOMEM` when fault injected.
> Would it be better for btrfs to handle the `ENOMEM` error, e.g.,
> gracefully return, rather than panic the kernel?

The __clear_extent_bit() part is one of the critical section where we
really rely on that to be work correctly.

We even implemented a preallocation scheme to prevent such problems, but
error injection won't be completely resolved by preallocation.

We indeed need to do the error handling better, but that would be a
pretty big project, not something can be easily done right now.

Thanks,
Qu
>
> Regards
> Hao
>
