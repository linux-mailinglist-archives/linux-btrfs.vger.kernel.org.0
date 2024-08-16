Return-Path: <linux-btrfs+bounces-7225-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C5095434F
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 09:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF262853FF
	for <lists+linux-btrfs@lfdr.de>; Fri, 16 Aug 2024 07:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AF813D882;
	Fri, 16 Aug 2024 07:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="dkuLA6on"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8984205D;
	Fri, 16 Aug 2024 07:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723794348; cv=none; b=RRYGglqcQ/20xSAkVNPttw0AN1NvEE/YdQ0t+63WELe5PcnLyQcy38VZxorS4uSQZat2rYYBcTF3QBxCrcrWP/HNIRtjLwJii4VZQYEB3u931I9ijHpfLJxlkCL2JjWJCXsFvFeTKutvwqY7w5OIiyoMrLpovycFH79L/rvgE0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723794348; c=relaxed/simple;
	bh=F5ENiML29rLl8aBNpN8jhSOvik4ZfegSlDcPw6HH9g8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+UGkr9bUNuv5jsmk2LzLShZClhcfSqpnPb5T+a76F46t5COuYnQpqZn0HhBI5JiqoJkMzM0C7amrN1AlrR260j1f15ogIjAt7OLjT2v6ycx1SxkQoX2/8ivsT/2SCKlxuXe767MlNQDOgTFvdJBaufwYCwrmSwH037nuJyiyJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=dkuLA6on; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1723794341; x=1724399141; i=quwenruo.btrfs@gmx.com;
	bh=xev38Kn6r+hoKSd7Y07iIqEQWZS68/nFMYj1sMxvF/I=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dkuLA6onF+LsasMz3Y7kjc/kIu44fw2/COqhsg7+FJuI0unLAOv1RndZXIkqTtM5
	 v5AyhQ3o5HS7diSYNXkPIBGIvttPPTGio6Lqf1RKBiBqb8xz9s/MUJosboBVETYdV
	 uFwD4x43ZzqcmGrpPedzNCohnLu8A8NJXt0Uk2EOnwF7vMgFTj+l6iTwv161lWShr
	 QV4QyKPT8xagLNPBEcZ4Bei5mCF5KzrZ84oR8oHWRK/qoHsOEh8THmCCnzUv5LPk7
	 uTCLdGo+ziV9q1tjvvWYxSW9aWz+mwWuLn27YHmGivzu5W/Tz9Xo8TYA9tXKOrbma
	 PMHj3OACIOSAam74rg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MoO6C-1rqSs83HVA-00jZBp; Fri, 16
 Aug 2024 09:45:41 +0200
Message-ID: <81f434bf-f1b7-40d4-aa33-54c2f4869574@gmx.com>
Date: Fri, 16 Aug 2024 17:15:37 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 6.10/regression/bisected - after f1d97e769152 I spotted increased
 execution time of the kswapd0 process and symptoms as if there is not enough
 memory
