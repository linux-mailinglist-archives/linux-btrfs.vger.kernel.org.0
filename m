Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACE6629624
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 11:42:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbiKOKmQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 05:42:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiKOKmP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 05:42:15 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41011BCAB;
        Tue, 15 Nov 2022 02:42:12 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvK4f-1pCHkX2gfx-00rKHW; Tue, 15
 Nov 2022 11:42:01 +0100
Message-ID: <08a18fd6-3ce8-a063-90cf-e659004d0894@gmx.com>
Date:   Tue, 15 Nov 2022 18:41:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: WARNING in _btrfs_ioctl_set_received_subvol
Content-Language: en-US
To:     Wei Chen <harperchen1110@gmail.com>, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        osandov@fb.com, sweettea-kernel@dorminy.me,
        syzkaller-bugs@googlegroups.com
References: <CAO4mrfdLsMZT1ytmTCK4m0xXezxskTUbQjqZoGobMVhnZgdfmw@mail.gmail.com>
 <CAO4mrfcYtXiuuaPtm==heNarkMqTUGoKWxnmiOC3jvhfjeOBFg@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <CAO4mrfcYtXiuuaPtm==heNarkMqTUGoKWxnmiOC3jvhfjeOBFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:TUwBr+dYsbfQGGpvbC7xm3ZbDMUOc/5i9II5GMGJIQT2PmB3UVG
 1uSgymMszwNQBHzwtVJ+vtLkOrxCLwmVz8KQfPJNn9P8TtemamEOruXd1ISXkmbZ2HXZQUL
 Tuk63OvdJoJR2I/Eb1eZ2CSvwHtDbNwSRfZNaajesm8wsmtgJqCA/aR9nCaKlLdw83HUSMg
 Z7cPMPoqvUB1HkzwHm9GA==
UI-OutboundReport: notjunk:1;M01:P0:jLQfyklhry0=;cmYkNsuvif6sq+XhsyWE6zXM2at
 kBXNcUdjOhgeODP6QdeoBw92LTuQ8mOqORq4B8T+p4n4dOU8YfvcmETOguSlSbrJSPC6yAAjv
 kkkp08fFHw2UCkVHlmuvSksPt+rA4NTzoWCelwr0bMRcGa5qXQ2jl+SwiNKrEYMGbQGVaf1AJ
 rLNLI7PQpKDvVHLOl2orWkPJDmpdytYRl9tNDY88wDo/FQNDbwXjJB9/pC6JhmMpn2uBBNO/G
 zL0feD5eJknm4RG5Hko5SriJbs7U6p+vZw98au4p74lzAG63qWWDlpVKzDgiUBTj9fZb9n52Y
 ddmcQ6PUOGuGOjsqqnAxKd8+uXRr9SQQMpzYp0/bvrMed0MfoSaVbwJx7I/z+4HS71D190DW9
 P9e6a3Btg6vcIrRn52rI5kAa9NR2SvVFbsioIzSHelyzm3OXMTai1fWON6be+ZRK1FAh0Snbp
 VYi65UOTpzETi8vXiul/Pf+1WMmBNM/1ulYyLReZ/5toQt8rJd9y4rHW0UIXKCmXSba7M7a5o
 EZfmWTCZui3pUfZUV9haGPL6dVoBE4+k+XU7sNhsh1qhxYVCX5WiGCNlVJl89CJjQaM3N/9N1
 seNypXZx5SXFoXKqez+40Fzhhdyw370UJGqkak7BcKfQFUSMZNIIeJR2E2utVMnp/1DwpPqLj
 gXYxnZS2hdKcEeHGWYp5MKQOotI6cjbBRjHrEdDmBw+4mr4j32ZUKZWQJzqUM/0Ey4anZTIw7
 hBFlEDBkoQ3QqAEU9tCs9DoRrCw1IUq+Ij/IDQfcpi6P+e5EbADjJDT54TlbbRrn/lGBK3O0Q
 DGoZnM8iLFBUzCi79aPUti3WwirEGUM6nPZIGWsDAs1hTPTte9g2lsg7615oG7AV3oY0PakEe
 4x4cxUdkUXkVkIlsPEhZl1vcqkquRcq47MzWYlIqLQ9ZmLf3GIvUqnjY1Yp3jPByUw9wGB13/
 2Vr4zEnsU1ukSnOkHJzs4UU0VJQrZlUlrGjGxID6Kofgktzuckv8kYENgC9xvZOW+eN6Og==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/15 18:30, Wei Chen wrote:
