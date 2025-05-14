Return-Path: <linux-btrfs+bounces-13994-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B51DAB61A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 06:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3BA74A2A38
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 04:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4051F0996;
	Wed, 14 May 2025 04:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Mrbm4RRR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94A21CFBC
	for <linux-btrfs@vger.kernel.org>; Wed, 14 May 2025 04:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747197606; cv=none; b=ZHZA4HdD/cA1Hef5eP0i2jY9m+axvMThf7RwMfpb1XhMfXtUafK/NQYtnlsP7PNpOA/aU8nkEtqZ4Ke/CguKLwCZljAQdq2IPMKnuoNnSPjn9Y1wwglAud0gosRXj+gzSKicWDvL8SqodLTwTXNmzzQ4LFSxB/PBpEWuYaU+55U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747197606; c=relaxed/simple;
	bh=oqqjlKHLQ1upk7+p+z7ggO+cev87Jl3d892yaShiEVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rtsw0lO//DEZ382qGAVk70C2vIjQGnuMPJspXNGzRfuaaAnVJd30YNeEYNAbdinkq8Ppfdo3OFph8TCOh6DQEPSzS5XBDlKqc/YidUnbXfIidor6JKZy7V6nSZfmWws9jtX9RHg1/Q6EucxUdbEeS+9txrm1xXngYXwc5dCC4DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Mrbm4RRR; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1747197597; x=1747802397; i=quwenruo.btrfs@gmx.com;
	bh=nicpWLXVEs9ytbXyFtrB2JWLpS6ZlWS+lvI8ePyQwb8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Mrbm4RRRHR+kpeSeewYkg6agPenu/RJ3sTA0v63NA85L0xaFjwB7TPtUQUOU2DKV
	 dmWRiJFW90vaOs6JjutkwlTSolsw6rSMF3CB/TS4Pvg5+W362VRb7LuiiQLk6b2C/
	 FB/mQ9HwTkpIt1h502zXfj0ovJWsAied8NFfxZw31/ugNLvONLrSwFKj5t3douVZt
	 QM1CGWCKH1+jHEzJlRb4xeWk7caiqIhmq5zV7CAQicCCJoe6c2iboiZTbXzm6ObtU
	 XEFXy+CxIuknIBc97QlW15tRFg+izONPTs8nHztV2nmbzdiETJICuzj4SVhjDcHY8
	 H0mJMtnEm8JmbiWzCg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQv8x-1uapeE0wYp-00Z65W; Wed, 14
 May 2025 06:39:57 +0200
Message-ID: <9c437137-4334-44a4-925d-51690769b97c@gmx.com>
Date: Wed, 14 May 2025 14:09:53 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: add prefix for the scrub error message
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <7cb4279a93d2a3c244e18db8e5c778795f24c884.1747187092.git.anand.jain@oracle.com>
 <9ba1fc52-38b2-43f6-9c29-df924d8045a4@gmx.com>
 <8630908b-2bdd-4726-889f-b9496d947c4d@oracle.com>
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
In-Reply-To: <8630908b-2bdd-4726-889f-b9496d947c4d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xuaQayKHdINvHyfCFUqAFf67Vz5phQE3V1mBCFesZ2KoVhQWr2X
 op2AxQQUM3HwT0CE1g9T81cGwfhjjE2ps+OkyGQjxEH6zra0qxeqp3qtd8E7OlZtO/asMAW
 hDDt6b5F0/xr6Y2Pe5hEU3R/3Mmfw3nxvcm1PcIoGpdCFApv8DT6wYu7zKkRR5SGX5+gaIT
 C8FQ1rYQM9BS2W/bbuEBA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fR1AtLTZz+4=;4R5Soo2v6W8FcBWIXFBx6iIFurJ
 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
 UiOeVA3xneOVk=



=E5=9C=A8 2025/5/14 13:57, Anand Jain =E5=86=99=E9=81=93:
>=20
>=20
> On 14/5/25 11:37, Qu Wenruo wrote:
>>
>>
>> =E5=9C=A8 2025/5/14 11:15, Anand Jain =E5=86=99=E9=81=93:
>>> Below is the dmesg output for the failing scrub. Since scrub messages=
=20
>>> are
>>> prefixed with "scrub:", please add this to the missing error as well.
>>> It helps dmesg grep for monitoring and debug.
>>>
>>> [ 5948.614757] BTRFS info (device sda state C): scrub: started on=20
>>> devid 1
>>> [ 5948.615141] BTRFS error (device sda state C): no valid extent or=20
>>> csum root for scrub
>>> [ 5948.615144] BTRFS info (device sda state C): scrub: not finished=20
>>> on devid 1 with status: -117
>>>
>>> Fixes: f95d186255b3 ("btrfs: avoid NULL pointer dereference if no=20
>>> valid csum tree")
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>> =C2=A0 fs/btrfs/scrub.c | 3 ++-
>>> =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
>>> index ed120621021b..521c977b6c87 100644
>>> --- a/fs/btrfs/scrub.c
>>> +++ b/fs/btrfs/scrub.c
>>> @@ -1658,7 +1658,8 @@ static int scrub_find_fill_first_stripe(struct=
=20
>>> btrfs_block_group *bg,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(!extent_root || !csum_root=
)) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_err(fs_info, "no val=
id extent or csum root for scrub");
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_err(fs_info,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 "scrub: no valid extent or csum root for scrub");
>>
>> In that case we can remove the phrase of "for scrub".
>>
>=20
> Done.
>=20
> -----------------------------------------------------
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 521c977b6c87..fe64cde14170 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1659,7 +1659,7 @@ static int scrub_find_fill_first_stripe(struct=20
> btrfs_block_group *bg,
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(!extent_root ||=
 !csum_root)) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 btrfs_err(fs_info,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 "scrub: no valid extent or csum root for scrub");
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 "scrub: no valid extent or csum root found");
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -EUCLEAN;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(stripe->sectors, 0, s=
izeof(struct=20
> scrub_sector_verification) *
> -----------------------------------------------------
>=20

Looks good to me.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu>
> Rvb?
>=20
> Thanks, Anand
>=20
>=20
>=20
>> Thanks,
>> Qu>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return =
-EUCLEAN;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(stripe->sectors, 0, sizeof(struc=
t=20
>>> scrub_sector_verification) *
>>
>=20
>=20


