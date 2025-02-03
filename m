Return-Path: <linux-btrfs+bounces-11215-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A245AA2513F
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 03:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 463093A3FB6
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2025 02:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF4A2AD0F;
	Mon,  3 Feb 2025 02:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="sSLlu6oi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B39AAD23
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Feb 2025 02:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738549956; cv=none; b=FGYM6eB0TnzP7dF0JQ78bM5bjn/uEgYnfw7FXTZ8tW4qzJn1pKNsKDGNn0K2P8ZDYS6Q9yL0FCnD18RmMFirzQ7OMQ9TL8IfZvPU8j9KGd1sdJeUFuY4lftaVnqcZmAK/Yzdg1BL/ZGhs9OpUrorGEN3j+WSA7yb1VIUz7KHHhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738549956; c=relaxed/simple;
	bh=o8PG8APlJHhiohRUCygTQZrEG0c2txQ8vnwSPg4U604=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=q93TkxhEenjSOsT5JhMsYFpBu4udf9ST4M2WabQ+U6rSWMsvHmP4Gx88m4Nnexe2vA9BUUHYLOqqGN+oZ7HJ9fDtoJP4X1Ko/mYcFaumPHuvFpeUdE33b/EqOe4seCNXxaeGiUu8act85ur/gLnwUwUCpoaZPETzcvPEPGezJVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=sSLlu6oi; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1738549951; x=1739154751; i=quwenruo.btrfs@gmx.com;
	bh=nSTP5q1cNoHbphBZaalyuOdWZSfqBWLdyv38KD6wufc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sSLlu6oiKRtLTqmUqkQCO1/U5zZMD5GqgvInv4IJunTP8Mjyespo5/p21sBTP4Tq
	 LRPX0VtfSYYLbTDKlomCwLiwfUqTMpyZl5pv6rcyXui2Wqm8B6sG9EeqZeE/iBNtt
	 9SPcozkDYZhmR+xMHFdSYT0U3zQ8oV9OaDIH3fHuphgSiUodphxz8Xb2ugdCB5Rt7
	 pBzrydfImVtKAkE7XajDkonuFsnDa1V3YQIclGlZezb23NxvI0Mxg0Vfy4t9jgsUc
	 xwBRbythZger9DhxRKWPc1Cre8oykSwxAmAOz3ZiwPXx/5eepL38UgMvLXv3sW2Sc
	 Cz8Os9zdYLC4ord/HQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MnJlc-1sxzFS3iKq-00iRFS; Mon, 03
 Feb 2025 03:32:31 +0100
Message-ID: <23f97ef3-5d4e-411e-abb3-9725d7f92238@gmx.com>
Date: Mon, 3 Feb 2025 13:02:27 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Converting RAID1 to single fails if RAID1 is missing device
To: Jussi Kansanen <jussi.kansanen@gmail.com>,
 Jeff Siddall <news@siddall.name>, linux-btrfs@vger.kernel.org
