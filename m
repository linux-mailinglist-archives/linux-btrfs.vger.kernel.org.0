Return-Path: <linux-btrfs+bounces-7982-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5296977857
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 07:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 633B2287BEF
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 05:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F22188005;
	Fri, 13 Sep 2024 05:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="UpteGnq4"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2D513D52F
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2024 05:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726205378; cv=none; b=qQtZCVA8YvNHXU98ZjMPSLUZFvlXcopurzNWHRtqJsWl5YO7VqKdGjO+ttCuJObO3QYG6AX2nQlUNyJ0X9llVeB/W+W1EJDG+7axeLm30COo3WdQ5jdUFUCfADmjjG2LTULW8rwia2vjRkn+NHWhh10ljUSW9LTEgv0xXrDtc4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726205378; c=relaxed/simple;
	bh=8iIll7EXExu2N9LTC3rEJ2vU7+HP96MVgqvDF+j2BqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a4BvCQFPdTVQbhAVdatgJ2VvrP4ZWD+onPcnZv3wSgOXa5lUR62kM/mIApw9JsKqIypYSY707d5WLjinKjZbtPzxm+YAAFFeRevTrtABKuc5f2j2vj3PA0NamFsz8DK8Kh+3ZxFNsOIQB/VNDb0VrF7eIiK3RYgG0SgKKUa/HPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=UpteGnq4; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726205372; x=1726810172; i=quwenruo.btrfs@gmx.com;
	bh=8iIll7EXExu2N9LTC3rEJ2vU7+HP96MVgqvDF+j2BqQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=UpteGnq4+d6AE++R5R7yX+jevto4+Ogz1lvypPZh0/LCfnpbFYs4VPPdkyssuLKT
	 fkGmqMdkRXo15JKx0u2hz6fNZ3dmbHSaPBSGCQb48LWdXP/lLX6aO542/yT72YR81
	 vxOrexPVt6n5ylgvgAICh2DQ2GC8X9+KyW712OR2VDoRtXrz/JXvv5ASt+b1OaKls
	 fl3WlFKT38XgIed4PpfxQYfYq533pMvvU3CTnszpUJAVxNTVf9Hy0rQiph/2uXAEP
	 6hovTph2euRBCrfqH/UNtVdFrdRpJwDAfuAzeaHuVtb4l/oOrc9HF96IeXioA7fq3
	 H3dUsafK3HtpflJ3yg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiJZO-1sKbrZ2iKU-00pSh4; Fri, 13
 Sep 2024 07:29:32 +0200
Message-ID: <84938a9c-97ba-4f90-8e66-bdfabf455146@gmx.com>
Date: Fri, 13 Sep 2024 14:59:28 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Critical error from Tree-checker
To: Archange <archange@archlinux.org>, Qu Wenruo <wqu@suse.com>,
 linux-btrfs@vger.kernel.org
