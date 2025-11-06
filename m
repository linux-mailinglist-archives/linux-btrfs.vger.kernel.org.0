Return-Path: <linux-btrfs+bounces-18760-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D84C3980D
	for <lists+linux-btrfs@lfdr.de>; Thu, 06 Nov 2025 09:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29BF71892596
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Nov 2025 08:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCD32FFFBC;
	Thu,  6 Nov 2025 08:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="NmUNaG8r"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492462FFF91
	for <linux-btrfs@vger.kernel.org>; Thu,  6 Nov 2025 08:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762416303; cv=none; b=JeGFzVLdZcxhM18ECMmyvsyyefjACe18OO563B4FKk31iZSMeVIiNl/IvCCy1QUpNXEq2fjwk6m1FOQY5cnJDGyGMn3pc6e7LCrYAj0g6rRS09ThKhDZQbQLwLB/wpZ33LrFABVzloKseq1GlXVEbPKQ73fp0ACmb15E6zPyd8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762416303; c=relaxed/simple;
	bh=1C4TvJvDh5powJq9v2pIIOwgYx/lVwuWpnS6w162K+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HgGDC/b/lwRE8NzcnwO0AZtUfyuEh9CQuSbWw0BghJ5/XOjxVg9g5LXTvms/9vosAQSeNyWaoTAtBZyGcLlUfPlt49Ud3kexxa1DZeVFQ9QgqoXtE1p8szFB0nRFkh9IHvH47cfykmGteET9VhvSwmPIdDgpiI7FEa7Yl/OFShs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=NmUNaG8r; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1762416298; x=1763021098; i=quwenruo.btrfs@gmx.com;
	bh=7NrkbX467GYMsyYZLNUD09+tYKQaymjpk4u3/Flthgk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=NmUNaG8rVLAnlUaJHbQkKYK3k7raw28861qmjySiGhlPkBIEIhZw89N8TVidbAng
	 OuVd1JVjd+XIyCTdoXafrmPq5lK5OAydeNhgjlgPbLmWNwxPktjNeUSz9EDzuUX+y
	 P2y7r++0uvQjWIBs94TLTY/45qLjSHmHrkbSDFd3z28rIvoliLTxYwJiekMFdOfZF
	 zbgnYhGoyNlL6tf3ndlYOcXdxpxmtmdHOCI/1wv2ha8rQAiegZxb5y87gyVaOnjHo
	 RO12+V105LJzv4xPgiuxqSMnOXpk39w9lZh+syoFCetUyJRz+twCWcB4CbW80h5ax
	 KgpS+UXficSd36YlLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MNt0M-1vadjV2A12-00QXt2; Thu, 06
 Nov 2025 09:04:57 +0100
Message-ID: <27808a35-6052-4c2a-93fb-69b64871dbf7@gmx.com>
Date: Thu, 6 Nov 2025 18:34:54 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: use kvmalloc for btrfs_bio::csum allocation
To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Calvin Owens <calvin@wbinvd.org>
References: <22b5e7a4dad73b2c97069f34910a56fcf58d5f6c.1762379016.git.wqu@suse.com>
 <20251106074953.GT13846@twin.jikos.cz>
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
In-Reply-To: <20251106074953.GT13846@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qPPTF9NiAa4YeMucjpcz2S9EpOVyQklbqtEs+X3cKz6vHn7MwOg
 pAF1Wbd2I/NViWKMBjKH9mwbDr0mdP7aQSQnzJpd9LujqYvz1SVEXBvVWxP0XWQV2cTu66U
 ULzSnYlyHkGP901HMkrM0JnsYwQpV/SK/vaRMeeKuEl1L3slkIPLRxt7soR2HvUOVZ5W4wf
 OktSkwRTlrte3qKGizgVQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1xYHM6zdqxQ=;oH5/FawWubR6B1ROLJ5B0UZRcAx
 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



