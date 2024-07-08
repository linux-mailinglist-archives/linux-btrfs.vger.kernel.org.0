Return-Path: <linux-btrfs+bounces-6311-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9096992AC55
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jul 2024 01:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14B571F22867
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 23:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94E01514F6;
	Mon,  8 Jul 2024 23:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="dJfOmawH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3413C34545;
	Mon,  8 Jul 2024 23:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720479761; cv=none; b=OGEjifBjNx2W9LxyfoQmm5Kavi3n7LGFsDxEkP6KJAB5GBW8PmEUlqgi6TFDZQUGD3QNCLAf//+ygcdTAB1U5xGLhlKtn/Z7PZKmwcGqEyJT2yTo+xG0YSjtviDP5f8aJ9TSpLxy0S9cNd5Bh0/WACZO48rEbEKA+yVfcdUru/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720479761; c=relaxed/simple;
	bh=uG/+aQClGwhtZo6k8lVP2S+kagDmKRqwdQVqP26DdII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LY3LYeZMW3Q65SAOjyvj7LlGKj29jT8xq8lJuqckwLsnrbVupSmbyG+ssWu7n5gdXGL7XKaaZPfrnDeLd49TsFzG20i4P519bVxhAK4mhOSdraPwxcKN/uQSEBWaOUyz8bE5lkQ9Gay301758Y0ZlBD/HQzXU2919Pm529Wn4oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=dJfOmawH; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1720479743; x=1721084543; i=quwenruo.btrfs@gmx.com;
	bh=JEJwolu5fK69Vvc6LDyg/r9dmrw8ucbENq7HiOCxU78=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dJfOmawH5AYPRu4VGIBxKpdRvCAB6CEXR51sDfgk+Kb2B8/bbzxEr20EF45OQFnA
	 b7/wz+REIvH+ToAqPsPP2ClCagq7x5u2pUJ/rnUMEis4A8DKWKc9RIVukKnnv+3GL
	 a71W4xodTLVQ55bD64KoMycGv2TsivGun/CQ2dD3+XKqBE1hlpTnuKYdSpolOLQwK
	 ylnLjJ7OKs/xKDIP05GDLJDbf2AletKh6RjlvOzidtVgpshJiGpgUg8Eu+1hKk6CD
	 oFGUZi6RT3mw+uGhM3UGgNeYs8ycRRiwBAczgM0ZZhBlaDTyuNJrzeOOYy5nhvbMa
	 IspySFh/TUY+riXBIQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N9MpS-1sLVGN0tfg-014ZF9; Tue, 09
 Jul 2024 01:02:23 +0200
