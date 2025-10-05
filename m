Return-Path: <linux-btrfs+bounces-17439-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BC6BB94BE
	for <lists+linux-btrfs@lfdr.de>; Sun, 05 Oct 2025 10:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F7318966FB
	for <lists+linux-btrfs@lfdr.de>; Sun,  5 Oct 2025 08:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5921F1317;
	Sun,  5 Oct 2025 08:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="muzth/+F"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6021F19A
	for <linux-btrfs@vger.kernel.org>; Sun,  5 Oct 2025 08:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759653447; cv=none; b=iBRElEWV2Y9NKV43y6FOY3OtexNzU5u7b9Rc7VIMVK3bUUFTFN7V/kQc1PQBZxKj7ExM3pyO/xgcbX3vcXO+uB2TB70vH38MVMPpuxJr4R1bAeXGdUqC3A4twQTOCUooCkQJ7YGhsfuwiwysKA5gWeSsQa5TlhIZuJPKxoXyQCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759653447; c=relaxed/simple;
	bh=DoE/ryFVS1LKeuhKdc/cwO80MZnSK/H8h9NIOZS71dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=AaFbSUVEihaijcQtkhiL52R+GwMC8Ka+4COdcCSVjldJSIFlboQZQQkEjZ3cwpcz3yjAvLM9Dsw6zJ+6fvJmdcUqOcWEo9v49lAhew1Jgh7AH9w6VXz6Vn6PM+XtMsjk9rec9I+bs75xvYscmyM0yTvYYckxnmBG/FqJLK8L6xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=muzth/+F; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1759653439; x=1760258239; i=quwenruo.btrfs@gmx.com;
	bh=DoE/ryFVS1LKeuhKdc/cwO80MZnSK/H8h9NIOZS71dg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=muzth/+FoekOOqwMf3IfEdfzqghZ+1KYaYYXyRgz+rLDwlzNhT4tDRPeJTCvwRXi
	 NKraamPboiocCFcqlJTmbm+iFGfSeUSKDxOCppEBr3cskij6xPZ3WSw1W+Y2B+gJW
	 80C/BJH9F5SVkAaF5OwWHndwi4cmJAIaNZ8bdoYVXIgQxb4iX2Sy/AY2aHXFgBcs2
	 lI/2jTp2t0dwlt1EtxHr0yqgmVytjwYqNSDuB8J0PZHD9NJDfefY64clkkTn2khbE
	 70J9qUYkn22t1MYqkAfwHg6Gx6Njtp2j6bjHAsfImuuoOFRF+nXc2L7lXx6ln4yLZ
	 jM1wIS5YQuXOyYFlvw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MRmfi-1ugbJM1kmQ-00MGsj; Sun, 05
 Oct 2025 10:37:19 +0200
Message-ID: <802bb720-5d61-4585-92b6-df05fb1215da@gmx.com>
Date: Sun, 5 Oct 2025 19:07:15 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to remove an unremovable file and directory?
To: =?UTF-8?Q?Henri_Hyyryl=C3=A4inen?= <henri.hyyrylainen@gmail.com>,
 Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <33570321-604e-4830-843a-4ed839dfbe83@gmail.com>
 <e7aefcaf-ecb5-492d-9ced-a9b846813bd6@suse.com>
 <5d0cde2f-441e-4007-a6b6-e2aa951befa2@gmail.com>
 <b6273125-86fb-443b-9b2d-3430594f0152@suse.com>
 <f2b72e44-9134-4cc5-99b0-fb51c2673cde@suse.com>
 <afea5a6c-96a6-4928-aa63-275a6c8f8030@gmail.com>
 <4cda86a1-6012-4200-91a0-9087eb9472da@suse.com>
 <09f5019c-650f-4839-8fea-a3c9eb6a9889@gmail.com>
 <2836fb95-a819-43fd-913e-a7c7f7741665@gmx.com>
 <e34577ac-3b2a-4fc8-8d04-b06f9b70cc5b@gmail.com>
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
In-Reply-To: <e34577ac-3b2a-4fc8-8d04-b06f9b70cc5b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MJAzIgjJWZGblZGKNxcq0bX5unCN2VWgh53T66X9tJfzV7sQFRE
 Czspg3rmfsq177VwvSdZqWzTQvD6op4sDiGSB08BceHPMrVLjKszTdiRwWqQBAoAK2cnEQD
 RsqXgqrMKn13dPHn0xND9t1i5bUwtQnRs5COhw5PKI/o+mazrdJ706UehUGKoMwksftgRKR
 jMcSCrkZOdQtrAM/ReczA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IwitEuW5KWs=;ln1TV1Njh0pbdJxGOTMGBPOCwP/
 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
 90ngZ51BmGLgQk8T4=



=E5=9C=A8 2025/10/5 18:50, Henri Hyyryl=C3=A4inen =E5=86=99=E9=81=93:
> Hello,
>=20
> The check has completed and, probably thanks to the second repair, it=20
> did not find much. Here's the full output:
>=20
>> [1/8] checking log skipped (none written)
>> [2/8] checking root items
>> [3/8] checking extents
>> Device extent[4, 19977638903808, 1073741824] didn't find the relative=
=20
>> chunk.

Great news, we only need to delete that item.


Try btrfs-corrupt-block (I know this sounds dangerous) command, which=20
may not be included by a lot of distros, thus recommended to build a=20
btrfs-progs and run it (without installing)

# ./btrfs-corrupt-block -d 4,204,19977638903808 -r 4 <device>

If it worked, there should be no message output. Otherwise something=20
went wrong.

Normally even if the command failed, it shouldn't cause extra damages=20
since everything else in your fs is still fine.

Thanks,
Qu

