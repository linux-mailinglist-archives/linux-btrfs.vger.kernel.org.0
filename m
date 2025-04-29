Return-Path: <linux-btrfs+bounces-13481-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0073DAA01B1
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 07:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6124E1A88866
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 05:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACB4224234;
	Tue, 29 Apr 2025 05:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="MxveIJV/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4825986338
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Apr 2025 05:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745903934; cv=none; b=fl1Ebh96ipHXA0AXJ9/P9/5LF+WjEd9QSSm8Bhe4hsVXR8o8hQapMVp4x3pHZvRs+p+YyqrZR7NHdrhUcr3BeKn/1Arnrt00ga0kAr4pgN3YwYZU5Ugt+p/eqIkBQQzQ9Fd/Prd4m8ulUgLvwYnv9I2Fi414YCNdiWzWpWYxkXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745903934; c=relaxed/simple;
	bh=T0GvvpOAQYzjv+BDzktOKT101RDBbfr3Ikd5OEFKBGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HkrhQCEIi3vFf026UVrVFFg/9mf7rGXIP7fATc2wTmuKBIknYjxerQqK9Sj+b865Fpu86Gmz/IW97mv/1hXw6n/kaluRccj66Z+O7GluDK1THY6f/SPGerBZnwgz8kQ2YiqD70KwIsJg6S/GjLabgjcJ6CKMGVTpi9xKfErS/JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=MxveIJV/; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1745903923; x=1746508723; i=quwenruo.btrfs@gmx.com;
	bh=+Du0iQeDv05tYZF3Z9irL8+y6D+e2LpTZGFoK9+dEqc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MxveIJV/uyKlFrj3oFZ8EYn64JKAZYtXQuYiBt7QgvfYsmxPCslbCdyIeU0JDbVe
	 iMBsrYNbMAcQ4brFITH/iGXFfodWachPYSY6jKkD3KmxwO2kO2h87rRz2QF2EQCo4
	 giMmE+TCYtzHKC8/EO6aTVeDoFWlFaezXOo+kTtFZFU7dylgGCaT1Y58XYYy8/JMY
	 MfbsblezC5WDdUAg0Jv9Ml0PvbqPTHm14Aom1qyr8/btISy1/+yAQep7c7QqajxnA
	 NlSmzcqHAGHkCOqCBjnl+ZUCalN8nhdczeZ48s+s0nNyi+gdPWiVS9CQ6SdbymO0o
	 vb745aY21UUixZgNMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWigq-1uXksb3aCO-00U4uQ; Tue, 29
 Apr 2025 07:18:42 +0200
Message-ID: <809b26c7-03f3-4a21-848f-aed8759dc396@gmx.com>
Date: Tue, 29 Apr 2025 14:48:32 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: kernel BUG in write_dev_supers in linux6.15-rc1
To: Jianzhou Zhao <luckd0g@163.com>, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org
References: <2ba8e841.23c2.1967f561791.Coremail.luckd0g@163.com>
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
In-Reply-To: <2ba8e841.23c2.1967f561791.Coremail.luckd0g@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x0DhOvhjApX72CZZgI6jj+H8FoysZf2i9PsJn4WGa1tSIkgjirD
 YeLA+AY4cpOmS8digfuFRXTBi89tzjZQhgyeq9JxMOqsDxVLqJbpIyFEzmRFnAWfAuOpIhm
 RSOpkAIKPWDTK8UrBSjNQx+6rdIKKDTpch5x7WCQstDxH28LrcS82IjIEr2jgbgW1E2oDly
 5GeV0wVZAmRYeb8eNv8Pw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S7nsJLN92sM=;eTJN5jEIVfc0XYl9zmD3eveK200
 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
 DQErXNJQNOCPM98gNr9FZY=



=E5=9C=A8 2025/4/29 11:47, Jianzhou Zhao =E5=86=99=E9=81=93:
> Hello, I found a potential bug titled "  kernel BUG in write_dev_supers =
 " with modified syzkaller in the  Linux6.15-rc1.
> If you fix this issue, please add the following tag to the commit:  Repo=
rted-by: Jianzhou Zhao <luckd0g@163.com>,    xingwei lee <xrivendell7@gmai=
l.com>
> The commit of the kernel is : 0af2f6be1b4281385b618cb86ad946eded089ac8
> kernel config: https://syzkaller.appspot.com/text?tag=3DKernelConfig&x=
=3D4c918722cb7e3d7
> compiler: gcc version 11.4.0