Message-ID: <99cc2be0-ea62-430b-8395-a915be48e9bf@gmx.com>
Date: Tue, 9 Jul 2024 08:32:19 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] btrfs: split RAID stripes on deletion
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240705-b4-rst-updates-v4-0-f3eed3f2cfad@kernel.org>
 <20240705-b4-rst-updates-v4-3-f3eed3f2cfad@kernel.org>
 <e0041c2d-f888-41cb-adb8-52c82ca0d03f@gmx.com>
 <e3927e86-d85e-4003-9ce5-e9e88741afa3@wdc.com>
 <ecd368a8-2582-4d23-a89d-549abb8c4902@gmx.com>
 <d0c28a38-23d4-44f3-9438-e374be1c33d0@wdc.com>
 <50d64ebb-857b-45ad-9f98-70353dfef535@wdc.com>
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
In-Reply-To: <50d64ebb-857b-45ad-9f98-70353dfef535@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4bhA1oX1As8EmfhO7gr6lO58tKXnsY96GYe1MrgcJyN4DcyeDxF
 nzQRkpUk9ajNgLYYexwEwhoYqfrbRoNeuNz3GiK4jEyv1osmZbE6GQeItYM6124HOl44It0
 Tw8Y76Gx7RdqKR05fc83E3wxNZBEFGfFR/AORZ5zOktmFqIrAMJOxpZUU2/KnGkXWGPRC+s
 t7CGpwVV0fchM7kft0iag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yJzpsUZ1pOY=;W03E9sWyf4BaNvGm8PiaYOBU52a
 60YV45BvINujuTl1TI6k+8k7qKJR8Zb1p+aZoJqOkFByy3LEU52GvTgQxGkHgLPaHCFf/lqDA
 crBe4ptJ6e8pAEnS//FZaljZ9yydsm1JrZ1gUKr9iwivAxxnQktY6UhAdlCUJX8ECoEG0KXHF
 EbDFNL9Nc0j20EUwQvO1jSz/UdO17zlzwFQvBwCLf5c6gtm8SvAg+t0d6BGnZ/6v76r+iQjhB
 r2K4CR2QuNn6SquPsOsSl5/a9tC2PV1WBcouAyaT898PaMylBpW68TUiKnhkaUUzdGbEA333U
 /SD2isFYk6RglEIpHfyrI0RpS5QKT3FpIab4HUCB6P/Otah/EoNCgbuz9dcCq9rPd8cc2PMYP
 XhTFHndJyCQ4x7wHCuj5H9jmrV9q2m/S1NBU+lCUQcaKAVdsEGnTA8GsDHqhyuQoIi3whwb0k
 7koXx/sNViUTxfKNKWkjvLO0wJoh2S0w3MFxuPP6cyg/FmG+KAXaCygtXfcpi5HmUumzZt6sW
 XroMljVNESYzls6abiC0b0q3x7paPeRdprwjcetUXqy+rOdxH5Vv1ElRwf74/LWMXqVrQiOli
 hd1JKHjuJaVACmcQoRiwQWAvRVakfvHvAj/mvofwLRtee2PvW9nJVjOg3DJyOt47ml8qaK9QP
 HvK977+SZDPJULfP0hQ1wHoaCGnA/RIX5YmQL04HbKuFPJQBSZNo7WMTbq/6pZOPJAho7EAaq
 vH5hBNL2HdNYeOpfXk7+7gjuyLWxxKXroFJuAh0jkSZ47Q0tfeDHqARFRg801tZvd2BhUnVCR
 1FcOB21nATi5aFLBZWsmp3gv2gAhnKnCe4IZ8tCQzhODc=



