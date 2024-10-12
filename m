Return-Path: <linux-btrfs+bounces-8874-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D01099B256
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Oct 2024 10:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBE2C1F22C72
	for <lists+linux-btrfs@lfdr.de>; Sat, 12 Oct 2024 08:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACF7149DF0;
	Sat, 12 Oct 2024 08:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="dOnVwjGT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4526DD517
	for <linux-btrfs@vger.kernel.org>; Sat, 12 Oct 2024 08:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728723339; cv=none; b=DCxdAIWH+PH+p2+OuYTEAf47NaPHs47DLD6v8vvoR2e5oH/LVpPQC4jEeB1Qj5KITsQARztw4gx0VReqWSA706MB7US9MgOC4o+LH/YOWlte8ZyGM71RP6gY74OXwg9otZzgFKy007bGZWN4t8OLXB6uYHH9qoQwEsGDYctMMsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728723339; c=relaxed/simple;
	bh=QCfBYTTAOT/2e9q/0DSr2zXwGFNCT94JKGeSEtoUjvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Yaupk8x8/dLCB+jN75NfFeEpcA5grrpy+SIw9hkPVAfCQFrOLfToX225BGKSwMUID9R0bKG2HUkxnMCmABzYMSReh3u7D63/+/JdfA2Uocn7BFaFJ0pS1fu1v+FPb2njagvD1jZkYha0iGvEBolax1JGRHi7IerXhaSDmDsp7Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=dOnVwjGT; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1728723333; x=1729328133; i=quwenruo.btrfs@gmx.com;
	bh=LYwz5GDM5SCxFlO8ROEE7JKoRUA79ry0A6g6wjIB/DM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dOnVwjGTvPKQPYVDudH7Od2dYWR6xN8q4HWLH3is9yL5OqZ+eE7igOqMKxw/fgHE
	 O0IlhthBhf6O8UbNUE1/158BN1z5atVHQEgOkGnOYg1ksNGiE+ujEuCO/XkAlDnXH
	 fNC226ZAp89s0LGDrp5o5myTxOvpFrESwv2HbcBFjfscqmhPKVYWZ/L2aSzMKS/tk
	 0kkEy5ko4dqMgJpERPKDZixSqG70TksHWwjXPKdWp4htErPKm8Nn7S7d8T6xf1D8v
	 t/ewqo+omP91IY37IHsINLVJshrkage0Aa/ssVivnmN+r1m4LHzLBH8tjWppB/JrY
	 vaF7R4q3lgNieWKLfQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N2E1G-1txf5O2Big-016fxX; Sat, 12
 Oct 2024 10:55:33 +0200
Message-ID: <b24060dd-0358-4b42-b182-e0c861ab77e3@gmx.com>
Date: Sat, 12 Oct 2024 19:25:29 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ENOSPC in btrfs_delete_unused_bgs (6.6)
To: Martin Raiber <martin@urbackup.org>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <010201927fc76ecd-1130f575-7e05-469b-a721-d4ef98432dfe-000000@eu-west-1.amazonses.com>
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
In-Reply-To: <010201927fc76ecd-1130f575-7e05-469b-a721-d4ef98432dfe-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MqqV7HKuyDeMcF5ekErrwOT0RpnCxD9ZDglrpYrYmvaxjmRPRdN
 jgQ+fiUbhjCQhTYsy8HnpHe37l6CGoW6x2XNd+DbpbtBW7EzjmDnCyjsWA/m/4rNrak3cGl
 AO8M5j6lW3AmNRPYrEgUaL/c8HEkdrhHLzulfb5IZaFyKcBrLn/1aGujDJ8qUuVEfyHsmt4
 +ahhk/hlOY9KwPp6ZGscA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pQGNHFjAQko=;UrJHce9vzNoe7eMRTF+9GfRCSd1
 uqteDpcfchYQp3gQBAkQLK1bkILPqP2NVkLgb6yJ6cekviAw+M9AAP9VQxULw6YBjXd56JCIo
 BHHl8QOtf0onO71MenXmRhGI6s/pFWPlvu2DMQpBfee0i/AzaaTfH5/oUz0g8ozetJc6tXVEY
 LuASV+byRsWfWCk/0+BGXHX1CG8wGIDSmZaz2kzszau9CMwv27U286cseQbF8RDGVgNBQlzDb
 nUWoDxUcZk6ZAe7HWxLAwg2W0XHgJSmvolXs1KeAIs7gwew2yUEZIAncNeyStN9HV84IFXdS0
 XXiHo3U6ecW6RM36HhIq3w4ETPQYdqb9fJLvUSgb4QEk646uwcjQh1JRKseyoItuTjAjtEmbY
 p3K7wHnm7kfUxcCzIcLkXlqPlNwRXnuswxN4KoA5D/nvO19ChVTmMFB07oAAwVTnQikTrctRx
 HgBNP7bJ6LGGIqEb/50MmO0KL3Oi7XH/HZ1bgVhLHCKaY6VHSQKW2/cjIZ3Wf1kaDJBPDhhpR
 K1oEY0MY5Z/RNjPZfiVw8pIkuqZqmoRFCO5Cu8NKxvdf+uXkUzF9HTaXK0LRw7AbVZjWrqRo4
 LqyyXSkMxpNeXSKZpNVMDZeEL7NWajXASVdnOqcWiI1YtwgBvFe9yokCmGih/qYSI7vnTQnx/
 cKj5MMSYDGRwCgVy/bNRKt82omx6Hr/Y97YtUPDH7EGseu/HyE9PcXkEZSo8YGv847d1y6gDf
 gmuYgrYc7SWMSblPdeFNwUcNKjAzUtE1vstsuQsqn6uQNtvpcRSjiLBaeBibYyjfH1iozFu9G
 RgUtC/2JEuSGxUcIHn3LECgw==



