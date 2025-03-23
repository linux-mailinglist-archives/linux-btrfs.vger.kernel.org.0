Return-Path: <linux-btrfs+bounces-12505-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25887A6CDF1
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Mar 2025 06:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4A261899FEB
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Mar 2025 05:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAF4201032;
	Sun, 23 Mar 2025 05:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="p4Ocjs5Y"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97BF1A83E4;
	Sun, 23 Mar 2025 05:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742709463; cv=none; b=sO0HlJMD+5Dgbr38TD5e0Mpfvzh0c9sJjtAluJQVIp2dMOWOPlaUX0Z61tsqPnLtDtlj7RDhG9tXIpjFJ8IdstYkclIngSfwXs/g9UKEKqd+p3xqT7u0mGyJsaF6CS2/ZI0CLVQnN8Io0U+mWmDViIwpOyRwxOXU/AYzuaJq3E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742709463; c=relaxed/simple;
	bh=I5LorUeqRK5ZgLET1ihSNiiPyAgGJwUxrszKXg22fno=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h/9USN8SaV1f5wFTLE1VoTrg55U/K6XnfVNhuVJW4J6dDbalF7aL8+Se4kZVrqVRU8Pe2G+bbPNO5Lvu0Ugh2SKME8o5BQJlEA4AGcQnqFED0QdPlM7zmgjPXpO/H9MLOeVx5X3+GanMb/UwAB0VS7BoLRJIMb9xD59a0Eil3u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=p4Ocjs5Y; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1742709455; x=1743314255; i=quwenruo.btrfs@gmx.com;
	bh=zJrgur2bLCUpJnwvCcOkXwr1zL3rQuUqkq5DAM/eT0g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=p4Ocjs5Y2wQduixqcLbexsFKdHpbXHNPkIuifLvAQhgnNoKkHn/ggbIcOctVF642
	 KFQc52svldc+dGeW5eJCK80AwBJT4BOA+fDiwd+zaV4Ay7vAS+tE1637JtZBaIiRc
	 qPaWuwzUFmTWWpOAvhwGQaAEu/+HVGMuya6xlpxdNa+D6R95SRwcKIhndfiwjLH90
	 0hqnoAfwCiKLS1UdjYkrs+3uqq3tiX8BkIXCsdOI+WKFkdLlGCMvZx5K3UwX9sOfQ
	 yD8uB+/YZ6V3O2BYEn7UvwN3uuDfo1PbwGZ71O5UyyD8nne2hXFwMuKixdE8NH8E7
	 0pLzn28Uu8ZJ1nouKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWRRT-1tg46n2Ok7-00LewZ; Sun, 23
 Mar 2025 06:57:35 +0100
