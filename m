Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF4C3813DF
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 May 2021 00:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbhENWrC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 May 2021 18:47:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:56389 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230371AbhENWrB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 May 2021 18:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1621032346;
        bh=qXq3LCy7jgLeZvXRz6LfJi+T0y+iQA07QvBFXmD5JFs=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=a1bwWzq9efCgId8iom3DuVq0hHzPo6PWLj3rPL1KX1sLE+/Piel3H4tcoosrf2FLy
         bzibZ8cLq4ifaMW32uDUsz6H9M5aFx3bO1JDkmIlRQhmU95m6CpV+S0hCYq4SE7GGR
         3zuqwzg9taO2dUBV/mMe91ethWzt+PO/TxO4D8wg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MzyuS-1lJoLv3aDu-00x6rL; Sat, 15
 May 2021 00:45:46 +0200
Subject: Re: [Patch v2 00/42] btrfs: add data write support for subpage
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210427230349.369603-1-wqu@suse.com>
 <20210512221821.GB7604@twin.jikos.cz>
 <de2c2a25-a8da-4d69-819e-847c4721b3f4@gmx.com>
 <36e94393-d6cf-cc3d-d710-79c517de4ecc@gmx.com>
 <20210514113040.GV7604@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <b2490ac7-7bb8-238c-1602-043bfcb09c8f@gmx.com>
Date:   Sat, 15 May 2021 06:45:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210514113040.GV7604@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2fszomX0tmJhpZK2wd1NbRlGsyz7HyjJ3iWTuNGbRE2HJBEhA0m
 eiEmjhfhCOWE3rKNXe1RqSXjtC9QJeHxrah0u7GeVagRglwTrS7b2cZkWRlrZXHc7u+v8eT
 eq4kZnqQfdTgM1a2BiQ/lL78+mgbBIXWyDanA8DkJSMXhQilYLYtPI+LEe+BAir0krqyjBu
 cm9fXvSjBbIOg7igN3lgw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:D0O2cYUpnAU=:4s+vJighuEMepp2RdGPtkG
 c2qj7xvyf1gwlwev3017hRxZesbdw4NVmpD3WnsqqPUzizk6S6i9afNt8ME4DR18dy4a6Ezkp
 v1pRT064RIQjk5ZefOoZXaI2gcjlA8fdgY0JXOX4dzJuHrc3LSXHXWxg0ALX28qmdvzr5Cgmg
 U6OT1PC6d2C9ViwqDVUb1kHUWGC22JYdDfDMwm40+BM9jCQmZ8zd27Z0a6elm4qCPEYMwjXC6
 PnTzW+RKq3XhjSFdtoTeHpTwWWzl8bvxcT+s202rfJ/IeijjsD+MuF/1+Ju/7vz7OKfoRh3X+
 jAldmr3RchB+lvAns9/Su0/HJA+gT6z2o8qixdsoYwvrAexVIq5LZGB7l2lkgNK4v//sglTvo
 TGOw48gFYEehW1qVwFtwgU75ZHOz0wdk/TTSQ9ekvD7BlKXryXcAvyzu4HFvbfxC4ZIrFlyW0
 ki7u4inA0SRVOm36/ZoF5B+1wS45KWtlaAKy8nPJcWZjCUspsCn9NUpjsG/lIq0ph6J6ppq8l
 HWxH0Fa3bKJDULeIgFf1aTm7z7l6SRO2NSgZJLqMLx/zfI1aRZzf4nwvbPAQAZldxHuAiEnNP
 sotWU3tXc5Oma6CtR4JAYzKp2CBBjHrtjk3eWFrhVdXaaTGaTcGQ8Icx6xlrBjYyyuPYfrqF2
 mLhNOVKFc0GG7N+gCmR4tpyD2TWGiXa+QK2OahFyWyYuKyUaOiZ+lADVB6FVAjZG9wzR3wmwC
 uzejUkSUV8s5oMp9SC//4eMnL8VsUTODnBd7yfGO7v9IwAHlYdCODnhUpIYW38fNX238lsGPX
 y7XZZ5ApjHJeUI8sfLYvPyMQ1i6fX8eLIrqh1G2ZNtxxwpDlm2zeDTdGY9sf/+kObHvjI6cKd
 n7YGG2XgEmlBecSsbE6M+bxw7aHQXAisE7KxyfiWjAOl9XmCmZs0JyU80d7Zn7hfihJV4I8wA
 TALhn5QevTwWL9lMS+2hqBmGNvWtYQWSW7UV162WU1PJZMJUHMvJ9p5dweOjec0BGF+ZgHqJ1
 RKPAvGJZ7qZMoANg0+S87jNfv0/ss//7SQvJkjkfcI6E2MKwjxxXk9TaRvGCy36A8/z5sVBam
 9BxwDT+iF3mAwGDxEbs0a0ViKfqMq0H8Orx84EwRa9Ul4mTeawWkO9JLicDj3m4HwcmtQK/n/
 PipR0Y0TZt8ZQrKF2JqMAFY7ckKb+Q/DFAChU3+1ZwYH3Dt3lii7pvWihxUHxqnMLA2Ezo80F
 IqfHSmnGY3MkssRD1
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/5/14 =E4=B8=8B=E5=8D=887:30, David Sterba wrote:
> On Thu, May 13, 2021 at 10:21:24AM +0800, Qu Wenruo wrote:
>>> On 2021/5/13 =E4=B8=8A=E5=8D=886:18, David Sterba wrote:
>>>> On Wed, Apr 28, 2021 at 07:03:07AM +0800, Qu Wenruo wrote:
>>>>> =3D=3D=3D Patchset structure =3D=3D=3D
>>>>>
>>>>> Patch 01~02:=C2=A0=C2=A0=C2=A0 hardcoded PAGE_SIZE related fixes
>>>>> Patch 03~05:=C2=A0=C2=A0=C2=A0 submit_extent_page() refactor which w=
ill reduce overhead
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for write path.
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This should benefit 4K p=
age the most. Although the
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 primary objective is jus=
t to make the code easier to
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 read.
>>>>> Patch 06:=C2=A0=C2=A0=C2=A0 Cleanup for metadata writepath, to reduc=
e the impact on
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regular sectorsize path.
>>>>> Patch 07~13:=C2=A0=C2=A0=C2=A0 PagePrivate2 and ordered extent relat=
ed refactor.
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Although it's still a re=
factor, the refactor is pretty
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 important for subpage da=
ta write path, as for subpage we
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 could have btrfs_writepa=
ge_endio_finish_ordered() call
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 across several sectors, =
which may or may not have
>>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ordered extent for those=
 sectors.
