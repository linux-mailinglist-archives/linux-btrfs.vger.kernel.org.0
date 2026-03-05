Return-Path: <linux-btrfs+bounces-22244-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPXiAB9TqWkj4wAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22244-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 10:55:43 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8AE20F160
	for <lists+linux-btrfs@lfdr.de>; Thu, 05 Mar 2026 10:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D7833043061
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Mar 2026 09:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E17B37C0E3;
	Thu,  5 Mar 2026 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ZeLrGylV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B26137C0F2
	for <linux-btrfs@vger.kernel.org>; Thu,  5 Mar 2026 09:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772704331; cv=none; b=nNav799UoOEH1IvsJ3pJgrsikSgKIj/LfKf79eW8E0afAv60/PXCcqmHg7aeHKJqBeEOLgkMTjb88icV3vgCtBoB2jjQ1TkuQCZDzpA/KbOQWOhZez4BfiZJbLg9CfTiJWqPulK6SUwmRLhgWun8mIdlUFt2Gm01XrAEipQ0z2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772704331; c=relaxed/simple;
	bh=vx1vw4/JgRYUxollHlyl9mgMBcukrvFz/TxmiAyCauY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pRAgkKMVGWNYt1rt3yVvHj7vzwVihRBGbmyu18Yb0+QFz7bgXvVsCH5IgZX+3NSfG7mBuNAkATnDJOLNFYEEuSLQctD+KyKEKNpkboL3wC8oxBo4XSEvCXtKmCiJEzFvXOfjfncTV4zEAaesborv7KDQOx/1tlErDGG9nUgkcZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=ZeLrGylV; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1772704327; x=1773309127; i=quwenruo.btrfs@gmx.com;
	bh=vx1vw4/JgRYUxollHlyl9mgMBcukrvFz/TxmiAyCauY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZeLrGylVz4mH2+twCDwYrFfcs5C+1NwOLYLChZgd0ssJLRiDVQbfnSUPXJASRFmE
	 NINIfHMpujwpXVpww/3jBfXIfLzYOnIiH3mWy1O8fZeXSv3ZXYyuU07AiOZVs22na
	 usiEMWJSepVfVJlVYPW89SFhBcSVYaym6s+1MUsP/YX5YANogrJUf0pMBVayNA6oO
	 Enq7Vw81wh9VN2CJO3Nx1oNl9YGzhHlNa4gc94u6UahbOf559lqW5w1OmmK3HLLvd
	 kCKWZrWtmnJ9Ry0cBNHTGmy3KUIyyvZdlYmfYTwTzMYiA0mE0jOTteh97uEDmNxu2
	 Pu9sLcBxaxnb5Cc7Fg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MzhnH-1vkfGH0P1l-017KOe; Thu, 05
 Mar 2026 10:52:07 +0100
Message-ID: <3da8df9d-bd8c-4194-a416-94f3450fd38d@gmx.com>
Date: Thu, 5 Mar 2026 20:21:55 +1030
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
 <5b0d277a-68b5-43c0-a292-1f43ab30d207@gmx.com>
 <b5e287ab-0979-44b3-b919-4d26189de520@fau.de>
 <DA85C45E-E46C-4E7C-908E-72A4F3592F90@fau.de>
 <348efe08-a9e6-499b-a283-17eb90978e91@gmx.com>
 <25cec577-3e4a-4fe6-a94e-8ecdea3736ec@fau.de>
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
In-Reply-To: <25cec577-3e4a-4fe6-a94e-8ecdea3736ec@fau.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e3YLviO0eHngXsa86FiQ6OzHoyoI1DwGz0szAkheV40zfF7t6ba
 wl4v0vj6eEpfiQDuERfyCe+4oBWNdtRjG7q0dcW4uYEgbS9su+B90SHHkHxuxder6T6Khua
 25hdOjtVr12EuLPMqrC/GmuunaNbCEeZMuqOH1JAWc4zHoYer++fK/PZQTWXCc5WwPOFVEs
 BUrE7PYRIBPE7DVaeEE3Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AteV5HEKRNs=;kbohxKAO4bsRX78G46VmRFrOduQ
 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
