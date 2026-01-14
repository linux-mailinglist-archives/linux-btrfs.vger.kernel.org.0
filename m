Return-Path: <linux-btrfs+bounces-20497-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E169D1DD83
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 11:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2879304BC93
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 Jan 2026 10:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A0638BDD0;
	Wed, 14 Jan 2026 10:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="rv8L17Hd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381D7389E16
	for <linux-btrfs@vger.kernel.org>; Wed, 14 Jan 2026 10:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768385153; cv=none; b=loq9pqU5rJC66FKdeQdhRfRKt0N4qMjdtexOCPFv69goheEr4TS0KnV3k4X9vlwdFfdwNn+v+2X79eoMraoWtpGPBHyZKYxdd/ipz816oDtxXOVk58JVcEU0Nfw80ZKNbyA9l/EqRxO3qgqecEEH0F4UtrSi1Lab1YQGCbRIZWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768385153; c=relaxed/simple;
	bh=1UTDk4pQeFdhEXdUi2oLwZCdErgPM1QpG/UQgmKBL74=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gmwOi45wU6EKXOVMTGWcfiULxdVzO8mMj7qs4/wOj/VHdQcrkuZ4BrQvQQph77hbsInvndBk3LP4JI/3A//mCmqEOkNhrSLvnm39EAC0XyJBSQ06TFFb51bn98wzOfn7taIFuzR4wkIimsIdc1D8WyN5poy2sj/YcrBrGJ/FuAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=rv8L17Hd; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1768385148; x=1768989948; i=quwenruo.btrfs@gmx.com;
	bh=iRWQVKl5Q5qdnpHe+SRWEQMwuVh8cxWi5BShbp1d1C4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=rv8L17HdSOZweC+Iv+gkBll0jLESx1PCWE4PFLthxj0GET/8uoPKe78qNlLx+sqc
	 Z24RzW/7eOSlqj3sWt39AE66JgrTfAp1kdqy9M5rwVV2UKrFWNvdysV9EggSSuZzA
	 I2ZNQIZrhtWhZl+R8O/p91WpXdfHjtuJshSz9uayCRqlUUlnR2lI00KFktw7AN3Ny
	 WjVRi67MWZ8YP6/exEC3I37IZWaJ6DuGIk40nqmphLWwNhTwlONtzvgPEt1O867N8
	 zqOE5s7Trf9YDGUES/pheCZa6JBL0PkjlMU9cErQrRwOSNlrUzLTyGpIlRmUnKpGO
	 K/c7+Kg6hab8ENZ+7w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MhD6W-1wJABl2K1K-00dJop; Wed, 14
 Jan 2026 11:05:48 +0100
Message-ID: <f53f9520-9168-49a3-8354-33d90d2ee3e5@gmx.com>
Date: Wed, 14 Jan 2026 20:35:44 +1030
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
In-Reply-To: <SA1PR18MB56922F690C5EC2D85371408B998FA@SA1PR18MB5692.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eOX7FlRrmLMB2oAym64lJ2yRlFTSv0o4HZ3FoYGEMhySTHd+8k0
 MTVdXsO0EXTAqvgVTLQwLtFbh2o3se2klVgwd+VZbizXyUmHwLaoE8cwnKeTa0Kt/Nfn5Jv
 wduk2IOEFmdG41g9hfWorS9erV5ynCAYNMh/EcDkItv4h3U0FvnPp/8A3srRr5LMtp8E0qe
 4JGulKN73lPvbdduQDbfA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PJjGumIJL2Q=;7Mg50gFOdlFMfefV1VWFwqaFShJ
 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
 gbDisffs=



=E5=9C=A8 2026/1/14 19:55, Aleksandar Gerasimovski =E5=86=99=E9=81=93:
> Hello everyone,
>=20
> I'm looking for a solution for a problem that we have with the btrfs.
>=20
> We have tried to do some initial investigation on our side however we ha=
ve limited knowledge and experience in this area.
> I hope you can give us some pointers how to investigate this further and=
 in what corners we shall start looking.
>=20
> So, on our products using the btrfs we see that the filesystem sometimes=
 stops working when we stress it with bonnie++ tool.
> We see the problem with mainstream 6.12 and 6.18 Kernels, our current gu=
ess from the debugging done so far is that
> we run in kind of a concurrency	and/or scheduling issue were the asynchr=
on meta data space reclaiming is not executed on time,
> and this leads to metadata space to not be free up on time for the new d=
ata. We can even see that adding a printk trace in a specific
> point is covering the problem.

Did your setup have multiple devices involved?

If so there is a known bug that slightly unbalanced device size can=20
trick btrfs into it can still over-commit metadata, but it can not in=20
fact and error out at one of the critical path that we can not do=20
anything but aborting the transaction.


Although even without that specific quirk, it's still known that btrfs=20
has some other problems related to metadata space reservation.

