Return-Path: <linux-btrfs+bounces-20524-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA31BD213F2
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 21:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44DAD301738E
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 20:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926FB357A30;
	Wed, 14 Jan 2026 20:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="KnRZNyFa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAA3352C41
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 20:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768424235; cv=none; b=sXS4t3ldKtgNXbQAsEnqVcskObCYZaqudL1FEHHz9hVyVVY53tDpqExw4TXr3Gz1BT7vB5zANreQKOGlfa62Okxm6ZGdUuk8LrhvOeXyc2jdriJvgvizkx5qVGh+oSyrLjc5oqBOYKsfmkZL3dm7BBj2mZ0JvAoxuWWc1W4PCKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768424235; c=relaxed/simple;
	bh=pKt3B7ItzK1+OZX6A/c4yqCuIOs6t+OBYf5EQ3bhPks=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KuK+dwOf9AwkJ4ySjacmEAeT6t0ZjeuW9VMsXYQ36q1/DNgMxUEumfakcZHjmh40eUoFq94bnI2U9CtD6sItQKLELsrj7+73K8am6QUPIH1xegZsmKIi9eQrgQtUd9Uh0M5AzH4eO6kGQzect4NvvfX039rz05dQOZ17hYPGy2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=KnRZNyFa; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1768424231; x=1769029031; i=quwenruo.btrfs@gmx.com;
	bh=fAD8SuzRTcvuLj56HxgNUYgQMl4qDRdELthKpuZh5/4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KnRZNyFanzYdTDxb+3Q4N+Mn92AmxjfMqY0KoMH9j235mltlHGLGgT89/xr7zI/+
	 5eUSRw7afsZlCCPHLc+Kl7QSGOP4/xZyV8/cNV/vuamdsxgi4mLYcp0+gL7Z3IfhY
	 7SnEJ9hHs1JfX86zdNiakWd3hrOJW3WlW+hEEXLAqAVln8ko6Ux8VtTgjSfD/lv20
	 nnZ6PM+T6ru1Ze3jXs+KtmECgG41WTyzr2I/pwMD+kohpsvQYY3fqhoaaeSM2XbKi
	 c3bB7dzex/1MK3/UIOjHn8sy1elnnl9dHf2/o+9CG8VYNIeXa8e4LweELh23tzV0h
	 SZi4yPTkE7yOXPVS3g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3siG-1vpARy4Aim-017wF2; Wed, 14
 Jan 2026 21:57:11 +0100
Message-ID: <12a4bcff-0cd5-4c20-8e15-67d9e6e854b5@gmx.com>
Date: Thu, 15 Jan 2026 07:27:08 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs stopps working when stressed
To: Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.com>,
 "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <SA1PR18MB56922F690C5EC2D85371408B998FA@SA1PR18MB5692.namprd18.prod.outlook.com>
 <f53f9520-9168-49a3-8354-33d90d2ee3e5@gmx.com>
 <SA1PR18MB5692EBE3FFC7694F733E6007998FA@SA1PR18MB5692.namprd18.prod.outlook.com>
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
In-Reply-To: <SA1PR18MB5692EBE3FFC7694F733E6007998FA@SA1PR18MB5692.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f0qMJBdbu6tFp2tZrnx8xIt+mYHGJyQWBM6o0TCHrk5XW68DYGT
 gVTmZi5msd48Cd/5F7y6IvofWdG34D6Wh0P7cwYsHrTuaVyqmtVeIDKUxpVYhoXvWUsEk4l
 +UvXY9Qxvg0qGjhv7UcTn5yP6YdN1pd77qFQ3kZm/ZeDCxKKgo29D0Ho2HhziEsA8srkZBS
 I/mVlZ9rD1osCFDKFACBw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:a6HKcDEO4yE=;ri+l/b8xUFhQYLQXjC4n+bdtVsy
 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
 RAXGL1gA=



=E5=9C=A8 2026/1/15 00:34, Aleksandar Gerasimovski =E5=86=99=E9=81=93:
> Hi Qu,
>=20
> Many thanks for answering:
>=20
> No, our setup has single device (btrfs output is posted below).
>=20
> We are on an embedded device so the specific partition with btrfs is 1Gi=
B, so if you really suggest 10GiB minimum than do we indeed do wrong FS se=
lection?

