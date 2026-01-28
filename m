Return-Path: <linux-btrfs+bounces-21189-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCyKDGhzemng6gEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21189-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 21:36:56 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 838DAA8ABE
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 21:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC81A308FAB9
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 20:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DAA374199;
	Wed, 28 Jan 2026 20:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="sk1YbxKD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37942D73A1
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 20:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632389; cv=none; b=SCjZ7Y2WEEhaWZ/xQGcWxJYQNJyFLstWYzo56Mfi1Pra/8aWRhaq5WTgY7x5K3UNhUpZLimB8HwRt0k83bxBsf3BVe6daWaMhp7zxOu/IDW36mh2dzY22uw7aqe887hbiYFRvUeqPCv6St6OceNFBrZ3dNw2tjFHHpEvS2S+U68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632389; c=relaxed/simple;
	bh=gpgqtEI/k/fpW6RlLrITSucW0YOMNXDklzHBZcllZK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eCDBL3jU6eCcG4ljCZlVEZ23KdnyZ2yB3W95Ej5wsesIvyuce/NoTw9rpns+wm2iyKShGNMCFTdQ5IlxyNTFi0wJzx3AIAjm7KGjKFXaXGG8MJuzrg9ZeA/xZt1OYk763Adm4w45PWSjU2rfVR3ZY41ztRiJnzdM7dG1aLaocZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=sk1YbxKD; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1769632384; x=1770237184; i=quwenruo.btrfs@gmx.com;
	bh=7uKzOvhKN9gmDNcBP6ogKO7kg8QRrIbx2KxAAStoKF0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sk1YbxKD8qrB0R0/g2iMJSMnoFrzyTqOmJIWMk95B8Kg+EroCnFBnXBCalGpJ1W6
	 i1NOFTHrguWKjeFXuo/ajwEXR8nOZTugNGH71BCUKxkZEPP0EuAUQdxkeU9s8/ybF
	 OHmcqhwct1R8cdKWB9Vix2kjjnN8179tZGaiTOq+VYUTCUEzktrO+2Xo89OGs4mNI
	 LFk0mdftdfGJNhf+9tY7H+HQmjtvFRnVnUueXN/UIUdD7eQJR6KwLq4NCn7ZlQIud
	 aPLWN2eSaRPeujy1/OkbT3jAg6ETUOQzxMAWs5bs8FPMiIE9PTyBQ6UKrx5BjDK5Y
	 3PqoY9N6ounTij+WDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MORAU-1vNTKT090w-00O94D; Wed, 28
 Jan 2026 21:33:03 +0100
Message-ID: <1f852e8e-3c64-4b4e-85a0-77c2d593c4fa@gmx.com>
Date: Thu, 29 Jan 2026 07:03:00 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] btrfs: switch to btrfs_compress_bio() interface
 for compressed writes
