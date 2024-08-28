Return-Path: <linux-btrfs+bounces-7655-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD9D963520
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 01:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE681F2388C
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Aug 2024 23:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B261AD9E1;
	Wed, 28 Aug 2024 22:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="oSK4iWBp"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFD3157A55;
	Wed, 28 Aug 2024 22:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724885989; cv=none; b=RgglNaZfBhwA776UuFlksxrMCi5WMHObzXbKiKg/XE8+PcPGFHIlvVb4TDe5yUvKt2MT9htab3fCUSyTki+68dc6N2wg/DwSkCf/xWQyFAmD2Q3gi24vC1VRX6KRDbFxZL8PzOhJYwRa3MIGqHJUfhtNmVv3uJ35103bf+g3DvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724885989; c=relaxed/simple;
	bh=6u6EYvyleHIfW0zy4csAsdavQ/iwnvYbkAIJrSH3Q9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dsq5B0cwbxV9bFC9LGBQfM7kmEqcFI0iuxhrhy4LAMKpn/FPJq/yyMwnTofP58YX81xLydZg76Rq7x4PTksnPVVLx6jIROEh+QRgARrIOo0OZ+o5+Vh/38H7S90WuLHQv5V2rvRxCrteZoftsyAFTA3v1DYEpUCu6xAAjuXM0vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=oSK4iWBp; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1724885978; x=1725490778; i=quwenruo.btrfs@gmx.com;
	bh=gr2mw8Jcr/YptkgHq4lPr55iBr7D1+Fbn6+UHu3HBOM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oSK4iWBp1hfOXzZxgLWqBKfUb0mG5u5NJspVtQugiPFrigJwNQpfFoPRbfewcn1U
	 eq2Z5HLwBImkMfjhZJbAO5K/aut7t+pJLUfuiIEMzrFYMq8yKayxT0st6kufgJQDS
	 IYzrYOz7QpeYWi360MbR2gmN9iY3Nx/2OuPfW8a+P5EBQlV68uGA+g5E3yZrUDL4z
	 qDGhpU0ZiscAKmQuNi1dtLGd4SuX5+9MM30WILnrxYxQW0Lf0skfpVGvXkOOjxWwc
	 Fb3ne3kbZPCQAFeZeqBUb/hf4/NxyHj05Lx9cjHO1e6Y12mkzpEGKtEH+28lmLqw1
	 Z7yecALurfW11HZdjg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MzQkK-1rwzmL3v8K-00ubRx; Thu, 29
 Aug 2024 00:59:38 +0200