>> [4/8] checking free space cache
>> [5/8] checking fs roots
>> [6/8] checking only csums items (without verifying data)
>> [7/8] checking root refs
>> [8/8] checking quota groups skipped (not enabled on this FS)
>> Opening filesystem to check...
>> Checking filesystem on /dev/sdb
>> UUID: 2b4ad16d-e456-4adf-960b-dca43560b98b
>> found 49454062784512 bytes used, no error found
>> total csum bytes: 48225005724
>> total tree bytes: 72333164544
>> total fs tree bytes: 19189743616
>> total extent tree bytes: 3319316480
>> btree space waste bytes: 5998261217
>> file data blocks allocated: 119737771229184
>> =C2=A0referenced 72125752061952
>=20
>=20
> - Henri Hyyryl=C3=A4inen
>=20
> Qu Wenruo kirjoitti 5.10.2025 klo 1.41:
>>
>>
>> =E5=9C=A8 2025/10/5 09:06, Henri Hyyryl=C3=A4inen =E5=86=99=E9=81=93:
>>> Thanks for the command.
>>>
>>> I tried reading through the data but I could not determine if there=20
>>> was any information related to scrub or balance status.
>>
>> It's fine. No persistent item for balance/dev-replace. So it's not=20
>> involved.
>>
>> Waiting for the readonly check result.
>>
>> And meanwhile, please prepare an environment to compile btrfs-progs.
>>
>> If there is only one stray dev extent, I'll create a simple dirty fix=
=20
>> so that you can mount the fs again.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Here's the full output I got:
>>>
>>>> btrfs-progs v6.16.1
>>>> root tree
>>>> leaf 227587769614336 items 61 free space 3547 generation 2035509=20
>>>> owner ROOT_TREE
>>>> leaf 227587769614336 flags 0x1(WRITTEN) backref revision 1
>>>> fs uuid 2b4ad16d-e456-4adf-960b-dca43560b98b
>>>> chunk uuid 0e317678-73cc-4485-ab6b-987285e19681
>>>> =C2=A0 =C2=A0 item 0 key (EXTENT_TREE ROOT_ITEM 0) itemoff 15844 item=
size 439
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2035509 root_dirid 0 bytenr 22=
7587769630720=20
>>>> byte_limit 0 bytes_used 3319316480
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 0 flags 0x0(none) refs 1
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_le=
vel 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2035509
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 00000000-0000-0000-0000-000000000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid 00000000-0000-0000-0000-00000=
0000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-000=
000000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 0 otransid 0 stransid 0 rtransid=
 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 item 1 key (DEV_TREE ROOT_ITEM 0) itemoff 15405 itemsiz=
e 439
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2025974 root_dirid 0 bytenr 22=
7594196631552=20
>>>> byte_limit 0 bytes_used 21889024
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 0 flags 0x0(none) refs 1
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_le=
vel 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 2 generation_v2 2025974
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 00000000-0000-0000-0000-000000000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid 00000000-0000-0000-0000-00000=
0000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-000=
000000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 0 otransid 0 stransid 0 rtransid=
 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 item 2 key (FS_TREE INODE_REF 6) itemoff 15388 itemsize=
 17
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 index 0 namelen 7 name: default
>>>> =C2=A0 =C2=A0 item 3 key (FS_TREE ROOT_ITEM 0) itemoff 14949 itemsize=
 439
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2025975 root_dirid 256 bytenr =
227573939142656=20
>>>> byte_limit 0 bytes_used 6603997184
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2025951 flags 0x0(none) ref=
s 1
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_le=
vel 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2025975
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid eea49a45-adcf-4bff-a203-0f600f2db6a8
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid 00000000-0000-0000-0000-00000=
0000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-000=
000000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 2025953 otransid 0 stransid 0 rt=
ransid 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1759258850.523837328 (2025-09-30 22=
:00:50)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1679586168.0 (2023-03-23 17:42:48)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 item 4 key (FS_TREE ROOT_REF 256) itemoff 14921 itemsiz=
e 28
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 256 sequence 6 name .s=
napshots
>>>> =C2=A0 =C2=A0 item 5 key (ROOT_TREE_DIR INODE_ITEM 0) itemoff 14761 i=
temsize 160
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 3 transid 0 size 0 nbytes 1638=
4
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 block group 0 mode 40755 links 1 uid 0 gi=
d 0 rdev 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 sequence 0 flags 0x0(none)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 atime 1679586169.0 (2023-03-23 17:42:49)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1679586169.0 (2023-03-23 17:42:49)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 mtime 1679586169.0 (2023-03-23 17:42:49)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1679586169.0 (2023-03-23 17:42:49)
>>>> =C2=A0 =C2=A0 item 6 key (ROOT_TREE_DIR INODE_REF 6) itemoff 14749 it=
emsize 12
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 index 0 namelen 2 name: ..
>>>> =C2=A0 =C2=A0 item 7 key (ROOT_TREE_DIR DIR_ITEM 2378154706) itemoff =
14712=20
>>>> itemsize 37
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 location key (FS_TREE ROOT_ITEM 184467440=
73709551615) type DIR
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 transid 0 data_len 0 name_len 7
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 name: default
>>>> =C2=A0 =C2=A0 item 8 key (CSUM_TREE ROOT_ITEM 0) itemoff 14273 itemsi=
ze 439
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2025954 root_dirid 0 bytenr 22=
7588044062720=20
>>>> byte_limit 0 bytes_used 49791238144
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 0 flags 0x0(none) refs 1
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_le=
vel 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2025954
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 00000000-0000-0000-0000-000000000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid 00000000-0000-0000-0000-00000=
0000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-000=
000000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 0 otransid 0 stransid 0 rtransid=
 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 item 9 key (UUID_TREE ROOT_ITEM 0) itemoff 13834 itemsi=
ze 439
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2025954 root_dirid 0 bytenr 22=
7587802447872=20
>>>> byte_limit 0 bytes_used 16384
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 0 flags 0x0(none) refs 1
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_le=
vel 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 0 generation_v2 2025954
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 00000000-0000-0000-0000-000000000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid 00000000-0000-0000-0000-00000=
0000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-000=
000000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 0 otransid 0 stransid 0 rtransid=
 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 item 10 key (256 ROOT_ITEM 0) itemoff 13395 itemsize 43=