OK, there is a real bug.

The problem is, when the failure happened, there are only around 350MiB=20
utilized, not 1GiB.

The metadata over-allocation decision is correct as we should be able to=
=20
allocate new metadata chunks.

Thanks,
Qu

>=20
> We could for sure try if mixed-bg improves the robustness.
> Is this known limitation of the btrfs?
>=20
> BTRFS status before the test:
> ------------------------------------------------------------
> # btrfs filesystem usage /mnt/data
> Overall:
>      Device size:                   1.00GiB
>      Device allocated:            350.38MiB
>      Device unallocated:          673.62MiB
>      Device missing:                  0.00B
>      Device slack:                    0.00B
>      Used:                         20.80MiB
>      Free (estimated):            885.20MiB      (min: 548.39MiB)
>      Free (statfs, df):           884.20MiB
>      Data ratio:                       1.00
>      Metadata ratio:                   2.00
>      Global reserve:                5.50MiB      (used: 0.00B)
>      Multiple profiles:                  no
>=20
> Data,single: Size:232.00MiB, Used:20.43MiB (8.80%)
>     /dev/mmcblk1p9        232.00MiB
>=20
> Metadata,DUP: Size:51.19MiB, Used:176.00KiB (0.34%)
>     /dev/mmcblk1p9        102.38MiB
>=20
> System,DUP: Size:8.00MiB, Used:16.00KiB (0.20%)
>     /dev/mmcblk1p9         16.00MiB
>=20
> Unallocated:
>     /dev/mmcblk1p9        673.62MiB
> -------------------------------------------------------
>=20
> ------------------------------------------------------
> # btrfs filesystem df /mnt/data/
> Data, single: total=3D232.00MiB, used=3D20.43MiB
> System, DUP: total=3D8.00MiB, used=3D16.00KiB
> Metadata, DUP: total=3D51.19MiB, used=3D176.00KiB
> GlobalReserve, single: total=3D5.50MiB, used=3D0.00B
>=20
> Running the test:
> # bonnie++ -d test/ -m NITROC -u 0 -s 256M -r 128M -b
> Using uid:0, gid:0.
> Writing a byte at a time...done
> Writing intelligently...done
> Rewriting...done
> Reading a byte at a time...done
> Reading intelligently...done
> start 'em...done...done...done...done...done...
> Create files in sequential order...[  971.162957] BTRFS warning (device =
mmcblk1p9): Skipping commit of aborted transaction.
> [  971.170964] ------------[ cut here ]------------
> [  971.175668] BTRFS: Transaction aborted (error -28)
> [  971.180579] WARNING: CPU: 2 PID: 845 at /fs/btrfs/transaction.c:2027 =
btrfs_commit_transaction+0x9ec/0xb34
> [  971.190238] Modules linked in: omap_rng rng_core mac80211(O) cfg80211=
(O) firmware_class compat(O)
> [  971.199251] CPU: 2 UID: 0 PID: 845 Comm: bonnie++ Tainted: G         =
  O       6.12.62-coreos-cn913x-tiny #1