Message-ID: <371fa45d-bf8c-4180-9a9f-63962f6aa0e0@gmx.com>
Date: Thu, 29 Aug 2024 08:29:33 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [btrfs?] kernel BUG in __extent_writepage_io (2)
To: syzbot <syzbot+ba3c0273042a898c230e@syzkaller.appspotmail.com>,
 clm@fb.com, dsterba@suse.com, hch@lst.de, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <0000000000008851fe0620c5f51c@google.com>
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
In-Reply-To: <0000000000008851fe0620c5f51c@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PzofUyJAiJ0iIoU4jstpDl+nyegVsgIg0HzrzMxW2E6DvUiRkml
 ty4OFtVolPscPHN2iBQ3P5IRJUqKLU0TimyrGiha1WTlmL0ad4gUPTUV7Y2FVos+W3z/ogu
 1gViYQ11KnSelHNFCjNtz0YgpWSLmA2KJtDKX5sLysRZU0B9r5PeVPBMLCJAmLL+VlZ9hDW
 VfU60TtXBHWm3OwKaUY0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:p6OYhuSJtzM=;8dFWlvPcGM4VWeKXIL7B3hbY3Q/
 loebZzSZhuHe9IoALGlc5RWTk+B0fZ9tzVIY4laKLH66pIZf0UlUcIZYd1/59YN7kySIC6+fL
 4FOERPvb/0fQHKRqedMHPpNm0GDmEV9eWTWkjavTBFWuwnP+bJqpuh6Xd1433Sq6wmS9CpYcB
 L3wlWwNKVqODHeyXpAjCdVTEjbN+IzXjSKunSqzxZwQ9jWbm/FFOOLKhATwKoaQynYa7clAEl
 8LySonKXde2SxA4chgyUyvYY6uPvpD8a4E8VvDQvTbDUtRHogqJWzu317JWgcOp22bBdiNv+D
 7c3Jy+BXZYKlKHqz+a+tKbAlOg7u1ffW5VAeMQmu9U5U/sY3MWzShTK3eTxF25ljKgtUChejq
 mALxHFMixSWGgM77tvkZ/8mT1R69wyioTIj6/A0WeqCDjLKw27FevZeRnI4hTvcsZb5jRSxLR
 sFNG8nZyFuY+7mrakZpwg2AMJJCwedqThfldSKLecNCXRWCXTGBtBA61OkRSj+fYKDZgXPf8C
 IWPT2czS59DYAZXRe50P0LjR4TBOV+v0w/mj2gU565rbnbMb78boi7dxiPcWH4p/XoMFBInEO
 fVqoTofkfP3aUiR+hPsDaCtCLfJV0luoA1dmMJxiFjY6ni6H61cGI42rgx9jpeBpJN94iHHW+
 6eekk9/sO3HOiuKYMo97NjUFQMcE6wW7/iCRfUEQA7lM+7bn5DUP54sd+gApA1smCwTCA7ohR
 f0ZPLybZrJp5/wCs7hx1H7qxW0yQZjol8666d2PHsX9LTbOkVGHuSva5qBA0nftk5fBqKWBuf
 aoi0i271NJI1a5MZyvIAG+EYPnRc5vj3boGYgBgfUEDyM=