Already fixed by upstream commit 65f2a3b2323e ("btrfs: remove folio=20
order ASSERT()s in super block writeback path").

>=20
> Unfortunately, we failed to generate the reproduction program of this bu=
g.
>=20
> ------------[ cut here ]-----------------------------------------
>   TITLE:   kernel BUG in write_dev_supers
> ------------[ cut here ]------------
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> assertion failed: folio_order(folio) =3D=3D 0, in fs/btrfs/disk-io.c:385=
6
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/disk-io.c:3856!
> Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 9462 Comm: syz-executor Not tainted 6.15.0-rc1-dirty =
#9 PREEMPT(full)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/=
01/2014
> RIP: 0010:write_dev_supers+0x7f0/0x910 fs/btrfs/disk-io.c:3856
> Code: e9 03 ff ff ff e8 70 a3 eb fd b9 10 0f 00 00 48 c7 c2 60 c0 d9 8b =
48 c7 c6 60 c7 d9 8b 48 c7 c7 e0 c0 d9 8b e8 41 d4 ca fd 90 <0f> 0b 48 8b =
7c 24 38 e8 04 f9 51 fe e9 3d f9 ff ff e8 3a f8 51 fe
> RSP: 0018:ffffc900053ff7c0 EFLAGS: 00010286
> RAX: 0000000000000045 RBX: ffff888029e60000 RCX: ffffffff819a5929
> RDX: 0000000000000000 RSI: ffff88801eb9bc80 RDI: 0000000000000002
> RBP: ffffea0001560a00 R08: fffffbfff1c4bb00 R09: fffff52000a7feb1
> R10: fffff52000a7feb0 R11: ffffc900053ff587 R12: dffffc0000000000
> R13: 0000000000000000 R14: 0000000000000002 R15: 0000000001000000
> FS:  000055556e3c5500(0000) GS:ffff888097b41000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f8af4976080 CR3: 0000000076248000 CR4: 0000000000752ef0
> PKRU: 80000000
> Call Trace:
>   <TASK>
>   write_all_supers+0x921/0x3680 fs/btrfs/disk-io.c:4153
>   btrfs_commit_transaction+0x2dad/0x4620 fs/btrfs/transaction.c:2541
>   btrfs_sync_fs+0x130/0x760 fs/btrfs/super.c:1040
>   sync_filesystem fs/sync.c:66 [inline]
>   sync_filesystem+0x1d3/0x2a0 fs/sync.c:30
>   generic_shutdown_super+0x74/0x390 fs/super.c:621
>   kill_anon_super+0x3a/0x60 fs/super.c:1237
>   btrfs_kill_super+0x3c/0x50 fs/btrfs/super.c:2100
>   deactivate_locked_super+0xb8/0x130 fs/super.c:473
>   deactivate_super fs/super.c:506 [inline]
>   deactivate_super+0xb1/0xd0 fs/super.c:502
>   cleanup_mnt+0x378/0x510 fs/namespace.c:1435
>   task_work_run+0x16f/0x280 kernel/task_work.c:227
>   resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>   exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
>   exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
>   __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
>   syscall_exit_to_user_mode+0x29e/0x2a0 kernel/entry/common.c:218
>   do_syscall_64+0xdc/0x260 arch/x86/entry/syscall_64.c:100
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fe31fbadfcb
> Code: a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 90 f3 0f 1e fa 31 f6 e9 =
05 00 00 00 0f 1f 44 00 00 f3 0f 1e fa b8 a6 00 00 00 0f 05 <48> 3d 00 f0 =
ff ff 77 05 c3 0f 1f 40 00 48 c7 c2 a8 ff ff ff f7 d8
> RSP: 002b:00007fff6eed1d98 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> RAX: 0000000000000000 RBX: 00000000000000cf RCX: 00007fe31fbadfcb
> RDX: 00007fe31fa4eb30 RSI: 0000000000000009 RDI: 00007fff6eed1e50
> RBP: 00007fff6eed1e50 R08: 0000000000000000 R09: 00007fff6eed1c20
> R10: 000055556e3d8673 R11: 0000000000000246 R12: 00007fe31fc44135
> R13: 00007fff6eed2f20 R14: 000055556e3d8600 R15: 000000000003644b
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:write_dev_supers+0x7f0/0x910 fs/btrfs/disk-io.c:3856
> Code: e9 03 ff ff ff e8 70 a3 eb fd b9 10 0f 00 00 48 c7 c2 60 c0 d9 8b =
48 c7 c6 60 c7 d9 8b 48 c7 c7 e0 c0 d9 8b e8 41 d4 ca fd 90 <0f> 0b 48 8b =
7c 24 38 e8 04 f9 51 fe e9 3d f9 ff ff e8 3a f8 51 fe
> RSP: 0018:ffffc900053ff7c0 EFLAGS: 00010286
> RAX: 0000000000000045 RBX: ffff888029e60000 RCX: ffffffff819a5929
> RDX: 0000000000000000 RSI: ffff88801eb9bc80 RDI: 0000000000000002
> RBP: ffffea0001560a00 R08: fffffbfff1c4bb00 R09: fffff52000a7feb1
> R10: fffff52000a7feb0 R11: ffffc900053ff587 R12: dffffc0000000000
> R13: 0000000000000000 R14: 0000000000000002 R15: 0000000001000000
> FS:  000055556e3c5500(0000) GS:ffff8880eb341000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa5b213e730 CR3: 0000000076248000 CR4: 0000000000752ef0
> PKRU: 80000000
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> I hope it helps.
> Best regards
> Jianzhou Zhao <luckd0g@163.com>


