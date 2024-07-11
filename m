Return-Path: <linux-btrfs+bounces-6354-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 862A292DEFF
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 05:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2AC7B219DB
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Jul 2024 03:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8155C249FF;
	Thu, 11 Jul 2024 03:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="RX9Pv7jB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744681A28B
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Jul 2024 03:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720670325; cv=none; b=f8G9uJS7s7eb6U9XYE92FokKtybrz3LVYBhZASzeF8UAf5dUkGIYVMapOZaw30+A26+DueakiOpK1XvxutOrwoPivCK9t9lDOdSAJ1ZGPfoV+itGmfqxPbXruGb4f/fIrSKh+Zcr9HKbweySnZB/+JzAUCdSWBGj6ccM1wLpgEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720670325; c=relaxed/simple;
	bh=2ERdBVXkkD6G3JDTlCG1yCzBr6v/aykaIfyUWIrDZXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hxmHeLyKzqkm3QHJgiS3HHYKCATh0glbnbl23qSAh8i8TlJ/mm+xhGE25VIWpMJMU/Ik2vkiCqYWNeuvavp6p1ThMm2YdFELNlJZHPZGMa3wUj1MUQLpQPaydtWMLW1ZfFckYfCzF4hGQcE6PdtyJ3R+FeS6GnxlWf+yzqunt0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=RX9Pv7jB; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1720670320; x=1721275120; i=quwenruo.btrfs@gmx.com;
	bh=B5k7JSN43nV7GnINSOLw7a4yvLzfRkANYRhGB++Is5E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RX9Pv7jBzG8NQGNF0Zu/dSZ6sV7Cf1xC4wQx/J8F8R7NVayHvF/MHweP+fEgSo9v
	 vrwqCIRDJV8K9U4/ZVWy5a6Itsrz7PBUjwW+xNPKISngnGt+HTcyXO1s7p71rCidj
	 QB6jYLktas1Go/ElVNX5W2y/anVWg3Y2Kjfj6GOZOWHMaAH20LM60VTX0DeTRPpxH
	 2mdvBXKZQANhGIi+5QhVKbmlvrtrSMfg6dIcY6188ocwAvJsd0cXjpslwSUpFn1EJ
	 RwiZg3+byc9QG6pkQivtjTWAAqierCVBJPD6q4ALWlDvphPukn8/3KYjCPoFXI5Vs
	 5KBK1JPPILKr8KS+cw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1McH9i-1rpOOq1Qg0-00eeKV; Thu, 11
 Jul 2024 05:58:40 +0200
Message-ID: <f4cc6206-a7b8-4986-9177-b813f8b616c8@gmx.com>
Date: Thu, 11 Jul 2024 13:28:38 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: btrfs-progs: btrfs dev usa as non-root is wrong and should just
 abort
To: Russell Coker <russell@coker.com.au>, linux-btrfs@vger.kernel.org
References: <2159193.PIDvDuAF1L@cupcakke> <4914581.rnE6jSC6OK@cupcakke>
 <ad3498e5-d41a-40ce-be73-c5d9de4f85a1@gmx.com> <7956171.lvqk35OSZv@cupcakke>
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
In-Reply-To: <7956171.lvqk35OSZv@cupcakke>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qG6LoRlvyTFOZvRYiwG62I9Df2K4lfdSoZ9kYLg3PcLf0tG3k9+
 HclCah4syOaGiSuMR8eDOUpWyvgB8RUsjC3s4rkEG2Z75cic16XugZQTtg+4racXpbF2rKB
 QhQJnQv9zSfJF/rLpSySTqWpAx4EaiN/Y32Aj/dxKTOSuy90kQMqG+N008OqtW4687pxKvE
 YCp3RbXGYUis7HLfDL2ow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pnjiXzuv5dM=;uw3IGw2LWPZkUGcNReSYVURD7NB
 7OFcF7MxG11UGzeP9Ed1xYwA1wL5Av5fGWUMaUg2JeGYaQ49pzK1oIIe6Pqo0q5Yodp6jcExz
 XkUHC2XolldYyoy3h9+JxASYT8vGZ/flcD6txxZ7GfmXoBIZVFfe6xlKBXMRIoiMmnzBK/EHa
 jPXuUQQbCjaFv6y+g3agsKdiLnB34CN4V8vFYil0vB17saSqmncwghu0j0//UKConjf6eipi5
 CapHEP+hysg64h/Vie4YIMHMGCbS/TiMzaErQ+ZEIY6jLtFAntf0tHgyN3L2XvZEc7HXQIsa6
 X2rzffnAnYV7oi4iwFD4KHRbbFMW/3F3ik/O5DG6RTovBzZ3hhIGDIpMVlqoWBD3ejYZtreC7
 4x26OGQqawki1EuMG5DPSreBDpFBLQaPnjTDtv70E1PGhh4PviYU+/Qounprp0fGmj94JWffb
 jeKIfM1Mbz8YjohfooupUIK/mzfPoxXgDWW9aBue+XFGGQnQyi7SrXrph9oxbFaHjNL2BkqCJ
 LRHP6+Y8Z+xGr3bcHb+2niYRYYzXFVk5w40XYmCuW2S/FdRC4U5h1ztKyIF32O/+GK8WCera7
 WM0VPv5n3X4vBRyc5zYVYh916G4eIOPg5Gkt77gsKXywaFbvUC+LDELb/01YnAaHg4f939FvD
 /N/bSgLJKeNbJhCcx4lK4TRsIvFUHqLec918ihVPj9upQwexBC8YDofT0D6NUxFDXIcojhNC+
 NSQlWiG8OA8yyFZrC/efxpRgbPn/thDoDAQeosgqlNBVm9U7G09BHFiI321/AAMeeiSuRImsn
 OV1jA336fdorqo1/uBOg0emw==



