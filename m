Return-Path: <linux-btrfs+bounces-12600-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD622A72702
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 00:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1A9A189CA9E
	for <lists+linux-btrfs@lfdr.de>; Wed, 26 Mar 2025 23:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551501F758F;
	Wed, 26 Mar 2025 23:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="D6yWHn6g"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D64A19644B
	for <linux-btrfs@vger.kernel.org>; Wed, 26 Mar 2025 23:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743031494; cv=none; b=fQ14K1d52wWCUhg3Pgeun2XRTNXhBLYgddsyljB1UU9KlZIhfro/qBH5KjOGv/1+oXcbPuIcTypGaocnjwhIVtVH+ulpDQxsRNPkl1LTHyrDJALLqWUe8Js+OJQf48bzGsOettq9kOIpdV2kkpfV9j8bHnK9BAYgTZHfqjj3sLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743031494; c=relaxed/simple;
	bh=jEePaTOuijbEGgzrLYiGY1pLglhROMNW5wpSMNPxuBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XLdxq2e0Qdhy8QrAXeXNJ6otdnYTmzw8PWFYYHU9R50qRyXTqmzAWqHUlH/vzFH7chNCrT8+rgNAFI9Gs/csUxhMpiTqbJMfpJ+d+uuNWLXeL1zh1RuqvHucz+bDjbbt/i4CtIehT0berbe3AL9UgeYFlqZW0CuOkvIcKJOy5Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=D6yWHn6g; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1743031428; x=1743636228; i=quwenruo.btrfs@gmx.com;
	bh=HQUyVWn+AH6DW0czUwM15AU+AC3bzgjynCLxsj+lY1g=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=D6yWHn6gCHdnskZJ9VcJmVw0XKXqHwb6bQdvot0dZqV+TFl/chEtMDOfT3UyBtKo
	 BljXixCGWyvs05gs1cW1kEmWBR+pFXPhk0kj/4/lGVqPuKDeQEAfD3P+GkDTdbJVl
	 BYhRFu0ZS3/3MsULKPyQwcRiLeqoyfwBmupidB4BcARuDSMcCCMR2JV3l/wiYq6IA
	 KqPHqB2F/UKnRqkBJO++767wjwZSmtKT+YlmbiQhlZMGmF3iTPBrhtezhL2gheI5D
	 xYXJRxRUSud56jRbZ56VLyWjouIr4N3BsWX23CtIV8DqQ+scCl3ZSPB32iSd4leBD
	 F7UmwkF4To+7zUIPVQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Md6Mj-1tP4cq3IYN-00hbbW; Thu, 27
 Mar 2025 00:23:48 +0100
Message-ID: <2b33bf94-ec1d-4825-834d-67f4083ea306@gmx.com>
Date: Thu, 27 Mar 2025 09:53:44 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mount compress=zstd leaves files uncompressed, that used to
 compress well with before
To: Dimitrios Apostolou <jimis@gmx.net>
Cc: Gerhard Wiesinger <lists@wiesinger.com>, linux-btrfs@vger.kernel.org
References: <2f70d8f3-2a68-1498-a6ce-63a11f3520e3@gmx.net>
 <d1c2f041-f4f5-9dad-511c-117ed8704565@gmx.net>
 <8aaba46c-f6d5-4f3a-a029-f564b8a6a9ff@wiesinger.com>
 <2858a386-0e8c-51a6-0d8a-ace78eced584@gmx.net>
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
In-Reply-To: <2858a386-0e8c-51a6-0d8a-ace78eced584@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RhmZWMwfbYiFUyTrYLgeauboWuYBZz6MlQN+tl+4ZvWgzrWDqS/
 u4DyIVSA8M1ZbFpM/++zHIuGdbAkNYKZXhhZRbT9jXta8MCUh3R3UlQ4tdeWoQfGbFFoshI
 FTAurYXaauokrQONkZ6Ov6I50CEnvQzQQYzYWq4V5uzRvA9Wl7bOehKQT4zeVa0G84rTloB
 nKF+IIGNyJ/1WV0fgbjqA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:u5B+osIkEk8=;SVE/2ZkiCMT19hFMTpHB1LW9jS5
 6xgdvqENtrsakUjBIMTuVuq34+3erqDGOlIRPaQI/TQTkvxHLvlipdUhp7mPPuzUsyIacZ2hu
 xrHyzMFKPXEQN1fZ9Bdfk/aRl01zEO/vbPvt2r2ngy9VBWfDiV4WlSiMLuDiK6LPK32y+aAOK
 FVzVxx8bfkAuu1IOhYwqwnuLWD++QCttbkmjjid10rbdHyC/4Wcx3U57OaOUkXFfzyUZ/qrDa
 C08pj3UcEAWmgdU+17UdcWWxAnI8tyopBX9FMe8SXE4ujcwXyEgEn+bUn2xr8f9//92p+LH9B
 vWXbzUgJJeYBcnwz3EuRAFVY8PqCuXIGOPyrxxqpWLDiUB3+Z7T+rAcxltHzOwfDhdi8HvGiD
 E/PQyRWb2sB0DUArZJkTbPHV5tH21c82RriNQHdrdwZngBIpZCwy8O9TNTzAxJFlNcq0xlF0z
 RpBnbrg1ptc43/LjtuPcPyxuZGQhySd/1qHQC9W4oQfjDcTR0f0VfxTcnFkYM51Y+9K0vC4LF
 YlC3lHL3dZkJQvX+sel1sfykGXRinWrTb06egb6TyClxdBAf3NGZbzjkDiKtiz4dkRjkLus7I
 /Jlngt5/LcDBrMCehm7gtimB3fGx5/TEKGUs9GeOFef+2oz4/snbbA35h3FPc7sBj0D1yqIrO
 mJiMZIxAEPP7YwQxvFSHnTfnfbRTrtI98z2kH7ULpAVa+TsAmVfeNI+L61baqQbNVTnPADO/s
 9qL3zDjpKikCov49IJQlmPnhNm1mV14bi6nQwpeBLqJAO+nLDq2/5CUT4on7RkfHTaPsIO8fs
 MxZ2xyAy0Rjxam64Qv4TQRa54946RrT28rudlvjATHEVa0lmhqz63HDklcY2dTjVsBbN2xzK7
 1kj7pZLGRhhr+SbglyeD4RgeZNjeLGlHWEAYqOPkSgcazKwrzWEBj2KNgb9oWepX2a0JRRbtc
 qwI16v5I5DT8tnAJo5oT76zQaNqEPspE4/bawaslKKFScLxgisdXp2kxkqd2c7SqxXbydkIc1
 GLLLKpp2xqkWnbAJ86ijkBY7AzXB3RsHnWGJhyPnImpyeI8MycFIMTPXAU6xNzaIOd/C3RvP5
 lYPuOuRPKUAQzS2oTsOYV1SxZ1w1P6suk0SqIymi7S4VhA71RznGaXAt95hLw8EvdmMLhNIWz
 TuK83c7TB/Au9l1w0QpY5jJpMJd8IX8MMYOg5PNuyGDVnq8C/hc2NgX8iW/Id/yd7QdqoJp4G
 I0wWnqe8pvDPNVFrvpHnZDw8noNKRgJmVPEO7VL5Y2q8x7rYMzembIi0FO8K1NPnbBYmR79iz
 a1I1MISJSUSHlGSkgUzG6MZ35MEASXy2RjLHP/NycQdhlMzwW3VPvviJ6alfbB/qxL5NhHIzd
 DRm5G2ZIiQ8DoT9uDkfmPmK2KQ4l5bpsGwl+xww3pnz+W9+rgOmkz4uUT+jwp9SwC2+LU07ZF
 kXLqa2cx3FY523+lRpo+P5TYAfxPG9VqUlJdMyYOxlxoZZpNH



