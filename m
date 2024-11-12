Return-Path: <linux-btrfs+bounces-9557-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA209C62E5
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 21:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB6292821C3
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 Nov 2024 20:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EF521832B;
	Tue, 12 Nov 2024 20:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="GxnpFCUC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DC218BBA2
	for <linux-btrfs@vger.kernel.org>; Tue, 12 Nov 2024 20:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731444679; cv=none; b=kwgG0hg5E8YnkjlNsY/Rg5u9JnBSQhcif5v56rHZBCiuykpTYdoh7E9C06ThJ8JIAktO8B49+lljLogQi3Y84zO92YRTga074YozyfqOXMHTiGjFIpUWXHTJYXvpiiBd234DXEWjxAaGMiGc9g7yYcLCyR6Q2oRKeJQ4afX+m1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731444679; c=relaxed/simple;
	bh=cdTFUDScat7AdQvT6riiHUUf6quZ6dVClqoXnmfIqs0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gwa5zUTm1SqXVNsFVApBbGqwgJHTpxepiV1E+RV2T6VjVcw4DFJKwvAztNtkCi30QGBbCwYeaGqL3ho0OTcxL7rCrqFFEFsEx3S7IhyiJIRFWawb6SsYCCJb54krNNfe7O8afXtsP9gX7SLXVe0g1keG4JYR0G4WxsU/7WI4wWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=GxnpFCUC; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1731444662; x=1732049462; i=quwenruo.btrfs@gmx.com;
	bh=bSqHhrdvRWE7QXDrp9eEa+yGis9nFg0ytjuitKr7hFs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GxnpFCUCKl7yVppBmP5gFUtN31PILo2NyE2o988ZNXMYv9K/s8No4Nk+wRuPRQg8
	 3EdhAC+TEbENGFgOl+8T7ANGSL7/HAo2d0Wi8REUx5I1jfacEbG0MMkaAhL16Idev
	 RX847fMDZArqrqiOpme+MjmkWJqf7FcVrX9KBL0EAUyhe04hJPnzFkho+KG8wetzA
	 oiviMf7GAlGmSja5EDgiyKbcYJmk8lTmyWTndL2KmFiuArmHXJN4t7aHWkLqQC67C
	 pI8yUwNUtXQj6btqx9jTVhps0gqkSannspe8CbWe2NLddrwyNd8bisEuBzjqkrVZc
	 sKZu1aLLr3SomBufLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGyxX-1swswo2W39-000f1P; Tue, 12
 Nov 2024 21:51:02 +0100
Message-ID: <5616e932-fbeb-4c97-8966-6b8b99ec145c@gmx.com>
Date: Wed, 13 Nov 2024 07:20:56 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] btrfs: fix use-after-free in
 btrfs_encoded_read_endio
