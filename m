Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F0059EF8F
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Aug 2022 01:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbiHWXJB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Aug 2022 19:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiHWXJA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Aug 2022 19:09:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24A9183B4
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 16:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661296123;
        bh=g3LmARl92shP1wlUP3fhulW5kYj+R9Sr0ezCaH4KFl8=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=VXS+x6lZMDN4+B/L8sc4nwR5R6dvvPMSWclV3oKGw6lDKXKUas+yG3rVnI+/+8sMn
         EYBY8vTJ5f+uRZKhhUr5NHl+C0Ra5u4wi5c9V4RsCh/j5HDvyUbdS08SlPR214InTe
         PV5E/QABD9AXrDAAngliP3BrvS0J2ncNBDEceu/Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGz1f-1oe7Wj3QrD-00E72U; Wed, 24
 Aug 2022 01:08:43 +0200
Message-ID: <c2c1f526-d183-8ade-1439-71d1e23f6ea9@gmx.com>
Date:   Wed, 24 Aug 2022 07:08:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: xfstests is rather unhappy on current for-next
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <YwT+GsTRLUwXKJ2w@infradead.org> <YwUEWy9ixBdEztCK@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <YwUEWy9ixBdEztCK@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TFdwFjJ62twL0oH27sNAI/AqkY0qBuRKjVu9qW75WxGVLpxCdNS
 0IG+E2gkik/NvCy2QfI3J1Za8uSmZRbti3gu7kSAJLKD8QcYnYcx81IfEsuAF8fdnIu6KnQ
 y0yEz5z7w8GPadTaQwIYumEMpFRc6qvGpDAHIAH/Q6L2JkwKahTvFAFwi6u1KpfHjy6JEVm
 vUEligLpq5Yz6+dxoPivQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:msCsZzskEtU=:9ooc5ZkbozhiuTVuRVjGWN
 izkS2CTUwxL2ru4GXEeV9isn1iBzZgsFYe3TXWkS/d5IoSPl1CJT460ByiGNmA+ja2yTnI0/W
 q6pwjGpiF/k+EIoZulxntBwjjErAy+7mwiXtXhLZBYd5++bzhEthHf0XDK2iU5cyknvCEcC+K
 vKAsH1DYT6U1j+IBeVz9DGz5Ui8oRRF20NgYHlmiXAlr/widyS54wloTVnaHtqSTHMMZvoo3M
 /b6D26mhQUSawzOnBU9M1jnI5olR3LNAhotNpccqDg+d3krTZZ9EFpkQGpN8/aEB669tbTz7b
 AldeFoXb4wqaWtHsXTC3VLo41E0r1UxiDoWcrTp/lgG2gti0cgu7e7KY/bpfQFz0whISohBk9
 pltjFIAJm2KtWZAh/oaD91CPNbnqEEleRZSfJL/ugN7wJYqIkNu1d54fJn3TEKZscjzrHZ5IY
 X3zI/d8cfSxQiPp7cq7PGW7HpD2ghAs9uzw1RS6H0WHWUaRbzhkCl1JxQoxue31i91Ywb8Djy
 dFDQvzdhGVMxleZ+G5fG1a8kWiSrAzsGUFESIQVGcvC3pSe3Mjc5hyXqTd+i/+4Mdvmo4MQjQ
 Ffipf3tZ5ps258k3mDMmnry4dBmicp9K6/wQZ0KXGyyAMRHNnUKH0sQ8dCpjRCfTKgF/TJf8N
 5xPgEND/rcSBg5Y4UDC5S4QfgFpxxbfvT1PaFdPsKkPkw9+LmF028yhb69XMhU99AYK6lJGKo
 xmDef8IQtCdGUy1tq7rXVawQswnGWIFsSsHoYqbuRSm3mYPAKGMTF6pQCaqDdcNbkn9yYLqmf
 YczfeOEx/YLj5B6G3ImySt469084iwAACmU6wZp0cuyibsQB3hkcG9I4ddWPE9vnTFdalCK+9
 Pg73REsDt1fcQHfcr9Cdea+y3QNUDFCCJUIVbFyjzCoRDZz8V5fZ5ebygtc1xZ7otsoJQNkLa
 ASysCCZtxtNqLdCpBcm1aabC3BuEOsBzbL1qwmxCbrV+P7LziQDUqK5xcRxGoHfoIrGMdRK7d
 YS4plJ3jDotEfwPvYYr/Ii9f2nu8Idrgj8C+B6rsDpoNef3iRNxPzSpiNu8wxa4y9gxP+nyPm
 mjgr2x4SF9Mnn2RhqsiTqI/OZzkOOtr15F+UuZA7zuWqjJzt2rzafaQhw==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/24 00:46, Christoph Hellwig wrote:
