Return-Path: <linux-btrfs+bounces-8756-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A5F997910
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 01:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D90381C22023
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 23:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4562B1E3DF9;
	Wed,  9 Oct 2024 23:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="AwPSG5nU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFC4149C4F;
	Wed,  9 Oct 2024 23:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728516108; cv=none; b=LiDL6rRzwjuqd58W8oJZsXfc2PW3eBblscnWS8CFwmUFtAZYu7ntL9dTlquET6zzL9+dVprfcy7kxzxxbBO8JAVtMzDE20ee2ZS5nmjQV/3tQAQglCFKZI3zZdxK5b0bcFjWLCNz1J5CG3uumMCaaW6YGlp1xNkp7/5b6jVijAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728516108; c=relaxed/simple;
	bh=HWmZQH1Wc+Mkzoi2FinFwnWd63jWBJRIAwLVlXDSu/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KBYGB/pLUdjah42HH5/FIXq6OECfj7Nr4QUZtPUr4Z/teBvSFn70dnwb4BsqEA7Ar9EblKNQWUWzGtesQfwyroSCbRGue6epWZpbKFRD0RXfk2qVEHR01ikxNnNPhpSaveZ0whGjvBzYv1UaIssJ4N6xOH/NQxA4kfdXDt8EL54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=AwPSG5nU; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1728516098; x=1729120898; i=quwenruo.btrfs@gmx.com;
	bh=4oFMtdZ5GFFGjiM81aydwGUkRCFzt/gOA3U/PfzajLA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AwPSG5nU+HP570uTjdfXPTXKGOShgtYGh76Elv7FYuSMiK03/HgEyogyN4AKfMKp
	 eQkQEJ6BZ/NGCFoM1UR/517nUpiFE+yB7+5OC0P7Yt6TXYewZHoUsnpBxHHshGU0v
	 mCzvyfoA+palnPILqQmGM+kg/1fBPg9s5T9QGlnoUkwIykf1wGuyGXY0Thz80D9HE
	 B7rI1PBpz38TtD5tJ4rzo4c9u1hXufORdlnE3HT2SI7MQSNflXnWOs6Jhomr2wOt+
	 oPIeWBLH3dipiRgBgvfyzA/rLK2makA9gKQjS/IKto9iIRubNC5Gl96aauEhDN6Jb
	 U7Nf86wwaiygTo065g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MGyxN-1tB4Ta47Pf-009Dbs; Thu, 10
 Oct 2024 01:21:38 +0200
Message-ID: <5278c962-8f78-499d-9723-38a3d6520e19@gmx.com>
Date: Thu, 10 Oct 2024 09:51:34 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [btrfs?] BUG: sleeping function called from invalid
 context in getname_kernel
