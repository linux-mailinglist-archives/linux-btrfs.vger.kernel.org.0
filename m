Return-Path: <linux-btrfs+bounces-14975-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AF5AE95A0
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 08:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D07AD4A2A74
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Jun 2025 06:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4C222541C;
	Thu, 26 Jun 2025 06:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="FtNpDmN4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC18354F81;
	Thu, 26 Jun 2025 06:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750917955; cv=none; b=hBH2gJjb2rmlmsxThYqYTip0krWGCkNTF/TsC9EtjATGHFlW95qjuN/P7IS0YpsM3nlFoQLDdkGbh9aJvCvS5mdXC5OSwnC7unbde576GcL4SyhdA8YA5/ExLvaNg2Wnta5GfPnDPFC7i5CXqWx9t6JnxqDGRzciea9najalnB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750917955; c=relaxed/simple;
	bh=cOP0vEXs6frp58gEOwvRBFGbJUTxK+G9kPArRnNV0pM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AEMFKZENx3qIqnKYwlJ7wCWYJZTM6LKlZI2H6iag0lfI04E5n7svj6gyTy+SPbGTzbt87Zei1GajFdd3OzgXkHAGdZoke8PmKjX4DBAj88LBxYh5CtjWQlrcYixH94UoeF9OoSuYH57MkTbq6fEutakCGUYUYSvAtidFjp4WRT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=FtNpDmN4; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1750917945; x=1751522745; i=quwenruo.btrfs@gmx.com;
	bh=rX5dxIHYFeKx4FfT5CWqJwkHBK1gC1KDismkqgLAQnE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FtNpDmN4c6lrbdrpLvwWHsJ61uLDjvDlrS53nC5YGyaVMtxRtkbetu5lZHX0uQXV
	 sZ0U/uFD4rV2NQouYUxTOwpOdzZmzWz8t4r40MmWkQE2xJwYn007FVU7JDY/aNTFc
	 nz3ZpdUr6za0Aje5cow2OholGGX9Q8SReUe51KSJhomCth9GDpJNVCk2I/4GqmGnJ
	 ZvSEJMgn4wVCv5BmGaOG65fhjciYVRshFrPyH2reQtOFGl5s17R1d4Nb/uY0m8+43
	 vNvwnfUPiph45sMqH09d01u+JGpkP6aGz0CCksZ4VlAhZ5jdznqO+5iMM2G+VZB6c
	 L5hjGdy3T8k3Ke4R6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MXGr8-1uEeFK2dSg-00Oybv; Thu, 26
 Jun 2025 08:05:45 +0200
Message-ID: <197c44ef-aa46-466e-9381-a0edff657762@gmx.com>
Date: Thu, 26 Jun 2025 15:35:40 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [btrfs?] possible deadlock in btrfs_read_chunk_tree
To: syzbot <syzbot+fa90fcaa28f5cd4b1fc1@syzkaller.appspotmail.com>,
 clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, wqu@suse.com
References: <685aa401.050a0220.2303ee.0009.GAE@google.com>
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
In-Reply-To: <685aa401.050a0220.2303ee.0009.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Tj2BwBo5eT/KJPzsyiaiGZqfGfGuOHUULA8Mfo+Vz2/Qcb54kPB
 ewQJZzB7qA929wMH78hS8aN/MY6cj/sn49+9rKl93TwdV25LSU/AS4fUU7KGYoshoOc+Xu1
 orXNarg1UStRftEmj/VimlEYPWKYhXA5BxizbcST8jL5saZOoS98oDzl4UecfoUo5/L/YO6
 hCjNsJhGsFzZ0zFg9ZvTw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6N3HAn0CSIk=;C8xEfnOjj2D+JzbiJQkqADix8kS
 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
 F7pNhbEi97Q==

#syz test: https://github.com/adam900710/linux.git shutdown