=E5=9C=A8 2024/8/29 08:04, syzbot =E5=86=99=E9=81=93:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    d2bafcf224f3 Merge tag 'cgroup-for-6.11-rc4-fixes' of gi=
t:..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D12d5fa7b9800=
00
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4fc2afd52fd0=
08bb
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dba3c0273042a89=
8c230e
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for De=
bian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D137c040b98=
0000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16ddb0159800=
00
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/7569f02310fb/di=
sk-d2bafcf2.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e30fee7b6c1d/vmlin=
ux-d2bafcf2.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/2ffddebac153/=
bzImage-d2bafcf2.xz
> mounted in repro #1: https://storage.googleapis.com/syzbot-assets/cd0855=
7ae343/mount_0.gz
> mounted in repro #2: https://storage.googleapis.com/syzbot-assets/90ff83=
92fe84/mount_2.gz
> mounted in repro #3: https://storage.googleapis.com/syzbot-assets/9c5b91=
850930/mount_7.gz
>
> The issue was bisected to:
>
> commit f22b5dcbd71edea087946511554956591557de9a
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Wed May 31 06:04:59 2023 +0000
>
>      btrfs: remove non-standard extent handling in __extent_writepage_io
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D109740439=
80000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D129740439=
80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D149740439800=
00
>
> IMPORTANT: if you fix the issue, please add the following tag to the com=
mit:
> Reported-by: syzbot+ba3c0273042a898c230e@syzkaller.appspotmail.com
> Fixes: f22b5dcbd71e ("btrfs: remove non-standard extent handling in __ex=
tent_writepage_io")
>
> assertion failed: block_start !=3D EXTENT_MAP_HOLE, in fs/btrfs/extent_i=
o.c:1488

This means there is a dirty page range for us to writeback, but no
delalloc range for it.

That patch is not the cause, but only exposed it.

I guess there is some page fault involved or interrupted direct IO?

Anyway the bisection doesn't make much sense.

Thanks,
Qu

> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/extent_io.c:1488!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 1 UID: 0 PID: 5722 Comm: syz-executor399 Not tainted 6.11.0-rc4-syz=
kaller-00255-gd2bafcf224f3 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =
Google 08/06/2024
> RIP: 0010:__extent_writepage_io+0x1224/0x1400 fs/btrfs/extent_io.c:1488
> Code: f7 07 90 0f 0b e8 dc 68 df fd 48 c7 c7 e0 92 2c 8c 48 c7 c6 c0 a0 =
2c 8c 48 c7 c2 80 92 2c 8c b9 d0 05 00 00 e8 9d 15 f7 07 90 <0f> 0b e8 b5 =
68 df fd 48 8b 3c 24 e8 bc 9d ff ff 48 89 c7 48 c7 c6
> RSP: 0018:ffffc900097d6ee8 EFLAGS: 00010246
> RAX: 000000000000004e RBX: 0000000000000000 RCX: 2f9fd79be1350f00
> RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> RBP: dffffc0000000000 R08: ffffffff817402ac R09: 1ffff920012fad7c
> R10: dffffc0000000000 R11: fffff520012fad7d R12: ffffea0001ccbdc8
> R13: 1ffffd40003997b9 R14: fffffffffffffffd R15: 000000000007b000
> FS:  00007f11a84976c0(0000) GS:ffff8880b9300000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f11a0fff000 CR3: 0000000020e4c000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   __extent_writepage fs/btrfs/extent_io.c:1578 [inline]
>   extent_write_cache_pages fs/btrfs/extent_io.c:2251 [inline]
>   btrfs_writepages+0x12a2/0x2760 fs/btrfs/extent_io.c:2373
>   do_writepages+0x35d/0x870 mm/page-writeback.c:2683
>   filemap_fdatawrite_wbc+0x125/0x180 mm/filemap.c:397
>   __filemap_fdatawrite_range mm/filemap.c:430 [inline]
>   filemap_fdatawrite_range+0x120/0x180 mm/filemap.c:448
>   btrfs_fdatawrite_range+0x53/0xe0 fs/btrfs/file.c:3794
>   btrfs_direct_write+0x558/0xb40 fs/btrfs/direct-io.c:952
>   btrfs_do_write_iter+0x2a1/0x760 fs/btrfs/file.c:1505
>   do_iter_readv_writev+0x60a/0x890
>   vfs_writev+0x37c/0xbb0 fs/read_write.c:971
>   do_pwritev fs/read_write.c:1072 [inline]
>   __do_sys_pwritev2 fs/read_write.c:1131 [inline]
>   __se_sys_pwritev2+0x1ca/0x2d0 fs/read_write.c:1122
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f11a850bd79
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 41 1d 00 00 90 48 89 f8 48 89 =
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f11a8497158 EFLAGS: 00000212 ORIG_RAX: 0000000000000148
> RAX: ffffffffffffffda RBX: 00007f11a85916d8 RCX: 00007f11a850bd79
> RDX: 0000000000000001 RSI: 0000000020000240 RDI: 0000000000000004
> RBP: 00007f11a85916d0 R08: 0000000000000000 R09: 0000000000000003
> R10: 0000000000002000 R11: 0000000000000212 R12: 00007f11a85916dc
> R13: 000000000000006e R14: 00007ffd9dcad860 R15: 00007ffd9dcad948
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__extent_writepage_io+0x1224/0x1400 fs/btrfs/extent_io.c:1488
> Code: f7 07 90 0f 0b e8 dc 68 df fd 48 c7 c7 e0 92 2c 8c 48 c7 c6 c0 a0 =
2c 8c 48 c7 c2 80 92 2c 8c b9 d0 05 00 00 e8 9d 15 f7 07 90 <0f> 0b e8 b5 =
68 df fd 48 8b 3c 24 e8 bc 9d ff ff 48 89 c7 48 c7 c6
> RSP: 0018:ffffc900097d6ee8 EFLAGS: 00010246
> RAX: 000000000000004e RBX: 0000000000000000 RCX: 2f9fd79be1350f00
> RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> RBP: dffffc0000000000 R08: ffffffff817402ac R09: 1ffff920012fad7c
> R10: dffffc0000000000 R11: fffff520012fad7d R12: ffffea0001ccbdc8
> R13: 1ffffd40003997b9 R14: fffffffffffffffd R15: 000000000007b000
> FS:  00007f11a84976c0(0000) GS:ffff8880b9200000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005654e2821068 CR3: 0000000020e4c000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisec=
tion
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

