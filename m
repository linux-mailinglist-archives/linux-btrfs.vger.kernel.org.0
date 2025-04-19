Return-Path: <linux-btrfs+bounces-13169-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB35A940AB
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Apr 2025 03:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1AE8A8110
	for <lists+linux-btrfs@lfdr.de>; Sat, 19 Apr 2025 01:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC30F2EAF7;
	Sat, 19 Apr 2025 01:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="hu/iyAIO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5606F4E2
	for <linux-btrfs@vger.kernel.org>; Sat, 19 Apr 2025 01:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745024514; cv=none; b=AIQEereRJE6qzvZdj2PVA/XI04sUxFrzH197RD7JGRNrhcWcg7aklXHM1tH5b1ja9ACIr1N6gz3f8Gqwr2o6zbyAYNpARMeHZx/uFZ1WMpKNx65JkDSbKYeuSbMd8TnC6bwNLKCSR5WMl1+uU+e99UI8ePV6Wh1toDQKyveOEiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745024514; c=relaxed/simple;
	bh=3p2oJVD+WtEX6N0RM0u4Iz7BbFJPII31OVXgr2sRQ/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mCdazDjm3n7mFGXIXYYv50yxuJi/MeQxAh5P9kNypa2nsBFrlEUQSgeilJQjRVLlXW0tYPKYUmCTcvS+JDshgvkUHwkBgw1STHw9RAEewkOtfw7VuJptexnpQqh8+vOl5qmtdbwmygycVqXv7B0ucpcGzHF8R/XSQKWVDNF41gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=hu/iyAIO; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1745024507; x=1745629307; i=quwenruo.btrfs@gmx.com;
	bh=b7l1gLnNo5q4Oaryse3W3fW1ti0yHKM3R9qSZ97Eg7o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hu/iyAIO77xF3ZU4pmX1bgDNYTt2SfaVlMc+TcEJz6iv+2tXD3B+yVS6zVblJeF5
	 HQu1CavnhzNZJGPq+41x55TzEiVFQjwTUFW77IDdMVFprkK8j/dDS9T+Ocz82inGN
	 DvCGRBYMOoTLW0N0sY3XXp0eXGgN4bmo7pq/JfdimSDlU4FlGtFIHVdXKGmX5kmUz
	 PKKYrdKsxxnrrqaX4uINUydVcwNzUwDsRzbhhiVNn3jlhqh/+hklW3E2x9Q8NUD0h
	 Ok6weHihsHAjybRqpcyOzq7+QqWOc1WFIfKzagVxzgXbDL3o5toBUv/nirJ1IWlbr
	 +blyQ/z4D9Qe+dIs8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N0oFz-1v2Hle0iCz-013GlY; Sat, 19
 Apr 2025 03:01:47 +0200
Message-ID: <ab3e2c87-6265-4d53-9025-a6ef6222530e@gmx.com>
Date: Sat, 19 Apr 2025 10:31:44 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] btrfs: refactor getting the address of a stripe
 sector
To: Christoph Hellwig <hch@lst.de>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <20250409111055.3640328-1-hch@lst.de>
 <20250409111055.3640328-8-hch@lst.de>
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
In-Reply-To: <20250409111055.3640328-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:COH60tocG4DaVBlv1f96EaR5VIGdyIXfZ5CnI2IX1aRQ+kz4Tvo
 eNMutCMCrgvIbsksUjtJmbP2yYzztr2zFAgyamqXQ9Fo33PumpYYf5g84aa/eZv/pjwmXf7
 qUgbBIsp0ykDS2wdkw1F28AKTIQxAf+8x7kK0sP8Wa5WQdwWK0ACicVfhB+7Lc3glyi9W1l
 /MG9HLVQNIyJcdxENnfyw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Lp8dNAWsPl4=;vIbEBjHsYVsiN11qK8Yj4nU1Ao+
 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



=E5=9C=A8 2025/4/9 20:40, Christoph Hellwig =E5=86=99=E9=81=93:
> Add a helper to get the actual kernel address of a stripe instead of
> just the page and offset into it to simplify the code, and add another
> helper to add the memory backing a sector to a bio using the above
> helper.
>=20
> This nicely abstracts away the page + offset representation from almost
> all of the scrub code.
[...]
> +static void scrub_bio_add_sector(struct btrfs_bio *bbio,
> +		struct scrub_stripe *stripe, int sector_nr)
> +{
> +	void *kaddr =3D scrub_stripe_get_kaddr(stripe, sector_nr);
> +
> +	__bio_add_page(&bbio->bio, virt_to_page(kaddr),
> +			bbio->fs_info->sectorsize, offset_in_page(kaddr));

Another bug here, on subpage cases (fs block size < page size),=20
especially for 64K page size and 4K fs block size, it will trigger the=20
WARN_ON_ONCE(bio_full()).

As a stripe is exactly 64K, thus for the initial read we only need a=20
single bio with at most one bvec.

As we know the whole range is covered by exactly one page, thus all the=20
submitted blocks can be merged into just one bvec.

But __bio_add_page() doesn't do the merge check, thus it will trigger=20
the WARN_ON_ONCE() for the second block.


__bio_add_page() is not the same as "ret =3D bio_add_page(); ASSERT(ret =
=3D=3D=20
blocksize)".