To: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>, Damien Le Moal <dlemoal@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Mark Harmstone <maharmstone@fb.com>, Omar Sandoval <osandov@osandov.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>
References: <cover.1731407982.git.jth@kernel.org>
 <7a14a2b897cbeb9a149bed18397ead70ec79345a.1731407982.git.jth@kernel.org>
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
In-Reply-To: <7a14a2b897cbeb9a149bed18397ead70ec79345a.1731407982.git.jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zvmClxmBBoMtaJju7M5bWvgtDUCap2Se18xlxbfyPzgEV1Cic37
 3FpQ36prAQbI8/LH9OEmPYikfw7kDNyi/sw18UKA79OjHWvLM6wZ+xjwatjrQEzgG52XcI4
 I2WQiyN4Srw3KiB//Rfyk20x6BuYBq7le1zVwEVzJ2otakYbl/4EofITnFSQYZ9HspkSFKZ
 OkyF57BOqmEzL/jMPleDw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0Iavk6yLJPI=;eoJMqxngAyLraW7qibv7nXRgmyx
 UA7NrDpeIfFuaH/ePvmD+W/1NeiLccGtGAoK8tyVMoHjCBsEJlsvl1y7yTYRC36gWEQcbZ9ZM
 mkTCayJOE401ZzKWlU/kJePGcAytThWpyPzaSffqD7R9CgjxzQcyFj+pFcMrT22WG4zSO+J0P
 EBPx48/7+eK+hUI64eyHBhi2/vrINkzebhezUHyA7Qa5qcayo4W+/0ZJ8KoRVQnle6hAS2ZQE
 MC3u/xLnUHZzh5rTt/ukGNZvxulf5X0/bC0c5UKEPUzdlNRZhUmVtyxfZqcbsKV1azkwCEpY8
 QPFk4i9GUHBiKJ6XGLwSjX491te6UXAimM6Fy+IQ8i2r3nHKSfAbcXC4kv6rTsaKb9KVcCiz3
 eMSVGJKn7ZnbqaaXuCQt6Tp/l99V+aFnDlspvayYGQ2UdLhPjgfuT/FDlf6mUvXvhvvpRhfP2
 6JCZF5P/UQVSVE2ByMeZGDemTbkCfvsCtXJ6EBRMHmQd4l3v9cGZHnxxvNazT716AX/z5p2Pz
 u5gbj/q7RBB2pkLLtdnlD+TAb1GiplHs3kHow2OdaVehVCR7AiIY5hcHhRjqEUEqPTrQ82YAC
 g4QaY0kTcSVinkB8yqURSPo6ktvW1PsP875ECuGLcFvhvjznTO5zgELLmc/DKnPIWGSGEGLEq
 s8PP2HlKruubZJpmyIZs7I4WQjQD/rIyYKqCewle9alXqWUAbqCQF+Q2cP9v/qUuZ6D3GC7lo
 rS2kQ20V4g0PNtcvElDdsv5s6WYt4DNJ5NacYoSpjwuv9fjFuoNNCzIiRzPZS37zVwV0kzgdy
 pqIQJLDYWXNWOeqCd4bh7k2Q==