To: Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1769566870.git.wqu@suse.com>
 <0ede658476d5d18894ef9938a509ff89d8485ef4.1769566870.git.wqu@suse.com>
 <20260128195746.GA4101846@zen.localdomain>
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
In-Reply-To: <20260128195746.GA4101846@zen.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IpAK7P27gcDOvDFQJo4Ti2Ag9GCYQFf+V0KDkItl4CXHEQVp9Jc
 /35a2bwZ2xoVtT7F+6/zCUYo6hmbKYbgRxPwEnBA5uGNwPoT4e9qn1yqQUXQOIgRZt2NcLQ
 2dHnjBPYJNfJCeJhQIr7e+X3HcQD5vX4YbnOVjeHgx2lN+dGUtGVMono50cIhNPF0QLd0aV
 chjdP6ptPDu6FE6mLrtXA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:72iBTpgBUrA=;TlJR5P5ILqwiWA205hqW5bh2McB
 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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21189-lists,linux-btrfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FREEMAIL_FROM(0.00)[gmx.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.com:mid,gmx.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: 838DAA8ABE
X-Rspamd-Action: no action



=E5=9C=A8 2026/1/29 06:28, Boris Burkov =E5=86=99=E9=81=93:
> On Wed, Jan 28, 2026 at 01:07:04PM +1030, Qu Wenruo wrote:
>> This switch has the following benefits:
>>
>> - A single structure to handle all compression
>>
>>    No more extra members like compressed_folios[] nor compress_type, al=
l
>>    those members.
>>
>>    This means the structure of async_extent is much smaller.
>>
>> - Simpler error handling
>>
>>    A single cleanup_compressed_bio() will handle everything, no extra
>>    compressed_folios[] array to bother.
>>
>> Some special notes:
>>
>> - Compressed folios releasing
>>
>>    Now we go bio_for_each_folio_all() loop to release the folios of the
>>    bio. This will work for both the old compressed_folios[] array and t=
he
>>    new pure bio method.
>>
>>    For old compressed_folios[], all folios of that array is queued into
>>    the bio, thus releasing the folios from the bio is the same as
>>    releasing each folio of that array. We jut need to be sure no double
>=20
> just
>=20
>>    releasing from the array and bio.
>>
>>    For the new pure bio method, that array is NULL, just usual folio
>>    releasing of the bio.
>>
>>    The only extra note is for end_bbio_compressed_read(), as the folios
>>    are allocated using btrfs_alloc_folio_array(), thus the folios shoul=
d
>>    only be released by regular folio_put(), not btrfs_free_compr_folio(=
).
>>
>> - Rounding up the bio to block size
>>
>>    We can not simply increase bi_size, as that will not increase the
>>    length of the last bvec.
>>
>>    Thus we have to properly add the last part into the bio.
>>    This will be done by the helper, round_up_last_block().
>=20
> Just curious:
> Would it be possible to do this in the compression library code along
> with the other btrfs_add_bio() calls?

Unfortunately no. The reason is for inline compressed extents, where we=20
want the unaligned compressed size.

Or we will lose the ability to create inline compressed extents.
As the end result is always a single block.

Thanks,
Qu

> Unifying that in one place seems
> nice. On the other hand duplicating that logic in each one is more
> fragile.
>=20
> Are you doing it in the generic code because it is generic and you save
> duplication or do those callsites lack some needed context?
>=20
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>   fs/btrfs/compression.c |  16 ++--
>>   fs/btrfs/inode.c       | 161 +++++++++++++++++++---------------------=
-
>>   2 files changed, 83 insertions(+), 94 deletions(-)
>>
>> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
>> index 942b85bcacbe..1d4e7c7c25c3 100644
>> --- a/fs/btrfs/compression.c
>> +++ b/fs/btrfs/compression.c
>> @@ -155,13 +155,6 @@ static int compression_decompress(int type, struct=
 list_head *ws,
>>   	}
>>   }
>>  =20
>> -static void btrfs_free_compressed_folios(struct compressed_bio *cb)
>> -{
>> -	for (unsigned int i =3D 0; i < cb->nr_folios; i++)
>> -		btrfs_free_compr_folio(cb->compressed_folios[i]);
>> -	kfree(cb->compressed_folios);
>> -}
>> -
>>   static int btrfs_decompress_bio(struct compressed_bio *cb);
>>  =20
>>   /*
>> @@ -270,12 +263,14 @@ static void end_bbio_compressed_read(struct btrfs=
_bio *bbio)
>>   {
>>   	struct compressed_bio *cb =3D to_compressed_bio(bbio);
>>   	blk_status_t status =3D bbio->bio.bi_status;
>> +	struct folio_iter fi;
>>  =20
>>   	if (!status)
>>   		status =3D errno_to_blk_status(btrfs_decompress_bio(cb));
>>  =20
>> -	btrfs_free_compressed_folios(cb);
>>   	btrfs_bio_end_io(cb->orig_bbio, status);
>> +	bio_for_each_folio_all(fi, &bbio->bio)
>> +		folio_put(fi.folio);
>>   	bio_put(&bbio->bio);
>>   }
>>  =20
>> @@ -326,6 +321,7 @@ static noinline void end_compressed_writeback(const=
 struct compressed_bio *cb)
>>   static void end_bbio_compressed_write(struct btrfs_bio *bbio)
>>   {
>>   	struct compressed_bio *cb =3D to_compressed_bio(bbio);
>> +	struct folio_iter fi;
>>  =20
>>   	btrfs_finish_ordered_extent(cb->bbio.ordered, NULL, cb->start, cb->l=
en,
>>   				    cb->bbio.bio.bi_status =3D=3D BLK_STS_OK);
>> @@ -333,7 +329,9 @@ static void end_bbio_compressed_write(struct btrfs_=
bio *bbio)
>>   	if (cb->writeback)
>>   		end_compressed_writeback(cb);
>>   	/* Note, our inode could be gone now. */
>> -	btrfs_free_compressed_folios(cb);
>> +	bio_for_each_folio_all(fi, &bbio->bio)
>> +		btrfs_free_compr_folio(fi.folio);
>> +	kfree(cb->compressed_folios);
>>   	bio_put(&cb->bbio.bio);
>>   }
>>  =20
>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
>> index 10609b8199a0..aafffb72dd0e 100644
>> --- a/fs/btrfs/inode.c
>> +++ b/fs/btrfs/inode.c
>> @@ -755,10 +755,7 @@ static noinline int cow_file_range_inline(struct b=
trfs_inode *inode,
>>   struct async_extent {
>>   	u64 start;
>>   	u64 ram_size;
>> -	u64 compressed_size;
>> -	struct folio **folios;
>> -	unsigned long nr_folios;
>> -	int compress_type;
>> +	struct compressed_bio *cb;
>>   	struct list_head list;
>>   };
>>  =20
>> @@ -779,24 +776,19 @@ struct async_cow {
>>   	struct async_chunk chunks[];
>>   };
>>  =20
>> -static noinline int add_async_extent(struct async_chunk *cow,
>> -				     u64 start, u64 ram_size,
>> -				     u64 compressed_size,
>> -				     struct folio **folios,
>> -				     unsigned long nr_folios,
>> -				     int compress_type)
>> +static int add_async_extent(struct async_chunk *cow,
>> +			    u64 start, u64 ram_size,
>> +			    struct compressed_bio *cb)
>>   {
>>   	struct async_extent *async_extent;
>>  =20
>>   	async_extent =3D kmalloc(sizeof(*async_extent), GFP_NOFS);
>>   	if (!async_extent)
>>   		return -ENOMEM;
>> +	ASSERT(ram_size < U32_MAX);
>>   	async_extent->start =3D start;
>>   	async_extent->ram_size =3D ram_size;
>> -	async_extent->compressed_size =3D compressed_size;
>> -	async_extent->folios =3D folios;
>> -	async_extent->nr_folios =3D nr_folios;
>> -	async_extent->compress_type =3D compress_type;
>> +	async_extent->cb =3D cb;
>>   	list_add_tail(&async_extent->list, &cow->extents);
>>   	return 0;
>>   }
>> @@ -870,6 +862,36 @@ static int extent_range_clear_dirty_for_io(struct =
btrfs_inode *inode, u64 start,
>>   	return ret;
>>   }
>>  =20
>> +static void zero_last_folio(struct compressed_bio *cb)
>> +{
>> +	struct bio *bio =3D &cb->bbio.bio;
>> +	struct bio_vec *bvec =3D bio_last_bvec_all(bio);
>> +	phys_addr_t last_paddr =3D page_to_phys(bvec->bv_page) + bvec->bv_off=
set + bvec->bv_len - 1;
>> +	struct folio *last_folio =3D page_folio(phys_to_page(last_paddr));
>> +	const u32 bio_size =3D bio->bi_iter.bi_size;
>> +	const u32 foffset =3D offset_in_folio(last_folio, bio_size);
>> +
>> +	folio_zero_range(last_folio, foffset, folio_size(last_folio) - foffse=
t);
>> +}
>> +
>> +static void round_up_last_block(struct compressed_bio *cb, u32 blocksi=
ze)
>> +{
>> +	struct bio *bio =3D &cb->bbio.bio;
>> +	struct bio_vec *bvec =3D bio_last_bvec_all(bio);
>> +	phys_addr_t last_paddr =3D page_to_phys(bvec->bv_page) + bvec->bv_off=
set + bvec->bv_len - 1;
>> +	struct folio *last_folio =3D page_folio(phys_to_page(last_paddr));
>> +	const u32 bio_size =3D bio->bi_iter.bi_size;
>> +	const u32 foffset =3D offset_in_folio(last_folio, bio_size);
>> +	bool ret;
>> +
>> +	if (IS_ALIGNED(bio_size, blocksize))
>> +		return;
>> +
>> +	ret =3D bio_add_folio(bio, last_folio, round_up(foffset, blocksize) -=
 foffset, foffset);
>> +	/* The remaining part should be merged thus never fail. */
>> +	ASSERT(ret);
>> +}
>> +
>>   /*
>>    * Work queue call back to started compression on a file and pages.
>>    *
>> @@ -890,20 +912,18 @@ static void compress_file_range(struct btrfs_work=
 *work)
>>   	struct btrfs_inode *inode =3D async_chunk->inode;
>>   	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>>   	struct address_space *mapping =3D inode->vfs_inode.i_mapping;
>> -	const u32 min_folio_shift =3D PAGE_SHIFT + fs_info->block_min_order;
>> +	struct compressed_bio *cb =3D NULL;
>>   	const u32 min_folio_size =3D btrfs_min_folio_size(fs_info);
>>   	u64 blocksize =3D fs_info->sectorsize;
>>   	u64 start =3D async_chunk->start;
>>   	u64 end =3D async_chunk->end;
>>   	u64 actual_end;
>>   	u64 i_size;
>> +	u32 cur_len;
>>   	int ret =3D 0;
>> -	struct folio **folios =3D NULL;
>> -	unsigned long nr_folios;
>>   	unsigned long total_compressed =3D 0;
>>   	unsigned long total_in =3D 0;
>>   	unsigned int loff;
>> -	int i;
>>   	int compress_type =3D fs_info->compress_type;
>>   	int compress_level =3D fs_info->compress_level;
>>  =20
>> @@ -942,9 +962,10 @@ static void compress_file_range(struct btrfs_work =
*work)
>>   	barrier();
>>   	actual_end =3D min_t(u64, i_size, end + 1);
>>   again:
>> -	folios =3D NULL;
>> -	nr_folios =3D (end >> min_folio_shift) - (start >> min_folio_shift) +=
 1;
>> -	nr_folios =3D min_t(unsigned long, nr_folios, BTRFS_MAX_COMPRESSED >>=
 min_folio_shift);
>> +	total_in =3D 0;
>> +	cur_len =3D min(end + 1 - start, BTRFS_MAX_UNCOMPRESSED);
>> +	ret =3D 0;
>> +	cb =3D NULL;
>>  =20
>>   	/*
>>   	 * we don't want to send crud past the end of i_size through
>> @@ -959,10 +980,6 @@ static void compress_file_range(struct btrfs_work =
*work)
>>   	if (actual_end <=3D start)
>>   		goto cleanup_and_bail_uncompressed;
>>  =20
>> -	total_compressed =3D min_t(unsigned long, actual_end - start, BTRFS_M=
AX_UNCOMPRESSED);
>> -	total_in =3D 0;
>> -	ret =3D 0;
>> -
>>   	/*
>>   	 * We do compression for mount -o compress and when the inode has no=
t
>>   	 * been flagged as NOCOMPRESS.  This flag can change at any time if =
we
>> @@ -971,15 +988,6 @@ static void compress_file_range(struct btrfs_work =
*work)
>>   	if (!inode_need_compress(inode, start, end))
>>   		goto cleanup_and_bail_uncompressed;
>>  =20
>> -	folios =3D kcalloc(nr_folios, sizeof(struct folio *), GFP_NOFS);
>> -	if (!folios) {
>> -		/*
>> -		 * Memory allocation failure is not a fatal error, we can fall
>> -		 * back to uncompressed code.
>> -		 */
>> -		goto cleanup_and_bail_uncompressed;
>> -	}
>> -
>>   	if (0 < inode->defrag_compress && inode->defrag_compress < BTRFS_NR_=
COMPRESS_TYPES) {
>>   		compress_type =3D inode->defrag_compress;
>>   		compress_level =3D inode->defrag_compress_level;
>> @@ -988,11 +996,15 @@ static void compress_file_range(struct btrfs_work=
 *work)
>>   	}
>>  =20
>>   	/* Compression level is applied here. */
>> -	ret =3D btrfs_compress_folios(compress_type, compress_level,
>> -				    inode, start, folios, &nr_folios, &total_in,
>> -				    &total_compressed);
>> -	if (ret)
>> +	cb =3D btrfs_compress_bio(inode, start, cur_len, compress_type,
>> +				 compress_level, async_chunk->write_flags);
>> +	if (IS_ERR(cb)) {
>> +		cb =3D NULL;
>>   		goto mark_incompressible;
>> +	}
>> +
>> +	total_compressed =3D cb->bbio.bio.bi_iter.bi_size;
>> +	total_in =3D cur_len;
>>  =20
>>   	/*
>>   	 * Zero the tail end of the last folio, as we might be sending it do=
wn
>> @@ -1000,7 +1012,7 @@ static void compress_file_range(struct btrfs_work=
 *work)
>>   	 */
>>   	loff =3D (total_compressed & (min_folio_size - 1));
>>   	if (loff)
>> -		folio_zero_range(folios[nr_folios - 1], loff, min_folio_size - loff)=
;
>> +		zero_last_folio(cb);
>>  =20
>>   	/*
>>   	 * Try to create an inline extent.
>> @@ -1016,11 +1028,13 @@ static void compress_file_range(struct btrfs_wo=
rk *work)
>>   					    BTRFS_COMPRESS_NONE, NULL, false);
>>   	else
>>   		ret =3D cow_file_range_inline(inode, NULL, start, end, total_compre=
ssed,
>> -					    compress_type, folios[0], false);
>> +					    compress_type,
>> +					    bio_first_folio_all(&cb->bbio.bio), false);
>>   	if (ret <=3D 0) {
>> +		cleanup_compressed_bio(cb);
>>   		if (ret < 0)
>>   			mapping_set_error(mapping, -EIO);
>> -		goto free_pages;
>> +		return;
>>   	}
>>  =20
>>   	/*
>> @@ -1028,6 +1042,7 @@ static void compress_file_range(struct btrfs_work=
 *work)
>>   	 * block size boundary so the allocator does sane things.
>>   	 */
>>   	total_compressed =3D ALIGN(total_compressed, blocksize);
>> +	round_up_last_block(cb, blocksize);
>>  =20
>>   	/*
>>   	 * One last check to make sure the compression is really a win, comp=
are
>> @@ -1038,12 +1053,12 @@ static void compress_file_range(struct btrfs_wo=
rk *work)
>>   	if (total_compressed + blocksize > total_in)
>>   		goto mark_incompressible;
>>  =20
>> +
>>   	/*
>>   	 * The async work queues will take care of doing actual allocation o=
n
>>   	 * disk for these compressed pages, and will submit the bios.
>>   	 */
>> -	ret =3D add_async_extent(async_chunk, start, total_in, total_compress=
ed, folios,
>> -			       nr_folios, compress_type);
>> +	ret =3D add_async_extent(async_chunk, start, total_in, cb);
>>   	BUG_ON(ret);
>>   	if (start + total_in < end) {
>>   		start +=3D total_in;
>> @@ -1056,33 +1071,10 @@ static void compress_file_range(struct btrfs_wo=
rk *work)
>>   	if (!btrfs_test_opt(fs_info, FORCE_COMPRESS) && !inode->prop_compres=
s)
>>   		inode->flags |=3D BTRFS_INODE_NOCOMPRESS;
>>   cleanup_and_bail_uncompressed:
>> -	ret =3D add_async_extent(async_chunk, start, end - start + 1, 0, NULL=
, 0,
>> -			       BTRFS_COMPRESS_NONE);
>> +	ret =3D add_async_extent(async_chunk, start, end - start + 1, NULL);
>>   	BUG_ON(ret);
>> -free_pages:
>> -	if (folios) {
>> -		for (i =3D 0; i < nr_folios; i++) {
>> -			WARN_ON(folios[i]->mapping);
>> -			btrfs_free_compr_folio(folios[i]);
>> -		}
>> -		kfree(folios);
>> -	}
>> -}
>> -
>> -static void free_async_extent_pages(struct async_extent *async_extent)
>> -{
>> -	int i;
>> -
>> -	if (!async_extent->folios)
>> -		return;
>> -
>> -	for (i =3D 0; i < async_extent->nr_folios; i++) {
>> -		WARN_ON(async_extent->folios[i]->mapping);
>> -		btrfs_free_compr_folio(async_extent->folios[i]);
>> -	}
>> -	kfree(async_extent->folios);
>> -	async_extent->nr_folios =3D 0;
>> -	async_extent->folios =3D NULL;
>> +	if (cb)
>> +		cleanup_compressed_bio(cb);
>>   }
>>  =20
>>   static void submit_uncompressed_range(struct btrfs_inode *inode,
>> @@ -1129,7 +1121,7 @@ static void submit_one_async_extent(struct async_=
chunk *async_chunk,
>>   	struct extent_state *cached =3D NULL;
>>   	struct extent_map *em;
>>   	int ret =3D 0;
>> -	bool free_pages =3D false;
>> +	u32 compressed_size;
>>   	u64 start =3D async_extent->start;
>>   	u64 end =3D async_extent->start + async_extent->ram_size - 1;
>>  =20
>> @@ -1149,17 +1141,14 @@ static void submit_one_async_extent(struct asyn=
c_chunk *async_chunk,
>>   			locked_folio =3D async_chunk->locked_folio;
>>   	}
>>  =20
>> -	if (async_extent->compress_type =3D=3D BTRFS_COMPRESS_NONE) {
>> -		ASSERT(!async_extent->folios);
>> -		ASSERT(async_extent->nr_folios =3D=3D 0);
>> +	if (!async_extent->cb) {
>>   		submit_uncompressed_range(inode, async_extent, locked_folio);
>> -		free_pages =3D true;
>>   		goto done;
>>   	}
>>  =20
>> +	compressed_size =3D async_extent->cb->bbio.bio.bi_iter.bi_size;
>>   	ret =3D btrfs_reserve_extent(root, async_extent->ram_size,
>> -				   async_extent->compressed_size,
>> -				   async_extent->compressed_size,
>> +				   compressed_size, compressed_size,
>>   				   0, *alloc_hint, &ins, true, true);
>>   	if (ret) {
>>   		/*
>> @@ -1169,7 +1158,8 @@ static void submit_one_async_extent(struct async_=
chunk *async_chunk,
>>   		 * fall back to uncompressed.
>>   		 */
>>   		submit_uncompressed_range(inode, async_extent, locked_folio);
>> -		free_pages =3D true;
>> +		cleanup_compressed_bio(async_extent->cb);
>> +		async_extent->cb =3D NULL;
>>   		goto done;
>>   	}
>>  =20
>> @@ -1181,7 +1171,9 @@ static void submit_one_async_extent(struct async_=
chunk *async_chunk,
>>   	file_extent.ram_bytes =3D async_extent->ram_size;
>>   	file_extent.num_bytes =3D async_extent->ram_size;
>>   	file_extent.offset =3D 0;
>> -	file_extent.compression =3D async_extent->compress_type;
>> +	file_extent.compression =3D async_extent->cb->compress_type;
>> +
>> +	async_extent->cb->bbio.bio.bi_iter.bi_sector =3D ins.objectid >> SECT=
OR_SHIFT;
>>  =20
>>   	em =3D btrfs_create_io_em(inode, start, &file_extent, BTRFS_ORDERED_=
COMPRESSED);
>>   	if (IS_ERR(em)) {
>> @@ -1197,22 +1189,20 @@ static void submit_one_async_extent(struct asyn=
c_chunk *async_chunk,
>>   		ret =3D PTR_ERR(ordered);
>>   		goto out_free_reserve;
>>   	}
>> +	async_extent->cb->bbio.ordered =3D ordered;
>>   	btrfs_dec_block_group_reservations(fs_info, ins.objectid);
>>  =20
>>   	/* Clear dirty, set writeback and unlock the pages. */
>>   	extent_clear_unlock_delalloc(inode, start, end,
>>   			NULL, &cached, EXTENT_LOCKED | EXTENT_DELALLOC,
>>   			PAGE_UNLOCK | PAGE_START_WRITEBACK);
>> -	btrfs_submit_compressed_write(ordered,
>> -			    async_extent->folios,	/* compressed_folios */
>> -			    async_extent->nr_folios,
>> -			    async_chunk->write_flags, true);
>> +	btrfs_submit_bbio(&async_extent->cb->bbio, 0);
>> +	async_extent->cb =3D NULL;
>> +
>>   	*alloc_hint =3D ins.objectid + ins.offset;
>>   done:
>>   	if (async_chunk->blkcg_css)
>>   		kthread_associate_blkcg(NULL);
>> -	if (free_pages)
>> -		free_async_extent_pages(async_extent);
>>   	kfree(async_extent);
>>   	return;
>>  =20
>> @@ -1227,7 +1217,8 @@ static void submit_one_async_extent(struct async_=
chunk *async_chunk,
>>   				     EXTENT_DEFRAG | EXTENT_DO_ACCOUNTING,
>>   				     PAGE_UNLOCK | PAGE_START_WRITEBACK |
>>   				     PAGE_END_WRITEBACK);
>> -	free_async_extent_pages(async_extent);
>> +	if (async_extent->cb)
>> +		cleanup_compressed_bio(async_extent->cb);
>>   	if (async_chunk->blkcg_css)
>>   		kthread_associate_blkcg(NULL);
>>   	btrfs_debug(fs_info,
>> --=20
>> 2.52.0
>>
>=20


