Return-Path: <linux-btrfs+bounces-10928-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD3DA0AC90
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jan 2025 00:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B60165B60
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 Jan 2025 23:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C712D1C1F3B;
	Sun, 12 Jan 2025 23:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="mgW/pSGx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9E4155C97;
	Sun, 12 Jan 2025 23:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736723371; cv=none; b=bJj1smEcH8/bX9o1pH56ze+LZ2Qberqbc7APR0Utr1e0LiyPNDhsWHzMb19VMdDJcn9rb1gBvoR36m6b0dbIcNmd+OpQWvNuS38vqrpKDSsrYXtCEg66RW05tLGzNBJ2hTGcPaGlxZTZm24+dVNdGHJMGJXFwm7d4/70zGL3nzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736723371; c=relaxed/simple;
	bh=cqqUhhjebO21i/OPapa642TzmirAIyxxcqSsIMVkCt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QAq9+xWBwXrH/1hXnVid8c29L9TJwjAq2Z+LX1pS2RrQAM97IojaAfaFUEpQfRMClQImBW4dJVbSHoWjEd4C1Wgk+ZDrzHjouX2gEp5cRIIyFCuC/WfSHXWqL8Tvjrd9hBv38uF+oTE5OGeLXAPc8auizNkdPRYL2iWo+jvtpdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=mgW/pSGx; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1736723344; x=1737328144; i=quwenruo.btrfs@gmx.com;
	bh=C/WXLIMIS3+We0C1cWcgRqN60KW5s3Fs+KCt9c/Lxok=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mgW/pSGxqb9BdhItyKxgvOPL5D0E1HxVjUxjDMwlGKX8HDioD3I47kII5AbpKKrG
	 sYmb39zsqsOxzmHWdpIiqiv6KlzU5HSWjEzvFfa9pv5gUSoXFhRxDUkdmerTwrDli
	 32yjAbz7FY2nX6F/04dFpsollz8lHit/cnnnoncnypVqETqy25TP1nV6G0+R+uAqJ
	 ic43vGht3r9les7fdhU9l4w/DFnlEP5qCNhgwnQmN4RAkd8oHJMIBPjT28qaxg0qH
	 Xr+DR/s6NEa43l9T1aM0qxcQIJDg2o8aAGlrQpKCk4SQyDMD5cu4bczF488Kel7fc
	 1THGuMJB2eqK1FL2ag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MQe9s-1tsVqb0vpO-00RjmY; Mon, 13
 Jan 2025 00:09:04 +0100
Message-ID: <085e2f2d-a306-4a38-9943-1e306a8c11ea@gmx.com>
Date: Mon, 13 Jan 2025 09:38:56 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: Potential Deadlock or Resource Contention in Btrfs Subsystem
To: Kun Hu <huk23@m.fudan.edu.cn>, peterz@infradead.org, namhyung@kernel.org,
 mingo@kernel.org, jolsa@kernel.org, song@kernel.org, josef@toxicpanda.com,
 anand.jain@oracle.com, nborisov@suse.com, dsterba@suse.com
