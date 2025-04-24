Return-Path: <linux-btrfs+bounces-13349-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BE7A99D5A
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 02:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9A4446C85
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 00:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0AE60DCF;
	Thu, 24 Apr 2025 00:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="jhTZJwKC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EBF7F9
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 00:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745456071; cv=none; b=tLce2uDWWgOLEXv9SqV/Uhs2jnXYDfX9DvmHKxeLglAsrJ+zNHnJSCmzvBbnNbj5bZ5Th4kUiV1mZAo4Xa982xCRNCFiTO5frzebd75Ns5Tycy3Zd4/oJ+aX++fmN0m/9dlsBtVj3FZdcKoNAP9ABfyHK3yrY3+cPQw1tNeSDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745456071; c=relaxed/simple;
	bh=mduoo1E7sL7HaG84/Gvagcr8lsnBVwszzAcA9fAeQ9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=In0RnMp3stFPxMzWoA3BNf4mpUTWJgzQRdWCdARNK6gxa7kCpQbHSEku9TEyaFqIfgLP5JHh5SXCGRAQLP6fId3JLHjxnPDXu4X5GT44BWyl1PVtEERAQ3z7QViz+mQukDzxJ1ahEKQ1xGj41xP2mC5cq6D/JgPwSPTukxXvLwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=jhTZJwKC; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1745456066; x=1746060866; i=quwenruo.btrfs@gmx.com;
	bh=IYSVUFBwaGx5GPZM9lceAUDaqQFc186KgE0pM0PpyDc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jhTZJwKCqcsqk+rSFbFY7mbE3uiyyzuKPwk5xgBaP/NVNDz2KNwcxcoLjE2OTVxH
	 bKl+Z8FxbOoxU01oSvHTpOb4gIY+qwE7GZ7oI/Rjw4Fuy55d2/DZhcjfPjjua2J9S
	 bhrfK8DFe55TQPHz9g8MD3EBCtZLGw+ar9zLbEOHtEQ6JshSt9lYLDaIHRSr/vDWn
	 yyWCuJc+e04Ea5bA11p95YUTShtkU4r9aKD9E03u5yZj9go2QUhbpTfLBuggoDST2
	 psa4XND/VYBQqhIId1ZeMcIKQont0qWvUSBNU5OSUVtgjcePQZPTH3JooDqBazrCn
	 xgj83iQQJS0vQFuViw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mg6Zq-1ukfux2T0w-00deGc; Thu, 24
 Apr 2025 02:54:26 +0200
Message-ID: <c01585b5-cca2-47b7-8798-a1ac8fb20de3@gmx.com>
Date: Thu, 24 Apr 2025 10:24:22 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] btrfs: make btrfs_truncate_block() to zero
 involved blocks in a folio
To: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <0bf58569b1f5ea0d7c2e086f07088e9093b274f3.1745443508.git.wqu@suse.com>
 <aAmCU2BDFmEmX0mv@devvm12410.ftw0.facebook.com>
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
In-Reply-To: <aAmCU2BDFmEmX0mv@devvm12410.ftw0.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DoSNDhuouiQm35tml32iImTP30fnAgpATNgVP+QyOLf5csEnQ+8
 Yd+1yIe4b8rLOr6TR/SIUKc9K5OIdsLP2WL+er026uGq19tq94Hw/MM/BSdRk3JbD3MtvVq
 3pL3Oxj3b/h/yoDYG9E/KGrP2ODfd7DI9A7ltovebUA5+obnpQ4L39go4swRxEVZy5BBX+B
 GRN8jaG9rxkSVz8PP+CuA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iEpYuB+OhPE=;Qlvxz4pKRyjtLNHEXkq2DOKplJW
 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
 wMAa2hGCnGUquCuc+6PgZ4=



=E5=9C=A8 2025/4/24 09:44, Boris Burkov =E5=86=99=E9=81=93:
> On Thu, Apr 24, 2025 at 06:56:31AM +0930, Qu Wenruo wrote:
[...]
>> Such behavior is only exposed when page size is larger than fs block
>> btrfs, as for block size =3D=3D page size case the block is exactly one
>> page, and fsx only checks exactly one page at EOF.
>=20
> This wording struck me as a little weird. What fsx does and doesn't
> check shouldn't really matter, compared to the expected/desired behavior
> of the various APIs.

Sure, I'll remove the fsx part.