=E5=9C=A8 2025/11/6 18:19, David Sterba =E5=86=99=E9=81=93:
[...]
>> This will become more common when the large folio support is moved out
>> of experimental features.
>>
>> In the above case, a read larger than 4MiB with SHA256 checksum (32
>> bytes for each 4K block) will be able to trigger a order 4 allocation.
>=20
> Can we possibly avoid allocating order 4 and keep it only up to the
> costly order 3? btrfs_submit_chunk() already splits the bio and is the
> only caller of btrfs_lookup_bio_sums(). The calculation could take into
> account csum size and page size so it's not splitting unnecessarily.

This is the trade-off between handling split at btrfs level or the mm leve=
l.

At btrfs stage, each split will cause around 300 bytes just for btrfs_bio.
I'd say the cost for vmalloc() is less, especially considering our csum=20
buffer is much smaller thus less chance to need to mapping.

Although the biggest reason I choose to split at mm level is, we really=20
do not need to bother physical continuous for csum handling.
Thus I see less reason to go the bio split path.
(And one less thing to bother at fs level is overall a win to me)

Thanks,
Qu

>=20
>>
>> The order 4 is larger than PAGE_ALLOC_COSTLY_ORDER (3), thus without
>> extra flags such allocation will not retry.
>>
>> And if the system has very small amount of memory (e.g. RPI4 with low
>> memory spec) or VMs with small vRAM, or the memory is heavily
>> fragmented, such allocation will fail and cause the above warning.
>>
>> [FIX]
>> Although btrfs is handling the memory allocation failure correctly, we
>> do not really need those physically contiguous memory just to restore
>> our checksum.
>>
>> In fact btrfs_csum_one_bio() is already using kvzallocated memory to
>> reduce the memory pressure.
>=20
> Reading the commit a3d46aea46f99d134b4e07, kvzalloc was also a
> workaround and it kept the code simple but relying on the virtual page
> mappings. I'd consider the bio paths critical enough so there are
> fallbacks that work with heavily fragmented memory where we can't get a
> contiguous memory or the mappings.
>=20
>> So follow the step to use kvmalloc() for btrfs_bio::csum.
>=20
> This is ok for now and that it worked for btrfs_csum_one_bio() so far
> sounds promising.
>=20
> Reviewed-by: David Sterba <dsterba@suse.com>
>=20
>> Reported-by: Calvin Owens <calvin@wbinvd.org>
>> Link: https://lore.kernel.org/linux-btrfs/20251105180054.511528-1-calvi=
n@wbinvd.org/
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/bio.c       | 2 +-
>>   fs/btrfs/file-item.c | 4 ++--
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
>> index 8af2b68c2d53..bb7ef4c67911 100644
>> --- a/fs/btrfs/bio.c
>> +++ b/fs/btrfs/bio.c
>> @@ -293,7 +293,7 @@ static void btrfs_check_read_bio(struct btrfs_bio *=
bbio, struct btrfs_device *de
>>   		offset +=3D sectorsize;
>>   	}
>>   	if (bbio->csum !=3D bbio->csum_inline)
>> -		kfree(bbio->csum);
>> +		kvfree(bbio->csum);
>>  =20
>>   	if (fbio)
>>   		btrfs_repair_done(fbio);
>> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
>> index 4b7c40f05e8f..bb8eb43334f6 100644
>> --- a/fs/btrfs/file-item.c
>> +++ b/fs/btrfs/file-item.c
>> @@ -373,7 +373,7 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
>>   		return -ENOMEM;
>>  =20
>>   	if (nblocks * csum_size > BTRFS_BIO_INLINE_CSUM_SIZE) {
>> -		bbio->csum =3D kmalloc_array(nblocks, csum_size, GFP_NOFS);
>> +		bbio->csum =3D kvmalloc(nblocks * csum_size, GFP_NOFS);
>>   		if (!bbio->csum)
>>   			return -ENOMEM;
>>   	} else {
>> @@ -439,7 +439,7 @@ int btrfs_lookup_bio_sums(struct btrfs_bio *bbio)
>>   		if (count < 0) {
>>   			ret =3D count;
>>   			if (bbio->csum !=3D bbio->csum_inline)
>> -				kfree(bbio->csum);
>> +				kvfree(bbio->csum);
>>   			bbio->csum =3D NULL;
>>   			break;
>>   		}
>> --=20
>> 2.51.2
>>
>=20