> Dear Linux developers,
> 
> I hope the following bug report is helpful.
> 
> Best,
> Wei
> 
> On Sun, 13 Nov 2022 at 19:38, Wei Chen <harperchen1110@gmail.com> wrote:
>>
>> Dear Linux Developer,
>>
>> Recently when using our tool to fuzz kernel, the following crash was
>> triggered. The bug persists in Linux 6.0.
>>
>> HEAD commit:  4f5365f77018  Linux 5.15.76

Not related to the bug itself, but more on the report.

I'd say, if the bug persists in the latest release, then please use the 
latest kernel in the report.
Not use the latest LTS as the commit.

You know most (if not all) linux communities are working on upstream 
code, not some LTS branch.

Thanks,
Qu

>> git tree: stable
>> compiler: gcc 7.5.0
>> console output:
>> https://drive.google.com/file/d/1wkzu8jz6edriSP6TpsCGYD5AzkLajIEv/view?usp=share_link
>> kernel config: https://drive.google.com/file/d/1flhc33savDkmYN6PRU5C2vXDX0LAKMvM/view?usp=share_link
>> C reproducer: https://drive.google.com/file/d/1zKWsWAOcaHfPKewTG6P3pnnVfwH_WXa9/view?usp=share_link
>> Syz reproducer:
>> https://drive.google.com/file/d/1jUR8_6Re4xpJhyLdXqPiiV72WT-Tk8A-/view?usp=share_link
>>
>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>> Reported-by: Wei Chen <harperchen1110@gmail.com>
>>
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000007
>> R13: 0000000000000000 R14: 000000000077bf80 R15: 00007ffd3c817900
>>   </TASK>
>> ------------[ cut here ]------------
>> WARNING: CPU: 1 PID: 29222 at fs/btrfs/ioctl.c:4521
>> _btrfs_ioctl_set_received_subvol+0x221/0x430 fs/btrfs/ioctl.c:4521
>> Modules linked in:
>> CPU: 1 PID: 29222 Comm: syz-executor.0 Not tainted 5.15.76 #5
>> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
>> rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
>> RIP: 0010:_btrfs_ioctl_set_received_subvol+0x221/0x430 fs/btrfs/ioctl.c:4521
>> Code: e8 74 34 44 ff 83 fb fb 0f 84 de 01 00 00 83 fb e2 0f 84 d5 01
>> 00 00 e8 5d 34 44 ff 89 de 48 c7 c7 c0 f8 39 85 e8 9f dc 2e ff <0f> 0b
>> e8 48 34 44 ff 89 d9 ba a9 11 00 00 e9 45 01 00 00 49 8b 4f
>> RSP: 0018:ffffc9000aecfd40 EFLAGS: 00010286
>> RAX: 0000000000000000 RBX: fffffffffffffff4 RCX: ffffc900013ed000
>> RDX: 0000000000040000 RSI: ffffffff812d935c RDI: 00000000ffffffff
>> RBP: ffffc9000aecfda0 R08: 0000000000000000 R09: 0000000000000001
>> R10: ffffc9000aecfbe0 R11: 0000000000000003 R12: ffff888014210400
>> R13: ffff8880208d2000 R14: ffff88810c4f21c0 R15: ffff88810f37b600
>> FS:  00007f41ffc27700(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> CR2: 00007fab915f7008 CR3: 000000002096e000 CR4: 00000000003526e0
>> Call Trace:
>>   <TASK>
>>   btrfs_ioctl_set_received_subvol_32 fs/btrfs/ioctl.c:4584 [inline]
>>   btrfs_ioctl+0x2154/0x3d50 fs/btrfs/ioctl.c:5007
>>   vfs_ioctl fs/ioctl.c:51 [inline]
>>   __do_sys_ioctl fs/ioctl.c:874 [inline]
>>   __se_sys_ioctl fs/ioctl.c:860 [inline]
>>   __x64_sys_ioctl+0xb6/0x100 fs/ioctl.c:860
>>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>   do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
>>   entry_SYSCALL_64_after_hwframe+0x61/0xcb
>> RIP: 0033:0x4697f9
>> Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
>> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
>> 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
>> RSP: 002b:00007f41ffc26c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>> RAX: ffffffffffffffda RBX: 000000000077bf80 RCX: 00000000004697f9
>> RDX: 0000000020072c40 RSI: 00000000c0c09425 RDI: 0000000000000005
>> RBP: 00007f41ffc26c80 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000007
>> R13: 0000000000000000 R14: 000000000077bf80 R15: 00007ffd3c817900
>>   </TASK>
>>
>> Best,
>> Wei
