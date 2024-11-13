Return-Path: <linux-btrfs+bounces-9621-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D03F09C7D65
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 22:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90DDA2855FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Nov 2024 21:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808412038B1;
	Wed, 13 Nov 2024 21:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="i02y8HTZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE3920721F
	for <linux-btrfs@vger.kernel.org>; Wed, 13 Nov 2024 21:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731532336; cv=none; b=F1v8Sd2XMY82VFZjPP+vqlkhVcksgEk8aRkAmhlpINB61HYeFi7bYdT5ytZgnGMWeQ8a2UhjA2XV5dgJBDG5Fz991foVSXJxEpwNvGRPPF+bM1aJ83KQBdV6SN5mZvyRRAN7Uo3OsjQeL86fHqGORBUgJPYeDVejZF7E4rPYWSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731532336; c=relaxed/simple;
	bh=PigVtzRqKksvm7NcS5o/1T0zq8HAgMWfHZrN6atL2Qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CdYgLbCS4TD16l1Pe40MZBhUPh3lP9g3mUNCgcfiMGqEe4QfyyHWtHsHkloQoLvfAR4xg2ZOrNXKOdcNB27jW6wVkzXAwrRLCKxqx/QHP57KFTVG10UW0f/3pnr62y+PZF9teo3Pnbp+o1SfWvk8Q3vgTr3PHF1YeUDmBk3oGHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=i02y8HTZ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1731532321; x=1732137121; i=quwenruo.btrfs@gmx.com;
	bh=Uz/BEe8mbENl88QPIN3g3CK4O24DG6J78qAMOs5k48E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=i02y8HTZ+FcuI9K8BpC5oBmkApg3M5wiNGh6PMOkNkSD5URi7mCuLBz24RXFybH4
	 eCVrBmQm765QyTqv+TS8IL/4xmJjZrHC46E/XEWo9cDj4MSHbZsGNR+6/kK8WZbXh
	 XZeSS3iALTLgp3d+FkRszCYB/CpHlQ1UuQFwCmHmnpFWtHo3QNX1TA+CDHg66/mpe
	 /VzOPYJVBuUJtwQCyTcGyWUx9iIZ9MNesHALsxLZVGAc19XGSC3Zt5JPlBw1ZRqWO
	 dxZDnXuP9ejj+Ul+kbgC8lc07XYiK0bRCuNhdbBTagI8XjZhZQFBE202VIyIm56ph
	 LKF8uTL+1UxapAEniA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N6KUT-1tr5XU19mz-017VYx; Wed, 13
 Nov 2024 22:12:01 +0100
Message-ID: <5589e48f-5db5-4da4-8043-8f1e72b7c9d3@gmx.com>
Date: Thu, 14 Nov 2024 07:41:57 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] btrfs: simplify waiting for encoded read endios
To: Johannes Thumshirn <jth@kernel.org>, linux-btrfs@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>, Damien Le Moal <dlemoal@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Mark Harmstone <maharmstone@fb.com>, Omar Sandoval <osandov@osandov.com>
References: <cover.1731517699.git.jth@kernel.org>
 <59f75f70e743049cbb019752baf094a7e2f044fa.1731518011.git.jth@kernel.org>
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
In-Reply-To: <59f75f70e743049cbb019752baf094a7e2f044fa.1731518011.git.jth@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mj0LZtbfTAbRV9yq+ZqCP18f+uFRDgON1sOFvP/K6Zstw6/aTCs
 w0oUv3mMmLzLWAZWeL+O1pJXjIKa12kWyQ9+rtaBLFQXOw3IraCiv/8L6VPzgRuf7Ku+Fx1
 VbcXz7l4gVhI8B5gGWjn9D0gq9QHC01HQxNNfS6OvZncaNWr3VtiGzwjqTioOklrbl+i08s
 zw648QoiEisEZFqm4LUAQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:bBnppsu2IJc=;/qMf/7Nh780X87m2vAfZiOL5+Lj
 J4hz1vkTacqd+ZIF0JrPvHcVLjY3HToWOPxv6EhNHR/axcPaiwUks10ihUpYZGVXCecatZH2e
 l92EGsc8Hc/vPpdvRtG9xCsLTl04DLLpMVvaQumE2RPcvzh65IGyCfCR2f6vdVCnIdkU00QAU
 IhjXCn4t5g2O2qOuIDUQTEPdA0GDTmR6ia2faJeqaosxqynXMeu6djxZvi8HF7YyCclj8nkaS
 F/XjIyfV1v7K5yFdUcVKqBEEBNFF/Vo9hlaOJnEAQFqrgk7XlMlx8krZHHmD1aN20GPf2L+Un
 8PDWcrmWUlaBkDW/TCLG+DOyILJatPLVOef9D2yLBW0fatw9mkol9ZjKiWKm7k0/QvvqRB75n
 N6HBNFidVfnxcxTwzDvrSEDVywpJAvD5e/vX+D3VLOM1dblZBW6kghVFLMWIHZoROj45JeMvA
 3Vpb2LOjZ3R1b2QW3UMcZT+kKQYZ6+Fz2AuDtxhLKYX0rPj6C01A7Hfh7dgLyAnuDHjPK9f+y
 w+2qkU9Xk31zffIOCTgohdiBdZHdDspaBwvQ1U8GsKwglK4PU05nWk0w3MBcfND5axLQrNF46
 8lXy+j3T0bjM7WUW1BCBiU7G1k4trkI5b7gZqOcXI7WXVw674/PL/PnZOVW1xw0MHF+DgtYc8
 ZlXFZDLhTl6zGOIoohvaSmAI6cb5OgRL78J1YL38oL0+TG0Jj8PFdP8SB1UfTjOMKflMWL2p+
 KrY9isgHNc+glcK2fm2r12pIdLTdGPIqIWgAsEIyHjdNcpzqbPlPC9dTAsFo5A6aiqhVZyXWj
 UwoVYzhWzRVrudu7f2xcZCheNPQoe7OIw5yX/7V0uIM6igZP1IgO/IdT5jgzDHH1jTQylIw/j
 e1OaLNQbHN6p3zBilFnxIb/8Lsi8ZvAhoqdFzA4dB0R7vFKuofWp+oIC9



