Return-Path: <linux-btrfs+bounces-13055-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEAE0A8AF60
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 06:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E46FF16C8DB
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Apr 2025 04:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A7B20969A;
	Wed, 16 Apr 2025 04:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="aWtHa5KP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0F4229B36
	for <linux-btrfs@vger.kernel.org>; Wed, 16 Apr 2025 04:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744779087; cv=none; b=aXPdS17ppFvx1m3Qb8RUQuBX1wbaOjP4D2h6ijbZE6D5CHHm9Bn6zwhGby8jQdX0vwManzCQPVatJ7+HyAr3RCA83bVDy7aIflM1bsiGH6F592ElcHHLa5K28Vcc4+WucWl8hFofpe7rgShS3bx9UtqmM1/rK/HfHGYrK7DJcFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744779087; c=relaxed/simple;
	bh=M3HATzSPwe+5TRVSTqA86wxbKQ97Hr7BtkUcEai/A94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W/YnA77qkLv+HfvGzYNCzhL+51GvdoGSF6KmP4hneJ++UDBrELy2CB5GVD9h8cGwVOZOUC+8o2NZs0F9cNvxjSrPA3WiVOCMQFQ+KkE+DGxW73zrOwKjHga7AoNLDxQezMb66FvIaLX5/ywHgLpF3deTCxDxgAqmWH/ij8l8tVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=aWtHa5KP; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1744779083; x=1745383883; i=quwenruo.btrfs@gmx.com;
	bh=Khldw83WFpmtid9+Q22LyT4g9QFuVX/UnKytydOj9s4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aWtHa5KPOZr8aZm4v6C2kedJuZoOoO5leMDxrtOM197YIUgog5/oTyM7NwLWB+Pr
	 4uwqMLzQEnPd7SpwVURh0Q9ueRTSp7JOo6Tz3O9LUGlSgRtsCilXmPYtS2YSjcqO4
	 BgZEVwR96b3+AUMALafhCuWXG+4v2ugITjZsgcHi5UsWgF2BSpBQYARR1AT2ftUZe
	 n7NgcDUwljyG9HaXVoSmYepL0rmA2Y1Ddj78EkfXI2i180xlUtJPdgm8PHcBDfQ+e
	 8IvI/kDqLfsEB/Dp7Nl1nIxox8/KfMmyspz0oqiYrVb2RrQAvCHNSxD12IN5Ik7Sb
	 oojUZjIq7hxx6LaGAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MS3mt-1tbWxl1syJ-00Rz0q; Wed, 16
 Apr 2025 06:51:22 +0200
Message-ID: <d5590a3b-4af1-4b6b-bbae-bca82e162445@gmx.com>
Date: Wed, 16 Apr 2025 14:21:19 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] btrfs: move kmapping out of btrfs_check_sector_csum
To: Christoph Hellwig <hch@lst.de>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <20250409111055.3640328-1-hch@lst.de>
 <20250409111055.3640328-5-hch@lst.de>
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
In-Reply-To: <20250409111055.3640328-5-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6Li5xqKt7PmoSbGyjm3ND1kC6EnnvzHLUkUU0jS44EOeTVptnmK
 71fSmYbHRDebAbzZyWx0dajvEJaRFHjbgW2ZpJA6dfgdLWQa/uJmyMa3x5mkF8CNq7Jl0Bq
 /nlrMF5pfmbNKauKqjqoOTKLOB8eGQuqe1B9X3wrncw+NGgauXWyGgOFMxUr7mPvhvdyMIm
 fPa7peB8AUHsaGR4gUmIw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RJF+6uWCd+w=;MGTrjr4+A/w+FayxO4YjcUhPHqc
 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
 RQOFnOxHbZOq4MIwSjscr4=



