Return-Path: <linux-btrfs+bounces-4202-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1799D8A3C1D
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 12:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BCF41C21349
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Apr 2024 10:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AD1208B8;
	Sat, 13 Apr 2024 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="mRmc3Y5i"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E56E556
	for <linux-btrfs@vger.kernel.org>; Sat, 13 Apr 2024 10:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713002937; cv=none; b=T5eH+4joZTJKIP7jERZ1TbRvV8VqqlSE0T00D/oXcRQUS2AUataEdRkYuqz2SCrbjkKq1u/oZqPJxKGY/XJYA8uGzNfj8pnPRNZ3fB82+0fyCCfYmKekk0l+z2EFYoALOSD6OObpzc2ASoWxnE5/w4+2BuiY3px8Xem4R78eiZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713002937; c=relaxed/simple;
	bh=+frWvdkSzW1kXeCixKvoWisQdJ2ccRLgY3bTLu5ijPg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KtLU3v9U5zKxFLSEuGu3Qyi7ouXx8GMRe0kHUPGxKmqgvD2BiGPPdRhKve4lxQSzmhW+USAwFTa2sye5ZAgOk/Vur+zMu+uf6qzmPz8jYgd3XvLg6Zrr7EprTnclD5LKGsS3pBrWVoRIWMnIbhCXXdDYrEDas14GMU+8Du+8J9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=mRmc3Y5i; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1713002928; x=1713607728; i=quwenruo.btrfs@gmx.com;
	bh=VRIYlB+9A90DOxAuSv5lNR2rloN/wbqTXl1JocVyk7o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mRmc3Y5iIgYo099VDXrGSK4iL+ljt4eGrkuK76lxmrKm2ppzzZZwZ2u2reEKK4qL
	 VelTR3PTNzaJwR23hUouGwwTqnJsT16j0K/CttK7lVhdozEE6gtN/2dz2ERiz0nUl
	 9S+OSa1UgK2a5++d8GeCxRHqQqhY10W1458SIs1u7mSIS5U4pdmh56xdGx4hZt6L1
	 C3IFf1Kt16XgZuVqE8doMZu5CpxDvezONzhXXrOrK4oz3gX+8dSPJyqKHyUhCTZmW
	 6a0Cfi6J7jRqNPeNhIqqXux60LqruryetbpaPXrvBFkS1W3EfB7IPHBTP+A9QpX6a
	 asKPDtZQG58z3bDORg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8QS8-1rrAT92gIS-004WS1; Sat, 13
 Apr 2024 12:08:48 +0200