> On Tue, Aug 23, 2022 at 09:19:38AM -0700, Christoph Hellwig wrote:
>> default options on x86-64 with a five-device spare pool gets
>> unhappy in the kobject code when running btrfs/017, and the
>> xfstest run then hangs:
>
> I've bisect this to:
>
> [80e96a54dd6993d6de0dc81285c02c709487808a] btrfs: sysfs: introduce
> qgroup global attribute groups
>

Thanks, will take a look into this, I guess some code base is already
out of date.

Thanks,
Qu

>
>>
>> [   85.716152] run fstests btrfs/017 at 2022-08-23 16:15:45
>> [   87.843179] BTRFS: device fsid 439db035-2c01-4c8e-9217-40d0accfd536 =
devid 1 transid 6)
>> [   87.921800] BTRFS info (device vdc): using crc32c (crc32c-generic) c=
hecksum algorithm
>> [   87.923465] BTRFS info (device vdc): using free space tree
>> [   87.937642] BTRFS info (device vdc): checking UUID tree
>> [   88.046021] kobject (ffff888104755140): tried to init an initialized=
 object, somethin.
>> [   88.048050] CPU: 0 PID: 7250 Comm: btrfs Not tainted 6.0.0-rc2-block=
+ #2218
>> [   88.049364] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1.14.0-2 04/04
>> [   88.050906] Call Trace:
>> [   88.051381]  <TASK>
>> [   88.051798]  dump_stack_lvl+0x56/0x6f
>> [   88.052506]  kobject_init.cold+0x31/0x3f
>> [   88.053251]  kobject_init_and_add+0x35/0xa0
>> [   88.054022]  ? rcu_read_lock_sched_held+0x3a/0x60
>> [   88.054864]  ? trace_kmalloc+0x29/0xd0
>> [   88.055537]  ? kmem_cache_alloc_trace+0x1ee/0x340
>> [   88.056376]  btrfs_sysfs_add_qgroups+0x87/0x100
>> [   88.057192]  btrfs_quota_enable+0xc6/0x830
>> [   88.057930]  ? trace_kmalloc+0x29/0xd0
>> [   88.058598]  ? __kmalloc_track_caller+0x20f/0x3b0
>> [   88.059431]  ? btrfs_ioctl+0x251f/0x35c0
>> [   88.060138]  btrfs_ioctl+0x2e06/0x35c0
>> [   88.060818]  ? find_held_lock+0x2b/0x80
>> [   88.061519]  ? lock_release+0x147/0x2f0
>> [   88.062217]  ? __x64_sys_ioctl+0x7b/0xb0
>> [   88.062919]  __x64_sys_ioctl+0x7b/0xb0
>> [   88.063592]  do_syscall_64+0x35/0x80
>> [   88.064245]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> [   88.065146] RIP: 0033:0x7f0240ada397
>> [   88.065912] Code: 3c 1c e8 1c ff ff ff 85 c0 79 87 49 c7 c4 ff ff ff=
 ff 5b 5d 4c 89 e8