=E5=9C=A8 2025/4/9 20:40, Christoph Hellwig =E5=86=99=E9=81=93:
> Move kmapping the page out of btrfs_check_sector_csum.  This allows
> using bvec_kmap_local where suitable and reduces the number of kmap
> calls in the raid56 code.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/btrfs_inode.h |  4 ++--
>   fs/btrfs/inode.c       | 18 ++++++++----------
>   fs/btrfs/raid56.c      | 19 +++++++++++--------
>   fs/btrfs/scrub.c       |  5 ++++-
>   4 files changed, 25 insertions(+), 21 deletions(-)
>=20
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index 4e2952cf5766..d48438332c7c 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -529,8 +529,8 @@ static inline void btrfs_update_inode_mapping_flags(=
struct btrfs_inode *inode)
>   #define CSUM_FMT				"0x%*phN"
>   #define CSUM_FMT_VALUE(size, bytes)		size, bytes
>  =20
> -int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page =
*page,
> -			    u32 pgoff, u8 *csum, const u8 * const csum_expected);
> +int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, void *kaddr,
> +		u8 *csum, const u8 * const csum_expected);
>   bool btrfs_data_csum_ok(struct btrfs_bio *bbio, struct btrfs_device *d=
ev,
>   			u32 bio_offset, struct bio_vec *bv);
>   noinline int can_nocow_extent(struct btrfs_inode *inode, u64 offset, u=
64 *len,
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index cc67d1a2d611..665df96af134 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3337,19 +3337,13 @@ int btrfs_finish_ordered_io(struct btrfs_ordered=
_extent *ordered)
>    * Verify the checksum for a single sector without any extra action th=
at depend
>    * on the type of I/O.
>    */
> -int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, struct page =
*page,
> -			    u32 pgoff, u8 *csum, const u8 * const csum_expected)
> +int btrfs_check_sector_csum(struct btrfs_fs_info *fs_info, void *kaddr,
> +			    u8 *csum, const u8 * const csum_expected)
>   {
>   	SHASH_DESC_ON_STACK(shash, fs_info->csum_shash);
> -	char *kaddr;
> -
> -	ASSERT(pgoff + fs_info->sectorsize <=3D PAGE_SIZE);
>  =20
>   	shash->tfm =3D fs_info->csum_shash;
> -
> -	kaddr =3D kmap_local_page(page) + pgoff;
>   	crypto_shash_digest(shash, kaddr, fs_info->sectorsize, csum);
> -	kunmap_local(kaddr);
>  =20
>   	if (memcmp(csum, csum_expected, fs_info->csum_size))
>   		return -EIO;
> @@ -3378,6 +3372,7 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, st=
ruct btrfs_device *dev,
>   	u64 end =3D file_offset + bv->bv_len - 1;
>   	u8 *csum_expected;
>   	u8 csum[BTRFS_CSUM_SIZE];
> +	char *kaddr;
>  =20
>   	ASSERT(bv->bv_len =3D=3D fs_info->sectorsize);
>  =20
> @@ -3395,9 +3390,12 @@ bool btrfs_data_csum_ok(struct btrfs_bio *bbio, s=
truct btrfs_device *dev,
>  =20
>   	csum_expected =3D bbio->csum + (bio_offset >> fs_info->sectorsize_bit=
s) *
>   				fs_info->csum_size;
> -	if (btrfs_check_sector_csum(fs_info, bv->bv_page, bv->bv_offset, csum,
> -				    csum_expected))
> +	kaddr =3D bvec_kmap_local(bv);
> +	if (btrfs_check_sector_csum(fs_info, kaddr, csum, csum_expected)) {
> +		kunmap_local(kaddr);
>   		goto zeroit;
> +	}
> +	kunmap_local(kaddr);
>   	return true;
>  =20
>   zeroit:
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index cdd373c27784..28dbded86cc2 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -1575,11 +1575,11 @@ static void verify_bio_data_sectors(struct btrfs=
_raid_bio *rbio,
>   		return;
>  =20
>   	bio_for_each_segment_all(bvec, bio, iter_all) {
> -		int bv_offset;
> +		void *kaddr =3D bvec_kmap_local(bvec);
> +		unsigned int off;
>  =20
> -		for (bv_offset =3D bvec->bv_offset;
> -		     bv_offset < bvec->bv_offset + bvec->bv_len;
> -		     bv_offset +=3D fs_info->sectorsize, total_sector_nr++) {
> +		for (off =3D 0; off < bvec->bv_len;
> +		     off +=3D fs_info->sectorsize, total_sector_nr++) {
>   			u8 csum_buf[BTRFS_CSUM_SIZE];
>   			u8 *expected_csum =3D rbio->csum_buf +
>   					    total_sector_nr * fs_info->csum_size;
> @@ -1589,11 +1589,12 @@ static void verify_bio_data_sectors(struct btrfs=
_raid_bio *rbio,
>   			if (!test_bit(total_sector_nr, rbio->csum_bitmap))
>   				continue;
>  =20
> -			ret =3D btrfs_check_sector_csum(fs_info, bvec->bv_page,
> -				bv_offset, csum_buf, expected_csum);
> +			ret =3D btrfs_check_sector_csum(fs_info, kaddr + off,
> +					csum_buf, expected_csum);
>   			if (ret < 0)
>   				set_bit(total_sector_nr, rbio->error_bitmap);
>   		}
> +		kunmap_local(kaddr);
>   	}
>   }
>  =20
> @@ -1791,6 +1792,7 @@ static int verify_one_sector(struct btrfs_raid_bio=
 *rbio,
>   	struct sector_ptr *sector;
>   	u8 csum_buf[BTRFS_CSUM_SIZE];
>   	u8 *csum_expected;
> +	void *kaddr;
>   	int ret;
>  =20
>   	if (!rbio->csum_bitmap || !rbio->csum_buf)
> @@ -1811,11 +1813,12 @@ static int verify_one_sector(struct btrfs_raid_b=
io *rbio,
>  =20
>   	ASSERT(sector->page);
>  =20
> +	kaddr =3D kmap_local_page(sector->page) + sector->pgoff;
>   	csum_expected =3D rbio->csum_buf +
>   			(stripe_nr * rbio->stripe_nsectors + sector_nr) *
>   			fs_info->csum_size;
> -	ret =3D btrfs_check_sector_csum(fs_info, sector->page, sector->pgoff,
> -				      csum_buf, csum_expected);
> +	ret =3D btrfs_check_sector_csum(fs_info, kaddr, csum_buf, csum_expecte=
d);
> +	kunmap_local(kaddr);
>   	return ret;
>   }
>  =20
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 2c5edcee9450..49021765c17b 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -694,6 +694,7 @@ static void scrub_verify_one_sector(struct scrub_str=
ipe *stripe, int sector_nr)
>   	struct page *page =3D scrub_stripe_get_page(stripe, sector_nr);
>   	unsigned int pgoff =3D scrub_stripe_get_page_offset(stripe, sector_nr=
);
>   	u8 csum_buf[BTRFS_CSUM_SIZE];
> +	void *kaddr;
>   	int ret;
>  =20
>   	ASSERT(sector_nr >=3D 0 && sector_nr < stripe->nr_sectors);
> @@ -737,7 +738,9 @@ static void scrub_verify_one_sector(struct scrub_str=
ipe *stripe, int sector_nr)
>   		return;
>   	}
>  =20
> -	ret =3D btrfs_check_sector_csum(fs_info, page, pgoff, csum_buf, sector=
->csum);
> +	kaddr =3D kmap_local_page(page) + pgoff;
> +	ret =3D btrfs_check_sector_csum(fs_info, kaddr, csum_buf, sector->csum=
);
> +	kunmap_local(kaddr);
>   	if (ret < 0) {
>   		set_bit(sector_nr, &stripe->csum_error_bitmap);
>   		set_bit(sector_nr, &stripe->error_bitmap);


