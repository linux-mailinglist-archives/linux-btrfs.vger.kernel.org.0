Return-Path: <linux-btrfs+bounces-538-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDFB801E62
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Dec 2023 21:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A66CB20BE8
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 Dec 2023 20:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CBF2111A;
	Sat,  2 Dec 2023 20:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="q7vqwiTa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770F39E
	for <linux-btrfs@vger.kernel.org>; Sat,  2 Dec 2023 12:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701547637; x=1702152437; i=quwenruo.btrfs@gmx.com;
	bh=VBS66Z9SYyFqzyByrzJRrBejb1i4CiaRei/1a4awY7Q=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=q7vqwiTaBioRqVMvXCk8BcDBqfc/CEp7W0UoEN967+VU1XcNBU2dfcPBRGzFp61o
	 i1JtEPpJAxp9GmAUIR7IICgS7P65aeNjXWtoVATiKlZkY76Ts3zSIOubT7j4tjwk7
	 QmVvnX0wR5w76iXhARRRMgDpaq0fdFIXMQnI600nWCHlj62inpU50JF+247xItqu2
	 fsBss1lt2THhqyZwZD5SkCT5uLYU3PHfFxhwVEfR5FVbjRTNch1zwudalcYm0ct2Q
	 k5dua56msHKeWhcnx0vRVXxlEb/B4ECGcEBW4kedKH93ZWzv86IMDf/i+Dd/1wUJo
	 ma91uskzNIGFbmeINg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MoO6C-1rc1W90fP6-00orli; Sat, 02
 Dec 2023 21:07:17 +0100
Message-ID: <d30abb90-4ab2-4f66-88b0-7d0992b41527@gmx.com>
Date: Sun, 3 Dec 2023 06:37:13 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BTRFS doesn't compress on the fly
To: Gerhard Wiesinger <lists@wiesinger.com>, linux-btrfs@vger.kernel.org
References: <ac521d3f-6575-4a72-a911-1991a2ca5f67@wiesinger.com>
 <ccec2d73-98a7-4e73-a9ee-9be0fc2e1c92@gmx.com>
 <b7995589-35a4-4595-baea-1dcdf1011d68@wiesinger.com>
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
In-Reply-To: <b7995589-35a4-4595-baea-1dcdf1011d68@wiesinger.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wV4PeO/YTRTVzTnuLXIRs01O0AdSUU0Gl1XwwJaqLN70Ok1Xjf/
 Nd83ccoviD+bqPDckzYigV/Q7ZErX3MyNP/4zNLf0iiNKJlcEU/cOExfjy51EDe87PJdi5H
 dUO+uiOF2rN8Nc4Sztedlt4CJZKT0ILlqoD0VIG2xcpLnYbLSgHO/ESYVjHQYmtLJ3Rix8j
 ROX5DnPOwwtEodcpRnCCQ==
UI-OutboundReport: notjunk:1;M01:P0:R7eQd0ogaaA=;wFCvQUcQCHL+WJF+wN1Rfn5+u7o
 t096EvgsUV0G50d9LcP71S5vvzarFuimrOWAW8zxqUn4DBQ+ZHabxkYVa6pwTgBmjO9VTDbv/
 Rwq73Os14sSbUPCrqXet86z9a5OAqJdOHVen7n9ezScp/yJTNLtkgds836DwVI3isuN9eJ3+G
 p3/5qAmEdj5hSTnLAH+H8ke34BitHsA2El7KrcN+taUGZNq5iNV+uxzhj4Ze+wz+edyWugP6d
 OPhUwCXP8whAGloTBG2mY37S0ZFTaDETazIT0IvivgFRIPPI8pvX8CPT8qflzb40ltc85pjmN
 gr4xpIjx/hbSK+nHGMdq/hUMLMyXqEMWCQ8P7zpkjJzX5QHgAMSlVaRZg9erJA7ET+6Br1QhC
 q8F5y7yxhBf52yH6LjOmlU9EVJ++d45RRDI3mN6sFcSavHFFyuE5ynaRijpJrtHbWg16sGjMP
 t817Aznjk/DiAlJERYiQ/TWo1KdHDa4AFgRVtN5Fe8qnxJKwghjwah1x/UU0p++HJhudtEk2f
 Kd+LDmdOHqHfknxdliSROFmAWsDJ1Y2Yw88DwniAqEa9HuCZQq0GmsjzH51xhnjJiu6pxVMt6
 MGTsLwRwWGhTEjuW+mYHiXUtX5HUOIFq+5Ao8GcQ5sWAJ42z+utNytZzTx/PXXn0fQwvYTMwH
 QKmE632zN0rdnr6YcAfYnFjsv9bEGxxI2o4b5QTQel5kIg5ZOYXzdiyugCgyOP8fTPX/GflHZ
 BrUUjVa06CWCS/nwQHrVigCOin5mUUSalGwS4+gsbK9YjQ/mBwTtdtAU1kOQwlxeVwhHCGDf/
 /4wAcAg6G+r6bD7BGrqFP4nAskAMLFpCfzlEUAyOZYmyomt8KSpeg6H4v8bFXFFhHxt+cISj2
 jZrp4nNiu3HNTpa4eJOW9opZF20Vl9LEx274agB6LIemzrTztCfLc/yHmTEgQcWKenrjWmrvx
 CqhMgLjYrZxtL9XbdMPbY7ADlsA=