> [  971.209161] Tainted: [O]=3DOOT_MODULE
> [  971.212684] Hardware name: belden nitroc VNX/NetModule CN9131 based N=
ITROC platform V1, BIOS 2024.10-g97cd8f3422eb 10/01/2024
> [  971.224059] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTY=
PE=3D--)
> [  971.231082] pc : btrfs_commit_transaction+0x9ec/0xb34
> [  971.236182] lr : btrfs_commit_transaction+0x9ec/0xb34
> [  971.241281] sp : ffff8000822a3c70
> [  971.244628] x29: ffff8000822a3ca0 x28: ffff0001012a3000 x27: ffff0001=
012a3c9c
> [  971.251854] x26: ffff0001012a3000 x25: ffff000100432b90 x24: ffff0001=
00432b90
> [  971.259076] x23: ffff000100432a78 x22: ffff0001012a3000 x21: ffff0001=
00432b28
> [  971.266294] x20: 00000000ffffffe4 x19: ffff0001012e4c00 x18: 00000000=
0000000a
> [  971.273513] x17: 0000000000000000 x16: 0000000000000000 x15: ffff8000=
822a36d0
> [  971.280732] x14: 0000000000000000 x13: 2938322d20726f72 x12: 72652820=
64657472
> [  971.287951] x11: 0000000000000293 x10: ffff800080f0a730 x9 : ffff8000=
80f62760
> [  971.295170] x8 : ffff00013f795708 x7 : ffff00013f795708 x6 : ffff0001=
3f7976f0
> [  971.302387] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 00000000=
00000000
> [  971.309604] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0001=
0f911e00
> [  971.316821] Call trace:
> [  971.319298]  btrfs_commit_transaction+0x9ec/0xb34
> [  971.324051]  btrfs_sync_file+0x43c/0x488
> [  971.328028]  vfs_fsync_range+0x68/0x84
> [  971.331833]  vfs_fsync+0x1c/0x28
> [  971.335108]  do_fsync+0x30/0x58
> [  971.338296]  __arm64_sys_fsync+0x18/0x28
> [  971.342272]  invoke_syscall.constprop.0+0x74/0xc8
> [  971.347034]  do_el0_svc+0x90/0xb0
> [  971.350396]  el0_svc+0xbc/0x104
> [  971.353581]  el0t_64_sync_handler+0x84/0x12c
> [  971.357899]  el0t_64_sync+0x190/0x194
> [  971.361604] ---[ end trace 0000000000000000 ]---
> [  971.366654] BTRFS info (device mmcblk1p9 state A): dumping space info=
:
> [  971.373230] BTRFS info (device mmcblk1p9 state A): space_info DATA ha=
s 562245632 free, is not full
> [  971.382247] BTRFS info (device mmcblk1p9 state A): space_info total=
=3D583663616, used=3D21417984, pinned=3D0, reserved=3D0, may_use=3D0, read=
only=3D0 zone_unusable=3D0
> [  971.396066] BTRFS info (device mmcblk1p9 state A): space_info METADAT=
A has -5767168 free, is full
> [  971.404994] BTRFS info (device mmcblk1p9 state A): space_info total=
=3D53673984, used=3D475136, pinned=3D53116928, reserved=3D16384, may_use=
=3D5767168, readonly=3D65536 zone_unusable=3D0
> [  971.420375] BTRFS info (device mmcblk1p9 state A): space_info SYSTEM =
has 8355840 free, is not full
> [  971.429389] BTRFS info (device mmcblk1p9 state A): space_info total=
=3D8388608, used=3D16384, pinned=3D16384, reserved=3D0, may_use=3D0, reado=
nly=3D0 zone_unusable=3D0
> [  971.443110] BTRFS info (device mmcblk1p9 state A): global_block_rsv: =
size 5767168 reserved 5767168
> [  971.452117] BTRFS info (device mmcblk1p9 state A): trans_block_rsv: s=
ize 0 reserved 0
> [  971.459991] BTRFS info (device mmcblk1p9 state A): chunk_block_rsv: s=
ize 0 reserved 0
> [  971.467865] BTRFS info (device mmcblk1p9 state A): delayed_block_rsv:=
 size 0 reserved 0
