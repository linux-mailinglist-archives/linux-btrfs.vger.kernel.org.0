Return-Path: <linux-btrfs+bounces-14985-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9053FAE99C8
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 11:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1738C1C242AB
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 09:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6B229A331;
	Thu, 26 Jun 2025 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="sGPvB9/l"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EF91C7005;
	Thu, 26 Jun 2025 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750929631; cv=none; b=Rs9z5viiT5MSLbi7q6HoAfSxeu86DVyLQDBo7FJdbFngE4TY/YWU0Il/U/AMQRC23wArlxIigLSiCsSKfI7t6CYSxBbJAHkzKiCXnJl+CQK8fNQhZ2mxRxK4888njqWYyaw1qUC+E+/VEIpV9bqLva1Aae3xSEot1/YSfVCQIxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750929631; c=relaxed/simple;
	bh=eZSWojWa4Vdr4M9424ErzQFrzY4XMLqEG5GeLVDj7pM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+U6CxZ4Z80vuvc2Fkkn8OzZuwrO/HY2LgLgP42DmvIv5m4oe95O3E7nEAoK1L9rjHwS3rYMdgkr/Sb5MKXIP3aNVtM9Pg0iwzHXKfnjo11J1dWSC0o9ZLRFVz1cq9LR/qHin6Jbu/gtdgzw9iXsajIlICgHlgcmNOmRf0ZVW0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=sGPvB9/l; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1750929622; x=1751534422; i=quwenruo.btrfs@gmx.com;
	bh=sMnDZPTJC+m0qmBSNk8gu8UMyhBNcSyBda3ExlsHmK4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sGPvB9/lttyT4LM2bQcaAfxJnM6lSTdXjKt7ZsL2T6nZbwqZIu/S96NjoU1/22fX
	 NZ+uT93fnylnHEM7QwaZkwd6yHTDLLPxct/iSK5e+oQgIPWU6snrI1cHuQg3igcPG
	 XgBAn3Ml+gAUqwNxPohUZRPFMG26lk1LGcmGZVNbDw9xp5CZxdXKR1sDzgbfkdx7r
	 2cVQGoHuxVv1dWQATkNAzkFaPo/odSfGQ1TcepkmmGEl52gnH6uLP7y+Ojggy8rtH
	 F0Iy8g0ZgnKTKESFtZW2DA6ON8DRW/NkslldbvvVV416h4EVdk4ebs+IurXtfFNv/
	 pd8KntQt+7PU3zywIg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N9MpY-1upqZG0ecW-00vIFX; Thu, 26
 Jun 2025 11:20:22 +0200
Message-ID: <bbe21da7-eed3-4fb9-afd9-6f1c70c0eaed@gmx.com>
Date: Thu, 26 Jun 2025 18:50:17 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] btrfs: Assertion failed in btrfs_exclop_balance on balance
 ioctl
To: cen zhang <zzzccc427@gmail.com>, clm@fb.com, josef@toxicpanda.com,
 dsterba@suse.com
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, zhenghaoran154@gmail.com
References: <CAFRLqsVDimnqBx0_pDF-bqEQ3epha2d3r6cKm-0b6UdzkkE42Q@mail.gmail.com>
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
In-Reply-To: <CAFRLqsVDimnqBx0_pDF-bqEQ3epha2d3r6cKm-0b6UdzkkE42Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QY+xAIAqUGwWP96JyW1Uv/alQzK8cAvfeAbtxIgXcDpxNKKigHg
 FoM5lRrKL6GSE7AzghR/xhnGPB7ByAOyfKl43NaPGihfi2BLuiqevZ86Dxi1o+vQAqfDORz
 BttFhASEb0dJAxwOl2JxxC3+s3955MKSXGo9ATJJbbKV+ARlHuJM/OAGoSjQZCQ3+RCuXwh
 GQh5pRtxuL69uGF764oOg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FWz2M1KQN68=;LGEwWnJuknylCOTO5vnurrw+Oaq
 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
 nVP7jDoiiPyDNo6bFSsXBmhtSAhkStoc=



=E5=9C=A8 2025/6/26 17:37, cen zhang =E5=86=99=E9=81=93:
> Hello Btrfs maintainers,
>=20
> I would like to report a kernel BUG, which appears to be a state
> management issue in the balance ioctl path.
>=20
> The kernel panics due to a failed assertion in btrfs_exclop_balance()
> at fs/btrfs/fs.c:127. The assertion fs_info->exclusive_operation =3D=3D
> BTRFS_EXCLOP_BALANCE_PAUSED fails, indicating that the function was
> called with an unexpected exclusive operation state.
>=20
> Here are the relevant details:
>=20
> Kernel Version: 6.16.0-rc1-g7f6432600434-dirty
> Hardware: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996)

Reproducer please?

I guess you guys are running syzbot, then please provide the usual=20
syzbot assets.

