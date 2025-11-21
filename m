Return-Path: <linux-btrfs+bounces-19255-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A016C7B841
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 20:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EDA93A6057
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 19:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573062E8B76;
	Fri, 21 Nov 2025 19:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="JnE43EEx"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C403207
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 19:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763753358; cv=none; b=dOQHegoA2UrGZbQVBtXQM7l0kQieRWTQjyqm4cZMLc7MxY0KSpSqSPFMfGa5RlA0SZ2tbKLgEsnz4FBsnujjt9UjK6dyKHACvFLlSywYMhX1TB90NXFMGTRWkQjqq2pwHNTvJ4YBx+4b1b/JLJ51L0itktBPm+BrguH4oRA16u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763753358; c=relaxed/simple;
	bh=XiCpouOcv2JR038E4d1bRRLeIiupcFzY31VEgsUeSqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oDb8QEQUQwVN4MCuXO1vWczFBgsZOtDW2FL6zLwYZdYL/4zu5mHAV+DPEMBFH8As3kgmUky0DMVL5kL6hMCtHGnhWbN2nJThELCN8V24U3v3we4rWurJlo0DaVdpoFKBaPFCo5tjj6OwvEzs3WuWvxiRujki7nUIXK/e7d7VDTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=JnE43EEx; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1763753350; x=1764358150; i=quwenruo.btrfs@gmx.com;
	bh=YHrlfvRUMlOajYgz23h4u/PcLK1LLLWyFJtWwuGeI+4=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JnE43EExnOI/owG9QwsFEk3jhk6WF3ZpQ5ZfWO3Cm7KtbJnyedA3jAE/YU2VBAGf
	 7hobeiFNd5Uw7oMqC0oAhrtxAUZAv5zzvnBth0Jl7Jy/bZyc9w+enJGDGujQwS6IC
	 HgMEMkZYxGjr0Ss1Xznyo6Pii12NWzsDeUTRqK6J7GP6urCpGEnpM7qxqDZcRGcYR
	 6Mp9AhAa6E3elxyoSKMi0SFsxzaEZywoqE8ZvvrT9r9HP5ixZ3alV8mUOdyX0H6PW
	 0H4v/uWS19GLXM8FxUiPZKQXe2CpYlsQaGCfrZUM1fTc44GL6kBppWIx6j0f08X+R
	 Qy4o6cLRo90X7vHjWw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mg6Zq-1w3oGB49de-00ff2A; Fri, 21
 Nov 2025 20:29:10 +0100
Message-ID: <9d592018-b3e2-42c1-b0fe-ed35b9c11cd0@gmx.com>
Date: Sat, 22 Nov 2025 05:59:07 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: remove redundant zero/NULL initializations in
 btrfs_alloc_root()
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <b35e6981136cd8066b56ba97e99e531e9621a84d.1763740870.git.fdmanana@suse.com>
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
In-Reply-To: <b35e6981136cd8066b56ba97e99e531e9621a84d.1763740870.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FS7o5Hl2+qzE0KS29PgaGlt6J+n9//PzZ1iUfjEH28jjIACBfFv
 aVIHhVOykgNWPZX4UxIRw92ge80oOCsqO4C3a3zb0JcAcFGQD5XBQSMVbpn/VMUZcXVaJwn
 pXMOpJMrnnxPa+/XdrEWjK0lccY5z0zM3ykkI266I5TJ1AO375yTUQy+mPTWJy8ai6wED/P
 vDSoCNfqKTDX92Arx0XFA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Q/AiIpCWma8=;sUUI9fE6oeMdU7IUX0qiCvQXlWR
 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
 bN3ofo20=



=E5=9C=A8 2025/11/22 02:32, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>=20
> We have allocated the root with kzalloc() so all the memory is already
> zero initialized, therefore it's redundant to assign 0 and NULL to sever=
al
> of the root members. Remove all of them except the atomic initialization=
s
> since atomic_t is an opaque type and it's not a good practice to assume
> its internals.
>=20
> This slightly reduces the binary size.
> With gcc 14.2.0-19 from Debian on x86_64, before this change:
>=20
>    $ size fs/btrfs/btrfs.ko
>       text	   data	    bss	    dec	    hex	filename
>    1939404	 162963	  15592	2117959	 205147	fs/btrfs/btrfs.ko
>=20
> After this change:
>=20
>    $ size fs/btrfs/btrfs.ko
>       text	   data	    bss	    dec	    hex	filename
>    1939212	 162963	  15592	2117767	 205087	fs/btrfs/btrfs.ko
>=20
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

I'm a little surprised that the compiler is not smart enough to skip=20
those duplicated zeroing.

Thanks,
Qu

> ---
>   fs/btrfs/disk-io.c | 13 -------------
>   1 file changed, 13 deletions(-)
>=20
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index fe62f5a244f5..89149fac804c 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -652,20 +652,10 @@ static struct btrfs_root *btrfs_alloc_root(struct =
btrfs_fs_info *fs_info,
>   	if (!root)
>   		return NULL;
>  =20
> -	memset(&root->root_key, 0, sizeof(root->root_key));
> -	memset(&root->root_item, 0, sizeof(root->root_item));
> -	memset(&root->defrag_progress, 0, sizeof(root->defrag_progress));
>   	root->fs_info =3D fs_info;
>   	root->root_key.objectid =3D objectid;
> -	root->node =3D NULL;
> -	root->commit_root =3D NULL;
> -	root->state =3D 0;
>   	RB_CLEAR_NODE(&root->rb_node);
>  =20
> -	btrfs_set_root_last_trans(root, 0);
> -	root->free_objectid =3D 0;
> -	root->nr_delalloc_inodes =3D 0;
> -	root->nr_ordered_extents =3D 0;
>   	xa_init(&root->inodes);
>   	xa_init(&root->delayed_nodes);
>  =20
> @@ -699,10 +689,7 @@ static struct btrfs_root *btrfs_alloc_root(struct b=
trfs_fs_info *fs_info,
>   	refcount_set(&root->refs, 1);
>   	atomic_set(&root->snapshot_force_cow, 0);
>   	atomic_set(&root->nr_swapfiles, 0);
> -	btrfs_set_root_log_transid(root, 0);
>   	root->log_transid_committed =3D -1;
> -	btrfs_set_root_last_log_commit(root, 0);
> -	root->anon_dev =3D 0;
>   	if (!btrfs_is_testing(fs_info)) {
>   		btrfs_extent_io_tree_init(fs_info, &root->dirty_log_pages,
>   					  IO_TREE_ROOT_DIRTY_LOG_PAGES);


