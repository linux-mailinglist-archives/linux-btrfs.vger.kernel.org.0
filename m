Return-Path: <linux-btrfs+bounces-13156-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B03BA92FBD
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Apr 2025 04:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D649445DAA
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Apr 2025 02:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DF02673B5;
	Fri, 18 Apr 2025 02:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="kgIHWKxa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2522673AB
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Apr 2025 02:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744942191; cv=none; b=fRcDBNNIahSyj674009DGQG3PTDJ4lNS7+Dql8iF3JKxLVwDcjTdEtocleU2hN5pjK+BMNAB4PpV4mJbD259OF0d5UVPTDPzI/W4n6Y87pvHLH5abF+NQP0awTx5L/HvlidWkEwPL+geMZuPI5J8xREPBXQCAKAl/Y07R/ZxiHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744942191; c=relaxed/simple;
	bh=AnrHvYSA4mJnbvTrAE4Sa7ATrQo9ZOKOyACtvgKPn2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Si29/F65Pqit0uPzdC4v5cWhWuIA15cZ7iSiRA9+jnBDzEgvtOTGj9slte+JAGUCt0qU8b5EN7Yz+14kjZw1vvqM+YlGg9NOlB9euvozcktLuDA4Yyf0ZjJAND3eyAYp/DCKb0ifiEnAglYHiJYnQuf0RDR0GHOgkFBMkCpVg5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=kgIHWKxa; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1744942184; x=1745546984; i=quwenruo.btrfs@gmx.com;
	bh=K/2jHJRcyuZ4mQUPir3kds7YtVpKDtg1WVd5m15koa0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kgIHWKxaXb2xfHwo449N3QFf4QlKgCS+E2FLQRnbq9NGRelSUIsTUlgU1kvIjGxO
	 JhoOdYRba1rRENHHtScIH7sMTnsTqDEOeYGivRndI0wmjwjy4RgMjQ8VDqIXHoT7K
	 xTa1afCXDnGFst9t4hGzplpld47Q4E+wBkFGJUt4cSEXgppSmpfoTBMR7E0qxC6g8
	 +T1o0jTHqUFHmgxhMV5WjxMdQZzAEutH1SiZKnZYurvieOvWuRIOp6AnFZnHNwHPY
	 Pzpjr73MCEQUMfP+G01qWdkwBQIRac6dvEJkZ/wPXvwDTdRHqyKzrrxwpYW2YeYXb
	 GmSFFWHuIwNudSlA8g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mqs0X-1urX6f0vBZ-00jHDc; Fri, 18
 Apr 2025 04:09:44 +0200
Message-ID: <d6fa1d98-4b4b-4e40-937f-3854fb2a91e5@gmx.com>
Date: Fri, 18 Apr 2025 11:39:41 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] btrfs: simplify bvec iteration in index_one_bio
To: Christoph Hellwig <hch@lst.de>, Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
References: <20250409111055.3640328-1-hch@lst.de>
 <20250409111055.3640328-6-hch@lst.de>
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
In-Reply-To: <20250409111055.3640328-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rAaOZmU91X9N5ShUND8eG70OiRTD5NBUC0faI0TE6fGu/k32Las
 CYimUJtZGThPySM3VJHvrAyGybSMpFniCTR++SvDOGYUsQX8TU3m6NwN0SG31C9Cw6iFCnc
 hdfls08TuzODmMlX9RpUHzI7qPqCzkpea7DwW1bpfhdPdFPxkCc7qukkctgaQmyZPjLsuXO
 eXr5SLIdzKSTexBAuh6Hw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RTCJY4FRiUg=;3Cr4LMFp2opw1Z7K4u1c+YZqhtW
 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
 w==



=E5=9C=A8 2025/4/9 20:40, Christoph Hellwig =E5=86=99=E9=81=93:
> Flatten the two loops by open coding bio_for_each_segment and advancing
> the iterator one sector at a time.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/raid56.c | 21 +++++++++------------
>   1 file changed, 9 insertions(+), 12 deletions(-)
>=20
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 28dbded86cc2..703e713bac03 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -1195,23 +1195,20 @@ static int rbio_add_io_sector(struct btrfs_raid_=
bio *rbio,
>   static void index_one_bio(struct btrfs_raid_bio *rbio, struct bio *bio=
)
>   {
>   	const u32 sectorsize =3D rbio->bioc->fs_info->sectorsize;
> -	struct bio_vec bvec;
> -	struct bvec_iter iter;
> +	struct bvec_iter iter =3D bio->bi_iter;
>   	u32 offset =3D (bio->bi_iter.bi_sector << SECTOR_SHIFT) -
>   		     rbio->bioc->full_stripe_logical;
>  =20
> -	bio_for_each_segment(bvec, bio, iter) {
> -		u32 bvec_offset;
> +	while (iter.bi_size) {
> +		int index =3D offset / sectorsize;

The value @offset is no longer updated, this means only the first sector=
=20
of the current bio will be updated, and it's updated several times,=20
resulting incorrect location.

Furthermore, for full stripe write since we do not allocate pages for=20
the stripes_pages[], we will got incorrect bio_sectors[] pointing to NULL.

This will crash rmw_rbio(), easily reproduced by btrfs/011.

I'll also fix it in my local branch.

Thanks,
Qu

> +		struct sector_ptr *sector =3D &rbio->bio_sectors[index];
> +		struct bio_vec bv =3D bio_iter_iovec(bio, iter);
>  =20
> -		for (bvec_offset =3D 0; bvec_offset < bvec.bv_len;
> -		     bvec_offset +=3D sectorsize, offset +=3D sectorsize) {
> -			int index =3D offset / sectorsize;
> -			struct sector_ptr *sector =3D &rbio->bio_sectors[index];
> +		sector->page =3D bv.bv_page;
> +		sector->pgoff =3D bv.bv_offset;
> +		ASSERT(sector->pgoff < PAGE_SIZE);
>  =20
> -			sector->page =3D bvec.bv_page;
> -			sector->pgoff =3D bvec.bv_offset + bvec_offset;
> -			ASSERT(sector->pgoff < PAGE_SIZE);
> -		}
> +		bio_advance_iter_single(bio, &iter, sectorsize);
>   	}
>   }
>  =20