=E5=9C=A8 2025/3/26 22:45, Dimitrios Apostolou =E5=86=99=E9=81=93:
> CC'ing Qu Wenruo from this thread
>
> On Mon, 24 Mar 2025, Gerhard Wiesinger wrote:
>>
>> It's a known bug I also ran into, see the disucssion here:
>> https://lore.kernel.org/all/b7995589-35a4-4595-
>> baea-1dcdf1011d68@wiesinger.com/T/
>> (It can't be easily fixed)
>
> Hi Qu, reading this thread I understand that posix_fallocate() ends up
> leaving files uncompressed forever in btrfs, regardless of mount options=
.
> I see this in PostgreSQL that recently started using posix_fallocate().
>
> You gave some information on why the solution is hard:
>> There is a long existing problem with compression with preallocation.
>>
>> One easy example is, if we go compression for the preallocated range,
>> what we do with the gap (compressed size is always smaller than the rea=
l
>> size).
>>
>> If we leave the gap, then the read performance can be even worse, as no=
w
>> we have to read several small extents with gaps between them, vs a larg=
e
>> contig read.
>
> Can't the solution/workaround be way more simple, or stupid even?
>
> * Either have fallocate(2) return EOPNOTSUPP on a force-compress
>  =C2=A0 filesystem, and leave the work-around to userspace,

Unfortunately fallocate has higher priority, not vise-verse.

In most cases, compression is a good to have feature, but even with
force-compression, we can still have cases that won't be compressed.

On the other hand, all major upstream fses have support for fallocate,
and although I understand preallocation is no longer as simple as
non-COW filesystems, not supporting it would still be a big surprise to
a lot of user space tools.

Although emotionally I agree with you. Fallocation on btrfs is just
looking for extra problems, and if I have the final call, I will be more
than happier to nuke fallocation support.

>
> * or fill up the holes with compressed zeros, basically implementing the
>  =C2=A0 work-around in kernelspace. I suspect this would be very cheap i=
n a
>  =C2=A0 deduplicating filesystem like btrfs, since all the zero-filled
>  =C2=A0 compressed extents are essentially identical.

Not that easily either. Fallocate itself should mean the next write into
the fallocated range will not fail with ENOSPC.

Although that assumption itself is no longer correct on btrfs, (e.g.
fallocate, then snapshot).

But doing compressed zeros means we got nothing from the old
preallocation behavior, and still waste space on holes.

>
>
> In any case, I think this should be documented in the btrfs documentatio=
n
> about compression, [1] it would have saved me time. I can try to submit =
a
> patch if you point me to the docs repo. Any other known cases where
> compression is unexpectedly skipped?

The document repo is btrfs-progs:

https://github.com/kdave/btrfs-progs

You can either submit regular email patches to this ml, or submit a
github PR.

Thanks,
Qu

>
> [1] https://btrfs.readthedocs.io/en/latest/Compression.html
>
>
> Thank you in advance,
> Dimitris
>


