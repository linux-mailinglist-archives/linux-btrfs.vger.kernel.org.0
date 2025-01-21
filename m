Return-Path: <linux-btrfs+bounces-11027-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC3AEA17991
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2025 09:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF5C13A98A6
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Jan 2025 08:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87E61B87F3;
	Tue, 21 Jan 2025 08:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="dvG/a/Jr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823F7192B63
	for <linux-btrfs@vger.kernel.org>; Tue, 21 Jan 2025 08:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737449525; cv=none; b=km313CEr6sNs4XZnm2+AbDNIes5u4i08a/EK6fYo3kuAsSFcdBgxaDfypbTzxJuViBhnb+88wsIt3WyEUwLh3wMuPBFV1hXlF7DtZ9oJBMvXdHkURlZN29JAJYdsiuIoCflGr7xmPlMk3Mfi0oMLefB7NJjWxif0s5P2/8Qj0Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737449525; c=relaxed/simple;
	bh=uqBnkxVDmY2WDENbNg91aLKLAv3TRTIhPWwQJAGoATM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z4gSZpWvnO7rwUKhsj+m9d3L5VqlgCcDhajPXuuvhNjOfWoQViSZp8gbWniDfrp5lh7cEPlvm/dODRxkgV0a8qYaLcXD1JUJaLiAKeHlwebdICqxlXU9kdwbU8/A8YWJ3WtfA5wIFFW/DzT+oF30zEwrrBJCyfK0XDUyK/guxtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=dvG/a/Jr; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1737449515; x=1738054315; i=quwenruo.btrfs@gmx.com;
	bh=H6L9Ta9yt2ILokwYlZy1VD0JU+d4iSO7lJcLqPENYgI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dvG/a/Jrkw7x2hsoTqV/rpCf8F5wgfKeoKrus8YXxGHcDNRBhdNpCmdhWuxVC3iD
	 V9bMFfQeBE2+TGNEvDJSMU6ibneuxcoYI8WtCB0OEw/aWk4zW7n8MPW0blk7NffzK
	 oAsU+T19xMSBL0d/kTtX6yi4hPRXWU8JF33rXToeSbtKZIoxGAulNcOhwo6YVREhu
	 GiXLvcAg3s9dCASucyH193IPhatZdJRczLoKqOewWJbESvOrCImkHqGIvnhSdqEw1
	 z9FCUy+SJ9/ZsJ++3QpGY+FyMI4Lr0Oh2KbJohA/I+xVJuUloYRVWNr4Hb+k6flZb
	 unuYp/3ErLg/crW6vg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MulqN-1tHoDo0KlH-014rQV; Tue, 21
 Jan 2025 09:51:55 +0100
