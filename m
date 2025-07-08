Return-Path: <linux-btrfs+bounces-15347-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F75AFDA65
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Jul 2025 00:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA220561800
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 22:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348E622B595;
	Tue,  8 Jul 2025 22:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="D9PI5jCd"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA00F14883F
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 22:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752012245; cv=none; b=kCSH0ri9A8UOo5DC7+LOkRpO83qk6ek9SyV06WwP6GSqyS90w/gwkLsupvoeyzRLt9IhRl1dKyOMwDM+nHyIlvF5ju5cNJpeGrujOTQ0owugwec9LqUpwk8d1N3kDrywc2G1ywcttCymbfEhqLAN59E4GAizYMpioCITAc9+asg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752012245; c=relaxed/simple;
	bh=BsLRCHjwi17/phlqx+lNkM6xh89y+DyZR8anPHnychE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VF8qNADi6a0WmtssiUbi800g7LrLhUU7OZ1p7BqYUfex7o7a8HGkNa8AKjMK/ntWA/Ce7YvMILWfDlDgfN+WTZFD7Es7kpYzmIgUvsVMvgCz6p4nURCOa7Xe6lk1c3K3RDUTZsi887j6B8idZHWW+Xu1XAxAWHBb6e5wHT86EfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=D9PI5jCd; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1752012240; x=1752617040; i=quwenruo.btrfs@gmx.com;
	bh=NXZu1NV53cGL9GmUwihokkpFzFofkmB0VrNH5ix9afo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=D9PI5jCdgAKhSBxCDiE/TRd4LUKUfJoczo8G/v+TxM0XB/YFPoQki0LIs9OiFt9s
	 GSUPb2Q2k/u+lyBpi5VpGZffVjj0LTi79uWShaxOGadAP4qbkS2tQVd/ZhmOL8g9A
	 AtoYxs2E95UI3AwEgsIdU2kCdCd20WcVXC4nbZANq9ddE0RiwlGsh3lQoiwDG7dZR
	 YMwVMbACr10nnWSiFwCj8BNlW4f0RTShynk+e3JEJ9AJHU7CrwEGBO47vyalrTZDM
	 ax5fBuy0ZKqKO43OFaZxqrOE1YLSnHXdf6NhcAGfGuTtAj6cTRmxHzarDwhCIKIby
	 JKt6wMgrE5qTTsQBRw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MTRQq-1u5fmc49Yi-00JH1U; Wed, 09
 Jul 2025 00:03:59 +0200
Message-ID: <72fe27cf-b912-4459-bae6-074dd86e843b@gmx.com>
Date: Wed, 9 Jul 2025 07:33:56 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: scrub: wip, pause on fs freeze
To: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc: wqu@suse.com
References: <20250708132540.28285-1-dsterba@suse.com>
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
In-Reply-To: <20250708132540.28285-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iEdjTMYsClCJUgN65X/E8SuKoGfqkkfujc7Pxn2BE9UNUCKIXo0
 +/9wqq1xwUMs5iNGMjwsjuGw3yjc3vX8X0SNYRKhkSGuULb0hu0C+FRkKpe5XnvjK6rBxFN
 4BkkjiWMah5l1y2mBNNgvF+wX2GfUCDTuDHw3c6ame7kEK75I9PIIORO5uLn3pQ+R5jYsRd
 uVr/JwwmJ581DUBkrdYpQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IjpSKSRQpbo=;n/s4ftqcK7CvfDwZMJY2pLSgUIQ
 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
 KDl9Sz4/PaOzXUlbnZT8fmCIpw80Zqco=



=E5=9C=A8 2025/7/8 22:55, David Sterba =E5=86=99=E9=81=93:
> Implement sb->freeze_super that can instruct our threads to pause
> themselves. In case of (read-write) scrub this means to undo
> mnt_want_write, implemented as sb_start_write()/sb_end_write().
> The freeze_super callback is necessary otherwise the call
> sb_want_write() inside the generic implementation hangs.

I don't this this is really going to work.

The main problem is out of btrfs, it's all about the s_writer.rw_sem.

If we have a running scrub, it holds the mnt_want_write_file(), which is=
=20
a read lock on the rw_sem.

Then we start freezing, which will call sb_wait_write(), which will do a=
=20
write lock on the rw_sem, waiting for the scrub to finish.

However the ->freeze() callback is only called when freeze_super() got=20
the write lock on the rw_sem.

At that stage, it's already too late.

