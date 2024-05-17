Return-Path: <linux-btrfs+bounces-5083-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 685948C8E59
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 May 2024 00:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BBF01C21AD0
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2024 22:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF15383B1;
	Fri, 17 May 2024 22:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="mi0LcwWM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C27C38F86
	for <linux-btrfs@vger.kernel.org>; Fri, 17 May 2024 22:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715986326; cv=none; b=bje1VfWc38ddtLtrQYKsYXhdOdjfMJa+Uev9oWZ2iPtl+ycvTF1YJ5LhorxLhoAxOA+YLlZYzZorKO6Ke1/6asGh4BAsBo8XtRIsQRIeIjpwdhrqTsjwH3lw6LU0tGQ3Fgvcja/gRLulj7H5SORBcuKCAbOY0pQi9Uhj+H4bD7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715986326; c=relaxed/simple;
	bh=JDvzQTiw86r0aHcfxIYNUzwGjmTLkoqZl+NP/318E2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NoTs0xQR8cpqNnOmU3DIQn6HqMkXfFjHMRSbIfORL3xZYVmGr11tapAUfmbLJxIQobmnZjb8sPW8vbFSC+IDZBGQyKvSEoCeul39duuVaP6Qx5YzBogMp3CDJGK8zOoL7TsHBsKqRULaytDd9DMid3GzpOu7l3XYifFTj8LzXVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=mi0LcwWM; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1715986317; x=1716591117; i=quwenruo.btrfs@gmx.com;
	bh=1Z6gF26ay5/SvKREW82qE2NOEftnKM5xzJ9JHhAep+U=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mi0LcwWMJckrur+y6I21ToHwSg1cQwFsNDFrrpbBD3rK2GqSksFStiFrLT7+P3ke
	 Sej4MPJr3nKsfrdfgONg181IkI9nY9PPBChKa4AGWU0O1iQIC9z8RZoP7bBxex9W8
	 Xmf/pidmigGeSC4U8CVhXvvtJOExgoA3bplNnWozX4DzvZVs9Mm4Y+fiueN0UxTEi
	 s0gk8khFM6No9iI0wU146rrchGxb+df/iYKxWkWRIyE6p6hxzc/rt6e/yrKuSCMxL
	 DhbfT6fW34EHYkSdcHAe9G81jgaBjUgSNmr2hvIWUgcuw14N+P8Y54I9JuvUck8QC
	 GpG9EOFCR7/OoTwEwQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.219] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MEFzx-1sFYYS050H-00B22o; Sat, 18
 May 2024 00:51:57 +0200
Message-ID: <038f89d6-3576-46c7-9336-5fde0bbc084c@gmx.com>
Date: Sat, 18 May 2024 08:21:52 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] btrfs: add and use helpers to get and set an inode's
 delayed_node
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1715951291.git.fdmanana@suse.com>
 <48ccb776f018f79730fb9b9139623960401f9505.1715951291.git.fdmanana@suse.com>
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
In-Reply-To: <48ccb776f018f79730fb9b9139623960401f9505.1715951291.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c2MZ8dpWK/HWp7YrZZM1HUzyPwPfGKAqw61YYaZ2/2FCAeKVTKK
 1Djg0tNQ0HOF3qW5/DP5mKFsAM3PXa7hNLuqEUgjLACQNT2Pzz6U2uCd0dzAUJSxGMQrAM8
 DKIUvXK9ScNBnUke7MmDfhhvT88Ik8VixFW/6rvCFtiBaOE4FFfncyx2WtEbUFXemHBxGqn
 mGl2NffHgzDGNdkRfGt9Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:hUWeknKpmz8=;nNYFleaZnMoHkeMNKS9g1FV1CZG
 +4aYLCwrWxQzVLZDncS2nJG3y5RiNk3AheERFX68BzyNPM3qqkrikLZ0fbcHoo7ctd9cJCRpp
 DDtOGVR8zr9fybjGYEv273PTKx2ZSr/tE2TNmEiyxj/7jVDp1MTkrUl8uMVqOkzmZ7U/ZTxkJ
 Tt3vox5txdt7nG6D1YQWyMMHVT4T9dsmdUykU2ws/2t0MfxC++ePwpgwHUuy1pFkCPZdm24Fb
 GhUIx3CkIBlULhG8nqlOa6Dc2wjsn/JIZaN6CsvGV8Beb9aEFkINxa1cp0RzZssEtNfhrL59R
 x70wS5dDCj8T/uMxFSmaaE1Cm1ZZMzoxXAleV79PVYUG63hsBDr+5mkfINJN+ffu6YLhLcp9m
 PxIcqN+c6EQvGhsbXBbrkorvSEPOo4aKxHm0oF6pMJsFE5JGeF5YnzZqKwsYDo1+FHoE0oGrb
 n7EO9q2iR8vZAsjtM332gqzYgJvHzLYlz2lEkCtYgBQY/AFOm5hIBAOaKhBAavzXkD5w//rkf
 Rut3JRsx31aZ9jkAg1hTB4RD1GR41NHPOjJgfQZRgHkHb8l7gj801gxQg7bgafBxuATgTw9xZ
 fbgD8i8/b9DdVnpdX/hdzlQyG5PrcPkgR9HFpfm8LlWePk/G//6QIpb2s0cqMGgkmoHFaxxFk
 p7n3FO2kyrkd5FzdeG2SE2AS+HHTYA8x8e/co9jooUxOuOcKsOWyCo58L8l+nSqwXmPI/6y2P
 psDOgQRr8pTpCiqR2m+DJiLARZFpd8qE/3w0Piur8DvRZAq591r/CijNiTteLro5MrbfM73Fm
 LW5+F8YdOY4uWr0YnpDLTiJPCAckD/kZQe3g37Jf/5Vck=