Message-ID: <264a293a-409a-4a8c-999d-fd469f4adb47@gmx.com>
Date: Tue, 21 Jan 2025 19:21:52 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix use-after-free when attempting to join an
 aborted transaction
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Cc: dvyukov@google.com
References: <f81151ae971c956f9b7e496a92bb67222452aee0.1737395071.git.fdmanana@suse.com>
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
In-Reply-To: <f81151ae971c956f9b7e496a92bb67222452aee0.1737395071.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3uUMfccNAnqRKridB0Uqtn+8iuOk02JjBao38zhsye7uwdiWdqx
 3NrMT+Bxd2Exb1CF0abZumNLThFCGriJCsASVMvJDsWciRa39DsYwZS56h5rK+wQyqmWHH6
 CjhjjuyWsCVsVgZIeg/D2bHGxicr1vAJAXcSS2Mjxp+6efC6c9MSBYke9WUKrGouSvEmb/p
 Qsi2WD3/2AKi+zVNBBSng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7Jznu1i4C94=;T0kdnoqMh3JT2t1Rnfw3sg9JHgD
 BMxCl70HEKo4SX6+MiwjM8HaA39vriotAgTD7NOuVU6rEVvTss8TFqLrtDZlVSNu7UOEtfrMv
 TUCWJIn93jCIJKsEj6umioXsRbbsmNxZH6f8cWcqoWDARm745SZh9zflwm3yTWu5lcgTgRlt0
 fmf+eiT5w+ABwTYegUSeR9rIdKVVtd79hQlqbPE9JBr2TeBgvcrgL/qVsZzAeXdy/YepYxRCT
 8CgL+tpJbGWP3eMejfMp6ntT2yd+gILrGsRbysnoRcu7Yqgl+TB4ushhvu86extd2WpCwBCrx
 Nmkr6fQCqgpMRtYtzL9Lvbw/lIz7E9mzWr0hE6zij/j1VSEGUwarqlMqQgMCpwWm0exSbmd9b
 1DKza3ZL4zXH45+EyEsHG4Fz8ImBkBSdFR69ewQJGQUqsJNPuD81TwLZ15VJQ+ScUQdnPQ7vd
 th10s9dcgCP3IX7xD/adyA5uEi5N7GfHXhwgN6f0ZvDrUif5SscL5ACV7r+bDZUxwVdyniYDi
 RHpSsQOxHXPOQs/HIn6fZrFUrkt5uKHBtozwXlGo0kg/uCSh8eKihB+vBACa/exrCPJCKrmyZ
 AveIbsp3rC8syVyzbJnVb/BubF3tGtYEGBFiCadv0IH/9sP6gaQbkh0xOc3Ege6RDyEUEs4nU
 /bHLBDXe/GWr9icBH74N0hwZ6iFM/CcHmkHV06i9J/qVxu3N+DFvEr4WxDLhgz7iiS5vdG8Vr
 ROWBTmKDXh6yMOCR2wDb8G70S6q9uSa8ZxRftAcNTOAZ8X8dD6NqVWKsHK9IZvsD5gCC0lxFH
 /lkfLd7mUkn+5wUhWupNh23lNbpnFtp06itbd+v6I6XyYNtJm1bbxb3QdfbL/d6uaVYu8HqW8
 PVX+nRpBNgxIG5TLpdDSmdfh2CWIHXgwaAEdLzwcyK4u1FwXL/GuJ3NUiQaAgN84bcvxHUcHG
 zr5KK7arXfeCSap/Zv5yH5FzP0lxdxssQLovEy2m+P6uziCbA7AtdcRWGJGa+6DqxEcijfvK9
 +1Rk70745xYj9VssnqRjOgChayHyW9Y4Lhhi9bijxMjanmomPTUhcwkTs/QNCwGOYGANv7N1o
 vdU+HWd4nxKsbKqKpdnuu/7siVEhUFtmaFeVJHOBNWjuMR5+drVCzlu1XcfpSmkD+rMoJG8Cy
 IBLH9h526x1SpSLa3nbUoZSBhEYvBVYifszRhn53l1A==



