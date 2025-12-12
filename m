Return-Path: <linux-btrfs+bounces-19683-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0377DCB7C3B
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 04:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 577B63066726
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 03:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 463ED2D9485;
	Fri, 12 Dec 2025 03:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="GrAt7gNF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF022D46BB
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 03:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765509373; cv=none; b=tk3IkAxvzJJ0B/5VJgHmivFIyo5ms/YmK/rl5QO8COMASXHQ0fOCe8Ku/Nt/x0UzcvfHeQBL9c4YE2MNggoiyPHBPWcMMZtsiithOJvvwbW+kgcrqSzUo+IRD2v4hr33d55joR5iQm8U9X70ID+RThCIE1WRQpI9+KTUEAYOu/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765509373; c=relaxed/simple;
	bh=er/jQzHQAAH2Kp3/uYFZyecrrBeCViFxV8atYXA7N4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aVcHj0uDPPHt1uQrPyM2reieoA2URw+AwTjxIkS4tsBIFft4nXWLqS3jlPC0yWqkAe9gbVQ5wbxC9ft8Kot7qhtQHAL+LoiiUry24AAoSGWR+d7nYvWLT5W8/6b7vXmb9Mrhm765KoZh4I0YIpBQdX7BR9h8ZVSlZ15S7ldtYwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=GrAt7gNF; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1765509337; x=1766114137; i=quwenruo.btrfs@gmx.com;
	bh=SP6TINnjIjrbUCOJFGmv2cbJt9frXtehST1O0UE8KbA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=GrAt7gNFoI7dvXgfSWv2YmnejZcwGtDv/tFcK5FVYKq9FXcxumou+5YJvvXK5mqU
	 hIq1sB2vSg3HjMyKwhQI6udfjN7YswgT/3DNRogMjjAGsozKSoZilOSx9oJjSglKd
	 KLnj5XVkmzsvlurnQX+2NiHbzaLCUNeZng4XjHoKKtu2k0GgMGzBHZBvrBZxki/4b
	 bkSOkygTl5B+Qdu30bqIWTx82KqOiIr47TSyCl/xPPsz8HNw2Zz3t7yx966Nzzxk+
	 qMHIhqp180ma1cXml/fSzConyj6Xnu9gb0Q5iYQttI4Xn4FDvqVtGDSPJOLYqvxAK
	 K7GfrAuxN6c6xO0qpg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mr9Bu-1vqMgQ3B2c-00fN1U; Fri, 12
 Dec 2025 04:15:37 +0100
Message-ID: <196b64a4-763b-4ced-bbc6-386053a0cd10@gmx.com>
Date: Fri, 12 Dec 2025 13:45:33 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs: add an ASSERT() to catch ordered extents
 without datasum
To: Filipe Manana <fdmanana@kernel.org>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1765418669.git.wqu@suse.com>
 <4d0eff22caa7217a4c1972a755043ee3324c5348.1765418669.git.wqu@suse.com>
 <CAL3q7H7O4dZzjo6tEoUMbkTbj6mJhh+ngM3s=Yudew5a2h0GDQ@mail.gmail.com>
 <CAL3q7H49_x14PMriJxRDxdyCuUqFow0Ytj0O40dvKTMcGfWzjQ@mail.gmail.com>
 <5b3260a8-1a24-4142-82ea-31ac477142ba@gmx.com>
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
In-Reply-To: <5b3260a8-1a24-4142-82ea-31ac477142ba@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oxAd0zgqriAUdrXVo0Lgy30zf0peJou03/DosS7IdF3/TOhErIk
 uK97CRgVI1dfbTzkMq1c/pl2hVngo828QDGzyyqhiFliWeK4l82gSAPykVOamK2OfUEdZZQ
 jbKyrhYCVkkV2FsqxyXqC1Uk5OOsv80zbFco+M/7UmwYCOYC4OvPs0tVVBGGJydQ2LjuWgM
 O6qP/MFJmj1MDd4xTiwnw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gVs4TF6x6RY=;XzruwKKDpEz9DkR+Z2sTy8Y12y0
 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
 qHxQkdhrkI8whDVaw1IZ



