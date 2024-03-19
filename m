Return-Path: <linux-btrfs+bounces-3452-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AD8880694
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 22:10:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50FB6B21D31
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Mar 2024 21:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C933B40859;
	Tue, 19 Mar 2024 21:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="VdJq74Bw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276A740841
	for <linux-btrfs@vger.kernel.org>; Tue, 19 Mar 2024 21:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710882624; cv=none; b=it5haNxEynATmL8Et875bsuse0Xt7KRzejgylBOqJYdvuGnZsKItLhE8P+5AMoEFcdT3BCp14SalUvMuy+4XSaa+QFiwqggedTJQve1p6dR2kJ6HMtHgu42S/bRL2CbE8XpqgkPnRKfGeYhGIziou1OMEZ3JWLD52EyF2EDkc+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710882624; c=relaxed/simple;
	bh=TRGQW4jTOqKllqMcFaRC8bjh5ZG6QgWeo+nD/J5t0CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ituOrCsztmcyzEULSW73IbRdUWIkv1sfQGshDzaax8dhE0YHtz7sW44BA8FkyzSyq0UX2J9cwAz/sc3hej0968KxfT8mAQ+vN4BuDfSmQMD2SLHe/pgxWJ7LVnVsUes2eKDG7RI/VsdTxXffnjASWEKZ7IEIWE7lerJljZvyeTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=VdJq74Bw; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1710882579; x=1711487379; i=quwenruo.btrfs@gmx.com;
	bh=5TgnXfR3dHgtNk4fF5zuPjLanO7vpGfxzPbKPzQ1chU=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=VdJq74BwhA9j68lAVevNS6AvQXKcy0VB1NyJogeYksnsy2EUAJFpwzOJIu6a+JG5
	 UmMMGF+IAOkj+Xeb9qD+b6zLe9Hmr2fi7nQ4ox9KKa7E0oj1Q0hRS4Z+pWdHyQN+N
	 qdtNBpnqKO0nscUFUBz2aFa9Dq8Cde8aJeQFmoVRWPBlh+a/LvmZZ9F8AsAwWvrf+
	 AifUioS/y7mhvZBGSGLZLrwrTcgUZ2czncfVA/GsLtX6Gimntn3UXaDdhLWB8DXBg
	 uOWAo7Z/eXtVvVXUUDzw59ORiqYIxHCZytCfmH23euC4UaKnY201i+490YCxuxr0T
	 MBhi6kU3ZFDZWJ9arg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MVvL5-1rN0St1deX-00RtbB; Tue, 19
 Mar 2024 22:09:38 +0100
Message-ID: <50a6c381-67d0-4370-85d3-13942c794e93@gmx.com>
Date: Wed, 20 Mar 2024 07:39:35 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/29] btrfs: btrfs_find_orphan_roots rename ret to ret2
 and err to ret
Content-Language: en-US
To: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1710857863.git.anand.jain@oracle.com>
 <a5b8d4ef4c88f3c6bb87c81e58a75e91af1053c8.1710857863.git.anand.jain@oracle.com>
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
In-Reply-To: <a5b8d4ef4c88f3c6bb87c81e58a75e91af1053c8.1710857863.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1XXnY4hfYW8sA4jk1YnsvplsDjaOUoxnizeF6pCd/A297yVeguM
 6tsp+Rcrmt3OIJ33YGKC6kj0EzeU8ynV/WJAPo8G0Ar3PaYLi0pYsuylaXo8bWsL66W/8zO
 2wmpF86luup5rm+vIjcYMPcrRQTBcEcYyGl52fl2aZBWgrMBUz1VBRNh0F/aYJpqQYEgWAX
 eSpKasAfwQcLCRi9tfo3Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TXFtSuXx/gQ=;/rsYa93R1q9tDpDXnO/cB5x7UXh
 VWPgkypOUI9KOxgclhVRB8s8RvJ47oyKtqmf0IQjaiYMWsyXN7lXbmczh+CadKdRjMkDQ9ylf
 PEx/JpEIHz6twKhNwZ9AR/g02jnzVTPv421eRdwnnB04iDBJonipJOdDpKsMpgpP1X/EKFytM
 fruYvOTAUX+4SAVdp9EC5kVEGWdblnSa2dbdoGaeiKMBjO8E1naNKptDeBo8GTmBFLDipXiuc
 JmedEpYKrIJ06hPbhZ/ffZtCXvtQgolQEkK0rut1pk5CjzRUd+EYZWpCztWb1uv1EtQDuhR7S
 3mJz6z4ty2Ff0g1pf6cErgHIDHA0LZDUN2sB0FMIsM4WGbEGaMZ5jY08fkN8Xl9YsLCz/75Hb
 wwXSNpA5Yiv118W7fPK3SK1K/lQ0UV8501IJv3r+7wvZEtNe+/Wd1eF5/ih26nNsKOt7MLw22
 bZ+1GbLmgIP/v7MQ28Oh81ikBkrDD2Ahg+V9nLp94ZPt9Y7JDdaywnzZCAq+0vms7cMU/0McS
 2RB9omsD35u0cRcH+WkzS+31+Nz9evl6JpLKXwv0vK4ExSSKRVlJMEwFFeRIfDcFKt6iaa0+b
 +pelS8CPkxlu4aG05d+ZU/Kj1SXGg19aWxDU1U73xzfnitZX0uQdW/wE0oCIgSf58Hdq99fRY
 0Cs79OVPNSMpb3Dv5aITwj8aQz68udB7NtOpAHsRL3dREId/8uEJ8/eJDQBMioDp+zfwqdRtu
 fCFGi3vBAzxqAQs264avSN4R0VXd/7pEBPSnS6aj2tBaoLGuM3rblqx5UKF1Oj8MeHcVyCPtM
 JeM5QqNS/rglVtNQmTAWnOyPQFQ5G8aMN7hpIRRe3TAw4=



