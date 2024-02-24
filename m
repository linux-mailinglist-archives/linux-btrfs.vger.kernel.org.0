Return-Path: <linux-btrfs+bounces-2701-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BBA862279
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 04:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77C67286B13
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Feb 2024 03:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434C012E51;
	Sat, 24 Feb 2024 03:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Wvrn37wE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A183FEF
	for <linux-btrfs@vger.kernel.org>; Sat, 24 Feb 2024 03:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708744558; cv=none; b=gPPx+yUhyRHDP1X4ec/bjjL40dVpHqk/Q4j0hoHqhCfs4ZEYGCERYnfXQPYS5Fo2W4XpRkq+LVrYmVa2DTlYOHR55lI481iDNkjZPG/XTcgNH33UEASh8rEfcldtdriQXSR5pZd74xIHEO2W3q3ShEW1XY5/k2J3T0Qq4MWr57w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708744558; c=relaxed/simple;
	bh=8WftMSTHkJBThJRU/HohM2gb74kSWz/mlMzMLr8Lwbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Vk1Mzgl3VEKeNPy2qtq8CtxTe5HSkwmTU3ifma3S80PStjNXEanL/IUFujhwbE2DdRxuGntnYqUONZ28BABxkdBFZBDZCFVRUoprZTEqgKNpNdnlOmG8DY8vBBTfSQj/3BFnjE0EjRaQawbZJE4wLJfrIyohBO7HbPN9T33ErEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Wvrn37wE; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1708744505; x=1709349305; i=quwenruo.btrfs@gmx.com;
	bh=8WftMSTHkJBThJRU/HohM2gb74kSWz/mlMzMLr8Lwbk=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=Wvrn37wEmvTwLg6fRIDs6LxhEldg7/VvJ5IfVQpzVvgol7ZaTF8apWCxnkC42+St
	 7B7bl7fpnfSxSL/AaCpij2loyw6y/B/DdP/Uj4EPtMbq0mbgtfy0RR4a5tjjNtdL2
	 1gkV5Z8oW3eO3pecA9Xj3mmEUj9yl+5c6atzu6jtr5E6J2IV4MVwpQxAMnPsjN+vR
	 f3TlgpMCvAxoeJUqz6krGrzw3UiUnNX1PboiuuiZEOBcmtFZ78grIsAUImTIjzRCy
	 40rei38xJcwr+AOtNsny6nebtetpL1h4YcoM1PGX1yDtf5MCJFd4YUO7vsrQr2poy
	 /SzEjW9ae85vgsnFrQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWRVb-1rOWt11nmV-00Xs0k; Sat, 24
 Feb 2024 04:15:05 +0100
