Return-Path: <linux-btrfs+bounces-3455-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03DD880847
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Mar 2024 00:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33189B220FA
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 23:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEA95FBA9;
	Tue, 19 Mar 2024 23:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="k6FcKX/I"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4043ED8
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 23:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710892044; cv=none; b=rxIwgS+XwqQ3KsqkCBpBnpAuklHNlKiamFSJiEVE7eqm1zAMqH5B8F1E2g2WBgowp/2Vvi7xsqF5Z0V2SkOL7Vdx9HOxGUELJ/pCrSEvw4mnp/D/qKH7oWad0De4/BB27yS9Gv/H/DAzH1DdEb/aRPY4XeJH7On9SoHFBd+Zx/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710892044; c=relaxed/simple;
	bh=XzwGw6dZDhJo/2dqlqp4hRCw8df7mF10NSCcZmQPA0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jkDuAMISDHtEJaUXX1lOWXWFxPB2fQ8nOi3zPpO4WltY+9AU7Vrpj0NeJ0pOBy3E9AkFiIvWgwPfPTb+55IcYCfY7EadPQDrYGwCcM5aRpZwIev0msKzlfa1lfiqzA6WIGIzGGqhmazhS40U4j7/HCL6LZ/UfIlQUjSiijViAVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=k6FcKX/I; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1710892035; x=1711496835; i=quwenruo.btrfs@gmx.com;
	bh=tDE4xib9GMULf78peq+srxDTGl32QE8GkePEEHsz9ww=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=k6FcKX/IG2cS46CvjIvAEph709IZyV2ZdP9sRdj56lpDo9tMMydNNBTx/j+Lo536
	 X7XaA9htWrbDG27azb+QCufpKguEBAbe/2F2h2YrjOpfew5nK2JjQgaUTZCNvxW+M
	 8ssNtLz3aymVD6Z3wEfTbomwkZLbYZKw94LfeOuDPhRCO/Meo/hbjbHTVjuQ818t+
	 224Hk+FNmcnuKRHbZSXYzopdExW6gPSfsF3rGxUQ7iCAfi/It/SALR9veFyydf7Af
	 LGmZUdyJGvMv23m+Ek5t8ksJIO/ZxL+n5aAkm7vFVmv8vxCNP8GrcRxih/YzXOS7k
	 UUSLCJzf2tiwnEeZ+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1ML9yS-1rUeMD0JKU-00IErX; Wed, 20
 Mar 2024 00:47:15 +0100
Message-ID: <ae2bcce6-8970-4b4c-99d5-b4ce2735553a@gmx.com>
Date: Wed, 20 Mar 2024 10:17:12 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/29] btrfs: __btrfs_wait_marked_extents rename werr to
 ret err to ret2
Content-Language: en-US
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1710857863.git.anand.jain@oracle.com>
 <2e8fef09405de09488a3dde439d213dee33e117e.1710857863.git.anand.jain@oracle.com>
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
In-Reply-To: <2e8fef09405de09488a3dde439d213dee33e117e.1710857863.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:iWBTNXJXa1PI0YiO6f6HmEIM0L6o9MoY2jn12owlo9mQx4vziIa
 91OF+kuYcPHxCgPXkrozCyW9auJY1XYYUjRC6gMw99EaaLqCLKdXt4xjLw6ClJbATlQURkH
 OGF85JttoSc61f9xsmsw8dvvPLlG7m/bsX3tkEP2k63WKOeVjNGeleumV1W8f70btLgDFyy
 hqIx5ZlD0DRa4bydSx3sg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SBqDcUeO3Wc=;3VO3r1ziWl6+A8HwlTMP5daxlji
 sXdapirw0FHl7WtkFSgIUa/So8v6KQ0gxFSkzAZXFY4JrdgXhuKCo2TTrxwdyWO1AvhBdNAqa
 FAapxh89332TEskaZdmmILCQ/b6xWXWKE42e7Vwzw9bXZTVRcT2qIsO8dz40ExxP1BLaz+Hdj
 EZvWwMQPqNyUUOwqphtY9N5ePVA1xu7ZrrvWMua/eH0wABUs+IprOHYO8HlwLyKHBUAPE/gVT
 pFWIZ8OC6qQoB9NvCWe9JPz1uXEXita5xGJJbQrbtFzr5a6/ye7oc/R5+oFf8PBCowvpCxV0+
 /uKL4rFstZrIWu2xnL7RlBmXCTtnEl3OtQGdPSwO3XnstjTVjSMUkTP0ew67negXqPso01odw
 k5jrqBvtAzrzoxZVj5KVm5lCiWc6nPpAHzp8ZMOv9CdcZafX/q6Q7/E1IuhLm6T6jYhPr0Ayr
 sYuJI9ME1f78HBZvj88nJy+eSSD/x706iYRAQieXhgq9Jsa+lfJMELEt/B+hUZ6UyPMuKnbFA
 KNMaMJJbNLGGG+xMkBvv0azDdlGbKbyZd3yC94/+M8b1jHMwoGe/mUZshxD0zcD5Us7VU44Ka
 CbE3qOzJgMZvynEmQkGbJ9u6wkCepZBLz7H6i7Gvpqc03GUo53xVBpw6zQ+Gh2GOb42mSMkif
 fCopdtJsLeDnjHrk62kRu8NPvNwtgnEKxxyx43Y6wgbIPf0UD/AMEWBGfAylJpnZzMnluXFrZ
 1Avhr5BmvFb39iQk7O6VCjpSjGsMr2FzMkA+1nxEEk/49rqpUBRDeSld0hBoTIUen+JYkxJu3
 9tNlEq5cZ4UTaOPV2yI3kPxDanpJz2pdSeJCnj6iMd+5I=