On 2023/12/2 22:32, Gerhard Wiesinger wrote:
> Hello Qu,
>
> Thank you for the answers, see inline.
>
> Any further ideas?
>
> Ciao,
> Gerhard.
>
> On 30.11.2023 21:53, Qu Wenruo wrote:
>>
>>
>> On 2023/11/30 21:51, Gerhard Wiesinger wrote:
>>> Dear All,
>>>
>>> I created a new BTRFS volume with migrating an existing PostgreSQL
>>> database on it. Versions are recent.
>>
>> Does the data base directory has something like NODATACOW or NODATASUM
>> set?
>> The other possibility is preallocation, for the first write on
>> preallocated range, no matter if the compression is enabled, the write
>> would be treated as NOCOW.
>>
> I don't think so. How to find out (googled already a lot)?

I normally go `btrfs ins dump-tree`, dump the subvolume, grep for the
inode number with `grep -A 3 "item .* key (257 INODE_ITEM 0)"`, which
would show something like this:

	item 6 key (257 INODE_ITEM 0) itemoff 15811 itemsize 160
		generation 7 transid 8 size 4194304 nbytes 4194304
		block group 0 mode 100644 links 1 uid 0 gid 0 rdev 0
		sequence 513 flags 0x10(PREALLOC)

The flags is the btrfs specific flags, which would show NODATACOW or
NODATASUM.

>
> At least it is not mounted with these options (see also original post).
>
> # Mounted via force
> findmnt -vno OPTIONS /var/lib/pgsql
> rw,relatime,compress-force=3Dzstd:3,space_cache=3Dv2,subvolid=3D5,subvol=
=3D/'
>
> According to the following link it should compress anyway with the -o
> compress-force option:
>
> https://archive.kernel.org/oldwiki/btrfs.wiki.kernel.org/index.php/Compr=
ession.html#What.27s_the_precedence_of_all_the_options_affecting_compressi=
on.3F
> Compression to newly written data happens:
> always -- if the filesystem is mounted with -o compress-force
> never -- if the NOCOMPRESS flag is set per-file/-directory
> if possible -- if the COMPRESS per-file flag (aka chattr +c) is set, but
> it may get converted to NOCOMPRESS eventually
> if possible -- if the -o compress mount option is specified
> Note, that mounting with -o compress will not set the +c file attribute.

Well, if you check the kernel code, inside btrfs_run_delalloc_range(),
which calls should_nocow() to check if we should fall to NOCOW path.

That should_nocow() would check if the inode has NODATACOW or PREALLOC
flags, then verify if there is any defrag request for it.
If no defrag request, then it can go NOCOW, thus break the COW requirement=
.

>
[...]
>>> # Stays here at this compression level
>>> compsize -x /var/lib/pgsql
>>> Processed 5332 files, 575858 regular extents (591204 refs), 40 inline.
>>> Type=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Perc=C2=A0=C2=A0=C2=A0=C2=A0 =
Disk Usage=C2=A0=C2=A0 Uncompressed Referenced
>>> TOTAL=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 63%=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 51G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 80G=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 80G
>>> none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 40G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 40G=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 40G
>>> zstd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 27%=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 10G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 40G=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 40G
>>> prealloc=C2=A0=C2=A0 100%=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.0M=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.0M=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 5.5M
>>
>> Not sure if the preallocation is the cause, but maybe you can try
>> disabling preallocation of postgresql?
>>
>> As preallocation doesn't make that much sense on btrfs, there are too
>> many cases that can break the preallocation.
>
>
> I googled a lot and didn't find anything useful with preallocation and
> postgresql (looks like it doesn'use fallocate).

I don't think so.

>
> How can I find something about preallocation out?

Above compsize is already showing there is some preallocated space.

Thus I'm wondering if the preallocation is the cause.

As should_nocow() would also check the PREALLOC inode flag, and tries
NOCOW path first (then falls to COW if needed)

Thanks,
Qu

>
>
>

