Return-Path: <linux-btrfs+bounces-16252-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98885B30863
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 23:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 104815E7FF4
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Aug 2025 21:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F557274FDB;
	Thu, 21 Aug 2025 21:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="oHw8Rdj6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD2025CC73
	for <linux-btrfs@vger.kernel.org>; Thu, 21 Aug 2025 21:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755811835; cv=none; b=Fzd4IudgF//+68IcYWeugslV4kczmkl08coDw7xy2+a1DXPcdjkEq9pdDxX0/I64rPeghag6eE3PwY6HRlZv9li3Lonu2j4jju4KKnnno/XYWK8CRVM5f3QVhnu/lClB9kK5XwPX4SYiqDHG7teOKZpNUzm0An+w8l78oseu1PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755811835; c=relaxed/simple;
	bh=89hhiI4glfKuqcRCI9F+FxWzHs08dlvDoCVJMfoFBnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BdnHcKejSFwxWXRhXUp1CCZ67OZ6zDqc3G6thEB+GheXzZJgkfDQkCsUwpyJHIPBo13kpNsqLVWbtFpMvAkiedydYSMyTicBVXynB+hOOFqil+Kgj4A2HEArAIPuTb5ju225daR4/UZQis4AwOjBhxcCNb0Tv4+9+EeG+TI8CFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=oHw8Rdj6; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1755811830; x=1756416630; i=quwenruo.btrfs@gmx.com;
	bh=xwGGAQKKYszFC91WqzA6Rtknylh1pqe/yMt/M5a5M3k=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=oHw8Rdj6G7lpM5HSu/hx/+QItgiy4nG3LC4Q+iZP9rav3mukGYOh23ORZ/d/Q2/R
	 cGo/sKexiVjFwrN1LuKB+9mhTVV6tAA365DI7kbFLiI739hFxHRXL61O8RBczcpHe
	 qMpFiYzLr+/O8HoJXxcfxanNFvGHC8j3JS7EZIT5tss7aGZAfceD2IyQK7rOfYIpz
	 8W0VxSoobPXRbA4eghki47qZ2ofOaIlAA5/8W367HzvaP9JP4nzaOvsvOhxfMhYvX
	 v6Z+ZXeausHzkhigqWfG958wfqSGp9x4xOJgznJtxFQuAi9SnKL6WctEM0rd3iSyU
	 4SLHdDx6r+tZyED1bQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N63RQ-1uVNgU0RZI-00vztU; Thu, 21
 Aug 2025 23:30:30 +0200
Message-ID: <43cb9a24-cac3-4dfc-9a7c-ed881e5c7b59@gmx.com>
Date: Fri, 22 Aug 2025 07:00:27 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3] btrfs: extract the compressed folio padding into a
 helper
To: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <81ac4ae4bab2538df93f045ac1094d3568ff8e9e.1755754005.git.wqu@suse.com>
 <20250821173754.GB84947@zen.localdomain>
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
In-Reply-To: <20250821173754.GB84947@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sjhC8q2A884cHXC6+hiDYc03SqMSt4Wr1OEQW5DuzQq9p5QTnrw
 kwbRJv8QeE56XBMpO1DstmqFsYgl9AcOZYxzvNRE8VddsgOESzau2qRGwMnJWPmDa4b4IAB
 kRuMtSDY/q9viHFI8x9VUBBVWz1NhM5GlnbBgkgZAjaVruE81cQnaBl1X6wtIeS67dl11/P
 iTeQZww+u5qKdHt1W+aUA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4Px1UP3GXr4=;NqLwWZ9XiRf6kZZU3meswucNl+J
 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



=E5=9C=A8 2025/8/22 03:07, Boris Burkov =E5=86=99=E9=81=93:
[...]
>>
>> Reason for RFC:
>>
>> Although this seems to be a preparation patch for bs > ps support, this
>> one will determine the path we go for compressed folios.
>>
>> There are 2 methods I can come up with:
>>
>> - Allocate dedicated large folios following min_order for compressed
>>    folios
>>    This is the more common method, used by filemap and will be the meth=
od
>>    for page cache.
>=20
> What is the fallback if the min_order allocation fails? Just fail, since
> that's what "min" means?

Yes.

Although if we're already at the min_order, alloc_gfp will retry and=20
warn about the allocation failure.

>=20
>>
>>    The problem is, we will no longer share the compr_pool across all
>>    btrfs filesystems, and the dedicated per-fs pool will have a much
>>    harder time to fill its pool when memory is fragmented or
>>    under-pressure.
>=20
> I'm curious if you have any data or workloads showing this, or if it is
> just a reasonable logical speculation.

Just my speculation. Although considering other fses like XFS and=20
bcachefs are already supporting bs > ps using this method, it may not be=
=20
that a huge problem.

>=20
>>
>>    The benefit is obvious, we will have the insurance that every folio
>>    will contain at least one block for bs > ps cases.
>>
>> - Allocate page sized folios but add extra padding folios for compresse=
d
>>    folios
>>    The method I take in this patchset.
>=20
> Assuming we don't want to straight up fail if we aren't able to allocate
> a 128k contiguous folio, we will need this fallback anyway, so I think I
> support this approach that you have already taken.

We will never allocate a large folio with 128K size. As our supported=20
block sizes end at 64K as the upper limit.

But it will still be a pretty large folio anyway.

