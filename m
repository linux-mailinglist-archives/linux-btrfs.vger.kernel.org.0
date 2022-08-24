Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CCB59F014
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Aug 2022 02:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiHXAHC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Aug 2022 20:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiHXAHB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Aug 2022 20:07:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6C72FFE2
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Aug 2022 17:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1661299609;
        bh=MfX7drgwuyWjD2EC8YYF2XEIQkneWJSbjpGei1KUbdQ=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=B4u7FY4RU2Lpu7cHU2hkC5UuHZKKC/xx2x5LLghBraX705sQIJNI8P7zxkwjaprDN
         uqjop9nS7NnnBZErWMJOtB7W+kv600GhO1Yhz8AHKyHE3XbwmtHUjNQyr8v0SBAkp8
         AUf2Fl+C7wL4rV6bax5wUQCKRA9Bo/aieXibExm4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MxUs7-1pNq8f1coj-00xvsM; Wed, 24
 Aug 2022 02:06:49 +0200
Message-ID: <d3836d12-641a-a332-12bf-7aff815f1850@gmx.com>
Date:   Wed, 24 Aug 2022 08:06:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: xfstests is rather unhappy on current for-next
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <YwT+GsTRLUwXKJ2w@infradead.org> <YwUEWy9ixBdEztCK@infradead.org>
 <c2c1f526-d183-8ade-1439-71d1e23f6ea9@gmx.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <c2c1f526-d183-8ade-1439-71d1e23f6ea9@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sYpRBpdDKXiewxABFGq7YZ4+6CAEtAyXU1xJ6B6AZSnQzEqOW0c
 fSigvkA8k9Q5PGNyrG7C6lMYJEHIBDDBCxuNG+4bqfuVGiZyrB7fNtYiKPLYYmmaps7Ac5U
 DU36lEz0Q9toJTz/k2grh2RR84RQEMQdWNqErsNHuMn2R5AVpyS6HLOnrs0UIOHWccENyh/
 AiN6w/NXNfi9FGslBXYaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Na3+HyoPr4Q=:k60Cbya2p3Y12wPZhkOSNo
 1z+hqoSeZsLKh9gSly7U0CzZUbA1ycAbqNJ/9GpDOZ6lu9Z0LBu8866N/PeOAFE+3Y6wi/DI2
 aQmutbkJoaRYERhe01lcZ+inEmau2bJ+r594rRnwoIGglhs1KuX05kr4EZgJOO9jLR/KEbJOf
 rlDZ3lT3S2sEAC+2ganxkfE175kiMkAun4X5Xhxx12q/rF6E/kXW8YK6GUhINcUUmKOE5Ir3N
 Khf2ZI2MGk7zRD0KYvHie0LqhkXj+a6C9EMvX/whkJVUavayraduBxAsXGb9vW/VNAFWv9y/o
 99AoIq/B6mY5u+jGNsLUr4ZiW5tIIZITTNEDNdCLY7i0qUDr9530L8botof0zuOBYehHoSG36
 UZpieeDXbTcd3+Oigs27aH9vcluPdNquSGNoPe5HVbVq7TUG7uoiZTMBQ5RFtUNThs21Ogt04
 aMnIMmUNB58fTozeA/PpwxsZguiZIHKUlv/luVxJ3flHojp1hyx2sX5AhmPZmaGenxvDwWAVq
 5dMnT6V7/tAugcHuLqY4Vjw7JNS/QZqIocs6ni1CFGnRQVA7/6d0d/1Ia3T+6BANYmncEAVpC
 oYBOmlW8QBPEL2vxtsZNTxy/5B6mM1JqLOE8aL1H8/RxKBtDHTxHD0hwqZMrq+nbtb6hT/QgY
 V3qd9+Zu8fyVSw7CxZxAEjpjSdJXdIVuWlcwRXQYVI57RiPHIjZApiJBy0sBHLFnfE018P5ct
 ndPJPt61bO3lneGB2fkMEvpoF9kviJrtD8h+qvqQTeZTQe3FijyvUFLB/eSps41+X8JOQV96f
 /D9yTXoqtZVbzJatrCCp0zFCKrQ+JWmjAhA/ZppTc5VoBv9+nPkTiPxLBQgr3T7YPst42/Tqo
 A8FBwqPQR+00aQhI+WtjMqBfw4QOpGpkLY/rg8zIs/Vyx27D5l46luy+kISHBPwMrAl6InBV5
 xVuD3fxznqj9Uv5N+bH5tGbkwBrhBOSdVXUxZGrr5BirZ2pisItGkCaT0JtGYtpUusplmsWe3
 kW/Rip9BmakCqnqcDy/8/n7Z/eoqdKUiagxQR04pnZSSmwV3kvq1UA3jTtKwwtYXLvkozgCb/
 oL3a9GY2usSK6cizQUjh+AhYhhY7BBrshekljny7sduGYkxDcweJs45NQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/24 07:08, Qu Wenruo wrote:
