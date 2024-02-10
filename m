Return-Path: <linux-btrfs+bounces-2294-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD5E850356
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Feb 2024 08:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A653B22E50
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Feb 2024 07:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8082E632;
	Sat, 10 Feb 2024 07:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="C7F0Gtho"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99972B9CF
	for <linux-btrfs@vger.kernel.org>; Sat, 10 Feb 2024 07:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707551160; cv=none; b=Zrg55pvz4RMHC3ke6kRNSNC1KXqn0rl9pHMJHcnljKggQtm6CwYb5+iEbnXHT5f22NIjwLI7OKhO7KkLZme1DugTf69xYYkdadHDir7PL/f89Kq3OvLuPOopnSSsH1SXXQlKs7Y3uQ7PXRsJ5BR68oPsAdgkzr7Vm16OKypl9CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707551160; c=relaxed/simple;
	bh=0hEcUKP7pGTR4HFwU2mx8OZYw6Z+qyemZmtB0EB9N7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VC6L71YrCxRP5db2ncwDWAB1u0qnlLBvZOtj8KGbeSM/jhyq8JGvA0rhaRjItZqeLV7+1mdCeFRX4qIs7tSibgut1eG5Wxf7LLhk6XLCV46Q2g1/3k3RFSDKZZ0YKoCS8bDTV/OKf/az3ouo0bRuI2CETL3Q6gKZEWFEInugJW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=C7F0Gtho; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707551151; x=1708155951; i=quwenruo.btrfs@gmx.com;
	bh=0hEcUKP7pGTR4HFwU2mx8OZYw6Z+qyemZmtB0EB9N7U=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=C7F0GthoKDt2pOHkYTNOJgcl+zSZ3R1QCyrkiaeG95pRtFxKm0nQW6rsaDD0H4qN
	 2cJp3rUqY+trWB30YUGUS2FmJnS7FtvXTP9b93gEvKUWH+9DfmruTAjOHkg0UlRyP
	 mYHkZw/LERUYWrempxbbEKWzno25f9nB9ySUaIE117AonmZcjvyK+iac4Yl2svvtz
	 Ws+suzO0PKXgjaw79jhmgGtMSJ9jNhkaTQSq9YV4THdcndwBkQXyHuC9Cf96rqadI
	 2DkCc9Xi82n3f6Ko5i3mCAHQLEOswJEkZlT0z+H4uuFiYSeX/WWDV26O2S26QKK1m
	 t2xGxPBIQyTZPWoQgA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mjj87-1r9mUO0TkJ-00lBCw; Sat, 10
 Feb 2024 08:45:51 +0100
Message-ID: <7c0ee6a2-e33a-41b9-9b18-8273cc032f1d@gmx.com>
Date: Sat, 10 Feb 2024 18:15:50 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] btrfs: stop passing root argument to
 __btrfs_del_delalloc_inode()
Content-Language: en-US
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1707491248.git.fdmanana@suse.com>
 <ff5a4f734ea78954aa38c0c4fbb64461102cde7b.1707491248.git.fdmanana@suse.com>
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
In-Reply-To: <ff5a4f734ea78954aa38c0c4fbb64461102cde7b.1707491248.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sUxErX6mY0CFj6NnXnKNcNLXIlU1dpLlVYCo0Ojfe7TNgMWlBiG
 PTsb/6FyRKAd1aA8x72yru6kv+TT22OhYshl2QHaoebJMeY8YBPd8gJecdaZJUbm9o7HaOh
 Orj3OfpNGYe+zVmXqGDgb5nFiDGoyrgKGQHSBTST+RnITMxP3wDeapBNbRrqvYA6NkaCJh0
 XWgkjbewIYC3CI/RrqjvQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ofpZM3BCkzY=;8EJdfNzgnIvSvUguTas7TpbRIOk
 1vCoVqYlo+vPumkq8hbveEkZtrSKudDi3EVHmd0WAZd/u1g4kieU2DRJwkYKSlItxzy5l4CNk
 5QI5WGCa/AkLeEuaU0cbjv0v7jERH+GFEEP1Hig89HqmST0KqyUXclPKL01PAvy4YbOSNQdzn
 apfb86apJi0g9M5W6CyO1D2RDc0TIswvPqIFpBq8lbrt0qQqRo9qWd3XfomQDTv5UruD0XdIz
 wBr+a33cIgDZa+kQjV4cuuiKEKx5LtqitMVHKnvIWBHC9A4U4DkA5dg2Po5ALrQJr8pyWaILI
 HXdsYLFuaU8mqUoMmz+qPYHznpTM3pv39xopN35oHerm4ihpvqZV39rXZfWQpfhB5ttC1EYEE
 nToCUF13KG+zlOWbN9QlJVZ9ByDLuXukVJ9fqb/NfnZNg2lxA8QOMb741g1njKbfbb/Ky5RIi
 9s56BJk66193acD0xeuLgs8fTmjGN5Ih0ivmJoyX7Z+aWZtXh73DJvFuvbCNgEecNt2VpNUuQ
 20yEGlZatM5Yq6900NMGsnampOnbYCvjQ88MZf9RiE4AWUTJEDydssnuSqqYUwC2/Lqm7OVXh
 321K5Sjb8hAk1tTHt9M6XnuwaZVgzn77qDlxd5Ue2ZSkQXeOQaCiUkFf15eZLBiiMHWq8UnQt
 vN+y7rt6inAvxqpWHcEa9Hd8ENM1+fqsYAdjkP1rHeIy1TQbhYin7P26R3bHWlPeq/ZXY099/
 PvegnUzTqgCdfgBTH5QZ8KFlYuMgl/AkIm1ZsbHvkHP7ojP9bZ1cteBCt14R+fibqpyhvEHUZ
 +OL/6S3XzyO8FtZGDPsA0KDIn7bmHRjLS55dKjhvyqEnc=



