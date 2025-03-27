Return-Path: <linux-btrfs+bounces-12626-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6155CA73F40
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 21:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFAED1666BF
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 20:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9AD1C8FD6;
	Thu, 27 Mar 2025 20:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="IwFkrI76"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4DB28EC
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 20:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743106911; cv=none; b=tUauB5urEyXR7ZqXkwG+I8WFM0eMI8o8UYEiBnOEIxUaBvQOsYQyz198vEzVTe7q6MSLG8S1nRhGjSBJX4+INlLLERnXCt02C93lwR8/bVK9DekHco7u8WwzyemZZ9CXFGxkgWr4C8DxDeorMNW0egnXz2VvpQCA2FJQnmh+e4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743106911; c=relaxed/simple;
	bh=nS6L8muEuA93YjQSqqZ4Z3e5eIbLxTQkNQFAz6SAk9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmmhJt57kbbosMK5hP/BjjlveyoDmDUZwAxHs9cS3mc4FJUYARSYKuLersq0tM+Ah6KhsHEZAXCoWXYptdqR1LG9ZyV3iDy3M/rGuoaXYjwMwijUbTSIFq/FCblbe+TJmqWmZrIAhjsRSv65wvCW1P9rEVtuW5R7Fh7/SCC2MEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=IwFkrI76; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1743106906; x=1743711706; i=quwenruo.btrfs@gmx.com;
	bh=i+JEdJK6y4Ssu4Tc9CM5HE8c+XPYB1QfRZsl17fkl+o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=IwFkrI76YRlxbnyM/j3wFUaswIF9SCAijdx3vCWzQFX7cCuxhuduvnP8Ixoy3b9i
	 ONTfiNWu1Auykhmw77JqbT2tl2jS++M66c5r7snlq+21t89IcGRrS3T3h/3Shm2gM
	 jT4TeATHPLEKmY/Y4Ex51ll4aKDSx21ml2BE9fGMi+f+Y1ctOyp+D5rY3ydy+yhTe
	 RScPMIun6ebJn8Ab1nl8GJ8ea5U3AZrt3a5yjoqDv4peVza33t7krNFlj8EW0xr7C
	 8X6oHuKJ5PyIpdkStyU+sTSJE9kLuAzK7i1rO6ZtZKy2nLpjmpwVdVucO5A83ht/6
	 xqliuNOy43/rdS9brw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3bSt-1syTG505S7-00wwg9; Thu, 27
 Mar 2025 21:21:46 +0100
