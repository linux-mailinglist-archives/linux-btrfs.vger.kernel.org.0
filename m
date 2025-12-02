Return-Path: <linux-btrfs+bounces-19447-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E744EC9A025
	for <lists+linux-btrfs@lfdr.de>; Tue, 02 Dec 2025 05:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EBF93A2BF7
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Dec 2025 04:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA922F5A02;
	Tue,  2 Dec 2025 04:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="XCUHXLJe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BD02F5473
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Dec 2025 04:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764649665; cv=none; b=Tya3E+kTllTssnSq0cmS6tpYIMW7sPkO/GowezGYI8alUZXdQj4YOtIbZlYNdNP3ujxXmp1KEUljGCY2huSMahpdSsBrVw67CJjspuCt26TV1V+6ORwb44OESE3ae6xNnJc82GtlTo4bqnkXYwuNmg2DNPgjjK9vTRjyxlniVFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764649665; c=relaxed/simple;
	bh=zR+5jltth1MXMkVgiT5j6KWx9ewcOkmtWXfZ+01HACs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HgbSrfWimAgiPTTpsMkbOFHYWxxWq0QAgshAIFPSwjRgy9Il5dYypfIDgjPk9ZBWfsBD60uouMy8BdMh1NoEembrFSyYX5HCrAoe16+QNf7DBd80k8ZMzUyKszB+9AC/Y9fSoBmx5fFOJBSwHnUbzSCE463oJKLF8UVmAXEyfwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=XCUHXLJe; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1764649657; x=1765254457; i=quwenruo.btrfs@gmx.com;
	bh=zR+5jltth1MXMkVgiT5j6KWx9ewcOkmtWXfZ+01HACs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=XCUHXLJehIWrhEI9wP0ZhDrFgItnZkXn4rijvlhn1SCldziApYKCumUEM598zMxh
	 E7h/B+LWqQu6xi2MMVUcIUap4PJ/8b9wUdV+NtkojUgNrQybbW5lDbWPg5XnbVGRJ
	 WiNCjjfwyxC5A2W66kWOOYb7CZk4xWlIvA/ustOuxHoccNQN8m7+PJHdgM16Nryjx
	 dwrtA0CBIc7g2uZExEjgfttwpcvPfDMGnIoCqrJabtDy3lGRtl4IIk0O0u8IMAIKw
	 aLwwvLd+A6m/6HCSGlvsDnO95o4XLSc/nTQBcYk0a5E9FJ6Ja3yR0xU/L2jRh6eTK
	 96wk+yShuVPNJSPz+g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWzfl-1vbTCT3czp-00XYsO; Tue, 02
 Dec 2025 05:27:37 +0100
Message-ID: <5b0d277a-68b5-43c0-a292-1f43ab30d207@gmx.com>
Date: Tue, 2 Dec 2025 14:57:34 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Troubles translating root tree's logical to physical address
To: Robin Seidl <robin.seidl@fau.de>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
References: <7e9c5666-645d-4b4f-9608-a521353c54b0@fau.de>
 <b5bce92a-f1e8-4137-ae9c-df6980702095@gmx.com>
 <59b45b35-e67c-4f54-9710-fe91fe9b0be0@fau.de>
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
In-Reply-To: <59b45b35-e67c-4f54-9710-fe91fe9b0be0@fau.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4rXsLCZJ0IBRYVjHrzwROcV/Pdr+KFkLyZzNgRiGeV/TYN2gBLh
 b+vTV/ToxTvYATsdk7ER5rbZM0gUDB6Tjm9KhSwDTShI0S2FONMnlehvQoS+kIzjMljkYLe
 VFn4Tj6ZIMxNBaS4rGTFiToiMgqIYj4FwwgpNFi4wcWZG2hr3CYVjkW4Ql4vQ+pYnxpiaBA
 cRsQLvtNkQ2pBIuJK7vOA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NleDcYN6WxQ=;vUlpzF6lYUpHWoQGh+Z/0pLTjnB
 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
 zHbbu4sd19PRQ9HikysGekWeauWI5oOSvM8lhz



=E5=9C=A8 2025/12/1 19:21, Robin Seidl =E5=86=99=E9=81=93:
> Hello Qu,
>=20
> thank you for your last answer, it helped a lot!
>=20
> I am currently trying to understand the structure of the extent tree in=
=20
> more detail and have the following problems:
>=20
> According to the documentation, the main items in the extent tree are of=
=20
> type `BTRFS_EXTENT_ITEM_KEY`, `BTRFS_METADATA_ITEM_KEY`,

Those are the basic ones with inline items.

If an inlined extent go too large, there will be other items for the=20
corresponding types:

BTRFS_SHARED_DATA_REF_KEY for data backrefs, and=20
BTRFS_SHARED_BLOCK_REF_KEY for metadata backrefs.

> and=20
> `BTRFS_BLOCK_GROUP_ITEM_KEY`.