To: Ivan Shapovalov <intelfx@intelfx.name>,
 Andrea Gelmini <andrea.gelmini@gmail.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAL3q7H5zfQNS1qy=jAAZa-7w088Q1K-R7+asj-f++6=N8skWzg@mail.gmail.com>
 <277314c9-c4aa-4966-9fbe-c5c42feed7ef@gmail.com>
 <CAL3q7H4iYRsjG9BvRYh_aB6UN-QFuTCqJdiq6hV_Xh7+U7qJ5A@mail.gmail.com>
 <3df4acd616a07ef4d2dc6bad668701504b412ffc.camel@intelfx.name>
 <95f2c790f1746b6a3623ceb651864778d26467af.camel@intelfx.name>
 <CAK-xaQaPbmZ+pcqFvfgtwTyMnHbMcs6j8KjgVOYBxGzGgoAJ7Q@mail.gmail.com>
 <7fca93ba155921cd3d32678899bbfcea58d23da3.camel@intelfx.name>
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
In-Reply-To: <7fca93ba155921cd3d32678899bbfcea58d23da3.camel@intelfx.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m37P737eWgX8tTolImS24TexYAsFCDEPs710cU/fQGmuHGmlEeQ
 zj8yRqptqFvDzSyKaToKCZGI3x6DP37fHfIdO/UGllCGA5jOSaQsHaw6O0A0k9ppXzFVCTH
 +K3h5HONGp/HxA5MquNFYIEx/UD1eAYQjpM8PZSuTFxfJGRChi96FxavVAhoerhxcWTfk+I
 sZ71nRXal2E5GlBxny2mQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VDN6cGCHYYI=;h50RBhS8ZqtJ5mcuOu7rPlnq6Tb
 OHoLoL/2OMYVbbFf/Tb4orzFPri1nQgJ6jWVaDpiM0oj6zPZkxOyIhbM1SGIVOlFXeNOIcQMw
 tKHu/4ffV64SSNeslRRDlZKyqRvZOdYHzV1LVrBV1/dRr6fvT5I97ahHjJs4JU2Ot7eZABKqz
 1OtSqe4/lyyC2XuOwqf9D7Hyw1KEoUdpDpuIzVNAowBoXXUUo7l2y/ANgdlnNhEVWM9SF9Djn
 ofF1cRJbN64KY/d9Uu6T4mWDxIPDwIvTHGqKdaq8fvyQGgsW7Uf9hkTCp2mTQJQXQRGYvuAp9
 ZDpN6TuszbfxLzA5puGRk4HylVSMiMdsEYoirQuFGiUOBbS5y+ZBIvb3Dir1YWNhU4OlnG5qE
 okigml08TLrOClkjPz1A3wy4Am7SSPqxZMe1LDM+7gnqm+7Uf102Kf2E1yJFlPZEEf7//3gNr
 Y5C+tuf89wFbJM8TNTgNmhBDw/m9DTYDCW2DZp7DxUTeDfGiDhffgZeriRPAxEuFDbE3JxEEJ
 LK2zFc4Hw8appPkj7CplTfZ0J3qvVk6QYxsRnMBBMCldGM/hyaZlZN+EwtUwxpoVbmn+rdurd
 MQqtxY8qT8/pax4PAzX2gbpUTfKLBLgsyS79xt+z8J0KGGXAoOJ30f4ffBOyhRh3sWy2ryLRv
 XTMpxdPbjVsg7PVVv0KtmUVDi8ztqS1UtwMz9NTU0giPuPXTPGqcbb3RFawtNQfAwJtMTkNmx
 Z0njfYaNQmmfdELHvdw/euJEZVl+qug/tB8c6JLsgNJ9cKSkXOpcu0w6u5o1EvekhQe1D1hzY
 S5oZzbPNH7VhWM7CsoWBudCA==



=E5=9C=A8 2024/8/16 16:17, Ivan Shapovalov =E5=86=99=E9=81=93:
> On 2024-08-16 at 08:42 +0200, Andrea Gelmini wrote:
>> Il giorno ven 16 ago 2024 alle ore 01:17 <intelfx@intelfx.name> ha scri=
tto:
>>> Can we please have it reverted on the basis of this severe regression,
>>> until a better solution is found?
>>
>> To disable the shrinker I simply remove two items:
>>
>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>> index f05cce7c8b8d..4f958ba61e0e 100644
>> --- a/fs/btrfs/super.c
>> +++ b/fs/btrfs/super.c
>> @@ -2410,8 +2410,6 @@ static const struct super_operations btrfs_super_=
ops =3D {
>>         .statfs         =3D btrfs_statfs,
>>         .freeze_fs      =3D btrfs_freeze,
>>         .unfreeze_fs    =3D btrfs_unfreeze,
>> -   .nr_cached_objects =3D btrfs_nr_cached_objects,
>> -   .free_cached_objects =3D btrfs_free_cached_objects,
>> };
>>
>> static const struct file_operations btrfs_ctl_fops =3D {
>>
>> This is from my thread with Filipe about same topic you can find in
>> the mailing list archive.
>
> Yes, that's what I did locally so far, on those systems that I _can_
> run custom kernels on. The others I had to downgrade to 6.9 for the
> time being. So I do have a vested interest in this being resolved in
> the mainline/stable tree :-)
>

That's the most straightforward way to revert to the previous behavior.

Or you can try this patch, which is less obvious but should do the same
thing:
https://lore.kernel.org/linux-btrfs/09ca70ddac244d13780bd82866b8b708088362=
fb.1723770634.git.wqu@suse.com/T/#u

Meanwhile after looking into how XFS triggers its reclaim, I believe we
should not even bother using those callbacks.

XFS handles the trigger by making sure there is only one reclaim
workload queued, and the workload always delay 18s by default.

So for btrfs, I believe it's better to do the reclaim in the cleaner threa=
d.

Will craft a proper fix for you guys to test, and since Filipe is on
vacation, we may go disable the reclaim workload for now.

Thanks,
Qu

