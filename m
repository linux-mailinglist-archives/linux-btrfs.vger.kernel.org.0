Return-Path: <linux-btrfs+bounces-5577-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A80929013EA
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Jun 2024 00:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF1F281FF5
	for <lists+linux-btrfs@lfdr.de>; Sat,  8 Jun 2024 22:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4470C38DC3;
	Sat,  8 Jun 2024 22:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="hNzb0j8s"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBC7D520
	for <linux-btrfs@vger.kernel.org>; Sat,  8 Jun 2024 22:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717886920; cv=none; b=Nyr97kh+vUlWWSKlj74x2VX7m9CcONGziR/n7OThY7H4lhZ3Q3XglsxwMYb9iu2Kd4C+5ZL9J6wsYbh/3UeAr70a3mlp72VQn+esFm0nNnS4MsoVwfzGe86pNjUZbMm/JW0acR87G0FOa0XHcz8L8A6Tn/BYF2jdib7SlNNxe0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717886920; c=relaxed/simple;
	bh=6nqN5+E9ov3Yunb2n0YU1IraHTptTiGAfe8vxoW3pQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uVCOokR0WzZUfZolUAxg51Q2Jja4cHvl0Kus0G+yEbeZkjYluYe85MWtciBKsXxub2FxocVil6G9bEW47nEgIsEcnqobUw3UKoHjIYOvUxY3KJ4nsmSdECzvexSCUrWpMtXlbS5lJd/CzA+PZylx7BVtdt0jRlvLN0rAgLyMgm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=hNzb0j8s; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1717886915; x=1718491715; i=quwenruo.btrfs@gmx.com;
	bh=6jirEihU1HRuaqYV84Ol5AXr18ibC9Uo3SaRK2mldho=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hNzb0j8s8+wQysvrvmMcp0wWLbW1qQEYk007HfGXravnVXAAUmYoHITngtQzJ78D
	 lq8K+Pwki/GW4OuwqqyBF/JigF/PnhgiLMeYmfTvjCz+7HFjrNgPvNn7flGpPE6lU
	 nhnYXFS3WMIPDRJF4dgYqjwJR57ZuTN4xlAOA8Hj+Nkk9h5ioRQG4vUFOxjIYNIOF
	 B10PWHNtojtaZf5VcBao+WKT3dvyGmzU4jNJm98yBsYN/w1oSMoFBEBF/QdHKycXU
	 lRYNJ2bFTgJz/T3QtnkAyS4VvKE8gcjFYu9C+58DX+UNWHA3QVCkLQuPr/QsbxwpI
	 8zD1PcZAxaf7uWtlIQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MF3DM-1sDt181CfY-00EIK4; Sun, 09
 Jun 2024 00:48:35 +0200
Message-ID: <41a2a18f-6937-400a-b34b-c89b946535e1@gmx.com>
Date: Sun, 9 Jun 2024 08:18:30 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: scrub reports uncorrectable csum errors linked to readable
 file (data: single)
To: Lionel Bouton <lionel-subscription@bouton.name>,
 linux-btrfs@vger.kernel.org
References: <c2fa6c37-d2a8-4d77-b095-e04e3db35ef0@bouton.name>
 <4525e502-c209-4672-ae32-68296436d204@gmx.com>
 <1df4ce53-8cf9-40b1-aa43-bf443947c833@bouton.name>
 <80456d11-9859-402c-a77c-5c3b98b755a5@gmx.com>
 <abe791bd-0e3e-4a07-a1ff-923231e145ad@bouton.name>
 <a75a1a98-b150-470d-acf5-6e504a2202fc@bouton.name>
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
In-Reply-To: <a75a1a98-b150-470d-acf5-6e504a2202fc@bouton.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aYAGOYPkncKJiNbgFoEx97nYhp8mtygvKgw2pehaEgdEjTTobO1
 g1OkocwgEsj+bdas5R0GVy+WHB7ujQ4nMpY0vBlc5lx3NQuKFOesD8ascAJBtxEmTFHITZ2
 aB2ApBgwcE5hqDRPupvZvo1GKiDzAa85ZILplSJlUe8UhKQoILfDpJtpRLiyP6YvyP7qE+c
 NYFmm4NUOsjuKv/+HdoQw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:lg2UDaptcGU=;TMcT0hgYUqwST2MrXIbX8rUCRPW
 RHi+pVDaPBzIS/nDPuAZKL2NDBxAG4vx3igsyhTItg6epBv4kFGRU9nLkJBkdROhXmXKRpW+E
 56N2AjaHeJrawteURt1/pdTv16R7e3LNKCT5CDLBQJJVntXGkxijaUv0FTzhZHTks3W0vS9Hi
 rM25m9JzTevYKow/EQWz8PVBZIF/LUsffbBn4i0OLAAueXRR8XjqJMZnj8QFwWcFKSZOVBi6E
 YVigdpF37EqPdgKlfKKImk7PsIeq4hu6REjWMN+NJcdRSfjp78NGlwj3IHKO5k1e2pmppBzz6
 tXHfZY277FQuS6/AKtN9OTmTIIZiwgQ9N6wigQz+5kC4Tv+NfAGZPDaSaVx1dmDWdbphqsiD8
 aZN5WUQ2+2gQr6phFq9m89tQ6PeCZLeDdAvkUivAmVYtmbL2xU44lnabsF3NgtdtIE2TCSMmh
 mGCsaR7XlPQkKzpqd8h07dYDX5slxH+OpI5DSLrMraRbam5KaYIGR4y4KD/eCNJ71wlKoLUwG
 wUwF1cFwc2eqaWeYvmYYMLuYZj6IwFwDEPgFMG7Z6oNyjDbaKQ2Zl0otVDMTM+Ie5+HSRhaB0
 bo1CpZjN4gxbhrRVRRWXV8ej3+A7EIu95rVYHOl69xa+YsRbyU9ma6GxH3Si1IG7VTKB6jjeO
 2vHGT1sn7g0A3K5lnBItwudGOKw90DIG4+8UrPm+oz6aSJLikXg1AF0pDA/xE8+ya5/dwvrwy
 Czvqfss92a7jpzA4h08+btpyDAAR40lJRL63B3p+9zarO/X0Jj1C+RgoYydaLbPCmFM94pn51
 YrdMCr0CqKfe21WHEBPriK66AP+EtYxEvv1hi6uMhJCHQ=



