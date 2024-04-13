Return-Path: <linux-btrfs+bounces-4204-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70EBB8A3C21
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 12:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9245E1C20F83
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 10:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5503D544;
	Sat, 13 Apr 2024 10:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="BlWmbbpm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD3B1CD16
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 10:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713003076; cv=none; b=ElbK8jUfj4eCIAgBzX9+lZ+CK9mNFAAv8CV4Oph3jmf31A6b5VXHKKMAs46/QDgYe4n/eWhpKsaHLRdcwT6mltr9DqzETY0bSM+dmEvAOAGGtOtPiI9AqL+j+TuzeNTdCATF26bgDXMMpGbCnzWMTb++SQo35cZf7O03bnXODvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713003076; c=relaxed/simple;
	bh=1q0mimv2ouEUC4JxQ/5gVrYfpaf7le4S5QdMc5ZPnpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QvcHz3WdW1ujhN1DmCDOWIdI4iwrb0CXZVU9yor+YJJ8EOdMIEP20Ize+mgCow30+bxvzcN2kYVGW2dTYqT4bXMMqoan/BxDveswW/FrQ819c/aBBY0zp63nJraVo3bnYE9i9DZdU6Piuatm09rGGd9Ylku/OOJKCjtBLSC1PVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=BlWmbbpm; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1713003068; x=1713607868; i=quwenruo.btrfs@gmx.com;
	bh=Eefg/lhhLthkVgkLPfofP5exOljtz3/t7/y3DyArhXE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BlWmbbpmlkP21kvDVGALiRB5llvW/nB8euBFIkh8GKMI268mlGG17JDyfivmPy9P
	 hzePVlQ+ihuA58b5XhLqax8yTQcldJK42q+DhAwyn5wxRRI97ibJhWAswiW1cH8mq
	 5AWzm8swXvvCoqpEpKD8IRlrEk8FVI3h7dswUfmbcHElxejV590v/YZAKCHEe6EH/
	 ROa3p/MU6qCR5YyxEACElGvrHI/+wT+CrthJ5WQIke6q9iB4UuDa0LnIqOny358IX
	 neeXQ3pZPw5DLXBEbm1bCwR5L0tq02sQd2ncA7HSw0pqddkhAoQgU85hgRgPbkeg1
	 12g4Nytd9nqswkJlKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MacOQ-1sSA0f2kBu-00cAxx; Sat, 13
 Apr 2024 12:11:08 +0200
Message-ID: <da03fb9a-ff58-482c-b0ab-8e24a9c47166@gmx.com>
Date: Sat, 13 Apr 2024 19:41:05 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] btrfs: add function comment to
 btrfs_lookup_csums_list()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1712933003.git.fdmanana@suse.com>
 <6cd95c2965fedf3f2b2d8b5dbf1dcbb072067192.1712933005.git.fdmanana@suse.com>
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
In-Reply-To: <6cd95c2965fedf3f2b2d8b5dbf1dcbb072067192.1712933005.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L276vLKmzopb+tR9YTS891QKBYNyy4nyi1OAzjtFhm6apuQdO4B
 NbjoxLnprrDAmh5xssqcTYKK2RlqPaMd/NBI6GNljVdrjrDOWANZexMvCxtGYR7e+4yMrOf
 laro1z4F5NIFLpuIZ3omjRBHf6exuZFhz52Vb+Xl8Pg3m2Lk8nKhGgC4CJRT1XzYgJUtK0I
 ksKCXo3/NtcYk9o2vIBgw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NeSFDKqhYxo=;AyztB+k214a85UL+1MDbzySS2lJ
 rhgScMkNpI/g02nSfLZUgAtE28ZOXW2mn3aBZsq+hLGOkQk3TU+5CLqfnKOpRhqs2rKG2W7Wi
 x03BHoHwiIgOOAnQVupCSvyK3Uamm0jRF08Ypxe2kOzCXyB+UTrPkqFjYkRLDos0raVDBfI8v
 LfnidX7bjiyph9BH/hXK2z7cYN0nDyObeenvd8EQ6tIWU3M1wR1ZmoMPxO9+ZhFetoN953kiC
 gOCnj3J86P8CrsDymOu6RF3JwaNTB1fQOpQtdJXJ7cL7s9RVBIF39Otz6bY1S5klmbVoXf1CZ
 bdIQ/QQf7hr6Q/78LdjyMR57YysQr147xe/WaT8eF/HLY8eGFGCkYF3a4KiyjuxJLwiu90Uw0
 h5sFbX90pxMq3OiQLK3ZMD5ctKyFTqeG8tretoteBUDRfnZOeEbLtoDZqv6gxpFXgIzWTmAW/
 JoVqObIzJ73cP4YvrkvnRtvcsqvQ3U92PkY42UmcULMt3jANpYpMYRurOnj+c6XySEHGIHCEY
 9rsxa/YwMUuTzMof8ewdKvDAO+lhY3HfgYh5psIxCG9TytTfax0x1kv8S7CMmkXywYX1N45QF
 kZzegZnCDHq/JonXs1PPBl8OGwrIxm3qk4jJYMDEJGjQUYHXOC27bM3X2femUfu+XDgg9oeQ2
 kaQYW0BW17EvSfUQud34DEegPJ4Z6KJk7H4Ju2IsU01bcJ5pqlYHgizpq4y0Xk/l9ocA5zMpR
 9QRYqY33j5Y3Rr0TyPr4L3+KBUnSm5wjUIkr1nsNS3dz6/01K815smcrrVKI02xgAebqTU15R
 fPBtG1KCpsfJHzLvnyHO82UEGpVSZyWlBgmbWzgktfL80=



=E5=9C=A8 2024/4/13 00:33, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Add a function comment to btrfs_lookup_csums_list() to document it.
> With another upcoming change its parameter list and return value will be
> less obvious. So add the documentation now so that it can be updated whe=
re
> needed later.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/file-item.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index e58fb5347e65..909438540119 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -450,6 +450,19 @@ blk_status_t btrfs_lookup_bio_sums(struct btrfs_bio=
 *bbio)
>   	return ret;
>   }
>
> +/*
> + * Search for checksums for a given logical range.
> + *
> + * @root:		The root where to look for checksums.
> + * @start:		Logical address of target checksum range.
> + * @end:		End offset (inclusive) of the target checksum range.
> + * @list:		List for adding each checksum that was found.
> + * @search_commit:	Indicate if the commit root of the @root should be u=
sed
> + *			for the search.
> + * @nowait:		Indicate if the search must be non-blocking or not.
> + *
> + * Return < 0 on error and 0 on success.
> + */
>   int btrfs_lookup_csums_list(struct btrfs_root *root, u64 start, u64 en=
d,
>   			    struct list_head *list, int search_commit,
>   			    bool nowait)