References: <2cb1d81e-12a8-4fb1-b3fc-e7e83d31e059@siddall.name>
 <d300d923-ed8c-4671-9694-6850d8c9b572@gmx.com>
 <92dbe939-46a6-4142-b6be-3ef69fffce1b@gmail.com>
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
In-Reply-To: <92dbe939-46a6-4142-b6be-3ef69fffce1b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u6E1TDeFZAmR1k8TCQFzcuKRlPCIIVxbYUXjEayjeNgATdufYui
 08UlJi1X7xGxzwDuitqnDGoRytMtmSDCRdTBeg1hmbOo7GzIuA3aYL/UosPjWu4az8ddPs4
 ZdPKbLeW0P0sl9WuD1gYeuum4sdMP7dqPC2YMzIZxwjn0iMH/EEdo2QElDTn19GrJVnj21N
 LZZIM509k7G48PsVwQ58A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KzwZAqujgTg=;InCEJt1mbV/fsYccewAkFstxwoO
 CpDanD6bIggz1DjTi74Q8Am7SRmnClqFSUkK2Pf1YcRitL19th0mrAkjV82uhoxo1FK0+pzGg
 uB0Wc1nYJY/0XsBtIHxIXRXuBFSGYC/3g8p5FfyCDGSvR2neqX8P49cWeCbUqV63tlYuqXF5n
 BIS5HCX+8cHtKX+5HjAoNK/UxVE2sE0tfW6wdM5n2S0rTTktY4EzKLMgTDYR49L/JgnxtkSyG
 VTZ8q+Y3oUYpWpVf0L8TmIbVj1Kcl6nrVSUZiz2UpgfGGDpc4Al+Hj0ArKEQZdUR+/SHZEbJD
 X63RyugymT75e4nwCRpgtmBCAVg3Wi7+hfCM2DgBJj0dV/uKjFvwQrQlg2TlO0dQljl4k7g8n
 531+/TXvV1QZBmZv65iXoNQh5ceAcMm++7jCXC48VsMBmjEqluGFAEnV7HZTyH0PkYTHEqNFj
 hKSKpqBZzdX5ZStG9T+rHhrxL6FLsZ6fpas61rmgHiFH7Bakpv5lmWrG2Eodg0FOtvFX/+pgs
 zk2qey7Gaeess5SuoGgzy1klL6yol5u3IzAXgxIEgiusd4AzcMbqDHepflSve3XuxJWDBbDPA
 FUwX2+CEMsOg5EapGavIeRTekyS6hIxdFHm0JYtLa0yK5kCzujmQ1HI3uOhFBb13fpnN8EgM6
 ECedZqe6G1RdoVw7WpZ5iZepvL1wFl+h5Ea/3HTkFZ/e9Wajh3yy73+8ZYEPcrJmA1GY8k5TT
 8mScWraqh6nAxTh6ayRKRpmoiU7sB804CEt/vhnWRq8/qFXuz720kW/bCUGg7gjVbzm4ErRZO
 v/yUropPhTegP0haFLzQCWKz4B+zBppgvmtitQ93sVyvVhX+gY3vwesg1nV0E04fY1MKwdt9f
 bfnUKwqNOlISX8/xQitKWxGuFhLchU+ItbeulvpalarBOskZ374Jj+n3WNpcMUALWiVJF7TaI
 U5bVKgFVM2+J53YG6RP1cjcJMJ72RjxC3M9X6O42CIE3lk4K5e2VVEQXGezwZ6hsenSH296JW
 BDmtuj80kD76MFi6RbBid5BWGE45ARhiGz775z97Gi8vgJRnugHNqFKki67FToqYuC7hO0NXA
 InnHEmRkOV6GMC6uoiauPM0fR+YEXct09m7W1YzxxRYk5NrNwYXhL5sBEUenqbck7F3Am+xPj
 j53Wg8NT8JNR/r9Pra2iO8dmqSALoqYDcyoPn6jX3B7bW3vKQwRdI/JzrZ1cCqDfAIgZYiB+t
 eaZ4r/FNnUIJRU7EvMEHAOQSV0+YHcp4cs6pa6mhHi2ov0coZO8Vnz2UdKJoiWrcRNtY6871l
 ss8z0M0BpCjtIk2HmClBz/Kfw==