>=20
> To reproduce the problem, we run: "bonnie++ -d test/ -m BTRFS -u 0 -s 25=
6M -r 128M -b"
> Note that the tested partition is for sure not full we have 800MB space =
there and we test with 256MB so it's not a space issue.

Unfortunately it's too small for btrfs.

Btrfs has the requirement to strictly split metadata and data space,=20
thus it's possible to let unbalanced metadata and data chunk usage to=20
exhaust one while the other has a lot of free space.

You can consider it as the ext4/xfs inode number limits vs data space=20
usage. One can exhaust all the available inodes way before exhausting=20
the available data.

It's just way worse in btrfs for smaller fses.

[...]
> [ 174.013001] BTRFS info (device mmcblk0p7 state A): space_info DATA has=
 234418176 free, is not full
> [ 174.022018] BTRFS info (device mmcblk0p7 state A): space_info total=3D=
255852544, used=3D21434368, pinned=3D0, reserved=3D0, may_use=3D0, readonl=
y=3D0 zone_unusable=3D0

You have only 244MiB of data chunk, which is already tiny for btrfs.
The worse part is, there is only 20MiB utilized

> [ 174.035829] BTRFS info (device mmcblk0p7 state A): space_info METADATA=
 has -5767168 free, is full
> [ 174.044752] BTRFS info (device mmcblk0p7 state A): space_info total=3D=
53673984, used=3D1146880, pinned=3D52445184, reserved=3D16384, may_use=3D5=
767168, readonly=3D65536 zone_unusable=3D0

Your metadata is tiny, only less than 52MiB (and will be doubled by the=20
default DUP profile for single dev setup).

This means your fs is only around 350MiB?

This is definitely not a good disk size for btrfs.

My recommendation for any btrfs is at least 10GiB.

This will allow btrfs to use 1Gib chunk stripe size (the max), so that=20
we won't have those tiny metadata blocks, and greatly reduce the problem=
=20
caused by unbalacned data/metadata.


But still, flipping RO is not a good behavior, although in such small=20
fs, you may have a better experience using mixed-bg feature, which will=20
let data and metadata share the same block groups, resolving the=20
unbalance problem (but introducing more limits).

Thanks,
Qu

> [ 174.060221] BTRFS info (device mmcblk0p7 state A): space_info SYSTEM h=
as 8355840 free, is not full
> [ 174.069252] BTRFS info (device mmcblk0p7 state A): space_info total=3D=
8388608, used=3D16384, pinned=3D16384, reserved=3D0, may_use=3D0, readonly=
=3D0 zone_unusable=3D0
> [ 174.082979] BTRFS info (device mmcblk0p7 state A): global_block_rsv: s=
ize 5767168 reserved 5767168
> [ 174.091989] BTRFS info (device mmcblk0p7 state A): trans_block_rsv: si=
ze 0 reserved 0
> [ 174.099865] BTRFS info (device mmcblk0p7 state A): chunk_block_rsv: si=
ze 0 reserved 0
> [ 174.107739] BTRFS info (device mmcblk0p7 state A): delayed_block_rsv: =
size 0 reserved 0
> [ 174.115794] BTRFS info (device mmcblk0p7 state A): delayed_refs_rsv: s=
ize 0 reserved 0
> [ 174.123787] BTRFS: error (device mmcblk0p7 state A) in cleanup_transac=
tion:2027: errno=3D-28 No space left
> [ 174.133336] BTRFS info (device mmcblk0p7 state EA): forced readonly
> Can't sync file.
> Cleaning up test directory after error.
> Bonnie: drastic I/O error (rmdir): Read-only file system
> ------------------------------------------------
>=20
> Trying to follow the "btrfs_add_bg_to_space_info" that is in "async_recl=
aim_work" context:
> -------------------------------------------------
> @@ -322,15 +322,21 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_in=
fo *info,
>          struct btrfs_space_info *found;
>          int factor, index;
>=20
>          factor =3D btrfs_bg_type_to_factor(block_group->flags);
>=20
>          found =3D btrfs_find_space_info(info, block_group->flags);
>          ASSERT(found);
>          spin_lock(&found->lock);
> +       pr_info("%s(%d): %s %lld %lld\n", __func__, __LINE__, space_info=
_flag_to_str(found), found->total_bytes, block_group->length);
> +       // OK: trigger twice free space is freed at second attempt.
> +       // METADATA 53673984 6291456
> +       // ..
> +       // METADATA 59965440 117440512
> +
> +       // KO: triggered one, no space
> +       // METADATA 53673984 6291456
> +       // crash...
> -------------------------------------------------
>=20
> Also maybe interesting to know is that trying to trace (printk) "btrfs_a=
dd_bg_to_space_info" influence the reproducibility.
>=20
> Any hints to resolve this problem are welcome.
>=20
> Regards,
> Aleksandar
>=20
>=20
>=20
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


