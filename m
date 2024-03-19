Return-Path: <linux-btrfs+bounces-3448-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B44AD88062A
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 21:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7D7F1C2111D
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 20:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069103DBBF;
	Tue, 19 Mar 2024 20:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="qKyAxzUa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8873F3D393
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 20:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710881030; cv=none; b=ofJszxQ4STQln4NC2Bx4CdQobLdwnvRq4qb79kasJ+dSHoB4CX61oOBgYDCOdPkPKh0UJy7i0PSEBXmS73M3MRR1rsSzMd9n/OtczXczrrD/o0XnkXUiCzvNOFp7vVfHR8Pi1LVDCe67UvvXVMldGRl7tvkWGpP/p0osgvy3X3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710881030; c=relaxed/simple;
	bh=SLBaugbHPNFGlmrarUAJwrO1LfkxAyI6S7ZScYlNweQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=L1Yky8a3EWlhMimr89CoMoFnAB8og5fLhCeGCll736EZLzO62q8SRW4Rz93hNIzNiSRTwt0m9wQinE1MDr8mKKYm+o8QhveKe05drQ0q9llW82Nk8zQa0hMvaU6XHtACRJwuOpx/pHdFpxpmFgV0UnVP35oJVH467pFNYQ3z8jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=qKyAxzUa; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1710881021; x=1711485821; i=quwenruo.btrfs@gmx.com;
	bh=sJ7yeokkyfP3TK7HKhmd6RIowJytQuE1LSlkLKSJ5Kc=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=qKyAxzUa5Sy6ivJVCjdGP7fSIZmQM3qXjg3TTYOdFa4hK+I1OZEXMPZQBjFx+UBN
	 qkj38EYRA3BvqhTrZUppjqpBTzTUM9uObTfAse7pmvIR9v5pdCiBL04F+N9IxPF5P
	 S8snN4ApDzQ4G5nteAlbBxQ6rItKRqcPS9pFt9oPcZEtlLtbVfl9g/cyn0qiYNUvQ
	 0e5Ly6UhZQqhpf7t4j0k9jWAFKv+jmbiCRwTJFEPo3sBarBy+7OXRvgMQya6ffDic
	 9a5xFlsuUBcKhL1w/rYvxqTD/nCUL5h/iVepFdBIqlWHqi4mprewBxn1IsL1qbUEI
	 GMiAdGIvyc5+KTEDhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MD9T1-1rdZca0ybx-0098Ed; Tue, 19
 Mar 2024 21:43:41 +0100
Message-ID: <c1e5cfaf-111d-49b4-b927-ee140e83e5ca@gmx.com>
Date: Wed, 20 Mar 2024 07:13:37 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/29] btrfs: btrfs_cleanup_fs_roots rename ret to ret2
 and err to ret
Content-Language: en-US
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1710857863.git.anand.jain@oracle.com>
 <b1eaaa193879d4ae920a76dfa3bc5f2e6c7f8a4d.1710857863.git.anand.jain@oracle.com>
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
In-Reply-To: <b1eaaa193879d4ae920a76dfa3bc5f2e6c7f8a4d.1710857863.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CQ6FMNlk+HU2b5Y2yFOyYZJt0mRqZ8LVwOQ+I5pWcCCjPdBDsBS
 va0mDf/huwrrPAn3ddSjkyjtRlL3+swEG7PKE/jTaVQwQG31BJ4MwzNN+c4J2raLFDzTKjl
 1LpBgTb+bpQ4tvfAZTslxD0VGzb6SWtTA6ZigV8exl4rh0flBIDHw4DS1sNZ7yGBand18tD
 z7ZxGn7xiknSE4l7p98vA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1dNX0b9iAQc=;8SO1X7ZTnHxqRr/R8BiQDPGXYHH
 a4hFnlHdWpZWYg8PU4Vp87WtBAehIa+xiQSLLXHklRZoxEL1kXh3/6H4H0VAWQ8wqM5Z0Pftx
 DE3fGA56g6HAkLnZCjwuG+VtRYAQRIzqyJN9WIsFqQjA22ayI5x5HiTQSrcXRY4LGLDiGQKmK
 kpkdr3wW33VLuY6C/NB3tOZG3ghTWgX1ZnXGXZ3DFAOsKZbLJGBjI+asGh/zK1GSqjv8ZXzTk
 +DeyKswpj2DrS168qhkeMY27mj5OeN6oS9tRbprxyxHfV4BKCkYhAcsuwX3Nv7B5Jc0tXopvN
 FoYT2YiBFB4cEmzNtbzqouq+9KBps2dP7JJe9yyJq4i1sCg4vqxaVMwEcQmmljhlnxN7PU4n9
 xvNwvhDR2OAsQ2obr5kUP0BpbDNEQjycqFVIOe4dT2smG/fiK/BhHKbaVmH0mF44ksnAzk4Nd
 oXgv8qpqfdV4fQc3NSOmjONpcGABioZYCazfKDS1yM8fj3/jasPcvS/sYu4zgFAeSbfE5X+xO
 2FaaS9DSw9mI//z0GvtAKnS1t6Y3XAs6MAnR1sBbksjqCzpWMJSwmvbpO4fOYz7oZtHcEUjpj
 eNDqF6OKepAdmVHA7WM2uwI60rJj4geKzfqEd0wMiR1EGbJ1m9sOgaN4jv3mzeg+D1Ntjcaih
 ormHz4ZTbrNANxzhdDayE+EUJAoIGUE98XJp7qpgeHlMKSw+yXTdrFeLTEJcUwCuG+s0HqTD8
 /s3wSqNC2b37+0TqwMWOoSJRgwhRm1CE1LOBb0Z9i0ehoMD4TUJ6BI+bVTCK6PZtQNeSURFZP
 Wx1shHApatVl6CZC/d30FEatgMFHSIKRCpFPMb6PY+p1w=