X-Rspamd-Queue-Id: CF8AE20F160
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-22244-lists,linux-btrfs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmx.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,fau.de:email,btrfs.readthedocs.io:url,gmx.com:dkim,gmx.com:mid]
X-Rspamd-Action: no action



=E5=9C=A8 2026/3/5 19:32, Robin Seidl =E5=86=99=E9=81=93:
> Hello Qu,
>=20
> I made good progress since the last time we wrote, but I just stumpled=
=20
> upon a question I couldn't find an answer for:
>=20
> After the creation of a single-disk 1 GiB FS, I dumped the superblock=20
> and found that the `bytes_used` (147 456) and `dev_item.bytes_used` (132=
=20
> 513 792) don't match while their `total_bytes` counterparts do.
>=20
> 1. Why is that?

I didn't remember the detailed explanation of sb.byets_used, but it=20
should be the total logical bytes that is utilized (aka, all data +=20
metadata extents, before any profiles duplications).

Meanwhile for dev_item.bytes_used, I'm pretty sure it is all dev extents=
=20
used on that device.
And one dev extent represents one copy/mirror from a chunk.

>=20
> 2. How do I have to modify each of them when manually (doing tree=20
> manipulations myself) allocating a METADATA extent (i. e. how much do I=
=20
> have to add to them)?

For metadata, you can allocate a new tree block, but overall it's=20
complex and you shouldn't do it directly.


The easiest to bump the size of metadata is to create a lot of inline=20
extents.
Inlined extents are stored inside a metadata (tree block), that will=20
bump the size of the corresponding subvolume tree very easily.

Thanks,
Qu