=E5=9C=A8 2025/2/3 12:49, Jussi Kansanen =E5=86=99=E9=81=93:
> On 2/3/25 02:44, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/2/3 09:13, Jeff Siddall =E5=86=99=E9=81=93:
>>> After a device failed on RAID1 filesystem, an attempt to convert the
>>> online filesystem from RAID1 to single failed.=C2=A0 This isn't an unc=
ommon
>>> use case if the failed device isn't readily replaceable.
>>>
>>> The command ran was:
>>>
>>> btrfs balance start -f -sconvert=3Dsingle -mconvert=3Dsingle -
>>> dconvert=3Dsingle /mountpoint
>>>
>>> and the kernel logs were:
>>>
>>> kernel: BTRFS info (device nvme0n1p3): balance: start -dconvert=3Dsing=
le -
>>> mconvert=3Ddup -sconvert=3Ddup
>>> kernel: BTRFS info (device nvme0n1p3): relocating block group
>>> 1222049267712 flags data|raid1
>>> kernel: BTRFS warning (device nvme0n1p3): chunk 1223123009536 missing =
1
>>> devices, max tolerance is 0 for writable mount
>>
>> This is not the chunk to be relocated. Considering the tolerance is onl=
y
>> 0, meaning it's the newly created single chunk.
>>
>> I tried locally, but failed to reproduce the same problem.
>>
>> Mind to provide the following info:
>>
>> - Kernel version
>> - Btrfs fi usage output
>> - Mount option of the fs
>>
>> My major concern is, the failing devices is still considered online, bu=
t
>> will fail all read/write/flush commands.
>> (Btrfs only has read time repair, not failing device detection)
>>
>> In that case, converting to single is the worst thing you can do, as it
>> will write metadata chunks into that failing devices, and lost
>> everything.
>>
>> The proper solution is to unmount the fs (if possible), remove the
>> failing device, then mount the fs in degraded mode, add replace the
>> missing device with a newer one.
>>
>> Thanks,
>> Qu
>>
>>> kernel: BTRFS: error (device nvme0n1p3) in write_all_supers:4370:
>>> errno=3D-5 IO failure (errors while submitting device barriers.)
>>> kernel: BTRFS info (device nvme0n1p3: state E): forced readonly
>>> kernel: BTRFS warning (device nvme0n1p3: state E): Skipping commit of
>>> aborted transaction.
>>> kernel: BTRFS: error (device nvme0n1p3: state EA) in
>>> cleanup_transaction:1992: errno=3D-5 IO failure
>>> kernel: BTRFS info (device nvme0n1p3: state EA): balance: ended with
>>> status: -5
>>>
>>> Either it should be made possible to convert a RAID1 device with a
>>> missing device to a single device filesystem without errors, or the
>>> command should return a message stating that it is not supported to
>>> convert RAID1 array with missing devices to a single.=C2=A0 Having the
>>> process fail and then going forced readonly is a significant failure o=
n
>>> an otherwise working system.
>>>
>>>
>>>
>>
>>
>
> Hi, here's a reproducer for similar issue that Jeff had:
>
> debian:/mnt# uname -a
> Linux debian 6.12.11-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.12.11-1
> (2025-01-25) x86_64 GNU/Linux
>
> debian:/mnt# findmnt .
> TARGET SOURCE=C2=A0=C2=A0 FSTYPE OPTIONS
> /mnt=C2=A0=C2=A0 /dev/sdd btrfs=C2=A0 rw,relatime,space_cache=3Dv2,subvo=
lid=3D5,subvol=3D/
>
> debian:/mnt# btrfs fi usage .
> Overall:
>  =C2=A0=C2=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 16.00GiB
>  =C2=A0=C2=A0=C2=A0 Device allocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 4.52GiB
>  =C2=A0=C2=A0=C2=A0 Device unallocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 11.48GiB
>  =C2=A0=C2=A0=C2=A0 Device missing:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B
>  =C2=A0=C2=A0=C2=A0 Device slack:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B
>  =C2=A0=C2=A0=C2=A0 Used:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.00GiB
>  =C2=A0=C2=A0=C2=A0 Free (estimated):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.74GiB=C2=A0=C2=A0=C2=A0 (min: 6.74GiB)
>  =C2=A0=C2=A0=C2=A0 Free (statfs, df):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.74GiB
>  =C2=A0=C2=A0=C2=A0 Data ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.00
>  =C2=A0=C2=A0=C2=A0 Metadata ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.00
>  =C2=A0=C2=A0=C2=A0 Global reserve:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 5.50MiB=C2=A0=C2=A0=C2=A0 (used: 0.00B)
>  =C2=A0=C2=A0=C2=A0 Multiple profiles:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
>
> Data,RAID1: Size:2.00GiB, Used:1.00GiB (50.05%)
>  =C2=A0=C2=A0 /dev/sdd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.00GiB
>  =C2=A0=C2=A0 /dev/sde=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.00GiB
>
> Metadata,RAID1: Size:256.00MiB, Used:1.14MiB (0.45%)
>  =C2=A0=C2=A0 /dev/sdd=C2=A0=C2=A0=C2=A0=C2=A0 256.00MiB
>  =C2=A0=C2=A0 /dev/sde=C2=A0=C2=A0=C2=A0=C2=A0 256.00MiB
>
> System,RAID1: Size:8.00MiB, Used:16.00KiB (0.20%)
>  =C2=A0=C2=A0 /dev/sdd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.00MiB
>  =C2=A0=C2=A0 /dev/sde=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.00MiB
>
> Unallocated:
>  =C2=A0=C2=A0 /dev/sdd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.74GiB
>  =C2=A0=C2=A0 /dev/sde=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.74GiB
>
>
> debian:/mnt# echo 1 > /sys/block/sde/device/delete
>
> debian:/mnt# btrfs balance start -mconvert=3Ddup -dconvert=3Dsingle .
> ERROR: error during balancing '.': Input/output error
> There may be more info in syslog - try dmesg | tail
>
> debian:/mnt# dmesg | tail -35
> [=C2=A0 582.117314] BTRFS info (device sdd): first mount of filesystem
> d4b36ef9-3518-43a6-bc68-a2b4df751896
> [=C2=A0 582.117329] BTRFS info (device sdd): using crc32c (crc32c-intel)
> checksum algorithm
> [=C2=A0 582.117333] BTRFS info (device sdd): using free-space-tree
> [=C2=A0 582.119952] BTRFS info (device sdd): checking UUID tree
> [=C2=A0 979.011795] sd 6:0:0:0: [sde] Synchronizing SCSI cache
> [=C2=A0 979.013096] ata7.00: Entering standby power mode
> [ 1002.726249] btrfs: attempt to access beyond end of device
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sde: rw=3D6145, sector=3D21696, nr_sectors =3D 32 limit=3D=
0

