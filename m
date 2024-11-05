Return-Path: <linux-btrfs+bounces-9343-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 054F19BD73C
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2024 21:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AC791F23F5B
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Nov 2024 20:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536B2215C51;
	Tue,  5 Nov 2024 20:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="E8HEhxuL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7993D81
	for <linux-btrfs@vger.kernel.org>; Tue,  5 Nov 2024 20:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730839887; cv=none; b=UQJb9W9fnLyqLpDiiGJ4oCr0H/Q06yoUaMUcsCXoB0RPl66Q1+iP0pEXlbEmEfd/xm9vzO6XBdt81tT+1zY6uVfqJE3Suv/Jv9mcbE2mxNXOJEoxC+S/myd7h4qF6XHY8Alz/WiBDUjuA6ny4y3ubKFZRwo1+8mQ2OS/v+eDvPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730839887; c=relaxed/simple;
	bh=VDEG6t4fUpx0B/LIGvkBpL/eWGtuU7gf2t/yVYVftX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B9cfIEg/cWBVFEsBq8UZN97c8Vc/RJG9qffC5oa+AZ/j6sRqGzO8izIxBk3u0x3NqqP+XmBpFft3nDQBQSjNNLOvYXmxH1zwELFd2C2CbX3xaU16BD8rac/Y9Ht3ktWh7zG1wNzycWOzz659XtEvMkgyv0NzkiguAL2u3zscJHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=E8HEhxuL; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1730839879; x=1731444679; i=quwenruo.btrfs@gmx.com;
	bh=VtjniE11kdiYbYQpy5wl3FG7NI1/VaCfspVdWc5o2f4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=E8HEhxuLELBMMTAhGwoft3N/ZTZZ3r1DD9ufDvBwzHgWO1V4EkJDiOas5D5eAfBR
	 a3LkIXbmYhlFZBIs5oX3hgYqBkrlpg2i3WJc1EJ9Sl3apJMePXT0vTCD5g9Eknuam
	 hVLFpOWBpJFx+vXx6Me9g9J60eXy2igNRRf+cJknfF8jUTyxAe22l/6KaV8ZQzuEw
	 NeKtVsRWTm7UYs5CNZLLsog8lE18MfRNc24r07kGN7+0vAfYgb3GMMoMq7axZth2W
	 Fa+fz5p6vaDJ2lgiiR4+rkPAx+OJKuE6b+Fwj9K0e2y7oK2JuKOkzSimv1CGHjivL
	 1skVfEvznAZgfXtiNg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1McH9i-1tgOMN0qyq-00dhdX; Tue, 05
 Nov 2024 21:51:19 +0100
Message-ID: <f6595be8-5dd7-442d-9573-b849be1ac8c7@gmx.com>
Date: Wed, 6 Nov 2024 07:21:16 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: simplify logic to decrement snapshot counter at
 btrfs_mksnapshot()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <e2938504101b0832739b3421f8d07b809a9f5232.1730818481.git.fdmanana@suse.com>
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
In-Reply-To: <e2938504101b0832739b3421f8d07b809a9f5232.1730818481.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SO+6WZtHU0YNQojiD9bEQPHTwv3toDkXjLkk6gSyRx30ZAwbpBK
 7GnEnQepfDhogk8LmAnuyhGO31/ahsCXqHgtQX+CwqgFc18X0TLcchCSiMGggwOjPJ/tUuD
 az052N9zS+cl4Q4z/EXF5O7ugWOctQ1jjhHXJiGt95iNlOVh+zLeBuEY3JdY69GrfVri8bT
 8FPONC8/eT82nDRNUyewA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:W1EZ9VyFXt0=;1YJgsSBj9t0IjoNuKnthygju/Io
 bme8Dvo1Bc9+MO2XlyHFzHGSZChtzClNP8zcr5N2f7qqLtOVhZttvOdmmOzoi/Dxhc2DL0j/m
 3IZnKmPHo6aNyzMRNpoE3GiLD7D8HTgAoXjyb5F5HJDIoCTreyya5svNlp964bGQRT/uVSmk3
 6gLQXH32lKoPXWBYek8q6KntOmfTJzyAcjFhnzd4ELVZNYn4Mw4IjocHqzCyDrwet3sgzTWST
 btEglsNNs+Hhe8jGENHPb7+l0bIokcSgos+0j/8kIZfXwCodSuJjuVz6kYIhK6yaA4qK2htXz
 +1h0ovlQlPGgeZHPQYK8I7VAocOt+sjq4EWQo67cE8APCh7/5U2w0cLzFTUTP6bkNHAX08xMc
 RRkdAjSzRBY+AnDz+59syxaJlgRCyfURZFkGNY63LuQs1RRe14Z8PpCL2u6Z+B4dpXoYfyJEQ
 DQkc1Ygph/GKYqV2PnKBt+QXROOMu6EBWOBLcNfhaCyn1/ZaRCTvEPE3HtXz46a3Tkr6MKLPQ
 Rqii08KDl0+VU+sF26pE0QHKV4sTmG7A89SHKFJsmtRsog5MbhkgJHpTrBfibsDTUMQZUhPV2
 HnEosQnAV6SrVgv5msH5IcKKTZMRayERfEgJ555FoFKDjETYkBeNLlrFVXyrsGTfTIZTeILTa
 ddsArkTC8NqXEC+iHMwkUiBgIiGhJO3wvKfxZ9VxnsE925PhpsfAXi+DO+mhoGeLXaJ49Pi9V
 Jj0Vja+2yNixXQ3+Rmn2qPuPDKgBxJijv2G7LS0a9xLhS8WK3jVO03ngwoLd/N8Dw45p0JZpH
 ace2hTh/Fqh3yfGrzRtVKcvQ==



=E5=9C=A8 2024/11/6 01:27, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> There's no point in having a 'snapshot_force_cow' variable to track if w=
e
> need to decrement the root->snapshot_force_cow counter, as we never jump
> to the 'out' label after incrementing the counter. Simplify this by
> removing the variable and always decrementing the counter before the 'ou=
t'
> label, right after the call to btrfs_mksubvol().
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/ioctl.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index cd3e82cc842b..26a07cbeb3a4 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -1049,7 +1049,6 @@ static noinline int btrfs_mksnapshot(const struct =
path *parent,
>   				   struct btrfs_qgroup_inherit *inherit)
>   {
>   	int ret;
> -	bool snapshot_force_cow =3D false;
>
>   	/*
>   	 * Force new buffered writes to reserve space even when NOCOW is
> @@ -1068,15 +1067,13 @@ static noinline int btrfs_mksnapshot(const struc=
t path *parent,
>   	 * creation.
>   	 */
>   	atomic_inc(&root->snapshot_force_cow);
> -	snapshot_force_cow =3D true;
>
>   	btrfs_wait_ordered_extents(root, U64_MAX, NULL);
>
>   	ret =3D btrfs_mksubvol(parent, idmap, name, namelen,
>   			     root, readonly, inherit);
> +	atomic_dec(&root->snapshot_force_cow);
>   out:
> -	if (snapshot_force_cow)
> -		atomic_dec(&root->snapshot_force_cow);
>   	btrfs_drew_read_unlock(&root->snapshot_lock);
>   	return ret;
>   }


