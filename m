Return-Path: <linux-btrfs+bounces-13350-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A62A99D6E
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 02:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAAD319467C6
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Apr 2025 00:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4FE6A8D2;
	Thu, 24 Apr 2025 00:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="pbKYIFS0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACD17F9
	for <linux-btrfs@vger.kernel.org>; Thu, 24 Apr 2025 00:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745456199; cv=none; b=WBF+dI1SGgDKiRHnzz9ChhMXH2QjvDlvWetBkuvqhubzCVX+t3k3OxnbnbsS/X1KH4LYZ35biz8yaSrJkoVw+CY3Su87+gtlcKaYz+tL0lG8xlWJql4ABKULepOll2bEKiENr8jr7AZXJp8yPy1m5WJD054iEK1arf3Z1ZVLZUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745456199; c=relaxed/simple;
	bh=H5UUSTRcIt4omKSiXibAejrMpWRo5q2nAIBpEg8D7WA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJXxeAW8HyVryGV6wEl1TPkfPbrY2vlAsi4kjw0cK6kQq0lXmiINryZ3fT2f5AY1016Si2Irr56pNRJVqHdQvsrBlfgnkRfl7z43MVIgeC9nYdzwJuzzeR4thCF1OAkgM1u3snKjEB6Ft/jUXXYOnxwF3K2Jh+vBX4ckAIc6O1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=pbKYIFS0; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1745456194; x=1746060994; i=quwenruo.btrfs@gmx.com;
	bh=pCC23PBQJAHQql9KZ38kE+UXzUHeNg39BpsbYICkxJ4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pbKYIFS0BiWRJoGhTYwHgJhWVCZpbOJRtFN9KrXx2ys7Qg4kHhWNKcXECmupswYt
	 v6g/KoCBHcTqEhUnW6YP0HH4/ypuMe2/F/wWpAc4tJ92St2qY5z3rW0bqqBQKr1Zo
	 RwtavY1w/RcDa1pOLmEjIj7bM3focnYrQ9sy8qQ2t1DCymm/iDFjhDeNjlZuCF+0z
	 WkKZX/BdxRxbPZfobWzC8GYU37jqJLzW7aaZvrVmNu8thOie4HAmonR2UdiCCBhrZ
	 0Av5IUf56mfpCTpNtzOmZ2v+RibJ0VwTz3DRAfvnGRq/2eYh5l/gw2hGL+p2KD7vO
	 FM2ANoZbT5uIjIBR0g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MwQTF-1uzIyz3MZB-00vQfB; Thu, 24
 Apr 2025 02:56:34 +0200
Message-ID: <49198456-c710-4a48-adaf-6d0b5267c3c1@gmx.com>
Date: Thu, 24 Apr 2025 10:26:28 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] btrfs: make btrfs_truncate_block() zero folio
 range for certain subpage corner cases
To: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <50e41f048f26b5b58f55b25c045e5dfe94a8dcfd.1745443508.git.wqu@suse.com>
 <aAmFYrptBXjufdg5@devvm12410.ftw0.facebook.com>
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
In-Reply-To: <aAmFYrptBXjufdg5@devvm12410.ftw0.facebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c0i07REd60VFdCGumP/15k/pcyjGL+ETeGYHn+4ZHFq6hK+/URU
 /or2K7dsIAbLOnfU/u4xQRrm1LM8iFEX+Ek7SKAo9k+DCob6uTv9QQ7TRchjOO4oyUTe7L8
 fZnjs1R19+Dhwh6nWZAWi30AgPmw/UIrVvRYarcBKft2EtlwgQAXKyz7JnuqA+X+KLYotCf
 d7wRiDdFFunTobGjuim6A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4vamcwor+wo=;oWZXgtGaD4mQKJ9JrevmT0ulbxI
 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
 n59wicBKYSkIA=



=E5=9C=A8 2025/4/24 09:57, Boris Burkov =E5=86=99=E9=81=93:
> On Thu, Apr 24, 2025 at 06:56:32AM +0930, Qu Wenruo wrote:
[...]
>> +/*
>> + * A helper to zero out all blocks inside range [@orig_start, @orig_en=
d) of
>> + * the target folio.
>> + * The target folio is the one containing the head or tail block of th=
e range
>> + * [@from, @end].
>> + *
>> + * This is a special case for fs block size < page size, where even if=
 the range
>> + * [from, end] is already block aligned, we can still have blocks beyo=
nd EOF being
>> + * polluted by memory mapped write.
>> + */
>=20
> This function name is basically the same as folio_zero_range which
> behaves very differently. I think it needs a name that captures the fact
> that it is a special case for btrfs_truncate_block

What about btrfs_truncate_block_zero_range()?

[...]
>> +	folio_wait_writeback(folio);
>=20
> This lock/read/wait pattern is the same as in btrfs_truncate_block and I
> think could benefit from being lifted into a function.

Sure, will do that.

>=20
>> +
>> +	clamp_start =3D max_t(u64, folio_pos(folio), orig_start);
>> +	clamp_end =3D min_t(u64, folio_pos(folio) + folio_size(folio) - 1,
>> +			  orig_end);
>> +	block_start =3D round_down(clamp_start, blocksize);
>> +	block_end =3D round_up(clamp_end + 1, blocksize) - 1;
>> +	lock_extent(io_tree, block_start, block_end, &cached_state);
>> +	ordered =3D btrfs_lookup_ordered_range(inode, block_start, block_end =
+ 1 - block_end);
>> +	if (ordered) {
>> +		unlock_extent(io_tree, block_start, block_end, &cached_state);
>> +		folio_unlock(folio);
>> +		folio_put(folio);
>> +		btrfs_start_ordered_extent(ordered);
>> +		btrfs_put_ordered_extent(ordered);
>> +		goto again;
>> +	}
>> +	folio_zero_range(folio, clamp_start - folio_pos(folio),
>> +			 clamp_end - clamp_start + 1);
>> +	unlock_extent(io_tree, block_start, block_end, &cached_state);
>> +
>> +out_unlock:
>> +	folio_unlock(folio);
>> +	folio_put(folio);
>> +	return ret;
>> +}
>> +
>>   /*
>>    * Read, zero a chunk and write a block.
>>    *
>> @@ -4801,8 +4875,20 @@ int btrfs_truncate_block(struct btrfs_inode *ino=
de, loff_t from, loff_t end,
>>   	if (end =3D=3D (loff_t)-1)
>>   		ASSERT(where =3D=3D BTRFS_TRUNCATE_HEAD_BLOCK);
>>  =20
>> -	if (IS_ALIGNED(from, blocksize) && IS_ALIGNED(end + 1, blocksize))
>> -		goto out;
>> +	if (IS_ALIGNED(from, blocksize) && IS_ALIGNED(end + 1, blocksize)) {
>=20
> Does this need to depend on `where` now or is it still necessary to
> check both?

No, that's the beauty of passing the original range we want to truncate.
It always works no matter @where.

Thanks,
Qu