=E5=9C=A8 2024/3/20 01:25, Anand Jain =E5=86=99=E9=81=93:
> Variable err is the actual return value of this function, and variable r=
et
> is a helper variable for err. So, rename them to ret and ret2 respective=
ly.
>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

Agree with Josef, I didn't see any special reason why we want to hold
both @ret and @err.

We directly assign @err after btrfs_get_fs_root() already, and only
continue if that @err is 0, so no need to hold two different values.

And again, I don't like the @ret2 naming anyway.

If we really need to hold two return values, I'd prefer to extract a
function to do own init/cleanup work inside, so we only need to hold one
@ret at higher level.

Thanks,
Qu
> ---
>   fs/btrfs/root-tree.c | 36 ++++++++++++++++++------------------
>   1 file changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/fs/btrfs/root-tree.c b/fs/btrfs/root-tree.c
> index 4bb538a372ce..869b50f05f39 100644
> --- a/fs/btrfs/root-tree.c
> +++ b/fs/btrfs/root-tree.c
> @@ -221,8 +221,8 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs=
_info)
>   	struct btrfs_path *path;
>   	struct btrfs_key key;
>   	struct btrfs_root *root;
> -	int err =3D 0;
> -	int ret;
> +	int ret =3D 0;
> +	int ret2;
>
>   	path =3D btrfs_alloc_path();
>   	if (!path)
> @@ -235,18 +235,18 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *=
fs_info)
>   	while (1) {
>   		u64 root_objectid;
>
> -		ret =3D btrfs_search_slot(NULL, tree_root, &key, path, 0, 0);
> -		if (ret < 0) {
> -			err =3D ret;
> +		ret2 =3D btrfs_search_slot(NULL, tree_root, &key, path, 0, 0);
> +		if (ret2 < 0) {
> +			ret =3D ret2;
>   			break;
>   		}
>
>   		leaf =3D path->nodes[0];
>   		if (path->slots[0] >=3D btrfs_header_nritems(leaf)) {
> -			ret =3D btrfs_next_leaf(tree_root, path);
> -			if (ret < 0)
> -				err =3D ret;
> -			if (ret !=3D 0)
> +			ret2 =3D btrfs_next_leaf(tree_root, path);
> +			if (ret2 < 0)
> +				ret =3D ret2;
> +			if (ret2 !=3D 0)
>   				break;
>   			leaf =3D path->nodes[0];
>   		}
> @@ -262,26 +262,26 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *=
fs_info)
>   		key.offset++;
>
>   		root =3D btrfs_get_fs_root(fs_info, root_objectid, false);
> -		err =3D PTR_ERR_OR_ZERO(root);
> -		if (err && err !=3D -ENOENT) {
> +		ret =3D PTR_ERR_OR_ZERO(root);
> +		if (ret && ret !=3D -ENOENT) {
>   			break;
> -		} else if (err =3D=3D -ENOENT) {
> +		} else if (ret =3D=3D -ENOENT) {
>   			struct btrfs_trans_handle *trans;
>
>   			btrfs_release_path(path);
>
>   			trans =3D btrfs_join_transaction(tree_root);
>   			if (IS_ERR(trans)) {
> -				err =3D PTR_ERR(trans);
> -				btrfs_handle_fs_error(fs_info, err,
> +				ret =3D PTR_ERR(trans);
> +				btrfs_handle_fs_error(fs_info, ret,
>   					    "Failed to start trans to delete orphan item");
>   				break;
>   			}
> -			err =3D btrfs_del_orphan_item(trans, tree_root,
> +			ret =3D btrfs_del_orphan_item(trans, tree_root,
>   						    root_objectid);
>   			btrfs_end_transaction(trans);
> -			if (err) {
> -				btrfs_handle_fs_error(fs_info, err,
> +			if (ret) {
> +				btrfs_handle_fs_error(fs_info, ret,
>   					    "Failed to delete root orphan item");
>   				break;
>   			}
> @@ -312,7 +312,7 @@ int btrfs_find_orphan_roots(struct btrfs_fs_info *fs=
_info)
>   	}
>
>   	btrfs_free_path(path);
> -	return err;
> +	return ret;
>   }
>
>   /* drop the root item for 'key' from the tree root */

