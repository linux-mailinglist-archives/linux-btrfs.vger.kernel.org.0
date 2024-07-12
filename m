Return-Path: <linux-btrfs+bounces-6417-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C3A92F8CE
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 12:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AC7F1C21C0F
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jul 2024 10:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F64157E84;
	Fri, 12 Jul 2024 10:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="M3Nrm7bl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDD310F7;
	Fri, 12 Jul 2024 10:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720779592; cv=none; b=us1AG/eCsXGMwKZfaf+nSvbbjjhjTDtzXBVazJPbzRZ9dhwkQ6QOOVp+H9bsZVIBXDfuaXihJaZx12tnmpVaRnORGz0ETEvhpLuLoyAA0MBbFG3Nb+zuOuZbKxCSC/ltm00lvJ/B2VcNkFfvRxFpFIixiQz7Ca5tbhD1HwJkP8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720779592; c=relaxed/simple;
	bh=Un1a07FROyat4k4vFZaNMvE2EYoFghmOeX+5Sma2rwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prur91YNHlrh7YH9uifDGFu7HKX78hTo7id38j/m0jSnRhLuaMvaybt4JtcKwrc7dYkaqyfN1Brb73J+tztY1ryWoSg1hmLMEPbAJXacUU/Em2uaydltoKP2v81mtuCfeoA8bVBDBEgk9W6+FOBrV/cn8y25J+lySbzc/xC9dwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=M3Nrm7bl; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1720779573; x=1721384373; i=quwenruo.btrfs@gmx.com;
	bh=1rH2oPl6vD8El3SjAFZFJYh6+D8M67DLs4BC4nadSq4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=M3Nrm7blML4d9Ydaa+pvws78ZwQ3DSlMbpD6dOrx9HuJZkqlfjypFuw4Z8G8Yqwt
	 kImymFKV+uFcgTE+5yzEw85X1GzfQ7vdYgGBJS5qL55AoGHZKl/WJyUpbocAEFcTU
	 g6SirJPwxsh76pOjjS0EpLMZuCV7HWSVT7YgXWxgzheLoiB+VkVyDWosTSC9DIU91
	 wj6NDO37wF/eebLIs2Bcv5WBUW1Y7y9pnp+bQK23HIf1p/AL1d4+HZx0NBueF4U3f
	 Hd3fzlhWu76Yz+yEpiKOPYhy1oZ1aU3xOTdnkkE5JvUEe58oyxVNnKqT7TJj6g5nf
	 H4fclbM+Hr/h3CbiAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mkpap-1s5Zb00N5T-00cXHr; Fri, 12
 Jul 2024 12:19:33 +0200
