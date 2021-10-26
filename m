Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D45E43B225
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Oct 2021 14:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbhJZMUQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 26 Oct 2021 08:20:16 -0400
Received: from mout.gmx.net ([212.227.15.19]:53379 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233816AbhJZMUP (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 26 Oct 2021 08:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635250670;
        bh=wscQiHWl9/PkYhDe2rNQlKq6tH19tmXj+QEQljhm/3Q=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=YDR2jSKM3FhBWTcX3wySrtgrDZlVVdvehwsR6Tp2tHqH4a91b1i40t1vg6+hfCkdp
         OxE6rCCLCWsY927iuO95qZuEAzqlkXauWxSUYaHrtskM66Qs5XQQ/Uig6WXiEozRcy
         OYfxTkjFbOx6T2YMsG7O24DDv76mW6/ysjwK3InY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MPog5-1mIR4A3K4Z-00MpeX; Tue, 26
 Oct 2021 14:17:50 +0200
Message-ID: <673ad5bf-fde0-24b6-41db-01b6cf0f00e1@gmx.com>
Date:   Tue, 26 Oct 2021 20:17:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: Errors after successful disk replace
Content-Language: en-US
To:     Emil Heimpel <broetchenrackete@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
References: <ed4a7a10-d5a4-4b62-8e67-0b971487a74a@gmail.com>
 <47f76535-12c3-996e-3306-0bf0f4eed57e@gmx.com>
 <297b21db-4a67-469d-9ae1-54b1043dac31@gmail.com>
 <28511d75-f76b-f587-3474-554e8bf2aa22@gmx.com>
 <64e5b8aa-bc49-4596-b4ff-8cc780a6513d@gmail.com>
 <5d8df74b-6094-de7d-1b47-885126cf4bc6@gmx.com>
 <0e218606-5e07-4d7d-b81f-519895af2dfa@gmail.com>
 <c237d0ab-c223-eeb9-ce3f-21a27b8b88a8@gmx.com>
 <f6ab2cd3-54a6-4f78-97eb-47f912d3694b@gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <f6ab2cd3-54a6-4f78-97eb-47f912d3694b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QgX2rSuzQqgO5tpil6BsfnVfWikgrgfK1iyCrZQgKESBX/qgLQv
 xLhxaLV44PGuJ4F0yfpwvMotwD4mfhl2M823OrCUzvOLNZhS5Fo8ZPzmgnlWZJ2A4p0Afxk
 /mEk4mahd696hWvrGr6U5HjRvEegJ0I/zFBIBRn7RMQzdq8MdmBKjb0yG3izY7fu17UjPgy
 SOIRbGDRd2/t0jqRw0RLg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QRpVU+LlCOg=:9fKHHrpJIfGvAUcbQquhbO
 nNSLfLm6zgQ/3C30jvQHM0YaisljAx/wuSqpadjWs6DPPZGnquLOG81zmcfD7XatGrZ6bdBgb
 93cwCi3RSJfv9ZHve4EMxhi2ingAkZbEmi0O6Obl/pa7PZJ8KHIoHwQYBgr1mY2AFHU1K1zE2
 H4oZwBVRHd5FZKmNgB/l5rChnV82M4MFASlGY3Yj/hr53RSleXgzbMtmhU7gr7iK6dP+ngtfu
 WlepQW8/dzlc0Ha5yZcbvedEzssrWCWBYIlVMMmDy4cHAzMx2Yh0Ee60zC2oJr1Lbsy964EeF
 59F3cupYpyHraY22SMQDFCHewUnzExGVzWcuYkJwUXK7G3tU4ZF4vu0kT/U0ZWTqSa5Y/DzHN
 lRzmaHCY0Q5SnqREGPhMN8YE39d92SFK/ngL5tBazhdCD1zF5iGW5jz1OB31me3dhEIR0ZGXh
 Eh4GZf8etXOfBUlqIRq+n8NJqb19kCy5qOmafH044h42DAH6webIexJCpuAUQd2fxw8v/FGZo
 YVJRa0+iyDEt4YLE2uK7FQTjM7ASxPlSJZUeVmEVSa6zu7nml4azUyapO0XK0LvZtLvWvOWdy
 CKEWxG0KIjVcQ6WQ/cVROdI7PsYb8nBLKcLxBDERAs39wSATurfnKmdym0IrLYpNbywlRBkGl
 WVX0LAaeVfOGXd5MJzJH8tv8oVLGeKTk22VS1ZHWME96SUWeUlBrwpQ9U8p2fNyHJj9V22qrZ
 2AjRtjSZL5PkW8JIivANBuK8xVrXcw8mICqJ37NKOy2cpiP9gAyZAFlKLHsiSYhDydHu5UtND
 Y1e/J2AACUfSv3Y6AImsH09SPpafVp9FbeRpnjjX/IJjRslkaWXUqvNiCOxjHMlQu87dF8bKP
 LrpjFbFnRClzA4U65mkdZVd4LN2f71y+l0w+I+No671V5/UIdj1DqRXrsoUM7kmtS2utq+Cm+
 3DI0vSjohEu05C1XqyKkhNE7knAkTuucKESqibIqLeFJ5GChSvdORxKMFtytaNzsGj7La8/eT
 jY9cnvUPlbBtqWsGlt0deSb+hy9ofQvKc2LbL05+IDvVeugg1/x+sLm3c4JaaZLBMelDFhjgv
 kD9g2zDLK7z8Ic=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/10/26 20:16, Emil Heimpel wrote:
> After reapplying the thermal paste and adding a fan to my storage contro=
ller (LSI SAS2008) I haven't encountered any abnormal behavior of my drive=
s. Scrub is running (disk by disk) and everything looks fine so far.
>
> I only got one task blocked message in dmesg, is that anything I should =
worry about?

Sometimes we can also hit such blocked message for certain test cases.

As long as the fs is still submitting IO, and you find proper CPU usage,
it should be fine.

Thanks,
Qu
>
>
> Sun Oct 24 18:22:11 2021] BTRFS info (device sdg1): scrub: started on de=
vid 5
> [Mon Oct 25 15:31:23 2021] BTRFS info (device sdg1): scrub: finished on =
devid 5 with status: 0
> [Mon Oct 25 15:31:26 2021] BTRFS info (device sdg1): scrub: started on d=
evid 3
> [Mon Oct 25 21:12:34 2021] perf: interrupt took too long (2501 > 2500), =
lowering kernel.perf_event_max_sample_rate to 79800
> [Mon Oct 25 23:01:43 2021] hrtimer: interrupt took 13811 ns
> [Tue Oct 26 02:58:17 2021] BTRFS info (device sdg1): scrub: finished on =
devid 3 with status: 0
> [Tue Oct 26 02:58:21 2021] BTRFS info (device sdg1): scrub: started on d=
evid 6
> [Tue Oct 26 12:23:36 2021] INFO: task btrfs:341674 blocked for more than=
 122 seconds.
> [Tue Oct 26 12:23:36 2021]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Tainted: =
G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OE=C2=A0=C2=
=A0=C2=A0=C2=A0 5.14.14-arch1-1 #1
> [Tue Oct 26 12:23:36 2021] "echo 0 > /proc/sys/kernel/hung_task_timeout_=
secs" disables this message.
> [Tue Oct 26 12:23:36 2021] task:btrfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 state:D stack:=C2=A0=C2=A0=C2=A0 0 pid:341674 =
ppid:341658 flags:0x00004000
> [Tue Oct 26 12:23:36 2021] Call Trace:
> [Tue Oct 26 12:23:36 2021]=C2=A0 __schedule+0x333/0x1530
> [Tue Oct 26 12:23:36 2021]=C2=A0 ? psi_task_switch+0xc2/0x1f0
> [Tue Oct 26 12:23:36 2021]=C2=A0 ? autoremove_wake_function+0x2c/0x50
> [Tue Oct 26 12:23:36 2021]=C2=A0 schedule+0x59/0xc0
> [Tue Oct 26 12:23:36 2021]=C2=A0 __scrub_blocked_if_needed+0xa0/0xf0 [bt=
rfs 796168a0fefcfb1a0bc1ff664fee7292a977f032]
> [Tue Oct 26 12:23:36 2021]=C2=A0 ? do_wait_intr_irq+0xa0/0xa0
> [Tue Oct 26 12:23:36 2021]=C2=A0 scrub_pause_off+0x21/0x50 [btrfs 796168=
a0fefcfb1a0bc1ff664fee7292a977f032]
> [Tue Oct 26 12:23:36 2021]=C2=A0 scrub_stripe+0x452/0x1580 [btrfs 796168=
a0fefcfb1a0bc1ff664fee7292a977f032]
> [Tue Oct 26 12:23:36 2021]=C2=A0 ? do_wait_intr_irq+0xa0/0xa0
> [Tue Oct 26 12:23:36 2021]=C2=A0 ? __btrfs_end_transaction+0xf6/0x210 [b=
trfs 796168a0fefcfb1a0bc1ff664fee7292a977f032]
> [Tue Oct 26 12:23:36 2021]=C2=A0 ? scrub_chunk+0xcd/0x130 [btrfs 796168a=
0fefcfb1a0bc1ff664fee7292a977f032]
> [Tue Oct 26 12:23:36 2021]=C2=A0 scrub_chunk+0xcd/0x130 [btrfs 796168a0f=
efcfb1a0bc1ff664fee7292a977f032]
> [Tue Oct 26 12:23:36 2021]=C2=A0 scrub_enumerate_chunks+0x354/0x790 [btr=
fs 796168a0fefcfb1a0bc1ff664fee7292a977f032]
> [Tue Oct 26 12:23:36 2021]=C2=A0 ? do_wait_intr_irq+0xa0/0xa0
> [Tue Oct 26 12:23:36 2021]=C2=A0 btrfs_scrub_dev+0x23d/0x570 [btrfs 7961=
68a0fefcfb1a0bc1ff664fee7292a977f032]
> [Tue Oct 26 12:23:36 2021]=C2=A0 btrfs_ioctl+0x1410/0x2df0 [btrfs 796168=
a0fefcfb1a0bc1ff664fee7292a977f032]
> [Tue Oct 26 12:23:36 2021]=C2=A0 ? __x64_sys_ioctl+0x82/0xb0
> [Tue Oct 26 12:23:36 2021]=C2=A0 __x64_sys_ioctl+0x82/0xb0
> [Tue Oct 26 12:23:36 2021]=C2=A0 do_syscall_64+0x5c/0x80
> [Tue Oct 26 12:23:36 2021]=C2=A0 ? create_task_io_context+0xc7/0x110
> [Tue Oct 26 12:23:36 2021]=C2=A0 ? get_task_io_context+0x48/0x80
> [Tue Oct 26 12:23:36 2021]=C2=A0 ? set_task_ioprio+0x97/0xa0
> [Tue Oct 26 12:23:36 2021]=C2=A0 ? __do_sys_ioprio_set+0x5e/0x300
> [Tue Oct 26 12:23:36 2021]=C2=A0 ? syscall_exit_to_user_mode+0x23/0x40
> [Tue Oct 26 12:23:36 2021]=C2=A0 ? syscall_exit_to_user_mode+0x23/0x40
> [Tue Oct 26 12:23:36 2021]=C2=A0 ? do_syscall_64+0x69/0x80
> [Tue Oct 26 12:23:36 2021]=C2=A0 ? exit_to_user_mode_prepare+0x77/0x170
> [Tue Oct 26 12:23:36 2021]=C2=A0 entry_SYSCALL_64_after_hwframe+0x44/0xa=
e
> [Tue Oct 26 12:23:36 2021] RIP: 0033:0x7fba22e2559b
> [Tue Oct 26 12:23:36 2021] RSP: 002b:00007fba22cf7c98 EFLAGS: 00000246 O=
RIG_RAX: 0000000000000010
> [Tue Oct 26 12:23:36 2021] RAX: ffffffffffffffda RBX: 000056511ecc6bc0 R=
CX: 00007fba22e2559b
> [Tue Oct 26 12:23:36 2021] RDX: 000056511ecc6bc0 RSI: 00000000c400941b R=
DI: 0000000000000003
> [Tue Oct 26 12:23:36 2021] RBP: 0000000000000000 R08: 00007fba22cf8640 R=
09: 0000000000000000
> [Tue Oct 26 12:23:36 2021] R10: 00007fba22cf8640 R11: 0000000000000246 R=
12: 00007ffec33d061e
> [Tue Oct 26 12:23:36 2021] R13: 00007ffec33d061f R14: 0000000000000000 R=
15: 00007fba22cf8640
> [Tue Oct 26 12:27:42 2021] INFO: task btrfs:341674 blocked for more than=
 122 seconds.
> [Tue Oct 26 12:27:42 2021]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Tainted: =
G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OE=C2=A0=C2=
=A0=C2=A0=C2=A0 5.14.14-arch1-1 #1
> [Tue Oct 26 12:27:42 2021] "echo 0 > /proc/sys/kernel/hung_task_timeout_=
secs" disables this message.
> [Tue Oct 26 12:27:42 2021] task:btrfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 state:D stack:=C2=A0=C2=A0=C2=A0 0 pid:341674 =
ppid:341658 flags:0x00004000
> [Tue Oct 26 12:27:42 2021] Call Trace:
> [Tue Oct 26 12:27:42 2021]=C2=A0 __schedule+0x333/0x1530
> [Tue Oct 26 12:27:42 2021]=C2=A0 ? autoremove_wake_function+0x2c/0x50
> [Tue Oct 26 12:27:42 2021]=C2=A0 schedule+0x59/0xc0
> [Tue Oct 26 12:27:42 2021]=C2=A0 __scrub_blocked_if_needed+0xa0/0xf0 [bt=
rfs 796168a0fefcfb1a0bc1ff664fee7292a977f032]
> [Tue Oct 26 12:27:42 2021]=C2=A0 ? do_wait_intr_irq+0xa0/0xa0
> [Tue Oct 26 12:27:42 2021]=C2=A0 scrub_pause_off+0x21/0x50 [btrfs 796168=
a0fefcfb1a0bc1ff664fee7292a977f032]
> [Tue Oct 26 12:27:42 2021]=C2=A0 scrub_stripe+0x452/0x1580 [btrfs 796168=
a0fefcfb1a0bc1ff664fee7292a977f032]
> [Tue Oct 26 12:27:42 2021]=C2=A0 ? __update_load_avg_cfs_rq+0x27d/0x2e0
> [Tue Oct 26 12:27:42 2021]=C2=A0 ? __btrfs_end_transaction+0xf6/0x210 [b=
trfs 796168a0fefcfb1a0bc1ff664fee7292a977f032]
> [Tue Oct 26 12:27:42 2021]=C2=A0 ? kmem_cache_free+0x107/0x410
> [Tue Oct 26 12:27:42 2021]=C2=A0 ? scrub_chunk+0xcd/0x130 [btrfs 796168a=
0fefcfb1a0bc1ff664fee7292a977f032]
> [Tue Oct 26 12:27:42 2021]=C2=A0 scrub_chunk+0xcd/0x130 [btrfs 796168a0f=
efcfb1a0bc1ff664fee7292a977f032]
> [Tue Oct 26 12:27:42 2021]=C2=A0 scrub_enumerate_chunks+0x354/0x790 [btr=
fs 796168a0fefcfb1a0bc1ff664fee7292a977f032]
> [Tue Oct 26 12:27:42 2021]=C2=A0 ? do_wait_intr_irq+0xa0/0xa0
> [Tue Oct 26 12:27:42 2021]=C2=A0 btrfs_scrub_dev+0x23d/0x570 [btrfs 7961=
68a0fefcfb1a0bc1ff664fee7292a977f032]
> [Tue Oct 26 12:27:42 2021]=C2=A0 btrfs_ioctl+0x1410/0x2df0 [btrfs 796168=
a0fefcfb1a0bc1ff664fee7292a977f032]
> [Tue Oct 26 12:27:42 2021]=C2=A0 ? __x64_sys_ioctl+0x82/0xb0
> [Tue Oct 26 12:27:42 2021]=C2=A0 __x64_sys_ioctl+0x82/0xb0
> [Tue Oct 26 12:27:42 2021]=C2=A0 do_syscall_64+0x5c/0x80
> [Tue Oct 26 12:27:42 2021]=C2=A0 ? create_task_io_context+0xc7/0x110
> [Tue Oct 26 12:27:42 2021]=C2=A0 ? get_task_io_context+0x48/0x80
> [Tue Oct 26 12:27:42 2021]=C2=A0 ? set_task_ioprio+0x97/0xa0
> [Tue Oct 26 12:27:42 2021]=C2=A0 ? __do_sys_ioprio_set+0x5e/0x300
> [Tue Oct 26 12:27:42 2021]=C2=A0 ? syscall_exit_to_user_mode+0x23/0x40
> [Tue Oct 26 12:27:42 2021]=C2=A0 ? syscall_exit_to_user_mode+0x23/0x40
> [Tue Oct 26 12:27:42 2021]=C2=A0 ? do_syscall_64+0x69/0x80
> [Tue Oct 26 12:27:42 2021]=C2=A0 ? exit_to_user_mode_prepare+0x77/0x170
> [Tue Oct 26 12:27:42 2021]=C2=A0 entry_SYSCALL_64_after_hwframe+0x44/0xa=
e
> [Tue Oct 26 12:27:42 2021] RIP: 0033:0x7fba22e2559b
> [Tue Oct 26 12:27:42 2021] RSP: 002b:00007fba22cf7c98 EFLAGS: 00000246 O=
RIG_RAX: 0000000000000010
> [Tue Oct 26 12:27:42 2021] RAX: ffffffffffffffda RBX: 000056511ecc6bc0 R=
CX: 00007fba22e2559b
> [Tue Oct 26 12:27:42 2021] RDX: 000056511ecc6bc0 RSI: 00000000c400941b R=
DI: 0000000000000003
> [Tue Oct 26 12:27:42 2021] RBP: 0000000000000000 R08: 00007fba22cf8640 R=
09: 0000000000000000
> [Tue Oct 26 12:27:42 2021] R10: 00007fba22cf8640 R11: 0000000000000246 R=
12: 00007ffec33d061e
> [Tue Oct 26 12:27:42 2021] R13: 00007ffec33d061f R14: 0000000000000000 R=
15: 00007fba22cf8640
>
> Thanks,
> Emil
>
> Oct 19, 2021 14:46:46 Qu Wenruo <quwenruo.btrfs@gmx.com>:
>
>>
>>
>> On 2021/10/19 20:38, Emil Heimpel wrote:
>>> So it finished after 2 minutes?
>>>
>>> [Tue Oct 19 14:13:51 2021] BTRFS info (device sde1): continuing dev_re=
place from <missing disk> (devid 1) to target /dev/sde1 @74%
>>> [Tue Oct 19 14:15:39 2021] BTRFS info (device sde1): dev_replace from =
<missing disk> (devid 1) to /dev/sde1 finished
>>
>> Then this means it previously only have the dev replace status not
>> cleaned up.
>>
>> Thus it ends pretty quick.
>>>
>>>
>>> Now I at least have an expected filesystem show:
>>>
>>> Label: 'BlueButter'=C2=A0 uuid: 7e3378e6-da46-4a60-b9b8-1bcc306986e3
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Total devices 6 FS bytes u=
sed 20.96TiB
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 1 =
size 7.28TiB used 5.46TiB path /dev/sde1
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 2 =
size 7.28TiB used 5.46TiB path /dev/sdb1
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 3 =
size 2.73TiB used 2.73TiB path /dev/sdg1
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 4 =
size 2.73TiB used 2.73TiB path /dev/sdd1
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 5 =
size 7.28TiB used 4.81TiB path /dev/sdf1
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 devid=C2=A0=C2=A0=C2=A0 6 =
size 7.28TiB used 5.33TiB path /dev/sdc1
>>>
>>> And a nondegraded remount worked too.
>>
>> And it's time for a full fs scrub to find out how consistent the fs is.
>>
>> For btrfs RAID56, every time a unexpected shutdown is hit, a scrub is
>> strongly recommended.
>>
>> And even routine scrub would be a plus for btrfs RAID56.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Thanks,
>>> Emil
>>>
>>> Oct 19, 2021 14:20:21 Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>>
>>>>
>>>>
>>>> On 2021/10/19 20:16, Emil Heimpel wrote:
>>>>> Color me suprised:
>>>>>
>>>>>
>>>>> [74713.072745] BTRFS info (device sde1): flagging fs with big metada=
ta feature
>>>>> [74713.072755] BTRFS info (device sde1): allowing degraded mounts
>>>>> [74713.072758] BTRFS info (device sde1): using free space tree
>>>>> [74713.072760] BTRFS info (device sde1): has skinny extents
>>>>> [74713.104297] BTRFS warning (device sde1): devid 1 uuid 51645efd-bf=
95-458d-b5ae-b31623533abb is missing
>>>>> [74714.675001] BTRFS info (device sde1): bdev (efault) errs: wr 5295=
0, rd 8161, flush 0, corrupt 1221, gen 0
>>>>> [74714.675015] BTRFS info (device sde1): bdev /dev/sdb1 errs: wr 0, =
rd 0, flush 0, corrupt 228, gen 0
>>>>> [74714.675025] BTRFS info (device sde1): bdev /dev/sdc1 errs: wr 0, =
rd 0, flush 0, corrupt 140, gen 0
>>>>> [74751.033383] BTRFS info (device sde1): continuing dev_replace from=
 <missing disk> (devid 1) to target /dev/sde1 @74%
>>>>> [bluemond@BlueQ ~]$ sudo btrfs replace status=C2=A0 -1 /mnt/btrfsrep=
air/
>>>>> 74.9% done, 0 write errs, 0 uncorr. read errs
>>>>>
>>>>> I guess I just wait?
>>>>
>>>> Yep, wait and stay alert, better to also keep an eye on the dmesg.
>>>>
>>>> But this also means, previous replace didn't really finish, which may
>>>> mean the replace ioctl is not reporting the proper status, and can be=
 a
>>>> possible bug.
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> Oct 19, 2021 13:37:09 Qu Wenruo <quwenruo.btrfs@gmx.com>:
>>>>>
>>>>>>
>>>>>>
>>>>>> On 2021/10/19 18:49, Emil Heimpel wrote:
>>>>>>> =E2=80=A6
>>>>>>
>>>>>> *failed*...
>>>>>>
>>>>>>> =E2=80=A6
>>>>>>
>>>>>> And ATA commands failure.
>>>>>>
>>>>>> I don't believe the replace finished without problem, and the invol=
ved
>>>>>> device is /dev/sdd.
>>>>>>
>>>>>>> =E2=80=A6
>>>>>>
>>>>>> You won't want to see this message at all.
>>>>>>
>>>>>> This means, you're running RAID56, as btrfs has write-hole problem,
>>>>>> which will degrade the robust of RAID56 byte by byte for each uncle=
an
>>>>>> shutdown.
>>>>>>
>>>>>> I guess the write hole problem has already make the repair failed f=
or
>>>>>> the replace.
>>>>>>
>>>>>> Thus after a successful mount, scrub and manually file checking is
>>>>>> almost a must.
>>>>>>
>>>>>>> =E2=80=A6
>>>>>>
>>>>>> This doesn't sound correct.
>>>>>>
>>>>>> If a device is properly replaced, it should have the same devid num=
ber.
>>>>>>
>>>>>> I guess you have tried to add a new device before, and then tried t=
o
>>>>>> replace the missing device, right?
>>>>>>
>>>>>>
>>>>>> Anyway, have you tried to mount it degraded and then remove the mis=
sing
>>>>>> device?
>>>>>>
>>>>>> Since you're using RAID56, I guess degrade mount should work.
>>>>>>
>>>>>> Thanks,
>>>>>> Qu
>>>>>>
>>>>>>> =E2=80=A6
