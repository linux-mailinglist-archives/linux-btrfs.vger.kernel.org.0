Return-Path: <linux-btrfs+bounces-7709-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B58B7967394
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 Sep 2024 00:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B6B28306B
	for <lists+linux-btrfs@lfdr.de>; Sat, 31 Aug 2024 22:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED6017F500;
	Sat, 31 Aug 2024 22:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Xc23ZNL7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC5529A5;
	Sat, 31 Aug 2024 22:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725143633; cv=none; b=uofWcElNIGDTMlzW91cXVqa4jSd7r5J3IoYO8nCme81h6nkZfTtIEE827wVAgoLBnFcVyYPbNcytNaaBRCeijiZb3kov0B93z447iVq/1GcJMC5jMv82H1kiSOqmc1/duvQsaLTAfyMMSoJS6pOaCMRJZCyt6zat+aPDVK1WKUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725143633; c=relaxed/simple;
	bh=P4WTBxhdMmxXB7nraLoaZ5h/u9jp6GxFQqbnPOnHI2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=f9+sr1sR/a8eypR+XnQb1FMCLg51e28cx+o+Aq1dxlxLpuFsHjBY79btP1rUjhG7lSwmOvsKLYvqT6yKa12hAlRZhC5qJhGxIlPbdRuRlPyBXqquzgBvFYoNSnmJ/9iy+ke1U2odh9POB1pawbNwDaalIinlGhhFP+Wl2ngNQ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Xc23ZNL7; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1725143614; x=1725748414; i=quwenruo.btrfs@gmx.com;
	bh=Mve+gyKsjgpW/qavfRjnHzJFKd0yzVjXgkM84t7FqHU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Xc23ZNL7ysZJT2Tzm6uIUVAPPi/76hYA/1+YDJakty/b8Ndc0kyY23/wEbZT1zlR
	 UWc4MMQJILhwwVxugReUCnAAhbZKm/aqJEaGkB2MzjIA7FS1VvagOOxT1VDbcHnsb
	 UtqiiQuGVP1pzWbk5tvmXJzeO9796+sSjctKgtDnGitcqRtAzNIzJk5zkXykuev0P
	 WbgjDa3LmhM9w4eggsGeXmdu7p4BraLutUKBCl9MBxHZhPyGWV3aTXxxJ+oGTSG2w
	 ZVX6gmJhE4XWPZaqKzKc6T9nXaB4BIkpGLMOgSoWGtt69rk5/znJr55YkRuMkzFS0
	 GOSRWAbhMmNUqsxzPw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MLQxX-1sSAaz0QBn-00Pvdq; Sun, 01
 Sep 2024 00:33:34 +0200
Message-ID: <aa2e3dba-9729-4b6b-94a5-36075d57ca7f@gmx.com>
Date: Sun, 1 Sep 2024 08:03:29 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [btrfs?] WARNING in __btrfs_free_extent (3)
To: syzbot <syzbot+480676efc0c3a76b5214@syzkaller.appspotmail.com>,
 clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <000000000000e93ea70620fe777a@google.com>
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
In-Reply-To: <000000000000e93ea70620fe777a@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TMddwUrNFH/YE5OEr/dWAfw85JCTXP1mMGVc1grfCERlU3Fp3Qe
 8kIth18GMw3B2y2f2hDg0n/t9cdTlObZkYygJe9IHjSSMjGv1lhNmdNRPUsKDj5KuJGlYz5
 XSg7QZ6GH+iQdUjUCPa2C5+QZI6rp3Tk3iv7ZW3ey/Sj56uOiNUXrSaZ7kn9YgJm+NlC5UL
 cOy6P3twL6lmbSoFKzx7w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BmYq8SQBt/s=;94CgZW+K2wwAOaoCODSSMQWyYM8
 d43omfLlX/9n+RRbgBqMkxwROWp/8TlQ024k0hmXPa5u6/HTrNpa51iLCAao/6zjJXqh3CXjd
 LkxwLlgqxUScXsegjL8x1s6M0xS6rXxFzPOp90HOpjykcH9CLxF/X+gH0tb0kkWzejliCy82x
 iw+BAlNo6IGWnN1/GUIHg5lEVWD9zr2W6uOgTXsQxzY55kNwR58gU1uH64Z8OjVmSc1100pFJ
 BUFmMoUnzWXk2bzQ9eoo6XkXf3vBWGX76Ze49fjEfFmk1aTnJqdga9YI7cxkllDTc3OPDuh4Y
 ILlQpZV7Gykzy9qmwZIYxCDz7GTMNWEGuIpbuoSemXEn5wck1OmGZHEAjccQ9p3YdyW/DfXmz
 4cLc2idQK0+9dD3xgrJamYG+sCjmeFzAhofEKT0armOWwxaEXFl1ncxk/kwT/xAEkWofduZhv
 rK2hCMQLOeKrMzy77qTUaHckqnsZoTmYVbhzVbmCl6xB1QcRye3uwOxbpIUFUwnfMPjX+VMow
 JiLPX2UpAG+4jGLdRFxMv7mIKiSNN60XhjT3h71lD4vgDwM2ssrLnN/k/Ro5cIcHAMxxPrZ21
 59WA6WSOGowmB3Q1rNeFUFkqQKS2xm1uAS5Js29W3pSGGNddHM5A7P0R6SiEXSBL2xr/fQKQ9
 s/7Yi/z+bBei/0IumOANBPq8vIoSjjSQiVkBK1ZgaGjrfOVJ6+yHR/JMd0NZ5uRqqQKYWDnRI
 tfiQGgBUddLqtiyqnaawpxxGbCMrm8OXqaJgGWbAB8wzGlAtiGMibWzg+onWH6qSPhjHj5hL5
 5fvttCWt4tvOvahNlc8ZRXXA==