=E5=9C=A8 2024/6/9 01:45, Lionel Bouton =E5=86=99=E9=81=93:
> Hi,
>
> To keep this short I've removed most of past exchanges as this is just
> to keep people following this thread informed on my progress.
>
> Le 07/06/2024 =C3=A0 01:46, Lionel Bouton a =C3=A9crit=C2=A0:
>>
>> [...]
>>>> I briefly considered doing just that... but then I found out that the
>>>> scrub errors were themselves in error and the on disk data was matchi=
ng
>>>> the checksums. When I tried to read the file not only didn't the
>>>> filesystem report an IO error (if I'm not mistaken it should if the
>>>> csum
>>>> doesn't match) but the file content matched the original file fetched
>>>> from its source.
>>>
>>> Got it, this is really weird now.
>>>
>>> What scrub doing is read the data from disk (without bothering page
>>> cache), and verify against checksums.
>>>
>>> Would it be possible to run "btrfs check --check-data-csum" on the
>>> unmounted/RO mounted fs?
>>
>> Yes with some caveats as the scrub takes approximately a week to
>> complete and I can't easily stop the services on this system for a week=
.
>> The block device is RBD on Ceph, so what I can do is take a block
>> level snapshot, map this snapshot to another system and run btrfs
>> check --check-data-csum there. If the IO is the same than btrfs scrub
>> this will probably take between 3 to 5 days to complete. I'll have to
>> run this on another VM with the same kernel and btrfs-progs versions,
>> BTRFS doesn't like having 2 devices showing up with the same internal
>> identifiers...
>>
>>>
>>> That would output the error for each corrupted sector (without
>>> ratelimit), so that you can record them all.
>>> And try to do logical-resolve to find each corrupted location?
>>>
>>> If btrfs check reports no error, it's 100% sure scrub is to blamce.
>>>
>>> If btrfs check reports error, and logical-resolve failed to locate the
>>> file and its position, it means the corruption is in bookend exntets.
>>>
>>> If btrfs check reports error and logical-resolve can locate the file a=
nd
>>> position, it's a different problem then.
>>
>> OK. I understand. This is time for me to go to sleep, but I'll work on
>> this tomorrow. I'll report as soon as check-data-sum finds something
>> or at the end in several days if it didn't.
>
> There is a bit of a slowdown. btrfs check was killed a couple hours ago
> (after running more than a day) by the OOM killer. I anticipated that it
> would need large amounts of memory (see below for the number of
> files/dirs/subvolumes) and started it on a VM with 32GB but it wasn't
> enough. It stopped after printing: "[4/7] checking fs roots".
>
> I restarted btrfs check --check-data-csum after giving 64GB of RAM to
> the VM hoping this will be enough.
> If it doesn't work and the oom-killer still is triggered I'll have to
> move other VMs around and the realistic maximum I can give the VM used
> for runing the btrfs check is ~200GB.

That's why we have --mode=3Dlowmem exactly for that reason.

But please be aware that, the low memory usage is traded off by doing a
lot of more IO.

Thanks,
Qu
>
> If someone familiar with btrfs check can estimate how much RAM is
> needed, here is some information that might be relevant:
> - according to the latest estimations there should be a total of around
> 50M files and 2.5M directories in the 3 main subvolumes on this filesyst=
em.
> - for each of these 3 subvolumes there should be approximately 30
> snapshots.
>
> Here is the filesystem usage output:
> Overall:
>  =C2=A0=C2=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 40.00TiB
>  =C2=A0=C2=A0=C2=A0 Device allocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 31.62TiB
>  =C2=A0=C2=A0=C2=A0 Device unallocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.38TiB
>  =C2=A0=C2=A0=C2=A0 Device missing:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B
>  =C2=A0=C2=A0=C2=A0 Device slack:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 12.00TiB
>  =C2=A0=C2=A0=C2=A0 Used:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 18.72TiB
>  =C2=A0=C2=A0=C2=A0 Free (estimated):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20.32TiB=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 (min: 16.13TiB)
>  =C2=A0=C2=A0=C2=A0 Free (statfs, df):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 20.32TiB
>  =C2=A0=C2=A0=C2=A0 Data ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 1.00
>  =C2=A0=C2=A0=C2=A0 Metadata ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2=
.00
>  =C2=A0=C2=A0=C2=A0 Global reserve:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 512.00MiB=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 (used: 0.00B)
>  =C2=A0=C2=A0=C2=A0 Multiple profiles:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
>
> Data,single: Size:30.51TiB, Used:18.57TiB (60.87%)
>  =C2=A0=C2=A0 /dev/sdb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 30.51TiB
>
> Metadata,DUP: Size:565.50GiB, Used:75.40GiB (13.33%)
>  =C2=A0=C2=A0 /dev/sdb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.10TiB
>
> System,DUP: Size:8.00MiB, Used:3.53MiB (44.14%)
>  =C2=A0=C2=A0 /dev/sdb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16.00MiB
>
> Unallocated:
>  =C2=A0=C2=A0 /dev/sdb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.38TiB
>
>
> Best regards,
> Lionel

