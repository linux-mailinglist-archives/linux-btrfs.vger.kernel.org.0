Return-Path: <linux-btrfs+bounces-10129-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E4F9E879E
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 21:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730271885815
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Dec 2024 20:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F3D8615A;
	Sun,  8 Dec 2024 20:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="RNRnhEV7"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414E6381AF
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Dec 2024 20:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733688438; cv=none; b=LcNVf1u7cQ8Oqo/KUP1AeSVwy6Cc0ZGSZvy+X0yJ6ddeTU0nvYgsfv/ibzp6baCh9PI+40xqQTjQ9QWypsKLkbJEliyewdlTz6oksLoDHgpobljIi5dwt1mCyrTwcxojVPPLigkU4pwJRvPh02jZdS0wYhKUgt1XI9G40BGUVZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733688438; c=relaxed/simple;
	bh=nfkH/zTsAdy8Hi+j4MrZ7EeACej3flGn+AO4mwzA/EE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ViY7TTUNJNVL33Msj+NQAqxjqA0ZMXNwlU3E/x0Hm5JTN7cJyyPwpY015ID+XgXhuAcNKLKrEJSnyRN0IphamY+o/rLa2bKUZOTwS1V4zckUwqlRDHIamv/tJEhDMcAtSiuHeyKdvLpO7GXTzmPxX6+Cmyggd4A05eHKLF2zB0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=RNRnhEV7; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1733688430; x=1734293230; i=quwenruo.btrfs@gmx.com;
	bh=nfkH/zTsAdy8Hi+j4MrZ7EeACej3flGn+AO4mwzA/EE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RNRnhEV7fE5qe7LOwROJE3py8RTplpYARd0mjP0r2/1uyUjm4Aa1fyB18Q3lCJT2
	 bo/PplkzYA152ntbiSnXtU6StSwVMOYsmfszg0/OI4goHjvNuZqVKiq5yX5eZ9Fv6
	 XgIohnmVS6HhHOsp11gTmKdsbJY5abejBQhq9jUs/znZCuEz9gZDznLtvSu9Bf1iI
	 Q9PC/ii24fwWUmrbH2L2stPYdObYmizULCJ1wjaM9dRnYHRJhQZcyTgvD9ZnhW29d
	 ipHaBKPBsCouyE70cu+y1FB0MDqlcEHB/wodeNLHqMjNyZ2lGHRNQ7QL+mYnOr5DO
	 ByCowEVkxdIC+IORMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTiTt-1tCHz63Bkr-00IJbK; Sun, 08
 Dec 2024 21:07:10 +0100
Message-ID: <0b9036d3-df7f-42d4-beb9-cdcf903e9f1b@gmx.com>
Date: Mon, 9 Dec 2024 06:37:06 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Using btrfs raid5/6
To: Jonah Sabean <jonah@jse.io>
Cc: Qu Wenruo <wqu@suse.com>, Scoopta <mlist@scoopta.email>,
 linux-btrfs@vger.kernel.org
References: <97b4f930-e1bd-43d0-ad00-d201119df33c@scoopta.email>
 <45adaefb-b0fe-4925-bc83-6d1f5f65a6dc@suse.com>
 <CAFMvigdQPC_cV5td1j0e2CR=qPT=W0Lp=+n74_UrSzahayMJWA@mail.gmail.com>
 <d6907ccb-70cd-4066-9bf7-2ead902f0974@gmx.com>
 <CAFMvigdfVLrPJsYq0xyuye5-_pAL5ByHQDS-RZ5T6de8EZWspQ@mail.gmail.com>
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
In-Reply-To: <CAFMvigdfVLrPJsYq0xyuye5-_pAL5ByHQDS-RZ5T6de8EZWspQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0Ysq+jYzjpaghgaKm02x3rywf9eleWa29EyWM37/lbA36QTGXF+
 glVeq8NbiBBoJbxrOPl7lfrqhnFuzNTGDuHtgNAg1uFu0tmkw8TAOvJwN1eh1EBdL07OmxN
 mdSF5FjAPt+PyHWsAjdYOnb5Gw17N/8fczkHuX+3NdiEYLl6XqSbeXrXKtAZM9Sv7wDtdDR
 satK7aZcb/SizH6zx1L6w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eQRLOfNFHfo=;sgbhMQ4sWZLQs+AeUffmkP03GcJ
 pP/uzuxo5DzVTebmXQzK5CmLgz/aBzg+00TbHNaXpk/SZg4duo2NvmclDuRggcLesoV+VwoJi
 WdnARBdn5GKTaYEm2kOyCHRYrK2XnimaJNeUAWVkmBTPZOYaPDi8S57Di8RXUmnZa+G4f1Eec
 6H630o137+Ya0naTScDsuMYdCAwtMjQ9WyXqjJ9bgDXLcfSTzsALIKMcAfbqYyeca+dQjpR+x
 vEP0gZ1bFqj6tld1uITEu8jEGDkKDvZojWhOop1rS1Z4EG19tSAe9TeVweuo/R7c8ODcRnz9g
 vMLenNgkVzobuSEqlI9Z/y8Gab2IqVcNF5AvWMVy/zgOnZaufmouO7remdKaCiMV/RtPpYD1x
 aOf2IuHGg0225jAvx0hZcEtxqON4roTziGodzqLigdrb0W8eDp1ETzfiWuCYT0sG51RzUinAw
 ezwZDKfLptyCwxS/AiKztp63riRjpROPgSkjcgzus5PDWkjvJpzwsKZob76eNqU+Hm7HbhpdE
 337cY10bWQxC9en1IHkw7uuVfLjRLGwIr+fichpRwenCZAgpHEvQYJOyfrpzaqkFV0xCbmYr/
 ksgxGhCwBKZ8w+h64oXoJiXHFPt9fCM4nw2L3/tzKwbn3BgqaFUBUcFrfU66Oi5CL+845ijmH
 ITKKQuKFJUhIowWWODNsQ//rjin/tE83nu+/ynkVYZKe5DeyhHb4aEwMOZOOJqe4fuzRYF2dy
 eT2sYyzR+jKH5mDyW80iafJibVHX2lmulk/LIpYjTqZj4JrXxy0LG4DObxSSIovhtEuhpwyrf
 PviFNTUDl33MGGteUknKDph/E6DuzJwy9sCK6kA4ahSSKhBGMwQGDA9f6IayoV/UW634jUbZN
 okjaVeVVpjnmpNEblXapf5SQcVTqU0SSmF/NeU8DPsAw28nEadPW5pdTOI+UwwNUG1Bn2d42q
 6VGiPT4UwL6AbpEtqAhGeOjl4f7UA8TwLheayBC8pkvNe9l08Vu/Q0o9fmSpzxQKu+VSnCHGT
 ZmEF9fXna8TBeSxFvmyNUN1GSpaNDPrN/XBraAcyvtKQuw10VzZGCvjvpLqYhUqURFunBjOoT
 64oU2ogfzMLZv0/kuEK1VULRdPpUXG