To: syzbot <syzbot+02a127be2df04bdc5df0@syzkaller.appspotmail.com>,
 clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <670689a8.050a0220.67064.0045.GAE@google.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <670689a8.050a0220.67064.0045.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LoptPSLV1kF0xwMi0OWAq2S7yDr3DP+yGnQkz1luXFaR2fUBMjV
 z2664Z3rQfBElKUhpbfn4ZbNCo5YXFxCOVHgPfW4YqU93rJ3Oh/Y75ok8hLk5/Of8UAkk0J
 3F5TAHH2BDos7xNG3gtKqDMk64dJ8zzFNwBvSkK85AMCg0BRF7JNgjoNgNPHEYCcpyr6baW
 hPK4RZ2Sq0yshNh12lA/g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YeqAVqAlcxk=;n2cvIM4gm1XT6yFMQ4fPUZ5zo/0
 WE8sZdilNVDF/Crj2JGTkcd8mcrKeLoT4MbVoGG8r4Q7qliDSrJdU7bupIkYCM1TAUEGKAwf/
 cWzaD16lJgzzgMgMgUNrt5NuaeHCSJ93MWy2+eAuPv44Xc5JVHTe/S8iAoGFsZswJisFxim4j
 b1cNIIZOUm8/51KlvxC7VGgoQjQ4JQNaQcCDmXgKOqyd0eOocmxxZZtgCe8Hqrq1FlQKkXcoQ
 SNl0r9BN0AFQSFaCJ+xAi4K4sWFuKCiT2lBAhvGRVV3YwNaJUMI3ku22/4KzH9Xbd0jrb55q8
 tLRVQ1c00FdlVMIQFF5ou1f7jgx3NKQpkjC+BtV3rWOMgD/saqJSbNF7tAAVkySSZLC/F6ZvG
 9J4oGVNAL7DQAzwTewKM91SIi3yao8uBWh+zw4Jhbj2WlW2dYQ17S7QVsIwirGY6ebmaEs1wk
 SBbplHq8J5qc4FfNb2SbLngoVBeC0X9Uuc5am0vTNn9xtbQuaQGzEAoTrUYrc65eaUyY70rJF
 GZLOF4kUHtRPNUkytLNA/xfY0Nl//jY0m7U+wPa5736Mn6LwcTfyOEjCYwVFFQnrJjZc1meie
 eAFIOQhHbTtQ7JCIy3KVE42Ru55EQvxkg1VUWLfGw8ZCE2p7jkwDfsZgKAyzdVHjc3uSBKHgM
 7nSvoLMBljUc7eWyqzRmFGhWXZ1whQ/0Cj1o0+1lCjy0FPmZnS2Fog9UMSIOBTsLfh2VJ7odm
 Fmjf/RGYELAPn99zrymLhVahmq6tLomuqvxrxydJyhrrIRKWEh0VXXacy7+rkUgdHlbDosRki
 xDnyXPcH8QYFuiNLFliqp8dg==

#syz test: https://github.com/adam900710/linux.git subpage_read

=E5=9C=A8 2024/10/10 00:18, syzbot =E5=86=99=E9=81=93:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    33ce24234fca Add linux-next specific files for 20241008
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D147717805800=
00
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4750ca93740b=
938d
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D02a127be2df04b=
dc5df0
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for De=
bian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D112f97d058=
0000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D101d4f9f9800=
00
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ee8dc2df0c57/di=
sk-33ce2423.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/dc473c0fa06e/vmlin=
ux-33ce2423.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4671f1ca2e61/=
bzImage-33ce2423.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/9876580e5=
6ab/mount_0.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the com=
mit:
> Reported-by: syzbot+02a127be2df04bdc5df0@syzkaller.appspotmail.com
>
> BUG: sleeping function called from invalid context at include/linux/sche=
d/mm.h:330
> in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 5233, name: udevd
> preempt_count: 0, expected: 0
> RCU nest depth: 1, expected: 0
> INFO: lockdep is turned off.
> CPU: 1 UID: 0 PID: 5233 Comm: udevd Not tainted 6.12.0-rc2-next-20241008=
-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =
Google 09/13/2024
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>   __might_resched+0x5d4/0x780 kernel/sched/core.c:8638
>   might_alloc include/linux/sched/mm.h:330 [inline]
>   slab_pre_alloc_hook mm/slub.c:4062 [inline]
>   slab_alloc_node mm/slub.c:4140 [inline]
>   kmem_cache_alloc_noprof+0x61/0x380 mm/slub.c:4167
>   getname_kernel+0x59/0x2f0 fs/namei.c:234
>   kern_path+0x1d/0x50 fs/namei.c:2716
>   is_same_device fs/btrfs/volumes.c:812 [inline]
>   device_list_add+0xc64/0x1ea0 fs/btrfs/volumes.c:947
>   btrfs_scan_one_device+0xab5/0xd90 fs/btrfs/volumes.c:1538
>   btrfs_control_ioctl+0x165/0x3e0 fs/btrfs/super.c:2264
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:907 [inline]
>   __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7faa2bb1ad49
> Code: 5c c3 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 =
48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <41> 89 c0 3d =
00 f0 ff ff 76 10 48 8b 15 ae 60 0d 00 f7 d8 41 83 c8
> RSP: 002b:00007ffd55ec91e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007faa2bb1ad49
> RDX: 00007ffd55ec91f8 RSI: 0000000090009427 RDI: 0000000000000009
> RBP: 0000000000000009 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffd55eca238 R14: 000055773bb412a0 R15: 00007ffd55ecaf58
>   </TASK>
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup
>