> [  971.475915] BTRFS info (device mmcblk1p9 state A): delayed_refs_rsv: =
size 0 reserved 0
> [  971.483876] BTRFS: error (device mmcblk1p9 state A) in cleanup_transa=
ction:2027: errno=3D-28 No space left
> [  971.493414] BTRFS info (device mmcblk1p9 state EA): forced readonly
> Can't sync directory, turning off dir-sync.
> Can't create file 000000028fIyc
> Cleaning up test directory after error.
> Bonnie: drastic I/O error (rmdir): Read-only file system
> ------------------------------------------------------------------------
>=20
> BTRFS status after the failing test:
> ---------------------------------------------
> # btrfs filesystem usage /mnt/data
> Overall:
>      Device size:                   1.00GiB
>      Device allocated:            675.00MiB
>      Device unallocated:          349.00MiB
>      Device missing:                  0.00B
>      Device slack:                    0.00B
>      Used:                         21.36MiB
>      Free (estimated):            885.20MiB      (min: 710.70MiB)
>      Free (statfs, df):           884.20MiB
>      Data ratio:                       1.00
>      Metadata ratio:                   2.00
>      Global reserve:                5.50MiB      (used: 0.00B)
>      Multiple profiles:                  no
>=20
> Data,single: Size:556.62MiB, Used:20.43MiB (3.67%)
>     /dev/mmcblk1p9        556.62MiB
>=20
> Metadata,DUP: Size:51.19MiB, Used:464.00KiB (0.89%)
>     /dev/mmcblk1p9        102.38MiB
>=20
> System,DUP: Size:8.00MiB, Used:16.00KiB (0.20%)
>     /dev/mmcblk1p9         16.00MiB
>=20
> Unallocated:
>     /dev/mmcblk1p9        349.00MiB
> -------------------------------------------------
>=20
> Regards,
> Aleksandar
>=20
> From: Qu Wenruo <quwenruo.btrfs@gmx.com>
> Sent: Wednesday, January 14, 2026 11:06 AM
> To: Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.com>; linux-=
btrfs@vger.kernel.org
> Subject: Re: btrfs stopps working when stressed
>=20
> =E5=9C=A8 2026/1/14 19:=E2=80=8A55, Aleksandar Gerasimovski =E5=86=99=E9=
=81=93: > Hello everyone, > > I'm looking for a solution for a problem tha=
t we have with the btrfs. > > We have tried to do some initial investigati=
on on our side however we have limited
>=20
>=20
>=20
> =E5=9C=A8 2026/1/14 19:55, Aleksandar Gerasimovski =E5=86=99=E9=81=93:
>> Hello everyone,
>>
>> I'm looking for a solution for a problem that we have with the btrfs.
>>
>> We have tried to do some initial investigation on our side however we h=
ave limited knowledge and experience in this area.
>> I hope you can give us some pointers how to investigate this further an=
d in what corners we shall start looking.
>>
>> So, on our products using the btrfs we see that the filesystem sometime=
s stops working when we stress it with bonnie++ tool.
>> We see the problem with mainstream 6.12 and 6.18 Kernels, our current g=
uess from the debugging done so far is that
>> we run in kind of a concurrency	and/or scheduling issue were the asynch=
ron meta data space reclaiming is not executed on time,
>> and this leads to metadata space to not be free up on time for the new =
data. We can even see that adding a printk trace in a specific
>> point is covering the problem.
>=20
> Did your setup have multiple devices involved?
>=20
> If so there is a known bug that slightly unbalanced device size can
> trick btrfs into it can still over-commit metadata, but it can not in
> fact and error out at one of the critical path that we can not do
> anything but aborting the transaction.
>=20
>=20
> Although even without that specific quirk, it's still known that btrfs
> has some other problems related to metadata space reservation.
>=20
>>
>> To reproduce the problem, we run: "bonnie++ -d test/ -m BTRFS -u 0 -s 2=
56M -r 128M -b"
>> Note that the tested partition is for sure not full we have 800MB space=
 there and we test with 256MB so it's not a space issue.
