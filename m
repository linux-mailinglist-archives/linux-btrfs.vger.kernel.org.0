Return-Path: <linux-btrfs+bounces-8759-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04247997A89
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 04:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50DC1F232BA
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 02:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A987E13C682;
	Thu, 10 Oct 2024 02:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="EEJWYjz+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED945B646;
	Thu, 10 Oct 2024 02:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728527220; cv=none; b=Whk/5ixfAlHReZfXellzeVxHcs4xcZPlFxjZFh249lMCBBMfp/H290M1czrA4RpQ7p8467bEvs+MT9W1lkiG1IbxPka8VswSISWdPHLrBB5WL+JA+GMqLVeLoeMZ5+BRkXZGfgWkPJ/hQE4XEDVU2rPtiRW3CopYExXR2FGswq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728527220; c=relaxed/simple;
	bh=yHTCyPtB7aB5w7yQGpRe/hFuGSYH5sf1GGfi7FDqnDY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=LFzflhrSJ6XuPB4ix3BSZXlXjEwBtXmGfa+6mXJY6XNqbEbgXHy51GMpnoVjZEtO4Mu+m5HlOZW7cXWE7gajclg/rzdMVz7SDkycXBgne3hS5asvm43oTTsNfbzyMeC9bavUXUOFDCRCkbOKmxCv/S1yA0jnmd3bgq7/r3FUGDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=EEJWYjz+; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1728527209; x=1729132009; i=quwenruo.btrfs@gmx.com;
	bh=HtMTySAOLMgOVHK+fH1MTzCna1oSLokVcWbVlYMvWeg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EEJWYjz+iLxa/GgQ9tjCdvdWg1YhJZYoYa95+DTVZmVQ/u0cHzFTfLme2nchpEca
	 iF/yDVJf57y+O4m4FwFRd9iKBh32LvFf/lAs1Z7MuzPEpKeq/ybtiSVC+/3UoIrSt
	 puIQ2LF1E0g18XzVqDdia2BPVWfcxtv7Dy/A797Ecuw3MTjyLzM2OWgXUquYGnpX9
	 SdXr/Fl2unVCTIAKnmWzhhNocubD/OCO/QTLB40AM7auDgk1qE3Jo3s3qELc+fSz8
	 XxwNsBXwu/bxdqM/GMADC0fB0ve0q4cj1lRj4AUiWone2MWFIWwdg0xMMo45PXGkq
	 zBbT9mYqfXa1ySETRg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MAfUo-1t9gAb0yc4-00AnPb; Thu, 10
 Oct 2024 04:26:49 +0200
Message-ID: <11876ca8-6104-4f67-a7ac-c1dd7e9a39e0@gmx.com>
Date: Thu, 10 Oct 2024 12:56:45 +1030
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
References: <67071fcf.050a0220.1139e6.0013.GAE@google.com>
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
In-Reply-To: <67071fcf.050a0220.1139e6.0013.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8/3zr9Y/Ap0JutxjQ2Kw/bQgH8DoBUay0LOsnOBz0StFbGSBoaJ
 wKiB3gEyWTHv1RmaDrEUnC0eN93mAfgoC+UPUtYy3l/RTKW8nW0DRh83FOzMZSft7hnF/C0
 vaduZv0YRkIXAIXTyspYah8ep/v6sheJF3BX7GpbZvZt2f35e2cCc3IFUFWzSA2C2e7EiKH
 PD+OoJpWGMrW0VF2QG/ag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MkaLcf/Sau8=;xRRsg1tguyk/ECGGeBW+W6rA7At
 hSr30WXrsMp/PRyrt96ERui+jhkiL5iWp/JwQLmnVpgfsufm6mxC8mg0LeOOwmHO0Di45Awvn
 mYF6LzVWNN9QDAl97+Cdwp5QRTz41fZHgfEK0sEivSv/9dlkj1B0JpQ3ybMjRMlirdpwyLaFo
 mFDlMpbjQYPIlEqR06uBbe/c8UBOb3jZ/qcJBZpY79hhNkiYUx5AokNVyRoTC/FSzORXx8v8C
 +Qd5uNlLnahxeLNubDz0oasrO9FSd/LUBPuo9C+S5Kc9TaBFcvQOwH7YU7Ufa/txc/VqVJ8dp
 E29+KSgyVfRH1LzOSb7WION4+QtJ7TX0qM2NlbOR7rU/k1c2l7LN5FsHTEovGavRGaRhN4OGQ
 8XvrU25fOOwGebRihHMHORi9O5zv9/w7SMcNp+dF1k9AzC8U1tQuqVmzzJn+SwL2o5YfRtdq+
 qgrZnJHyXhvcfxfkEUe9V9/NP++9SUiMFrSPxgbbYMqg5dVmZZ59preWudHutCo679aOKriWe
 u4sL7LxaKbeUDPCGat0t/RnfyklwupSsyOkgPHYIrY6AP4woFWBNlgNW4HgcXJeHa+Xsb3OLd
 C54AxQxTpDMdg9LTgam+4F5feRas8NecIfwVp/+NNnmHMo8f5a5v0kc66AxPT6lKBErXDU8nl
 tXyBNuDG9xXv1k2c/QdIck2RIhgGfTQGZb0CfAijj2g99qF1xikoDVz7ipbUHFhIM7bV5OE4n
 arg2GZCoSxZ4k/xaPD/qz2OyTBjRuWLz8oqWOmqeTQboY0dOaFpOPMEPvmACmaALgLVzjm2ob
 qRA9o1o6Cu7PVA9KaYP48WsFtVi9d/8e74DgjZvlvm54A=

