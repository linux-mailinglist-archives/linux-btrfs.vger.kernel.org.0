Return-Path: <linux-btrfs+bounces-8755-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2123899790D
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 01:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1199283EFD
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Oct 2024 23:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6B1F1E3785;
	Wed,  9 Oct 2024 23:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="jsFCui9R"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC8D149C4F;
	Wed,  9 Oct 2024 23:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728516097; cv=none; b=fo05pYcueYfm93fsuPENWNvGxipjxU0BdaFssZC1ExLfAi+xpBS1D/I0smQfI/rUpzrymGVqvpiPrY/ola4r1ghiBr8InhblRixgFt9/yrVZ0GmXvV/dnabdIe+QlX2ViVssMX2ZBqKHfJ1QNphZUsB1vTMUJRSv1UISS4ZFddE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728516097; c=relaxed/simple;
	bh=X0KH4/CwuHqO9smAiCBs+uTGVZ/V5G845hbsYWD8tGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=txmcKuOKys+THJCIlXHjL29L2rTS3y86exvW2llb6rAYAZ1DbNDqIU/wrvdi2I9+zgJJYOYkrsSIgOz0ijgk5F695NqDytJl4QmwfbdXiYpeu+RHcUIBMIjjIWEtWvBd03mv36EaPv3OMls9WZ3W8B3fW5IIwsECabc6PWkJJRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=jsFCui9R; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1728516085; x=1729120885; i=quwenruo.btrfs@gmx.com;
	bh=rKhCT41MBpPaV4I9O1YPe654uXl5WGRTNmD8RHCJ1vE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jsFCui9R5B0hXghRacIuUBayghe5cM0EO/x4CSoDU9YuDHmHqbA93oRCKzFPQGWu
	 qfqt3524ak+JtXLdAIN+5JeN+GlfnWpkKiOKaRb7Zs9YN26W50hmoHIuKTZEXVcm8
	 RkCezVdFLkMZlrmV16PThpQNu5C3sQ9WteHZNSHftvvWVWcwscUzFxMHA52lws8QB
	 GBrJdSQbRb6JXJMcSmOIhgMjmmxXmn2l4ImsO+J5OZfHJh53F83T/K0fXTJubvlty
	 Hjc4bDCjqy+ThCXIobxzAJM8Hioz0xVV+T7XhnFf61RQbmzhgnhOH3nON6Ex5UQg8
	 aYOKIS+wxyo+grZz1w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MCsU6-1t7VgK4A8e-00DuGF; Thu, 10
 Oct 2024 01:21:25 +0200
Message-ID: <abc5e714-53a8-4b23-be5c-966442cbb0c1@gmx.com>
Date: Thu, 10 Oct 2024 09:51:20 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [btrfs?] general protection fault in getname_kernel (2)
To: syzbot <syzbot+cee29f5a48caf10cd475@syzkaller.appspotmail.com>,
 clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <670689a8.050a0220.67064.0046.GAE@google.com>
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
In-Reply-To: <670689a8.050a0220.67064.0046.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1fla3/fpl29LZ5xjJSMWzkDUkp48wWjW+q7MFxcJZLYfaAlsH55
 5kKcfB8hgqWUvH+UzKU1pOoHCBEAmqi2YyzflrnTyJlh56UHJn52Ozp2kEACY1bpH3eGN1Q
 +fHOoyRZpjEINuk5T+ZP1RjcknyjkSrfcSd6Y6w88+LrYrmpb3CPcy2URq9d4h8aJVbAemk
 8uAIPCVaYGrROzMkSwesA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:M4fa4hT2NKs=;pXEtoiShSFWa2Z2Kxh1KNSgUnvG
 bBpQZ16EXyZoYemUp77zGFs9J/ssGyzr3k4Pgn3qiQl0g5qvjQgjH3M8zYRM/qi3Fttdi2vts
 DBP7V1AWt/+p6FVoUuxe6X8XmQ3p9DQqoKBtUuetN8lkx7JLh7HR2rrQARXQ2Y5ouXgYj/Qg6
 ms+TBQmM+MQxGEhJSdxgVS+Gu1Wsgz/rYS/TDSCywGDaIMyY6+A7VCaOClUxtSHLcWJDHE53N
 N7YKJODetAzhuLgahNZXzAq9JNsBsxLOuOwR8WyzXfTqOWTQ5cxnGExDLU1jjU+CsH84pNbzE
 Iytm3yQgjTtrc3lDX09c8/ATNJ75K8HgpdQ+cG4dN1FyPmzxT7JSH/P+UCpwarudYZYQnJXFs
 X9xOatIGBdF7r3ELWXI5PTzHVPSBk8J8LQzw7e8T4UZxtEAE7M06NaEsqxnCcfKXuVWWYvjch
 EflNze5tB07jaOTj7KxtFgPo8N9T8ff8VejsV/J3dlA69/5BHdaVhN3084q5xS56dft18+nFm
 K3UsQplkCfiiDkKlKqYOn7p7hyrcItmGNNqpxG/jegMxPMQmInVTwaYDZMUwtOIUjcfxn2d5I
 StWj9zOQWGvBda3roMl/i7ImyNJvvds+ECw/ygUpnzlrkUrjPvjJK3JJ8rUaVb+rtwNolt5JM
 UCqqL1M4Xnf1jp30TioMc0Uhy2mYttsocZ2baKhhDfrhZ8sId5OB82HQPKyEHyQWCVwz+2qwH
 n0hmeKkWYcs0eBB1z+FNuetX+PTSeSNX3fai1C7MdWTaIcU7Yy8Ti41R+toqTEB5tTsElSF2S
 lyYFr4mMpZydeJw0FcKT834g==