9
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2025954 root_dirid 256 bytenr =
227587802316800=20
>>>> byte_limit 0 bytes_used 49152
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2015386 flags 0x0(none) ref=
s 1
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_le=
vel 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 1 generation_v2 2025954
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 56f85f76-1eb8-1245-a35b-8a9307d5c68f
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid 00000000-0000-0000-0000-00000=
0000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-000=
000000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 2025954 otransid 31 stransid 0 r=
transid 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1759260258.238143629 (2025-09-30 22=
:24:18)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1679588253.995834574 (2023-03-23 18=
:17:33)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 item 11 key (256 ROOT_BACKREF 5) itemoff 13367 itemsize=
 28
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 256 sequence 6 nam=
e .snapshots
>>>> =C2=A0 =C2=A0 item 12 key (256 ROOT_REF 14428) itemoff 13341 itemsize=
 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 28589 sequence 2 name =
snapshot
>>>> =C2=A0 =C2=A0 item 13 key (256 ROOT_REF 14451) itemoff 13315 itemsize=
 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 28635 sequence 2 name =
snapshot
>>>> =C2=A0 =C2=A0 item 14 key (256 ROOT_REF 14475) itemoff 13289 itemsize=
 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 28683 sequence 2 name =
snapshot
>>>> =C2=A0 =C2=A0 item 15 key (256 ROOT_REF 14499) itemoff 13263 itemsize=
 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 28731 sequence 2 name =
snapshot
>>>> =C2=A0 =C2=A0 item 16 key (256 ROOT_REF 14523) itemoff 13237 itemsize=
 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 28779 sequence 2 name =
snapshot
>>>> =C2=A0 =C2=A0 item 17 key (256 ROOT_REF 14547) itemoff 13211 itemsize=
 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 28827 sequence 2 name =
snapshot
>>>> =C2=A0 =C2=A0 item 18 key (256 ROOT_REF 14559) itemoff 13185 itemsize=
 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 28851 sequence 2 name =
snapshot
>>>> =C2=A0 =C2=A0 item 19 key (256 ROOT_REF 14583) itemoff 13159 itemsize=
 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 28899 sequence 2 name =
snapshot
>>>> =C2=A0 =C2=A0 item 20 key (256 ROOT_REF 14607) itemoff 13133 itemsize=
 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 28947 sequence 2 name =
snapshot
>>>> =C2=A0 =C2=A0 item 21 key (256 ROOT_REF 14631) itemoff 13107 itemsize=
 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 28995 sequence 2 name =
snapshot
>>>> =C2=A0 =C2=A0 item 22 key (256 ROOT_REF 14640) itemoff 13081 itemsize=
 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 29013 sequence 2 name =
snapshot
>>>> =C2=A0 =C2=A0 item 23 key (256 ROOT_REF 14641) itemoff 13055 itemsize=
 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 29015 sequence 2 name =
snapshot
>>>> =C2=A0 =C2=A0 item 24 key (256 ROOT_REF 14642) itemoff 13029 itemsize=
 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 29017 sequence 2 name =
snapshot
>>>> =C2=A0 =C2=A0 item 25 key (256 ROOT_REF 14643) itemoff 13003 itemsize=
 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 29019 sequence 2 name =
snapshot
>>>> =C2=A0 =C2=A0 item 26 key (256 ROOT_REF 14644) itemoff 12977 itemsize=
 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 29021 sequence 2 name =
snapshot
>>>> =C2=A0 =C2=A0 item 27 key (256 ROOT_REF 14645) itemoff 12951 itemsize=
 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root ref key dirid 29023 sequence 2 name =
