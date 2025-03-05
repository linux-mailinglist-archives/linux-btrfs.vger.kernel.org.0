Return-Path: <linux-btrfs+bounces-12017-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4D5A4F872
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 09:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58B213A7175
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 08:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520FA1F419F;
	Wed,  5 Mar 2025 08:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Ldm+IQLk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD342E3360;
	Wed,  5 Mar 2025 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162140; cv=none; b=GWWq+VKGbxqv5SWJ/AckKg0dNW+6yHAuWn/opsGzIlLmUhod1BMGHGkGwor00YkpMWdzUgz2qtyN/N6SBYPBBTAkn/+LPMmc83VDzK05UOA4Pm+MxoMDblJZC64qcmZ39o/1nVuR0WFcz7czt95vWTAnfAq2/Iq5r6xkxx18/2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162140; c=relaxed/simple;
	bh=x94aN2O8PqkMYd/XlXCzaKZ0q6OC2EhoZoDLf3dIoqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FvuJSZm0SbzizLPSc+a/w4umQaltuEy4reMhlYdCLhl4AeIRzFpCdrIVQ2HFJIskbFSKlWxz5BrQmcUKXWfSGBb3Agv6ijcnnXYP4rBWYmzz792xLbvEtW0gMkXwwxbGN7xIZ0bLUjx/UI88h/DlCC7c7HLVTEetFsOBbKhT+yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Ldm+IQLk; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1741162135; x=1741766935; i=quwenruo.btrfs@gmx.com;
	bh=pbj4XAu0X/u1iuH0pj5czWsw0tMh5VFPAcUpFwl3AGQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ldm+IQLkpK61dpPeYpxZnJNBakCnIzut6HX9G7pq+dRpvWhAzBvPydw9yvVag5Jo
	 qPpsZmOith8EdJwL8wFiTFWSTHHGGuXb5klMf2IxhhuEVli+mBa6NkSlSqV9VPnWN
	 9vyeLH3KM85FfVsW7/gG3XKe+0FoF66Mq/COAUuo2aY8eoq5sM656FZ0VKQv42Gnd
	 OcX2SsXEchgH+kdfh9nXVGZaKIC3SSDEILIUGeyZWMEYnH8ZtZdAgcHeU07Absfb/
	 Sx1fBQKBievECf3ZIl8y3KqXP3cfP6s0e7FRFYfC+70KlwWeji39xaITOIrbWfY9e
	 0hmetCc2Odg3wpVK+A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mgeo8-1tJzxK1oOC-00fNvE; Wed, 05
 Mar 2025 09:08:55 +0100