>=20
> Unfortunately it's too small for btrfs.
>=20
> Btrfs has the requirement to strictly split metadata and data space,
> thus it's possible to let unbalanced metadata and data chunk usage to
> exhaust one while the other has a lot of free space.
>=20
> You can consider it as the ext4/xfs inode number limits vs data space
> usage. One can exhaust all the available inodes way before exhausting
> the available data.
>=20
> It's just way worse in btrfs for smaller fses.
>=20
> [...]
>> [ 174.013001] BTRFS info (device mmcblk0p7 state A): space_info DATA ha=
s 234418176 free, is not full
>> [ 174.022018] BTRFS info (device mmcblk0p7 state A): space_info total=
=3D255852544, used=3D21434368, pinned=3D0, reserved=3D0, may_use=3D0, read=
only=3D0 zone_unusable=3D0
>=20
> You have only 244MiB of data chunk, which is already tiny for btrfs.
> The worse part is, there is only 20MiB utilized
>=20
>> [ 174.035829] BTRFS info (device mmcblk0p7 state A): space_info METADAT=
A has -5767168 free, is full
>> [ 174.044752] BTRFS info (device mmcblk0p7 state A): space_info total=
=3D53673984, used=3D1146880, pinned=3D52445184, reserved=3D16384, may_use=
=3D5767168, readonly=3D65536 zone_unusable=3D0
>=20
> Your metadata is tiny, only less than 52MiB (and will be doubled by the
> default DUP profile for single dev setup).
>=20
> This means your fs is only around 350MiB?
>=20
> This is definitely not a good disk size for btrfs.
>=20
> My recommendation for any btrfs is at least 10GiB.
>=20
> This will allow btrfs to use 1Gib chunk stripe size (the max), so that
> we won't have those tiny metadata blocks, and greatly reduce the problem
> caused by unbalacned data/metadata.
>=20
>=20
> But still, flipping RO is not a good behavior, although in such small
> fs, you may have a better experience using mixed-bg feature, which will
> let data and metadata share the same block groups, resolving the
> unbalance problem (but introducing more limits).
>=20
> Thanks,
> Qu
>=20
>> [ 174.060221] BTRFS info (device mmcblk0p7 state A): space_info SYSTEM =
has 8355840 free, is not full
>> [ 174.069252] BTRFS info (device mmcblk0p7 state A): space_info total=
=3D8388608, used=3D16384, pinned=3D16384, reserved=3D0, may_use=3D0, reado=
nly=3D0 zone_unusable=3D0
>> [ 174.082979] BTRFS info (device mmcblk0p7 state A): global_block_rsv: =
size 5767168 reserved 5767168
>> [ 174.091989] BTRFS info (device mmcblk0p7 state A): trans_block_rsv: s=
ize 0 reserved 0
>> [ 174.099865] BTRFS info (device mmcblk0p7 state A): chunk_block_rsv: s=
ize 0 reserved 0
>> [ 174.107739] BTRFS info (device mmcblk0p7 state A): delayed_block_rsv:=
 size 0 reserved 0
>> [ 174.115794] BTRFS info (device mmcblk0p7 state A): delayed_refs_rsv: =
size 0 reserved 0
>> [ 174.123787] BTRFS: error (device mmcblk0p7 state A) in cleanup_transa=
ction:2027: errno=3D-28 No space left
>> [ 174.133336] BTRFS info (device mmcblk0p7 state EA): forced readonly
>> Can't sync file.
>> Cleaning up test directory after error.
>> Bonnie: drastic I/O error (rmdir): Read-only file system
>> ------------------------------------------------
>>
>> Trying to follow the "btrfs_add_bg_to_space_info" that is in "async_rec=
laim_work" context:
>> -------------------------------------------------
>> @@ -322,15 +322,21 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_i=
nfo *info,
>>           struct btrfs_space_info *found;
>>           int factor, index;
>>
>>           factor =3D btrfs_bg_type_to_factor(block_group->flags);
>>
>>           found =3D btrfs_find_space_info(info, block_group->flags);
>>           ASSERT(found);
>>           spin_lock(&found->lock);
>> +       pr_info("%s(%d): %s %lld %lld\n", __func__, __LINE__, space_inf=
o_flag_to_str(found), found->total_bytes, block_group->length);
>> +       // OK: trigger twice free space is freed at second attempt.
>> +       // METADATA 53673984 6291456
>> +       // ..
>> +       // METADATA 59965440 117440512
>> +
>> +       // KO: triggered one, no space
>> +       // METADATA 53673984 6291456
>> +       // crash...
>> -------------------------------------------------
>>
>> Also maybe interesting to know is that trying to trace (printk) "btrfs_=
add_bg_to_space_info" influence the reproducibility.
>>
>> Any hints to resolve this problem are welcome.
>>
>> Regards,
>> Aleksandar
>>
>>
>>
>>
>> **********************************************************************
>> DISCLAIMER:
>> Privileged and/or Confidential information may be contained in this mes=
sage. If you are not the addressee of this message, you may not copy, use =
or deliver this message to anyone. In such event, you should destroy the m=
essage and kindly notify the sender by reply e-mail. It is understood that=
 opinions or conclusions that do not relate to the official business of th=
e company are neither given nor endorsed by the company. Thank You.
>>
>=20
> **********************************************************************
> DISCLAIMER:
> Privileged and/or Confidential information may be contained in this mess=
age. If you are not the addressee of this message, you may not copy, use o=
r deliver this message to anyone. In such event, you should destroy the me=
ssage and kindly notify the sender by reply e-mail. It is understood that =
opinions or conclusions that do not relate to the official business of the=
 company are neither given nor endorsed by the company. Thank You.
>=20