>>>>>
>>>>> ^^^ Above patches are all subpage data write preparation ^^^
>>>>
>>>> Do you think the patches 1-13 are safe to be merged independently? I'=
ve
>>>> paged through the whole patchset and some of the patches are obviousl=
y
>>>> preparatory stuff so they can go in without much risk.
>>>
>>> Yes. I believe they are OK for merge.
>>>
>>> I have run the full tests on x86 VM for the whole patchset, no new
>>> regression.
>>>
>>> Especially patch 03~05 would benefit 4K page size the most, thus mergi=
ng
>>> them first would definitely help.
>>>
>>> Just let me to run the tests with patch 1~13 only, to see if there is
>>> any special dependency missing.
>>
>> Yep, patch 1~13 with the v5 read time repair patches are safe for x86.
>
> All fine up to generic/521 that got stuck. It looks like some use after
> free, check the 2nd line of the dump, there's the 0x6b6b signature
>
> generic/521		[00:33:06][26901.358817] run fstests generic/521 at 2021-05=
-14 00:33:06
> [27273.028163] general protection fault, probably for non-canonical addr=
ess 0x6b6b6b6b6b6b6a9b: 0000 [#1] PREEMPT SMP
> [27273.030710] CPU: 0 PID: 20046 Comm: fsx Not tainted 5.13.0-rc1-defaul=
t+ #1463
> [27273.032295] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
> [27273.034731] RIP: 0010:btrfs_lookup_first_ordered_range+0x46/0x140 [bt=
rfs]

It's in the new function introduced, and considering how few parameteres
are passed in, I guess it's really something wrong in the function,
other than some conflicts with other patches.

Any line number for it?

Thanks,
Qu

> [27273.040247] RSP: 0018:ffffb7ac06617b10 EFLAGS: 00010002
> [27273.041365] RAX: 6b6b6b6b6b6b6b6b RBX: 6b6b6b6b6b6b6b6b RCX: ffffffff=
ffffffff
> [27273.042841] RDX: 6b6b6b6b6b6b6b6b RSI: ffffffffc01b3e09 RDI: ffff93c4=
44e397d0
> [27273.044388] RBP: 0000000000001000 R08: 0000000000000001 R09: 00000000=
00000000
> [27273.045938] R10: ffffffffc01b3e09 R11: 0000000000000000 R12: 00000000=
0002f000
> [27273.047409] R13: ffff93c48ae79368 R14: ffff93c444e397b8 R15: 00000000=
0002f000
> [27273.048959] FS:  00007fb0f0a5e740(0000) GS:ffff93c4bd600000(0000) knl=
GS:0000000000000000
> [27273.050674] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [27273.051971] CR2: 00007fb0f0936000 CR3: 0000000028bf4001 CR4: 00000000=
00170eb0
> [27273.053548] Call Trace:
> [27273.054145]  btrfs_invalidatepage+0xd3/0x390 [btrfs]
> [27273.055276]  truncate_cleanup_page+0xda/0x170
> [27273.056243]  truncate_inode_pages_range+0x131/0x5a0
> [27273.057334]  ? trace_btrfs_space_reservation+0x33/0xf0 [btrfs]
> [27273.058642]  ? lock_acquire+0xa0/0x150
> [27273.059506]  ? unmap_mapping_pages+0x4d/0x130
> [27273.060491]  ? do_raw_spin_unlock+0x4b/0xa0
> [27273.061477]  ? unmap_mapping_pages+0x5e/0x130
> [27273.062482]  btrfs_punch_hole_lock_range+0xc5/0x130 [btrfs]
> [27273.063738]  btrfs_zero_range+0x1d7/0x4b0 [btrfs]
> [27273.064833]  btrfs_fallocate+0x6b4/0x890 [btrfs]
> [27273.065921]  ? __x64_sys_fallocate+0x3e/0x70
> [27273.066920]  ? __do_sys_newfstatat+0x40/0x70
> [27273.067875]  vfs_fallocate+0x12e/0x420
> [27273.068738]  __x64_sys_fallocate+0x3e/0x70
> [27273.069684]  do_syscall_64+0x3f/0xb0
> [27273.070539]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [27273.071641] RIP: 0033:0x7fb0f0b5716a
> [27273.076352] RSP: 002b:00007fff6503e0c8 EFLAGS: 00000246 ORIG_RAX: 000=
000000000011d
> [27273.078019] RAX: ffffffffffffffda RBX: 0000000000007909 RCX: 00007fb0=
f0b5716a
> [27273.079522] RDX: 000000000002956d RSI: 0000000000000010 RDI: 00000000=
00000003
> [27273.081020] RBP: 000000000002956d R08: 0000000000007909 R09: 00000000=
0002956d
> [27273.082542] R10: 0000000000007909 R11: 0000000000000246 R12: 00000000=
00000000
> [27273.083984] R13: 0000000000030e76 R14: 0000000000000010 R15: 00000000=
0002956d
> [27273.090924] ---[ end trace f729bc2baa232124 ]---
> [27273.092000] RIP: 0010:btrfs_lookup_first_ordered_range+0x46/0x140 [bt=
rfs]
> [27273.097206] RSP: 0018:ffffb7ac06617b10 EFLAGS: 00010002
> [27273.098338] RAX: 6b6b6b6b6b6b6b6b RBX: 6b6b6b6b6b6b6b6b RCX: ffffffff=
ffffffff
> [27273.099843] RDX: 6b6b6b6b6b6b6b6b RSI: ffffffffc01b3e09 RDI: ffff93c4=
44e397d0
> [27273.101302] RBP: 0000000000001000 R08: 0000000000000001 R09: 00000000=
00000000
> [27273.102827] R10: ffffffffc01b3e09 R11: 0000000000000000 R12: 00000000=
0002f000
> [27273.104328] R13: ffff93c48ae79368 R14: ffff93c444e397b8 R15: 00000000=
0002f000
> [27273.105786] FS:  00007fb0f0a5e740(0000) GS:ffff93c4bd600000(0000) knl=
GS:0000000000000000
> [27273.107478] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [27273.108672] CR2: 00007fb0f0936000 CR3: 0000000028bf4001 CR4: 00000000=
00170eb0
> [27273.110157] note: fsx[20046] exited with preempt_count 1
> [27273.111323] BUG: sleeping function called from invalid context at inc=
lude/linux/percpu-rwsem.h:49
> [27273.113204] in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 20=
046, name: fsx
> [27273.114784] INFO: lockdep is turned off.
> [27273.115614] irq event stamp: 0
> [27273.116355] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [27273.117657] hardirqs last disabled at (0): [<ffffffff9c0675a3>] copy_=
process+0x3f3/0x1550
> [27273.119308] softirqs last  enabled at (0): [<ffffffff9c0675a3>] copy_=
process+0x3f3/0x1550
> [27273.129243] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [27273.130557] CPU: 0 PID: 20046 Comm: fsx Tainted: G      D           5=
.13.0-rc1-default+ #1463
> [27273.132460] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BI=
OS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
> [27273.135049] Call Trace:
> [27273.135710]  dump_stack+0x6d/0x89
> [27273.136549]  ___might_sleep.cold+0xf2/0x132
> [27273.137575]  exit_signals+0x1d/0x350
> [27273.138451]  do_exit+0xa6/0x4a0
> [27273.139238]  rewind_stack_do_exit+0x17/0x17
> [27273.140270] RIP: 0033:0x7fb0f0b5716a
> [27273.144797] RSP: 002b:00007fff6503e0c8 EFLAGS: 00000246 ORIG_RAX: 000=
000000000011d
> [27273.146353] RAX: ffffffffffffffda RBX: 0000000000007909 RCX: 00007fb0=
f0b5716a
> [27273.147736] RDX: 000000000002956d RSI: 0000000000000010 RDI: 00000000=
00000003
> [27273.149157] RBP: 000000000002956d R08: 0000000000007909 R09: 00000000=
0002956d
> [27273.150620] R10: 0000000000007909 R11: 0000000000000246 R12: 00000000=
00000000
> [27273.152094] R13: 0000000000030e76 R14: 0000000000000010 R15: 00000000=
0002956d
>