Message-ID: <03e95a73-6c8a-47b0-9b72-c1204118be47@gmx.com>
Date: Sun, 23 Mar 2025 16:27:29 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] kernel BUG in close_ctree
To: syzbot <syzbot+2665d678fffcc4608e18@syzkaller.appspotmail.com>,
 clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <0000000000003f315b05ee1ed3f4@google.com>
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
In-Reply-To: <0000000000003f315b05ee1ed3f4@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1Ad3oexN5BreABQ8hxFi2lEHIqe3EJopf9O3ZShUJW1HpFGA+yk
 zpO/VoT4Z/pT/o3BZY+iXJ13oMFB3e8EgoxGVuAPZubWO9HIbhHWFPWn/tFstwTsnN5gzW/
 lR47df6CMaN0KCprCiIQtyh/+pcluXRm2BDsiSg8j2JufHKG4HOjU0TS2vk9F+3cI2L4HGl
 qFGHnPNpXaGrRaobHabMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:L/2KmM2BNUE=;xvtMzM3MkRxOE0Pg2xNG1mr0HXw
 +CTW6IwB07CkgOTD/TqOtfTRBvV2EkY5dSBOjPHEr/MqPczIT2oQMdxOUxvVvhFawMU3KVmDI
 71rSmEWQkOhcGa/uMEPsZVDPO5BLB2BMBUafvn6U6PYuGHISQn7YCeT/YnX5cYehKHFWpAigO
 d2btVcQ0CgtVKWdeLVFvwPZASDjlHVcyKb9QlR0FUvy/UlGm78w2VYP4AGujCMYUWCJc5hc62
 1TTXDzK/p0ur3pSWi0qHzROil5yXiqNSuXHRSoHiGSN/nSPcI60y5RFVeqB5t4zgWtgZN5lc/
 6GNf2qGdTGxpKdBOA+a+FGO1qHDeCzYm7rKViV3x7u7Jj5aGqrGTfWVGcPdhjsNOATwfCa1dN
 yk7AB1lRUhYI9ybgJJO4jd/d+ij73+7atLtyTHWovnDtCni6cWawN16CGfGpaJIaQv1CBn9Ue
 dIFWIMP155PWmzacttWrHsqvamX25tmEIsajDI5oBFem0Ig6Sr0p/AbAer7XDuQ6uPk24omIO
 xwnswB9s8Dvoox2BJ/WnlyrMsqgWNxn5mecwpYa2mvWcKB4lrJ4tfWAFgSbypNcOt86dAWw1k
 mXuEx8JjVwQMeYZODsgr7p7oM2NPl37+QTzx3rgTLvpbKu9D2eaWD9fRHg+BEErfBO5BDFMYT
 5RTsnRFLBiFoPSOzblmWkZgX06JBxeNd7x/haBt9do3YmG5s0CJHgpLMOAHIdXugUOMy6N8fH
 c4lQ0S1KAJBDRcivfNPGZP1L57eqNJG+OvwDSSJ/M4U7PnzNUC4kkbqj7xWYbDJFG1PZc5Oqv
 /jDiu5x6SUA6OGaqh3V7Ai5GsUZGtOJdGyv6La9e0h9Mw+NO9QYZ8/XAx1LZHrZoCF9tm4RzJ
 fix56KOFtANsftREhoUslXkxzFcpS9RDaZ5/0AqwmF7zPDLyKZUm3jmI33jWJUDacx69pLMBG
 McTXA5Ar9k/W05v0AYLbetN3roUrXXYDsRQxBMype5QxYt5KgP0No10Elp/UVEoEM8LxsPzNE
 S9EU2sGOb4EkyUmczxHgMU0865+jYqT2/HuAwzeCy557a6rpWq4Uo/GLyAG+j2q/rl0wYlHOc
 w5zuf0FUPXjEzaVzPWpiBpmohEEcVNswJd/5mwQ3LVBvNLjmdO7Yam0NxUSZ9jBWO5YLLeyx+
 qED+kt7FinagubMfjdxaRg5pK35ICKansmDrn9pUyskNNp0p9E2+PUnzWWpnmtliMoz/uywAL
 EabHUL8gaW8tX9bh9hLRKC9evGRPQY6NnoPTejaBUtNEOuxG0jdUk03TpcEgVgauyjuh7/yP6
 QTCNISycQe/c7+qc64QsCCwpPDdZ3vhnVHUqB7FCe8jGzhaBVT3V95FUJswpGrdwhiZBKb3op
 IH33EgbjU5AHfKFFBriKmQfiVegXcdYk8cXY1X9NnOksQvuk47ZUUXn2b1Vn00cy64iBqxI6N
 dvVf8s4OLrnbBFSUv1JHooFr8cRvZLvVUgW9AgimDDDYTvCmw

#syz test: https://github.com/btrfs/linux.git for-next