Cc: "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>,
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <AA0E5191-E4D8-4FAA-AB60-B38D6F2D0E99@m.fudan.edu.cn>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <AA0E5191-E4D8-4FAA-AB60-B38D6F2D0E99@m.fudan.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZNvZavULAPdMw3FimFyTygyLFnfQbHYVeiZH/Fv/Y/wXqUazygc
 LcR7rmFydqaJQiL4QvaBpwoSWxczrBQrWjitxvHN8fc9el/rPw2tYdqNSQQE0cBm22UuPCd
 QUBAOJJT+UcYRRq9wQAThI+oTY93fy1LpwdSxlLcBfXiYNhmrw2IFQyI05e6FB2myJbhCJj
 Tef2riFbZJgYmtstAJRHQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+0EBXsrrXsk=;9kNN6fjMlw4f15GdcEV/bxMcO1I
 lQoL6GFo3qZ3q31q3O/dEP02ssThPbaw8D5oq+12ad2ttXw9AxSMr4MLTBtpFoR61wLUBHP9p
 GVWpdHsGyEucB+pf5/st6BGQ1LQ9E6vFMJJDKP2xLWW1IBMc5cM9IMl3tzk/H2gSYoB5F7Pgu
 sFBdClNoMm6DYdlN9uvCNcuLW+xehoPIIFg0uddyjHoUAf58ncGuQdYKw/me1rit16+txQlv1
 f8qCU8ZwbLYPiVDTdpIlx9pe3raeQ24AZR5BtvH+EtAaoBAkKhBrctZRFy/SpssRmSXv04YaV
 xlBFunmj4e7YUzOYdm7gdyM9bVhu0hWE5fvgxVVowqlPgBHJAnpdkI9ygj94Q5ypM3tzh32kh
 /dmKTguZyCrNYbygXJBVHqDf6VwjMcPSnBluqz4UK85OOK2R+zEbKMhodVR2+jCyHMW+N837i
 /E2tCRHwsGPTWzBq7xp7UITidbC50+emXEQFH+/Dprr6+IbTWdAil8OnaSulknJ9MzCwbMdRz
 gHedWv1N51h/5kf2RNC74qtelgg2a+FySqaBdber2xeZ1Lyv/s/daUi/oilFwmaOwkyfoec3a
 0jnn1O9gFN3tl/ZW6+Wqb71avvXcp2XYPk393n2DLvG4Gq2tm5oUk9SWne9o6f0XbWhG1BsuC
 QEW3/8Mz7JYe3sv56OtHlyy3wdHW7e/WsuJF1Sw2lhH+7jA4Y5qD3OLxKqjpr65OeH09zUygh
 +nMsT88sobB7vQjztuz8ZeK2vp0k7EXFVMil/yPjTfY2q0jItc9mPL7vdUHFSR8TVrh847KN2
 TS4+2q2wvY/ymsXk89EmE2YfkuNZSs5l01e5xB1xYDmxYAAPZSX6aYzqjCQycml5xSGJqr6op
 JVOtGy+TsEOPcsVYbOAGIW2ElyK6CssmHf7LF0WsOTq+zivFQGXQxvtUCGU/tadwWd16wmxTF
 XlnTSEiGbO0b+X7quVoPEyJGuF6DKCmdTGKSaHWbyRIE3OJCCvY3DGueqJcUpvuRIJZRe4o0A
 ++pvjUhmMKaZjdT5KM+fkBXLBbAIwW5c4gju3l7CZuePPE7eVUo5UrAEjEwINYQpjki6DQepV
 9qFt9ApWUerNfMNnj7GqME8KBM8T4X



=E5=9C=A8 2025/1/12 19:47, Kun Hu =E5=86=99=E9=81=93:
> Hello,
>
> When using our customized fuzzer tool to fuzz the latest Linux kernel, t=
he following crash (41s)
> was triggered.
>
> HEAD commit: 9d89551994a430b50c4fffcb1e617a057fa76e20
> git tree: upstream
> Console output: https://drive.google.com/file/d/1pCyGTZTXMoUYn7NmKmAI4uz=
XrIXfl9K4/view?usp=3Dsharing
> Kernel config: https://drive.google.com/file/d/1w49JIxvyeFZT7bqCXvZjozqp=
oLYLUvJH/view?usp=3Dsharing
> C reproducer: https://drive.google.com/file/d/1gJjbndbNAJbwzGMiFr4ZGqF6V=
sOExkfD/view?usp=3Dsharing
> Syzlang reproducer: https://drive.google.com/file/d/1EndqkJNtUxhqf9SmF9t=
05I28UfU8Rhks/view?usp=3Dsharing
> New crash log: https://drive.google.com/file/d/12rKpMVQLb-FHx_wlDlelYS7S=
khbbiiqw/view?usp=3Dsharing
>
> We first found the issue without a stable C and Syzlang reproducers, but=
 later I tried multiple rounds of replication and got a new crash log (the=
 results seem to be different twice) as well as the C and Syzlang reproduc=
