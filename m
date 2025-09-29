Return-Path: <linux-btrfs+bounces-17276-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1887BAAAE2
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Sep 2025 00:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37BD13A5AC6
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Sep 2025 22:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 930D6219301;
	Mon, 29 Sep 2025 22:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="KR/o7vNU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B6B72634;
	Mon, 29 Sep 2025 22:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759184112; cv=none; b=a6UfkkCexJIzUWWnBTI6vwWwpC7zra/xvHmysQjWdCgOkdIoiBr5Oq7ExXxqmIHsEoRQjlxi5Pyhe0G92M88UkAMZCn2EAxPqef5iW6N/P9qUxGU3rQyIztm/HJflRdMj1qgq9lvynAfaBYj07IU782Z6I+iC31QaHurljBIL34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759184112; c=relaxed/simple;
	bh=5szxmqo/fkrwLcwmX7mxHJpY9jyPpATtvDMSRF9h/cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B2b+eDuybNsjaVuxKYlozYxR42XpBfaqFiyqoXkplaw81FfBlymcVXfL1vSqSuFODyznbUFz3/iw/2VDJh395IOZ4+j5KZnojLBmfkj2jJAsVEs4UVjcIsnFFBZumjWFtbPwmc2e+pAqKMfsIIn/+VdKn5LuaPpYRq9M82J6Xa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=KR/o7vNU; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1759184105; x=1759788905; i=quwenruo.btrfs@gmx.com;
	bh=G8sSDafkoQSM9p6E+eId93MLNAw5f0+5zb5pIFSXrVU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KR/o7vNUIyBelBeEcER1zbDCMJLb3Tx1YZjJ1Cy6Uv+ZujgAI5FaoDflKG0nfZXt
	 g9w1bcbnr63eP+DwgNMdPRo7AdkJTmVPch/yFyTZNYD2B+LqKy18plLieNQRLDWfu
	 K+8hfSMTS6m9mZKv3NXNFfhSOssymQrV2c9SwJmBGrlbVIOxxJ9k22pPMuZ5SzWsU
	 lZgpFWsqyrPXq6UqS2EMhJqIwc2HXnXTvtUkWc3zhx4hEqGSnvl6Gc7GWmROhPm7L
	 +vI3lDVAo5im4Oj5IqiWSvWBInyouYvfmq9pVV8ZCc9h1W/gDDoT2FQ7PTgCDhQgZ
	 99iprTqASwhHux0YtQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MWics-1uo5NQ2F9U-00T3Xv; Tue, 30
 Sep 2025 00:15:05 +0200
Message-ID: <f2da155c-bc9c-4612-99fe-e0e6d074aa78@gmx.com>
Date: Tue, 30 Sep 2025 07:44:59 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [btrfs?] kernel BUG in scrub_stripe_get_kaddr
To: syzbot <syzbot+bde59221318c592e6346@syzkaller.appspotmail.com>,
 clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <68dae1e2.050a0220.1696c6.001f.GAE@google.com>
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
In-Reply-To: <68dae1e2.050a0220.1696c6.001f.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yFys884rN+JdFAkdmJt7uref926bftdJjAPlx2iZGRCtufDXvxf
 IoVxYBNkA6wHkMatA//NsAKGYSpkXOasLpV5dMp2ePPr3smthVwxT9hJiajWOo87/FYZPi0
 kbZD325MbBFwm5prJlG2ivC6ddjKzWMOMqapsx9GPQ+JM8zyGDFhHLr2xlegRuInm6yCQfz
 0CnNcP8yph143NiD9+pXw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pcdcWn8vYDs=;v7NPfXAt8swELilwLdMl4A7EY/d
 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



=E5=9C=A8 2025/9/30 05:15, syzbot =E5=86=99=E9=81=93:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    262858079afd Add linux-next specific files for 20250926
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1562cae25800=
00
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6117d7eea7e1=
f3a7
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dbde59221318c59=
2e6346
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b79=
76-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D137abf1258=
0000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1277f1425800=
00
>=20
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/818c8ba6ac53/di=
sk-26285807.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/da143e1d7f10/vmlin=
ux-26285807.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b73ae95dc148/=
bzImage-26285807.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/27e0b3290=
872/mount_1.gz
>    fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=3D14=
77f142580000)
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the com=
mit:
> Reported-by: syzbot+bde59221318c592e6346@syzkaller.appspotmail.com
>=20
> BTRFS info (device loop0): force clearing of disk cache
> BTRFS info (device loop0): enabling auto defrag
> BTRFS info (device loop0): max_inline set to 0
> BTRFS info (device loop0): scrub: started on devid 1
> assertion failed: !folio_test_partial_kmap(folio) :: 0, in fs/btrfs/scru=
b.c:697