=E5=9C=A8 2024/7/8 20:22, Johannes Thumshirn =E5=86=99=E9=81=93:
> On 08.07.24 07:26, Johannes Thumshirn wrote:
>> On 08.07.24 07:20, Qu Wenruo wrote:
>>>
>>> Can the ASSERT() be reproduced without a zoned device? (I'm really not=
 a
>>> fan of the existing tcmu emulated solution, meanwhile libvirt still
>>> doesn't support ZNS devices)
>>>
>>> If it can be reproduced just with RST feature, I may provide some help
>>> digging into the ASSERT().
>>
>> Let me check. It's very sporadic as well unfortunately.
>>
>>
>
> OK, I've managed to trigger the failure with btrfs/070 on a
> SCRATCH_DEV_POOL with 5 non-zoned devices.

I'm hitting errors like this:

[  227.898320] ------------[ cut here ]------------
[  227.898817] BTRFS: Transaction aborted (error -17)
[  227.899250] WARNING: CPU: 7 PID: 65 at
fs/btrfs/raid-stripe-tree.c:116 btrfs_insert_raid_extent+0x337/0x3d0 [btrf=
s]
[  227.900122] Modules linked in: btrfs blake2b_generic xor
zstd_compress vfat fat intel_rapl_msr intel_rapl_common crct10dif_pclmul
crc32_pclmul ghash_clmulni_intel iTCO_wdt iTCO_vendor_support
aesni_intel crypto_simd cryptd psmouse i2c_i801 pcspkr i2c_smbus lpc_ich
intel_agp intel_gtt joydev agpgart mousedev raid6_pq libcrc32c loop drm
fuse qemu_fw_cfg ext4 crc32c_generic crc16 mbcache jbd2 dm_mod
virtio_rng virtio_net virtio_blk virtio_balloon net_failover
virtio_console failover virtio_scsi rng_core dimlib usbhid virtio_pci
virtio_pci_legacy_dev crc32c_intel virtio_pci_modern_dev serio_raw
[  227.904452] CPU: 7 PID: 65 Comm: kworker/u40:0 Not tainted
6.10.0-rc6-custom+ #167
[  227.905220] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
unknown 2/2/2022
[  227.905827] Workqueue: btrfs-endio-write btrfs_work_helper [btrfs]
[  227.906558] RIP: 0010:btrfs_insert_raid_extent+0x337/0x3d0 [btrfs]
[  227.907246] Code: 89 6b 08 e8 4b 18 f7 ff 49 8b 84 24 50 02 00 00 4c
39 f0 75 be 31 db e9 7d fe ff ff 89 de 48 c7 c7 f0 8d 9d a0 e8 29 a1 79
e0 <0f> 0b e9 69 ff ff ff e8 bd 95 3e e1 49 8b 46 60 48 05 48 1a 00 00
[  227.908277] BTRFS: error (device dm-3 state A) in
btrfs_insert_one_raid_extent:116: errno=3D-17 Object already exists
[  227.909356] RSP: 0018:ffffc9000026fca0 EFLAGS: 00010282
[  227.909361] RAX: 0000000000000000 RBX: 00000000ffffffef RCX:
0000000000000027
[  227.911934] RDX: ffff88817bda1948 RSI: 0000000000000001 RDI:
ffff88817bda1940
[  227.912722] RBP: ffff8881029dcbe0 R08: 0000000000000000 R09:
0000000000000003
[  227.913095] BTRFS info (device dm-3 state EA): forced readonly
[  227.913569] R10: ffffc9000026fb38 R11: ffffffff826d0508 R12:
0000000000000010
[  227.915182] R13: ffff8881029dcbe0 R14: ffff88812a5ff790 R15:
ffff8881488f2780
[  227.916130] FS:  0000000000000000(0000) GS:ffff88817bd80000(0000)
knlGS:0000000000000000
[  227.916912] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  227.917500] CR2: 0000561364dec000 CR3: 00000001583ca000 CR4:
0000000000750ef0
[  227.918210] PKRU: 55555554
[  227.918484] Call Trace:
[  227.918727]  <TASK>
[  227.918940]  ? __warn+0x8c/0x180
[  227.919299]  ? btrfs_insert_raid_extent+0x337/0x3d0 [btrfs]
[  227.919891]  ? report_bug+0x164/0x190
[  227.920272]  ? prb_read_valid+0x1b/0x30
[  227.920666]  ? handle_bug+0x3c/0x80
[  227.921013]  ? exc_invalid_op+0x17/0x70
[  227.921397]  ? asm_exc_invalid_op+0x1a/0x20
[  227.921835]  ? btrfs_insert_raid_extent+0x337/0x3d0 [btrfs]
[  227.922440]  btrfs_finish_one_ordered+0x3c3/0xaa0 [btrfs]
[  227.923055]  ? srso_alias_return_thunk+0x5/0xfbef5
[  227.923549]  ? srso_alias_return_thunk+0x5/0xfbef5
[  227.924062]  btrfs_work_helper+0x107/0x4c0 [btrfs]
[  227.924612]  ? lock_is_held_type+0x9a/0x110
[  227.925040]  process_one_work+0x212/0x720
[  227.925454]  ? srso_alias_return_thunk+0x5/0xfbef5
[  227.926010]  worker_thread+0x1dc/0x3b0
[  227.926411]  ? __pfx_worker_thread+0x10/0x10
[  227.926918]  kthread+0xe0/0x110
[  227.927377]  ? __pfx_kthread+0x10/0x10
[  227.927776]  ret_from_fork+0x31/0x50
[  227.928151]  ? __pfx_kthread+0x10/0x10
[  227.928564]  ret_from_fork_asm+0x1a/0x30
[  227.929035]  </TASK>
[  227.929305] irq event stamp: 11077
[  227.929710] hardirqs last  enabled at (11085): [<ffffffff8115daf5>]
console_unlock+0x135/0x160
[  227.930725] hardirqs last disabled at (11094): [<ffffffff8115dada>]
console_unlock+0x11a/0x160
[  227.931730] softirqs last  enabled at (10728): [<ffffffff810b4684>]
__irq_exit_rcu+0x84/0xa0
[  227.932568] softirqs last disabled at (10723): [<ffffffff810b4684>]
__irq_exit_rcu+0x84/0xa0
[  227.933494] ---[ end trace 0000000000000000 ]---
[  227.933992] BTRFS: error (device dm-3 state EA) in
btrfs_insert_one_raid_extent:116: errno=3D-17 Object already exists
[  227.935193] BTRFS warning (device dm-3 state EA): Skipping commit of
aborted transaction.
[  227.936383] BTRFS: error (device dm-3 state EA) in
cleanup_transaction:2018: errno=3D-17 Object already exists

But not that ASSERT() yet.

I guess I need the first patch to pass this first?

Thanks,
Qu