=E5=9C=A8 2024/11/13 00:23, Johannes Thumshirn =E5=86=99=E9=81=93:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Shinichiro reported the following use-after free that sometimes is
> happening in our CI system when running fstests' btrfs/284 on a TCMU
> runner device:
>
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>     BUG: KASAN: slab-use-after-free in lock_release+0x708/0x780
>     Read of size 8 at addr ffff888106a83f18 by task kworker/u80:6/219
>
>     CPU: 8 UID: 0 PID: 219 Comm: kworker/u80:6 Not tainted 6.12.0-rc6-kt=
s+ #15
>     Hardware name: Supermicro Super Server/X11SPi-TF, BIOS 3.3 02/21/202=
0
>     Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
>     Call Trace:
>      <TASK>
>      dump_stack_lvl+0x6e/0xa0
>      ? lock_release+0x708/0x780
>      print_report+0x174/0x505
>      ? lock_release+0x708/0x780
>      ? __virt_addr_valid+0x224/0x410
>      ? lock_release+0x708/0x780
>      kasan_report+0xda/0x1b0
>      ? lock_release+0x708/0x780
>      ? __wake_up+0x44/0x60
>      lock_release+0x708/0x780
>      ? __pfx_lock_release+0x10/0x10
>      ? __pfx_do_raw_spin_lock+0x10/0x10
>      ? lock_is_held_type+0x9a/0x110
>      _raw_spin_unlock_irqrestore+0x1f/0x60
>      __wake_up+0x44/0x60
>      btrfs_encoded_read_endio+0x14b/0x190 [btrfs]
>      btrfs_check_read_bio+0x8d9/0x1360 [btrfs]
>      ? lock_release+0x1b0/0x780
>      ? trace_lock_acquire+0x12f/0x1a0
>      ? __pfx_btrfs_check_read_bio+0x10/0x10 [btrfs]
>      ? process_one_work+0x7e3/0x1460
>      ? lock_acquire+0x31/0xc0
>      ? process_one_work+0x7e3/0x1460
>      process_one_work+0x85c/0x1460
>      ? __pfx_process_one_work+0x10/0x10
>      ? assign_work+0x16c/0x240
>      worker_thread+0x5e6/0xfc0
>      ? __pfx_worker_thread+0x10/0x10
>      kthread+0x2c3/0x3a0
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork+0x31/0x70
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork_asm+0x1a/0x30
>      </TASK>
>
>     Allocated by task 3661:
>      kasan_save_stack+0x30/0x50
>      kasan_save_track+0x14/0x30
>      __kasan_kmalloc+0xaa/0xb0
>      btrfs_encoded_read_regular_fill_pages+0x16c/0x6d0 [btrfs]
>      send_extent_data+0xf0f/0x24a0 [btrfs]
>      process_extent+0x48a/0x1830 [btrfs]
>      changed_cb+0x178b/0x2ea0 [btrfs]
>      btrfs_ioctl_send+0x3bf9/0x5c20 [btrfs]
>      _btrfs_ioctl_send+0x117/0x330 [btrfs]
>      btrfs_ioctl+0x184a/0x60a0 [btrfs]
>      __x64_sys_ioctl+0x12e/0x1a0
>      do_syscall_64+0x95/0x180
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>     Freed by task 3661:
>      kasan_save_stack+0x30/0x50
>      kasan_save_track+0x14/0x30
>      kasan_save_free_info+0x3b/0x70
>      __kasan_slab_free+0x4f/0x70
>      kfree+0x143/0x490
>      btrfs_encoded_read_regular_fill_pages+0x531/0x6d0 [btrfs]
>      send_extent_data+0xf0f/0x24a0 [btrfs]
>      process_extent+0x48a/0x1830 [btrfs]
>      changed_cb+0x178b/0x2ea0 [btrfs]
>      btrfs_ioctl_send+0x3bf9/0x5c20 [btrfs]
>      _btrfs_ioctl_send+0x117/0x330 [btrfs]
>      btrfs_ioctl+0x184a/0x60a0 [btrfs]
>      __x64_sys_ioctl+0x12e/0x1a0
>      do_syscall_64+0x95/0x180
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>     The buggy address belongs to the object at ffff888106a83f00
>      which belongs to the cache kmalloc-rnd-07-96 of size 96
>     The buggy address is located 24 bytes inside of
>      freed 96-byte region [ffff888106a83f00, ffff888106a83f60)
>
>     The buggy address belongs to the physical page:
>     page: refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888=
106a83800 pfn:0x106a83
>     flags: 0x17ffffc0000000(node=3D0|zone=3D2|lastcpupid=3D0x1fffff)
>     page_type: f5(slab)
>     raw: 0017ffffc0000000 ffff888100053680 ffffea0004917200 000000000000=
0004
>     raw: ffff888106a83800 0000000080200019 00000001f5000000 000000000000=
0000
>     page dumped because: kasan: bad access detected
>
>     Memory state around the buggy address:
>      ffff888106a83e00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>      ffff888106a83e80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>     >ffff888106a83f00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>                                 ^
>      ffff888106a83f80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
>      ffff888106a84000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>     =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Further analyzing the trace and the crash dump's vmcore file shows that
> the wake_up() call in btrfs_encoded_read_endio() is calling wake_up() on
> the wait_queue that is in the private data passed to the end_io handler.
>
> Commit 4ff47df40447 ("btrfs: move priv off stack in
> btrfs_encoded_read_regular_fill_pages()") moved 'struct
> btrfs_encoded_read_private' off the stack.
>
> Before that commit one can see a corruption of the private data when
> analyzing the vmcore after a crash:
>
> *(struct btrfs_encoded_read_private *)0xffff88815626eec8 =3D {
> 	.wait =3D (wait_queue_head_t){
> 		.lock =3D (spinlock_t){
> 			.rlock =3D (struct raw_spinlock){
> 				.raw_lock =3D (arch_spinlock_t){
> 					.val =3D (atomic_t){
> 						.counter =3D (int)-2005885696,
> 					},
> 					.locked =3D (u8)0,
> 					.pending =3D (u8)157,
> 					.locked_pending =3D (u16)40192,
> 					.tail =3D (u16)34928,
> 				},
> 				.magic =3D (unsigned int)536325682,
> 				.owner_cpu =3D (unsigned int)29,
> 				.owner =3D (void *)__SCT__tp_func_btrfs_transaction_commit+0x0 =3D 0=
x0,
> 				.dep_map =3D (struct lockdep_map){
> 					.key =3D (struct lock_class_key *)0xffff8881575a3b6c,
> 					.class_cache =3D (struct lock_class *[2]){ 0xffff8882a71985c0, 0xff=
ffea00066f5d40 },
> 					.name =3D (const char *)0xffff88815626f100 =3D "",
> 					.wait_type_outer =3D (u8)37,
> 					.wait_type_inner =3D (u8)178,
> 					.lock_type =3D (u8)154,
> 				},
> 			},
> 			.__padding =3D (u8 [24]){ 0, 157, 112, 136, 50, 174, 247, 31, 29 },
> 			.dep_map =3D (struct lockdep_map){
> 				.key =3D (struct lock_class_key *)0xffff8881575a3b6c,
> 				.class_cache =3D (struct lock_class *[2]){ 0xffff8882a71985c0, 0xfff=
fea00066f5d40 },
> 				.name =3D (const char *)0xffff88815626f100 =3D "",
> 				.wait_type_outer =3D (u8)37,
> 				.wait_type_inner =3D (u8)178,
> 				.lock_type =3D (u8)154,
> 			},
> 		},
> 		.head =3D (struct list_head){
> 			.next =3D (struct list_head *)0x112cca,
> 			.prev =3D (struct list_head *)0x47,
> 		},
> 	},
> 	.pending =3D (atomic_t){
> 		.counter =3D (int)-1491499288,
> 	},
> 	.status =3D (blk_status_t)130,
> }
>
> Here we can see several indicators of in-memory data corruption, e.g. th=
e
> large negative atomic values of ->pending or
> ->wait->lock->rlock->raw_lock->val, as well as the bogus spinlock magic
> 0x1ff7ae32 (decimal 536325682 above) instead of 0xdead4ead or the bogus
> pointer values for ->wait->head.
>
> To fix this, move the call to bio_put() before the atomic_test operation
> so the submitter side in btrfs_encoded_read_regular_fill_pages() is not
> woken up before the bio is cleaned up.
>
> Also change atomic_dec_return() to atomic_dec_and_test() to fix the
> corruption, as atomic_dec_return() is defined as two instructions on
> x86_64, whereas atomic_dec_and_test() is defined as a single atomic
> operation.

This means we should not utilize "atomic_dec_return() =3D=3D 0" as a way t=
o
do synchronization.

And unfortunately I'm also seeing other locations still utilizing the
same patter inside btrfs_encoded_read_regular_fill_pages()

Shouldn't we also fix that call site even just for the sake of consistency=
?

Thanks,
Qu

> This can lead to a situation where counter value is already
> decremented but the if statement in btrfs_encoded_read_endio() is not
> completely processed, i.e. the 0 test has not completed. If another thre=
ad
> continues executing btrfs_encoded_read_regular_fill_pages() the
> atomic_dec_return() there can see an already updated ->pending counter a=
nd
> continues by freeing the private data. Continuing in the endio handler t=
he
> test for 0 succeeds and the wait_queue is woken up, resulting in a
> use-after-free.
>
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Suggested-by: Damien Le Moal <Damien.LeMoal@wdc.com>
> Fixes: 1881fba89bd5 ("btrfs: add BTRFS_IOC_ENCODED_READ ioctl")
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/inode.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 22b8e2764619..cb8b23a3e56b 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -9089,7 +9089,8 @@ static void btrfs_encoded_read_endio(struct btrfs_=
bio *bbio)
>   		 */
>   		WRITE_ONCE(priv->status, bbio->bio.bi_status);
>   	}
> -	if (atomic_dec_return(&priv->pending) =3D=3D 0) {
> +	bio_put(&bbio->bio);
> +	if (atomic_dec_and_test(&priv->pending)) {
>   		int err =3D blk_status_to_errno(READ_ONCE(priv->status));
>
>   		if (priv->uring_ctx) {
> @@ -9099,7 +9100,6 @@ static void btrfs_encoded_read_endio(struct btrfs_=
bio *bbio)
>   			wake_up(&priv->wait);
>   		}
>   	}
> -	bio_put(&bbio->bio);
>   }
>
>   int btrfs_encoded_read_regular_fill_pages(struct btrfs_inode *inode,