>=20
> Crash Log:
> assertion failed: fs_info->exclusive_operation =3D=3D
> BTRFS_EXCLOP_BALANCE_PAUSED :: 0, in fs/btrfs/fs.c:127
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/fs.c:127!
> Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> CPU: 0 UID: 0 PID: 95466 Comm: syz-executor.6 Not tainted
> 6.16.0-rc1-g7f6432600434-dirty #52 PREEMPT(voluntary)
> Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS
> 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:btrfs_exclop_balance+0x632/0x640 fs/btrfs/fs.c:127
> Code: b5 fe e8 11 0c c7 fe 48 c7 c7 60 06 19 9c 48 c7 c6 80 08 19 9c
> 31 d2 48 c7 c1 40 08 19 9c 41 b8 7f 00 00 00 e8 7f 2e 7b fe 90 <0f> 0b
> 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
> RSP: 0018:ffff88811c37fd88 EFLAGS: 00010246
> RAX: 0000000000000068 RBX: 0000000000000000 RCX: 7c00c5848baac500
> RDX: ffffc9001dfc5000 RSI: 000000000000092e RDI: 000000000000092f
> RBP: 1ffff110277c95ae R08: ffff88811c37fc2f R09: 1ffff1102386ff85
> R10: dffffc0000000000 R11: ffffed102386ff86 R12: ffff88813be4ad70
> R13: 1ffffda204ef92b5 R14: dffffc0000000000 R15: ffffed10277c95ae
> FS:  00007fda4d92c6c0(0000) GS:ffff88840ff1b000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b31222000 CR3: 000000012ebdb000 CR4: 00000000000006f0
> Call Trace:
>   <TASK>
>   btrfs_ioctl_balance+0x9bd/0xf10 fs/btrfs/ioctl.c:3548
>   btrfs_ioctl+0x104f/0x1480 fs/btrfs/ioctl.c:5303
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:907 [inline]
>   __se_sys_ioctl+0xd1/0x130 fs/ioctl.c:893
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xcf/0x240 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fda4e7fa35d
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fda4d92c0a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007fda4e94c1f0 RCX: 00007fda4e7fa35d
> RDX: 0000000020008c40 RSI: 00000000c4009420 RDI: 0000000000000003
> RBP: 00007fda4e86b4b1 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: ffffffffffffffb8 R14: 00007fda4e94c1f0 R15: 00007ffc61c2f0d0
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:btrfs_exclop_balance+0x632/0x640 fs/btrfs/fs.c:127
> Code: b5 fe e8 11 0c c7 fe 48 c7 c7 60 06 19 9c 48 c7 c6 80 08 19 9c
> 31 d2 48 c7 c1 40 08 19 9c 41 b8 7f 00 00 00 e8 7f 2e 7b fe 90 <0f> 0b
> 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90
> RSP: 0018:ffff88811c37fd88 EFLAGS: 00010246
> RAX: 0000000000000068 RBX: 0000000000000000 RCX: 7c00c5848baac500
> RDX: ffffc9001dfc5000 RSI: 000000000000092e RDI: 000000000000092f
> RBP: 1ffff110277c95ae R08: ffff88811c37fc2f R09: 1ffff1102386ff85
> R10: dffffc0000000000 R11: ffffed102386ff86 R12: ffff88813be4ad70
> R13: 1ffffda204ef92b5 R14: dffffc0000000000 R15: ffffed10277c95ae
> FS:  00007fda4d92c6c0(0000) GS:ffff88840ff1b000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b31222000 CR3: 000000012ebdb000 CR4: 00000000000006f0
> note: syz-executor.6[95466] exited with preempt_count 1
>=20
> Here is the machineinfo:
> ------------------------------------------------------------------------=
=2D-------
> QEMU emulator version 8.2.2 (Debian 1:8.2.2+ds-0ubuntu1.7)
> qemu-system-x86_64 ["-m" "16384" "-smp" "4" "-chardev"
> "socket,id=3DSOCKSYZ,server=3Don,wait=3Doff,host=3Dlocalhost,port=3D2467=
4"
> "-mon" "chardev=3DSOCKSYZ,mode=3Dcontrol" "-display" "none" "-serial"
> "stdio" "-no-reboot" "-name" "VM-1" "-device" "virtio-rng-pci"
> "-enable-kvm" "-hdb"
> "/home/zzzccc/go-work/syzkaller-old/syzkaller/test/btrfs/disk.qcow2"
> "-device" "e1000,netdev=3Dnet0" "-netdev"
> "user,id=3Dnet0,restrict=3Don,hostfwd=3Dtcp:127.0.0.1:35475-:22,hostfwd=
=3Dtcp::7313-:6060"
> "-hda" "/home/zzzccc/go-work/syzkaller-old/syzkaller/test/btrfs/bookworm=
.img"
> "-snapshot" "-kernel" "/home/zzzccc/linux-DDRD/arch/x86/boot/bzImage"
> "-append" "root=3D/dev/sda console=3DttyS0 "]
>=20
> [CPU Info]
> processor           : 0, 1, 2, 3
> vendor_id           : AuthenticAMD
> cpu family          : 15
> model               : 107
> model name          : QEMU Virtual CPU version 2.5+
> stepping            : 1
> microcode           : 0x1000065
> cpu MHz             : 3593.248
> cache size          : 512 KB
> physical id         : 0
> siblings            : 4
> core id             : 0, 1, 2, 3
> cpu cores           : 4
> apicid              : 0, 1, 2, 3
> initial apicid      : 0, 1, 2, 3
> fpu                 : yes
> fpu_exception       : yes
> cpuid level         : 13
> wp                  : yes
> flags               : fpu de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx lm rep_good
> nopl cpuid extd_apicid tsc_known_freq pni cx16 x2apic hypervisor
> lahf_lm cmp_legacy svm 3dnowprefetch vmmcall
> bugs                : fxsave_leak sysret_ss_attrs null_seg
> swapgs_fence amd_e400 spectre_v1 spectre_v2 spectre_v2_user
> bogomips            : 7186.49
> TLB size            : 1024 4K pages
> clflush size        : 64
> cache_alignment     : 64
> address sizes       : 40 bits physical, 48 bits virtual
> power management    :
>=20
> ------------------------------------------------------------------------=
=2D-------
>=20
> Here is the log of this
> bug:https://github.com/zzzcccyyyggg/Syzkaller-log/blob/main/c206ec44dc55=
2558339e6db76afe471d2dcee23b/log3
>=20
> Thank you for your attention to this matter.
>=20
> Best regards,
> Cen Zhang
>=20