#syz test: https://github.com/adam900710/linux.git subpage_read

=E5=9C=A8 2024/10/10 00:18, syzbot =E5=86=99=E9=81=93:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    33ce24234fca Add linux-next specific files for 20241008
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D10df97d05800=
00
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4750ca93740b=
938d
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dcee29f5a48caf1=
0cd475
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for De=
bian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D160ce32798=
0000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D15ea77079800=
00
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ee8dc2df0c57/di=
sk-33ce2423.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/dc473c0fa06e/vmlin=
ux-33ce2423.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4671f1ca2e61/=
bzImage-33ce2423.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the com=
mit:
> Reported-by: syzbot+cee29f5a48caf10cd475@syzkaller.appspotmail.com
>
> Oops: general protection fault, probably for non-canonical address 0xdff=
ffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 0 UID: 0 PID: 5235 Comm: syz-executor338 Not tainted 6.12.0-rc2-nex=
t-20241008-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =
Google 09/13/2024
> RIP: 0010:strlen+0x2c/0x70 lib/string.c:402
> Code: 1e fa 41 57 41 56 41 54 53 49 89 fe 48 c7 c0 ff ff ff ff 49 bf 00 =
00 00 00 00 fc ff df 48 89 fb 49 89 c4 48 89 d8 48 c1 e8 03 <42> 0f b6 04 =
38 84 c0 75 12 48 ff c3 49 8d 44 24 01 43 80 7c 26 01
> RSP: 0018:ffffc90003b7f8a8 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88802c5cda00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffffffff901d3f2f R09: 1ffffffff203a7e5
> R10: dffffc0000000000 R11: fffffbfff203a7e6 R12: ffffffffffffffff
> R13: ffff888028a7e000 R14: 0000000000000000 R15: dffffc0000000000
> FS:  000055557da91380(0000) GS:ffff8880b8600000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000200000c0 CR3: 000000004fdaa000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   getname_kernel+0x1d/0x2f0 fs/namei.c:232
>   kern_path+0x1d/0x50 fs/namei.c:2716
>   is_good_dev_path fs/btrfs/volumes.c:760 [inline]
>   btrfs_scan_one_device+0x19e/0xd90 fs/btrfs/volumes.c:1484
>   btrfs_get_tree_super fs/btrfs/super.c:1841 [inline]
>   btrfs_get_tree+0x30e/0x1920 fs/btrfs/super.c:2114
>   vfs_get_tree+0x90/0x2b0 fs/super.c:1800
>   fc_mount+0x1b/0xb0 fs/namespace.c:1231
>   btrfs_get_tree_subvol fs/btrfs/super.c:2077 [inline]
>   btrfs_get_tree+0x652/0x1920 fs/btrfs/super.c:2115
>   vfs_get_tree+0x90/0x2b0 fs/super.c:1800
>   vfs_cmd_create+0xa0/0x1f0 fs/fsopen.c:225
>   __do_sys_fsconfig fs/fsopen.c:472 [inline]
>   __se_sys_fsconfig+0xa1f/0xf70 fs/fsopen.c:344
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fe8c78542a9
> Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 =
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd2c4992f8 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
> RAX: ffffffffffffffda RBX: 00007ffd2c4994c8 RCX: 00007fe8c78542a9
> RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
> RBP: 00007fe8c78c7610 R08: 0000000000000000 R09: 00007ffd2c4994c8
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffd2c4994b8 R14: 0000000000000001 R15: 0000000000000001
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:strlen+0x2c/0x70 lib/string.c:402
> Code: 1e fa 41 57 41 56 41 54 53 49 89 fe 48 c7 c0 ff ff ff ff 49 bf 00 =
00 00 00 00 fc ff df 48 89 fb 49 89 c4 48 89 d8 48 c1 e8 03 <42> 0f b6 04 =
38 84 c0 75 12 48 ff c3 49 8d 44 24 01 43 80 7c 26 01
> RSP: 0018:ffffc90003b7f8a8 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88802c5cda00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffffffff901d3f2f R09: 1ffffffff203a7e5
> R10: dffffc0000000000 R11: fffffbfff203a7e6 R12: ffffffffffffffff
> R13: ffff888028a7e000 R14: 0000000000000000 R15: dffffc0000000000
> FS:  000055557da91380(0000) GS:ffff8880b8700000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005606b6327058 CR3: 000000004fdaa000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> ----------------
> Code disassembly (best guess), 1 bytes skipped:
>     0:	fa                   	cli
>     1:	41 57                	push   %r15
>     3:	41 56                	push   %r14
>     5:	41 54                	push   %r12
>     7:	53                   	push   %rbx
>     8:	49 89 fe             	mov    %rdi,%r14
>     b:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
>    12:	49 bf 00 00 00 00 00 	movabs $0xdffffc0000000000,%r15
>    19:	fc ff df
>    1c:	48 89 fb             	mov    %rdi,%rbx
>    1f:	49 89 c4             	mov    %rax,%r12
>    22:	48 89 d8             	mov    %rbx,%rax
>    25:	48 c1 e8 03          	shr    $0x3,%rax
> * 29:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax <-- trapping instr=
uction
>    2e:	84 c0                	test   %al,%al
>    30:	75 12                	jne    0x44
>    32:	48 ff c3             	inc    %rbx
>    35:	49 8d 44 24 01       	lea    0x1(%r12),%rax
>    3a:	43                   	rex.XB
>    3b:	80                   	.byte 0x80
>    3c:	7c 26                	jl     0x64
>    3e:	01                   	.byte 0x1
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