As you can see, btrfs is still trying to access the removed device, thus
still the worst case scenario.

IIRC the sde deletion using sysfs interface is exactly what test case
generic/730 is doing (but with single devices fs), and unfortunately
btrfs doesn't support proper device shutdown callback, thus using sysfs
delete is just leading to the worst situation.

I can enhance the document related to convert, so that one should not
try to convert if there is any unreliable device.

But I think the ultimate solution is to make btrfs to properly detect
and support device shut down request.
Although that would also introduce new complexity, e.g. what if the
missing devices show up again after missing several writes?

Thanks,
Qu

> [ 1002.726274] btrfs: attempt to access beyond end of device
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sde: rw=3D6145, sector=3D21728, nr_sectors =3D 32 limit=3D=
0
> [ 1002.726281] btrfs: attempt to access beyond end of device
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sde: rw=3D6145, sector=3D21760, nr_sectors =3D 32 limit=3D=
0
> [ 1002.726442] BTRFS error (device sdd): bdev /dev/sde errs: wr 1, rd 0,
> flush 0, corrupt 0, gen 0
> [ 1002.726501] BTRFS error (device sdd): bdev /dev/sde errs: wr 2, rd 0,
> flush 0, corrupt 0, gen 0
> [ 1002.726534] BTRFS error (device sdd): bdev /dev/sde errs: wr 3, rd 0,
> flush 0, corrupt 0, gen 0
> [ 1002.726659] BTRFS error (device sdd): bdev /dev/sde errs: wr 3, rd 0,
> flush 1, corrupt 0, gen 0
> [ 1002.726692] btrfs: attempt to access beyond end of device
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sde: rw=3D145409, sector=3D128, nr_sectors =3D 8 limit=3D0
> [ 1002.726702] BTRFS warning (device sdd): lost super block write due to
> IO error on /dev/sde (-5)
> [ 1002.726704] BTRFS error (device sdd): bdev /dev/sde errs: wr 4, rd 0,
> flush 1, corrupt 0, gen 0
> [ 1002.726728] btrfs: attempt to access beyond end of device
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sde: rw=3D14337, sector=3D131072, nr_sectors =3D 8 limit=
=3D0
> [ 1002.726733] BTRFS warning (device sdd): lost super block write due to
> IO error on /dev/sde (-5)
> [ 1002.726737] BTRFS error (device sdd): bdev /dev/sde errs: wr 5, rd 0,
> flush 1, corrupt 0, gen 0
> [ 1002.726835] BTRFS error (device sdd): error writing primary super
> block to device 2
> [ 1002.726844] BTRFS info (device sdd): balance: start -dconvert=3Dsingl=
e
> -mconvert=3Ddup -sconvert=3Ddup
> [ 1002.726990] BTRFS info (device sdd): relocating block group
> 1372585984 flags data|raid1
> [ 1002.727811] BTRFS error (device sdd): bdev /dev/sde errs: wr 5, rd 0,
> flush 2, corrupt 0, gen 0
> [ 1002.727816] BTRFS warning (device sdd): chunk 2446327808 missing 1
> devices, max tolerance is 0 for writable mount
> [ 1002.727818] BTRFS: error (device sdd) in write_all_supers:4044:
> errno=3D-5 IO failure (errors while submitting device barriers.)
> [ 1002.727821] BTRFS info (device sdd state E): forced readonly
> [ 1002.727823] BTRFS warning (device sdd state E): Skipping commit of
> aborted transaction.
> [ 1002.727824] BTRFS error (device sdd state EA): Transaction aborted
> (error -5)
> [ 1002.727826] BTRFS: error (device sdd state EA) in
> cleanup_transaction:2017: errno=3D-5 IO failure
> [ 1002.727838] BTRFS info (device sdd state EA): balance: ended with
> status: -5
>
> debian:~# umount /mnt
>
> debian:~# btrfs fi show
> warning, device 2 is missing
> Label: none=C2=A0 uuid: d4b36ef9-3518-43a6-bc68-a2b4df751896
>  =C2=A0=C2=A0=C2=A0=C2=A0Total devices 2 FS bytes used 1.00GiB
>  =C2=A0=C2=A0=C2=A0=C2=A0devid=C2=A0=C2=A0=C2=A0 1 size 8.00GiB used 2.2=
6GiB path /dev/sdd
>  =C2=A0=C2=A0=C2=A0=C2=A0*** Some devices missing
>
> mount -odegraded /dev/sdd /mnt
>
> debian:~# dmesg | tail -15
> [ 1332.628959] BTRFS info (device sdd): first mount of filesystem
> d4b36ef9-3518-43a6-bc68-a2b4df751896
> [ 1332.628974] BTRFS info (device sdd): using crc32c (crc32c-intel)
> checksum algorithm
> [ 1332.628978] BTRFS info (device sdd): using free-space-tree
> [ 1332.630281] BTRFS warning (device sdd): devid 2 uuid
> 0afd8d45-96d6-4393-b7ce-e55abd4b668e is missing
> [ 1332.632964] BTRFS info (device sdd): balance: resume -
> dconvert=3Dsingle,soft -mconvert=3Ddup,soft -sconvert=3Ddup,soft
> [ 1332.633041] BTRFS info (device sdd): relocating block group
> 1372585984 flags data|raid1
> [ 1332.638220] BTRFS info (device sdd): found 1 extents, stage: move
> data extents
> [ 1332.640073] BTRFS info (device sdd): found 1 extents, stage: update
> data pointers
> [ 1332.641350] BTRFS info (device sdd): relocating block group 298844160
> flags data|raid1
> [ 1333.991088] BTRFS info (device sdd): found 8 extents, stage: move
> data extents
> [ 1333.994336] BTRFS info (device sdd): found 8 extents, stage: update
> data pointers
> [ 1333.997220] BTRFS info (device sdd): relocating block group 30408704
> flags metadata|raid1
> [ 1333.998489] BTRFS info (device sdd): found 1 extents, stage: move
> data extents
> [ 1333.999617] BTRFS info (device sdd): relocating block group 22020096
> flags system|raid1
> [ 1334.000838] BTRFS info (device sdd): balance: ended with status: 0
>
> debian:/mnt# btrfs fi usage .
> Overall:
>  =C2=A0=C2=A0=C2=A0 Device size:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 16.00GiB
>  =C2=A0=C2=A0=C2=A0 Device allocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 3.00GiB
>  =C2=A0=C2=A0=C2=A0 Device unallocated:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 13.00GiB
>  =C2=A0=C2=A0=C2=A0 Device missing:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 8.00GiB
>  =C2=A0=C2=A0=C2=A0 Device slack:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0.00B
>  =C2=A0=C2=A0=C2=A0 Used:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.00GiB
>  =C2=A0=C2=A0=C2=A0 Free (estimated):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 14.44GiB=C2=A0=C2=A0=C2=A0 (min: 7.94GiB)
>  =C2=A0=C2=A0=C2=A0 Free (statfs, df):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.44GiB
>  =C2=A0=C2=A0=C2=A0 Data ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.00
>  =C2=A0=C2=A0=C2=A0 Metadata ratio:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.00
>  =C2=A0=C2=A0=C2=A0 Global reserve:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 5.50MiB=C2=A0=C2=A0=C2=A0 (used: 0.00B)
>  =C2=A0=C2=A0=C2=A0 Multiple profiles:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 no
>
> Data,single: Size:2.44GiB, Used:1.00GiB (41.07%)
>  =C2=A0=C2=A0 /dev/sdd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2.44GiB
>
> Metadata,DUP: Size:256.00MiB, Used:1.17MiB (0.46%)
>  =C2=A0=C2=A0 /dev/sdd=C2=A0=C2=A0=C2=A0=C2=A0 512.00MiB
>
> System,DUP: Size:32.00MiB, Used:16.00KiB (0.05%)
>  =C2=A0=C2=A0 /dev/sdd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 64.00MiB
>
> Unallocated:
>  =C2=A0=C2=A0 /dev/sdd=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 5.00GiB
>  =C2=A0=C2=A0 <missing disk>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8.00GiB
>
> debian:/mnt# btrfs device remove missing .
>
> debian:/mnt# dmesg | tail -1
> [ 1714.116147] BTRFS info (device sdd): device deleted: missing
>
>
>


