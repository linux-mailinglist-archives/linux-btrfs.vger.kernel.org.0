Return-Path: <linux-btrfs+bounces-4849-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C188C085C
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 02:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50D001C20E87
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 May 2024 00:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966C01113;
	Thu,  9 May 2024 00:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="h+u5yhz8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F98C38C
	for <linux-btrfs@vger.kernel.org>; Thu,  9 May 2024 00:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715214118; cv=none; b=nrvfeII+dfXM8w/X0kl/9WVAIevB4YC4fB7vz2DRnzVLFir7mEpVxvpEiIrLMdRSy9RhmT4FRr8e+b4BAQtdEiQJjZfkg4Gb9ftgmliaGvwvsGcrY4BZzzQsYWAO/xedsL/I+TQNWBWKhfsPIM3ggGUVfsYTuTcjp6f28+FKxOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715214118; c=relaxed/simple;
	bh=vBmA2fLV6JOzxuxhA+nzFcktnFvPPnkzVwfol8mDeWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lXi6vHMOLwmwCobH/jIaSdHocNk7gHj3TsvJb8DVGb5pr87DiHahHlz/lzH1CDo1eOFlwFC1rbUnCqpwN+kP/i7X2bA6tzXM9u+CGRebAHVOVaABdbZHlTwVA7HBPZkMRkbwpYeALDIl27FazsOrk1JKLd6NJ1zjubBOzXDXrJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=h+u5yhz8; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715214110; x=1715818910; i=quwenruo.btrfs@gmx.com;
	bh=0CmryvhlTQNAkRgPTKbEiMbbU7seeaUeIxm0nG3KXlA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=h+u5yhz8r6drXyj3RQ4y8UyoLXqipfR593VI85piLOo4i8xlHjxHRg6Rq122NXRP
	 UBHx7ZYxKRg9TNAe5+ps5iTaOLDbuTXH2T963e1A8uXMpQDyUN9IeSG6vvFFTzrfu
	 +mIra/rtek+r376QxvcAFqAtKpDyeeKKgTJoVSbgFqX06xw03FitITij+OBhn6xig
	 KrJnN8WSwkNU5sqjGOLugv2T+Zcy5Rw9DvCVCR6+yPiRl3fXkxkICA1vMtZj5klOD
	 NQaerxMwAMJiig2txm1MOs288h7BcpMfMf8dyidbO1ULxUrl1MOZBiAJDPz+h2nMr
	 Kjwj/SWxIEma4o1QpQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N7i8Y-1sjESN2mLi-018Kez; Thu, 09
 May 2024 02:21:50 +0200
Message-ID: <a521fb0a-c2f5-49cf-b1b8-9a1ae67ee824@gmx.com>
Date: Thu, 9 May 2024 09:51:46 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] btrfs: preallocate inodes xarray entry to avoid
 transaction abort
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1715169723.git.fdmanana@suse.com>
 <b9b409c79af85d0fe336ebec2800c36399c8f515.1715169723.git.fdmanana@suse.com>
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
In-Reply-To: <b9b409c79af85d0fe336ebec2800c36399c8f515.1715169723.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B2cSA3eJ5XJ/Aj4MQxZ0DqUcvfdJReCvqhTg0J1W3rS1pZkjIqr
 cAVDj2Wlny/wn9bIYiO85tCsdrkELD8bppW9VZHHY5X+esCexq0xCz1wGfnJ/tqzZbfTLCZ
 z23RvVNm5ymQfJhPHrFGXCBoTKthH0xKLh+ZzCgq5nyHMDYgyas10K9m8yRI7VvAaV5trOq
 ep/rpVKFZS1Pzz5TvW2AQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:U3yim41m8vY=;meeVD8F/jBR8k8HXKz8tOT234Wz
 Z90znkTOxrxByDYG1TlIicO+yUNrRhpBuzwS/fQgYnwNEFXsPe59xP7QTYj0lPiesnSV6ahB/
 C4DoEEwg3VeiZTQjV3UyNU3D1e8pwj/mS4GStJeIj8nHg9RTsGvE9rjW6Obemr75bWUSwqIM+
 nGpxCR54zSiUbTuRRaH2jjBTPfpz4V7I4WcRc8wjD3XeMik9VLCg8V3czC8znZPQUkaKdYJ28
 8knNTnghuOJd8SvwD8MSDSg5na0nStB9QXWBnyb4HRmRRXhiA369FBqVLKnSadrWOgNNWtX5C
 g59leendNfHbSNqmUV00J15Zpp9kNChYuxSkJJu/YSjG9+Ki9OfZZzFPGc8bwhZ18RCaHK2Tt
 N1jn2H/ucfcDs7b2lfEuYMJjFWaOG321LZ1Mro6i+yIghO56pXXzfEO6lozb/ymAKx++x9/9w
 dPbfAMx5j0tMncIqmzPrfKjkCKDDfCvXKsNpDCsxYZWcZLoHPetdyqSiZpsRO5CEnEEX2FAvi
 J9L+0uP7QtGqBEHMpG8+pTqMWXHkAlIEhHwUhIiq8dcOQJmIpHrkqkLuZnIslf8A/GJJPJFQc
 gwWLwhvTl5oJ8gZS8BtB9BVR4tnGBsR4n8/euW50lFiv60tIOXz5llsVMS7Vv2sjvNDo9S+Q0
 yJwpgpuhErwZgDhbJ82wBioUKu9THpUbqmQWMwRa/WhtJ6ytuyjFKIbLLmKEdPK1fah8YYjgs
 Hd7jDpDX2uR4g/F4oyVCsVfg+6q5omg89zua5Xk1hrnqIqB0lgsv7boeZ/KNeYS+f3HYkxExd
 M29T9VmUKm0nftgTjkNaaW7DIvRtyFxwMsrNjjiutLp4k=