>=20
>>
>>    The benefit is we can still use the shared compr folios pool, meanin=
g
>>    a better latency filling the pool.
>>
>>    The problem is we must manually pad the compressed folios.
>>    Thankfully the compressed folios are not filemap ones, we don't need
>>    to bother about the folio flags at all.
>>
>>    Another problem is, we will have different handling for filemap and
>>    compressed folios.
>>    Filemap folios will have the min_order insurance, but not for
>>    compressed folios.
>>    I believe the inconsistency is still manageable, at least for now.
>>
>> Thus I leave this one as RFC, any feedback will be appreciated.
>> ---
>>   fs/btrfs/compression.c | 42 +++++++++++++++++++++++++++++++++++++++++=
-
>>   fs/btrfs/inode.c       |  9 ---------
>>   2 files changed, 41 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
>> index 3291d1ff2722..9cd9182684f3 100644
>> --- a/fs/btrfs/compression.c
>> +++ b/fs/btrfs/compression.c
>> @@ -1024,6 +1024,43 @@ int btrfs_compress_filemap_get_folio(struct addr=
ess_space *mapping, u64 start,
>>   	return 0;
>>   }
>>  =20
>> +/*
>> + * Fill the range between (total_out, round_up(total_out, blocksize)) =
with zero.
>> + *
>> + * If bs > ps, also allocate extra folios to ensure the compressed fol=
ios are aligned
>> + * to block size.
>> + */
>> +static int pad_compressed_folios(struct btrfs_fs_info *fs_info, struct=
 folio **folios,
>> +				 unsigned long orig_len,  unsigned long *out_folios,
>> +				 unsigned long *total_out)
>> +{
>> +	const unsigned long aligned_len =3D round_up(*total_out, fs_info->sec=
torsize);
>> +	const unsigned long aligned_nr_folios =3D aligned_len >> PAGE_SHIFT;
>> +
>> +	ASSERT(aligned_nr_folios <=3D BTRFS_MAX_COMPRESSED_PAGES);
>> +	ASSERT(*out_folios =3D=3D DIV_ROUND_UP_POW2(*total_out, PAGE_SIZE),
>> +	       "out_folios=3D%lu total_out=3D%lu", *out_folios, *total_out);
>=20
> I guess you could avoid the division if you make a different condition
> for aligned vs unaligned (and thus use bit shift). I think it's fine,
> though, just mentioning.

Yep, I had an internal version doing round_up() then right shift.
I can definitely switch back to that version.

Thanks,
Qu

>=20
>> +
>> +	/* Zero the tailing part of the compressed folio. */
>> +	if (!IS_ALIGNED(*total_out, PAGE_SIZE))
>> +		folio_zero_range(folios[*total_out >> PAGE_SHIFT], offset_in_page(*t=
otal_out),
>> +				PAGE_SIZE - offset_in_page(*total_out));
>> +
>> +	/* Padding the compressed folios to blocksize. */
>> +	for (unsigned long cur =3D *out_folios; cur < aligned_nr_folios; cur+=
+) {
>> +		struct folio *folio;
>> +
>> +		ASSERT(folios[cur] =3D=3D NULL);
>> +		folio =3D btrfs_alloc_compr_folio();
>> +		if (!folio)
>> +			return -ENOMEM;
>> +		folios[cur] =3D folio;
>> +		folio_zero_range(folio, 0, PAGE_SIZE);
>> +		(*out_folios)++;
>> +	}
>> +	return 0;
>> +}
>> +
>>   /*
>>    * Given an address space and start and length, compress the bytes in=
to @pages
>>    * that are allocated on demand.
>> @@ -1033,7 +1070,7 @@ int btrfs_compress_filemap_get_folio(struct addre=
ss_space *mapping, u64 start,
>>    * - compression algo are 0-3
>>    * - the level are bits 4-7
>>    *
>> - * @out_pages is an in/out parameter, holds maximum number of pages to=
 allocate
>> + * @out_folios is an in/out parameter, holds maximum number of pages t=
o allocate
>>    * and returns number of actually allocated pages
>>    *
>>    * @total_in is used to return the number of bytes actually read.  It
>> @@ -1060,6 +1097,9 @@ int btrfs_compress_folios(unsigned int type, int =
level, struct btrfs_inode *inod
>>   	/* The total read-in bytes should be no larger than the input. */
>>   	ASSERT(*total_in <=3D orig_len);
>>   	put_workspace(fs_info, type, workspace);
>> +	if (ret < 0)
>> +		return ret;
>> +	ret =3D pad_compressed_folios(fs_info, folios, orig_len, out_folios, =
total_out);
>>   	return ret;
>>   }
>>  =20
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 0161e1aee96f..b04f48af721a 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -864,7 +864,6 @@ static void compress_file_range(struct btrfs_work *=
work)
>>   	unsigned long nr_folios;
>>   	unsigned long total_compressed =3D 0;
>>   	unsigned long total_in =3D 0;
>> -	unsigned int poff;
>>   	int i;
>>   	int compress_type =3D fs_info->compress_type;
>>   	int compress_level =3D fs_info->compress_level;
>> @@ -964,14 +963,6 @@ static void compress_file_range(struct btrfs_work =
*work)
>>   	if (ret)
>>   		goto mark_incompressible;
>>  =20
>> -	/*
>> -	 * Zero the tail end of the last page, as we might be sending it down
>> -	 * to disk.
>> -	 */
>> -	poff =3D offset_in_page(total_compressed);
>> -	if (poff)
>> -		folio_zero_range(folios[nr_folios - 1], poff, PAGE_SIZE - poff);
>> -
>>   	/*
>>   	 * Try to create an inline extent.
>>   	 *
>> --=20
>> 2.50.1
>>
>=20