Message-ID: <b9f7b83d-5efa-4906-9df3-a27f399162fb@gmx.com>
Date: Fri, 28 Mar 2025 06:51:42 +1030
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
 <2b33bf94-ec1d-4825-834d-67f4083ea306@gmx.com>
 <ba2a850f-6697-7555-baa4-32bc6bf62f81@gmx.net>
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
In-Reply-To: <ba2a850f-6697-7555-baa4-32bc6bf62f81@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xfVjMB86GcGnR+warsOthY+gHVufsTQWeJZsHZsXL5dd9GEaktZ
 FnteGoHgO0VQ/cnY23GtuI00/RKOMmd1XkTq0E9Gn7EyhO5iz3ODiTTReQ0eZ7CKak3hi+B
 XesHTRKRQCIgLCOvTiAhAtjhYaxHJ81c9PNI6uV2LTNCATXfSr0cCKwhtZ1Hm1sCQ53pHpe
 W69SOZOb9hm38Udl3MLEA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:J0wMEw5CdM8=;DrALo+/xf+pcBzsgWN+fAv0xv72
 Eayxtcw1etvnN0/tM+FQFMZPKk0Udu0tNEwlQ/OBs/tzygQBLGccEDmtVPdxg1jiYHAGj+EFs
 t7lLuoK2z9dXZguJNs8HCpT+vXnE95m9s+4JXT5sCVCvgOW6e1GsuwVlTuu59TeTGfPC2f34f
 uU0jx+VB2zXVYjX77IgIewY2eBjT+sgT7bg9FhaqovuCzqhqEVjd7iA6hdGsQL3A9ov0TZL2t
 ECn+uPJBxOHUMu/osrrvMk3yreZUvW+P6UZ7Z2guqw7kDhERpT1OiNgfzWzw06Y+jRaIv8JyP
 MiaApsczDoaXpnTbA02sR8DViu6VQtP+zlvm4enn6hLr994/I7X44qML2tiuhkhJtM3qgIO3M
 RZ7nHzesj80GnKQTXYooY8VskHqabfVAKIGog+JtLtHserBby/+67ysMp1JPHK4UJcY/bYOQb
 +C/Rd2RGoH/N0hMS2eDbvrSqaxn9baoZ40f5JZchNxkmjgyHv7gYG+Zy2iQVtGCHd4pYmZ7PX
 oV905bOAUJLSGVigJAKt2zpSoiF2FQQgYwIKBOQrcJOx/byhI2p752BUHNBTUbYBYUdWYouL3
 Z2J1hHmslq/elC+Y7I0Fe4VqitvCD+YaJrspsAZOqTcGNBqfYg/eUN8M+ENyeSnMQ32PNaPa5
 W2y25gFQDfCQJHGmCmGX0iznw5Sw358X9hHF0mynMoec+Lqf9Ba/1l4OhC9jK/f+CDE2KPmsP
 v5oi6Hz/A94Y0Pw2RMUIc0Zlc5xfqQXNFoDFUEqVqeBJyBfAL9SODP6YaBUM8OCwC/fR0hQkn
 1VCUU8r6FZujGQg4oSoMOzzMm+xXJd2Kh+7lkHceNf0w8cIBbwaUYI1sok9XdgBLtyjWHD3Zk
 AT6tiSPQrXXtUYO48UO2tFdr/QmJZjjWugiwav91yOkMaWNyum7ksl07HktgIMR8j+6t3odg3
 2WyqWqfNpWf+VI0JIrpB9/sZdGprxVPK003J4BTZtSEuJIl8m+NXwkp5tpWntU9QhHjVapm4Y
 7Tc4oh4OOR4B4vSxuhOBjzmkmPwRCsYv7e9w9FxlloBdQRMTQ2xDTxqYCBQ7glwy6wEyiV7bl
 h60Xfm3ijHIiKeJeGeDYWjjTs88mU7QIYXBPK5T1g5HuYpKVblo66EUDs9tn7ms2gthm4dkqY
 v3lEjv0vz+vwLgWNINZVqNXAktrj53r25gs7CKdbfCxr9Xw4AXEV508RNakMVfnWxAhLUnzAw
 j/pI1l7n72SbRJ/oJWSOGNCOOwI5Dwx+qFRD3Elg/LWofgPjw/QXqynfNOcsVP7qVn0oeCjnQ
 ipvPFjXL+zMcbIsUfw7QcrpcawkUxbblM80Z+d9XvpkkCQw6eJWHHgkILB6G9QGJNsFEeY8nl
 9cHt1YTJvzgtkXTV2nnT13PgsXNzU2Z1R3jh9zwgQrBsHbDQwCKBrJFGNgUZHR3QKfRhAtOYW
 kJ5xqz94OGf3LaBrdLWhIz8ILhFtNdjpeVKVVfBh+n+RJ20b+ehihFmh3yWdfNcydcTZCiA==



=E5=9C=A8 2025/3/28 00:10, Dimitrios Apostolou =E5=86=99=E9=81=93:
> On Thu, 27 Mar 2025, Qu Wenruo wrote:
>>
>> =E5=9C=A8 2025/3/26 22:45, Dimitrios Apostolou =E5=86=99=E9=81=93:
>>>
>>> =C2=A0Can't the solution/workaround be way more simple, or stupid even=
?
>>>
>>> =C2=A0* Either have fallocate(2) return EOPNOTSUPP on a force-compress
>>> =C2=A0 =C2=A0 filesystem, and leave the work-around to userspace,
>>
>> Unfortunately fallocate has higher priority, not vise-verse.
>>
>> In most cases, compression is a good to have feature, but even with
>> force-compression, we can still have cases that won't be compressed.
>
> Do you know of other cases besides fallocate?