=E5=9C=A8 2025/1/21 04:16, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> When we are trying to join the current transaction and if it's aborted,
> we read its 'aborted' field after unlocking fs_info->trans_lock and
> without holding any extra reference count on it. This means that a
> concurrent task that is aborting the transaction may free the transactio=
n
> before we read its 'aborted' field, leading to a use-after-free.
>
> Fix this by reading the 'aborted' field while holding fs_info->trans_loc=
k
> since any freeing task must first acquire that lock and set
> fs_info->running_transaction to NULL before freeing the transaction.
>
> This was reported by syzbot and Dmitry with the following stack traces
> from KASAN:
>
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     BUG: KASAN: slab-use-after-free in join_transaction+0xd9b/0xda0 fs/b=
trfs/transaction.c:278
>     Read of size 4 at addr ffff888011839024 by task kworker/u4:9/1128
>
>     CPU: 0 UID: 0 PID: 1128 Comm: kworker/u4:9 Not tainted 6.13.0-rc7-sy=
zkaller-00019-gc45323b7560e #0
>     Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debi=
an-1.16.3-2~bpo12+1 04/01/2014
>     Workqueue: events_unbound btrfs_async_reclaim_data_space
>     Call Trace:
>      <TASK>
>      __dump_stack lib/dump_stack.c:94 [inline]
>      dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>      print_address_description mm/kasan/report.c:378 [inline]
>      print_report+0x169/0x550 mm/kasan/report.c:489
>      kasan_report+0x143/0x180 mm/kasan/report.c:602
>      join_transaction+0xd9b/0xda0 fs/btrfs/transaction.c:278
>      start_transaction+0xaf8/0x1670 fs/btrfs/transaction.c:697
>      flush_space+0x448/0xcf0 fs/btrfs/space-info.c:803
>      btrfs_async_reclaim_data_space+0x159/0x510 fs/btrfs/space-info.c:13=
21
>      process_one_work kernel/workqueue.c:3236 [inline]
>      process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
>      worker_thread+0x870/0xd30 kernel/workqueue.c:3398
>      kthread+0x2f0/0x390 kernel/kthread.c:389
>      ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>      ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>      </TASK>
>
>     Allocated by task 5315:
>      kasan_save_stack mm/kasan/common.c:47 [inline]
>      kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>      poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>      __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
>      kasan_kmalloc include/linux/kasan.h:260 [inline]
>      __kmalloc_cache_noprof+0x243/0x390 mm/slub.c:4329
>      kmalloc_noprof include/linux/slab.h:901 [inline]
>      join_transaction+0x144/0xda0 fs/btrfs/transaction.c:308
>      start_transaction+0xaf8/0x1670 fs/btrfs/transaction.c:697
>      btrfs_create_common+0x1b2/0x2e0 fs/btrfs/inode.c:6572
>      lookup_open fs/namei.c:3649 [inline]
>      open_last_lookups fs/namei.c:3748 [inline]
>      path_openat+0x1c03/0x3590 fs/namei.c:3984
>      do_filp_open+0x27f/0x4e0 fs/namei.c:4014
>      do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
>      do_sys_open fs/open.c:1417 [inline]
>      __do_sys_creat fs/open.c:1495 [inline]
>      __se_sys_creat fs/open.c:1489 [inline]
>      __x64_sys_creat+0x123/0x170 fs/open.c:1489
>      do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>      do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>     Freed by task 5336:
>      kasan_save_stack mm/kasan/common.c:47 [inline]
>      kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>      kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:582
>      poison_slab_object mm/kasan/common.c:247 [inline]
>      __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
>      kasan_slab_free include/linux/kasan.h:233 [inline]
>      slab_free_hook mm/slub.c:2353 [inline]
>      slab_free mm/slub.c:4613 [inline]
>      kfree+0x196/0x430 mm/slub.c:4761
>      cleanup_transaction fs/btrfs/transaction.c:2063 [inline]
>      btrfs_commit_transaction+0x2c97/0x3720 fs/btrfs/transaction.c:2598
>      insert_balance_item+0x1284/0x20b0 fs/btrfs/volumes.c:3757
>      btrfs_balance+0x992/0x10c0 fs/btrfs/volumes.c:4633
>      btrfs_ioctl_balance+0x493/0x7c0 fs/btrfs/ioctl.c:3670
>      vfs_ioctl fs/ioctl.c:51 [inline]
>      __do_sys_ioctl fs/ioctl.c:906 [inline]
>      __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
>      do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>      do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
>     The buggy address belongs to the object at ffff888011839000
>      which belongs to the cache kmalloc-2k of size 2048
>     The buggy address is located 36 bytes inside of
>      freed 2048-byte region [ffff888011839000, ffff888011839800)
>
>     The buggy address belongs to the physical page:
>     page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0=
x11838
>     head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincoun=
t:0
>     flags: 0xfff00000000040(head|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
>     page_type: f5(slab)
>     raw: 00fff00000000040 ffff88801ac42000 ffffea0000493400 dead00000000=
0002
>     raw: 0000000000000000 0000000000080008 00000001f5000000 000000000000=
0000
>     head: 00fff00000000040 ffff88801ac42000 ffffea0000493400 dead0000000=
00002
>     head: 0000000000000000 0000000000080008 00000001f5000000 00000000000=
00000
>     head: 00fff00000000003 ffffea0000460e01 ffffffffffffffff 00000000000=
00000
>     head: 0000000000000008 0000000000000000 00000000ffffffff 00000000000=
00000
>     page dumped because: kasan: bad access detected
>     page_owner tracks the page as allocated
>     page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd=
20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMAL=
LOC), pid 57, tgid 57 (kworker/0:2), ts 67248182943, free_ts 67229742023
>      set_page_owner include/linux/page_owner.h:32 [inline]
>      post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1558
>      prep_new_page mm/page_alloc.c:1566 [inline]
>      get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3476
>      __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4753
>      alloc_pages_mpol_noprof+0x3e1/0x780 mm/mempolicy.c:2269
>      alloc_slab_page+0x6a/0x110 mm/slub.c:2423
>      allocate_slab+0x5a/0x2b0 mm/slub.c:2589
>      new_slab mm/slub.c:2642 [inline]
>      ___slab_alloc+0xc27/0x14a0 mm/slub.c:3830
>      __slab_alloc+0x58/0xa0 mm/slub.c:3920
>      __slab_alloc_node mm/slub.c:3995 [inline]
>      slab_alloc_node mm/slub.c:4156 [inline]
>      __do_kmalloc_node mm/slub.c:4297 [inline]
>      __kmalloc_node_track_caller_noprof+0x2e9/0x4c0 mm/slub.c:4317
>      kmalloc_reserve+0x111/0x2a0 net/core/skbuff.c:609
>      __alloc_skb+0x1f3/0x440 net/core/skbuff.c:678
>      alloc_skb include/linux/skbuff.h:1323 [inline]
>      alloc_skb_with_frags+0xc3/0x820 net/core/skbuff.c:6612
>      sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2884
>      sock_alloc_send_skb include/net/sock.h:1803 [inline]
>      mld_newpack+0x1c3/0xaf0 net/ipv6/mcast.c:1747
>      add_grhead net/ipv6/mcast.c:1850 [inline]
>      add_grec+0x1492/0x19a0 net/ipv6/mcast.c:1988
>      mld_send_cr net/ipv6/mcast.c:2114 [inline]
>      mld_ifc_work+0x691/0xd90 net/ipv6/mcast.c:2651
>     page last free pid 5300 tgid 5300 stack trace:
>      reset_page_owner include/linux/page_owner.h:25 [inline]
>      free_pages_prepare mm/page_alloc.c:1127 [inline]
>      free_unref_page+0xd3f/0x1010 mm/page_alloc.c:2659
>      __slab_free+0x2c2/0x380 mm/slub.c:4524
>      qlink_free mm/kasan/quarantine.c:163 [inline]
>      qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
>      kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
>      __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
>      kasan_slab_alloc include/linux/kasan.h:250 [inline]
>      slab_post_alloc_hook mm/slub.c:4119 [inline]
>      slab_alloc_node mm/slub.c:4168 [inline]
>      __do_kmalloc_node mm/slub.c:4297 [inline]
>      __kmalloc_noprof+0x236/0x4c0 mm/slub.c:4310
>      kmalloc_noprof include/linux/slab.h:905 [inline]
>      kzalloc_noprof include/linux/slab.h:1037 [inline]
>      fib_create_info+0xc14/0x25b0 net/ipv4/fib_semantics.c:1435
>      fib_table_insert+0x1f6/0x1f20 net/ipv4/fib_trie.c:1231
>      fib_magic+0x3d8/0x620 net/ipv4/fib_frontend.c:1112
>      fib_add_ifaddr+0x40c/0x5e0 net/ipv4/fib_frontend.c:1156
>      fib_netdev_event+0x375/0x490 net/ipv4/fib_frontend.c:1494
>      notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
>      __dev_notify_flags+0x207/0x400
>      dev_change_flags+0xf0/0x1a0 net/core/dev.c:9045
>      do_setlink+0xc90/0x4210 net/core/rtnetlink.c:3109
>      rtnl_changelink net/core/rtnetlink.c:3723 [inline]
>      __rtnl_newlink net/core/rtnetlink.c:3875 [inline]
>      rtnl_newlink+0x1bb6/0x2210 net/core/rtnetlink.c:4012
>
>     Memory state around the buggy address:
>      ffff888011838f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>      ffff888011838f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>     >ffff888011839000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                    ^
>      ffff888011839080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>      ffff888011839100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Reported-by: syzbot+45212e9d87a98c3f5b42@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/linux-btrfs/678e7da5.050a0220.303755.007c.=
GAE@google.com/
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Link: https://lore.kernel.org/linux-btrfs/CACT4Y+ZFBdo7pT8L2AzM=3DvegZwj=
p-wNkVJZQf0Ta3vZqtExaSw@mail.gmail.com/
> Fixes: 871383be592b ("btrfs: add missing unlocks to transaction abort pa=
ths")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/transaction.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 15312013f2a3..aca83a98b75a 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -274,8 +274,10 @@ static noinline int join_transaction(struct btrfs_f=
s_info *fs_info,
>   	cur_trans =3D fs_info->running_transaction;
>   	if (cur_trans) {
>   		if (TRANS_ABORTED(cur_trans)) {
> +			const int abort_error =3D cur_trans->aborted;
> +
>   			spin_unlock(&fs_info->trans_lock);
> -			return cur_trans->aborted;
> +			return abort_error;
>   		}
>   		if (btrfs_blocked_trans_types[cur_trans->state] & type) {
>   			spin_unlock(&fs_info->trans_lock);