On 2024/2/10 04:30, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
>
> There's no need to pass a root argument to __btrfs_del_delalloc_inode()
> and btrfs_del_delalloc_inode(), we can just pass the inode since the roo=
t
> is always the root associated to that inode. Some remove the root argume=
nt
> from these functions.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/btrfs_inode.h |  2 +-
>   fs/btrfs/disk-io.c     |  2 +-
>   fs/btrfs/inode.c       | 15 +++++++--------
>   3 files changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index 83d78a6f3aa2..32c59c5bd94d 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -428,7 +428,7 @@ noinline int can_nocow_extent(struct inode *inode, u=
64 offset, u64 *len,
>   			      u64 *orig_start, u64 *orig_block_len,
>   			      u64 *ram_bytes, bool nowait, bool strict);
>
> -void __btrfs_del_delalloc_inode(struct btrfs_root *root, struct btrfs_i=
node *inode);
> +void __btrfs_del_delalloc_inode(struct btrfs_inode *inode);
>   struct inode *btrfs_lookup_dentry(struct inode *dir, struct dentry *de=
ntry);
>   int btrfs_set_inode_index(struct btrfs_inode *dir, u64 *index);
>   int btrfs_unlink_inode(struct btrfs_trans_handle *trans,
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 4280f8e23461..8ab185182c30 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4629,7 +4629,7 @@ static void btrfs_destroy_delalloc_inodes(struct b=
trfs_root *root)
>   		struct inode *inode =3D NULL;
>   		btrfs_inode =3D list_first_entry(&splice, struct btrfs_inode,
>   					       delalloc_inodes);
> -		__btrfs_del_delalloc_inode(root, btrfs_inode);
> +		__btrfs_del_delalloc_inode(btrfs_inode);
>   		spin_unlock(&root->delalloc_lock);
>
>   		/*
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index e3d12d8cf088..ec8af7d0f166 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -2406,9 +2406,9 @@ static void btrfs_add_delalloc_inodes(struct btrfs=
_inode *inode)
>   	spin_unlock(&root->delalloc_lock);
>   }
>
> -void __btrfs_del_delalloc_inode(struct btrfs_root *root,
> -				struct btrfs_inode *inode)
> +void __btrfs_del_delalloc_inode(struct btrfs_inode *inode)
>   {
> +	struct btrfs_root *root =3D inode->root;
>   	struct btrfs_fs_info *fs_info =3D root->fs_info;
>
>   	if (!list_empty(&inode->delalloc_inodes)) {
> @@ -2426,12 +2426,11 @@ void __btrfs_del_delalloc_inode(struct btrfs_roo=
t *root,
>   	}
>   }
>
> -static void btrfs_del_delalloc_inode(struct btrfs_root *root,
> -				     struct btrfs_inode *inode)
> +static void btrfs_del_delalloc_inode(struct btrfs_inode *inode)
>   {
> -	spin_lock(&root->delalloc_lock);
> -	__btrfs_del_delalloc_inode(root, inode);
> -	spin_unlock(&root->delalloc_lock);
> +	spin_lock(&inode->root->delalloc_lock);
> +	__btrfs_del_delalloc_inode(inode);
> +	spin_unlock(&inode->root->delalloc_lock);
>   }
>
>   /*
> @@ -2538,7 +2537,7 @@ void btrfs_clear_delalloc_extent(struct btrfs_inod=
e *inode,
>   		if (do_list && inode->delalloc_bytes =3D=3D 0 &&
>   		    test_bit(BTRFS_INODE_IN_DELALLOC_LIST,
>   					&inode->runtime_flags))
> -			btrfs_del_delalloc_inode(root, inode);
> +			btrfs_del_delalloc_inode(inode);
>   		spin_unlock(&inode->lock);
>   	}
>

