Return-Path: <linux-btrfs+bounces-19548-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCFBCA9FF9
	for <lists+linux-btrfs@lfdr.de>; Sat, 06 Dec 2025 04:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 219AE30AB84E
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Dec 2025 03:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A679E2609DC;
	Sat,  6 Dec 2025 03:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="AputNV3+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D8B3B8D7B
	for <linux-btrfs@vger.kernel.org>; Sat,  6 Dec 2025 03:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764993372; cv=none; b=kxfIRTwrPimAdLYdcxqN8GsRnuMihWOir0xXFWHldR5jPOdMuQaLYQQSfOlDj4Ovu4JfQQnSJBG6i8Q1er9LATdIVfoNR+GIA0Ntv2Zy5897VrSnWeNM3u7RyG0WNn+y4up+ff3kds+bgnuSAKx8fTZ1dPr9J1mYyGciHocEMmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764993372; c=relaxed/simple;
	bh=QchRbnqZiUE2qWMSWQitAku9qzg1LkSwJtqxhYGGZc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YUEvxttjKoK/ZapjaYcvolaXwsqEp8jXj0nuGgN8V2w58SuPgJ91ez55jCDKiE+XBHjc6/5j9DNHC8k8ZiuVbfaTFDPo5Y/8VUX3b945lUP+7Yw9KiT0PJ8abLG07kJHOs+ShvzHvMUGInrIzH7Iu1XzMj0/9oY7cTBqZihTu5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=AputNV3+; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1764993364; x=1765598164; i=quwenruo.btrfs@gmx.com;
	bh=VLNVf/zB4xLhKDYK5RnlpgI3ydzVPhQUDqR0RQShfdk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AputNV3+CABRKTnpenpDoUjikjsbdYK06lzZ5fJPP6X+xmi6ci9//E5Cbn/7CgNq
	 20KU+GY8EofpT7ZThLND7aopqdvIQ/dZRwxGF4bj7EqONRfsOP0mHqH4mDFPLkqsU
	 bXWemv1pC1s/XgvJRNzatiqQOJKs07I5RC+ZIBfYCG6ab1qwPJHQhxAA/3j9TkFXO
	 EAjf4zA+XkaikqSkavLPa3R8ZgJ1JvTgTHg/1N4bZdEnK5mIWEgkUMtiZfB/KCOto
	 UqRthK1uGMyYqkdhMxgBOF1jXtjdbWjaTD7LUmB+pOdT/aZ5gVU30JQgTEOeqXGn6
	 RXzJOpfQk5oKI7KHGg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MEFvp-1vJj3m2klR-000cJo; Sat, 06
 Dec 2025 04:56:04 +0100
Message-ID: <348efe08-a9e6-499b-a283-17eb90978e91@gmx.com>
Date: Sat, 6 Dec 2025 14:26:00 +1030
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
In-Reply-To: <DA85C45E-E46C-4E7C-908E-72A4F3592F90@fau.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5UmWS6Cb/Fcg8pCRKPIVEB+yIk0pDdTzhxZivANhxX7xlgYtP6T
 UFpSHkzZt1V7AnYT6GWz1To+LYweH+yt1DeB/PAC82CJVx0xnEN7Ewuir5THCSop6KFn4B8
 vOm+gc/5HgztF3V9716g57L3MeLqIlC5xczLzYhm3fufZP953m2hEwa++Fzuz9hrgYGjRMa
 AZ0d+GA2yVK1m6dKGTXQA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Y5wdCsQeMEk=;sOHiyu5Lvtx95O5QE3c4+7Se/7H
 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
 b7yjInyHuK/Tu5TJtyqu9RCwmK2vq



=E5=9C=A8 2025/12/6 05:52, Robin Seidl =E5=86=99=E9=81=93:
> Just a quick update: I figured out, that the offset field is the first f=
ield of `struct btrfs_extent_data_ref` and thus they are overlapping. Is t=
his correct? It seems like I get correct results with this method.

btrfs_extent_data_ref::offset is not always utilized.

For TREE_BLOCK_REF_KEY and SHARED_BLOCK_REF_KEY types, the offset is=20
utilized, and needs no extra structure.