=E5=9C=A8 2024/7/11 13:25, Russell Coker =E5=86=99=E9=81=93:
> On Thursday, 11 July 2024 13:47:59 AEST Qu Wenruo wrote:
>>> # btrfs dev usa -b /
>>> /dev/mapper/root, ID: 1
>>>
>>>      Device size:          511493395968
>>
>> The device size is 4K aligned.
>>
>> I guess it's some older fs? As newer mkfs would always round down to th=
e
>> sector size.
>
> My recollection is that I had run mkfs on a system running Debian/Bookwo=
rm
> which had different hardware and then used dd to copy it to this one.
>
>>>      Device slack:               1536
>>>      Data,single:          231936622592
>>>      Metadata,DUP:         6442450944
>>>      System,DUP:             67108864
>>>      Unallocated:          273047212032
>>>
>>> $ btrfs dev usa -b /
>>> WARNING: cannot read detailed chunk info, per-device usage will not be
>>> shown, run as root
>>> /dev/mapper/root, ID: 1
>>>
>>>      Device size:           999010539
>>>      Device slack:         18446743563215167723
>>>      Unallocated:          511493394432
>>>>
>>>> And what's the version of the btrfs-progs?
>>>
>>> The Debian package version is 6.6.3-1.2+b1.
>>
>> It may be easier to debug by trying a newer version of btrfs-progs.
>>
>> And since I'm not sure if it's the unalignment causing problems, you ma=
y
>> want to resize the fs by:
>>
>> # btrfs device resize -1M <mnt>
>>
>> Then resize to max (which should always align the fs correctly):
>>
>> # btrfs device resize max <mnt>
>
> root@cupcakke:/tmp# btrfs fi resize 1:-1M  /
> Resize device id 1 (/dev/mapper/root) from 476.37GiB to 476.36GiB
> root@cupcakke:/tmp# btrfs fi resize 1:max  /
> Resize device id 1 (/dev/mapper/root) from 476.36GiB to max
>
> etbe@cupcakke:/tmp$ btrfs dev usa -b /
> WARNING: cannot read detailed chunk info, per-device usage will not be s=
hown,
> run as root
> /dev/mapper/root, ID: 1
>     Device size:           999010539
>     Device slack:         18446743563215167723
>     Unallocated:          511493394432

What about the usage output using root privilege?

Just want to be sure that the fs is properly resized to be 4K aligned.

>
> etbe@cupcakke:/tmp$ btrfs dev usa /
> WARNING: cannot read detailed chunk info, per-device usage will not be s=
hown,
> run as root
> /dev/mapper/root, ID: 1
>     Device size:           952.73MiB
>     Device slack:           16.00EiB
>     Unallocated:           476.37GiB
>
> That doesn't seem to have changed anything.
>
And what about newer progs?

Thanks,
Qu

