Return-Path: <linux-btrfs+bounces-8133-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7017C97CEC9
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2024 23:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F038283B08
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Sep 2024 21:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0633E14E2E1;
	Thu, 19 Sep 2024 21:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="l+m1kET2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF3217555;
	Thu, 19 Sep 2024 21:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726781953; cv=none; b=nk65nQ1T5eUM7FlugD3iL03W7dAwokTw9sF+Io/0UGubn4XaaY8pIGvpokwKD4NEudCxlHsj5+8ktic44+svpEsJxFJZumFnx++AvIuiSaLpsD5YRQC7LwuXR7AsI/nTXh6416mxL21IS8imc8cfVP3ExEdTe+Xftz5hmZQjIts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726781953; c=relaxed/simple;
	bh=Z1I0DB/RMKlgAR+Sca7FJPazgXUu3FZUtgSVN1VZYl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=phnqrsaGq17+8fb3UkMVaQ7m7Z8ag4K6GSpM56his934Q89SvkHkwILSNdFj7iwmb0NeKmhWGvq5KNpW/hrcpnG5wH+MYJi0rC2Uvwsh1lkj9jQ7RKApxuaKobuJykQq7WIQWlJYUCfWFI921ggRvR2EwUxB/DOobbeVpETuUI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=l+m1kET2; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726781871; x=1727386671; i=quwenruo.btrfs@gmx.com;
	bh=JUowRRq74BoWX/FMn++BEqCVTyhfJXGtUi0j8Oe3jsA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=l+m1kET2MXtAb17x5JS1hbX9sig6xIUj8SMUnZZ+bi+Y4/thnfqF2d803XklPYun
	 VCDWGOKT7k+VAZPhrFXaVu7eBC9IZGms+zQ466paC561y5NaAFYY3SdOYSN5bJsv6
	 1ng8uvIwuBS5z4vdO4w5W8qWJctwWhnTXg8ljv5nKz4ZCu1FeZU8HNu1SNWOAOtak
	 Kqr0a2MbLiksme5R6tvpCeA8Ihg/yS+QzoSZKt/aSD6/0vD2DwsFnCPl89tpmFXwp
	 CZoNc0jkq0lIAx3zriw7aiEnkmFRcb2JXjBz/uZKPoxXBhaaNm0rQyJmeHBW1SKfr
	 UWAMvFdwP0M6Ao8wAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MxUnp-1s2yxD2tjd-015DXP; Thu, 19
 Sep 2024 23:37:51 +0200
Message-ID: <d2c7c140-5c07-4071-b9c3-28eab1e3f462@gmx.com>
Date: Fri, 20 Sep 2024 07:07:45 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_recover_relocation
To: syzbot <syzbot+4be543bf197a0325c7d9@syzkaller.appspotmail.com>,
 brauner@kernel.org, clm@fb.com, dsterba@suse.com,
 johannes.thumshirn@wdc.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <66ec3506.050a0220.29194.002b.GAE@google.com>
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
In-Reply-To: <66ec3506.050a0220.29194.002b.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pHahqHlZCg7fBIY8ZT7XfpcoAQQRHcvFb2lB6jfsGGutIFRCqEF
 xXmAnXmb8K6Uogce61Y820NtpESLC6mjf+j+0nGKE8tuFdBnQEMZmmNlhzBE9psGi3BWrvJ
 pv2tO5tro6MI7AQyR+AfqBSM+aLMxb0jq2ypVEKJkCVsGr2ymi/SagrBr/JOUtWwOAlNDd3
 BaDheXk3qSNYPeUaGOsbA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3PArxUoVe8c=;9TYgWCW96Z+eDEgxJ2P4xjDqRp1
 ufMDuveZ03KIQMgzSuHNIf4XdQ2ijCbm5U902EWeyvpQMRwyAoKnBEit7H4ueJdVhiMwlLxfN
 qwiBsjTRD/lG0nUQZq+XgESbBVGS1Wp92IVj9cOSS8bmayKBvT/gLRrAZCgxdCoV7I7aeN9J5
 Bsg4YTO4hrvE3svhiLODlOy8PUjoAYjNTYFAVFEgUf1LpIPG2KFiWo0gboU1u7W3hT8GXjuVd
 BdHzPSZ/Syzn4VW2jcPYxZHrRvgwMdLFfR2ef6+DALtmCYPmhgt3AilZA6nJcSWpmqb8n4JRj
 BpL06kxc9Qi0oL9Pvu9RFhAovOzjYPxWwwbRlXTg09ssMPXFbLqx4TPg6qyniCEoep/ft1uVS
 3SVDkhS8HkbUImURFI4NgXGH1mpUpBCoYsYKJ0L9UgGOUtPp8KMZ4A1BPbwKFfxRIx+XmcN1I
 zTBboBDL0wu2e9dsAYetpc3yg3NGj1etCFXTPz2xbAeeaJKvwc6cc5D9a5Yk+3z0NBJxe0Wv8
 7GV+xaIGSAFQ+zhpE5uSFD+dNF6GNDHy39di2fEHpBJT2mO9NCITT79scwo5WVIBd1xd5dGfT
 ktIHBqKlGuXLS/+8ML9SYw+tjRwu6wsq5ej7EFGnsxQmxLimHwZuQDdY5HCRuguNaOK1+aIuw
 /ipwQDgAIQsmn07A8YxY/OLq8hko4QTciWhEFCTH2MZgGFtsh0DICY0Aq4n/pcFtItVuUfcM7
 wXL5AW1mRo2Nyo+EBYt8Os2grJfGs5pciCq+sgzufGZWvv2fDRr+UwYDQZ1+lehfpmb9+OHoR
 2I62h+XaDZJSAVWMLYZCj6feKG9btMlEYv4uIYaGW3/AM=