Message-ID: <10b0cfa5-eadb-48a7-806a-3fc044682b04@gmx.com>
Date: Wed, 5 Mar 2025 18:38:49 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/defrag: implement compression levels
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250304171403.571335-1-neelx@suse.com>
 <bc3446ce-347f-41da-9255-233e2e08f91c@gmx.com>
 <CAPjX3FcZ6TJZnHNf3sm00F49BVsDzQaZr5fJHMXRUXne3gLZ2w@mail.gmail.com>
 <29ec66bd-27a0-443e-b19b-fb759a847dcb@suse.com>
 <20250305080150.GB5777@suse.cz>
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
In-Reply-To: <20250305080150.GB5777@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Z6X0t3bLk8SX3URasfHdROjmmtpFiwYPYb8iwyBXZvIAtHloHFi
 grPN8Nq5Oln/jDfLReVXpxOOzFkRJScF21eBJ9qho1fjyauswFQlKc+UYjOxFna07trEE6Q
 pEqJpVrlHuBCrME9Br8bjKCBlASZOsUxHNFVd0f6I7ucbq+QO6BrfKxpmg9x/+FzPV2jsTA
 n3CFNSrabhJL4crNHL6Ww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Lo4A3qDdhaU=;47ZqoX3d+w8K4rAZG2E2HZRNt1g
 VJ92Fi242tiCKVEsmOugANwVDjMgEMNOl+aAKH1QDStcump2NZsSVpmzSUZsLn0OrENQrtgVN
 hwjGBtrgRjSLFkskDHCP+2gDo01881V1KUN0l5X3vchsbsaxK8qA8xZjMnRE+B+RT5iVHIyot
 Yqm9NnTxoCdvJImgmByun9xA/NtMN3dmqlZGCAQ35XBwmBeMqZ3fIeaNhRXdjqNaImooxvkPN
 mzWFr8FHyOdAvAY/MaK32U15EDL/Xufq+WXCs3QkaG2kI1wgMqDGY6JxMUjqi6/8uvEQ87T3G
 vtsG0glH5PXI+GClDUz13FpBMhoLFF+sH2cyeDzU2hfCMHYqr7ZT9umNRhYU1qV5q6KlguIVS
 LLo6UXfCxqoxcZntTzpj4TkOgn8CQMUEfllHSJoDPQimpuRciLbX3B8idpdRsDSUE0wCyHfts
 u0xogxHBdR53amJ0p3PtbDDbH1xS1R34CIY7s6JldqT5PtRTj4X6dZNHZ615M6pJ0PVdq/eK4
 Om2ZB2YiASpD7SptpDm9ON5pdXakxnrBgc2JiFQGUv/6gXhgsDgeADBs9hvkXw1PH99B2R6e1
 XbC+6NztmFsqk8Ph5ZHy9rEt+8Xr+s4Eai7PagS9G1wm06mNRXoIcP701Nb22GPd0wmGZEpqs
 FLix0HLFq2RgMOIpMh3mEvhGtXScBYrK3HX8s3/dorkkqrHwQpwgQL9xdMTp1EojwP6+yCkGu
 cIyohRrWzcgIvBny2gojx5cIfIs7pjGyCqaW/0acKH6gc0ew9AmD9bfpvcHoKQgsFtMpgMDNT
 ZiMlQ03rtbak16bQXxZzUROXW6pHAetmAgROnufI2uLsOZKjeIuW5bi+rs0+HY22zBVcknGzu
 b8qDTjUz+im2Lu7LeK9JU+4WAIZLXIKCnU/jrE/nJRAam6MQ954UcVg96H9IZEx64L7o6nNPi
 9Y3wKz3Gc9gWlmA7Qr0/XT3AFwPghaSVKmDDNmXcTCrHOinwYItI3CDtrvWsCV8R87E31oEUO
 Hz7+FcnqUHkS7PQtJ4a0FIyK6KtEY56Hzgjo5HKgdf8JFfZAqnMyDaaT4RM1GPZAO0fxb7FPr
 jpI+Tqgzj/MCWiQn8KDetwIYJp0881w6AAoD9dLdQ2wcYeRF/e+jGqATqMntofnXcG4CRXPfE
 EGN5JfYJEyZ5gcROKd7fJ4V/cpc8wOca1Y+uyHQuSIT8zKeP3YViY2d/wSLLzdkzR36CYtvGE
 1hWVWNkFNx8yG90jOkXGfruN6yJWKBbEQHLs/WFHTGciOAbUxKuqMexNUrCoSADsLUsRNmKe/
 drO5oIoepqf7pOVnz5o1craBVWz1bl6hDk26T3kS6/upz2F/JwZHHWlW2WthCV+Hnm0WxkQsj
 k5wAF8O5WkQ1uDK1KTZQwF+v3Ir8sRWVT7L8o=



=E5=9C=A8 2025/3/5 18:31, David Sterba =E5=86=99=E9=81=93:
> On Wed, Mar 05, 2025 at 06:14:16PM +1030, Qu Wenruo wrote:
>> [...]
>>>>>         /* spare for later */
>>>>>         __u32 unused[4];
>>>>
>>>> We have enough space left here, although u32 is overkilled for
>>>> compress_type, using the unused space for a new s8/s16/s32 member sho=
uld
>>>> be fine.
>>>
>>> That is what I did originally, but discussing with Dave he suggested
>>> this solution.
>>
>> Normally I would be fine with the union, to save some memory.
>>
>> Maybe I'm a little paranoid, but the defrag ioctl flag check is only
>> introduced last year by commit 173431b274a9 ("btrfs: defrag: reject
>> unknown flags of btrfs_ioctl_defrag_range_args").
>
> The commit has been backported to stable trees 4.19.307 5.10.210 5.15.14=
9
> 5.4.269 6.1.76 6.6.15 6.7.3 , so we could assume the flags are
> validated.

I know it's backported to all stable kernels, but I still won't consider
a patch that's only one year old to be applied to all the kernels in the
wide.

Maybe I'm really paranoid on this.

>
>> So it's possible that some older kernels don't have that commit, and ma=
y
>> incorrectly continue by ignoring the flag.
>> Thankfully that should fail with -EINVAL (type always in the higher
>> bits, thus always tricking the NR_COMPRESS_TYPES check.
>>
>> If that layout (type in higher bits, level in lower bits) is
>> intentionally, I'd say it's very clever.
>>
>> Anyway either solution looks fine to me now.
>
> The layout also depends on endianness, but should not matter as long as
> the flgags are validated. If not, either the level is ignored or it
> fails due to the >=3D NR_COMPRESS_TYPES check. Both should be acceptable
> as fallback.

Since the fallback behavior is sane, I'm fine with the union solution.

Thanks,
Qu