Message-ID: <29de89df-273c-40b2-8636-ce6246b45f46@gmx.com>
Date: Sat, 13 Apr 2024 19:38:44 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] btrfs: remove use of a temporary list at
 btrfs_lookup_csums_list()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1712933003.git.fdmanana@suse.com>
 <5ba3b6e48c1e7433b1e38ae315713d7b31813730.1712933005.git.fdmanana@suse.com>
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
In-Reply-To: <5ba3b6e48c1e7433b1e38ae315713d7b31813730.1712933005.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QTTwyDeCnijGaddzpsIRtDp4GpMk23s7Ugo5sBbRshEnlYMhMjL
 uHDp4l/LUh+Vi/O4FKzTLuWkdqrXVBEE6+uXcZlhbtT1mNeqT7aEOlRbVSeiBV3FE+5mz5z
 l4i4PYIjzv2qbuu5bduVuuvhxBLy9fvrVg1tiA7aY5XNJjefwcctqd3puyfaobqqtXia/30
 87iWGWACT5b1tf+Euk4dA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:fYSUGspxOO0=;YA+mYgUryVXjV1oX3oD5m/k1Koo
 1xJlcQHUR/KxVHIH0qY6bTv7VURE43n5qXuYjeLn0+Aw5nUGDf3X5yZ6lrJBNXliJDakGQIXx
 uqAmO9b0I474K/mBlzSNz+BUQQcwzGtSeu/MZVc1Nxb2i5K6jReVHrqx0SsjUs5MI7tJqrsTw
 D9g4+Ru2EmSJZZ1kksU5auNaHaM1LIpmI/Fd2V2sh903qKq8Tsyl5e9FkwxlYgQ2D+lpk5l2g
 LTnG68zvYZvjQuf+mtdkagsm07DxHjQOIik++MUUIcvXIY0+eCR36PCSt5BNdB+LujiX7GHvF
 09d20hDAFSIznyCLQk80CA1WY2w1c8dWLNFX/fcxSXE4Uq6Z8Ep5CVOtWtgnH9vDgIRw9VT5Q
 koM1nefMqjtXHl12L+bxXEU55fmZfUqWLd8pkhTZVghs6arlcmRuF3D3F0MO/f2QyBnFhrl+s
 3UJENhI1lmct+JtKgUjYIy779EVDvGn3tkvbyDTXdfpW9BnLUzOy9eg6ehHQtfbJI2ot6VPZt
 WN1VgGy/kyAtJrtJzjZZ5lBGID54u06K1EWn6NdVE2TPiVQbiD4Q3rBFA1IVJPf7NZsarGRWT
 jNHra6yUPoMq1ha4xQx7LrJHRXcZTy0D9UQ1fNI94AZcrkmpNG/F1McZM+7VwSfWW0dkx9UlT
 fIHQ4OJFrkiPmxfGqLkkydF3DwW85wwNXaH+ujBl2LekaNJ7uYrC6P/JAtk0qt+ppsEO3fqBa
 SgAuRrM6n5XKDmKbpuhB8Le//qwe8xkrHahpA4gEBGbWCp9TvOBw2dEPL8keXBkqF1czVIfkO
 I0luducu2B69RYNsFoFSvYIfk9lpDHPqnff9uz8+TSQ+8=



=E5=9C=A8 2024/4/13 00:33, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> There's no need to use a temporary list to add the checksums, we can jus=
t
> add them to input list and then on error delete and free any checksums
> that were added. So simplify and remove the temporary list.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Initially I'm not sure if this would bring a behavior change as csum
tree search failure would free any existing csum items, but all the call
sites pass an empty list into the function anyway, so it's completely fine=
.

Thanks,
Qu
> ---
>   fs/btrfs/file-item.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/fs/btrfs/file-item.c b/fs/btrfs/file-item.c
> index 0712a0aa2dd0..c2799325706f 100644
> --- a/fs/btrfs/file-item.c
> +++ b/fs/btrfs/file-item.c
> @@ -470,7 +470,6 @@ int btrfs_lookup_csums_list(struct btrfs_root *root,=
 u64 start, u64 end,
>   	struct extent_buffer *leaf;
>   	struct btrfs_ordered_sum *sums;
>   	struct btrfs_csum_item *item;
> -	LIST_HEAD(tmplist);
>   	int ret;
>
>   	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
> @@ -572,18 +571,17 @@ int btrfs_lookup_csums_list(struct btrfs_root *roo=
t, u64 start, u64 end,
>   					   bytes_to_csum_size(fs_info, size));
>
>   			start +=3D size;
> -			list_add_tail(&sums->list, &tmplist);
> +			list_add_tail(&sums->list, list);
>   		}
>   		path->slots[0]++;
>   	}
>   	ret =3D 0;
>   fail:
> -	while (ret < 0 && !list_empty(&tmplist)) {
> -		sums =3D list_entry(tmplist.next, struct btrfs_ordered_sum, list);
> +	while (ret < 0 && !list_empty(list)) {
> +		sums =3D list_entry(list->next, struct btrfs_ordered_sum, list);
>   		list_del(&sums->list);
>   		kfree(sums);
>   	}
> -	list_splice_tail(&tmplist, list);
>
>   	btrfs_free_path(path);
>   	return ret;