=E5=9C=A8 2024/5/17 22:43, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> When reading the delayed_node of an inode without taking the lock of the
> root->delayed_nodes we are using READ_ONCE(), and when updating it we ar=
e
> using WRITE_ONCE().
>
> Add and use helpers that hide the usage of READ_ONCE() and WRITE_ONCE(),
> like we do for other inode fields such as first_dir_index_to_log or the
> log_transid field of struct btrfs_root for example.
>
> Also make use of the setter helper at btrfs_alloc_inode() for consistenc=
y
> only - it shouldn't be needed since when allocating an inode no one else
> can access it concurrently.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   fs/btrfs/btrfs_inode.h   | 12 ++++++++++++
>   fs/btrfs/delayed-inode.c | 10 +++++-----
>   fs/btrfs/inode.c         |  4 ++--
>   3 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> index 4d9299789a03..3c8bc7a8ebdd 100644
> --- a/fs/btrfs/btrfs_inode.h
> +++ b/fs/btrfs/btrfs_inode.h
> @@ -330,6 +330,18 @@ struct btrfs_inode {
>   	struct inode vfs_inode;
>   };
>
> +static inline struct btrfs_delayed_node *btrfs_get_inode_delayed_node(
> +					      const struct btrfs_inode *inode)
> +{
> +	return READ_ONCE(inode->delayed_node);
> +}
> +
> +static inline void btrfs_set_inode_delayed_node(struct btrfs_inode *ino=
de,
> +						struct btrfs_delayed_node *node)
> +{
> +	WRITE_ONCE(inode->delayed_node, node);
> +}
> +
>   static inline u64 btrfs_get_first_dir_index_to_log(const struct btrfs_=
inode *inode)
>   {
>   	return READ_ONCE(inode->first_dir_index_to_log);
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index 6df7e44d9d31..f2fe488665e8 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -71,7 +71,7 @@ static struct btrfs_delayed_node *btrfs_get_delayed_no=
de(
>   	u64 ino =3D btrfs_ino(btrfs_inode);
>   	struct btrfs_delayed_node *node;
>
> -	node =3D READ_ONCE(btrfs_inode->delayed_node);
> +	node =3D btrfs_get_inode_delayed_node(btrfs_inode);
>   	if (node) {
>   		refcount_inc(&node->refs);
>   		return node;
> @@ -106,7 +106,7 @@ static struct btrfs_delayed_node *btrfs_get_delayed_=
node(
>   		 */
>   		if (refcount_inc_not_zero(&node->refs)) {
>   			refcount_inc(&node->refs);
> -			WRITE_ONCE(btrfs_inode->delayed_node, node);
> +			btrfs_set_inode_delayed_node(btrfs_inode, node);
>   		} else {
>   			node =3D NULL;
>   		}
> @@ -161,7 +161,7 @@ static struct btrfs_delayed_node *btrfs_get_or_creat=
e_delayed_node(
>   	ASSERT(xa_err(ptr) !=3D -EINVAL);
>   	ASSERT(xa_err(ptr) !=3D -ENOMEM);
>   	ASSERT(ptr =3D=3D NULL);
> -	WRITE_ONCE(btrfs_inode->delayed_node, node);
> +	btrfs_set_inode_delayed_node(btrfs_inode, node);
>   	xa_unlock(&root->delayed_nodes);
>
>   	return node;
> @@ -1308,11 +1308,11 @@ void btrfs_remove_delayed_node(struct btrfs_inod=
e *inode)
>   {
>   	struct btrfs_delayed_node *delayed_node;
>
> -	delayed_node =3D READ_ONCE(inode->delayed_node);
> +	delayed_node =3D btrfs_get_inode_delayed_node(inode);
>   	if (!delayed_node)
>   		return;
>
> -	WRITE_ONCE(inode->delayed_node, NULL);
> +	btrfs_set_inode_delayed_node(inode, NULL);
>   	btrfs_release_delayed_node(delayed_node);
>   }
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 11cad22d7b4c..2f3129fe0e58 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6100,7 +6100,7 @@ static int btrfs_dirty_inode(struct btrfs_inode *i=
node)
>   		ret =3D btrfs_update_inode(trans, inode);
>   	}
>   	btrfs_end_transaction(trans);
> -	if (READ_ONCE(inode->delayed_node))
> +	if (btrfs_get_inode_delayed_node(inode))
>   		btrfs_balance_delayed_items(fs_info);
>
>   	return ret;
> @@ -8475,7 +8475,7 @@ struct inode *btrfs_alloc_inode(struct super_block=
 *sb)
>   	ei->prop_compress =3D BTRFS_COMPRESS_NONE;
>   	ei->defrag_compress =3D BTRFS_COMPRESS_NONE;
>
> -	ei->delayed_node =3D NULL;
> +	btrfs_set_inode_delayed_node(ei, NULL);
>
>   	ei->i_otime_sec =3D 0;
>   	ei->i_otime_nsec =3D 0;