ers.
>
> I suspect the issue may stem from resource contention or synchronization=
 delays, as indicated by functions like queued_spin_lock_slowpath and sync=
hronize_rcu_expedited. There could also be inconsistencies in file system =
or device state management (btrfs_close_devices, loop_configure), or chall=
enges with concurrent resource allocation (copy_process, perf_prepare_samp=
le).
>
> Could you kindly help review these areas to narrow down the root cause? =
Your expertise would be greatly appreciated.

There is a recent report about btrfs' new mount API change lead to
mnt_list corruption:

https://lore.kernel.org/linux-btrfs/ec6784ed-8722-4695-980a-4400d4e7bd1a@g=
mx.com/

Which can be fixed by the latest VFS branch provided by Christian:
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs-6.14.mount

Considering the offending fc_mount() triggered by
btrfs_get_tree_subvol() is involved, mind to test if the above branch
fixes the bug?

Thanks,
Qu

>
> If you fix this issue, please add the following tag to the commit:
> Reported-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.e=
du.cn>
>
> watchdog: BUG: soft lockup - CPU#0 stuck for 26s! [syz.5.114:2341]
> Modules linked in:
> irq event stamp: 0
> hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> hardirqs last disabled at (0): [<ffffffff9c8ea334>] copy_process+0x1dc4/=
0x7550 kernel/fork.c:2339
> softirqs last  enabled at (0): [<ffffffff9c8ea381>] copy_process+0x1e11/=
0x7550 kernel/fork.c:2340
> softirqs last disabled at (0): [<0000000000000000>] 0x0
> CPU: 0 UID: 0 PID: 2341 Comm: syz.5.114 Tainted: G    B              6.1=
3.0-rc5 #1
> Tainted: [B]=3DBAD_PAGE
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubun=
tu1.1 04/01/2014
> RIP: 0010:kasan_mem_to_shadow include/linux/kasan.h:64 [inline]
> RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
> RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
> RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
> RIP: 0010:kasan_check_range+0x49/0x1b0 mm/kasan/generic.c:189
> Code: 00 0f 1f 44 00 00 48 b8 00 00 00 00 00 00 00 ff eb 0a 48 b8 00 00 =
00 00 00 80 ff ff 48 39 c7 0f 82 ad 00 00 00 4c 8d 5c 37 ff <48> 89 fb 48 =
b8 00 00 00 00 00 fc ff df 4d 89 da 48 c1 eb 03 49 c1
> RSP: 0018:ffa0000004567610 EFLAGS: 00000206
> RAX: ff00000000000000 RBX: ffffffffa72d3ac0 RCX: ffffffffa48fb188
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffffa72d3ac0
> RBP: ffa0000004567678 R08: fff3fc00008acee5 R09: fffffbfff4e5a759
> R10: fffffbfff4e5a758 R11: ffffffffa72d3ac3 R12: 0000000000000001
> R13: 0000000000000003 R14: fffffbfff4e5a758 R15: ff1100000163c810
> FS:  00007fd72f03c700(0000) GS:ff1100006a200000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f9e6b5806f4 CR3: 000000004122e001 CR4: 0000000000771ef0
> PKRU: 80000000
> Call Trace:
>   <IRQ>
>   </IRQ>
>   <TASK>
>   instrument_atomic_read include/linux/instrumented.h:68 [inline]
>   atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
>   virt_spin_lock arch/x86/include/asm/qspinlock.h:102 [inline]
>   queued_spin_lock_slowpath+0xb8/0xc60 kernel/locking/qspinlock.c:324
>   queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
>   do_raw_spin_lock+0x1de/0x290 kernel/locking/spinlock_debug.c:116
>   spin_lock include/linux/spinlock.h:351 [inline]
>   __kernfs_new_node+0xff/0x8c0 fs/kernfs/dir.c:629
>   kernfs_new_node+0x18b/0x250 fs/kernfs/dir.c:700
>   kernfs_create_dir_ns+0x4d/0x160 fs/kernfs/dir.c:1061
>   internal_create_group+0xadd/0x1000 fs/sysfs/group.c:170
>   loop_sysfs_init drivers/block/loop.c:762 [inline]
>   loop_configure+0x68e/0xf90 drivers/block/loop.c:1098
>   lo_ioctl+0xc47/0x1760 drivers/block/loop.c:1524
>   blkdev_ioctl+0x27e/0x6d0 block/ioctl.c:693
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:906 [inline]
>   __se_sys_ioctl fs/ioctl.c:892 [inline]
>   __x64_sys_ioctl+0x19e/0x210 fs/ioctl.c:892
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fd7303e832b
> Code: 0f 92 c0 84 c0 75 b0 49 8d 3c 1c e8 1f 3f 03 00 85 c0 78 b1 48 83 =
c4 08 4c 89 e0 5b 41 5c c3 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fd72f03b968 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fd7303e832b
> RDX: 0000000000000004 RSI: 0000000000004c00 RDI: 0000000000000005
> RBP: 0000000000000005 R08: 0000000000000000 R09: 00000000000046dc
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fd72f03ba0c R14: 00007fd72f03ba10 R15: 00000000200047c2
>   </TASK>
> Sending NMI from CPU 0 to CPUs 1-3:
> NMI backtrace for cpu 2
> CPU: 2 UID: 0 PID: 234 Comm: systemd-udevd Tainted: G    B              =
6.13.0-rc5 #1
> Tainted: [B]=3DBAD_PAGE
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubun=
tu1.1 04/01/2014
> RIP: 0010:virt_spin_lock arch/x86/include/asm/qspinlock.h:106 [inline]
> RIP: 0010:queued_spin_lock_slowpath+0x248/0xc60 kernel/locking/qspinlock=
.c:324
> Code: 14 02 48 89 d8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 bc 09 00 =
00 b8 01 00 00 00 66 89 03 e9 c1 fe ff ff 89 44 24 48 f3 90 <e9> 5e fe ff =
ff 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03
> RSP: 0018:ffa00000035e7660 EFLAGS: 00000202
> RAX: 0000000000000001 RBX: ffffffffa72d3ac0 RCX: ffffffffa48fb188
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffffa72d3ac0
> RBP: ffa00000035e76a8 R08: fff3fc00006bceeb R09: fffffbfff4e5a759
> R10: fffffbfff4e5a758 R11: ffffffffa72d3ac3 R12: 0000000000000001
> R13: 0000000000000003 R14: fffffbfff4e5a758 R15: 0000000000000001
> FS:  00007f52ff3348c0(0000) GS:ff1100006a300000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fd727c1b000 CR3: 0000000005cd4001 CR4: 0000000000771ef0
> PKRU: 55555554
> Call Trace:
>   <NMI>
>   </NMI>
>   <TASK>
>   queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
>   do_raw_spin_lock+0x1de/0x290 kernel/locking/spinlock_debug.c:116
>   spin_lock include/linux/spinlock.h:351 [inline]
>   kernfs_put fs/kernfs/dir.c:574 [inline]
>   kernfs_put+0x16d/0x3b0 fs/kernfs/dir.c:552
>   evict+0x403/0x880 fs/inode.c:796
>   iput_final fs/inode.c:1946 [inline]
>   iput fs/inode.c:1972 [inline]
>   iput+0x51c/0x830 fs/inode.c:1958
>   dentry_unlink_inode+0x2cd/0x4c0 fs/dcache.c:422
>   __dentry_kill+0x186/0x5b0 fs/dcache.c:625
>   dput.part.0+0x49e/0x990 fs/dcache.c:867
>   dput+0x1f/0x30 fs/dcache.c:857
>   lookup_fast+0x24b/0x520 fs/namei.c:1757
>   walk_component+0x5e/0x5b0 fs/namei.c:2108
>   lookup_last fs/namei.c:2610 [inline]
>   path_lookupat.isra.0+0x180/0x560 fs/namei.c:2634
>   do_o_path fs/namei.c:3958 [inline]
>   path_openat+0x1a97/0x2970 fs/namei.c:3980
>   do_filp_open+0x1fa/0x2f0 fs/namei.c:4014
>   do_sys_openat2+0x641/0x6e0 fs/open.c:1402
>   do_sys_open+0xc7/0x150 fs/open.c:1417
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f52ff7e0342
> Code: c0 f6 c2 40 75 52 89 d0 45 31 d2 25 00 00 41 00 3d 00 00 41 00 74 =
41 64 8b 04 25 18 00 00 00 85 c0 75 65 b8 01 01 00 00 0f 05 <48> 3d 00 f0 =
ff ff 0f 87 a2 00 00 00 48 8b 4c 24 38 64 48 2b 0c 25
> RSP: 002b:00007ffeb31bb980 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f52ff7e0342
> RDX: 00000000002a0000 RSI: 000055f5a5c490d1 RDI: 0000000000000011
> RBP: 000055f5a5c490d0 R08: 000055f59033f950 R09: 00007f52ff8c3be0
> R10: 0000000000000000 R11: 0000000000000246 R12: 000055f5a5bb47b5
> R13: 0000000000000011 R14: 0000000000000005 R15: 000055f5a5c490d1
>   </TASK>
> NMI backtrace for cpu 3
> CPU: 3 UID: 0 PID: 2338 Comm: syz.6.112 Tainted: G    B              6.1=
3.0-rc5 #1
> Tainted: [B]=3DBAD_PAGE
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubun=
tu1.1 04/01/2014
> RIP: 0010:virt_spin_lock arch/x86/include/asm/qspinlock.h:106 [inline]
> RIP: 0010:queued_spin_lock_slowpath+0x248/0xc60 kernel/locking/qspinlock=
.c:324
> Code: 14 02 48 89 d8 83 e0 07 83 c0 01 38 d0 7c 08 84 d2 0f 85 bc 09 00 =
00 b8 01 00 00 00 66 89 03 e9 c1 fe ff ff 89 44 24 48 f3 90 <e9> 5e fe ff =
ff 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03
> RSP: 0018:ffa0000003827630 EFLAGS: 00000202
> RAX: 0000000000000001 RBX: ffffffffa72d3ac0 RCX: ffffffffa48fb188
> RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffffa72d3ac0
> RBP: ffa0000003827678 R08: fff3fc0000704ee5 R09: fffffbfff4e5a759
> R10: fffffbfff4e5a758 R11: ffffffffa72d3ac3 R12: 0000000000000001
> R13: 0000000000000003 R14: fffffbfff4e5a758 R15: ff1100000163c810
> FS:  00007f562eb2c700(0000) GS:ff1100006a380000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f562770b000 CR3: 0000000021918005 CR4: 0000000000771ef0
> PKRU: 80000000
> Call Trace:
>   <NMI>
>   </NMI>
>   <TASK>
>   queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
>   do_raw_spin_lock+0x1de/0x290 kernel/locking/spinlock_debug.c:116
>   spin_lock include/linux/spinlock.h:351 [inline]
>   __kernfs_new_node+0xff/0x8c0 fs/kernfs/dir.c:629
>   kernfs_new_node+0x18b/0x250 fs/kernfs/dir.c:700
>   kernfs_create_dir_ns+0x4d/0x160 fs/kernfs/dir.c:1061
>   internal_create_group+0xadd/0x1000 fs/sysfs/group.c:170
>   loop_sysfs_init drivers/block/loop.c:762 [inline]
>   loop_configure+0x68e/0xf90 drivers/block/loop.c:1098
>   lo_ioctl+0xc47/0x1760 drivers/block/loop.c:1524
>   blkdev_ioctl+0x27e/0x6d0 block/ioctl.c:693
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:906 [inline]
>   __se_sys_ioctl fs/ioctl.c:892 [inline]
>   __x64_sys_ioctl+0x19e/0x210 fs/ioctl.c:892
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f562fef932b
> Code: 0f 92 c0 84 c0 75 b0 49 8d 3c 1c e8 1f 3f 03 00 85 c0 78 b1 48 83 =
c4 08 4c 89 e0 5b 41 5c c3 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f562eb2b968 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f562fef932b
> RDX: 0000000000000005 RSI: 0000000000004c00 RDI: 0000000000000006
> RBP: 0000000000000006 R08: 0000000000000000 R09: 0000000000005d98
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f562eb2ba0c R14: 00007f562eb2ba10 R15: 0000000020011842
>   </TASK>
> NMI backtrace for cpu 1
> CPU: 1 UID: 0 PID: 2322 Comm: syz.3.108 Tainted: G    B              6.1=
3.0-rc5 #1
> Tainted: [B]=3DBAD_PAGE
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubun=
tu1.1 04/01/2014
> RIP: 0010:apic_mem_wait_icr_idle arch/x86/kernel/apic/ipi.c:130 [inline]
> RIP: 0010:__default_send_IPI_shortcut+0x13/0x40 arch/x86/kernel/apic/ipi=
.c:163
> Code: 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 =
90 53 89 fb 83 fe 02 75 04 eb 1d f3 90 8b 04 25 00 c3 5f ff <f6> c4 10 75 =
f2 09 de 89 34 25 00 c3 5f ff 5b e9 b4 94 33 08 e8 74
> RSP: 0018:ffa00000001e8850 EFLAGS: 00000002
> RAX: 00000000000400f6 RBX: 0000000000040000 RCX: ffffffff9c74659c
> RDX: 0000000000000001 RSI: 00000000000000f6 RDI: 0000000000040000
> RBP: 0000000000000001 R08: 0000000000000000 R09: fff3fc000003d100
> R10: fff3fc000003d0ff R11: ffa00000001e87ff R12: 0000000000000001
> R13: ff1100006a2bd270 R14: ff1100006a2bd468 R15: ffa00000001e8918
> FS:  00007f5d89ee7700(0000) GS:ff1100006a280000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 0000000008f1e005 CR4: 0000000000771ef0
> PKRU: 80000000
> Call Trace:
>   <NMI>
>   </NMI>
>   <IRQ>
>   __apic_send_IPI_self arch/x86/include/asm/apic.h:455 [inline]
>   arch_irq_work_raise+0x4f/0x70 arch/x86/kernel/irq_work.c:31
>   irq_work_raise kernel/irq_work.c:84 [inline]
>   __irq_work_queue_local kernel/irq_work.c:112 [inline]
>   __irq_work_queue_local+0x14c/0x450 kernel/irq_work.c:88
>   irq_work_queue_on+0x156/0x170 kernel/irq_work.c:175
>   rcu_read_unlock_special kernel/rcu/tree_plugin.h:686 [inline]
>   __rcu_read_unlock+0x440/0x570 kernel/rcu/tree_plugin.h:437
>   rcu_read_unlock include/linux/rcupdate.h:882 [inline]
>   __perf_event_output kernel/events/core.c:8091 [inline]
>   perf_event_output_forward+0x16a/0x2c0 kernel/events/core.c:8100
>   __perf_event_overflow+0x1e4/0x8f0 kernel/events/core.c:9926
>   perf_swevent_overflow+0xac/0x150 kernel/events/core.c:10001
>   perf_swevent_event+0x1e9/0x2e0 kernel/events/core.c:10034
>   perf_tp_event+0x227/0xfe0 kernel/events/core.c:10535
>   perf_trace_run_bpf_submit+0xef/0x180 kernel/events/core.c:10471
>   do_perf_trace_preemptirq_template include/trace/events/preemptirq.h:14=
 [inline]