=E5=9C=A8 2022/11/23 18:40, syzbot =E5=86=99=E9=81=93:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    eb7081409f94 Linux 6.1-rc6
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D17e5b3098800=
00
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D5db36e7087dc=
ccae
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D2665d678fffcc4=
608e18
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binut=
ils for Debian) 2.35.2
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/12e9c825ff47/di=
sk-eb708140.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/107e5e091c9e/vmlin=
ux-eb708140.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/605ab211617d/=
bzImage-eb708140.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the com=
mit:
> Reported-by: syzbot+2665d678fffcc4608e18@syzkaller.appspotmail.com
>
> assertion failed: list_empty(&fs_info->delayed_iputs), in fs/btrfs/disk-=
io.c:4664
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/ctree.h:3713!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 3696 Comm: syz-executor.2 Not tainted 6.1.0-rc6-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS =
Google 10/26/2022
> RIP: 0010:assertfail.constprop.0+0x27/0x29 fs/btrfs/ctree.h:3713
> Code: 3f c9 f7 41 54 41 89 f4 55 48 89 fd e8 a2 3f c9 f7 44 89 e1 48 89 =
ee 48 c7 c2 60 a4 95 8a 48 c7 c7 a0 a4 95 8a e8 00 76 f5 ff <0f> 0b e8 82 =
3f c9 f7 e8 8d 3d 15 f8 be 73 04 00 00 48 c7 c7 40 a5
> RSP: 0018:ffffc90003727be8 EFLAGS: 00010282
> RAX: 0000000000000051 RBX: ffff888027d9c000 RCX: 0000000000000000
> RDX: ffff88804a6b6280 RSI: ffffffff8164973c RDI: fffff520006e4f6f
> RBP: ffffffff8a95dac0 R08: 0000000000000051 R09: 0000000000000000
> R10: 0000000080000000 R11: 0000000000000000 R12: 0000000000001238
> R13: 0000000000000000 R14: 0000000000000000 R15: ffff88801da29200
> FS:  0000555555bec400(0000) GS:ffff8880b9a00000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f17654d56be CR3: 0000000031a82000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   close_ctree+0x502/0xdc7 fs/btrfs/disk-io.c:4664
>   generic_shutdown_super+0x158/0x410 fs/super.c:492
>   kill_anon_super+0x3a/0x60 fs/super.c:1086
>   btrfs_kill_super+0x3c/0x50 fs/btrfs/super.c:2441
>   deactivate_locked_super+0x98/0x160 fs/super.c:332
>   deactivate_super+0xb1/0xd0 fs/super.c:363
>   cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1186
>   task_work_run+0x16f/0x270 kernel/task_work.c:179
>   resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
>   exit_to_user_mode_loop kernel/entry/common.c:171 [inline]
>   exit_to_user_mode_prepare+0x23c/0x250 kernel/entry/common.c:203
>   __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
>   syscall_exit_to_user_mode+0x1d/0x50 kernel/entry/common.c:296
>   do_syscall_64+0x46/0xb0 arch/x86/entry/common.c:86
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f7827a8d5f7
> Code: ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 0f 1f 44 00 00 31 f6 e9 =
09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffeef557068 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007f7827a8d5f7
> RDX: 00007ffeef55713c RSI: 000000000000000a RDI: 00007ffeef557130
> RBP: 00007ffeef557130 R08: 00000000ffffffff R09: 00007ffeef556f00
> R10: 0000555555bed8b3 R11: 0000000000000246 R12: 00007f7827ae6b46
> R13: 00007ffeef5581f0 R14: 0000555555bed810 R15: 00007ffeef558230
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:assertfail.constprop.0+0x27/0x29 fs/btrfs/ctree.h:3713
> Code: 3f c9 f7 41 54 41 89 f4 55 48 89 fd e8 a2 3f c9 f7 44 89 e1 48 89 =
ee 48 c7 c2 60 a4 95 8a 48 c7 c7 a0 a4 95 8a e8 00 76 f5 ff <0f> 0b e8 82 =
3f c9 f7 e8 8d 3d 15 f8 be 73 04 00 00 48 c7 c7 40 a5
> RSP: 0018:ffffc90003727be8 EFLAGS: 00010282
> RAX: 0000000000000051 RBX: ffff888027d9c000 RCX: 0000000000000000
> RDX: ffff88804a6b6280 RSI: ffffffff8164973c RDI: fffff520006e4f6f
> RBP: ffffffff8a95dac0 R08: 0000000000000051 R09: 0000000000000000
> R10: 0000000080000000 R11: 0000000000000000 R12: 0000000000001238
> R13: 0000000000000000 R14: 0000000000000000 R15: ffff88801da29200
> FS:  0000555555bec400(0000) GS:ffff8880b9b00000(0000) knlGS:000000000000=
0000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fd78dea19d8 CR3: 0000000031a82000 CR4: 00000000003506e0
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
>


