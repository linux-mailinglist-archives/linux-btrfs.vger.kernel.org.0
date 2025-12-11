Return-Path: <linux-btrfs+bounces-19675-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC18CB7581
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 00:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B1A5301459C
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 23:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD61A296BC5;
	Thu, 11 Dec 2025 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="mQ6lddEE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F961C84D7
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 23:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765494933; cv=none; b=Q5L3qygpvcgneMHud+SB5UVUWRqsNUYllY8DLXFB86vprg6hF/eCq/HzGvEVUEtDPRWxa0yxHzb7pP0Cj37dubyxWP9srnXl1UXod9qFPsurqbAvHON/nnOu+V1Zsk1/sdxOeK6VboPSLjLRf1BwOPoKgQflBxB8ZH9R+G18jFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765494933; c=relaxed/simple;
	bh=CNd4/Jt28avfKuFaa8eAkZOvlcGr4wzwtpGOG+HlRCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BT7Fm3HWVIehOQTEx02Sk3+UfdREYs9KcdD2OgF5mYJaM//dgjuyIy/wTdV8Np60oiQt2i0/tqqfLmAMx3VRttiPWIT6EIjf9FG3WXvxVG3xvxAuG26ykTEHxlIFulenAox1U/ddhcEPFP8mPJAPuXYIptFGwtIoWKpea3UyBdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=mQ6lddEE; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1765494925; x=1766099725; i=quwenruo.btrfs@gmx.com;
	bh=VgJXIR5RC4g1ltKx/SGFVpVQCxNzCkbHhruXicmIZjQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mQ6lddEEomyjmvo/5dIj2qupaTzmvEOrB+E1TzjjIgJRxs7MpQ4uSJDVQMKYDzYj
	 ds9p632Vuqk+eZAx8d0zkgAqIs62PyVZzw0RqrimR/NcTiwihl/bQthiR9wQYO3EZ
	 vVDlZhcZzDvzPNvuAMQKloOZKjGPpTzrNMNUoGvSp821y0ocuzXrq2aKKEr92wiKs
	 P97JA1r0ZeT0yTSidFxiybzq3mJSc6qDpmASnoTZLwXdSvDL/uWKihpfBOmaHaije
	 Ce6pjPXnrKfJ9lmXFKqIvV1OOHQRij7wO0727XiIeQDnE7QLAsecRiC/rsdige4p6
	 OL7DCeUcUeHn8U8YtA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MHoRA-1vHD6g24LW-007Flu; Fri, 12
 Dec 2025 00:15:24 +0100
Message-ID: <5b3260a8-1a24-4142-82ea-31ac477142ba@gmx.com>
Date: Fri, 12 Dec 2025 09:45:22 +1030
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
In-Reply-To: <CAL3q7H49_x14PMriJxRDxdyCuUqFow0Ytj0O40dvKTMcGfWzjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+kiF0m2qVZeBDXBReE6IdTE3z07SYR0mt78Tw1QfFAF+NBOpHJs
 Oh7DHl+vt0wq/F/RvmDvtUjF/zwSl5gqk+dE6TdU1Qs1a68U4FilrQlLkl8P3JvEzzjjS3Z
 JMyTCcaCGjDLqzOWZKzzWHwKMi4u9mJrmlfdp/aAfXMXEMp3zkaxuV8u9bAqDklcqtEO8M0
 3L1CMeUu9vndj4ZVGcISA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AixASc/dfoA=;GbZh7hMA2iy21LGvpBIH9JJNjtz
 +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
 ay5dFzgMwEZTxdWCCdRNgV5TYs/kU



=E5=9C=A8 2025/12/12 02:36, Filipe Manana =E5=86=99=E9=81=93:
> On Thu, Dec 11, 2025 at 11:41=E2=80=AFAM Filipe Manana <fdmanana@kernel.=
org> wrote:
>>
>> On Thu, Dec 11, 2025 at 2:16=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
>>>
>>> Inside btrfs_finish_one_ordered(), there are only very limited
>>> situations where the OE has no checksum:
>>>
>>> - The OE is completely truncated or error happened
>>>    In that case no file extent is going to be inserted.
>>>
>>> - The inode has NODATASUM flag
>>>
>>> - The inode belongs to data reloc tree
>>>
>>> Add an ASSERT() using the last two cases, which will help us to catch
>>> problems described in commit 18de34daa7c6 ("btrfs: truncate ordered
>>> extent when skipping writeback past i_size"), and prevent future simil=
ar
>>> cases.
>>
>> How exactly does this new assertion catches that case described in that=
 commit?
>> We had csums there, just not for the whole range of the ordered
>> extent, just for the range from its start offset to the rounded up
>> i_size (which is less than the ordered extent's end offset).
>=20
> Rather than checking for the presence of checksums, and if they cover
> the whole range, the best is to check if we have an ordered range that
> crosses EOF...

Although btrfs_setsize() will also wait for OEs during expansion, I'd=20
prefer not to get isize involved in btrfs_finish_one_ordered() context.

Once i_size is involved, we need extra correctness check to make sure=20
the value is correct and not racy.

I know the current one can not catch the situation that only part of the=
=20
OE has csum, but I also didn't expect the ASSERT() to catch all situations=
.

The current one is good enough to catch most cases on subpage=20
environment and still safe enough not to cause false alerts.

Thanks,
Qu

> Since it's also a bug if we have a nocow ordered extent that crosses EOF=
.
>=20
> Something like this (only compile tested):
>=20
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 0cbac085cdaf..76f7eab7a750 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3139,6 +3139,11 @@ int btrfs_finish_one_ordered(struct
> btrfs_ordered_extent *ordered_extent)
>                          goto out;
>          }
>=20
> +       ASSERT(start + logical_len <=3D
> +              round_up(i_size_read(&inode->vfs_inode), fs_info->sectors=
ize),
> +              "start=3D%llu logical_len=3D%llu i_size=3D%lld sectorsize=
=3D%u",
> +              start, logical_len, i_size_read(&inode->vfs_inode),
> fs_info->sectorsize);
> +
>          /*
>           * If it's a COW write we need to lock the extent range as we w=
ill be
>           * inserting/replacing file extent items and unpinning an exten=
t map.
>=20
>=20
>=20
>>
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>>   fs/btrfs/inode.c | 15 +++++++++++++++
>>>   1 file changed, 15 insertions(+)
>>>
>>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>>> index 461725c8ccd7..740de9436d24 100644
>>> --- a/fs/btrfs/inode.c
>>> +++ b/fs/btrfs/inode.c
>>> @@ -3226,6 +3226,21 @@ int btrfs_finish_one_ordered(struct btrfs_order=
ed_extent *ordered_extent)
>>>                  goto out;
>>>          }
>>>
>>> +       /*
>>> +        * If we have no data checksum, either the OE is:
>>> +        * - Fully truncated
>>> +        *   Those ones won't reach here.
>>> +        *
>>> +        * - No data checksum
>>> +        *
>>> +        * - Belongs to data reloc inode
>>> +        *   Which doesn't have csum attached to OE, but cloned
>>> +        *   from original chunk.
>>> +        */
>>> +       if (list_empty(&ordered_extent->list))
>>> +               ASSERT(inode->flags & BTRFS_INODE_NODATASUM ||
>>> +                      btrfs_is_data_reloc_root(inode->root));
>>
>> No need to inode->root, we have a local variable with the root already.
>>
>>> +
>>>          ret =3D add_pending_csums(trans, &ordered_extent->list);
>>>          if (unlikely(ret)) {
>>>                  btrfs_abort_transaction(trans, ret);
>>> --
>>> 2.52.0
>>>
>>>
>=20