/dev/urandom or something similar, those kind of data will result the
compressed data to be larger than the original, and btrfs will abort
compression no matter the mount option.

>
>>
>> On the other hand, all major upstream fses have support for fallocate,
>> and although I understand preallocation is no longer as simple as
>> non-COW filesystems, not supporting it would still be a big surprise to
>> a lot of user space tools.
>
> I checked what openzfs does, and here is an excerpt from the commit
> message that added support for fallocate:
>
>  =C2=A0 Since ZFS does COW and snapshows, preallocating blocks for a fil=
e
>  =C2=A0 cannot guarantee that writes to the file will not run out of spa=
ce.
>  =C2=A0 Instead, make a best-effort attempt to check that at least enoug=
h
>  =C2=A0 space is currently available in the pool (12% margin), then crea=
te
>  =C2=A0 a sparse file of the requested size and continue on with life.
>
> The whole commit with some discussion is at [1], while a long issue
> discussing alternative is at [2].
>
> [1]=C2=A0 https://github.com/openzfs/zfs/pull/10408
> [2]=C2=A0 https://github.com/openzfs/zfs/issues/326
>
> It could be the solution for btrfs too, to just check if such space plus=
 a
> margin is available and return a sparse file. We lie to userspace about
> guaranteeing that write() can't fail, but as you mentioned, we are alrea=
dy
> lying:

In that case, I'd prefer to return EOPNOTSUPP for fallocate, not even
try to emulate the behavior like ZFS.

At least we have one more fs showing how bad fallocate is on a COW fs.

>
>> Not that easily either. Fallocate itself should mean the next write int=
o
>> the fallocated range will not fail with ENOSPC.
>>
>> Although that assumption itself is no longer correct on btrfs, (e.g.
>> fallocate, then snapshot).
>
> Anyway,
>
>>
>> Although emotionally I agree with you. Fallocation on btrfs is just
>> looking for extra problems, and if I have the final call, I will be mor=
e
>> than happier to nuke fallocation support.
>
>  From a purist's perspective I also find EOPNOTSUPP as the best solution=
.
>
> * Better for the kernel: no complicated workarounds, no lies to userspac=
e
>
> * Better for the application: it gets to know that there are no guarante=
es
>  =C2=A0 on space allocation
>
> * Better for the admin: the files get compressed as the mount options
>  =C2=A0 mandate
>
> The only disadvantage I see is breaking the applications that don't
> implement fallback code to {posix_,}fallocate() returning
> EOPNOTSUPP/EINVAL.
> I have to ask here, is posix_fallocate() mandated by some standard?
> If not, it's an application bug.

Nope, it's not a hard requirement, in fact some older fses (still
supported upstream) are not supporting fallocate at all.

E.g. Ext2 doesn't support fallocate.

But suddenly dropping one feature which we originally support, is a
little concerning.

>
> Maybe the best tradeoff is to add a mount option fallocate=3Doff.

That will be feasible.

I can try push that direction after you have updated the docs.


>
>>
>>>
>>> =C2=A0* or fill up the holes with compressed zeros, basically implemen=
ting
>>> the
>>> =C2=A0 =C2=A0 work-around in kernelspace. I suspect this would be very=
 cheap in a
>>> =C2=A0 =C2=A0 deduplicating filesystem like btrfs, since all the zero-=
filled
>>> =C2=A0 =C2=A0 compressed extents are essentially identical.
>>
>>
>> But doing compressed zeros means we got nothing from the old
>> preallocation behavior, and still waste space on holes.
>
> I might be misunderstanding the terminology. I thought a "hole" is one
> block or extent of zeros. If that's one block referenced (deduplicated)
> multiple times, then there is no space wasted, right? It's just a lie:
> btrfs allocated no space for the hole.

Oh, in that case, a hole really means a hole, there is no space taken on
disk, and all the zero are just filled at read time.

Thus there is no compressed or non-compressed hole, it's really a hole,
void.

And in that case I guess you mean making fallocate fallback to hole
punching (for unallocated range).

Which is still not as good as EOPNOTSUPP IHMO.

Thanks,
Qu

>
>
> Thank you,
> Dimitris