=E5=9C=A8 2024/9/1 03:29, syzbot =E5=86=99=E9=81=93:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    86987d84b968 Merge tag 'v6.11-rc5-client-fixes' of git:/=
/g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D109f14259800=
00

I was checking the console and trying to find out what's before the
transaction abort.

The error number means it's ENOENT thus it seems to be a missing extent
item or whatever.

But the console output contains not even the WARNING line, is the
console output trimmed or whatever?

Thanks,
Qu

> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da0455552d0b2=
7491
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D480676efc0c3a7=
6b5214
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for De=
bian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/87692913ef45/di=
sk-86987d84.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a27da6973d7f/vmlin=
ux-86987d84.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2e28d02ce725/=
bzImage-86987d84.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the com=
mit:
> Reported-by: syzbot+480676efc0c3a76b5214@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> BTRFS: Transaction aborted (error -2)
> WARNING: CPU: 1 PID: 63 at fs/btrfs/extent-tree.c:2972 do_free_extent_ac=
counting fs/btrfs/extent-tree.c:2972 [inline]
> WARNING: CPU: 1 PID: 63 at fs/btrfs/extent-tree.c:2972 __btrfs_free_exte=
nt+0x32d1/0x3a10 fs/btrfs/extent-tree.c:3346
> Modules linked in:
> CPU: 1 UID: 0 PID: 63 Comm: kworker/u8:4 Not tainted 6.11.0-rc5-syzkalle=
r-00057-g86987d84b968 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =
Google 08/06/2024
> Workqueue: events_unbound btrfs_async_reclaim_metadata_space
> RIP: 0010:do_free_extent_accounting fs/btrfs/extent-tree.c:2972 [inline]
> RIP: 0010:__btrfs_free_extent+0x32d1/0x3a10 fs/btrfs/extent-tree.c:3346
> Code: e8 24 a4 ae fd 90 0f 0b 90 90 e9 3c f3 ff ff e8 35 80 ec fd 90 48 =
c7 c7 00 79 2b 8c 44 8b 6c 24 18 44 89 ee e8 00 a4 ae fd 90 <0f> 0b 90 90 =
4c 8b 24 24 e9 4f f3 ff ff e8 0d 80 ec fd 90 48 c7 c7
> RSP: 0018:ffffc900015e6f80 EFLAGS: 00010246
> RAX: ec2b4374561a8400 RBX: ffff88805d790001 RCX: ffff888015581e00
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: ffffc900015e7150 R08: ffffffff8155b212 R09: fffffbfff1cba0e0
> R10: dffffc0000000000 R11: fffffbfff1cba0e0 R12: dffffc0000000000
> R13: 00000000fffffffe R14: 0000000000000000 R15: ffff88805d3be5c8
> FS:  0000000000000000(0000) GS:ffff8880b9300000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f3dca9f0270 CR3: 000000002dd02000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   run_delayed_tree_ref fs/btrfs/extent-tree.c:1724 [inline]
>   run_one_delayed_ref fs/btrfs/extent-tree.c:1750 [inline]
>   btrfs_run_delayed_refs_for_head fs/btrfs/extent-tree.c:2015 [inline]
>   __btrfs_run_delayed_refs+0x112e/0x4680 fs/btrfs/extent-tree.c:2085
>   btrfs_run_delayed_refs+0xe3/0x2c0 fs/btrfs/extent-tree.c:2197
>   btrfs_commit_transaction+0x4be/0x3740 fs/btrfs/transaction.c:2198
>   flush_space+0x19c/0xd00 fs/btrfs/space-info.c:835
>   btrfs_async_reclaim_metadata_space+0x6dc/0x840 fs/btrfs/space-info.c:1=
106
>   process_one_work kernel/workqueue.c:3231 [inline]
>   process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
>   worker_thread+0x86d/0xd10 kernel/workqueue.c:3389
>   kthread+0x2f0/0x390 kernel/kthread.c:389
>   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
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