>
>
> On 2022/8/24 00:46, Christoph Hellwig wrote:
>> On Tue, Aug 23, 2022 at 09:19:38AM -0700, Christoph Hellwig wrote:
>>> default options on x86-64 with a five-device spare pool gets
>>> unhappy in the kobject code when running btrfs/017, and the
>>> xfstest run then hangs:
>>
>> I've bisect this to:
>>
>> [80e96a54dd6993d6de0dc81285c02c709487808a] btrfs: sysfs: introduce
>> qgroup global attribute groups
>>
>
> Thanks, will take a look into this, I guess some code base is already
> out of date.

Root cause is in that commit, I'm using kmalloc() for fs_info->qgroups_kob=
j.

Not sure why my previous runs didn't trigger the problem...

Simply change that kmalloc() to kzalloc() can fix it.

Will do more testing to make sure the seemingly untouched patchset is
still doing its work correctly.

Thanks,
Qu

>
> Thanks,
> Qu
>
>>
>>>
>>> [=C2=A0=C2=A0 85.716152] run fstests btrfs/017 at 2022-08-23 16:15:45
>>> [=C2=A0=C2=A0 87.843179] BTRFS: device fsid
>>> 439db035-2c01-4c8e-9217-40d0accfd536 devid 1 transid 6)
>>> [=C2=A0=C2=A0 87.921800] BTRFS info (device vdc): using crc32c (crc32c=
-generic)
>>> checksum algorithm
>>> [=C2=A0=C2=A0 87.923465] BTRFS info (device vdc): using free space tre=
e
>>> [=C2=A0=C2=A0 87.937642] BTRFS info (device vdc): checking UUID tree
>>> [=C2=A0=C2=A0 88.046021] kobject (ffff888104755140): tried to init an
>>> initialized object, somethin.
>>> [=C2=A0=C2=A0 88.048050] CPU: 0 PID: 7250 Comm: btrfs Not tainted
>>> 6.0.0-rc2-block+ #2218
>>> [=C2=A0=C2=A0 88.049364] Hardware name: QEMU Standard PC (i440FX + PII=
X, 1996),
>>> BIOS 1.14.0-2 04/04
>>> [=C2=A0=C2=A0 88.050906] Call Trace:
>>> [=C2=A0=C2=A0 88.051381]=C2=A0 <TASK>
>>> [=C2=A0=C2=A0 88.051798]=C2=A0 dump_stack_lvl+0x56/0x6f
>>> [=C2=A0=C2=A0 88.052506]=C2=A0 kobject_init.cold+0x31/0x3f
>>> [=C2=A0=C2=A0 88.053251]=C2=A0 kobject_init_and_add+0x35/0xa0
>>> [=C2=A0=C2=A0 88.054022]=C2=A0 ? rcu_read_lock_sched_held+0x3a/0x60
>>> [=C2=A0=C2=A0 88.054864]=C2=A0 ? trace_kmalloc+0x29/0xd0
>>> [=C2=A0=C2=A0 88.055537]=C2=A0 ? kmem_cache_alloc_trace+0x1ee/0x340
>>> [=C2=A0=C2=A0 88.056376]=C2=A0 btrfs_sysfs_add_qgroups+0x87/0x100
>>> [=C2=A0=C2=A0 88.057192]=C2=A0 btrfs_quota_enable+0xc6/0x830
>>> [=C2=A0=C2=A0 88.057930]=C2=A0 ? trace_kmalloc+0x29/0xd0
>>> [=C2=A0=C2=A0 88.058598]=C2=A0 ? __kmalloc_track_caller+0x20f/0x3b0
>>> [=C2=A0=C2=A0 88.059431]=C2=A0 ? btrfs_ioctl+0x251f/0x35c0
>>> [=C2=A0=C2=A0 88.060138]=C2=A0 btrfs_ioctl+0x2e06/0x35c0
>>> [=C2=A0=C2=A0 88.060818]=C2=A0 ? find_held_lock+0x2b/0x80
>>> [=C2=A0=C2=A0 88.061519]=C2=A0 ? lock_release+0x147/0x2f0
>>> [=C2=A0=C2=A0 88.062217]=C2=A0 ? __x64_sys_ioctl+0x7b/0xb0
>>> [=C2=A0=C2=A0 88.062919]=C2=A0 __x64_sys_ioctl+0x7b/0xb0
>>> [=C2=A0=C2=A0 88.063592]=C2=A0 do_syscall_64+0x35/0x80
>>> [=C2=A0=C2=A0 88.064245]=C2=A0 entry_SYSCALL_64_after_hwframe+0x63/0xc=
d
>>> [=C2=A0=C2=A0 88.065146] RIP: 0033:0x7f0240ada397
>>> [=C2=A0=C2=A0 88.065912] Code: 3c 1c e8 1c ff ff ff 85 c0 79 87 49 c7 =
c4 ff ff
>>> ff ff 5b 5d 4c 89 e8
>>> [=C2=A0=C2=A0 88.069908] RSP: 002b:00007fff156c90c8 EFLAGS: 00000202 O=
RIG_RAX:
>>> 0000000000000010
>>> [=C2=A0=C2=A0 88.071473] RAX: ffffffffffffffda RBX: 0000000000000000 R=
CX:
>>> 00007f0240ada397
>>> [=C2=A0=C2=A0 88.072988] RDX: 00007fff156c90e0 RSI: 00000000c0109428 R=
DI:
>>> 0000000000000003
>>> [=C2=A0=C2=A0 88.074391] RBP: 0000000000000003 R08: 000056165e61c2a0 R=
09:
>>> 00007f0240bb8c00
>>> [=C2=A0=C2=A0 88.075788] R10: fffffffffffff248 R11: 0000000000000202 R=
12:
>>> 00007fff156c9dfa
>>> [=C2=A0=C2=A0 88.077433] R13: 0000000000000001 R14: 000056165cc0008d R=
15:
>>> 00007fff156c9288
>>> [=C2=A0=C2=A0 88.079003]=C2=A0 </TASK>
>>> [=C2=A0=C2=A0 88.080327] general protection fault, probably for non-ca=
nonical
>>> address 0x1ad998badaI
>>> [=C2=A0=C2=A0 88.082664] CPU: 1 PID: 7250 Comm: btrfs Not tainted
>>> 6.0.0-rc2-block+ #2218
>>> [=C2=A0=C2=A0 88.083949] Hardware name: QEMU Standard PC (i440FX + PII=
X, 1996),
>>> BIOS 1.14.0-2 04/04
>>> [=C2=A0=C2=A0 88.085488] RIP: 0010:kfree+0x6e/0x550
>>> [=C2=A0=C2=A0 88.086159] Code: 01 d8 0f 82 dd 04 00 00 49 bc 00 00 00 =
80 7f 77
>>> 00 00 49 01 c4 48 b4
>>> [=C2=A0=C2=A0 88.089383] RSP: 0018:ffffc900036d7c58 EFLAGS: 00010203
>>> [=C2=A0=C2=A0 88.090304] RAX: ffffea0000000000 RBX: 6b6b6b6b6b6b6b6b R=
CX:
>>> 0000000000000001
>>> [=C2=A0=C2=A0 88.091550] RDX: 0000000000000000 RSI: ffffffff82fbd87b R=
DI:
>>> ffffffff830a6076
>>> [=C2=A0=C2=A0 88.092793] RBP: ffffc900036d7c90 R08: ffffffff83085f05 R=
09:
>>> 0000000000000001
>>> [=C2=A0=C2=A0 88.094042] R10: 0000000000000304 R11: ffffffff83a3b9e0 R=
12:
>>> 01ad998badadad80
>>> [=C2=A0=C2=A0 88.095345] R13: ffff888104755140 R14: ffff88810d375910 R=
15:
>>> ffff88810d3b4000
>>> [=C2=A0=C2=A0 88.096588] FS:=C2=A0 00007f02409e8d40(0000) GS:ffff88813=
bd00000(0000)
>>> knlGS:00000000000000
>>> [=C2=A0=C2=A0 88.098002] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000=
080050033
>>> [=C2=A0=C2=A0 88.099010] CR2: 000055f382527900 CR3: 000000010d1da000 C=
R4:
>>> 00000000000006e0
>>> [=C2=A0=C2=A0 88.100254] Call Trace:
>>> [=C2=A0=C2=A0 88.100699]=C2=A0 <TASK>
>>> [=C2=A0=C2=A0 88.101088]=C2=A0 kobject_set_name_vargs+0x6f/0x90
>>> [=C2=A0=C2=A0 88.101950]=C2=A0 kobject_init_and_add+0x5d/0xa0
>>> [=C2=A0=C2=A0 88.102697]=C2=A0 ? trace_kmalloc+0x29/0xd0
>>> [=C2=A0=C2=A0 88.103366]=C2=A0 ? kmem_cache_alloc_trace+0x1ee/0x340
>>> [=C2=A0=C2=A0 88.104256]=C2=A0 btrfs_sysfs_add_qgroups+0x87/0x100
>>> [=C2=A0=C2=A0 88.105340]=C2=A0 btrfs_quota_enable+0xc6/0x830
>>> [=C2=A0=C2=A0 88.106076]=C2=A0 ? trace_kmalloc+0x29/0xd0
>>> [=C2=A0=C2=A0 88.106748]=C2=A0 ? __kmalloc_track_caller+0x20f/0x3b0
>>> [=C2=A0=C2=A0 88.107584]=C2=A0 ? btrfs_ioctl+0x251f/0x35c0
>>> [=C2=A0=C2=A0 88.108282]=C2=A0 btrfs_ioctl+0x2e06/0x35c0
>>> [=C2=A0=C2=A0 88.108953]=C2=A0 ? find_held_lock+0x2b/0x80
>>> [=C2=A0=C2=A0 88.109654]=C2=A0 ? lock_release+0x147/0x2f0
>>> [=C2=A0=C2=A0 88.110340]=C2=A0 ? __x64_sys_ioctl+0x7b/0xb0
>>> [=C2=A0=C2=A0 88.111038]=C2=A0 __x64_sys_ioctl+0x7b/0xb0
>>> [=C2=A0=C2=A0 88.111724]=C2=A0 do_syscall_64+0x35/0x80
>>> [=C2=A0=C2=A0 88.112368]=C2=A0 entry_SYSCALL_64_after_hwframe+0x63/0xc=
d
>>> [=C2=A0=C2=A0 88.113263] RIP: 0033:0x7f0240ada397
>>> [=C2=A0=C2=A0 88.113913] Code: 3c 1c e8 1c ff ff ff 85 c0 79 87 49 c7 =
c4 ff ff
>>> ff ff 5b 5d 4c 89 e8
>>> [=C2=A0=C2=A0 88.117319] RSP: 002b:00007fff156c90c8 EFLAGS: 00000202 O=
RIG_RAX:
>>> 0000000000000010
>>> [=C2=A0=C2=A0 88.118657] RAX: ffffffffffffffda RBX: 0000000000000000 R=
CX:
>>> 00007f0240ada397
>>> [=C2=A0=C2=A0 88.119898] RDX: 00007fff156c90e0 RSI: 00000000c0109428 R=
DI:
>>> 0000000000000003
>>> [=C2=A0=C2=A0 88.121137] RBP: 0000000000000003 R08: 000056165e61c2a0 R=
09:
>>> 00007f0240bb8c00
>>> [=C2=A0=C2=A0 88.122404] R10: fffffffffffff248 R11: 0000000000000202 R=
12:
>>> 00007fff156c9dfa
>>> [=C2=A0=C2=A0 88.123648] R13: 0000000000000001 R14: 000056165cc0008d R=
15:
>>> 00007fff156c9288
>>> [=C2=A0=C2=A0 88.124895]=C2=A0 </TASK>
>>> [=C2=A0=C2=A0 88.125298] Modules linked in:
>>> [=C2=A0=C2=A0 88.126308] ---[ end trace 0000000000000000 ]---
>>>
>>>
>>>
>>>
>>>
>> ---end quoted text---