=E5=9C=A8 2024/5/8 21:47, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> When creating a new inode, at btrfs_create_new_inode(), one of the very
> last steps is to add the inode to the root's inodes xarray. This often
> requires allocating memory which may fail (even though xarrays have a
> dedicated kmem_cache which make it less likely to fail), and at that poi=
nt
> we are forced to abort the current transaction (as some, but not all, of
> the inode metadata was added to its subvolume btree).
>
> To avoid a transaction abort, preallocate memory for the xarray early at
> btrfs_create_new_inode(), so that if we fail we don't need to abort the
> transaction and the insertion into the xarray is guaranteed to succeed.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>   fs/btrfs/inode.c | 26 +++++++++++++++++++-------
>   1 file changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 450fe1582f1d..85dbc19c2f6f 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -5493,7 +5493,7 @@ static int fixup_tree_root_location(struct btrfs_f=
s_info *fs_info,
>   	return err;
>   }
>
> -static int btrfs_add_inode_to_root(struct btrfs_inode *inode)
> +static int btrfs_add_inode_to_root(struct btrfs_inode *inode, bool prea=
lloc)
>   {
>   	struct btrfs_root *root =3D inode->root;
>   	struct btrfs_inode *existing;
> @@ -5503,9 +5503,11 @@ static int btrfs_add_inode_to_root(struct btrfs_i=
node *inode)
>   	if (inode_unhashed(&inode->vfs_inode))
>   		return 0;
>
> -	ret =3D xa_reserve(&root->inodes, ino, GFP_NOFS);
> -	if (ret)
> -		return ret;
> +	if (prealloc) {
> +		ret =3D xa_reserve(&root->inodes, ino, GFP_NOFS);
> +		if (ret)
> +			return ret;
> +	}
>
>   	spin_lock(&root->inode_lock);
>   	existing =3D xa_store(&root->inodes, ino, inode, GFP_ATOMIC);
> @@ -5606,7 +5608,7 @@ struct inode *btrfs_iget_path(struct super_block *=
s, u64 ino,
>
>   		ret =3D btrfs_read_locked_inode(inode, path);
>   		if (!ret) {
> -			ret =3D btrfs_add_inode_to_root(BTRFS_I(inode));
> +			ret =3D btrfs_add_inode_to_root(BTRFS_I(inode), true);
>   			if (ret) {
>   				iget_failed(inode);
>   				inode =3D ERR_PTR(ret);
> @@ -6237,6 +6239,7 @@ int btrfs_create_new_inode(struct btrfs_trans_hand=
le *trans,
>   	struct btrfs_item_batch batch;
>   	unsigned long ptr;
>   	int ret;
> +	bool xa_reserved =3D false;
>
>   	path =3D btrfs_alloc_path();
>   	if (!path)
> @@ -6251,6 +6254,11 @@ int btrfs_create_new_inode(struct btrfs_trans_han=
dle *trans,
>   		goto out;
>   	inode->i_ino =3D objectid;
>
> +	ret =3D xa_reserve(&root->inodes, objectid, GFP_NOFS);
> +	if (ret)
> +		goto out;
> +	xa_reserved =3D true;
> +
>   	if (args->orphan) {
>   		/*
>   		 * O_TMPFILE, set link count to 0, so that after this point, we
> @@ -6424,8 +6432,9 @@ int btrfs_create_new_inode(struct btrfs_trans_hand=
le *trans,
>   		}
>   	}
>
> -	ret =3D btrfs_add_inode_to_root(BTRFS_I(inode));
> -	if (ret) {
> +	ret =3D btrfs_add_inode_to_root(BTRFS_I(inode), false);
> +	if (WARN_ON(ret)) {
> +		/* Shouldn't happen, we used xa_reserve() before. */
>   		btrfs_abort_transaction(trans, ret);
>   		goto discard;
>   	}
> @@ -6456,6 +6465,9 @@ int btrfs_create_new_inode(struct btrfs_trans_hand=
le *trans,
>   	ihold(inode);
>   	discard_new_inode(inode);
>   out:
> +	if (xa_reserved)
> +		xa_release(&root->inodes, objectid);
> +
>   	btrfs_free_path(path);
>   	return ret;
>   }

