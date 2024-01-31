Return-Path: <linux-btrfs+bounces-1945-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D798B8434E1
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 05:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01A5D1C25330
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 04:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D514208A8;
	Wed, 31 Jan 2024 04:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b="Oyge4RVZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mail-108-mta123.mxroute.com (mail-108-mta123.mxroute.com [136.175.108.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B376118C3D
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 04:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706676612; cv=none; b=EhIjkaRY/AR1dbzCXJ1zqfGDGZTERarlkt+lP2pboz52oSBpIgwos7CavcJ5b2EWUSRrjXeFcyi3JY/asQ6HueY/gm7P7ySSfWnxLLthrebLBUcFPwFO2yjRZfDO1CtiBNHjPSqx80UOCjR1xO/cHiW2kUekwUKAIOM54g5hXQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706676612; c=relaxed/simple;
	bh=IyD7tUAQYUUynSifqzfZfm8t4YpjJWwlL8BiZVIG+Jk=;
	h=References:From:To:Cc:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=ETeBLevRLpEwzqD80hyuB2MBAUFJIlPVfPskY1Ye6i8TCU7pCZ1ExPsv0GumVXWgsymBKULXOueC+b3gTFX7+oZZqoJP7ivZVo6Ii2XWRbzYbynHUB6DN6hiVQxnB+UfyGcTysARr+1v9mhkA0J93+gOo2GNrGFOqzSwTB7p7JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.org; spf=pass smtp.mailfrom=damenly.org; dkim=pass (2048-bit key) header.d=damenly.org header.i=@damenly.org header.b=Oyge4RVZ; arc=none smtp.client-ip=136.175.108.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=damenly.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=damenly.org
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta123.mxroute.com (ZoneMTA) with ESMTPSA id 18d5dd596e60003727.003
 for <linux-btrfs@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Wed, 31 Jan 2024 04:44:55 +0000
X-Zone-Loop: b3f57ac0e88b1c0fc30ff128a10793908d606769df6e
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=damenly.org
	; s=x; h=Content-Type:MIME-Version:Message-ID:In-reply-to:Date:Subject:Cc:To:
	From:References:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rnLGajAq0kkXOjHoQYqW46gFHVjsbKNpM0HwOh/Jqnc=; b=Oyge4RVZ5u16d1FN/D8p2GmA2Z
	NvNg70QzDbd1m+G/vU3lDRev/16k8MJvoZOhOQmVm0fsxLQrHk8voBjJp+q2LKfdZdzvwEg2gTqBx
	c9C8R5evL/hcjY45n7cq5U08CsCxv8qVU4btiyOrOKmM/vP7pEiWpiUJ+Sy5+6ca1dmAxDv7tbhJI
	X5mUBjWjO5ypJ04z3zpKZoTBF3+5QFdInX/r3z3VTPM/UWdiMsbSdgRXOk5THaw6Y0RR26y2KRiUJ
	kkxfhG8zOOqp7NOGgSmd8K4bUsAvpua7nGnEaxytz+h2hXK1lkRIGvdbfKjJryagwNOAlPDiUQfEy
	MuPsyxLg==;
References: <20240126080423.138713-1-xuyang2018.jy@fujitsu.com>
User-agent: mu4e 1.7.5; emacs 28.2
From: Su Yue <l@damenly.org>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Cc: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] t_snapshot_deleted_subvolume: change the position of
 macro definition
Date: Wed, 31 Jan 2024 12:39:52 +0800
In-reply-to: <20240126080423.138713-1-xuyang2018.jy@fujitsu.com>
Message-ID: <a5omglk6.fsf@damenly.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Authenticated-Id: l@damenly.org


On Fri 26 Jan 2024 at 03:04, Yang Xu <xuyang2018.jy@fujitsu.com> 
wrote:

Cc linux-btrfs

> On some platform, struct btrfs_ioctl_vol_args_v2 is defined, but 
> the
>
Would you mention what are these platforms?

--
Su
> macros BTRFS_IOC_SNAP_DESTROY_V2, BTRFS_IOC_SNAP_CREATE_V2 and
> BTRFS_IOC_SUBVOL_CREATE_V2 are not defined. This will cause 
> compile
> error. We should always check these macros and manually define 
> them
> if necessary.
>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  src/t_snapshot_deleted_subvolume.c | 30 
>  +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/src/t_snapshot_deleted_subvolume.c 
> b/src/t_snapshot_deleted_subvolume.c
> index c3adb1c4..d84ba35a 100644
> --- a/src/t_snapshot_deleted_subvolume.c
> +++ b/src/t_snapshot_deleted_subvolume.c
> @@ -20,21 +20,6 @@
>  #define BTRFS_IOCTL_MAGIC 0x94
>  #endif
>
> -#ifndef BTRFS_IOC_SNAP_DESTROY_V2
> -#define BTRFS_IOC_SNAP_DESTROY_V2 \
> -	_IOW(BTRFS_IOCTL_MAGIC, 63, struct btrfs_ioctl_vol_args_v2)
> -#endif
> -
> -#ifndef BTRFS_IOC_SNAP_CREATE_V2
> -#define BTRFS_IOC_SNAP_CREATE_V2 \
> -	_IOW(BTRFS_IOCTL_MAGIC, 23, struct btrfs_ioctl_vol_args_v2)
> -#endif
> -
> -#ifndef BTRFS_IOC_SUBVOL_CREATE_V2
> -#define BTRFS_IOC_SUBVOL_CREATE_V2 \
> -	_IOW(BTRFS_IOCTL_MAGIC, 24, struct btrfs_ioctl_vol_args_v2)
> -#endif
> -
>  #ifndef BTRFS_SUBVOL_NAME_MAX
>  #define BTRFS_SUBVOL_NAME_MAX 4039
>  #endif
> @@ -58,6 +43,21 @@ struct btrfs_ioctl_vol_args_v2 {
>  };
>  #endif
>
> +#ifndef BTRFS_IOC_SNAP_DESTROY_V2
> +#define BTRFS_IOC_SNAP_DESTROY_V2 \
> +	_IOW(BTRFS_IOCTL_MAGIC, 63, struct btrfs_ioctl_vol_args_v2)
> +#endif
> +
> +#ifndef BTRFS_IOC_SNAP_CREATE_V2
> +#define BTRFS_IOC_SNAP_CREATE_V2 \
> +	_IOW(BTRFS_IOCTL_MAGIC, 23, struct btrfs_ioctl_vol_args_v2)
> +#endif
> +
> +#ifndef BTRFS_IOC_SUBVOL_CREATE_V2
> +#define BTRFS_IOC_SUBVOL_CREATE_V2 \
> +	_IOW(BTRFS_IOCTL_MAGIC, 24, struct btrfs_ioctl_vol_args_v2)
> +#endif
> +
>  int main(int argc, char **argv)
>  {
>  	if (argc != 2) {