This is caused by the config CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP=3Dy, which=
=20
forces every folio_test_partial_kmap() to always return true.

I'm not sure how this config would help in the real world, especially=20
for cases where we can control the folio being allocated, and on 64bits=20
systems where kmap_local*() is just no-op.

Anyway I'll change all those folio_test_partial_kmap() usages in=20
ASSERT()s to folio_test_highmem() directly.

Thanks,
Qu
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/scrub.c:697!
> Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
> CPU: 0 UID: 0 PID: 6077 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(=
full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =
Google 08/18/2025
> RIP: 0010:scrub_stripe_get_kaddr+0x1bb/0x1c0 fs/btrfs/scrub.c:697
> Code: 0f 0b e8 b8 14 db fd 48 c7 c7 60 8d ef 8b 48 c7 c6 a0 9f ef 8b 31 =
d2 48 c7 c1 20 8e ef 8b 41 b8 b9 02 00 00 e8 86 58 42 fd 90 <0f> 0b 0f 1f =
00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
> RSP: 0018:ffffc9000354f0d0 EFLAGS: 00010246
> RAX: 000000000000004f RBX: ffff88805bfa0010 RCX: f481606445f80d00
> RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> RBP: 000000000000000c R08: ffffc9000354ede7 R09: 1ffff920006a9dbc
> R10: dffffc0000000000 R11: fffff520006a9dbd R12: dffffc0000000000
> R13: dffffc0000000000 R14: ffff88805bfa0010 R15: 000000000000000c
> FS:  000055556411a500(0000) GS:ffff8881259fc000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f34bfdf2b60 CR3: 000000007537c000 CR4: 00000000003526f0
> Call Trace:
>   <TASK>
>   scrub_bio_add_sector fs/btrfs/scrub.c:932 [inline]
>   scrub_submit_initial_read+0xf21/0x1120 fs/btrfs/scrub.c:1897
>   submit_initial_group_read+0x423/0x5b0 fs/btrfs/scrub.c:1952
>   flush_scrub_stripes+0x18f/0x1150 fs/btrfs/scrub.c:1973
>   scrub_stripe+0xbea/0x2a30 fs/btrfs/scrub.c:2516
>   scrub_chunk+0x2a3/0x430 fs/btrfs/scrub.c:2575
>   scrub_enumerate_chunks+0xa70/0x1350 fs/btrfs/scrub.c:2839
>   btrfs_scrub_dev+0x6e7/0x10e0 fs/btrfs/scrub.c:3153
>   btrfs_ioctl_scrub+0x249/0x4b0 fs/btrfs/ioctl.c:3163
>   vfs_ioctl fs/ioctl.c:51 [inline]
>   __do_sys_ioctl fs/ioctl.c:597 [inline]
>   __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f2f5d78eec9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 =
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffef70163e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007f2f5d9e5fa0 RCX: 00007f2f5d78eec9
> RDX: 0000200000000000 RSI: 00000000c400941b RDI: 0000000000000004
> RBP: 00007f2f5d811f91 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f2f5d9e5fa0 R14: 00007f2f5d9e5fa0 R15: 0000000000000003
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:scrub_stripe_get_kaddr+0x1bb/0x1c0 fs/btrfs/scrub.c:697
> Code: 0f 0b e8 b8 14 db fd 48 c7 c7 60 8d ef 8b 48 c7 c6 a0 9f ef 8b 31 =
d2 48 c7 c1 20 8e ef 8b 41 b8 b9 02 00 00 e8 86 58 42 fd 90 <0f> 0b 0f 1f =
00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
> RSP: 0018:ffffc9000354f0d0 EFLAGS: 00010246
> RAX: 000000000000004f RBX: ffff88805bfa0010 RCX: f481606445f80d00
> RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
> RBP: 000000000000000c R08: ffffc9000354ede7 R09: 1ffff920006a9dbc
> R10: dffffc0000000000 R11: fffff520006a9dbd R12: dffffc0000000000
> R13: dffffc0000000000 R14: ffff88805bfa0010 R15: 000000000000000c
> FS:  000055556411a500(0000) GS:ffff888125afc000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000556796dbd950 CR3: 000000007537c000 CR4: 00000000003526f0
>=20
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
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


