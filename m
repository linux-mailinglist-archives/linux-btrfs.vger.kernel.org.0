Return-Path: <linux-btrfs+bounces-10111-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2639E8203
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2024 21:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58AEB281E42
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Dec 2024 20:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475DC155A21;
	Sat,  7 Dec 2024 20:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="YhfVVYBW"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD6014A0B9
	for <linux-btrfs@vger.kernel.org>; Sat,  7 Dec 2024 20:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733604504; cv=none; b=WRRREwQuvbplgRtHzJfDFXN87sKYRSUcNEs0HRW7xIoNuQ/sOfUv5Jbs3iPKyAUGgPg5RbiuWOW2Gk222oJoveCQ6hGEll3wPiR9xfLa/ER19e0Hdt/4gRMAdwLdgWx5mQ3AYOnJyAtbE2HaV19J0G50xN3ADIH5LrOYstLmuys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733604504; c=relaxed/simple;
	bh=xvv/mDbDOpYmcdBLIskdaUE+LmesYMYIpAC/kcRxU4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ONQclM+Z3Ay2jhGP4eNLKPxvjbkF244rnO/o5PbCkr8bwm5mmJ/jIJpuT+MRo6GlmnSDd88J0g9/jOWWVQygRUj/HC4rD7D5CILqzbBL/hQ/NcD7/8QncVKCYeJkL1ZY0etXH9fuQr0cIpj+y+vWw8xeRFVfCID+3Zlm1fcwE30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=YhfVVYBW; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1733604495; x=1734209295; i=quwenruo.btrfs@gmx.com;
	bh=xvv/mDbDOpYmcdBLIskdaUE+LmesYMYIpAC/kcRxU4Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=YhfVVYBWn7V2SjMIAnzCBUj3KcF2SijKtIp3aK17Z+XERAt122D8QGO1CZoce8t/
	 o0xE023BdlRXeuFQD/kNNU8fNXFxBSgcqDXCH7ycXnS+ilpU1A7u4DtoZjQpRgzAy
	 OojASYs8ZCuZ7ImTCjE3FsHutFu8AaKggsLoggTXqcKaI4DuU4pcXoHH3JUpW+QHI
	 KA5DjdIgJ2752XNieDk7NlrdnO8BXgjopTB/ImQbbPMhj62QVCbQrsj4GWHIYt1qo
	 D56FneFasWBKVn8h6WLbWzxv1s4kfEHAQn7uXPmGmqkh3usnnZc7KOVQNV1gJD2s/
	 89H7u3Wune+deIqqJQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJE6F-1t5X8e1KKh-00Rgpq; Sat, 07
 Dec 2024 21:48:15 +0100
Message-ID: <d6907ccb-70cd-4066-9bf7-2ead902f0974@gmx.com>
Date: Sun, 8 Dec 2024 07:18:12 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Using btrfs raid5/6
To: Jonah Sabean <jonah@jse.io>, Qu Wenruo <wqu@suse.com>
Cc: Scoopta <mlist@scoopta.email>, linux-btrfs@vger.kernel.org
References: <97b4f930-e1bd-43d0-ad00-d201119df33c@scoopta.email>
 <45adaefb-b0fe-4925-bc83-6d1f5f65a6dc@suse.com>
 <CAFMvigdQPC_cV5td1j0e2CR=qPT=W0Lp=+n74_UrSzahayMJWA@mail.gmail.com>
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
In-Reply-To: <CAFMvigdQPC_cV5td1j0e2CR=qPT=W0Lp=+n74_UrSzahayMJWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/Qf+ShplaFsdlqLwofjjsvQ/N33+R9nvx9tzL/iDCizOoH4ZWuN
 6dTlxlamqL2uU+Bbfs/3dnMGWQIQt0A7QmctFO4q9u5ZpBiI2jJrE384Co9gri5Py1grmaN
 nr+P1SUiKwujnUzPho2JKetIrTS3MwMKTo/i5pt1wofsEkUSWIFbXVQlS4mGWXpEDLD7gxs
 zugPG3x6zi8+lYI4EGZug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SFU2/vrJN6M=;O9Bqbm8gg+eOO6yNRMHON6xVwWg
 wzk7pK4SA1ACcUngQPdWLbVj/YkXJq41A3S4UmuN6vFrsjNUu0b6R8R/QCdfEiJpTrHyBa04u
 G3x0aK0yYQtLyep1AgWQO7s/9FFaOwdiTB1bf/N//OYi6tfH8hsjrTpEZ9q4W+OgpARtVDuY3
 dSuHcEXyL5t3XOZMY6iextrQKgvNDj2FVwBL+9D0H+6tIgOI0qWPuOCX7M+sksaAoe182UzLd
 xDHVq3DyIyASAD4eFEofpBjuwPYlc6SpSy5aYytifTcaqSosxznsyNvh+OT5RDPia4/Y0Ygki
 JXrr/ouEsLzux4REMJl+ccWFt5YYjHlRJsQ/JbMJaxlrd9WTfMmFglvLdSPmqlb/NWsOswl8e
 R5yiI6KdEgN9gBv1A/sYsjAJNkvXfA8VWvg7jO+8FDxg/9jvW+q4fsI0GcvO0xttGjmwL3cM0
 31vtULS7vmV7WJcLJ/y3oVTUNeTt5tuuBqPs2Bi7zwEUWgGKGv+r+GwFNJHai6MgvUmhjtekw
 bmHm1LtaxZ/zBVTVSrJBhFaG/T296feb2bb01zQgMGOSJhxlitoRsUyfelBHkEWULo+b+Mi2O
 Gfb83c8wQnaORuoH8FkQ6yzHgP5GDgcI+vkoi9Ls2tYczWJ26cMAHjijFzr6Z/Ee2UyOOOVgV
 9tIkli7yz0olLXif8EkqHHpt+R2bvlRJNR7HdzrxDycfmwUzD1cwYmk+ywtHtQzOuF/m8sME1
 R/rWTYd65+l3/50H+LukPykWcpdw8UG9+yBgRiDM3Yr0AjFX6jc7MsfYmaOHBKOIl8Lch0k6B
 WvUMMyvqQR0B0RGNkZ+045vpvoxLKND+rKp4Pj+vOyWSU5eO06TYfeK54h9irhSuheWRg36s5
 RMTgFohBSZzk6OhDI75+sOCYMx98s3c8Itxd4hYeujeENcEAUVWxMesfRxITrrH3EEjcqPMOM
 bCOkL6HAnuk4CRlSoFT3w/K2ZEBLdxgvLYzjsDEuv2y5x2QNVTwblLUGxF/N1Q5MGUWT7S5Ds
 T8WwgzSgj9Y0RxIyEMM6XwoPametZJ4DKHqzPGH5YQz2Jggv0h/kdJ8DGj0smsfitgNoKnbGx
 NdY9sojm+fBt9P/+JlT3o+baqQesbw