#syz test: https://github.com/adam900710/linux.git syzbot_rorw

=E5=9C=A8 2024/9/19 23:58, syzbot =E5=86=99=E9=81=93:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    d42f7708e27c Merge tag 'for-linus-6.11' of git://git.ker=
ne..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D141de4079800=
00
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1c9e29688003=
9df9
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D4be543bf197a03=
25c7d9
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for De=
bian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D125748a998=
0000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D14440c9f9800=
00
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b879ea3b7dd4/di=
sk-d42f7708.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/812a7fb7bfcc/vmlin=
ux-d42f7708.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/806a22d4adbf/=
bzImage-d42f7708.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/06797c3a4=
d01/mount_0.gz
>
> The issue was bisected to:
>
> commit ad21f15b0f795daf8723dddbcb61797d4f1c2aed
> Author: Josef Bacik <josef@toxicpanda.com>
> Date:   Wed Nov 22 17:17:50 2023 +0000
>
>      btrfs: switch to the new mount API
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D177254079=
80000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D14f254079=
80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D10f254079800=
00
>
> IMPORTANT: if you fix the issue, please add the following tag to the com=
mit:
> Reported-by: syzbot+4be543bf197a0325c7d9@syzkaller.appspotmail.com
> Fixes: ad21f15b0f79 ("btrfs: switch to the new mount API")
>
> BTRFS info (device loop0 state MC): resize thread pool 2097158 -> 4
> assertion failed: fs_root, in fs/btrfs/relocation.c:4375
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/relocation.c:4375!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 1 UID: 0 PID: 5226 Comm: syz-executor261 Not tainted 6.11.0-rc7-syz=
kaller-00151-gd42f7708e27c #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =
Google 08/06/2024
> RIP: 0010:btrfs_recover_relocation+0x1b6f/0x1ba0 fs/btrfs/relocation.c:4=
375
> Code: 40 d1 fd eb 05 e8 c1 40 d1 fd 48 c7 c7 60 51 2d 8c 48 c7 c6 e0 52 =
2d 8c 48 c7 c2 e0 51 2d 8c b9 17 11 00 00 e8 02 ce eb 07 90 <0f> 0b e8 9a =
40 d1 fd 48 c7 c7 60 51 2d 8c 48 c7 c6 00 52 2d 8c 48
> RSP: 0018:ffffc900033e76a0 EFLAGS: 00010246
> RAX: 0000000000000038 RBX: ffff88802918c048 RCX: 8c13e04592c8c800
> RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> RBP: ffffc900033e7830 R08: ffffffff8174016c R09: fffffbfff1cba0e0
> R10: dffffc0000000000 R11: fffffbfff1cba0e0 R12: dffffc0000000000
> R13: 0000000000000000 R14: ffffc900033e77a0 R15: ffff888027a8d160
> FS:  000055557fadc380(0000) GS:ffff8880b8900000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000200011c8 CR3: 00000000693e0000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   btrfs_start_pre_rw_mount+0xe15/0x1300 fs/btrfs/disk-io.c:3048
>   btrfs_remount_rw fs/btrfs/super.c:1309 [inline]
>   btrfs_reconfigure+0xae6/0x2d40 fs/btrfs/super.c:1534
>   btrfs_reconfigure_for_mount fs/btrfs/super.c:2020 [inline]
>   btrfs_get_tree_subvol fs/btrfs/super.c:2079 [inline]
>   btrfs_get_tree+0x918/0x1920 fs/btrfs/super.c:2115
>   vfs_get_tree+0x90/0x2b0 fs/super.c:1800
>   do_new_mount+0x2be/0xb40 fs/namespace.c:3472
>   do_mount fs/namespace.c:3812 [inline]
>   __do_sys_mount fs/namespace.c:4020 [inline]
>   __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:3997
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7efc59f9fed9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 =
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fff486e20c8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007efc59f9fed9
> RDX: 0000000020001240 RSI: 0000000020001200 RDI: 00000000200011c0
> RBP: 00007efc5a0195f0 R08: 0000000000000000 R09: 000055557fadd4c0
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fff486e20f0
> R13: 00007fff486e2318 R14: 431bde82d7b634db R15: 00007efc59fe903b
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:btrfs_recover_relocation+0x1b6f/0x1ba0 fs/btrfs/relocation.c:4=
375
> Code: 40 d1 fd eb 05 e8 c1 40 d1 fd 48 c7 c7 60 51 2d 8c 48 c7 c6 e0 52 =
2d 8c 48 c7 c2 e0 51 2d 8c b9 17 11 00 00 e8 02 ce eb 07 90 <0f> 0b e8 9a =
40 d1 fd 48 c7 c7 60 51 2d 8c 48 c7 c6 00 52 2d 8c 48
> RSP: 0018:ffffc900033e76a0 EFLAGS: 00010246
> RAX: 0000000000000038 RBX: ffff88802918c048 RCX: 8c13e04592c8c800
> RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> RBP: ffffc900033e7830 R08: ffffffff8174016c R09: fffffbfff1cba0e0
> R10: dffffc0000000000 R11: fffffbfff1cba0e0 R12: dffffc0000000000
> R13: 0000000000000000 R14: ffffc900033e77a0 R15: ffff888027a8d160
> FS:  000055557fadc380(0000) GS:ffff8880b8900000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000556f055030d8 CR3: 00000000693e0000 CR4: 00000000003506f0
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

