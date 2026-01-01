Return-Path: <linux-btrfs+bounces-20057-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34573CECB22
	for <lists+linux-btrfs@lfdr.de>; Thu, 01 Jan 2026 01:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 212563001030
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jan 2026 00:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B68FC1E3DDE;
	Thu,  1 Jan 2026 00:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="OUCgfirr"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BB81C860B
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Jan 2026 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767226812; cv=none; b=eBYinzN4nKpTcu/nTKcMN0XS7dpHoPHY7WUQY5fVVdJtZlcTdaFzt65Bd+XIYR+zy2q1p/8/mwdoOftOh2gcpRUwaTiZ79RFEcqZwrNf2xt+mQKm8ZkSu29moT/K8zl2zVQzNEpF/UveSNfPyA8pajcPgIgwLZYMhK01KxYr4eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767226812; c=relaxed/simple;
	bh=1PBrBNrhJ0GoXvjc3XDo0l1SQFcGrMiqlEXHEm2I5ZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VXNc1GktOA8QqriouRXQGBGIHOAOhNbMEIZkLOa+OGSTL7/rGyrvMAF5jSgCigVllLFeo54PlUEwLlR+5DslIL0iQnr4sRP7NEa301EGGBQdSU+TsaAbSMWUL3tNWHry7Q+D1IJnSvEBQq+UzlPr354bnSuJSdwh0yO/vFZ7ibY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=OUCgfirr; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1767226806; x=1767831606; i=quwenruo.btrfs@gmx.com;
	bh=ZNrm2YM2p6wFWuwjZ2CQUQwCR2a4uZlbDw6wnbKlyqI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OUCgfirrcuI6RPuXE5NnOah0AGRFMVpMc51vi9nDFEnnk8QznUOPrPdFCopIgi8p
	 eBEZsjXcUykYdq21Jqh++QX/7ZwClxGRlWu89vXNq1hp+2He3kk5IfW9Wcm28EdjD
	 4YOw2Cgj3NosfowwNHQV50KLMO/ftoMN/IOpKznyl2L69nmQQ/SNIK6tNGTYPlu2e
	 6I7vFRGvDWUSGhNJOQRDy86cqzptdS9mFBHeFa+gN0AZJRH+8J3Mbmv/wHlcoZbqV
	 S3XXmrQGi7TClP2s0Re5b5xuh4Nj8qiAp4wMBWBuTzp6bNBeebDJ1rBaeB1suWnZ3
	 N0TWyPX7oz1vcje0TQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N63Vi-1vzAhq0z8K-00zuZl; Thu, 01
 Jan 2026 01:20:06 +0100
Message-ID: <d15168bf-f8c4-42c6-9a10-73ef44119318@gmx.com>
Date: Thu, 1 Jan 2026 10:50:04 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] btrfs: fix periodic reclaim condition
To: Sun YangKai <sunk67188@gmail.com>, linux-btrfs@vger.kernel.org
References: <20251231111623.30136-1-sunk67188@gmail.com>
 <20251231111623.30136-8-sunk67188@gmail.com>
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
In-Reply-To: <20251231111623.30136-8-sunk67188@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pJwG+vBgB++9byO3vV+lgXVaMe7LNwsjln38hKuKf5NL0lTBKwA
 h/YMyoTYGaFfeIPNIQQoTYjvvBNtXUD/cac4cIkciSXf+H0YThvJXvvImQiPUzouMmCHv4g
 Ow6vA6DTulotzMetAboB1iTAC8iagWjfY6BiNoouIn6IJfi/9ZW7+M4HFlu6pBZeIMTEj1p
 CA2NBK8cMvdjDQg5EeyeQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3omYfZzbvGY=;ZEm49W8rgpcaM/FsEhY8RokHVIG
 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



=E5=9C=A8 2025/12/31 21:09, Sun YangKai =E5=86=99=E9=81=93:
> Problems with current implementation:
> 1. reclaimable_bytes is signed while chunk_sz is unsigned, causing
>     negative reclaimable_bytes to trigger reclaim unexpectedly
> 2. The "space must be freed between scans" assumption breaks the
>     two-scan requirement: first scan marks block groups, second scan
>     reclaims them. Without the second scan, no reclamation occurs.
>=20
> Instead, track actual reclaim progress: pause reclaim when block groups
> will be reclaimed, and resume only when progress is made. This ensures
> reclaim continues until no further progress can be made, then resumes wh=
en
> space_info changes or new reclaimable groups appear.
>=20
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>