Message-ID: <4e2faa16-3021-4d53-9121-f41d86b428fd@gmx.com>
Date: Sat, 24 Feb 2024 13:45:00 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to repair BTRFS
Content-Language: en-US
To: Matthew Jurgens <default@edcint.co.nz>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <cb434383-5dfb-4748-8039-1496e09a2a80@edcint.co.nz>
 <e18d4a17-12ed-438a-bceb-b1a2e10d15d4@gmx.com>
 <be5917ba-4940-4800-9fbf-c1a24f4d82be@edcint.co.nz>
 <7382a5c8-726f-41b3-9cbf-b2c67f0a5419@suse.com>
 <0dd56988-e191-45c7-a3d7-60f43fc4b7fd@edcint.co.nz>
 <2b2d37d2-d618-44eb-97f8-549b99b7b4d1@edcint.co.nz>
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
In-Reply-To: <2b2d37d2-d618-44eb-97f8-549b99b7b4d1@edcint.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OF2bEjPyTFBLrtRY6podHqD/rYeBnDVZR/gHn4qPVAgGAp04uPE
 3s65EVMMqLOF5xdoBs2nb9flSdETlUjjgl8TZcsm9uU3E9neafMy9IgYqePvACzGMrBAez9
 M6ZlhSGVfCJlN7q2UlPJAC6L2C83ph2xTDAqcfB54+fQ+sUdnJvN/9n6IpJssddP0Q0nJBR
 fcktrpyIiF94UJ+5JzLSg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ggwP6JBK0RQ=;BV4D3VR21g97iUZCk6vVUPBO0qS
 g5hG/nUiGdNBdYW69oKH0G1sD+otsCtXvd25juKN/xjZlanb4Ck8HuWWMccrUvHuF72fK5DY8
 KY4ncwgp9PRBY4GOBiRrMczP1n1OqIM6N9U8jJW519OxLg2akYnA1M0kE+gkj2T/bLvRYRELZ
 qicIeBbc0JxqKTmaow0h4iFM/A+DKf++EODmfWEPIVxyc13/HyasaycIT8LewbxIlAdPVbniA
 D7jYsbdvnlpW+5abm4jFqk3OgT/xoc2Vjyqo9fNPJOcOMRl3XD9s4JGsh6HWPVhI8k+e05Q3Q
 NoRM/dzaIVuKLenf3gxAap9N0hhzU991EUHlS8xYzzLSAE8wkzVu8n+Wdaug9W4H2zdNVLewu
 cWBpqt7xMLghVEPevbztj2XEC0DwowOOPEUnXyQoAM5BN1HQm2fQvSammQT2VFzb1qo/JuofD
 cm5Uq0PrAccHnGILh+8l4blExiZmDaoxXf0UmAHKH51Xtuc9CGTbLBO8WJWBb5Wmyu97fbLum
 sKkiqKO7DFUnnQv3qgx64LTicO0ifUPyqKgwgUNc02M31aSIxhykkxz6UZHopSOyAbnMpW9IE
 wGwj9ET0Y6qYXxYpk10qumEehrE4cOsJVOwnsXbPccwvquomkgm3B/XCjd7pne4RhGSATD6XX
 oOFRX8gJBaz9P7WpesIi+k9h/0oOA46AsJdZE1VQjteL2y50/u2w6zBTN0gAizzs7RlFBhFwG
 vltfm2874lVmAr5Z5sorgWvapsM5SBdW6+Mu+vmnozaCV05S3AZjibgX2AGUbLDwAgY4Bty34
 6Z3jC+LkVTJeh1N4nkSQRU9rgbi3zxytw9TP/TDyswSAo=



=E5=9C=A8 2024/2/24 12:21, Matthew Jurgens =E5=86=99=E9=81=93:
>
> On 24/02/2024 12:22 pm, Matthew Jurgens wrote:
>> As I understand rescue=3Dall, I don't need it for allowing me to mount
>> (since I can already mount the file system) but it will allow me to
>> copy damaged files out of the file system. However, I don't know what
>> is damaged. I do have backups.
>>
>> Commands like=C2=A0 btrfs inspect-internal logical-resolve 206470878986=
24
>> /export/shared
>>
>> just return
>> ERROR: logical ino ioctl: No such file or directory

The damaged ones are tree blocks, thus logical resolve won't give a data
inode at all.

>>
> Having said this, I think I can find which files are damaged by trying
> to read every single file on the file system.

The problem is, since the corruption is in tree blocks, it can cover
quite some files with a single tree block.

>
> I was just doing some space calculations using du and it started
> throwing errors like:
>
> du: cannot access '/export/shared/backups/xyz': Input/output error
>
> which also resulted in entries in the messages file like:
>
> kernel: BTRFS warning (device sdg): checksum verify failed on logical
> 20647087931392 mirror 1 wanted 0x97fa472a found 0xccdf090b level 0
>
> where 20647087931392 is a number that appears in other messages eg dmesg
>
> I figure I can then just run a du on the whole file system and any files
> it complains about are probably problematic.
>
> If it turns out that I can do without the files, can I fix the problem
> just by deleting them or is there something else I must do?