=E5=9C=A8 2024/11/14 03:46, Johannes Thumshirn =E5=86=99=E9=81=93:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Simplify the I/O completion path for encoded reads by using a
> completion instead of a wait_queue.
>
> Furthermore use refcount_t instead of atomic_t for reference counting th=
e
> private data.
>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/inode.c | 23 ++++++++++++-----------
>   1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index fdad1adee1a3..3ba78dc3abaa 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3,6 +3,7 @@
>    * Copyright (C) 2007 Oracle.  All rights reserved.
>    */
>
> +#include "linux/completion.h"
>   #include <crypto/hash.h>
>   #include <linux/kernel.h>
>   #include <linux/bio.h>
> @@ -9068,9 +9069,9 @@ static ssize_t btrfs_encoded_read_inline(
>   }
>
>   struct btrfs_encoded_read_private {
> -	wait_queue_head_t wait;
> +	struct completion done;
>   	void *uring_ctx;
> -	atomic_t pending;
> +	refcount_t pending_refs;
>   	blk_status_t status;
>   };
>
> @@ -9089,14 +9090,14 @@ static void btrfs_encoded_read_endio(struct btrf=
s_bio *bbio)
>   		 */
>   		WRITE_ONCE(priv->status, bbio->bio.bi_status);
>   	}
> -	if (atomic_dec_and_test(&priv->pending)) {
> +	if (refcount_dec_and_test(&priv->pending_refs)) {
>   		int err =3D blk_status_to_errno(READ_ONCE(priv->status));
>
>   		if (priv->uring_ctx) {
>   			btrfs_uring_read_extent_endio(priv->uring_ctx, err);
>   			kfree(priv);
>   		} else {
> -			wake_up(&priv->wait);
> +			complete(&priv->done);
>   		}
>   	}
>   	bio_put(&bbio->bio);
> @@ -9116,8 +9117,8 @@ int btrfs_encoded_read_regular_fill_pages(struct b=
trfs_inode *inode,
>   	if (!priv)
>   		return -ENOMEM;
>
> -	init_waitqueue_head(&priv->wait);
> -	atomic_set(&priv->pending, 1);
> +	init_completion(&priv->done);
> +	refcount_set(&priv->pending_refs, 1);
>   	priv->status =3D 0;
>   	priv->uring_ctx =3D uring_ctx;
>
> @@ -9130,7 +9131,7 @@ int btrfs_encoded_read_regular_fill_pages(struct b=
trfs_inode *inode,
>   		size_t bytes =3D min_t(u64, disk_io_size, PAGE_SIZE);
>
>   		if (bio_add_page(&bbio->bio, pages[i], bytes, 0) < bytes) {
> -			atomic_inc(&priv->pending);
> +			refcount_inc(&priv->pending_refs);
>   			btrfs_submit_bbio(bbio, 0);
>
>   			bbio =3D btrfs_bio_alloc(BIO_MAX_VECS, REQ_OP_READ, fs_info,
> @@ -9145,11 +9146,11 @@ int btrfs_encoded_read_regular_fill_pages(struct=
 btrfs_inode *inode,
>   		disk_io_size -=3D bytes;
>   	} while (disk_io_size);
>
> -	atomic_inc(&priv->pending);
> +	refcount_inc(&priv->pending_refs);
>   	btrfs_submit_bbio(bbio, 0);
>
>   	if (uring_ctx) {
> -		if (atomic_dec_return(&priv->pending) =3D=3D 0) {
> +		if (refcount_dec_and_test(&priv->pending_refs)) {
>   			ret =3D blk_status_to_errno(READ_ONCE(priv->status));
>   			btrfs_uring_read_extent_endio(uring_ctx, ret);
>   			kfree(priv);
> @@ -9158,8 +9159,8 @@ int btrfs_encoded_read_regular_fill_pages(struct b=
trfs_inode *inode,
>
>   		return -EIOCBQUEUED;
>   	} else {
> -		if (atomic_dec_return(&priv->pending) !=3D 0)
> -			io_wait_event(priv->wait, !atomic_read(&priv->pending));
> +		if (!refcount_dec_and_test(&priv->pending_refs))
> +			wait_for_completion_io(&priv->done);
>   		/* See btrfs_encoded_read_endio() for ordering. */
>   		ret =3D blk_status_to_errno(READ_ONCE(priv->status));
>   		kfree(priv);