For SHARED_DATA_REF_KEY, the offset is utilized as the parent bytenr=20
directly, then followed by btrfs_shared_data_ref structure to show the=20
ref counts.

For EXTENT_DATA_REF_KEY, it's the offset is not utilized directly but as=
=20
the first member of btrfs_extent_data_ref.


This is not easy to grab, but unfortunately btrfs has a lot of such=20
usage from the early days of btrfs.
E.g. btrfs_file_extent_item, which only part of the members are utilized=
=20
for inlined data extents.

I hope one day we can move away from this stupid partial structure=20
reuse, but move to a more structured layout.

E.g. btrfs_file_extent_header for the shared members of inlined and=20
regular extent, then followed by btrfs_file_extent_details for regular one=
s.

Thanks,
Qu

>=20
> Thanks,
> Robin
>=20
> On 3 December 2025 16:08:39 UTC, Robin Seidl <robin.seidl@fau.de> wrote:
>> Thank you very much.
>>
>> In https://github.com/kdave/btrfs-progs/blob/745e510b6c82829b9345699db3=
23b9a615a9f539/kernel-shared/print-tree.c#L565 the `offset` field of `stru=
ct btrfs_extent_inline_ref` is used to determine the pointer to the `struc=
t btrfs_extent_data_ref`. As I don't yet understand the underlying extent =
buffer you are using, I wanted to ask: relative to what is this offset (in=
 other words: how exactly is the `offset` field of `struct btrfs_extent_in=