#syz test: https://github.com/adam900710/linux.git subpage_read

=E5=9C=A8 2024/10/10 10:59, syzbot =E5=86=99=E9=81=93:
> Hello,
>
> syzbot has tested the proposed patch but the reproducer is still trigger=
ing an issue:
> general protection fault in getname_kernel
>
> Oops: general protection fault, probably for non-canonical address 0xdff=
ffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 1 UID: 0 PID: 6008 Comm: syz.0.15 Not tainted 6.12.0-rc2-syzkaller-=
00045-g964c2da72390 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =
Google 09/13/2024
> RIP: 0010:strlen+0x2c/0x70 lib/string.c:402
> Code: 1e fa 41 57 41 56 41 54 53 49 89 fe 48 c7 c0 ff ff ff ff 49 bf 00 =
00 00 00 00 fc ff df 48 89 fb 49 89 c4 48 89 d8 48 c1 e8 03 <42> 0f b6 04 =
38 84 c0 75 12 48 ff c3 49 8d 44 24 01 43 80 7c 26 01
> RSP: 0018:ffffc900035af8a8 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88802d46bc00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffffffff942c58f7 R09: 1ffffffff2858b1e
> R10: dffffc0000000000 R11: fffffbfff2858b1f R12: ffffffffffffffff
> R13: ffff8880727f8000 R14: 0000000000000000 R15: dffffc0000000000
> FS:  00007f01495d76c0(0000) GS:ffff8880b8700000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2f75ffff CR3: 000000002cffe000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   getname_kernel+0x1d/0x2f0 fs/namei.c:232
>   kern_path+0x1d/0x50 fs/namei.c:2716
>   is_good_dev_path fs/btrfs/volumes.c:760 [inline]
>   btrfs_scan_one_device+0x19e/0xd90 fs/btrfs/volumes.c:1492
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
> RIP: 0033:0x7f014877dff9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 =
f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f01495d7038 EFLAGS: 00000246 ORIG_RAX: 00000000000001af
> RAX: ffffffffffffffda RBX: 00007f0148935f80 RCX: 00007f014877dff9
> RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
> RBP: 00007f01487f0296 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007f0148935f80 R15: 00007ffe7a9c13b8
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:strlen+0x2c/0x70 lib/string.c:402
> Code: 1e fa 41 57 41 56 41 54 53 49 89 fe 48 c7 c0 ff ff ff ff 49 bf 00 =
00 00 00 00 fc ff df 48 89 fb 49 89 c4 48 89 d8 48 c1 e8 03 <42> 0f b6 04 =
38 84 c0 75 12 48 ff c3 49 8d 44 24 01 43 80 7c 26 01
> RSP: 0018:ffffc900035af8a8 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffff88802d46bc00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffffffff942c58f7 R09: 1ffffffff2858b1e
> R10: dffffc0000000000 R11: fffffbfff2858b1f R12: ffffffffffffffff
> R13: ffff8880727f8000 R14: 0000000000000000 R15: dffffc0000000000
> FS:  00007f01495d76c0(0000) GS:ffff8880b8700000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000001b2f75ffff CR3: 000000002cffe000 CR4: 00000000003526f0
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
> Tested on:
>
> commit:         964c2da7 btrfs: make buffered write to copy one page a..
> git tree:       https://github.com/adam900710/linux.git subpage_read
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1296b7d05800=
00
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D3ec5955a0d4f=
6ede
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dcee29f5a48caf1=
0cd475
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for De=
bian) 2.40
>
> Note: no patches were applied.