=E5=9C=A8 2024/3/20 01:25, Anand Jain =E5=86=99=E9=81=93:
> Since err represents the function return value, rename it as ret,
> and rename the original ret, which serves as a helper return value,
> to ret2.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>   fs/btrfs/disk-io.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 3df5477d48a8..d28de2cfb7b4 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2918,21 +2918,21 @@ static int btrfs_cleanup_fs_roots(struct btrfs_f=
s_info *fs_info)
>   	u64 root_objectid =3D 0;
>   	struct btrfs_root *gang[8];
>   	int i =3D 0;
> -	int err =3D 0;
> -	unsigned int ret =3D 0;
> +	int ret =3D 0;
> +	unsigned int ret2 =3D 0;

I really hate the same @ret2.

Since it's mostly the found number of radix tree gang lookup, can we
change it to something like @found?

>
>   	while (1) {

Another thing is, the @ret2 is only utilized inside the loop except the
final cleanup.

Can't we only declare @ret2 (or the new name) inside the loop and make
the cleanup also happen inside the loop (or a dedicated helper?)

Thanks,
Qu
>   		spin_lock(&fs_info->fs_roots_radix_lock);
> -		ret =3D radix_tree_gang_lookup(&fs_info->fs_roots_radix,
> +		ret2 =3D radix_tree_gang_lookup(&fs_info->fs_roots_radix,
>   					     (void **)gang, root_objectid,
>   					     ARRAY_SIZE(gang));
> -		if (!ret) {
> +		if (!ret2) {
>   			spin_unlock(&fs_info->fs_roots_radix_lock);
>   			break;
>   		}
> -		root_objectid =3D gang[ret - 1]->root_key.objectid + 1;
> +		root_objectid =3D gang[ret2 - 1]->root_key.objectid + 1;
>
> -		for (i =3D 0; i < ret; i++) {
> +		for (i =3D 0; i < ret2; i++) {
>   			/* Avoid to grab roots in dead_roots. */
>   			if (btrfs_root_refs(&gang[i]->root_item) =3D=3D 0) {
>   				gang[i] =3D NULL;
> @@ -2943,12 +2943,12 @@ static int btrfs_cleanup_fs_roots(struct btrfs_f=
s_info *fs_info)
>   		}
>   		spin_unlock(&fs_info->fs_roots_radix_lock);
>
> -		for (i =3D 0; i < ret; i++) {
> +		for (i =3D 0; i < ret2; i++) {
>   			if (!gang[i])
>   				continue;
>   			root_objectid =3D gang[i]->root_key.objectid;
> -			err =3D btrfs_orphan_cleanup(gang[i]);
> -			if (err)
> +			ret =3D btrfs_orphan_cleanup(gang[i]);
> +			if (ret)
>   				goto out;
>   			btrfs_put_root(gang[i]);
>   		}
> @@ -2956,11 +2956,11 @@ static int btrfs_cleanup_fs_roots(struct btrfs_f=
s_info *fs_info)
>   	}
>   out:
>   	/* Release the uncleaned roots due to error. */
> -	for (; i < ret; i++) {
> +	for (; i < ret2; i++) {
>   		if (gang[i])
>   			btrfs_put_root(gang[i]);
>   	}
> -	return err;
> +	return ret;
>   }
>
>   /*