>   perf_trace_preemptirq_template+0x287/0x450 include/trace/events/preemp=
tirq.h:14
>   trace_irq_enable include/trace/events/preemptirq.h:40 [inline]
>   trace_hardirqs_on+0xf2/0x160 kernel/trace/trace_preemptirq.c:73
>   irqentry_exit+0x3b/0x90 kernel/entry/common.c:357
>   asm_sysvec_irq_work+0x1a/0x20 arch/x86/include/asm/idtentry.h:738
> RIP: 0010:handle_softirqs+0x185/0x870 kernel/softirq.c:549
> Code: 00 00 48 89 44 24 20 48 c7 c7 40 39 c7 a4 e8 82 23 fc 07 65 66 c7 =
05 20 c0 72 63 00 00 e8 83 c3 40 00 fb 48 c7 c3 c0 b0 e0 a6 <e9> 8f 00 00 =
00 48 b9 00 00 00 00 00 fc ff df 48 89 d8 48 c1 e8 03
> RSP: 0018:ffa00000001e8f78 EFLAGS: 00000246
> RAX: 0000000000000007 RBX: ffffffffa6e0b0c0 RCX: 1ffffffff51f7c86
> RDX: 0000000000000000 RSI: 0000000000000103 RDI: ffffffff9c90f18d
> RBP: ffa0000004656d48 R08: 0000000000000000 R09: 0000000000000000
> R10: fffffbfff51f7aba R11: ffffffffa8fbd5d7 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000200
>   __do_softirq kernel/softirq.c:595 [inline]
>   invoke_softirq kernel/softirq.c:435 [inline]
>   __irq_exit_rcu kernel/softirq.c:662 [inline]
>   irq_exit_rcu+0xee/0x140 kernel/softirq.c:678
>   instr_sysvec_call_function_single arch/x86/kernel/smp.c:266 [inline]
>   sysvec_call_function_single+0xca/0xf0 arch/x86/kernel/smp.c:266
>   </IRQ>
>   <TASK>
>   asm_sysvec_call_function_single+0x1a/0x20 arch/x86/include/asm/idtentr=
y.h:709
> RIP: 0010:get_current arch/x86/include/asm/current.h:49 [inline]
> RIP: 0010:__rcu_read_unlock+0xc6/0x570 kernel/rcu/tree_plugin.h:440
> Code: b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 0f b6 04 02 84 c0 =
74 08 3c 03 0f 8e bf 01 00 00 8b 85 00 04 00 00 85 c0 75 57 <65> 48 8b 1d =
b2 ae 52 63 48 8d bb fc 03 00 00 48 b8 00 00 00 00 00
> RSP: 0018:ffa0000004656df8 EFLAGS: 00000206
> RAX: 0000000000000046 RBX: ff1100006a2bd240 RCX: 1ffffffff51f7c86
> RDX: 0000000000000000 RSI: 0000000000000003 RDI: ffffffff9cb10432
> RBP: ffffffffa7126380 R08: 0000000000000000 R09: 0000000000000000
> R10: fffffbfff51f7aba R11: ffffffffa8fbd5d7 R12: 0000000000000001
> R13: 0000000000000200 R14: ffffffffa7194b00 R15: 0000000000000000
>   rcu_read_unlock include/linux/rcupdate.h:882 [inline]
>   __is_insn_slot_addr+0x140/0x290 kernel/kprobes.c:305
>   is_kprobe_insn_slot include/linux/kprobes.h:332 [inline]
>   kernel_text_address kernel/extable.c:123 [inline]
>   kernel_text_address+0x5b/0xc0 kernel/extable.c:94
>   __kernel_text_address+0xd/0x40 kernel/extable.c:79
>   unwind_get_return_address arch/x86/kernel/unwind_orc.c:369 [inline]
>   unwind_get_return_address+0x62/0xb0 arch/x86/kernel/unwind_orc.c:364
>   arch_stack_walk+0x9d/0xf0 arch/x86/kernel/stacktrace.c:26
>   stack_trace_save+0x8f/0xc0 kernel/stacktrace.c:122
>   kasan_save_stack+0x24/0x50 mm/kasan/common.c:47
>   kasan_save_track+0x14/0x30 mm/kasan/common.c:68
>   unpoison_slab_object mm/kasan/common.c:319 [inline]
>   __kasan_slab_alloc+0x87/0x90 mm/kasan/common.c:345
>   kasan_slab_alloc include/linux/kasan.h:250 [inline]
>   slab_post_alloc_hook mm/slub.c:4119 [inline]
>   slab_alloc_node mm/slub.c:4168 [inline]
>   kmem_cache_alloc_noprof+0x154/0x420 mm/slub.c:4175
>   radix_tree_node_alloc.constprop.0+0x1e8/0x350 lib/radix-tree.c:253
>   idr_get_free+0x569/0xac0 lib/radix-tree.c:1506
>   idr_alloc_u32+0x174/0x2d0 lib/idr.c:46
>   idr_alloc_cyclic+0x106/0x230 lib/idr.c:125
>   __kernfs_new_node+0x117/0x8c0 fs/kernfs/dir.c:630
>   kernfs_new_node+0x18b/0x250 fs/kernfs/dir.c:700
>   __kernfs_create_file+0x55/0x360 fs/kernfs/file.c:1034
>   sysfs_add_file_mode_ns+0x21c/0x440 fs/sysfs/file.c:313
>   sysfs_create_file_ns+0x12f/0x1d0 fs/sysfs/file.c:380
>   sysfs_create_file include/linux/sysfs.h:788 [inline]
>   sysfs_create_files+0x6e/0x1c0 fs/sysfs/file.c:390
>   btrfs_sysfs_add_mounted+0x1f1/0x480 fs/btrfs/sysfs.c:2170
>   open_ctree+0x24d6/0x5190 fs/btrfs/disk-io.c:3471
>   btrfs_fill_super fs/btrfs/super.c:972 [inline]
>   btrfs_get_tree_super fs/btrfs/super.c:1898 [inline]
>   btrfs_get_tree+0x101a/0x1c40 fs/btrfs/super.c:2093
>   vfs_get_tree+0x93/0x340 fs/super.c:1814
>   fc_mount+0x17/0xd0 fs/namespace.c:1231
>   btrfs_get_tree_subvol fs/btrfs/super.c:2051 [inline]
>   btrfs_get_tree+0xa1b/0x1c40 fs/btrfs/super.c:2094
>   vfs_get_tree+0x93/0x340 fs/super.c:1814
>   do_new_mount fs/namespace.c:3507 [inline]
>   path_mount+0x1287/0x1d60 fs/namespace.c:3834
>   do_mount+0xf8/0x110 fs/namespace.c:3847
>   __do_sys_mount fs/namespace.c:4057 [inline]
>   __se_sys_mount fs/namespace.c:4034 [inline]
>   __x64_sys_mount+0x193/0x230 fs/namespace.c:4034
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f5d8b29615e
> Code: ff ff ff 64 c7 00 16 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 =
00 00 00 00 66 90 f3 0f 1e fa 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f5d89ee69b8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 000000000000559d RCX: 00007f5d8b29615e
> RDX: 00000000200055c0 RSI: 0000000020005600 RDI: 00007f5d89ee6a10
> RBP: 00007f5d89ee6a50 R08: 00007f5d89ee6a50 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000206 R12: 00000000200055c0
> R13: 0000000020005600 R14: 00007f5d89ee6a10 R15: 0000000020000440
>   </TASK>
>
>
>
> ---------------
> thanks,
> Kun Hu