Again will fix it by reverting to the old bio_add_page() with ASSERT().

Thanks,
Qu

> +}
> +
>   static void scrub_stripe_submit_repair_read(struct scrub_stripe *strip=
e,
>   					    int mirror, int blocksize, bool wait)
>   {
> @@ -829,13 +821,6 @@ static void scrub_stripe_submit_repair_read(struct =
scrub_stripe *stripe,
>   	ASSERT(atomic_read(&stripe->pending_io) =3D=3D 0);
>  =20
>   	for_each_set_bit(i, &old_error_bitmap, stripe->nr_sectors) {
> -		struct page *page;
> -		int pgoff;
> -		int ret;
> -
> -		page =3D scrub_stripe_get_page(stripe, i);
> -		pgoff =3D scrub_stripe_get_page_offset(stripe, i);
> -
>   		/* The current sector cannot be merged, submit the bio. */
>   		if (bbio && ((i > 0 && !test_bit(i - 1, &stripe->error_bitmap)) ||
>   			     bbio->bio.bi_iter.bi_size >=3D blocksize)) {
> @@ -854,8 +839,7 @@ static void scrub_stripe_submit_repair_read(struct s=
crub_stripe *stripe,
>   				(i << fs_info->sectorsize_bits)) >> SECTOR_SHIFT;
>   		}
>  =20
> -		ret =3D bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
> -		ASSERT(ret =3D=3D fs_info->sectorsize);
> +		scrub_bio_add_sector(bbio, stripe, i);
>   	}
>   	if (bbio) {
>   		ASSERT(bbio->bio.bi_iter.bi_size);
> @@ -1202,10 +1186,6 @@ static void scrub_write_sectors(struct scrub_ctx =
*sctx, struct scrub_stripe *str
>   	int sector_nr;
>  =20
>   	for_each_set_bit(sector_nr, &write_bitmap, stripe->nr_sectors) {
> -		struct page *page =3D scrub_stripe_get_page(stripe, sector_nr);
> -		unsigned int pgoff =3D scrub_stripe_get_page_offset(stripe, sector_nr=
);
> -		int ret;
> -
>   		/* We should only writeback sectors covered by an extent. */
>   		ASSERT(test_bit(sector_nr, &stripe->extent_sector_bitmap));
>  =20
> @@ -1221,8 +1201,7 @@ static void scrub_write_sectors(struct scrub_ctx *=
sctx, struct scrub_stripe *str
>   				(sector_nr << fs_info->sectorsize_bits)) >>
>   				SECTOR_SHIFT;
>   		}
> -		ret =3D bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
> -		ASSERT(ret =3D=3D fs_info->sectorsize);
> +		scrub_bio_add_sector(bbio, stripe, sector_nr);
>   	}
>   	if (bbio)
>   		scrub_submit_write_bio(sctx, stripe, bbio, dev_replace);
> @@ -1675,9 +1654,6 @@ static void scrub_submit_extent_sector_read(struct=
 scrub_stripe *stripe)
>   	atomic_inc(&stripe->pending_io);
>  =20
>   	for_each_set_bit(i, &stripe->extent_sector_bitmap, stripe->nr_sectors=
) {
> -		struct page *page =3D scrub_stripe_get_page(stripe, i);
> -		unsigned int pgoff =3D scrub_stripe_get_page_offset(stripe, i);
> -
>   		/* We're beyond the chunk boundary, no need to read anymore. */
>   		if (i >=3D nr_sectors)
>   			break;
> @@ -1730,7 +1706,7 @@ static void scrub_submit_extent_sector_read(struct=
 scrub_stripe *stripe)
>   			bbio->bio.bi_iter.bi_sector =3D logical >> SECTOR_SHIFT;
>   		}
>  =20
> -		__bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
> +		scrub_bio_add_sector(bbio, stripe, i);
>   	}
>  =20
>   	if (bbio) {
> @@ -1768,15 +1744,8 @@ static void scrub_submit_initial_read(struct scru=
b_ctx *sctx,
>  =20
>   	bbio->bio.bi_iter.bi_sector =3D stripe->logical >> SECTOR_SHIFT;
>   	/* Read the whole range inside the chunk boundary. */
> -	for (unsigned int cur =3D 0; cur < nr_sectors; cur++) {
> -		struct page *page =3D scrub_stripe_get_page(stripe, cur);
> -		unsigned int pgoff =3D scrub_stripe_get_page_offset(stripe, cur);
> -		int ret;
> -
> -		ret =3D bio_add_page(&bbio->bio, page, fs_info->sectorsize, pgoff);
> -		/* We should have allocated enough bio vectors. */
> -		ASSERT(ret =3D=3D fs_info->sectorsize);
> -	}
> +	for (unsigned int cur =3D 0; cur < nr_sectors; cur++)
> +		scrub_bio_add_sector(bbio, stripe, cur);
>   	atomic_inc(&stripe->pending_io);
>  =20
>   	/*