=E5=9C=A8 2024/12/9 03:01, Jonah Sabean =E5=86=99=E9=81=93:
> On Sat, Dec 7, 2024 at 4:48=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.com=
> wrote:
>>
>>
>>
>> =E5=9C=A8 2024/12/6 12:33, Jonah Sabean =E5=86=99=E9=81=93:
>>> On Wed, Dec 4, 2024 at 12:40=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote=
:
>>>>
>>>>
>>>>
>>>> =E5=9C=A8 2024/12/4 14:04, Scoopta =E5=86=99=E9=81=93:
>>>>> I'm looking to deploy btfs raid5/6 and have read some of the previou=
s
>>>>> posts here about doing so "successfully." I want to make sure I
>>>>> understand the limitations correctly. I'm looking to replace an md+e=
xt4
>>>>> setup. The data on these drives is replaceable but obviously ideally=
 I
>>>>> don't want to have to replace it.
>>>>
>>>> 0) Use kernel newer than 6.5 at least.
>>>>
>>>> That version introduced a more comprehensive check for any RAID56 RMW=
,
>>>> so that it will always verify the checksum and rebuild when necessary=
.
>>>>
>>>> This should mostly solve the write hole problem, and we even have som=
e
>>>> test cases in the fstests already verifying the behavior.
>>>>
>>>>>
>>>>> 1) use space_cache=3Dv2
>>>>>
>>>>> 2) don't use raid5/6 for metadata
>>>>>
>>>>> 3) run scrubs 1 drive at a time
>>>>
>>>> That's should also no longer be the case.
>>>>
>>>> Although it will waste some IO, but should not be that bad.
>>>
>>> When was this fixed? Last I tested it took a month or more to complete
>>> a scrub on an 8 disk raid5 system with 8tb disks mostly full at the
>>> rate it was going. It was the only thing that kept me from using it.
>>
>> IIRC it's 6.6 for the scrub speed fix.
>>
>> Although it still doesn't fully address the extra read (twice of the
>> data) nor the random read triggered by parity scrub from other devices.
>>
>> A root fix will need a completely new way to do the scrub (my previous
>> scrub_fs attempt), but that interface will not handle other profiles
>> well (can not skip large amount of unused space).
>>
>> So if your last attempt is using some recent kernel version or the
>> latest LTS, then I guess the random read is still breaking the performa=
nce.
>
> Thanks for the update! Will your scrub_fs be rebased for raid5/6 in
> the near future? Would be nice to be rid of the 2x reads. I suspect
> then raid6 results in 3x reads still then?

Yes, RAID6 it's 3x read.

Unfortunately that feature is no longer under active development for a
while.

But I'll take some time to revive it in the near future.

Thanks,
Qu
>
>
>>
>> Thanks,
>> Qu
>>
>>>
>>>>
>>>>>
>>>>> 4) don't expect to use the system in degraded mode
>>>>
>>>> You can still, thanks to the extra verification in 0).
>>>>
>>>> But after the missing device come back, always do a scrub on that
>>>> device, to be extra safe.
>>>>
>>>>>
>>>>> 5) there are times where raid5 will make corruption permanent instea=
d of
>>>>> fixing it - does this matter? As I understand it md+ext4 can't detec=
t or
>>>>> fix corruption either so it's not a loss
>>>>
>>>> With non-RAID56 metadata, and data checksum, it should not cause prob=
lem.
>>>>
>>>> But for no-data checksum/ no COW cases, it will cause permanent corru=
ption.
>>>>
>>>>>
>>>>> 6) the write hole exists - As I understand it md has that same probl=
em
>>>>> anyway
>>>>
>>>> The same as 5).
>>>>
>>>> Thanks,
>>>> Qu
>>>>
>>>>>
>>>>> Are there any other ways I could lose my data? Again the data IS
>>>>> replaceable, I'm just trying to understand if there are any major
>>>>> advantages to using md+btrfs or md+ext4 over btrfs raid5 if I don't =
care
>>>>> about downtime during degraded mode. Additionally the posts I'm look=
ing
>>>>> at are from 2020, has any of the above changed since then?
>>>>>
>>>>> Thanks!
>>>>>
>>>>>
>>>>
>>>>
>>>
>>