Not really much you can do (at least safely).

As mentioned, the corruption a tree block, not on-disk data of a file
(which scrub can easily give you the path).

Furthermore, a single corrupted tree block can lead to tons of
cross-reference problem (that's why btrfs check is reporting tons of
problems).

It's hard to make the fs back to sane RW status.
You can try "btrfs check --repair", and you may need to do it several
times until no more repair or no more errors.

And without a full memtest run, if it's really some runtime memory
corruption, it will happen again.

Thanks,
Qu

>
>> On 24/02/2024 9:12 am, Qu Wenruo wrote:
>>>
>>>
>>> =E5=9C=A8 2024/2/24 08:11, Matthew Jurgens =E5=86=99=E9=81=93:
>>>>
>>>> On 24/02/2024 6:55 am, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> =E5=9C=A8 2024/2/23 21:39, Matthew Jurgens =E5=86=99=E9=81=93:
>>>>>> If I can't run --repair, then how do I repair my file system?
>>>>>>
>>>>>> I ran a scrub which reported 8 errors that could not be fixed.
>>>>>
>>>>> The scrub report and corresponding dmesg please.
>>>>>
>>>> The latest scrub report is
>>>>
>>>> UUID:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 021756e1-c9b4-41e7-bfd3-bc4e930eae46
>>>> Scrub started:=C2=A0=C2=A0=C2=A0 Fri Feb 23 21:42:13 2024
>>>> Status:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 f=
inished
>>>> Duration:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5:52:50
>>>> Total to scrub:=C2=A0=C2=A0 9.00TiB
>>>> Rate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 447.36MiB/s
>>>> Error summary:=C2=A0=C2=A0=C2=A0 verify=3D8
>>>> =C2=A0=C2=A0 Corrected:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>> =C2=A0=C2=A0 Uncorrectable:=C2=A0 8
>>>> =C2=A0=C2=A0 Unverified:=C2=A0=C2=A0=C2=A0=C2=A0 0
>>>>
>>>>
>>>> Probably the most relevant dmesg lines:
>>> [...]
>>>> [10226.535987] BTRFS warning (device sdg): tree block 20647087931392
>>>> mirror 2 has bad csum, has 0x97fa472a want 0xccdf090b
>>>> [10226.615321] BTRFS warning (device sdg): tree block 20647087931392
>>>> mirror 2 has bad csum, has 0x97fa472a want 0xccdf090b
>>>> [10226.615524] BTRFS warning (device sdg): tree block 20647087931392
>>>> mirror 2 has bad csum, has 0x97fa472a want 0xccdf090b
>>>> [10226.615731] BTRFS warning (device sdg): tree block 20647087931392
>>>> mirror 2 has bad csum, has 0x97fa472a want 0xccdf090b
>>>
>>> This is not good, this means both tree block copies are having csum
>>> mismatch.
>>>
>>> Since both metadata copies are corrupted, it's not some on-disk data
>>> corruption, but more likely some runtime corruption leads to bad csum
>>> (like runtime memory corruption).
>>>
>>> Since the unmounted fsck still gave tons of error on fs tree, I'd say
>>> at least some of the corrupted tree blocks are in subvolume trees.
>>> (aka, affecting data salvage)
>>>
>>> The first thing I'd recommend is to do a full memory tests (if it's
>>> not ECC memory), to make sure the hardware is not the cause. Or it
>>> would just show up again no matter whatever filesystem you're using
>>> in the next try.
>>>
>>> Anyway, since the fs is really corrupted, data salvage is recommended
>>> before doing any writes into the fs.
>>> You can salvage the data by "-o ro,rescue=3Dall" mount option.
>>>
>>> I won't recommend any further rescue/writes until you have verified
>>> the hardware memory and rescued whatever you need.
>>>
>>> Thanks,
>>> Qu
>>>
>