=E5=9C=A8 2025/12/12 09:45, Qu Wenruo =E5=86=99=E9=81=93:
>=20
>=20
> =E5=9C=A8 2025/12/12 02:36, Filipe Manana =E5=86=99=E9=81=93:
>> On Thu, Dec 11, 2025 at 11:41=E2=80=AFAM Filipe Manana <fdmanana@kernel=
.org>=20
>> wrote:
>>>
>>> On Thu, Dec 11, 2025 at 2:16=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote=
:
>>>>
>>>> Inside btrfs_finish_one_ordered(), there are only very limited
>>>> situations where the OE has no checksum:
>>>>
>>>> - The OE is completely truncated or error happened
>>>> =C2=A0=C2=A0 In that case no file extent is going to be inserted.
>>>>
>>>> - The inode has NODATASUM flag
>>>>
>>>> - The inode belongs to data reloc tree
>>>>
>>>> Add an ASSERT() using the last two cases, which will help us to catch
>>>> problems described in commit 18de34daa7c6 ("btrfs: truncate ordered
>>>> extent when skipping writeback past i_size"), and prevent future=20
>>>> similar
>>>> cases.
>>>
>>> How exactly does this new assertion catches that case described in=20
>>> that commit?
>>> We had csums there, just not for the whole range of the ordered
>>> extent, just for the range from its start offset to the rounded up
>>> i_size (which is less than the ordered extent's end offset).
>>
>> Rather than checking for the presence of checksums, and if they cover
>> the whole range, the best is to check if we have an ordered range that
>> crosses EOF...
>=20
> Although btrfs_setsize() will also wait for OEs during expansion, I'd=20
> prefer not to get isize involved in btrfs_finish_one_ordered() context.
>=20
> Once i_size is involved, we need extra correctness check to make sure=20
> the value is correct and not racy.
>=20
> I know the current one can not catch the situation that only part of the=
=20
> OE has csum, but I also didn't expect the ASSERT() to catch all situatio=
ns.
>=20
> The current one is good enough to catch most cases on subpage=20
> environment and still safe enough not to cause false alerts.

But on the other hand, if we're adding an ASSERT(), we really want to=20
catch them all, not just some easier to catch cases.

So I'll try to do all the following checks in a dedicated helper instead:

- If inode has NODATASUM, there must be no csum

- No checksum should be there for data reloc inode
   Or it will lead to -EEXIST during csum insertion.

- Csum must match the num_bytes ranges for uncompressed OE

- Csum must match the full disk_num_bytes range for compressed OE
   I'm not 100% sure about this part and will do more testing.

By this we do not need to bother i_size and still catch all cases,=20
including the one in 18de34daa7c6 ("btrfs: truncate ordered extent when=20
skipping writeback past i_size") and the no csum cases in previous patch.

Thanks,
Qu

>=20
> Thanks,
> Qu
>=20
>> Since it's also a bug if we have a nocow ordered extent that crosses EO=
F.
>>
>> Something like this (only compile tested):
>>
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 0cbac085cdaf..76f7eab7a750 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -3139,6 +3139,11 @@ int btrfs_finish_one_ordered(struct
>> btrfs_ordered_extent *ordered_extent)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 goto out;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASSERT(start + logical_len <=3D
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 round_up(i_size_read(&inode->vfs_inode), fs_info-=20
>> >sectorsize),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 "start=3D%llu logical_len=3D%llu i_size=3D%lld sectorsize=3D%u",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 start, logical_len, i_size_read(&inode->vfs_inode),
>> fs_info->sectorsize);
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If it's a COW =
write we need to lock the extent range as we=20
>> will be
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * inserting/repl=
acing file extent items and unpinning an=20
>> extent map.
>>
>>
>>
>>>
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>> =C2=A0 fs/btrfs/inode.c | 15 +++++++++++++++
>>>> =C2=A0 1 file changed, 15 insertions(+)
>>>>
>>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>>> index 461725c8ccd7..740de9436d24 100644
>>>> --- a/fs/btrfs/inode.c
>>>> +++ b/fs/btrfs/inode.c
>>>> @@ -3226,6 +3226,21 @@ int btrfs_finish_one_ordered(struct=20
>>>> btrfs_ordered_extent *ordered_extent)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If we have no data chec=
ksum, either the OE is:
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * - Fully truncated
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 Those ones =
won't reach here.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * - No data checksum
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * - Belongs to data reloc=
 inode
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 Which doesn=
't have csum attached to OE, but cloned
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *=C2=A0=C2=A0 from origin=
al chunk.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (list_empty(&ordered_extent-=
>list))
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ASSERT(inode->flags & BTRFS_INODE_NODATASUM ||
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_is_data=
_reloc_root(inode->root));
>>>
>>> No need to inode->root, we have a local variable with the root already=
.
>>>
>>>> +
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D add_pending_=
csums(trans, &ordered_extent->list);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(ret)) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_abort_transaction(trans, ret);
>>>> --=20
>>>> 2.52.0
>>>>
>>>>
>>
>=20
>=20


