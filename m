Return-Path: <linux-btrfs+bounces-6252-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA14928F80
	for <lists+linux-btrfs@lfdr.de>; Sat,  6 Jul 2024 01:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 468BC1C2230B
	for <lists+linux-btrfs@lfdr.de>; Fri,  5 Jul 2024 23:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3791482F8;
	Fri,  5 Jul 2024 23:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="RH18t34m"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B239B3A8CB;
	Fri,  5 Jul 2024 23:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720221588; cv=none; b=pASHStHbB5OcvQccbfkIMKxU66M8tGCKyaGWSByMu+8CWOVXHOnSvIXwSq8RjGriUuNtPCWtNDOnNoZQqAUINTIoKBfsKAaosfxmh6X4ZrMJkTWXGJr7azQN0zZ0Ov2xJjkd4ugxqLY02y2zX/CSoDdQi2Y/LKhey+1FnnDjIDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720221588; c=relaxed/simple;
	bh=wd3o2UiFtRW0GhIK5ovjLNqt6QHxcm7lu6zWI/tTOsI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h1O7mtW/ui534Jgaip4Hzr1FhrRSZdPJmMzW0kaGrNqIc+SdtwWjqosz4z506UtuzujAfjFjhGURxM9MJxj3Pvzekmlti8lm+ExN8SkfV/6eHUVWHG5UpY6r+BAEvDsk0voBqx/I4pbNL5tUmP0lq80zDB+MU1EUjAZJbEuvMME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=RH18t34m; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1720221573; x=1720826373; i=quwenruo.btrfs@gmx.com;
	bh=yXR7tbO7KPHj+ZgW/+Rr2FCRBXpUlZOIJVkAlRHid/A=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=RH18t34m8FE5c5glncFlphCffXNPgW6EUWdZbvA/nz1zSVxWWTilEuLF7maMgV31
	 Xbg+kSdchZKofuSACX7ZDElk4q2VIx9F1RuY068pwiL9umcx/IMglMuvbPeKYaO09
	 Ln1hjR08PPnMXFeyG1NS39yzHwHXKq1czqos4jASMnFbisjhogWB1ro3bPgMkqu0S
	 uQrvFhH5iNjXe2tMtUo0m5Hg7wdT/oyocs8ommri3ZZWhVv4nHBdzeQfio2pVHYMT
	 CWlE+mvZrdH2McpQkbopp8v1Z0usf43l4eSV4XolMfZ9FA9TjG4oiji7CIQEGZFj9
	 EBGOVn1E+gt40FBxKA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3UV8-1sQQB50bYo-002gN6; Sat, 06
 Jul 2024 01:19:33 +0200
Message-ID: <e51d0042-ec10-4a50-bd76-3d3d3cbc9bfc@gmx.com>
Date: Sat, 6 Jul 2024 08:49:28 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/7] btrfs: replace stripe extents
To: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240705-b4-rst-updates-v4-0-f3eed3f2cfad@kernel.org>
 <20240705-b4-rst-updates-v4-1-f3eed3f2cfad@kernel.org>
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
In-Reply-To: <20240705-b4-rst-updates-v4-1-f3eed3f2cfad@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:U7gqOFCiBOICmvU9aWrhgOX+lUid0sVZrzhKM17SG1YM3j3pAq6
 aXgxhLU2DSHuxsT+IqCN3MdgDRLQGg55xD1EdCbl+N0B/SAwWyBpUcYoG4Qu348ei1iUaIG
 1LprDrUtANOahhxugequ5Io7krj7s4BFkWVj0H3aia1CqoCoz0T/xdgV6Mn97QQICk72rqV
 0qTYq+eyTMXLiYAPXezHw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:I9BFu9wFrxY=;J7tjGf0Hcmoh0o4ccZmT1iTrOsz
 daXFRG/Wu6xdTFRQ2PNAqcvrYY3qasWwAvg+bFrFPfHbrNLQHtu9dwtmrlG4y+S9cVllRf+A6
 WaSdmmOUGi2xo8voh29meXiHYmjQumaWf4ylllvglG6/kV5OJ144DB0BkFhaHjHTPf6yBe1mn
 j99J0ty4XKpjzNG4jkbMZTRfN7d8gNNAnYKzShLy5IaSqCK8X5Rb2kxjkQw09bRuvvcIhCSCi
 Ino+BSNsw3TSP4D4L2oZtddtDDoeYQMM4uWTs6g/xunNVSuQ0RAJ7sI7WJWmx8N+cN7YyIdAd
 tWOo3omaioHJdB2MgrSB6Lid1FpwR1kxTp9EE7eg34Q2EQWdSkQJ5KYKWvrGRTQ6ZAD/2pDSn
 ScppUxad3Z0PJwcQaWWyvR62qLutdWWWQ/63Ceq6HCuuCYH09WmIMSPP7tSIPXHpuHHkvRUT+
 BuR6GQJSr8D8ozHwkrMkt4/L17u6Ej9vH2oK5XYMS3nyec8asCda4C8dXvtPHpA3kQ8Jns4+y
 AQLTf5sjNUz4vlAXBHC7wjVTSxZMzIgSivu6YFbaKlkUBBjdn3jnKIlRAARy7VDMxhseUIVTD
 hqfaUKUUViYxfOgjH00N52bS1CLmdtYWJ4/z0DWtGXimzngBG3kJgNxlrPzbGQSeQQUF/AScW
 mfukmcfRJgzgWb0Oj3Y1DstgApzTP7syzXKbBRgg5pRRP6YwmCB22tsCWY2wvOrILkaxlPGR8
 6SxGUDGsVsA0uJNG9ekG8UCtJx2lUB3sGnm3mKUgEZ+RgoNTzknwTQjIBp0wbrvTN6vgavZ4X
 Iq/3cymsTC9KOsOCoQZzz1xwhXfPPHCZkYmrSUjSTksos=



