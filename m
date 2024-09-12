Return-Path: <linux-btrfs+bounces-7976-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3ED9773AB
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 23:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0608D2826F2
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Sep 2024 21:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2452D1C1AC8;
	Thu, 12 Sep 2024 21:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="KRLaFk+D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1842C80;
	Thu, 12 Sep 2024 21:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726176773; cv=none; b=owXdGtNWz09WurYqPXWYd3I1d7NpLrCIY8MP67xIDHspd52hVxF8VJfIeOwPfNpm+WZ3kwvqYEAuun1Uh4lQt1TowJgPCVEBfE9xfCWNHm6p4piwMdOuwlWXjLY0fm8Z6T2AElF936ijk24Kc9n7rqwjIsHrwL+ka9bV+GL6YP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726176773; c=relaxed/simple;
	bh=1Fzl7TRVTDIErHZq05Ym7/w1xEzQv+aQl7/C5PxAL50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Agdmov5mAhs7y+vDD7osDQu/JV+h/qhCXXf7NLbFRFx3+SqcGcRIJqdC+vYgu5gdv/so+w89w/BPAa2JBYvXCRSA73tHG6z6/w/KpbWsE6qaiRK+L5IpLCUKK6gH8asxEHwwTfPYyNnPDGXT5FYnxoU6oW/4QPbUkPFScdgDROI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=KRLaFk+D; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1726176756; x=1726781556; i=quwenruo.btrfs@gmx.com;
	bh=A7i/HcCWsfKmbwIYy6IUidLYZbj6aiMFfZuIjJtx6nE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=KRLaFk+DI5iStiGWsWa3KZ6U10ToUriyMHqLNEHI5D8bRuBXRjnVurmGYX6fMKm1
	 51ViJkLJb+jzL8kvLycx/Ux040P70zkkZ4EOHSTdrLBEyiIyjqv4VkwQUpEMhGmpY
	 4ugWendf8tPnNqjEkV0m/tLoCS0pkNPf67MOwzSM/Yze7uG47W8IgSt7abEMs2cfa
	 zovDX5MaZrJmVV829I/+Ts8TKlyfxh6A8pTGOBgd6Zj213RZtREMi4Zz0eMfe8rRs
	 2bnxiS3hAUVFtJS2bp3fFivrthWTXkigBgMtI53JhoGXCa98UvG78/qc8aN0kgxmQ
	 DN2DWDe9hRRCnEcM8A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MHG8m-1skThM0MSG-00DKjC; Thu, 12
 Sep 2024 23:32:36 +0200
Message-ID: <a0d0fa88-e67c-4b35-88b4-74c5b15a16bb@gmx.com>
Date: Fri, 13 Sep 2024 07:02:31 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: scrub: skip PREALLOC extents on RAID stripe-tree
To: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 "open list:BTRFS FILE SYSTEM" <linux-btrfs@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>, Qu Wenru <wqu@suse.com>
References: <20240912143312.14442-1-jth@kernel.org>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20240912143312.14442-1-jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Yh/ahhImB5kcoXwItdZAqKKp/7qB0fkAc4UQ3QVU44UKjLXoykS
 cq3ECbx80KK8AWnVxlM4LFZvMp8Dd4BRkopfhPMTMbJzkwZCNnidV++74Nf8GZUquW0aInh
 5PQ95jZan/xy2k+6W3SKfhraUFVlevpuSz4KqKlUN+54NUr8xFFYrIWugds7inLeh7uIQK4
 1a+Tzn9aIur8uc1W8zogw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rhFdnXRV9+I=;/G6wjo9DdFGYpWplR2JZ409DOMV
 39gerWSOCEwezDkTDK/0YujcHMedYAJ3ER20z5v2ZB/xwkmia0baTQnOAflDcfBnA65ZbHOC2
 i+jVzR+rXPTiVAtJoE2GrmPoJr8cdk6zVjnyb3nIbW7DkQ+OtZTpb/K6Fn2qyGIitJckQ2sao
 qgD8Mg1g1NbaEMSLtkQ+e17fji1wc2XkYvs53GLULEiYxvDHLeiCFifn4wtu1dqfITbWW1jh3
 glip9qWgwREFpnVC/V+39do3lc8k9htsIXMS0e3Ryw9D4Cdslv8kf7ISrzd8Fh98eDEhGZbMw
 hSdcCcbyN7lgSnxjN1Z4QHhf1Jt5NG2+VXZcPE1jH4jC+gDZysNNQrvCm2kI2IZmTRjs6tukl
 MCxGZ3klfTpe65v6HqO+0ERkpKO7lP1nyxq7H40jdX3cNfy58Lyk5CkUTBqNnQkxFnuN70QsV
 ZiJd4wyDNCrGq82Ov/zWSrqAdzyuZBhN7vYtbvEH0xdrynUeb/pBkVMNm9BCPXl2mNuFpqrjG
 qEH9hyYRsNRuO1bnCTyVQtzJgJeJ3d15VPhToDNJYwvStSYMm2FMyxOHq/eWI38nwxwnKsGbv
 NfF62BwrazCkZpZYP1BSmnHlne+/Bj6zEj54E7FUtXfYnVhFHoj2eVj+kSoiG0ngSW0AYbPLs
 ugCNRTPu8V7ToZqEJ4yLg1mCGGDnoeL5zQEeqJaUAy9UmEOApfbGqwtd9Rjevw08estN0ZK3U
 4ilWpbgiSuPxt+pogdEwZ5gV0qZ168gcda52xA/6+1A4RWLDCiqovWFe9+BV3d46WIj4Ts8hS
 Z/hUH7H8FknmPnDQIGv3xk9XPRbCQb6ydfsj233TolN/8=



