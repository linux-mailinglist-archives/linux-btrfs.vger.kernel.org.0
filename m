Return-Path: <linux-btrfs+bounces-18935-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B331C56AFA
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 10:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36BCA3BF4A1
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 09:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583D42E2DFB;
	Thu, 13 Nov 2025 09:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Yh3hW3Xg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEF91F5EA;
	Thu, 13 Nov 2025 09:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763027079; cv=none; b=srdrGNd6HXET0kFecwpusJpKnn8GHR2EfyTIWAFCkbiAYg7UZYM05UZ3j1GD50FOEAjTemxm9pv4s7o0LbpRW/5j+v2LWFY56jAANthIKUpOaWwFSJP3B2zyO0t4UDQg9XflfcNPgOFxwktjc5/E2c2CjBNbO7jIru11FiNO0Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763027079; c=relaxed/simple;
	bh=EG1UtWqvznM7tn5XJfqv/rV+yKZ1UIz0CzVy+5a8YNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ROsbcPALPY5u8QhMc73OlY9gttqyuucBuX95WRWpjon938r+MyEsdQs4iK/u5tmxugVuar+J9v2SaQmRmKUwCVS3v8pZDl2l8CvsSR23f1zlv0SZd3Jg8g0EYwp1PaB/8mSlOdn2DRjuOfaN4+F7kFJErKXMid0qANhx9Kn5OuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Yh3hW3Xg; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1763027071; x=1763631871; i=quwenruo.btrfs@gmx.com;
	bh=jf6rwGRQcmL6Xf9p64Ui28QKo0E6whqRVLflRLEDoK0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Yh3hW3XgYMCqKQeR9Hg/u/CCT4ARWyjFnnZO48uXMIE56oSVMiJTC9z2BE8w0oxq
	 gFc/i0mn+fHLjhQL1WDGEP8yh1mCkD0efDf4RpH0/iwxuvh2n0lONPfMDsaUvQ3kU
	 BwbswLmku5vAAw9l4KAexAmTg9t3ppjfuJcJUkPQV+lm/NTNqrBl/iDKufG3Grokq
	 vldO5W8ghqPSQIpDZwI8aUVhplJbxU4b02gJwP1rtUpWXRrCagttqiy5HhNuhJpYp
	 7D/3JKekXu/cFX53Q0lCv/HwJIYxd32JyZ8Md+iRuXLHx8ZLDa2z2bN9IQF5cKC2f
	 JfJjqG+Az0rhPYNwtA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MryXN-1vvYRE30Jp-00l9hg; Thu, 13
 Nov 2025 10:44:30 +0100
Message-ID: <6a7a088c-4e6f-4787-8513-bbe20658edcb@gmx.com>
Date: Thu, 13 Nov 2025 20:14:24 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: simplify async csum synchronization
To: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251113093110.2619692-1-neelx@suse.com>
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
In-Reply-To: <20251113093110.2619692-1-neelx@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oZdqUlc0i2as5Pe61w0wvfJl0L9UNvB1h7wtpo+tEjxXGfEx4xj
 dhgmMO19aroqIsridceq91fus2WH5DgEEoMVAprdmUFObpnn7gNNpb1FdUYnzUhZQMxW9vH
 0KZkP5NQXnbiTtcqtDuhN0vGoEXhZyYSMYjTGvrs9zWXAEWesaiMWSs8pJkIjzT19xtxCHc
 usdVUk7gVXe+d2JFigMGA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EgXTi5LnmdM=;NQLKbmGA1FbtbOyOuGPFWX43mGS
 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
 hHRGpK5K7n5vfxYmM=



=E5=9C=A8 2025/11/13 20:01, Daniel Vacek =E5=86=99=E9=81=93:
> We don't need the completion csum_done which marks the csum work
> has been executed. We can simply flush_work() instead.
>=20
> This way we can slim down the btrfs_bio structure by 32 bytes matching
> it's size to what it used to be before introducing the async csums.
> Hence not making any change with respect to the structure size.
> ---
> This is a simple fixup for "btrfs: introduce btrfs_bio::async_csum" in
> for-next and can be squashed into it.
> ---
>   fs/btrfs/bio.c       | 2 +-
>   fs/btrfs/bio.h       | 1 -
>   fs/btrfs/file-item.c | 6 +++---
>   3 files changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index a73652b8724a..fd6e4278a62f 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -106,7 +106,7 @@ void btrfs_bio_end_io(struct btrfs_bio *bbio, blk_st=
atus_t status)
>   	ASSERT(in_task());
>  =20
>   	if (bbio->async_csum)
> -		wait_for_completion(&bbio->csum_done);
> +		flush_work(&bbio->csum_work);
>  =20
>   	bbio->bio.bi_status =3D status;
>   	if (bbio->bio.bi_pool =3D=3D &btrfs_clone_bioset) {
> diff --git a/fs/btrfs/bio.h b/fs/btrfs/bio.h
> index deaeea3becf4..0b09d9122fa2 100644
> --- a/fs/btrfs/bio.h
> +++ b/fs/btrfs/bio.h
> @@ -57,7 +57,6 @@ struct btrfs_bio {
>   			struct btrfs_ordered_extent *ordered;
>   			struct btrfs_ordered_sum *sums;
>   			struct work_struct csum_work;
> -			struct completion csum_done;
>   			struct bvec_iter csum_saved_iter;
>   			u64 orig_physical;
>   		};
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 72be3ede0edf..3e9241f360c8 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -792,7 +792,6 @@ static void csum_one_bio_work(struct work_struct *wo=
rk)
>   	ASSERT(btrfs_op(&bbio->bio) =3D=3D BTRFS_MAP_WRITE);
>   	ASSERT(bbio->async_csum =3D=3D true);
>   	csum_one_bio(bbio, &bbio->csum_saved_iter);
> -	complete(&bbio->csum_done);
>   }
>  =20
>   /*
> @@ -805,6 +804,7 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio, bool =
async)
>   	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>   	struct bio *bio =3D &bbio->bio;
>   	struct btrfs_ordered_sum *sums;
> +	struct workqueue_struct *wq;
>   	unsigned nofs_flag;
>  =20
>   	nofs_flag =3D memalloc_nofs_save();
> @@ -825,11 +825,11 @@ int btrfs_csum_one_bio(struct btrfs_bio *bbio, boo=
l async)
>   		csum_one_bio(bbio, &bbio->bio.bi_iter);
>   		return 0;
>   	}
> -	init_completion(&bbio->csum_done);
>   	bbio->async_csum =3D true;
>   	bbio->csum_saved_iter =3D bbio->bio.bi_iter;
>   	INIT_WORK(&bbio->csum_work, csum_one_bio_work);
> -	schedule_work(&bbio->csum_work);
> +	wq =3D bio->bi_opf & REQ_META? fs_info->endio_meta_workers: fs_info->e=
ndio_workers;

Metadata will not go into btrfs_csum_one_bio(), thus it's fixed to=20
endio_workers().


> +	queue_work(wq, &bbio->csum_work);
>   	return 0;
>   }
>  =20