line_ref`=C2=A0defined)?
>>
>> I assume in https://github.com/kdave/btrfs-progs/blob/745e510b6c82829b9=
345699db323b9a615a9f539/kernel-shared/print-tree.c#L578, the `struct btrfs=
_shared_data_ref` lies directly after the `struct btrfs_extent_inline_ref`=
 which is why you do the `iref + 1`, correct?
>>
>> Best regards
>> Robin
>>
>> Am 02.12.2025 um 05:27 schrieb Qu Wenruo:
>>>
>>>
>>> =E5=9C=A8 2025/12/1 19:21, Robin Seidl =E5=86=99=E9=81=93:
>>>> Hello Qu,
>>>>
>>>> thank you for your last answer, it helped a lot!
>>>>
>>>> I am currently trying to understand the structure of the extent tree =
in more detail and have the following problems:
>>>>
>>>> According to the documentation, the main items in the extent tree are=
 of type `BTRFS_EXTENT_ITEM_KEY`, `BTRFS_METADATA_ITEM_KEY`,
>>>
>>> Those are the basic ones with inline items.
>>>
>>> If an inlined extent go too large, there will be other items for the c=
orresponding types:
>>>
>>> BTRFS_SHARED_DATA_REF_KEY for data backrefs, and BTRFS_SHARED_BLOCK_RE=
F_KEY for metadata backrefs.
>>>
>>>> and `BTRFS_BLOCK_GROUP_ITEM_KEY`.
>>>
>>> And where you can find BTRFS_BLOCK_GROUP_ITEM_KEY depends on fs featur=
es.
>>> If the fs has BLOCK_GROUP_TREE feature, then that key will be moved to=
 block group tree.
>>>
>>>> The documentation also states that, depending on the flags it contain=
s, a `btrfs_extent_item` is followed by additional structs. I assume that =
these structs are referred to here: https://github.com/kdave/btrfs-progs/ =
blob/745e510b6c82829b9345699db323b9a615a9f539/kernel-shared/uapi/ btrfs_tr=
ee.h#L815-L839. Is that correct?
>>>
>>> Yes.
>>>
>>>> However, I cannot figure out which flags would have to be set for whi=
ch struct and in what order they would then be written.
>>>
>>> You can check the print-tree code for that.
>>>
>>> https://github.com/kdave/btrfs-progs/blob/745e510b6c82829b9345699db323=
b9a615a9f539/kernel-shared/print-tree.c#L500
>>>
>>> For metadata btrfs_extent_item::flags it has EXTENT_FLAG_TREE_BLOCK fl=
ag.
>>> Otherwise it should have EXTENT_FLAG_DATA flag set.
>>>
>>>>
>>>> What also confuses me is that some of these structs appear to have de=
fined key types (https://github.com/kdave/btrfs-progs/ blob/745e510b6c8282=
9b9345699db323b9a615a9f539/kernel-shared/uapi/ btrfs_tree. h#L237-L251), w=
hich would imply that they could be identified by their keys, like the mai=
n items above, instead of by the set flags. However, a quick look at the o=
utput of `dump-tree` did not confirm this.
>>>
>>> Please check the print_extent_item() function, which shows exactly how=
 those key types are utilized for inline case.
>>>
>>> And just around the callsites of print_extent_item() inside __btrfs_pr=
int_leaf(), there are other print_extent*() calls, that are handling the d=
edicated keyed cases.
>>>
>>> Thanks,
>>> Qu
>>>
>>>>
>>>> Can you clarify how exactly I should read the contents of the extent =
tree?
>>>>
>>>> Best regards
>>>> Robin
>>>>
>>>> Am 17.11.2025 um 11:01 schrieb Qu Wenruo:
>>>>>
>>>>>
>>>>> =E5=9C=A8 2025/11/17 20:05, Robin Seidl =E5=86=99=E9=81=93:
>>>>>> Hello,
>>>>>> I'm currently working on reading the BTRFS structures without mount=
ing the filesystem. I am now having troubles translating the root tree roo=
t address to a physical address:
>>>>>>
>>>>>> I did the tests on a freshly created filesystem.
>>>>>> At 0x10000 the superblock begins.
>>>>>> At 0x10050 the u64 logical address of the root tree root begins. It=
 is 0x1d4c000.
>>>>>> At 0x100a0 the u32 size of the chunk array begins. It is 0x81.
>>>>>> At 0x1032b the sys_chunk_array starts.
>>>>>>  =C2=A0=C2=A0 =C2=A0 0x1032b to 0x1033c is the btrfs_key. The chunk=
s logical start (u64 at 0x10334) is 0x1500000
>>>>>>  =C2=A0=C2=A0 =C2=A0 0x1033c to 0x1036c is the btrfs_chunk. The chu=
nks length (u64 at 0x1033c) is 0x800000.
>>>>>>  =C2=A0=C2=A0 =C2=A0 0x1036c to 0x1037d is the btrfs_stripe.
>>>>>
>>>>> This can be done using `btrfs ins dump-super -f` to print a more hum=
an readable output of the system chunk array.
>>>>>
>>>>>>
>>>>>> When the logical start of the chunk is 0x1500000 and the length is =
0x800000, then the logical end of the chunk is 0x1d00000. This implies tha=
t the root tree root adddress 0x1d4c000 is outside of the first and only c=
hunk.
>>>>>
>>>>> Just like the name, system chunk array, it only contains system chun=
ks.
>>>>>
>>>>> System chunks only store the chunk tree, which stores the remaining =
chunks.
>>>>>> What am I missing here, how do I translate the logical address of t=
he root tree root into its physical counterpart?
>>>>>
>>>>> Tree root is in metadata chunks, not in system chunks.
>>>>>
>>>>> You need super block system chunk array -> chunk tree -> the remaini=
ng chunks to do the bootstrap.
>>>>>
>>>>> If you are not yet able to understand the full kernel bootstrap code=
 (it's more complex and have a lot of other things), you can check open_ct=
ree() from btrfs-progs.
>>>>>
>>>>> The overall involved functions are (all from btrfs-progs):
>>>>>
>>>>> - btrfs_setup_chunk_tree_and_device_map()
>>>>>
>>>>> - btrfs_read_sys_array()
>>>>>
>>>>> - btrfs_read_chunk_tree()
>>>>>
>>>>> Thanks,
>>>>> Qu
>>>>>
>>>>>
>>>>>>
>>>>>> Best regards
>>>>>> Robin
>>>>>>
>>>>>> PS: In the wiki (https://btrfs.readthedocs.io/en/latest/dev/On-disk=
- format.html#superblock) there is a typo regarding the start of the sys_c=
hunk_array as it claims it starts at 0x1002b.
>>>>>>
>>>>>
>>>