=E5=9C=A8 2024/10/12 18:40, Martin Raiber =E5=86=99=E9=81=93:
> Hi,
>
> currently getting following ENOSPC, remount to read-only after running f=
or a few days:
>
>
> [286211.180852] ------------[ cut here ]------------
> [286211.180856] BTRFS: Transaction aborted (error -28)
> [286211.180889] WARNING: CPU: 4 PID: 7160 at fs/btrfs/volumes.c:3198 btr=
fs_remove_chunk+0x96e/0x990
> [286211.180898] Modules linked in: loop dm_crypt bfq xfs raid1 md_mod dm=
_mod st sr_mod cdrom bridge stp llc ext4 intel_rapl_msr crc16 intel_rapl_c=
ommon mbcache jbd2 ghash_clmulni_intel sha512_ssse3 sha256_ssse3 sha1_ssse=
3 snd_pcm sg hyperv_drm snd_timer drm_shmem_helper hyperv_key>
> [286211.181012] CPU: 4 PID: 7160 Comm: btrfs-cleaner Tainted: G=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 6.6.54 #2
> [286211.181016] Hardware name: Microsoft Corporation Virtual Machine/Vir=
tual Machine, BIOS 090007=C2=A0 05/18/2018
> [286211.181019] RIP: 0010:btrfs_remove_chunk+0x96e/0x990
> [286211.181024] Code: c5 fe ff ff be fb ff ff ff 48 c7 c7 20 71 b1 9b e8=
 87 59 b4 ff 0f 0b e9 df fe ff ff 89 ce 48 c7 c7 20 71 b1 9b e8 72 59 b4 f=
f <0f> 0b 8b 0c 24 e9 54 ff ff ff 89 ee 48 c7 c7 20 71 b1 9b e8 5a 59
> [286211.181027] RSP: 0018:ffffacbecf35fd70 EFLAGS: 00010286
> [286211.181031] RAX: 0000000000000000 RBX: ffff988e93a10d80 RCX: 0000000=
000000027
> [286211.181034] RDX: ffff9892b92213c8 RSI: 0000000000000001 RDI: ffff989=
2b92213c0
> [286211.181036] RBP: ffff988f186e2670 R08: 0000000000000000 R09: ffffacb=
ecf35fc08
> [286211.181039] R10: 0000000000000003 R11: ffffffff9c1e2408 R12: 00056d6=
f6c180000
> [286211.181041] R13: ffff988eb96dc888 R14: 0000000000000001 R15: ffff988=
b5343a640
> [286211.181044] FS:=C2=A0 0000000000000000(0000) GS:ffff9892b9200000(000=
0) knlGS:0000000000000000
> [286211.181047] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [286211.181050] CR2: 00007f1a32634340 CR3: 00000004773b0000 CR4: 0000000=
0003506e0
> [286211.181054] Call Trace:
> [286211.181057]=C2=A0 <TASK>
> [286211.181060]=C2=A0 ? btrfs_remove_chunk+0x96e/0x990
> [286211.181064]=C2=A0 ? __warn+0x81/0x130
> [286211.181071]=C2=A0 ? btrfs_remove_chunk+0x96e/0x990
> [286211.181076]=C2=A0 ? report_bug+0x171/0x1a0
> [286211.181081]=C2=A0 ? srso_return_thunk+0x5/0x5f
> [286211.181086]=C2=A0 ? prb_read_valid+0x1b/0x30
> [286211.181093]=C2=A0 ? handle_bug+0x41/0x70
> [286211.181097]=C2=A0 ? exc_invalid_op+0x17/0x70
> [286211.181101]=C2=A0 ? asm_exc_invalid_op+0x1a/0x20
> [286211.181111]=C2=A0 ? btrfs_remove_chunk+0x96e/0x990
> [286211.181122]=C2=A0 btrfs_delete_unused_bgs+0x70e/0x9b0
> [286211.181134]=C2=A0 ? __pfx_cleaner_kthread+0x10/0x10
> [286211.181139]=C2=A0 cleaner_kthread+0xf5/0x130
> [286211.181144]=C2=A0 kthread+0xe8/0x120
> [286211.181149]=C2=A0 ? __pfx_kthread+0x10/0x10
> [286211.181153]=C2=A0 ret_from_fork+0x34/0x50
> [286211.181159]=C2=A0 ? __pfx_kthread+0x10/0x10
> [286211.181162]=C2=A0 ret_from_fork_asm+0x1b/0x30
> [286211.181173]=C2=A0 </TASK>
> [286211.181175] ---[ end trace 0000000000000000 ]---
> [286211.181178] BTRFS info (device loop0: state A): dumping space info:
> [286211.181181] BTRFS info (device loop0: state A): space_info DATA has =
2241260216320 free, is not full
> [286211.181185] BTRFS info (device loop0: state A): space_info total=3D2=
7155909967872, used=3D7519504883712, pinned=3D0, reserved=3D5688012247040,=
 may_use=3D11706058747904, readonly=3D1073872896 zone_unusable=3D0