=E5=9C=A8 2024/3/20 01:25, Anand Jain =E5=86=99=E9=81=93:
> Rename the function's local variable werr to ret, and err to ret2.
> Also, align these two variable declarations with the other declarations =
in
> the function for better function space alignment.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Again, not a fan of @ret2.

And IIRC we can declare the variable used inside the loop local, by
making sure we set the global ret properly before breaking the loop.

Thanks,
Qu
> ---
>   fs/btrfs/transaction.c | 26 +++++++++++++-------------
>   1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 167893457b58..f344f97a6035 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1173,12 +1173,12 @@ int btrfs_write_marked_extents(struct btrfs_fs_i=
nfo *fs_info,
>   static int __btrfs_wait_marked_extents(struct btrfs_fs_info *fs_info,
>   				       struct extent_io_tree *dirty_pages)
>   {
> -	int err =3D 0;
> -	int werr =3D 0;
>   	struct address_space *mapping =3D fs_info->btree_inode->i_mapping;
>   	struct extent_state *cached_state =3D NULL;
>   	u64 start =3D 0;
>   	u64 end;
> +	int ret =3D 0;
> +	int ret2 =3D 0;
>
>   	while (find_first_extent_bit(dirty_pages, start, &start, &end,
>   				     EXTENT_NEED_WAIT, &cached_state)) {
> @@ -1190,22 +1190,22 @@ static int __btrfs_wait_marked_extents(struct bt=
rfs_fs_info *fs_info,
>   		 * concurrently - we do it only at transaction commit time when
>   		 * it's safe to do it (through extent_io_tree_release()).
>   		 */
> -		err =3D clear_extent_bit(dirty_pages, start, end,
> -				       EXTENT_NEED_WAIT, &cached_state);
> -		if (err =3D=3D -ENOMEM)
> -			err =3D 0;
> -		if (!err)
> -			err =3D filemap_fdatawait_range(mapping, start, end);
> -		if (err)
> -			werr =3D err;
> +		ret2 =3D clear_extent_bit(dirty_pages, start, end,
> +					EXTENT_NEED_WAIT, &cached_state);
> +		if (ret2 =3D=3D -ENOMEM)
> +			ret2 =3D 0;
> +		if (!ret2)
> +			ret2 =3D filemap_fdatawait_range(mapping, start, end);
> +		if (ret2)
> +			ret =3D ret2;
>   		free_extent_state(cached_state);
>   		cached_state =3D NULL;
>   		cond_resched();
>   		start =3D end + 1;
>   	}
> -	if (err)
> -		werr =3D err;
> -	return werr;
> +	if (ret2)
> +		ret =3D ret2;
> +	return ret;
>   }
>
>   static int btrfs_wait_extents(struct btrfs_fs_info *fs_info,