>=20
> Other than that, very nice debug and thanks for the clear explanation.
>=20
>>
>> [FIX]
>> Enhance btrfs_truncate_block() by:
>>
>> - Force callers to pass a @start/@end combination
>>    So that there will be no 0 length passed in.
>>
>> - Rename the @front parameter to an enum
>>    And make it matches the @start/@end parameter better by using
>>    TRUNCATE_HEAD_BLOCK and TRUNCATE_TAIL_BLOCK instead.
>=20
> Do I understand that you are not just renaming front to an enum, but
> changing the meaning to be selecting a block to do the dirty/writeback
> thing on? That is not really as clear as it could be from the commit
> message/comments.

The original code is hiding the block selection by doing all it by the=20
caller.

E.g. If we have something like this:


     0       4K      8K     12K     16K
     |   |///|///////|//////|///|   |
         2K                     14K

The original code do the truncation by calling with @from =3D 2K, @front =
=3D=20
false, and @from=3D14K, @front =3D true.

But that only handles the block at range [0, 4k) and [12K, 16K), on a=20
64K page, it will not tell exact range we can zero.

If we just zero everything past 2K until page end, then the contents at=20
[14K, 64K) will be zeroed incorrectly.

Thus we need the correct range we're really trunacting, to avoid=20
over/under zeroing.


Normally with the full truncating range passed in, we still need to know=
=20
what exact block we're truncating, because for each range there are=20
always the heading and tailing blocks.



But since you're already mentioning this, it looks like the old @from is=
=20
still a better solution, and since we're already passing the original=20
range into the function, we should be able to detect just based on @from=
=20
and original ranges.

E.g. for above case, if we want to truncate [2k, 4K), we can just pass
@from =3D 2K, @range =3D [2K, 14K).

And if we want to trunacte [12K, 14K), pass @from =3D 14K, range=3D[2K, 14=
K).

>=20
>>
>> - Pass the original unmodified range into btrfs_truncate_block()
>>    There are several call sites inside btrfs_zero_range() and
>>    btrfs_punch_hole() where we pass part of the original range for
>>    truncating.
>=20
> The definition of "original range" is very murky to me. It seems
> specific to the hole punching code (and maybe some of the other
> callsites).

Yes, it's specific to hole punching and zero range, which all modify=20
their internal cursors.

But if we go the above purposal, using the full range to replace @front=20
parameter, it may be a little easier to understand.

>> @@ -2656,8 +2657,9 @@ static int btrfs_punch_hole(struct file *file, lo=
ff_t offset, loff_t len)
>=20
> (not visible in the formatted patch) but there is a comment just above
> this change about how we don't need to truncate past EOF. Can you check
> it and update it if it is wrong now?

Indeed I need to update that part to mention the mmap write cases.

>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 538a9ec86abc..6f910c056819 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -4765,15 +4765,16 @@ static int btrfs_rmdir(struct inode *dir, struc=
t dentry *dentry)
>>    *
>>    * @inode - inode that we're zeroing
>>    * @from - the offset to start zeroing
>> - * @len - the length to zero, 0 to zero the entire range respective to=
 the
>> - *	offset
>=20
> orig_start/orig_end are missing. This adds to the confusion about their
> definition/semantics I mentioned above.
>=20
> More generally, I think this change is a huge change to the semantics of
> this function, which used to operate on only a block but now operates on
> a range. I think that merits a full rewrite of the doc to fully
> represent what the new interface is.

Will do that.


>>  =20
>> -	block_start =3D round_down(from, blocksize);
>> +	if (where =3D=3D BTRFS_TRUNCATE_HEAD_BLOCK)
>> +		block_start =3D round_down(from, blocksize);
>> +	else
>> +		block_start =3D round_down(end, blocksize);
>=20
> I don't think I get why we would want to change which block we are doing
> the cow stuff to, if the main focus is zeroing the full original range.
E.g. We want to truncate range [2K, 6K], it covers two blocks:

        0           2K          4K         6K         8K
        |           |//////////////////////|          |

If we're handling the HEAD block, aka for block [0, 4K), the block start=
=20
should be round_down(2K).

If we're handling the tail block, aka for block [4k, 8k), the block=20
start should be round_down(6K).

The original code move the handling to the caller, but I believe the new=
=20
purposed parameters can handle it a little easier.

>=20
> Apologies if I am being dense on that :)

No worries, that's more or less expected because I already know the new=20
parameters are very ugly, just can not come up a better one at the time=20
of writing.

Thanks,
Qu

