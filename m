Return-Path: <linux-btrfs+bounces-7932-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F78974DDE
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 11:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8947285D1E
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Sep 2024 09:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7FA155A52;
	Wed, 11 Sep 2024 09:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="aOnJBfEU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62BA2AF1D
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726045458; cv=none; b=hA/8uR8ouexumJsiZOUet3Yze0UeA5b/WtwKRZ2d2T/kErWaD+ROeDF2AY/nNyDk/lKcoy14hLyOnEyw2fb5kJR62lMhIvZ1/TlRCnGl4lgGsr715FoCQf8yYjvkitSkIdFy+ppA6Vgw27dmHiypFXp6pUzjpmURp+tplHhRw3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726045458; c=relaxed/simple;
	bh=5JFWjvlpnacTFEtcOIAObx50Hrkc8K3UkpPHl7fUgmw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qsMquYrC+JfWplYG1/pEBWSk1LcckRI7QVOva99PHoLSOqF+KpOBWEKHFrjqoSnBYED0YseMG22Li2w9jkhuzbvwZJ1EFCn2tncCSCwgjEyVhBqLXGlsvEJnRmlvteumzQ0Mb3ysi2clq6GP5hSHM3R//DcEo6frDNMbnk0jsZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=aOnJBfEU; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726045454; x=1726650254; i=quwenruo.btrfs@gmx.com;
	bh=Yz02bzQTplCXsIhN0HsTqdSSpsHAbiQwh85e9fIxlrA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aOnJBfEUbprpQX559J+Kt0qM4BykOkcpiB+mDEEp3U/RXsJiV2qWM/MtxOaXWX/v
	 X6AfUHqHeCwyi2TgddtQqmdIZ61ZDctEJtLbVTXuaTvEKVqZUbsGykM3goUMLh9c8
	 OzGf6PJBIeNLGZNjY67q4vfV5kHt+A0rTuEmUxGwV6qfprXj4pWd9sdxFt3gGDq28
	 aG4sJ/groV52dpihgPLuGqGTRwX414YWVGjtOxlRmSAm7OtsDOOrDAdYXm9n4iDPT
	 qBBWJKyuiAgqn4RqzlPRuMBmCZdo7E6bnEiX2CrJ61li9056KABlXL45JaZah4mM6
	 P0IfttiliUOYnnGuQQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M2f9b-1srsAc1zLD-004C6B for
 <linux-btrfs@vger.kernel.org>; Wed, 11 Sep 2024 11:04:13 +0200