>> [   88.069908] RSP: 002b:00007fff156c90c8 EFLAGS: 00000202 ORIG_RAX: 00=
00000000000010
>> [   88.071473] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0=
240ada397
>> [   88.072988] RDX: 00007fff156c90e0 RSI: 00000000c0109428 RDI: 0000000=
000000003
>> [   88.074391] RBP: 0000000000000003 R08: 000056165e61c2a0 R09: 00007f0=
240bb8c00
>> [   88.075788] R10: fffffffffffff248 R11: 0000000000000202 R12: 00007ff=
f156c9dfa
>> [   88.077433] R13: 0000000000000001 R14: 000056165cc0008d R15: 00007ff=
f156c9288
>> [   88.079003]  </TASK>
>> [   88.080327] general protection fault, probably for non-canonical add=
ress 0x1ad998badaI
>> [   88.082664] CPU: 1 PID: 7250 Comm: btrfs Not tainted 6.0.0-rc2-block=
+ #2218
>> [   88.083949] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS 1.14.0-2 04/04
>> [   88.085488] RIP: 0010:kfree+0x6e/0x550
>> [   88.086159] Code: 01 d8 0f 82 dd 04 00 00 49 bc 00 00 00 80 7f 77 00=
 00 49 01 c4 48 b4
>> [   88.089383] RSP: 0018:ffffc900036d7c58 EFLAGS: 00010203
>> [   88.090304] RAX: ffffea0000000000 RBX: 6b6b6b6b6b6b6b6b RCX: 0000000=
000000001
>> [   88.091550] RDX: 0000000000000000 RSI: ffffffff82fbd87b RDI: fffffff=
f830a6076
>> [   88.092793] RBP: ffffc900036d7c90 R08: ffffffff83085f05 R09: 0000000=
000000001
>> [   88.094042] R10: 0000000000000304 R11: ffffffff83a3b9e0 R12: 01ad998=
badadad80
>> [   88.095345] R13: ffff888104755140 R14: ffff88810d375910 R15: ffff888=
10d3b4000
>> [   88.096588] FS:  00007f02409e8d40(0000) GS:ffff88813bd00000(0000) kn=
lGS:00000000000000
>> [   88.098002] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [   88.099010] CR2: 000055f382527900 CR3: 000000010d1da000 CR4: 0000000=
0000006e0
>> [   88.100254] Call Trace:
>> [   88.100699]  <TASK>
>> [   88.101088]  kobject_set_name_vargs+0x6f/0x90
>> [   88.101950]  kobject_init_and_add+0x5d/0xa0
>> [   88.102697]  ? trace_kmalloc+0x29/0xd0
>> [   88.103366]  ? kmem_cache_alloc_trace+0x1ee/0x340
>> [   88.104256]  btrfs_sysfs_add_qgroups+0x87/0x100
>> [   88.105340]  btrfs_quota_enable+0xc6/0x830
>> [   88.106076]  ? trace_kmalloc+0x29/0xd0
>> [   88.106748]  ? __kmalloc_track_caller+0x20f/0x3b0
>> [   88.107584]  ? btrfs_ioctl+0x251f/0x35c0
>> [   88.108282]  btrfs_ioctl+0x2e06/0x35c0
>> [   88.108953]  ? find_held_lock+0x2b/0x80
>> [   88.109654]  ? lock_release+0x147/0x2f0
>> [   88.110340]  ? __x64_sys_ioctl+0x7b/0xb0
>> [   88.111038]  __x64_sys_ioctl+0x7b/0xb0
>> [   88.111724]  do_syscall_64+0x35/0x80
>> [   88.112368]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>> [   88.113263] RIP: 0033:0x7f0240ada397
>> [   88.113913] Code: 3c 1c e8 1c ff ff ff 85 c0 79 87 49 c7 c4 ff ff ff=
 ff 5b 5d 4c 89 e8
>> [   88.117319] RSP: 002b:00007fff156c90c8 EFLAGS: 00000202 ORIG_RAX: 00=
00000000000010
>> [   88.118657] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f0=
240ada397
>> [   88.119898] RDX: 00007fff156c90e0 RSI: 00000000c0109428 RDI: 0000000=
000000003
>> [   88.121137] RBP: 0000000000000003 R08: 000056165e61c2a0 R09: 00007f0=
240bb8c00
>> [   88.122404] R10: fffffffffffff248 R11: 0000000000000202 R12: 00007ff=
f156c9dfa
>> [   88.123648] R13: 0000000000000001 R14: 000056165cc0008d R15: 00007ff=
f156c9288
>> [   88.124895]  </TASK>
>> [   88.125298] Modules linked in:
>> [   88.126308] ---[ end trace 0000000000000000 ]---
>>
>>
>>
>>
>>
> ---end quoted text---