=E5=9C=A8 2025/6/24 22:41, syzbot =E5=86=99=E9=81=93:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    5d4809e25903 Add linux-next specific files for 20250620
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D1421b3705800=
00
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D58afc4b78b52=
b7e3
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dfa90fcaa28f5cd=
4b1fc1
> compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e077=
57-1~exp1~20250514183223.118), Debian LLD 20.1.6
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D11f1cb0c58=
0000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14aff30c5800=
00
>=20
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/16492bf6b788/di=
sk-5d4809e2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7be284ded1de/vmlin=
ux-5d4809e2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/467d717f0d9c/=
bzImage-5d4809e2.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/4a74fbfa0=
b0f/mount_0.gz
>    fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=3D10=
30cdd4580000)
>=20
> The issue was bisected to:
>=20
> commit 7aacdf6feed1ca882339ebd3895a233373b40a1e
> Author: Qu Wenruo <wqu@suse.com>
> Date:   Tue Jun 17 05:19:38 2025 +0000
>=20
>      btrfs: delay btrfs_open_devices() until super block is created
>=20
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D14d29b0c5=
80000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D16d29b0c5=
80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D12d29b0c5800=
00
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the com=
mit:
> Reported-by: syzbot+fa90fcaa28f5cd4b1fc1@syzkaller.appspotmail.com
> Fixes: 7aacdf6feed1 ("btrfs: delay btrfs_open_devices() until super bloc=
k is created")
>=20
> BTRFS info (device loop0): using sha256 (sha256-x86_64) checksum algorit=
hm
> BTRFS info (device loop0): disk space caching is enabled
> BTRFS warning (device loop0): space cache v1 is being deprecated and wil=
l be removed in a future release, please use -o space_cache=3Dv2
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 6.16.0-rc2-next-20250620-syzkaller #0 Not tainted
> ------------------------------------------------------
> syz-executor123/5843 is trying to acquire lock:
> ffffffff8e6e9fe8 (uuid_mutex){+.+.}-{4:4}, at: btrfs_read_chunk_tree+0xe=
f/0x2170 fs/btrfs/volumes.c:7462
>=20
> but task is already holding lock:
> ffff8880328ea0e0 (&type->s_umount_key#41/1){+.+.}-{4:4}, at: alloc_super=
+0x204/0x970 fs/super.c:345
>=20
> which lock already depends on the new lock.
>=20
>=20
> the existing dependency chain (in reverse order) is:
>=20
> -> #1 (&type->s_umount_key#41/1){+.+.}-{4:4}:
>         lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
>         down_write_nested+0x9d/0x200 kernel/locking/rwsem.c:1693
>         alloc_super+0x204/0x970 fs/super.c:345
>         sget_fc+0x329/0xa40 fs/super.c:761
>         btrfs_get_tree_super fs/btrfs/super.c:1867 [inline]
>         btrfs_get_tree_subvol fs/btrfs/super.c:2059 [inline]
>         btrfs_get_tree+0x4c6/0x12d0 fs/btrfs/super.c:2093
>         vfs_get_tree+0x8f/0x2b0 fs/super.c:1804
>         do_new_mount+0x24a/0xa40 fs/namespace.c:3902
>         do_mount fs/namespace.c:4239 [inline]
>         __do_sys_mount fs/namespace.c:4450 [inline]
>         __se_sys_mount+0x317/0x410 fs/namespace.c:4427
>         do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>         do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>         entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> -> #0 (uuid_mutex){+.+.}-{4:4}:
>         check_prev_add kernel/locking/lockdep.c:3168 [inline]
>         check_prevs_add kernel/locking/lockdep.c:3287 [inline]
>         validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
>         __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
>         lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
>         __mutex_lock_common kernel/locking/mutex.c:602 [inline]
>         __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:747
>         btrfs_read_chunk_tree+0xef/0x2170 fs/btrfs/volumes.c:7462
>         open_ctree+0x17f2/0x3a10 fs/btrfs/disk-io.c:3458
>         btrfs_fill_super fs/btrfs/super.c:984 [inline]
>         btrfs_get_tree_super fs/btrfs/super.c:1922 [inline]
>         btrfs_get_tree_subvol fs/btrfs/super.c:2059 [inline]
>         btrfs_get_tree+0xc6f/0x12d0 fs/btrfs/super.c:2093
>         vfs_get_tree+0x8f/0x2b0 fs/super.c:1804
>         do_new_mount+0x24a/0xa40 fs/namespace.c:3902
>         do_mount fs/namespace.c:4239 [inline]
>         __do_sys_mount fs/namespace.c:4450 [inline]
>         __se_sys_mount+0x317/0x410 fs/namespace.c:4427
>         do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>         do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>         entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> other info that might help us debug this:
>=20
>   Possible unsafe locking scenario:
>=20
>         CPU0                    CPU1
>         ----                    ----
>    lock(&type->s_umount_key#41/1);
>                                 lock(uuid_mutex);
>                                 lock(&type->s_umount_key#41/1);
>    lock(uuid_mutex);
>=20
>   *** DEADLOCK ***
>=20
> 1 lock held by syz-executor123/5843:
>   #0: ffff8880328ea0e0 (&type->s_umount_key#41/1){+.+.}-{4:4}, at: alloc=
_super+0x204/0x970 fs/super.c:345
>=20
> stack backtrace:
> CPU: 1 UID: 0 PID: 5843 Comm: syz-executor123 Not tainted 6.16.0-rc2-nex=
t-20250620-syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =
Google 05/07/2025
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>   print_circular_bug+0x2ee/0x310 kernel/locking/lockdep.c:2046
>   check_noncircular+0x134/0x160 kernel/locking/lockdep.c:2178
>   check_prev_add kernel/locking/lockdep.c:3168 [inline]
>   check_prevs_add kernel/locking/lockdep.c:3287 [inline]
>   validate_chain+0xb9b/0x2140 kernel/locking/lockdep.c:3911
>   __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
>   lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
>   __mutex_lock_common kernel/locking/mutex.c:602 [inline]
>   __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:747
>   btrfs_read_chunk_tree+0xef/0x2170 fs/btrfs/volumes.c:7462
>   open_ctree+0x17f2/0x3a10 fs/btrfs/disk-io.c:3458
>   btrfs_fill_super fs/btrfs/super.c:984 [inline]
>   btrfs_get_tree_super fs/btrfs/super.c:1922 [inline]
>   btrfs_get_tree_subvol fs/btrfs/super.c:2059 [inline]
>   btrfs_get_tree+0xc6f/0x12d0 fs/btrfs/super.c:2093
>   vfs_get_tree+0x8f/0x2b0 fs/super.c:1804
>   do_new_mount+0x24a/0xa40 fs/namespace.c:3902
>   do_mount fs/namespace.c:4239 [inline]
>   __do_sys_mount fs/namespace.c:4450 [inline]
>   __se_sys_mount+0x317/0x410 fs/namespace.c:4427
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fda63124f3a
> Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f =
84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd76f19cb8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007ffd76f19cd0 RCX: 00007fda63124f3a
> RDX: 00002000000004c0 RSI: 00002000000015c0 RDI: 00007ffd76f19cd0
> RBP: 00002000000004c0 R08: 00007ffd76f19d10 R09: 0000000000005598
> R10: 0000000002000000 R11: 0000000000000282 R12: 00002000000015c0
> R13: 00007ffd76f19d10 R14: 0000000000000003 R15: 0000000002000000
>   </TASK>
> BTRFS info (device loop0): rebuilding free space tree
> BTRFS info (device loop0): disabling free space tree
> BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPAC=
E_TREE (0x1)
> BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPAC=
E_TREE_VALID (0x2)
>=20
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisec=
tion
>=20
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>=20
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>=20
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>=20
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>=20
> If you want to undo deduplication, reply with:
> #syz undup
>=20