snapshot
>>>> =C2=A0 =C2=A0 item 28 key (14428 ROOT_ITEM 1849346) itemoff 12512 ite=
msize 439
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2025978 root_dirid 256 bytenr =
71398781173760=20
>>>> byte_limit 0 bytes_used 8815476736
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2018745 flags 0x1(RDONLY) r=
efs 1
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_le=
vel 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2025978
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 97cd122d-c519-8746-bdfe-13479bfefb9d
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600=
f2db6a8
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-000=
000000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 1849346 otransid 1849346 stransi=
d 0 rtransid 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1758406304.841464812 (2025-09-21 01=
:11:44)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1758406304.840394467 (2025-09-21 01=
:11:44)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 item 29 key (14428 ROOT_BACKREF 256) itemoff 12486 item=
size 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 28589 sequence 2 n=
ame snapshot
>>>> =C2=A0 =C2=A0 item 30 key (14451 ROOT_ITEM 1899154) itemoff 12047 ite=
msize 439
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2025981 root_dirid 256 bytenr =
71398809468928=20
>>>> byte_limit 0 bytes_used 6747799552
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2018745 flags 0x1(RDONLY) r=
efs 1
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_le=
vel 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2025981
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid c5e2ba38-c982-8a4f-99e5-bb9ff8c5f7cd
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600=
f2db6a8
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-000=
000000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 1897416 otransid 1899154 stransi=
d 0 rtransid 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1758484800.817458724 (2025-09-21 23=
:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1758488400.101635440 (2025-09-22 00=
:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 item 31 key (14451 ROOT_BACKREF 256) itemoff 12021 item=
size 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 28635 sequence 2 n=
ame snapshot
>>>> =C2=A0 =C2=A0 item 32 key (14475 ROOT_ITEM 1942246) itemoff 11582 ite=
msize 439
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2025984 root_dirid 256 bytenr =
71398831259648=20
>>>> byte_limit 0 bytes_used 6755549184
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2018745 flags 0x1(RDONLY) r=
efs 1
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_le=
vel 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2025984
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 38b9ea09-54ef-5140-bddc-83dc884c31b3
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600=
f2db6a8
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-000=
000000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 1940067 otransid 1942246 stransi=
d 0 rtransid 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1758570000.151997903 (2025-09-22 22=
:40:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1758574800.777676964 (2025-09-23 00=
:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 item 33 key (14475 ROOT_BACKREF 256) itemoff 11556 item=
size 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 28683 sequence 2 n=
ame snapshot
>>>> =C2=A0 =C2=A0 item 34 key (14499 ROOT_ITEM 1977241) itemoff 11117 ite=
msize 439
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2025986 root_dirid 256 bytenr =
71398873153536=20
>>>> byte_limit 0 bytes_used 6538182656
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2018745 flags 0x1(RDONLY) r=
efs 1
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_le=
vel 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2025986
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 703f0298-831b-1e4d-b1f1-fc37ff582770
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600=
f2db6a8
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-000=
000000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 1977241 otransid 1977241 stransi=
d 0 rtransid 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1758661201.518446292 (2025-09-24 00=
:00:01)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1758661204.161207119 (2025-09-24 00=
:00:04)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 item 35 key (14499 ROOT_BACKREF 256) itemoff 11091 item=
size 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 28731 sequence 2 n=
ame snapshot
>>>> =C2=A0 =C2=A0 item 36 key (14523 ROOT_ITEM 2001507) itemoff 10652 ite=
msize 439
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2025988 root_dirid 256 bytenr =
71398873497600=20
>>>> byte_limit 0 bytes_used 6561398784
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2018745 flags 0x1(RDONLY) r=
efs 1
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_le=
vel 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2025988
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 9672abd0-7e7b-ab4f-9e0f-7183e58bb6c4
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600=
f2db6a8
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-000=
000000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 2001507 otransid 2001507 stransi=
d 0 rtransid 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1758747600.712874426 (2025-09-25 00=
:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1758747600.840460363 (2025-09-25 00=
:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 item 37 key (14523 ROOT_BACKREF 256) itemoff 10626 item=
size 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 28779 sequence 2 n=
ame snapshot
>>>> =C2=A0 =C2=A0 item 38 key (14547 ROOT_ITEM 2017206) itemoff 10187 ite=
msize 439
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2025990 root_dirid 256 bytenr =
71398872924160=20
>>>> byte_limit 0 bytes_used 6570868736
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2018745 flags 0x1(RDONLY) r=
efs 1
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_le=
vel 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2025990
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 671b4b4f-fd99-e140-8535-fce0a16babfb
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600=
f2db6a8
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-000=
000000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 2017206 otransid 2017206 stransi=
d 0 rtransid 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1758834001.88320469 (2025-09-26 00:=
00:01)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1758834001.271433540 (2025-09-26 00=
:00:01)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 item 39 key (14547 ROOT_BACKREF 256) itemoff 10161 item=
size 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 28827 sequence 2 n=
ame snapshot
>>>> =C2=A0 =C2=A0 item 40 key (14559 ROOT_ITEM 2019735) itemoff 9722 item=
size 439
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2025992 root_dirid 256 bytenr =
75423231606784=20
>>>> byte_limit 0 bytes_used 6576078848
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2019735 flags 0x1(RDONLY) r=
efs 1
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_le=
vel 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2025992
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 3ff52125-57ee-6140-87a5-4fb848ec4638
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600=
f2db6a8
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-000=
000000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 2019711 otransid 2019735 stransi=
d 0 rtransid 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1758919659.690576855 (2025-09-26 23=
:47:39)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1758920400.700930626 (2025-09-27 00=
:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 item 41 key (14559 ROOT_BACKREF 256) itemoff 9696 items=
ize 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 28851 sequence 2 n=
ame snapshot
>>>> =C2=A0 =C2=A0 item 42 key (14583 ROOT_ITEM 2022097) itemoff 9257 item=
size 439
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2025994 root_dirid 256 bytenr =
65812067024896=20
>>>> byte_limit 0 bytes_used 6557646848
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2022097 flags 0x1(RDONLY) r=
efs 1
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_le=
vel 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2025994
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 860f0635-f296-a04b-9fc5-bd85d480799c
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600=
f2db6a8
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-000=
000000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 2022097 otransid 2022097 stransi=
d 0 rtransid 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1759006819.37527411 (2025-09-28 00:=
00:19)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1759006820.861182212 (2025-09-28 00=
:00:20)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 item 43 key (14583 ROOT_BACKREF 256) itemoff 9231 items=
ize 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 28899 sequence 2 n=
ame snapshot
>>>> =C2=A0 =C2=A0 item 44 key (14607 ROOT_ITEM 2024585) itemoff 8792 item=
size 439
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2025996 root_dirid 256 bytenr =
227573944696832=20
>>>> byte_limit 0 bytes_used 6583533568
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2024585 flags 0x1(RDONLY) r=
efs 1
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_le=
vel 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2025996
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid af3524d0-8a9a-894c-b5b7-705b10114326
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600=
f2db6a8
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-000=
000000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 2024474 otransid 2024585 stransi=
d 0 rtransid 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1759089642.387498362 (2025-09-28 23=
:00:42)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1759093200.412309185 (2025-09-29 00=
:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 item 45 key (14607 ROOT_BACKREF 256) itemoff 8766 items=
ize 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 28947 sequence 2 n=
ame snapshot
>>>> =C2=A0 =C2=A0 item 46 key (14631 ROOT_ITEM 2025813) itemoff 8327 item=
size 439
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2025998 root_dirid 256 bytenr =
178141351657472=20
>>>> byte_limit 0 bytes_used 6602981376
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2025813 flags 0x1(RDONLY) r=
efs 1
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_le=
vel 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2025998
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 6f085114-93b0-d146-8997-9a41ff62f8db
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600=
f2db6a8
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-000=
000000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 2025812 otransid 2025813 stransi=
d 0 rtransid 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1759177902.175859896 (2025-09-29 23=
:31:42)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1759210423.120386595 (2025-09-30 08=
:33:43)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 item 47 key (14631 ROOT_BACKREF 256) itemoff 8301 items=
ize 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 28995 sequence 2 n=
ame snapshot
>>>> =C2=A0 =C2=A0 item 48 key (14640 ROOT_ITEM 2025865) itemoff 7862 item=
size 439
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2026000 root_dirid 256 bytenr =
194611771719680=20
>>>> byte_limit 0 bytes_used 6603735040
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2025865 flags 0x1(RDONLY) r=
efs 1
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_le=
vel 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2026000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid a48f03d9-4847-654a-af1d-5e0eaf6ecd0c
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600=
f2db6a8
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-000=
000000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 2025863 otransid 2025865 stransi=
d 0 rtransid 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1759237252.139079795 (2025-09-30 16=
:00:52)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1759240800.56609287 (2025-09-30 17:=
00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 item 49 key (14640 ROOT_BACKREF 256) itemoff 7836 items=
ize 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 29013 sequence 2 n=
ame snapshot
>>>> =C2=A0 =C2=A0 item 50 key (14641 ROOT_ITEM 2025870) itemoff 7397 item=
size 439
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2026002 root_dirid 256 bytenr =
65801342844928=20
>>>> byte_limit 0 bytes_used 6603292672
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2025870 flags 0x1(RDONLY) r=
efs 1
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_le=
vel 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2026002
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 56e7aa4e-e166-504d-9a55-8c8b074c0fd9
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600=
f2db6a8
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-000=
000000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 2025868 otransid 2025870 stransi=
d 0 rtransid 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1759241717.101400473 (2025-09-30 17=
:15:17)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1759244400.232224532 (2025-09-30 18=
:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 item 51 key (14641 ROOT_BACKREF 256) itemoff 7371 items=
ize 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 29015 sequence 2 n=
ame snapshot
>>>> =C2=A0 =C2=A0 item 52 key (14642 ROOT_ITEM 2025874) itemoff 6932 item=
size 439
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2026004 root_dirid 256 bytenr =
187252895498240=20
>>>> byte_limit 0 bytes_used 6603341824
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2025874 flags 0x1(RDONLY) r=
efs 1
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_le=
vel 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2026004
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid f1761dfd-ec60-724a-9af0-dea952cc6771
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600=
f2db6a8
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-000=
000000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 2025872 otransid 2025874 stransi=
d 0 rtransid 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1759244441.841998010 (2025-09-30 18=
:00:41)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1759248000.122051877 (2025-09-30 19=
:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 item 53 key (14642 ROOT_BACKREF 256) itemoff 6906 items=
ize 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 29017 sequence 2 n=
ame snapshot
>>>> =C2=A0 =C2=A0 item 54 key (14643 ROOT_ITEM 2025904) itemoff 6467 item=
size 439
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2026006 root_dirid 256 bytenr =
227587769647104=20
>>>> byte_limit 0 bytes_used 6603587584
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2025904 flags 0x1(RDONLY) r=
efs 1
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_le=
vel 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2026006
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 68fd5037-6c8a-c74e-b08f-cff4cdccf752
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600=
f2db6a8
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-000=
000000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 2025904 otransid 2025904 stransi=
d 0 rtransid 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1759251597.815452999 (2025-09-30 19=
:59:57)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1759251600.884521740 (2025-09-30 20=
:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 item 55 key (14643 ROOT_BACKREF 256) itemoff 6441 items=
ize 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 29019 sequence 2 n=
ame snapshot
>>>> =C2=A0 =C2=A0 item 56 key (14644 ROOT_ITEM 2025922) itemoff 6002 item=
size 439
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2026008 root_dirid 256 bytenr =
227594191208448=20
>>>> byte_limit 0 bytes_used 6603653120
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2025922 flags 0x1(RDONLY) r=
efs 1
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_le=
vel 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2026008
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 07ccd2ae-f51d-2c46-82df-05e16964b2e5
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600=
f2db6a8
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-000=
000000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 2025921 otransid 2025922 stransi=
d 0 rtransid 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1759254975.20573006 (2025-09-30 20:=
56:15)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1759255200.196692319 (2025-09-30 21=
:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 item 57 key (14644 ROOT_BACKREF 256) itemoff 5976 items=
ize 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 29021 sequence 2 n=
ame snapshot
>>>> =C2=A0 =C2=A0 item 58 key (14645 ROOT_ITEM 2025951) itemoff 5537 item=
size 439
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2026010 root_dirid 256 bytenr =
193309358817280=20
>>>> byte_limit 0 bytes_used 6603964416
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 2025951 flags 0x1(RDONLY) r=
efs 1
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_le=
vel 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 3 generation_v2 2026010
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid b46ce558-2c39-3944-91d4-b2b229f04a16
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid eea49a45-adcf-4bff-a203-0f600=
f2db6a8
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-000=
000000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 2025950 otransid 2025951 stransi=
d 0 rtransid 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 1759257514.988583086 (2025-09-30 21=
:38:34)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 1759258800.482340435 (2025-09-30 22=
:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 item 59 key (14645 ROOT_BACKREF 256) itemoff 5511 items=
ize 26
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 root backref key dirid 29023 sequence 2 n=
ame snapshot
>>>> =C2=A0 =C2=A0 item 60 key (DATA_RELOC_TREE ROOT_ITEM 0) itemoff 5072 =
itemsize 439
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 generation 2018764 root_dirid 256 bytenr =
71399055278080=20
>>>> byte_limit 0 bytes_used 16384
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 last_snapshot 0 flags 0x0(none) refs 1
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 drop_progress key (0 UNKNOWN.0 0) drop_le=
vel 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 level 0 generation_v2 2018764
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uuid 00000000-0000-0000-0000-000000000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 parent_uuid 00000000-0000-0000-0000-00000=
0000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 received_uuid 00000000-0000-0000-0000-000=
000000000
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctransid 0 otransid 0 stransid 0 rtransid=
 0
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ctime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 otime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 stime 0.0 (1970-01-01 02:00:00)
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 rtime 0.0 (1970-01-01 02:00:00)
>>>
>>> Qu Wenruo kirjoitti 5.10.2025 klo 1.07:
>>>>
>>>>
>>>> =E5=9C=A8 2025/10/5 08:23, Henri Hyyryl=C3=A4inen =E5=86=99=E9=81=93:
>>>>>> One extra thing, at the time of the initial "btrfs check --=20
>>>>>> repair", there is no running dev-replace/balance or whatever runnin=
g?
>>>>>>
>>>>>> Although those operations will be automatically paused by unmount,
>>>>>> btrfs check is not going to be able to handle some of those paused=
=20
>>>>>> operations.=20
>>>>>
>>>>> Is there a way for me to check that without mounting the=20
>>>>> filesystem? As far as I could find, none of the balance / scrub=20
>>>>> commands allow working on an unmounted filesystem. So I couldn't=20
>>>>> find out if I had any in canceled state.
>>>>
>>>> # btrfs ins dump-tree -t root <device>
>>>>>
>>>>> Though, I'm pretty sure I let the last scrub and balance operation=
=20
>>>>> I tried to fully complete before starting using the check and=20
>>>>> repair commands. But I'm not absolutely certain that I didn't try=20
>>>>> one of those a last time and didn't let it fully complete.
>>>>>
>>>>> I'll start that "btrfs check --readonly" command now. And I'll=20
>>>>> report back once it is done (hopefully by the morning in my timezone=
).
>>>>>
>>>>> - Henri Hyyryl=C3=A4inen
>>>>>
>>>>> Qu Wenruo kirjoitti 4.10.2025 klo 23.55:
>>>>>>
>>>>>>
>>>>>> =E5=9C=A8 2025/10/5 07:14, Qu Wenruo =E5=86=99=E9=81=93:
>>>>>>>
>>>>>>>
>>>>>>> =E5=9C=A8 2025/10/5 04:13, Henri Hyyryl=C3=A4inen =E5=86=99=E9=81=
=93:
>>>>>>>> Hello again.
>>>>>>>>
>>>>>>>> It took over 3 days, but the btrfs check --repair has now=20
>>>>>>>> completed seemingly successfully. I mostly saw output about the=
=20
>>>>>>>> file being placed in lost+found and and directory size being=20
>>>>>>>> corrected. However, there were some messages about mismatch of=20
>>>>>>>> used bytes.
>>>>>>>>
>>>>>>>> Unfortunately it seems like the situation has gotten worse since=
=20
>>>>>>>> the repair, because now I cannot mount the filesystem at all.=20
>>>>>>>> Instead I get an error like this:
>>>>>>>>
>>>>>>>>> BTRFS error (device sdc): dev extent physical offset=20
>>>>>>>>> 19977638903808 on devid 4 doesn't have corresponding chunk
>>>>>>>>> BTRFS error (device sdc): failed to verify dev extents against=
=20
>>>>>>>>> chunks: -117
>>>>>>>>> BTRFS error (device sdc): open_ctree failed: -117
>>>>>>>> Even if I remove that one problematic device physically from my=
=20
>>>>>>>> computer, the filesystem still refuses to mount with the same=20
>>>>>>>> error. Maybe the problems with the device replace are again=20
>>>>>>>> showing up with the actual size of the hard drive not being used=
=20
>>>>>>>> correctly? I cannot try to remove the device slack as I cannot=20
>>>>>>>> mount the filesystem.
>>>>>>>
>>>>>>> Nope, this is a different problem, and not related to dev replace.
>>>>>>>
>>>>>>> Unfortunately btrfs check has not implemented any repair for that.
>>>>>>>
>>>>>>> Overall if the dev extent is found but not corresponding chunk,=20
>>>>>>> it should still be fine but some space unavailable.
>>>>>>>
>>>>>>> But the kernel is overly cautious on chunk tree, as it's a very=20
>>>>>>> important and basic functionality.
>>>>>>>
>>>>>>> Please provide the full "btrfs check --readonly" output so that=20
>>>>>>> we can evaluate and add the missing repair functionality.
>>>>>>
>>>>>> One extra thing, at the time of the initial "btrfs check --=20
>>>>>> repair", there is no running dev-replace/balance or whatever runnin=
g?
>>>>>>
>>>>>> Although those operations will be automatically paused by unmount,
>>>>>> btrfs check is not going to be able to handle some of those paused=
=20
>>>>>> operations.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Qu
>>>>>>>
>>>>>>>>
>>>>>>>> I did try to run a repair again, and this time I got a bunch of=
=20
>>>>>>>> messages like:
>>>>>>>>
>>>>>>>>> repair deleting extent record: key [65795546775552,169,0]
>>>>>>>>> adding new tree backref on start 65795546775552 len 16384=20
>>>>>>>>> parent 65811674234880 root 65811674234880
>>>>>>>>> adding new tree backref on start 65795546775552 len 16384=20
>>>>>>>>> parent 0 root 14499
>>>>>>>>> adding new tree backref on start 65795546775552 len 16384=20
>>>>>>>>> parent 65791012274176 root 65791012274176
>>>>>>>>> adding new tree backref on start 65795546775552 len 16384=20
>>>>>>>>> parent 65806385807360 root 65806385807360
>>>>>>>>> Repaired extent references for 65795546775552
>>>>>>>>> ref mismatch on [65795548233728 16384] extent item 5, found 4
>>>>>>>
>>>>>>> That's fixing some backref mismatch, which you can ignore unless=
=20
>>>>>>> "btrfs check --reaonly" later reports new problems.
>>>>>>>
>>>>>>>> But the filesystem still refuses to mount with the exact same=20
>>>>>>>> error. I did not let the repair run entirely as it would have=20
>>>>>>>> likely taken another 3 days. What should I do? This time I'm not=
=20
>>>>>>>> finding any good information on what to do. For now, I've=20
>>>>>>>> started the repair again, but it doesn't exactly sound like it=20
>>>>>>>> is even fixing anything now. Still, I'll let it continue. The=20
>>>>>>>> output so far is:
>>>>>>>>
>>>>>>>>> [1/8] checking log skipped (none written)
>>>>>>>>> [2/8] checking root items
>>>>>>>>> Fixed 0 roots.
>>>>>>>>> [3/8] checking extents
>>>>>>>>> Device extent[4, 19977638903808, 1073741824] didn't find the=20
>>>>>>>>> relative chunk.
>>>>>>>>> super bytes used 49454738989056 mismatches actual used=20
>>>>>>>>> 49454738923520
>>>>>>>>> Device extent[4, 19977638903808, 1073741824] didn't find the=20
>>>>>>>>> relative chunk.
>>>>>>>>> super bytes used 49454739005440 mismatches actual used=20
>>>>>>>>> 49454738956288
>>>>>>>>> Device extent[4, 19977638903808, 1073741824] didn't find the=20
>>>>>>>>> relative chunk.
>>>>>>>>> super bytes used 49454739021824 mismatches actual used=20
>>>>>>>>> 49454738972672
>>>>>>>>> Device extent[4, 19977638903808, 1073741824] didn't find the=20
>>>>>>>>> relative chunk.
>>>>>>>>> super bytes used 49454739005440 mismatches actual used=20
>>>>>>>>> 49454738972672
>>>>>>>>
>>>>>>>>
>>>>>>>> If I was able to somehow remove that one logically corrupt devid=
=20
>>>>>>>> from the filesystem, or somehow correct the size, that would=20
>>>>>>>> hopefully allow me to rebuild from the raid10 data then, but I=20
>>>>>>>> can't do those with the unmountable filesystem.
>>>>>>>>
>>>>>>>>
>>>>>>>> - Henri Hyyryl=C3=A4inen
>>>>>>>>
>>>>>>>> Qu Wenruo kirjoitti 30.9.2025 klo 0.52:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> =EF=BF=BD=EF=BF=BD=EF=BF=BD 2025/9/30 02:41, Henri Hyyryl=C3=A4i=
nen =E5=86=99=E9=81=93:
>>>>>>>>>> Hello,
>>>>>>>>>>
>>>>>>>>>> I hope this is the right place to ask about a filesystem=20
>>>>>>>>>> problem. Really shortly put, I have a file that both exists=20
>>>>>>>>>> and doesn't and prevents the containing directory from being=20
>>>>>>>>>> deleted. No matter what variant of rm and inode based deletion=
=20
>>>>>>>>>> I try I get an error about the file not existing, and I also=20
>>>>>>>>>> cannot try to read the file, but if I try to delete the=20
>>>>>>>>>> directory I get an error that it is not empty (so the file=20
>>>>>>>>>> kind of exists). Trying to ls the directory also gives a file=
=20
>>>>>>>>>> doesn't exist error.
>>>>>>>>>>
>>>>>>>>>> Here's what btrfs check found, which I hope does better in=20
>>>>>>>>>> illustrating the problem:
>>>>>>>>>>
>>>>>>>>>>> root 5 inode 25953213 errors 200, dir isize wrong
>>>>>>>>>>> root 5 inode 27166085 errors 2000, link count wrong
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir =
25953213 index 7 namelen 33 name=20
>>>>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir=
=20
>>>>>>>>>>> item
>>>>>>>>>>
>>>>>>>>>> I've tried everything I've found suggested including a full=20
>>>>>>>>>> scrub, balance with -dusage=3D75 -musage=3D75, resetting file=
=20
>>>>>>>>>> attributes, deleting through the find command, and even some=20
>>>>>>>>>> repair mount flags that don't seem to exist for btrfs.
>>>>>>>>>
>>>>>>>>> The fs is corrupted, thus none of those will help.
>>>>>>>>> I'm more interested in how the corruption happened.
>>>>>>>>>
>>>>>>>>> Did you use some tools other than btrfs kernel module and=20
>>>>>>>>> btrfs- progs?
>>>>>>>>> Like ntfs2btrfs or winbtrfs?
>>>>>>>>>
>>>>>>>>> IIRC certain versions have some bugs related to extent tree,=20
>>>>>>>>> but should not cause this problem.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> The other possibility is hardware memory bitflip, which is more=
=20
>>>>>>>>> common than you thought (almostly one report per month)
>>>>>>>>>
>>>>>>>>> In that case, a full memtest is always recommended, or you will=
=20
>>>>>>>>> hit all kinds of weird corruptions in the future anyway.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> With a full memtest proving the memory hardware is fine, then=20
>>>>>>>>> "btrfs check --repair" should be able to fix it.
>>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Qu
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> What I haven't tried is a full rebalance with no filters, but=
=20
>>>>>>>>>> I did not try that yet as it would take quite a long time and=
=20
>>>>>>>>>> if it only moves data blocks around without recomputing=20
>>>>>>>>>> directory items, it doesn't seem like the right tool to fix my=
=20
>>>>>>>>>> problem. So I'm pretty much stuck and to me it seems like my=20
>>>>>>>>>> only option is to run btrfs check with the repair flag, but as=
=20
>>>>>>>>>> that has big warnings on it I thought I would try asking here=
=20
>>>>>>>>>> first (sorry if this is not the right experts group to ask).=20
>>>>>>>>>> So is there still something I can try or am I finally=20
>>>>>>>>>> "allowed" to use the repair command? Here's the full output I=
=20
>>>>>>>>>> got from btrfs check:
>>>>>>>>>>
>>>>>>>>>>> Opening filesystem to check...
>>>>>>>>>>> Checking filesystem on /dev/sdc
>>>>>>>>>>> UUID: 2b4ad16d-e456-4adf-960b-dca43560b98b
>>>>>>>>>>> [1/8] checking log skipped (none written)
>>>>>>>>>>> [2/8] checking root items
>>>>>>>>>>> [3/8] checking extents
>>>>>>>>>>> [4/8] checking free space tree
>>>>>>>>>>> We have a space info key for a block group that doesn't exist
>>>>>>>>>>> [5/8] checking fs roots
>>>>>>>>>>> root 5 inode 25953213 errors 200, dir isize wrong
>>>>>>>>>>> root 5 inode 27166085 errors 2000, link count wrong
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir =
25953213 index 7 namelen 33 name=20
>>>>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir=
=20
>>>>>>>>>>> item
>>>>>>>>>>> root 14428 inode 25953213 errors 200, dir isize wrong
>>>>>>>>>>> root 14428 inode 27166085 errors 2000, link count wrong
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir =
25953213 index 7 namelen 33 name=20
>>>>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir=
=20
>>>>>>>>>>> item
>>>>>>>>>>> root 14451 inode 25953213 errors 200, dir isize wrong
>>>>>>>>>>> root 14451 inode 27166085 errors 2000, link count wrong
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir =
25953213 index 7 namelen 33 name=20
>>>>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir=
=20
>>>>>>>>>>> item
>>>>>>>>>>> root 14475 inode 25953213 errors 200, dir isize wrong
>>>>>>>>>>> root 14475 inode 27166085 errors 2000, link count wrong
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir =
25953213 index 7 namelen 33 name=20
>>>>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir=
=20
>>>>>>>>>>> item
>>>>>>>>>>> root 14499 inode 25953213 errors 200, dir isize wrong
>>>>>>>>>>> root 14499 inode 27166085 errors 2000, link count wrong
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir =
25953213 index 7 namelen 33 name=20
>>>>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir=
=20
>>>>>>>>>>> item
>>>>>>>>>>> root 14523 inode 25953213 errors 200, dir isize wrong
>>>>>>>>>>> root 14523 inode 27166085 errors 2000, link count wrong
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir =
25953213 index 7 namelen 33 name=20
>>>>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir=
=20
>>>>>>>>>>> item
>>>>>>>>>>> root 14544 inode 25953213 errors 200, dir isize wrong
>>>>>>>>>>> root 14544 inode 27166085 errors 2000, link count wrong
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir =
25953213 index 7 namelen 33 name=20
>>>>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir=
=20
>>>>>>>>>>> item
>>>>>>>>>>> root 14545 inode 25953213 errors 200, dir isize wrong
>>>>>>>>>>> root 14545 inode 27166085 errors 2000, link count wrong
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir =
25953213 index 7 namelen 33 name=20
>>>>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir=
=20
>>>>>>>>>>> item
>>>>>>>>>>> root 14546 inode 25953213 errors 200, dir isize wrong
>>>>>>>>>>> root 14546 inode 27166085 errors 2000, link count wrong
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir =
25953213 index 7 namelen 33 name=20
>>>>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir=
=20
>>>>>>>>>>> item
>>>>>>>>>>> root 14547 inode 25953213 errors 200, dir isize wrong
>>>>>>>>>>> root 14547 inode 27166085 errors 2000, link count wrong
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir =
25953213 index 7 namelen 33 name=20
>>>>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir=
=20
>>>>>>>>>>> item
>>>>>>>>>>> root 14548 inode 25953213 errors 200, dir isize wrong
>>>>>>>>>>> root 14548 inode 27166085 errors 2000, link count wrong
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir =
25953213 index 7 namelen 33 name=20
>>>>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir=
=20
>>>>>>>>>>> item
>>>>>>>>>>> root 14549 inode 25953213 errors 200, dir isize wrong
>>>>>>>>>>> root 14549 inode 27166085 errors 2000, link count wrong
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir =
25953213 index 7 namelen 33 name=20
>>>>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir=
=20
>>>>>>>>>>> item
>>>>>>>>>>> root 14550 inode 25953213 errors 200, dir isize wrong
>>>>>>>>>>> root 14550 inode 27166085 errors 2000, link count wrong
>>>>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir =
25953213 index 7 namelen 33 name=20
>>>>>>>>>>> Microsoft.AspNetCore.Metadata.dll filetype 1 errors 1, no dir=
=20
>>>>>>>>>>> item
>>>>>>>>>>> ERROR: errors found in fs roots
>>>>>>>>>>> found 49400296812544 bytes used, error(s) found
>>>>>>>>>>> total csum bytes: 48179330432
>>>>>>>>>>> total tree bytes: 65067483136
>>>>>>>>>>> total fs tree bytes: 12107431936
>>>>>>>>>>> total extent tree bytes: 3194437632
>>>>>>>>>>> btree space waste bytes: 4558984171
>>>>>>>>>>> file data blocks allocated: 76487982252032
>>>>>>>>>>> =C2=A0referenced 60030799097856
>>>>>>>>>>
>>>>>>>>>> So hopefully if I'm reading things right, running a repair=20
>>>>>>>>>> would delete just that one file and directory (which itself is=
=20
>>>>>>>>>> a backup so I will not miss that file at all)?
>>>>>>>>>>
>>>>>>>>>> I do not have enough disk space to copy off the entire=20
>>>>>>>>>> filesystem and rebuild from scratch, without doing something=20
>>>>>>>>>> like rebalancing all data from raid10 to single and then=20
>>>>>>>>>> removing half the disks, but I assume that would take at least=
=20
>>>>>>>>>> 4 weeks to process (as I just replaced a disk which took like=
=20
>>>>>>>>>> a week).
>>>>>>>>>>
>>>>>>>>>> As to what originally caused the corruption, I think it was=20
>>>>>>>>>> probably faulty RAM, because up to to like 3 weeks ago I had=20
>>>>>>>>>> one really bad RAM stick in my computer where a certain memory=
=20
>>>>>>>>>> region always had incorrectly reading bytes. I had seen=20
>>>>>>>>>> intermittent quite high csum errors in monthly scrubs pretty=20
>>>>>>>>>> randomly, which thankfully could almost always be corrected so=
=20
>>>>>>>>>> I didn't have any major problems even though I had like=20
>>>>>>>>>> totally broken RAM in my computer for who knows how long. So=20
>>>>>>>>>> btrfs was able to protect my data quite impressively from bad=
=20
>>>>>>>>>> RAM.
>>>>>>>>>>
>>>>>>>>>> Sorry for getting a bit sidetracked there, but what should I=20
>>>>>>>>>> do in this situation?
>>>>>>>>>>
>>>>>>>>>> - Henri Hyyryl=C3=A4inen
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>
>>>>
>>>
>>


