Return-Path: <linux-btrfs+bounces-2174-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB57084BEEF
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 21:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6621C2423A
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 20:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AE81B95D;
	Tue,  6 Feb 2024 20:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="or5RYBwt"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619FC1B81D
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Feb 2024 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707252649; cv=none; b=inz6wc9vGdcC1gvSqSmTXJHfUTLe91okgCHTeA8gNS9ucFESnXXmsZXOvzAvRK297XKrVdeViq8xcTBJQFAPwJdQ4M3w6eF8oy604p667aUKcZE2TyDuq0pimRxInOx3BEcBRVAdLTYJWvm7PtueB65PlLjRhyBxfq6gbrvc3Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707252649; c=relaxed/simple;
	bh=hgqnpuZT7rWmC8wy0NirdGAcdsyBDfNA8urWxNVs4TI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lElPf+go1xIJY1rXuQhEFSCesegZABodsVjG7YlVMzz+vS96ojsolUm91DWiTYm4T2d7eA3OvZ8s+MKhvXv5dFoZ01nVhprea9NJ+mN5qo+5RbhDFfiAQjkgExdRp/u/O3glHY17pi1ZoMcxjzfLoNksjlspWUWO9cLTK0dckK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=or5RYBwt; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707252639; x=1707857439; i=quwenruo.btrfs@gmx.com;
	bh=hgqnpuZT7rWmC8wy0NirdGAcdsyBDfNA8urWxNVs4TI=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=or5RYBwtZvi2tUx+zYuNval4zgRmKyi4xHJyhiBtAto5GvzDlw2feSmxFJJkleEu
	 AYPs52cVlfX0fufIOqvnubhSe3vcjm7Z9P5fqiSZ4nvTt7d8rEmRM5Q+FAo/IZIRj
	 My0Nrohq2oH8BrylJVYEojJiwZOGwSCkoeV1yxTHDbhSgycZDyxo+bheNJ3nJT2JE
	 hocvttHm5ROat+K6K7+aNuqRCmSJEvhe80a0geKulC99NG6b95wVfkppqk2gQXm2W
	 KsPYsFYstAxOFoeHpBlTtLatB10ZyqNxTHaZUALSuPly0Av8OMbK3vrsZorLEP+HU
	 8mypQT1tsaZPm+MjdA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([61.245.157.120]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M7K3Y-1rf8Ql01bY-007kBL; Tue, 06
 Feb 2024 21:50:39 +0100
Message-ID: <6f730234-f252-47bb-b52f-3eac960c863e@gmx.com>
Date: Wed, 7 Feb 2024 07:20:36 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: defrag: allow fine-tuning on lone extent
 defrag behavior
Content-Language: en-US
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1707172743.git.wqu@suse.com>
 <1e862826f30ce2de104b66572ddfbfd6e2d398a5.1707172743.git.wqu@suse.com>
 <CAL3q7H5OcYGdoriDdOissUntv1+6orr6-JM2s6HjXDCqNvk6qw@mail.gmail.com>
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
In-Reply-To: <CAL3q7H5OcYGdoriDdOissUntv1+6orr6-JM2s6HjXDCqNvk6qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c35/MMClZDV2c/c62HtfwY/0M+mKP9PhyrsXy7QvKIKDMm6NYK0
 xmo/q8JAVlssOfJRDNLCdByImns/1kjSeD7I7Nreh1Y2aBxbuN4ITwwZYDTfKx1Sv37btKq
 FLGtpf6pcbspexVgFrfms9SDEOeYR/IQlhQR/rPKlUsuNy9TQKVfzCQn4uFct4glusAcGOE
 SNdle95r+KiAqj3//oeKw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:i22ZrJOlA3o=;Y3iDUJ/DGz6K5/+nfk8d5135CGq
 +uZkHYeoakyDTQ67HyFkR2HRCjch4O9tPd5mSCGyU2b8JugAlx0whNUN9hSLPILUv3cGcTzDs
 4Igw7RdZtUqlu67A3i/FKQNlHVzmBJclvFH9RbJRDJxXRCaYWaDCJwL/b41yvvr58rxsTvdNy
 OUk+pYs1CEdd4sujPDqRG9YJ0pPYtbjC4GkK9xU31viLGfApurrJf4BSC5+UyGNQYl+cosq7h
 xQtFxEzmmEE91LTcMq8qIr5wQna1XQR/lIVERBBkzyRk2fJ5TzAXvyLv2ZauYRM2X77rHnRgF
 f9bJtqshz4OQgZTAU5ELuQ062FMXmVK7D7ePyVTL6RBGmleF8pnTAlNUZpqr9MasuqvJfmHI8
 5HDCHMapbCl7EmHGZlqg/nV0xk0cHqQ5ppARvlgevxDBWsM2N1m1XOfoeVLuwLBeLqat8XKes
 lU1HvTO9LSs+Scoexr0x4UZijNlEHpfgEuUOY2b80L4g6OWVy+OMJURUKxgpMxemr3RQLBMGD
 lTSjv37qPimfWzSlR+dFT5hJEC+HCKJ1FLn+lwl7BIsZt9Mqzlf+0wHimNG4TtsTq+Ia0vzUV
 tpsrQZv6j5+XMZVFgs1KCuwETs4wPRIIo6t1WBDEw837m4g3vR496FRmV3R3g6QtxYd3fq2T7
 xbJDAomebzSvWdZSrKnGmrIccyap9CU+cnehhZu84reBFHBZ2HkshhOidJUO4PN2BRJf9oiEq
 /jsRo3e5oHQyqyTTDveP5Hw6wsaMtgFHK4OIjaKVShtF14fldkTrV+k5vYzlVcD6pvUxUaEC6
 PNZDZnUfXctQW0xpi/6bLTGVhJ42tFNpAXzTrGGuiw2eA=



On 2024/2/7 03:33, Filipe Manana wrote:
> On Mon, Feb 5, 2024 at 11:48=E2=80=AFPM Qu Wenruo <wqu@suse.com> wrote:
>>
>> Previously we're using a fixed ratio and fixed bytes for lone extents
>> defragging, which may not fit all situations.
>>
>> This patch would enhance the behavior by allowing fine-tuning using som=
e
>> extra members inside btrfs_ioctl_defrag_range_args.
>>
>> This would introduce two flags and two new members:
>>
>> - BTRFS_DEFRAG_RANGE_LONE_RATIO and BTRFS_DEFRAG_RANGE_LONE_WASTED_BYTE=
S
>>    With these flags set, defrag would consider lone extents with their
>>    utilization ratio and wasted bytes as a defrag condition.
>>
>> - lone_ratio
>>    This is a u32 value, but only [0, 65536] is allowed (still beyond u1=
6
>>    range, thus have to go u32).
>>    0 means disable lone ratio detection.
>>    [1, 65536] means the ratio. If a lone extent is utilizing less than
>>    (lone_ratio / 65536) * on-disk size of an extent, it would be
>>    considered as a defrag target.
>>
>> - lone_wasted_bytes
>>    This is a u32 value.
>>    If we free the lone extent, and can free up to @lone_wasted_bytes
>>    (excluding the extent itself), then it would be considered as a defr=
ag
>>    target.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/defrag.c          | 40 ++++++++++++++++++++++++-------------=
-
>>   fs/btrfs/ioctl.c           |  9 +++++++++
>>   include/uapi/linux/btrfs.h | 28 +++++++++++++++++++++-----
>>   3 files changed, 57 insertions(+), 20 deletions(-)
>>
>> diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
>> index 85c6e45d0cd4..3566845ee3e6 100644
>> --- a/fs/btrfs/defrag.c
>> +++ b/fs/btrfs/defrag.c
>> @@ -958,26 +958,28 @@ struct defrag_target_range {
>>    * any adjacent ones), but we may still want to defrag them, to free =
up
>>    * some space if possible.
>>    */
>> -static bool should_defrag_under_utilized(struct extent_map *em)
>> +static bool should_defrag_under_utilized(struct extent_map *em, u32 lo=
ne_ratio,
>> +                                        u32 lone_wasted_bytes)
>>   {
>>          /*
>>           * Ratio based check.
>>           *
>> -        * If the current extent is only utilizing 1/16 of its on-disk =
size,
>> +        * If the current extent is only utilizing less than
>> +        * (%lone_ratio/65536) of its on-disk size,
>
> I really don't understand what this notation "(%lone_ratio/65536)" means=
...

That means the ratio is between [0, 65536].

0 means disable ratio check, 1 means 1/65536 of the on-disk size and
65536 mean 65536/65536 of the on-disk size (aka, all regular extents
would meet the ratio)

As normally we don't do any float inside kernel, the ratio must be some
unsigned int/long based.

Any better ideas on the description?

>
>>           * it's definitely under-utilized, and defragging it may free =
up
>>           * the whole extent.
>>           */
>> -       if (em->len < em->orig_block_len / 16)
>> +       if (lone_ratio && em->len < em->orig_block_len * lone_ratio / 6=
5536)
>
> Why don't you use SZ_64K everywhere instead of 65536?

Maybe for the ratio, I should use some macro to define the division base.

>
>>                  return true;
>>
>>          /*
>>           * Wasted space based check.
>>           *
>> -        * If we can free up at least 16MiB, then it may be a good idea
>> -        * to defrag.
>> +        * If we can free up at least @lone_wasted_bytes, then it may b=
e a
>> +        * good idea to defrag.
>>           */
>>          if (em->len < em->orig_block_len &&
>> -           em->orig_block_len - em->len > SZ_16M)
>> +           em->orig_block_len - em->len > lone_wasted_bytes)
>
> According to the comment it should be >=3D. So either fix the comment,
> or the comparison.

OK, would change that.

[...]
>> +
>> +       /*
>> +        * If we defrag a lone extent (has no adjacent file extent) can=
 free
>
> Using this term "lone" is confusing for me, and this description also
> suggests it's about a file with only one extent.
> I would call it wasted_ratio, and the other one wasted_bytes, without
> the "lone" in the name.

The "lone" would describe a file extent without non-hole neighbor file
extent, thus I though "lone" would be good enough, but it's not.
>
> Because a case like this:
>
> xfs_io -f -c "pwrite 0 4K" $MNT/foobar
> sync
> xfs_io -c "pwrite 8K 128M" $MNT/foobar
> sync
> xfs_io -c "truncate 16K" $MNT/foobar
> btrfs filesystem defrag $MNT/foobar
>
> There's an adjacent extent, it's simply not mergeable, but we want to
> rewrite the second extent to avoid pinning 128M - 8K of data space.
> A similar example with a next extent that is not mergeable is also
> doable, or examples with previous and next extents that aren't
> mergeable.

Yeah, such extent would always have hole neighbors, just not mergeable.
Thus "lone" is not good enough.

>
> And I still don't get the logic of using 65536... Why not have the
> ratio as an integer between 0 and 99? That's a lot more intuitive
> IMO...

The choose of 65536 is to make the division faster, as regular division
is always slow no matter whatever arch we're one.
"/ 65536" would be optimized by compiler to ">> 4".

But I guess I'm over optimizing here?

Thanks,
Qu

>
> Thanks.
>
>> +        * up more space than this value (in bytes), it would be consid=
ered
>> +        * as a defrag target.
>> +        */
>> +       __u32 lone_wasted_bytes;
>> +
>>          /* spare for later */
>> -       __u32 unused[4];
>> +       __u32 unused[2];
>>   };
>>
>>
>> --
>> 2.43.0
>>
>>
>