Message-ID: <3252790e-1b13-45b2-bacc-96b502b55eb3@gmx.com>
Date: Fri, 12 Jul 2024 19:49:28 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] btrfs: replace stripe extents
To: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Qu Wenru <wqu@suse.com>, Filipe Manana <fdmanana@suse.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240712-b4-rst-updates-v3-0-5cf27dac98a7@kernel.org>
 <20240712-b4-rst-updates-v3-2-5cf27dac98a7@kernel.org>
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
In-Reply-To: <20240712-b4-rst-updates-v3-2-5cf27dac98a7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZUCvNtrx+nO4HyMSGfqN2xfllP+uG8nKfyGG0H6EOElDxM5ASBc
 g7tOLqSboys3/qapLsvTxKkKrfOMry+bHjh+6Eno9qhlFMPHhqnchzh9RMna7QLSePTrRKO
 Fw1TLgSLTLYYRYdwXNedrQ6Kp26iFMiXASe1L4JDGSONa7qWBA/uVGKmiwIpRX2ojUpRFOi
 xZSRRs4f7ICLF1rf/xbDA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jOLZHsSVuAw=;uKkGdp2tfD6WDS8nsPwjU5eGtfG
 X0t77OejWRuX3nqz1K7UptrDNH7aSORC69SuyKC4yx2BtGT4GwxOLORWf27G1zhJa4t8GH4On
 QVHPZZY8gm03MIDVsCMwtydPdaSn8OxwJpgP4y0pTmddkIJ6I0YXxV+EbDf/G393hBmlnPD0V
 c7jg3JfL83lLf3ABq0+aMWsHDebL83hm1ApfrZ8ajXbe74pzLS9RFfNUDShnhBKQ2W/d7FHaD
 8fFnSZnRt2rHaB2NrFKXKssr8h0+8DT2kgHNd/CSs64EA/lIFcz3LhHdm45bfjRCRUqX4XvrY
 QmC5zvo/mtTNDTHNNmqeOKJ83+ElczgKdljohslWADTOH8C19nsSOfcrKaU/1XsS8PhmelDuh
 BKbGadfRleyljSc3eev1xgNovQndRcal9IJ41wd4uYBWrtu6SQ9t4z3Ng0i62RGWwSk/We/48
 2BArLW/QHdgLYHlzgXJ2dkLwkNmpo2zowtuFtMD0yzC5EarKWBSxg+8lQuIEUJUVSxepRwjNL
 ZAnlUBt2wIcevXal+x/PsO+WxqxldrYzPjypuCgauYpqYyVUQjWPkAAGCfF9V3o3yyxPVJEjb
 jqcZiYLcCS3Htt7G+sreBjEvO4W+sAGYKqvg6nOvo63wmEvPwUZZo5IleMrDKZJzfyIa4MD8u
 nNeEbl52/cD84V53dFBPlm2X+iE+/CZ5e0iAW7JJQc/AIr4cv2NTKhhNXlErgwKJOD/Cq5e6S
 rvaaH8EWQLiDCYxsEy7FgPT9dyr+W9/EOsPkNBO5NnqFLcaB8jQWuXgIBBcQF//sc0eq9eK6W
 WdNpx2/wmDTzLsB4bXxfCYcw==



=E5=9C=A8 2024/7/12 17:18, Johannes Thumshirn =E5=86=99=E9=81=93:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Update stripe extents in case a write to an already existing address
> incoming.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

> ---
>   fs/btrfs/raid-stripe-tree.c | 33 +++++++++++++++++++++++++++++++++
>   1 file changed, 33 insertions(+)
>
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index e6f7a234b8f6..53ca2c1a32ac 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -73,6 +73,36 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handl=
e *trans, u64 start, u64 le
>   	return ret;
>   }
>
> +static int update_raid_extent_item(struct btrfs_trans_handle *trans,
> +				   struct btrfs_key *key,
> +				   struct btrfs_stripe_extent *stripe_extent,
> +				   const size_t item_size)
> +{
> +	struct btrfs_path *path;
> +	struct extent_buffer *leaf;
> +	int ret;
> +	int slot;
> +
> +	path =3D btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	ret =3D btrfs_search_slot(trans, trans->fs_info->stripe_root, key, pat=
h,
> +				0, 1);
> +	if (ret)
> +		return ret =3D=3D 1 ? ret : -EINVAL;
> +
> +	leaf =3D path->nodes[0];
> +	slot =3D path->slots[0];
> +
> +	write_extent_buffer(leaf, stripe_extent,
> +			    btrfs_item_ptr_offset(leaf, slot), item_size);

Since the replace one should be the same size, an ASSERT() would make it
easier to catch future problems.

Thanks,
Qu
> +	btrfs_mark_buffer_dirty(trans, leaf);
> +	btrfs_free_path(path);
> +
> +	return ret;
> +}
> +
>   static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *tra=
ns,
>   					struct btrfs_io_context *bioc)
>   {
> @@ -112,6 +142,9 @@ static int btrfs_insert_one_raid_extent(struct btrfs=
_trans_handle *trans,
>
>   	ret =3D btrfs_insert_item(trans, stripe_root, &stripe_key, stripe_ext=
ent,
>   				item_size);
> +	if (ret =3D=3D -EEXIST)
> +		ret =3D update_raid_extent_item(trans, &stripe_key, stripe_extent,
> +					      item_size);
>   	if (ret)
>   		btrfs_abort_transaction(trans, ret);
>
>