=E5=9C=A8 2024/9/13 00:03, Johannes Thumshirn =E5=86=99=E9=81=93:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> When scrubbing a RAID stripe-tree based filesystem with preallocated
> extents, the btrfs_map_block() called by
> scrub_submit_extent_sector_read() will return ENOENT, because there is
> no RAID stripe-tree entry for preallocated extents. This then causes
> the sector to be marked as a sector with an I/O error.
>
> To prevent this false alert don't mark secotors for that
> btrfs_map_block() returned an ENOENT as I/O errors but skip them.
>
> This results for example in errors in fstests' btrfs/060 .. btrfs/074
> which all perform fsstress and scrub operations. Whit this fix, these
> errors are gone and the tests pass again.
>
> Cc: Qu Wenru <wqu@suse.com>

My concern is, ENOENT can be some real problems other than PREALLOC.
I'd prefer this to be the last-resort method.

Would it be possible to create an RST entry for preallocated operations
manually? E.g. without creating a dummy OE, but just insert the needed
RST entries into RST tree at fallocate time?

Thanks,
Qu

> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/scrub.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 3a3427428074..b195c41676e3 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -1657,7 +1657,7 @@ static u32 stripe_length(const struct scrub_stripe=
 *stripe)
>   }
>
>   static void scrub_submit_extent_sector_read(struct scrub_ctx *sctx,
> -					    struct scrub_stripe *stripe)
> +					   struct scrub_stripe *stripe)
>   {
>   	struct btrfs_fs_info *fs_info =3D stripe->bg->fs_info;
>   	struct btrfs_bio *bbio =3D NULL;
> @@ -1703,10 +1703,21 @@ static void scrub_submit_extent_sector_read(stru=
ct scrub_ctx *sctx,
>   			err =3D btrfs_map_block(fs_info, BTRFS_MAP_READ, logical,
>   					      &stripe_len, &bioc, &io_stripe, &mirror);
>   			btrfs_put_bioc(bioc);
> -			if (err < 0) {
> +			if (err < 0 && err !=3D -ENOENT) {
>   				set_bit(i, &stripe->io_error_bitmap);
>   				set_bit(i, &stripe->error_bitmap);
>   				continue;
> +			} else if (err =3D=3D -ENOENT) {
> +				/*
> +				 * btrfs_map_block() returns -ENOENT if it can't
> +				 * find the logical  address in the RAID stripe
> +				 * tree. This can happens on PREALLOC  extents.
> +				 * As we know the extent tree  has an extent
> +				 * recorded there, we can be sure this is a
> +				 * PREALLOC  extent, so skip this sector and
> +				 * continue to the next.
> +				 */
> +				continue;
>   			}
>
>   			bbio =3D btrfs_bio_alloc(stripe->nr_sectors, REQ_OP_READ,