> [286211.181191] BTRFS info (device loop0: state A): space_info METADATA =
has 128141934592 free, is not full
> [286211.181194] BTRFS info (device loop0: state A): space_info total=3D3=
46287833088, used=3D199112523776, pinned=3D212992, reserved=3D24543232, ma=
y_use=3D19008618496, readonly=3D0 zone_unusable=3D0
> [286211.181199] BTRFS info (device loop0: state A): space_info SYSTEM ha=
s 0 free, is not full
> [286211.181202] BTRFS info (device loop0: state A): space_info total=3D4=
194304, used=3D3358720, pinned=3D32768, reserved=3D802816, may_use=3D0, re=
adonly=3D0 zone_unusable=3D0
> [286211.181207] BTRFS info (device loop0: state A): global_block_rsv: si=
ze 536870912 reserved 536002560
> [286211.181210] BTRFS info (device loop0: state A): trans_block_rsv: siz=
e 1048576 reserved 1048576
> [286211.181213] BTRFS info (device loop0: state A): chunk_block_rsv: siz=
e 0 reserved 0
> [286211.181216] BTRFS info (device loop0: state A): delayed_block_rsv: s=
ize 1572864 reserved 1572864
> [286211.181219] BTRFS info (device loop0: state A): delayed_refs_rsv: si=
ze 17007902720 reserved 17007902720
> [286211.181222] BTRFS: error (device loop0: state A) in btrfs_remove_chu=
nk:3198: errno=3D-28 No space left
> [286211.181252] BTRFS info (device loop0: state EA): forced readonly
>
>
> The device should have plenty of free space:
>
> Overall:
>  =C2=A0=C2=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 28.08TiB
>  =C2=A0=C2=A0=C2=A0 Device allocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 25.07TiB
>  =C2=A0=C2=A0=C2=A0 Device unallocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.02TiB
>  =C2=A0=C2=A0=C2=A0 Device missing:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B
>  =C2=A0=C2=A0=C2=A0 Device slack:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1023.97PiB
>  =C2=A0=C2=A0=C2=A0 Used:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 22.79TiB
>  =C2=A0=C2=A0=C2=A0 Free (estimated):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.16TiB=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (min: 5.16TiB)
>  =C2=A0=C2=A0=C2=A0 Free (statfs, df):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.16TiB
>  =C2=A0=C2=A0=C2=A0 Data ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 1.00
>  =C2=A0=C2=A0=C2=A0 Metadata ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1=
.00
>  =C2=A0=C2=A0=C2=A0 Global reserve:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 512.00MiB=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (used: 0.00B)
>  =C2=A0=C2=A0=C2=A0 Multiple profiles:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
>
> Data,single: Size:24.75TiB, Used:22.61TiB (91.36%)
>  =C2=A0=C2=A0 /dev/loop0=C2=A0=C2=A0=C2=A0=C2=A0 24.75TiB
>
> Metadata,single: Size:322.50GiB, Used:187.11GiB (58.02%)
>  =C2=A0=C2=A0 /dev/loop0=C2=A0=C2=A0=C2=A0 322.50GiB
>
> System,single: Size:4.00MiB, Used:3.20MiB (80.08%)
>  =C2=A0=C2=A0 /dev/loop0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4.00MiB

This should be the cause, I have never seen a case where SYSTEM chunk is
causing problems.

Have you tried to mount the fs, and balance system chunks to see if it
helps?

# btrfs balance start -s <mnt>

Otherwise it's indeed a bug we need to fix.

Thanks,
Qu
>
> Unallocated:
>  =C2=A0=C2=A0 /dev/loop0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.02TiB
>
> Regards,
>
> Martin
>
>