And where you can find BTRFS_BLOCK_GROUP_ITEM_KEY depends on fs features.
If the fs has BLOCK_GROUP_TREE feature, then that key will be moved to=20
block group tree.

> The documentation also states that,=20
> depending on the flags it contains, a `btrfs_extent_item` is followed by=
=20
> additional structs. I assume that these structs are referred to here:=20
> https://github.com/kdave/btrfs-progs/=20
> blob/745e510b6c82829b9345699db323b9a615a9f539/kernel-shared/uapi/=20
> btrfs_tree.h#L815-L839. Is that correct?

Yes.

> However, I cannot figure out=20
> which flags would have to be set for which struct and in what order they=
=20
> would then be written.

You can check the print-tree code for that.

https://github.com/kdave/btrfs-progs/blob/745e510b6c82829b9345699db323b9a6=
15a9f539/kernel-shared/print-tree.c#L500

For metadata btrfs_extent_item::flags it has EXTENT_FLAG_TREE_BLOCK flag.
Otherwise it should have EXTENT_FLAG_DATA flag set.

>=20
> What also confuses me is that some of these structs appear to have=20
> defined key types (https://github.com/kdave/btrfs-progs/=20
> blob/745e510b6c82829b9345699db323b9a615a9f539/kernel-shared/uapi/=20
> btrfs_tree. h#L237-L251), which would imply that they could be=20
> identified by their keys, like the main items above, instead of by the=
=20
> set flags. However, a quick look at the output of `dump-tree` did not=20
> confirm this.

Please check the print_extent_item() function, which shows exactly how=20
those key types are utilized for inline case.

And just around the callsites of print_extent_item() inside=20
__btrfs_print_leaf(), there are other print_extent*() calls, that are=20
handling the dedicated keyed cases.

Thanks,
Qu

>=20
> Can you clarify how exactly I should read the contents of the extent tre=
e?
>=20
> Best regards
> Robin
>=20
> Am 17.11.2025 um 11:01 schrieb Qu Wenruo:
>>
>>
>> =E5=9C=A8 2025/11/17 20:05, Robin Seidl =E5=86=99=E9=81=93:
>>> Hello,
>>> I'm currently working on reading the BTRFS structures without=20
>>> mounting the filesystem. I am now having troubles translating the=20
>>> root tree root address to a physical address:
>>>
>>> I did the tests on a freshly created filesystem.
>>> At 0x10000 the superblock begins.
>>> At 0x10050 the u64 logical address of the root tree root begins. It=20
>>> is 0x1d4c000.
>>> At 0x100a0 the u32 size of the chunk array begins. It is 0x81.
>>> At 0x1032b the sys_chunk_array starts.
>>> =C2=A0=C2=A0 =C2=A0 0x1032b to 0x1033c is the btrfs_key. The chunks lo=
gical start=20
>>> (u64 at 0x10334) is 0x1500000
>>> =C2=A0=C2=A0 =C2=A0 0x1033c to 0x1036c is the btrfs_chunk. The chunks =
length (u64 at=20
>>> 0x1033c) is 0x800000.
>>> =C2=A0=C2=A0 =C2=A0 0x1036c to 0x1037d is the btrfs_stripe.
>>
>> This can be done using `btrfs ins dump-super -f` to print a more human=
=20
>> readable output of the system chunk array.
>>
>>>
>>> When the logical start of the chunk is 0x1500000 and the length is=20
>>> 0x800000, then the logical end of the chunk is 0x1d00000. This=20
>>> implies that the root tree root adddress 0x1d4c000 is outside of the=
=20
>>> first and only chunk.
>>
>> Just like the name, system chunk array, it only contains system chunks.
>>
>> System chunks only store the chunk tree, which stores the remaining=20
>> chunks.
>>> What am I missing here, how do I translate the logical address of the=
=20
>>> root tree root into its physical counterpart?
>>
>> Tree root is in metadata chunks, not in system chunks.
>>
>> You need super block system chunk array -> chunk tree -> the remaining=
=20
>> chunks to do the bootstrap.
>>
>> If you are not yet able to understand the full kernel bootstrap code=20
>> (it's more complex and have a lot of other things), you can check=20
>> open_ctree() from btrfs-progs.
>>
>> The overall involved functions are (all from btrfs-progs):
>>
>> - btrfs_setup_chunk_tree_and_device_map()
>>
>> - btrfs_read_sys_array()
>>
>> - btrfs_read_chunk_tree()
>>
>> Thanks,
>> Qu
>>
>>
>>>
>>> Best regards
>>> Robin
>>>
>>> PS: In the wiki (https://btrfs.readthedocs.io/en/latest/dev/On-disk-=
=20
>>> format.html#superblock) there is a typo regarding the start of the=20
>>> sys_chunk_array as it claims it starts at 0x1002b.
>>>
>>