References: <9541deea-9056-406e-be16-a996b549614d@archlinux.org>
 <244f1d2b-f412-4860-af34-65f630e7f231@gmx.com>
 <3fa8f466-7da9-4333-9af7-36dabc2a2047@gmx.com>
 <4803f696-2dc5-4987-a353-fce1272e93e7@archlinux.org>
 <914ea24d-aa0d-4f01-8c5e-96cf5544f931@gmx.com>
 <2cec94bd-fc5e-4e9c-acc9-fb8d58ca3ee1@archlinux.org>
 <e81fe89a-52bc-4629-a27b-c69d64c9fbec@gmx.com>
 <b44f33ba-3230-476c-ba3e-cb47e1b9233a@archlinux.org>
 <57614727-8097-4b43-93f5-d08a078cbde9@gmx.com>
 <66e28d81-7162-4ab4-b321-088ee733678e@archlinux.org>
 <523adab7-9a88-4c27-93bf-a85fd87162d8@gmx.com>
 <3bfdf0ee-9efa-44b8-b9fd-cabcf90875ec@archlinux.org>
 <ca541404-4bfd-41b8-9afd-735bce6db663@suse.com>
 <e1dc1add-0bb7-4d13-8929-a1bfdb8181bf@archlinux.org>
 <650f2de0-c5e5-4e3c-aa0e-ff79d931a263@gmx.com>
 <ccf78d58-a050-4ba7-853b-37b6a1386a69@archlinux.org>
 <1ee66f34-b855-4a96-bf75-a3d14b9ce392@suse.com>
 <c275d2c9-20d9-46ce-82ab-3f86c091a5d3@archlinux.org>
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
In-Reply-To: <c275d2c9-20d9-46ce-82ab-3f86c091a5d3@archlinux.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hkL+EmHCWmFzfDb6uit/NX29Ai9kQ6jXw6qmrrSMj6Ylux8et4w
 eppmOf6UbyIMsOHMVlQB4/09SVIPixV5XefTpeipuBwGY5BxySL/+FowhjxsfN72/0MsJSP
 JnGYwt/LFcGu5pDt0bl5A/l+AI0Fqv64skaRTWdUf+xF/zBBePRAp638t63vH7jyBzStxgT
 NjUrg/XK5aiuG69A33RlA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KrFfJHsG3RU=;tOgWa0AllyHBgNc7HAITkcH90xg
 uRyUorUmQUbj1xbHv7oekHiipGDv0ArwxGe9RrdCQe+hsm8OeWkiqb0BLrbVWHt1dDTec5dlG
 4FQwvXyH/ZV6DW+rZLONwYi9TUpVOxf+63MQkyuN/XsYFlu0RIg2hw7+5/hj/5NRh02BRvIx4
 Qksza/RSUUvqhLADrqelCSqPWOaQ1f7QRnsTx1P9FykNiCxcaueG/ccHtHRsLWn2IVoO54z8F
 AIxx2e3osfnOfeyy7LGONBuPfKRc/V2RMo1XpJlKOQmmWir1Ojl7Qx3fS7leRiLxFZa8NeY10
 w3nPif9G+65N6DZhbD+O1kBiw4WoYUMUQnNnla8dpE1e7O3blZe3yKmEyTzZ9OxJYPER61+ri
 u/THBJ8yFVEL5RX7xpeCMmx8Edsmkz7Odfier9AB8FSm/VQU4sD/TssVXn0969G92ubJppKrp
 WcIaszYtbogi17nPhI4TQRmbbgnnoBOFAqfqTT9T09UYXrySsJOYISfvjy0OYvwaYNwz+Ajn6
 U+gppfcXMAor6ypbJ9Mub3APf2+lt/sU2B2Cr15lEjhkJI+FJAgOLt5/vmSZMfxyoQ9wU3HzD
 DELJzTzOa6QjqfCZZdDU6IerlqU1HXaQeQ758gMRs+7X/3928k7VNSXwPaqGRtAwSV+7Tm14R
 p/IJuXHRB5+knYkKEFvE5+Eg5ii4/igfCNPPMhjedniEertXagDibiZJXRQ4QT+3VmkMFcXSm
 JFxyIsvHPBIR9TagOR4nOWtpvcG4q02sEENATZkAasgTzuW3jwtwVQx5l+YQcCsEtWNPw0ZKM
 CJrK8D04l5g4vzDZ1RPtYJBoHaM0Mwu+i0SSV2dd5ED60=



=E5=9C=A8 2024/9/13 14:55, Archange =E5=86=99=E9=81=93:
[...]
>>
>> This indeed shows a very old filesystem, and for a long long time, we
>> no longer create any block group at logical bytenr 0, thus it shows an
>> corner case that older fs layout doesn't exclude the first 1MiB.
>
> IIRC this file system was created in 2016.

That explains why the first chunk starts at exactly bytenr 0.

Newer fs will start at bytenr 1M, so it won't touch the reserved range.

>
>> And it's indeed a false alert.
>>
>> In that case, as long as you still have unallocated space, you can
>> just relocate the system chunks:
>>
>> # btrfs balacne start -s <mnt>
>>
>> Which should move the system chunks to new locations and will not
>> utilize the first 1MiB reserved space.
>
> # btrfs balance start -s /
> ERROR: Refusing to explicitly operate on system chunks.
> Pass --force if you really want to do that.
>
> According to https://btrfs.readthedocs.io/en/latest/btrfs-balance.html,
> -s requires -f, so I guess I should continue with that?

Yes.

And I also recommend to convert your metadata and system chunks to DUP,
if there are enough unallocated space.
(If have more devices then RAID1).

It looks like the old mkfs defaults to SINGLE for SSDs, but nowadays we
keep DUP no matter if it's SSD or not.

Thanks,
Qu
>
> Regards,
> Archange
>