If this is a bug fix indicated by the title, add a proper "Fixes:" tag=20
please.

Thanks,
Qu

> ---
>   fs/btrfs/block-group.c | 15 +++++++--------
>   fs/btrfs/space-info.c  | 42 +++++++++++++++++++-----------------------
>   fs/btrfs/space-info.h  | 26 ++++++++++++++++++--------
>   3 files changed, 44 insertions(+), 39 deletions(-)
>=20
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 944857bd6af6..39e6f1bf3506 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1871,6 +1871,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *wo=
rk)
>   	while (!list_empty(&fs_info->reclaim_bgs)) {
>   		u64 used;
>   		u64 reserved;
> +		u64 old_total;
>   		int ret =3D 0;
>  =20
>   		bg =3D list_first_entry(&fs_info->reclaim_bgs,
> @@ -1936,6 +1937,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *wo=
rk)
>   		}
>  =20
>   		spin_unlock(&bg->lock);
> +		old_total =3D space_info->total_bytes;
>   		spin_unlock(&space_info->lock);
>  =20
>   		/*
> @@ -1988,14 +1990,14 @@ void btrfs_reclaim_bgs_work(struct work_struct *=
work)
>   			reserved =3D 0;
>   			spin_lock(&space_info->lock);
>   			space_info->reclaim_errors++;
> -			if (READ_ONCE(space_info->periodic_reclaim))
> -				space_info->periodic_reclaim_ready =3D false;
>   			spin_unlock(&space_info->lock);
>   		}
>   		spin_lock(&space_info->lock);
>   		space_info->reclaim_count++;
>   		space_info->reclaim_bytes +=3D used;
>   		space_info->reclaim_bytes +=3D reserved;
> +		if (space_info->total_bytes < old_total)
> +			btrfs_resume_periodic_reclaim(space_info);
>   		spin_unlock(&space_info->lock);
>  =20
>   next:
> @@ -3730,8 +3732,6 @@ int btrfs_update_block_group(struct btrfs_trans_ha=
ndle *trans,
>   		space_info->bytes_reserved -=3D num_bytes;
>   		space_info->bytes_used +=3D num_bytes;
>   		space_info->disk_used +=3D num_bytes * factor;
> -		if (READ_ONCE(space_info->periodic_reclaim))
> -			btrfs_space_info_update_reclaimable(space_info, -num_bytes);
>   		spin_unlock(&cache->lock);
>   		spin_unlock(&space_info->lock);
>   	} else {
> @@ -3741,12 +3741,11 @@ int btrfs_update_block_group(struct btrfs_trans_=
handle *trans,
>   		btrfs_space_info_update_bytes_pinned(space_info, num_bytes);
>   		space_info->bytes_used -=3D num_bytes;
>   		space_info->disk_used -=3D num_bytes * factor;
> -		if (READ_ONCE(space_info->periodic_reclaim))
> -			btrfs_space_info_update_reclaimable(space_info, num_bytes);
> -		else
> -			reclaim =3D should_reclaim_block_group(cache, num_bytes);
> +		reclaim =3D should_reclaim_block_group(cache, num_bytes);
>  =20
>   		spin_unlock(&cache->lock);
> +		if (reclaim)
> +			btrfs_resume_periodic_reclaim(space_info);
>   		spin_unlock(&space_info->lock);
>  =20
>   		btrfs_set_extent_bit(&trans->transaction->pinned_extents, bytenr,
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index b6ec09aea64f..dce21809e640 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -2124,43 +2124,39 @@ static void do_reclaim_sweep(struct btrfs_space_=
info *space_info, int raid)
>   	}
>  =20
>   	up_read(&space_info->groups_sem);
> -}
> -
> -void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space=
_info, s64 bytes)
> -{
> -	u64 chunk_sz =3D calc_effective_data_chunk_size(space_info->fs_info);
> -
> -	lockdep_assert_held(&space_info->lock);
> -	space_info->reclaimable_bytes +=3D bytes;
>  =20
> -	if (space_info->reclaimable_bytes >=3D chunk_sz)
> -		btrfs_set_periodic_reclaim_ready(space_info, true);
> -}
> -
> -void btrfs_set_periodic_reclaim_ready(struct btrfs_space_info *space_in=
fo, bool ready)
> -{
> -	lockdep_assert_held(&space_info->lock);
> -	if (!READ_ONCE(space_info->periodic_reclaim))
> -		return;
> -	if (ready !=3D space_info->periodic_reclaim_ready) {
> -		space_info->periodic_reclaim_ready =3D ready;
> -		if (!ready)
> -			space_info->reclaimable_bytes =3D 0;
> +	/*
> +	 * Temporary pause periodic reclaim until reclaim make some progress.
> +	 * This can prevent periodic reclaim keep happening but make no progre=
ss.
> +	 */
> +	if (will_reclaim) {
> +		spin_lock(&space_info->lock);
> +		btrfs_pause_periodic_reclaim(space_info);
> +		spin_unlock(&space_info->lock);
>   	}
>   }
>  =20
>   static bool btrfs_should_periodic_reclaim(struct btrfs_space_info *spa=
ce_info)
>   {
>   	bool ret;
> +	u64 chunk_sz;
> +	u64 unused;
>  =20
>   	if (space_info->flags & BTRFS_BLOCK_GROUP_SYSTEM)
>   		return false;
>   	if (!READ_ONCE(space_info->periodic_reclaim))
>   		return false;
> +	if (!READ_ONCE(space_info->periodic_reclaim_paused))
> +		return true;
> +
> +	chunk_sz =3D calc_effective_data_chunk_size(space_info->fs_info);
>  =20
>   	spin_lock(&space_info->lock);
> -	ret =3D space_info->periodic_reclaim_ready;
> -	btrfs_set_periodic_reclaim_ready(space_info, false);
> +	unused =3D space_info->total_bytes - space_info->bytes_used;
> +	ret =3D (unused >=3D space_info->last_reclaim_unused + chunk_sz ||
> +	       btrfs_calc_reclaim_threshold(space_info) !=3D space_info->last_=
reclaim_threshold);
> +	if (ret)
> +		btrfs_resume_periodic_reclaim(space_info);
>   	spin_unlock(&space_info->lock);
>  =20
>   	return ret;
> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index a4fa04d10722..2ebfe440837b 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -216,12 +216,9 @@ struct btrfs_space_info {
>   	 * Periodic reclaim should be a no-op if a space_info hasn't
>   	 * freed any space since the last time we tried.
>   	 */
> -	bool periodic_reclaim_ready;
> -
> -	/*
> -	 * Net bytes freed or allocated since the last reclaim pass.
> -	 */
> -	s64 reclaimable_bytes;
> +	bool periodic_reclaim_paused;
> +	u8 last_reclaim_threshold;
> +	u64 last_reclaim_unused;
>   };
>  =20
>   static inline bool btrfs_mixed_space_info(const struct btrfs_space_inf=
o *space_info)
> @@ -301,9 +298,22 @@ void btrfs_dump_space_info_for_trans_abort(struct b=
trfs_fs_info *fs_info);
>   void btrfs_init_async_reclaim_work(struct btrfs_fs_info *fs_info);
>   u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *=
sinfo);
>  =20
> -void btrfs_space_info_update_reclaimable(struct btrfs_space_info *space=
_info, s64 bytes);
> -void btrfs_set_periodic_reclaim_ready(struct btrfs_space_info *space_in=
fo, bool ready);
>   u8 btrfs_calc_reclaim_threshold(const struct btrfs_space_info *space_i=
nfo);
> +static inline void btrfs_resume_periodic_reclaim(struct btrfs_space_inf=
o *space_info)
> +{
> +	lockdep_assert_held(&space_info->lock);
> +	if (space_info->periodic_reclaim_paused)
> +		space_info->periodic_reclaim_paused =3D false;
> +}
> +static inline void btrfs_pause_periodic_reclaim(struct btrfs_space_info=
 *space_info)
> +{
> +	lockdep_assert_held(&space_info->lock);
> +	if (!space_info->periodic_reclaim_paused) {
> +		space_info->periodic_reclaim_paused =3D true;
> +		space_info->last_reclaim_threshold =3D btrfs_calc_reclaim_threshold(s=
pace_info);
> +		space_info->last_reclaim_unused =3D space_info->total_bytes - space_i=
nfo->bytes_used;
> +	}
> +}
>   void btrfs_reclaim_sweep(const struct btrfs_fs_info *fs_info);
>   void btrfs_return_free_space(struct btrfs_space_info *space_info, u64 =
len);
>  =20