Thanks,
Qu>
> This works with concurrent scrub running and 'fsfreeze --freeze', not
> with process freezing (like with suspend).
>=20
> References: https://lwn.net/Articles/1018341/
>=20
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>   fs/btrfs/fs.h    |  2 ++
>   fs/btrfs/scrub.c | 21 +++++++++++++++++++++
>   fs/btrfs/super.c | 36 ++++++++++++++++++++++++++++++++----
>   3 files changed, 55 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 8cc07cc70b12..005828a6ab17 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -137,6 +137,8 @@ enum {
>   	BTRFS_FS_QUOTA_OVERRIDE,
>   	/* Used to record internally whether fs has been frozen */
>   	BTRFS_FS_FROZEN,
> +	/* Started freezing, pause your progress. */
> +	BTRFS_FS_FREEZING,
>   	/*
>   	 * Indicate that balance has been set up from the ioctl and is in the
>   	 * main phase. The fs_info::balance_ctl is initialized.
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 6776e6ab8d10..9a6bce6ea191 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2250,6 +2250,27 @@ static int scrub_simple_mirror(struct scrub_ctx *=
sctx,
>   			ret =3D -ECANCELED;
>   			break;
>   		}
> +
> +		/* Freezing? */
> +		if (test_bit(BTRFS_FS_FREEZING, &fs_info->flags)) {
> +			atomic_inc(&fs_info->scrubs_paused);
> +			smp_mb();
> +			wake_up(&fs_info->scrub_pause_wait);
> +
> +			if (!sctx->readonly)
> +				sb_end_write(fs_info->sb);
> +
> +			try_to_freeze();
> +			wait_on_bit(&fs_info->flags, BTRFS_FS_FREEZING, TASK_UNINTERRUPTIBLE=
);
> +
> +			if (!sctx->readonly)
> +				sb_start_write(fs_info->sb);
> +
> +			atomic_dec(&fs_info->scrubs_paused);
> +			smp_mb();
> +			wake_up(&fs_info->scrub_pause_wait);
> +		}
> +
>   		/* Paused? */
>   		if (atomic_read(&fs_info->scrub_pause_req)) {
>   			/* Push queued extents */
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index e4ce2754cfde..c049d145db66 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2279,7 +2279,33 @@ static long btrfs_control_ioctl(struct file *file=
, unsigned int cmd,
>   	return ret;
>   }
>  =20
> -static int btrfs_freeze(struct super_block *sb)
> +static int btrfs_freeze_super(struct super_block *sb, enum freeze_holde=
r who,
> +			      const void *freeze_owner)
> +{
> +	struct btrfs_fs_info *fs_info =3D btrfs_sb(sb);
> +	int ret;
> +
> +	set_bit(BTRFS_FS_FREEZING, &fs_info->flags);
> +	ret =3D freeze_super(sb, who, freeze_owner);
> +	if (ret < 0)
> +		clear_bit(BTRFS_FS_FREEZING, &fs_info->flags);
> +	return ret;
> +}
> +
> +static int btrfs_thaw_super(struct super_block *sb, enum freeze_holder =
who,
> +			    const void *freeze_owner)
> +{
> +	struct btrfs_fs_info *fs_info =3D btrfs_sb(sb);
> +	int ret;
> +
> +	ret =3D thaw_super(sb, who, freeze_owner);
> +	clear_bit(BTRFS_FS_FREEZING, &fs_info->flags);
> +	smp_mb();
> +	wake_up_bit(&fs_info->flags, BTRFS_FS_FREEZING);
> +	return ret;
> +}
> +
> +static int btrfs_freeze_fs(struct super_block *sb)
>   {
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(sb);
>  =20
> @@ -2345,7 +2371,7 @@ static int check_dev_super(struct btrfs_device *de=
v)
>   	return ret;
>   }
>  =20
> -static int btrfs_unfreeze(struct super_block *sb)
> +static int btrfs_unfreeze_fs(struct super_block *sb)
>   {
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(sb);
>   	struct btrfs_device *device;
> @@ -2426,8 +2452,10 @@ static const struct super_operations btrfs_super_=
ops =3D {
>   	.destroy_inode	=3D btrfs_destroy_inode,
>   	.free_inode	=3D btrfs_free_inode,
>   	.statfs		=3D btrfs_statfs,
> -	.freeze_fs	=3D btrfs_freeze,
> -	.unfreeze_fs	=3D btrfs_unfreeze,
> +	.freeze_super   =3D btrfs_freeze_super,
> +	.thaw_super     =3D btrfs_thaw_super,
> +	.freeze_fs	=3D btrfs_freeze_fs,
> +	.unfreeze_fs	=3D btrfs_unfreeze_fs,
>   	.nr_cached_objects =3D btrfs_nr_cached_objects,
>   	.free_cached_objects =3D btrfs_free_cached_objects,
>   };