=E5=9C=A8 2024/7/6 00:43, Johannes Thumshirn =E5=86=99=E9=81=93:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> If we can't insert a stripe extent in the RAID stripe tree, because
> the key that points to the specific position in the stripe tree is
> already existing, we have to remove the item and then replace it by a
> new item.
>
> This can happen for example on device replace operations.

In that case, can we just modify the targeted dev stripe?

Or do we have other call sites that can lead to such conflicts?

As I'm not that confident if such replace behavior would mask some real
problems.

Thanks,
Qu

>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/raid-stripe-tree.c | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
>
> diff --git a/fs/btrfs/raid-stripe-tree.c b/fs/btrfs/raid-stripe-tree.c
> index e6f7a234b8f6..3b32e96c33fc 100644
> --- a/fs/btrfs/raid-stripe-tree.c
> +++ b/fs/btrfs/raid-stripe-tree.c
> @@ -73,6 +73,39 @@ int btrfs_delete_raid_extent(struct btrfs_trans_handl=
e *trans, u64 start, u64 le
>   	return ret;
>   }
>
> +static int replace_raid_extent_item(struct btrfs_trans_handle *trans,
> +				    struct btrfs_key *key,
> +				    struct btrfs_stripe_extent *stripe_extent,
> +				    const size_t item_size)
> +{
> +	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> +	struct btrfs_root *stripe_root =3D fs_info->stripe_root;
> +	struct btrfs_path *path;
> +	int ret;
> +
> +	path =3D btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	ret =3D btrfs_search_slot(trans, stripe_root, key, path, -1, 1);
> +	if (ret)
> +		goto err;
> +
> +	ret =3D btrfs_del_item(trans, stripe_root, path);
> +	if (ret) {
> +		ret =3D (ret =3D=3D 1) ? -ENOENT : ret;
> +		goto err;
> +	}
> +
> +	btrfs_free_path(path);
> +
> +	return btrfs_insert_item(trans, stripe_root, key, stripe_extent,
> +				 item_size);
> + err:
> +	btrfs_free_path(path);
> +	return ret;
> +}
> +
>   static int btrfs_insert_one_raid_extent(struct btrfs_trans_handle *tra=
ns,
>   					struct btrfs_io_context *bioc)
>   {
> @@ -112,6 +145,9 @@ static int btrfs_insert_one_raid_extent(struct btrfs=
_trans_handle *trans,
>
>   	ret =3D btrfs_insert_item(trans, stripe_root, &stripe_key, stripe_ext=
ent,
>   				item_size);
> +	if (ret =3D=3D -EEXIST)
> +		ret =3D replace_raid_extent_item(trans, &stripe_key,
> +					       stripe_extent, item_size);
>   	if (ret)
>   		btrfs_abort_transaction(trans, ret);
>
>

