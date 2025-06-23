Return-Path: <linux-btrfs+bounces-14841-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D957AE3338
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 03:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 819EB3AF04B
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Jun 2025 01:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FD4AD5A;
	Mon, 23 Jun 2025 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="FVY0XIDz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943F14A1A
	for <linux-btrfs@vger.kernel.org>; Mon, 23 Jun 2025 01:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750641029; cv=none; b=fcL83+Up3KZ9X4xSyWO3ZxdaVl9pSXgOp4skM3CPVPxFPCqe0IgXOoUcOIxupoxIRvKXWBzMTR7Ay9++cUr6cb6mlqdoqPPZiQtm79XSxCnZG9CkMix1LwPA9HOqXwG8kZkv5idDYpaV01tYQnRJO58uDfSGuR4Vv91vMjqePN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750641029; c=relaxed/simple;
	bh=O9dJ4dzM0Glq60Q1omuX2Ryfuel2OwT5oRbE0N/RY74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OBv5HvjjuM1ku+M/+XsH6tVUZhFGwLti4n+OVNg7RZNiDmVjgAFP2NWr4E4PtlLR2QntFiWry+QF9SJLA8XZSJHRIEIBcalgR2xoMCp4WExxsINgeb/oUC7CcQgk3b0on/aVkoiXzE94RDjnMaLDvdG4+F6bnlhkiZMKo7nw+Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=FVY0XIDz; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1750641022; x=1751245822; i=quwenruo.btrfs@gmx.com;
	bh=X8UUxL98T/kpuU2CeTabcuUqrocJt7eOfJvesu6s5h4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FVY0XIDzJSdX9WXd6FSqc4sQ0QK9bD0BR5p2ShqWuJfKfADkvwMaq5i9Q7+uURRY
	 1OzFwQh42w18wcMv0y2BVfeu88p7rj5pK+7BonA9w6sQOWE4tIykJr2OiWiGU2h+I
	 WDxI11yBL9zBtlrMOtFM8NlhNF0Kb6RvAqJfO8xk8PF2ndjnD3/uESerRwQSIL7f9
	 +GSOKeo1lcoHBzyyb5DfJj7tssh76wdV72v8dLjM+Rzl7key13F1tdFLneAJaHLmR
	 eh2Rcw89e7iltkRBlDqZYhaQG357oicKFhKG3PQGvwLgZtVItINmDhxlbkFXvFHP1
	 jmHFnR+0y9tJgQbKMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MuUjC-1ulaoh1CyI-011MO9; Mon, 23
 Jun 2025 03:10:21 +0200
Message-ID: <6d867d2b-cbfd-41ae-b8bb-d12415119974@gmx.com>
Date: Mon, 23 Jun 2025 10:40:18 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] btrfs: use the super_block as bdev holder
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1750137547.git.wqu@suse.com>
 <20250619132918.GK4037@twin.jikos.cz>
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
In-Reply-To: <20250619132918.GK4037@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/hMGURbDBH0Vz8HW6DZ55YFHxpN41/hZ3ipPNh8MDsPpbp9BI7n
 ZctIRPsyplQf3A0E/t9XEPRmthWWN7zy369ms1yld4vLG2y+OU0jifho+qsdzDL4BUyaK9d
 gF+uBB7w8OLIKy1dt5omA7Np7ednJTt8LM9AoqBgxouzvter0x1i8mf/QDXkINdn+qhA1Zw
 HlLgfXeCLUvHrJ23X3iUA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:D3Mj88ftq+0=;XCGI+eB4vTBi5+rlS9ss12SBhpR
 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



