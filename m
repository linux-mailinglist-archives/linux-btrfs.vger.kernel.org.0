Return-Path: <linux-btrfs+bounces-15135-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8B3AEE973
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 23:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442351BC099B
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 21:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B56C230BE9;
	Mon, 30 Jun 2025 21:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="sp9kkYQ0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778882AD2F
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 21:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751319041; cv=none; b=kZun6yPBnQupdVVHZt5vEKw8UpH96wA3pBc/R/nYMPknahWHfvKr282aHbtxgYZU/DpY0ggeZuXgCBao/C9rOjgrx04oFKFgSTQMkopBgObyytMuHHRp8s9F24l+QT6mIsCXvvtuW0G2swM6KdCPj81Vh7dBGAUh2uKAHq9QfyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751319041; c=relaxed/simple;
	bh=olaSjuzDAg+68KwVQZOvHcopj+g/iPXFgFfwjGs3s2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aAL5l+IjUc4JRuEQFtAURH4Eb2yybGiiEyneQvDelx9l7yNU2gHNB3HRBe6CxFfE83nTvx6lePJkyN1383hSJnQKlKpAwBN+mH+dLJRFjclN0ADbi9qJ7Rf51XpHGeLCGD04tmrlWwmmEWy83LRHvzlxjgIu2RnlltEtaCyXYbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=sp9kkYQ0; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1751319033; x=1751923833; i=quwenruo.btrfs@gmx.com;
	bh=rM896DhjN6cRCHAfGcgp4lShNk5AwwwyUKwJV55ppgg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sp9kkYQ0HV0YoIc2opwNmNJuQx3Vb/cm5/fA2uEwBpykOx/3ijV+/a8Jjq/pGpot
	 5u3f47MAcLX1Z8/ta44JtHB2/JVe/cjEN1RsU7imX9hDWt/V0bRAC2AlBbRyNLMWz
	 4uH+eFFJsQKcSM52+m1mDbXL6Lf+rXWGLeJ/bHEf9ykBO5UNDUJShSYHYB4W2OlQK
	 vpHBG6hzYu3kChabOSArwn34swPUmmCPKBguinQulFh2VtnYUlAVyLoLLAvMJDgvf
	 kmHUEnepvvkbjVJpH65PlRLYQAARmfE0FgGbyIqKHGs0u7+p9fPKPUAeQd3bFQyN2
	 RRr+b22ctLTJscdqfg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MqJqN-1v0W9j30BX-00fY9g; Mon, 30
 Jun 2025 23:30:33 +0200
Message-ID: <01442a4a-ba38-4821-a63b-9c3f112905a0@gmx.com>
Date: Tue, 1 Jul 2025 07:00:29 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: change dump_block_groups in btrfs_dump_space_info
 from int to bool
To: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20250630144735.224222-1-jth@kernel.org>
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
In-Reply-To: <20250630144735.224222-1-jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oXYLs6PiU8RvnAuNebJVLIrsbBxm9NK6sJGywZQx5xmmDeXhYdR
 /mdrIOInmS/eB6LPkAlqGWbiQLHj5x72iWVYDGZuMkg3oexlHwvfzm7noPnoDMEmA13kdxo
 uKbshkt47MnXMBa6BgfSepcRLLLRtOuEv3wYR0Hqrh+TpjSlE2oHqhiTWYl3WJF/MfT5kH1
 SlEoAqM9IC3iWeiunuE0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0YSHZRrFYrc=;bhB+p5BUIdgP0q7pubjAUDznn2U
 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
 zQ==



=E5=9C=A8 2025/7/1 00:17, Johannes Thumshirn =E5=86=99=E9=81=93:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>=20
> btrfs_dump_space_info()'s parameter dump_block_groups is used as a boole=
an
> although it is defined as an integer.
>=20
> Change it from int to bool.
>=20
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu


> ---
>   fs/btrfs/block-group.c | 8 ++++----
>   fs/btrfs/space-info.c  | 7 ++++---
>   fs/btrfs/space-info.h  | 2 +-
>   3 files changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 4259d955e70f..dc0b29ed46c0 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1417,7 +1417,7 @@ static int inc_block_group_ro(struct btrfs_block_g=
roup *cache, int force)
>   	if (ret =3D=3D -ENOSPC && btrfs_test_opt(cache->fs_info, ENOSPC_DEBUG=
)) {
>   		btrfs_info(cache->fs_info,
>   			"unable to make block group %llu ro", cache->start);
> -		btrfs_dump_space_info(cache->fs_info, cache->space_info, 0, 0);
> +		btrfs_dump_space_info(cache->fs_info, cache->space_info, 0, false);
>   	}
>   	return ret;
>   }
> @@ -4315,7 +4315,7 @@ static void reserve_chunk_space(struct btrfs_trans=
_handle *trans,
>   	if (left < bytes && btrfs_test_opt(fs_info, ENOSPC_DEBUG)) {
>   		btrfs_info(fs_info, "left=3D%llu, need=3D%llu, flags=3D%llu",
>   			   left, bytes, type);
> -		btrfs_dump_space_info(fs_info, info, 0, 0);
> +		btrfs_dump_space_info(fs_info, info, 0, false);
>   	}
>  =20
>   	if (left < bytes) {
> @@ -4460,7 +4460,7 @@ static void check_removing_space_info(struct btrfs=
_space_info *space_info)
>   	 * indicates a real bug if this happens.
>   	 */
>   	if (WARN_ON(space_info->bytes_pinned > 0 || space_info->bytes_may_use=
 > 0))
> -		btrfs_dump_space_info(info, space_info, 0, 0);
> +		btrfs_dump_space_info(info, space_info, 0, false);
>  =20
>   	/*
>   	 * If there was a failure to cleanup a log tree, very likely due to a=
n
> @@ -4471,7 +4471,7 @@ static void check_removing_space_info(struct btrfs=
_space_info *space_info)
>   	if (!(space_info->flags & BTRFS_BLOCK_GROUP_METADATA) ||
>   	    !BTRFS_FS_LOG_CLEANUP_ERROR(info)) {
>   		if (WARN_ON(space_info->bytes_reserved > 0))
> -			btrfs_dump_space_info(info, space_info, 0, 0);
> +			btrfs_dump_space_info(info, space_info, 0, false);
>   	}
>  =20
>   	WARN_ON(space_info->reclaim_size > 0);
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 102fcc34ffe2..65cc36ef3f75 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -615,7 +615,7 @@ static void __btrfs_dump_space_info(const struct btr=
fs_fs_info *fs_info,
>  =20
>   void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
>   			   struct btrfs_space_info *info, u64 bytes,
> -			   int dump_block_groups)
> +			   bool dump_block_groups)
>   {
>   	struct btrfs_block_group *cache;
>   	u64 total_avail =3D 0;
> @@ -1890,7 +1890,8 @@ int btrfs_reserve_metadata_bytes(struct btrfs_fs_i=
nfo *fs_info,
>   					      space_info->flags, orig_bytes, 1);
>  =20
>   		if (btrfs_test_opt(fs_info, ENOSPC_DEBUG))
> -			btrfs_dump_space_info(fs_info, space_info, orig_bytes, 0);
> +			btrfs_dump_space_info(fs_info, space_info, orig_bytes,
> +					      false);
>   	}
>   	return ret;
>   }
> @@ -1921,7 +1922,7 @@ int btrfs_reserve_data_bytes(struct btrfs_space_in=
fo *space_info, u64 bytes,
>   		trace_btrfs_space_reservation(fs_info, "space_info:enospc",
>   					      space_info->flags, bytes, 1);
>   		if (btrfs_test_opt(fs_info, ENOSPC_DEBUG))
> -			btrfs_dump_space_info(fs_info, space_info, bytes, 0);
> +			btrfs_dump_space_info(fs_info, space_info, bytes, false);
>   	}
>   	return ret;
>   }
> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index 7de31541ab45..679f22efb407 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -278,7 +278,7 @@ u64 __pure btrfs_space_info_used(const struct btrfs_=
space_info *s_info,
>   void btrfs_clear_space_info_full(struct btrfs_fs_info *info);
>   void btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
>   			   struct btrfs_space_info *info, u64 bytes,
> -			   int dump_block_groups);
> +			   bool dump_block_groups);
>   int btrfs_reserve_metadata_bytes(struct btrfs_fs_info *fs_info,
>   				 struct btrfs_space_info *space_info,
>   				 u64 orig_bytes,