=E5=9C=A8 2024/12/6 12:33, Jonah Sabean =E5=86=99=E9=81=93:
> On Wed, Dec 4, 2024 at 12:40=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>
>>
>>
>> =E5=9C=A8 2024/12/4 14:04, Scoopta =E5=86=99=E9=81=93:
>>> I'm looking to deploy btfs raid5/6 and have read some of the previous
>>> posts here about doing so "successfully." I want to make sure I
>>> understand the limitations correctly. I'm looking to replace an md+ext=
4
>>> setup. The data on these drives is replaceable but obviously ideally I
>>> don't want to have to replace it.
>>
>> 0) Use kernel newer than 6.5 at least.
>>
>> That version introduced a more comprehensive check for any RAID56 RMW,
>> so that it will always verify the checksum and rebuild when necessary.
>>
>> This should mostly solve the write hole problem, and we even have some
>> test cases in the fstests already verifying the behavior.
>>
>>>
>>> 1) use space_cache=3Dv2
>>>
>>> 2) don't use raid5/6 for metadata
>>>
>>> 3) run scrubs 1 drive at a time
>>
>> That's should also no longer be the case.
>>
>> Although it will waste some IO, but should not be that bad.
>
> When was this fixed? Last I tested it took a month or more to complete
> a scrub on an 8 disk raid5 system with 8tb disks mostly full at the
> rate it was going. It was the only thing that kept me from using it.

IIRC it's 6.6 for the scrub speed fix.

Although it still doesn't fully address the extra read (twice of the
data) nor the random read triggered by parity scrub from other devices.

A root fix will need a completely new way to do the scrub (my previous
scrub_fs attempt), but that interface will not handle other profiles
well (can not skip large amount of unused space).

So if your last attempt is using some recent kernel version or the
latest LTS, then I guess the random read is still breaking the performance=
.

Thanks,
Qu

>
>>
>>>
>>> 4) don't expect to use the system in degraded mode
>>
>> You can still, thanks to the extra verification in 0).
>>
>> But after the missing device come back, always do a scrub on that
>> device, to be extra safe.
>>
>>>
>>> 5) there are times where raid5 will make corruption permanent instead =
of
>>> fixing it - does this matter? As I understand it md+ext4 can't detect =
or
>>> fix corruption either so it's not a loss
>>
>> With non-RAID56 metadata, and data checksum, it should not cause proble=
m.
>>
>> But for no-data checksum/ no COW cases, it will cause permanent corrupt=
ion.
>>
>>>
>>> 6) the write hole exists - As I understand it md has that same problem
>>> anyway
>>
>> The same as 5).
>>
>> Thanks,
>> Qu
>>
>>>
>>> Are there any other ways I could lose my data? Again the data IS
>>> replaceable, I'm just trying to understand if there are any major
>>> advantages to using md+btrfs or md+ext4 over btrfs raid5 if I don't ca=
re
>>> about downtime during degraded mode. Additionally the posts I'm lookin=
g
>>> at are from 2020, has any of the above changed since then?
>>>
>>> Thanks!
>>>
>>>
>>
>>
>