=E5=9C=A8 2025/6/19 22:59, David Sterba =E5=86=99=E9=81=93:
> On Tue, Jun 17, 2025 at 02:49:33PM +0930, Qu Wenruo wrote:
>> [CHANGELOG]
>> v3:
>> - Drop the btrfs_fs_devices::opened split
>>    It turns out to cause problems during tests.
>>
>> - Extra cleanup related to the btrfs_get_tree_*()
>>    Now the re-entry through vfs_get_tree() is completely dropped.
>>
>> - Extra comments explaining the sget_fc() behavior
>>
>> - Call bdev_fput() instead of fput()
>>    This alignes us to all the other fses.
>>
>> - Updated patch to delay btrfs_open_devices() until sget_fc()
>>    Instead of relying on the previous solution (split
>>    btrfs_open_devices::opened), just expand the uuid_mutex critical
>>    section.
>=20
> I've added the patches to linux-next for testing.
>=20

Please drop the series.

The problem is exactly in the btrfs_open_devices() handling.

The new delayed behavior is causing lockdep warning, as now sget_fc() is=
=20
called with uuid_mutex hold, this can cause a ABBA deadlock:

[   50.807904] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   50.809738] WARNING: possible circular locking dependency detected
[   50.811563] 6.16.0-rc1-custom+ #258 Not tainted
[   50.813040] ------------------------------------------------------
[   50.814761] mount/798 is trying to acquire lock:
[   50.816114] ffffffffa070b068 (uuid_mutex){+.+.}-{4:4}, at:=20
btrfs_read_chunk_tree+0x7d/0x870 [btrfs]
[   50.818690]
[   50.818690] but task is already holding lock:
[   50.820964] ffff8881055d50e0 (&type->s_umount_key#46/1){+.+.}-{4:4},=20
at: alloc_super+0xe0/0x3c0
[   50.823553]
[   50.823553] which lock already depends on the new lock.
[   50.823553]
[   50.825852]
[   50.825852] the existing dependency chain (in reverse order) is:
[   50.827858]
[   50.827858] -> #1 (&type->s_umount_key#46/1){+.+.}-{4:4}:
[   50.829749]        down_write_nested+0x38/0xc0
[   50.831063]        alloc_super+0xe0/0x3c0
[   50.832175]        sget_fc+0x66/0x400
[   50.833203]        btrfs_get_tree+0x195/0x620 [btrfs]
[   50.834653]        vfs_get_tree+0x2c/0xe0
[   50.835767]        vfs_cmd_create+0x57/0xd0
[   50.836979]        __do_sys_fsconfig+0x4c0/0x660
[   50.838244]        do_syscall_64+0x6c/0x2c0
[   50.839397]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   50.840968]
[   50.840968] -> #0 (uuid_mutex){+.+.}-{4:4}:
[   50.842767]        __lock_acquire+0x14b7/0x22a0
[   50.844138]        lock_acquire+0xc9/0x300
[   50.845427]        __mutex_lock+0xb9/0xe00
[   50.846625]        btrfs_read_chunk_tree+0x7d/0x870 [btrfs]
[   50.848272]        open_ctree+0x9aa/0x1483 [btrfs]
[   50.849654]        btrfs_get_tree.cold+0xf3/0x19d [btrfs]
[   50.851173]        vfs_get_tree+0x2c/0xe0
[   50.852443]        vfs_cmd_create+0x57/0xd0
[   50.853768]        __do_sys_fsconfig+0x4c0/0x660
[   50.855094]        do_syscall_64+0x6c/0x2c0
[   50.856260]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   50.857773]
[   50.857773] other info that might help us debug this:
[   50.857773]
[   50.859955]  Possible unsafe locking scenario:
[   50.859955]
[   50.861558]        CPU0                    CPU1
[   50.862816]        ----                    ----
[   50.864067]   lock(&type->s_umount_key#46/1);
[   50.865367]                                lock(uuid_mutex);
[   50.866962]=20
lock(&type->s_umount_key#46/1);
[   50.868821]   lock(uuid_mutex);
[   50.869716]
[   50.869716]  *** DEADLOCK ***
[   50.869716]
[   50.871325] 2 locks held by mount/798:
[   50.872370]  #0: ffff888102ea2c70 (&fc->uapi_mutex){+.+.}-{4:4}, at:=20
__do_sys_fsconfig+0x48f/0x660
[   50.874799]  #1: ffff8881055d50e0=20
(&type->s_umount_key#46/1){+.+.}-{4:4}, at: alloc_super+0xe0/0x3c0
[   50.877270]
[   50.877270] stack backtrace:
[   50.878480] CPU: 3 UID: 0 PID: 798 Comm: mount Not tainted=20
6.16.0-rc1-custom+ #258 PREEMPT(full)
[   50.878486] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=20
unknown 02/02/2022
[   50.878488] Call Trace:
[   50.878493]  <TASK>
[   50.878498]  dump_stack_lvl+0x76/0xa0
[   50.878505]  print_circular_bug.cold+0x185/0x1d0
[   50.878512]  check_noncircular+0x169/0x190
[   50.878518]  __lock_acquire+0x14b7/0x22a0
[   50.878526]  lock_acquire+0xc9/0x300
[   50.878529]  ? btrfs_read_chunk_tree+0x7d/0x870 [btrfs]
[   50.878626]  ? lock_acquire+0xc9/0x300
[   50.878628]  ? fs_reclaim_acquire+0x4f/0xe0
[   50.878634]  __mutex_lock+0xb9/0xe00
[   50.878640]  ? btrfs_read_chunk_tree+0x7d/0x870 [btrfs]
[   50.878685]  ? fs_reclaim_acquire+0x4f/0xe0
[   50.878687]  ? lock_release+0xdd/0x2e0
[   50.878690]  ? btrfs_read_chunk_tree+0x7d/0x870 [btrfs]
[   50.878726]  ? btrfs_read_chunk_tree+0x7d/0x870 [btrfs]
[   50.878759]  btrfs_read_chunk_tree+0x7d/0x870 [btrfs]
[   50.878793]  ? btrfs_root_node+0x22/0x220 [btrfs]
[   50.878844]  ? find_held_lock+0x2b/0x80
[   50.878849]  ? btrfs_root_node+0x9c/0x220 [btrfs]
[   50.878912]  ? load_super_root+0x95/0xc3 [btrfs]
[   50.878976]  open_ctree+0x9aa/0x1483 [btrfs]
[   50.879015]  btrfs_get_tree.cold+0xf3/0x19d [btrfs]
[   50.879053]  ? fscontext_read+0x11d/0x130
[   50.879056]  ? __do_sys_fsconfig+0x48f/0x660
[   50.879058]  vfs_get_tree+0x2c/0xe0
[   50.879062]  ? capable+0x3a/0x60
[   50.879066]  vfs_cmd_create+0x57/0xd0
[   50.879069]  __do_sys_fsconfig+0x4c0/0x660
[   50.879071]  do_syscall_64+0x6c/0x2c0
[   50.879077]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   50.879080] RIP: 0033:0x7f3442f9eefe
[   50.879086] Code: 73 01 c3 48 8b 0d 12 be 0c 00 f7 d8 64 89 01 48 83=20
c8 ff c3 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 49 89 ca b8 af 01 00 00 0f=20
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e2 bd 0c 00 f7 d8 64 89 01 48
[   50.879088] RSP: 002b:00007ffe661382a8 EFLAGS: 00000246 ORIG_RAX:=20
00000000000001af
[   50.879092] RAX: ffffffffffffffda RBX: 0000558220e95430 RCX:=20
00007f3442f9eefe
[   50.879094] RDX: 0000000000000000 RSI: 0000000000000006 RDI:=20
0000000000000003
[   50.879094] RBP: 00007ffe661382e0 R08: 0000000000000000 R09:=20
0000000000000000
[   50.879095] R10: 0000000000000000 R11: 0000000000000246 R12:=20
00007f34430c8980
[   50.879096] R13: 0000000000000000 R14: 0000558220e96720 R15:=20
00007f34430bd8e0
[   50.879099]  </TASK>

I'll need to find out a way to make sget_fc() call without holding=20
uuid_mutex instead.

Thanks,
Qu