>=20
> Thanks,
> Robin
>=20
> On 12/6/25 04:56, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/12/6 05:52, Robin Seidl =E5=86=99=E9=81=93:
>>> Just a quick update: I figured out, that the offset field is the=20
>>> first field of `struct btrfs_extent_data_ref` and thus they are=20
>>> overlapping. Is this correct? It seems like I get correct results=20
>>> with this method.
>>
>> btrfs_extent_data_ref::offset is not always utilized.
>>
>> For TREE_BLOCK_REF_KEY and SHARED_BLOCK_REF_KEY types, the offset is=20
>> utilized, and needs no extra structure.
>>
>> For SHARED_DATA_REF_KEY, the offset is utilized as the parent bytenr=20
>> directly, then followed by btrfs_shared_data_ref structure to show the=
=20
>> ref counts.
>>
>> For EXTENT_DATA_REF_KEY, it's the offset is not utilized directly but=
=20
>> as the first member of btrfs_extent_data_ref.
>>
>>
>> This is not easy to grab, but unfortunately btrfs has a lot of such=20
>> usage from the early days of btrfs.
>> E.g. btrfs_file_extent_item, which only part of the members are=20
>> utilized for inlined data extents.
>>
>> I hope one day we can move away from this stupid partial structure=20
>> reuse, but move to a more structured layout.
>>
>> E.g. btrfs_file_extent_header for the shared members of inlined and=20
>> regular extent, then followed by btrfs_file_extent_details for regular=
=20
>> ones.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Thanks,
>>> Robin
>>>
>>> On 3 December 2025 16:08:39 UTC, Robin Seidl <robin.seidl@fau.de> wrot=
e:
>>>> Thank you very much.
>>>>
>>>> In https://github.com/kdave/btrfs-progs/=20
>>>> blob/745e510b6c82829b9345699db323b9a615a9f539/kernel-shared/print-=20
>>>> tree.c#L565 the `offset` field of `struct btrfs_extent_inline_ref`=20
>>>> is used to determine the pointer to the `struct=20
>>>> btrfs_extent_data_ref`. As I don't yet understand the underlying=20
>>>> extent buffer you are using, I wanted to ask: relative to what is=20
>>>> this offset (in other words: how exactly is the `offset` field of=20
>>>> `struct btrfs_extent_inline_ref`=C2=A0defined)?
>>>>
>>>> I assume in https://github.com/kdave/btrfs-progs/=20
>>>> blob/745e510b6c82829b9345699db323b9a615a9f539/kernel-shared/print-=20
>>>> tree.c#L578, the `struct btrfs_shared_data_ref` lies directly after=
=20
>>>> the `struct btrfs_extent_inline_ref` which is why you do the `iref +=
=20
>>>> 1`, correct?
>>>>
>>>> Best regards
>>>> Robin
>>>>
>>>> Am 02.12.2025 um 05:27 schrieb Qu Wenruo:
>>>>>
>>>>>
>>>>> =E5=9C=A8 2025/12/1 19:21, Robin Seidl =E5=86=99=E9=81=93:
>>>>>> Hello Qu,
>>>>>>
>>>>>> thank you for your last answer, it helped a lot!
>>>>>>
>>>>>> I am currently trying to understand the structure of the extent=20
>>>>>> tree in more detail and have the following problems:
>>>>>>
>>>>>> According to the documentation, the main items in the extent tree=
=20
>>>>>> are of type `BTRFS_EXTENT_ITEM_KEY`, `BTRFS_METADATA_ITEM_KEY`,
>>>>>
>>>>> Those are the basic ones with inline items.
>>>>>
>>>>> If an inlined extent go too large, there will be other items for=20
>>>>> the corresponding types:
>>>>>
>>>>> BTRFS_SHARED_DATA_REF_KEY for data backrefs, and=20
>>>>> BTRFS_SHARED_BLOCK_REF_KEY for metadata backrefs.
>>>>>
>>>>>> and `BTRFS_BLOCK_GROUP_ITEM_KEY`.
>>>>>
>>>>> And where you can find BTRFS_BLOCK_GROUP_ITEM_KEY depends on fs=20
>>>>> features.
>>>>> If the fs has BLOCK_GROUP_TREE feature, then that key will be moved=
=20
>>>>> to block group tree.
>>>>>
>>>>>> The documentation also states that, depending on the flags it=20
>>>>>> contains, a `btrfs_extent_item` is followed by additional structs.=
=20
>>>>>> I assume that these structs are referred to here: https://=20
>>>>>> github.com/kdave/btrfs-progs/=20
>>>>>> blob/745e510b6c82829b9345699db323b9a615a9f539/kernel-shared/uapi/=
=20
>>>>>> btrfs_tree.h#L815-L839. Is that correct?
>>>>>
>>>>> Yes.
>>>>>
>>>>>> However, I cannot figure out which flags would have to be set for=
=20
>>>>>> which struct and in what order they would then be written.
>>>>>
>>>>> You can check the print-tree code for that.
>>>>>
>>>>> https://github.com/kdave/btrfs-progs/=20
>>>>> blob/745e510b6c82829b9345699db323b9a615a9f539/kernel-shared/print-=
=20
>>>>> tree.c#L500
>>>>>
>>>>> For metadata btrfs_extent_item::flags it has EXTENT_FLAG_TREE_BLOCK=
=20
>>>>> flag.
>>>>> Otherwise it should have EXTENT_FLAG_DATA flag set.
>>>>>
>>>>>>
>>>>>> What also confuses me is that some of these structs appear to have=
=20
>>>>>> defined key types (https://github.com/kdave/btrfs-progs/=20
>>>>>> blob/745e510b6c82829b9345699db323b9a615a9f539/kernel-shared/uapi/=
=20
>>>>>> btrfs_tree. h#L237-L251), which would imply that they could be=20
>>>>>> identified by their keys, like the main items above, instead of by=
=20
>>>>>> the set flags. However, a quick look at the output of `dump-tree`=
=20
>>>>>> did not confirm this.
>>>>>
>>>>> Please check the print_extent_item() function, which shows exactly=
=20
>>>>> how those key types are utilized for inline case.
>>>>>
>>>>> And just around the callsites of print_extent_item() inside=20
>>>>> __btrfs_print_leaf(), there are other print_extent*() calls, that=20
>>>>> are handling the dedicated keyed cases.
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>>
>>>>>> Can you clarify how exactly I should read the contents of the=20
>>>>>> extent tree?
>>>>>>
>>>>>> Best regards
>>>>>> Robin
>>>>>>
>>>>>> Am 17.11.2025 um 11:01 schrieb Qu Wenruo:
>>>>>>>
>>>>>>>
>>>>>>> =E5=9C=A8 2025/11/17 20:05, Robin Seidl =E5=86=99=E9=81=93:
>>>>>>>> Hello,
>>>>>>>> I'm currently working on reading the BTRFS structures without=20
>>>>>>>> mounting the filesystem. I am now having troubles translating=20
>>>>>>>> the root tree root address to a physical address:
>>>>>>>>
>>>>>>>> I did the tests on a freshly created filesystem.
>>>>>>>> At 0x10000 the superblock begins.
>>>>>>>> At 0x10050 the u64 logical address of the root tree root begins.=
=20
>>>>>>>> It is 0x1d4c000.
>>>>>>>> At 0x100a0 the u32 size of the chunk array begins. It is 0x81.
>>>>>>>> At 0x1032b the sys_chunk_array starts.
>>>>>>>> =C2=A0=C2=A0=C2=A0 =C2=A0 0x1032b to 0x1033c is the btrfs_key. Th=
e chunks logical=20
>>>>>>>> start (u64 at 0x10334) is 0x1500000
>>>>>>>> =C2=A0=C2=A0=C2=A0 =C2=A0 0x1033c to 0x1036c is the btrfs_chunk. =
The chunks length=20
>>>>>>>> (u64 at 0x1033c) is 0x800000.
>>>>>>>> =C2=A0=C2=A0=C2=A0 =C2=A0 0x1036c to 0x1037d is the btrfs_stripe.
>>>>>>>
>>>>>>> This can be done using `btrfs ins dump-super -f` to print a more=
=20
>>>>>>> human readable output of the system chunk array.
>>>>>>>
>>>>>>>>
>>>>>>>> When the logical start of the chunk is 0x1500000 and the length=
=20
>>>>>>>> is 0x800000, then the logical end of the chunk is 0x1d00000.=20
>>>>>>>> This implies that the root tree root adddress 0x1d4c000 is=20
>>>>>>>> outside of the first and only chunk.
>>>>>>>
>>>>>>> Just like the name, system chunk array, it only contains system=20
>>>>>>> chunks.
>>>>>>>
>>>>>>> System chunks only store the chunk tree, which stores the=20
>>>>>>> remaining chunks.
>>>>>>>> What am I missing here, how do I translate the logical address=20
>>>>>>>> of the root tree root into its physical counterpart?
>>>>>>>
>>>>>>> Tree root is in metadata chunks, not in system chunks.
>>>>>>>
>>>>>>> You need super block system chunk array -> chunk tree -> the=20
>>>>>>> remaining chunks to do the bootstrap.
>>>>>>>
>>>>>>> If you are not yet able to understand the full kernel bootstrap=20
>>>>>>> code (it's more complex and have a lot of other things), you can=
=20
>>>>>>> check open_ctree() from btrfs-progs.
>>>>>>>
>>>>>>> The overall involved functions are (all from btrfs-progs):
>>>>>>>
>>>>>>> - btrfs_setup_chunk_tree_and_device_map()
>>>>>>>
>>>>>>> - btrfs_read_sys_array()
>>>>>>>
>>>>>>> - btrfs_read_chunk_tree()
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Qu
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> Best regards
>>>>>>>> Robin
>>>>>>>>
>>>>>>>> PS: In the wiki (https://btrfs.readthedocs.io/en/latest/dev/On-=
=20
>>>>>>>> disk- format.html#superblock) there is a typo regarding the=20
>>>>>>>> start of the sys_chunk_array as it claims it starts at 0x1002b.
>>>>>>>>
>>>>>>>
>>>>>
>>