Message-ID: <d91459d0-ee3f-43f4-87c9-6b7eec69e48e@gmx.com>
Date: Wed, 11 Sep 2024 18:34:11 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Btrfs balance broke filesystem
To: linux-btrfs@vger.kernel.org
References: <b9b86b32095ba924fb8c7eec4d8ec024113d9ff4.camel@beware.dropbear.id.au>
 <5fdb905b-20ee-4978-ba81-10b1fc4ac475@gmx.com>
 <20240911080004.GA218002@tik.uni-stuttgart.de>
 <79e83450-098a-4e09-bfcb-625b6346525d@gmx.com>
 <20240911085829.GC218002@tik.uni-stuttgart.de>
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
In-Reply-To: <20240911085829.GC218002@tik.uni-stuttgart.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EjSoqQ9kA9NpseQzyp+j9yr9J9pyqaOMvcUHKJWbu1BAgVc+8BF
 aijFEMJcbiIrNuWmib/1uVh2Y8JBo/Ka/1EzAtgh9igvbDL6j6Ml0IqvVYgS8yZj/2iFx96
 GEf/M5UWmZrhOusAOovUdh7lJUzHxW9Pzxbs5D0vkHtLLxhLcvn6ziKML6aPzh16Eat2waD
 BHjGXt4RbUPhgjZd0SLMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/v5dpfI/qEw=;PPghGrPFVK4mGn8MyGyaVNUJOXh
 9i/s/qFijJx2YL85r4szKjh+AdaLDHWwpIKi8tIO/MXSNJ8s4iZBzEB6NisLxJ4+DpAcDsGZ/
 /K7yL6+cl72gsGBq20pIGFdwi0Mnnc7uNgXXQSsWfd55YRLfdqm4bypa8xKw6S8EvgQc3vtx+
 6+yVL82pa9IrfwUlO3q93ljj9Rx40aNaxM8U1hspSGZUD6M7Z1BzVxpOF0eZ9W+rHQ9DLnbIs
 4zlkRqGFklv2BC0kHbvjv3oKk11NtM39S5YHfaN1YVNH5QpgKkJ+AF2jw08TZji10V4IxMNKV
 pXLQiGhOePGFfRxdL07xcFSBea4w2o6Gjgl/2J/7fimUTh400wPOs6jg041jhCakpeQSZd3ME
 U8cQCmZC4XEoiUCcTjOI9t10VFmHwyItIjMrYO6dUXbXgzyEH+7yxGULePdNzwBNlCvuu5jfH
 AW2mZOCdCOterSEfwDvpWwjtIU7g8XtOA5vbbRTO0wXOgbVPmhHwRNQ8iqigsasB9ymzkJJk9
 b3s9La+LDWyDXkQCnqoRkOK4uvtpeU0Z3bWBbGw8qTMgawJT2pDOx5kNUBLWufpYB3nXJtUA8
 HyjQmvydU/F6/KvyZtAnSjW2faWwtcViJcw86C+hN8PyNNBQDtkTvhqpU78AjhZECvptpVhKD
 9vF5x5be6plJXhmzm6YPezUBlC5k065M0nzJZwtSKOlXMOSTPbtopm08OiA5ofwZWRVdi7p8m
 TgSBKKt4cT5fTrqaYCOJdLjxE6cYAgeNzcVo392g3wcyGUHoZNUBMZXuAv86fN5aDrwqYZbwD
 z76bAL/bubuRvhSBxLqpeeQg==



=E5=9C=A8 2024/9/11 18:28, Ulli Horlacher =E5=86=99=E9=81=93:
> On Wed 2024-09-11 (17:41), Qu Wenruo wrote:
>
>> =C3=A5=C2=9C=C5=A1 2024/9/11 17:30, Ulli Horlacher =C3=A5=C2=86=C2=99=
=C3=A9=C2=81":
>>
>>> On Sun 2024-09-01 (19:15), Qu Wenruo wrote:
>>>
>>>> Convert/balance is only recommended if you have unallocated space (sh=
own
>>>> in `btrfs fi show`) to fulfill at least a metadata block group (1G in
>>>> size for most cases).
>>>
>>> How can I detect this "unallocated space"?
>>
>> My bad, the more correct usage should be "btrfs fi usage"
>
> I see, it is just "free space"!
>
>
>> In your case, "btrfs dev usage" is also fine, and that already shows th=
e
>> problem:
>>
>> /dev/mapper/cryptroot-1, ID: 1
>>      Device size:           915.01GiB
>>      Device slack:            3.50KiB
>>      Data,single:           842.97GiB
>>      Metadata,single:        72.01GiB
>>      System,single:          32.00MiB
>>      Unallocated:             1.00MiB  <<< Only 1MiB, not enough
>
> Mismatch-error :-)
>
> It is not "my case". The thread starting mail was not from me, I have ha=
d
> just an addon question regarding btrfsmaintenance.
>
>
>
>> This multi-device problem is a long existing known problem, I guess it'=
s
>> really time for us to properly fix it.
>>
>> The unallocated space is only a workaround, to prevent hitting the
>> situation.
>
>> For your use case, RAID1 with unbalanced disk size, there is really no
>> good way to fix it until we fix the root bug.
>
> If there are no btrfs RAID filesystems balancing is not an issue?
>
> My storage is a hardware RAID (Netapp), the btrfs filesystems are on sin=
gle
> virtual disks (/dev/sdX)
>
> I can riskless continue using "btrfsmaintenance"?
> (I just should switch to the official Ubuntu package)

In that case, yes.

Thanks,
Qu
>
>

