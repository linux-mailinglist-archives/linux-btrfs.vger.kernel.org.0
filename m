Return-Path: <linux-btrfs+bounces-14186-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BA2AC20A2
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 May 2025 12:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D69F4E0B14
	for <lists+linux-btrfs@lfdr.de>; Fri, 23 May 2025 10:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424D0225A20;
	Fri, 23 May 2025 10:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="L4v2F2AI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B13C1C6FF4
	for <linux-btrfs@vger.kernel.org>; Fri, 23 May 2025 10:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747994950; cv=none; b=e4/sBZBAkLm/NFQGl8oLNWr1+rJhy+SpVw6WQK5yjVj19d1lbdLhWsi+Qh0Xj4os8SiWSABjuuv5lrQ7mNf/tq5DSjpQtpgd7NI3vfWCHOrDa8Re0vsJi3bT9riye8BswUUH1SGl4p25roVlJn+9bA2FjVt19pzdhsbfEKy6BG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747994950; c=relaxed/simple;
	bh=MkLlX2T5C3AKmNIUAcX9j9w4C9WF46JDkVni8fSk7Qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IiS/37UmywmGOZOVryowyXI5GfTy8O0IJWYiX23ur6BgSDQMnZNwPgj51EqpJTdg9Fm7RY+m0Lw80uB032jK7PyUw5lo0Nd43Z5V8WSrcY7Qm6sR3IPL2dwRVFOFtXQY1DKhMpzRLPT9kTB9OCrjKsurZlovMNZX124JQmEVKE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=L4v2F2AI; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1747994943; x=1748599743; i=quwenruo.btrfs@gmx.com;
	bh=+2s5dr0UBMGxRol/7iouHKh2eOA6hfxIY+TYnQT7uKc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=L4v2F2AIwazPzsGMhMMOVgJdINRkP7eIY3cd7d6cuEVwS7yaj78Uq6yG0t1YjJbS
	 ZV5r1wKBkE5gwB0P7MFgcXogNWtQxz16GjOOa3Ufr90uYOuiuBLeT92WVktDN8NWg
	 iNZhv6GeABBNtzWzZZzLc+M95w8vk1iqC7Ecc4MVd7QVjvx7zcEEOhIzCzLQIRYoR
	 S8c9dZCIFPl/UMrfqVXV+c9Rk+kpaRagLX8RdRplMdIexeoAsauQ865EpPh13Vcyc
	 EtjYSacWPY23KZAdJ5TeptQK2qjjOtzeSjUwEC0zdTX+BosUR8Z8aGXCoj3Gd79lx
	 Avbhin/y872MDZeqqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.228] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MD9X9-1u9usI0KJt-009e5L; Fri, 23
 May 2025 12:09:03 +0200
Message-ID: <d5aeaff6-3e04-4525-861d-36dfa358eb45@gmx.com>
Date: Fri, 23 May 2025 19:39:00 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/10] btrfs: redirect I/O for remapped block groups
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
References: <20250515163641.3449017-1-maharmstone@fb.com>
 <20250515163641.3449017-7-maharmstone@fb.com>
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
In-Reply-To: <20250515163641.3449017-7-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VwoKKu2Nae8HXLnLSqxQ/A5tWvlqi/7ZPeB17kbBFOVIMmKoad/
 d7crrz62uofWx/82Yk0OctxcVkUXx7UKSNxVkoQCOPisJVf6p+tQ2LgsCxbjGJ1LbfESxTR
 C4ctv6n7UAKEwFoDEMTHjF2VtFfrKSSjgbdp/OAnNq3wtyEHAuWMMGGjT03MkMGhUwZyVXD
 AiYujc6PMlmsG7Fb3B6lw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2ioyY7g6YX8=;0+V6U0s2oDgAElitizadx+ZXyOi
 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
 HBrI=



=E5=9C=A8 2025/5/16 02:06, Mark Harmstone =E5=86=99=E9=81=93:
> Change btrfs_map_block() so that if the block group has the REMAPPED
> flag set, we call btrfs_translate_remap() to obtain a new address.

I'm wondering if we can do it a little simpler:

- Delete the chunk item for a fully relocated/remapped chunk
   So that future read/write into that logical range will not find a chunk=
.

- If chunk map lookup failed, search remap tree instead

By this we do not need the REMAPPED flag at all.

Thanks,
Qu

>=20
> btrfs_translate_remap() searches the remap tree for a range
> corresponding to the logical address passed to btrfs_map_block(). If it
> is within an identity remap, this part of the block group hasn't yet
> been relocated, and so we use the existing address.
>=20
> If it is within an actual remap, we subtract the start of the remap
> range and add the address of its destination, contained in the item's
> payload.
>=20
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
>   fs/btrfs/ctree.c      | 11 ++++---
>   fs/btrfs/ctree.h      |  3 ++
>   fs/btrfs/relocation.c | 75 +++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/relocation.h |  2 ++
>   fs/btrfs/volumes.c    | 19 +++++++++++
>   5 files changed, 105 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index a2e7979372cc..7808f7bc2303 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -2331,7 +2331,8 @@ int btrfs_search_old_slot(struct btrfs_root *root,=
 const struct btrfs_key *key,
>    * This may release the path, and so you may lose any locks held at th=
e
>    * time you call it.
>    */
> -static int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *=
path)
> +int btrfs_prev_leaf(struct btrfs_trans_handle *trans, struct btrfs_root=
 *root,
> +		    struct btrfs_path *path, int ins_len, int cow)
>   {
>   	struct btrfs_key key;
>   	struct btrfs_key orig_key;
> @@ -2355,7 +2356,7 @@ static int btrfs_prev_leaf(struct btrfs_root *root=
, struct btrfs_path *path)
>   	}
>  =20
>   	btrfs_release_path(path);
> -	ret =3D btrfs_search_slot(NULL, root, &key, path, 0, 0);
> +	ret =3D btrfs_search_slot(trans, root, &key, path, ins_len, cow);
>   	if (ret <=3D 0)
>   		return ret;
>  =20
> @@ -2454,7 +2455,7 @@ int btrfs_search_slot_for_read(struct btrfs_root *=
root,
>   		}
>   	} else {
>   		if (p->slots[0] =3D=3D 0) {
> -			ret =3D btrfs_prev_leaf(root, p);
> +			ret =3D btrfs_prev_leaf(NULL, root, p, 0, 0);
>   			if (ret < 0)
>   				return ret;
>   			if (!ret) {
> @@ -5003,7 +5004,7 @@ int btrfs_previous_item(struct btrfs_root *root,
>  =20
>   	while (1) {
>   		if (path->slots[0] =3D=3D 0) {
> -			ret =3D btrfs_prev_leaf(root, path);
> +			ret =3D btrfs_prev_leaf(NULL, root, path, 0, 0);
>   			if (ret !=3D 0)
>   				return ret;
>   		} else {
> @@ -5044,7 +5045,7 @@ int btrfs_previous_extent_item(struct btrfs_root *=
root,
>  =20
>   	while (1) {
>   		if (path->slots[0] =3D=3D 0) {
> -			ret =3D btrfs_prev_leaf(root, path);
> +			ret =3D btrfs_prev_leaf(NULL, root, path, 0, 0);
>   			if (ret !=3D 0)
>   				return ret;
>   		} else {
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 075a06db43a1..90a0d38a31c9 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -721,6 +721,9 @@ static inline int btrfs_next_leaf(struct btrfs_root =
*root, struct btrfs_path *pa
>   	return btrfs_next_old_leaf(root, path, 0);
>   }
>  =20
> +int btrfs_prev_leaf(struct btrfs_trans_handle *trans, struct btrfs_root=
 *root,
> +		    struct btrfs_path *path, int ins_len, int cow);
> +
>   static inline int btrfs_next_item(struct btrfs_root *root, struct btrf=
s_path *p)
>   {
>   	return btrfs_next_old_item(root, p, 0);
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 02086191630d..e5571c897906 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -3897,6 +3897,81 @@ static const char *stage_to_string(enum reloc_sta=
ge stage)
>   	return "unknown";
>   }
>  =20
> +int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
> +			  u64 *length)
> +{
> +	int ret;
> +	struct btrfs_key key, found_key;
> +	struct extent_buffer *leaf;
> +	struct btrfs_remap *remap;
> +	BTRFS_PATH_AUTO_FREE(path);
> +
> +	path =3D btrfs_alloc_path();
> +	if (!path)
> +		return -ENOMEM;
> +
> +	key.objectid =3D *logical;
> +	key.type =3D BTRFS_IDENTITY_REMAP_KEY;
> +	key.offset =3D 0;
> +
> +	ret =3D btrfs_search_slot(NULL, fs_info->remap_root, &key, path,
> +				0, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	leaf =3D path->nodes[0];
> +
> +	if (path->slots[0] >=3D btrfs_header_nritems(leaf)) {
> +		ret =3D btrfs_next_leaf(fs_info->remap_root, path);
> +		if (ret < 0)
> +			return ret;
> +
> +		leaf =3D path->nodes[0];
> +	}
> +
> +	btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
> +
> +	if (found_key.objectid > *logical) {
> +		if (path->slots[0] =3D=3D 0) {
> +			ret =3D btrfs_prev_leaf(NULL, fs_info->remap_root, path,
> +					      0, 0);
> +			if (ret) {
> +				if (ret =3D=3D 1)
> +					ret =3D -ENOENT;
> +				return ret;
> +			}
> +
> +			leaf =3D path->nodes[0];
> +		} else {
> +			path->slots[0]--;
> +		}
> +
> +		btrfs_item_key_to_cpu(leaf, &found_key, path->slots[0]);
> +	}
> +
> +	if (found_key.type !=3D BTRFS_REMAP_KEY &&
> +	    found_key.type !=3D BTRFS_IDENTITY_REMAP_KEY) {
> +		return -ENOENT;
> +	}
> +
> +	if (found_key.objectid > *logical ||
> +	    found_key.objectid + found_key.offset <=3D *logical) {
> +		return -ENOENT;
> +	}
> +
> +	if (*logical + *length > found_key.objectid + found_key.offset)
> +		*length =3D found_key.objectid + found_key.offset - *logical;
> +
> +	if (found_key.type =3D=3D BTRFS_IDENTITY_REMAP_KEY)
> +		return 0;
> +
> +	remap =3D btrfs_item_ptr(leaf, path->slots[0], struct btrfs_remap);
> +
> +	*logical =3D *logical - found_key.objectid + btrfs_remap_address(leaf,=
 remap);
> +
> +	return 0;
> +}
> +
>   /*
>    * function to relocate all extents in a block group.
>    */
> diff --git a/fs/btrfs/relocation.h b/fs/btrfs/relocation.h
> index 788c86d8633a..f07dbd9a89c6 100644
> --- a/fs/btrfs/relocation.h
> +++ b/fs/btrfs/relocation.h
> @@ -30,5 +30,7 @@ int btrfs_should_cancel_balance(const struct btrfs_fs_=
info *fs_info);
>   struct btrfs_root *find_reloc_root(struct btrfs_fs_info *fs_info, u64 =
bytenr);
>   bool btrfs_should_ignore_reloc_root(const struct btrfs_root *root);
>   u64 btrfs_get_reloc_bg_bytenr(const struct btrfs_fs_info *fs_info);
> +int btrfs_translate_remap(struct btrfs_fs_info *fs_info, u64 *logical,
> +			  u64 *length);
>  =20
>   #endif
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 77194bb46b40..4777926213c0 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6620,6 +6620,25 @@ int btrfs_map_block(struct btrfs_fs_info *fs_info=
, enum btrfs_map_op op,
>   	if (IS_ERR(map))
>   		return PTR_ERR(map);
>  =20
> +	if (map->type & BTRFS_BLOCK_GROUP_REMAPPED) {
> +		u64 new_logical =3D logical;
> +
> +		ret =3D btrfs_translate_remap(fs_info, &new_logical, length);
> +		if (ret)
> +			return ret;
> +
> +		if (new_logical !=3D logical) {
> +			btrfs_free_chunk_map(map);
> +
> +			map =3D btrfs_get_chunk_map(fs_info, new_logical,
> +						  *length);
> +			if (IS_ERR(map))
> +				return PTR_ERR(map);
> +
> +			logical =3D new_logical;
> +		}
> +	}
> +
>   	num_copies =3D btrfs_chunk_map_num_copies(map);
>   	if (io_geom.mirror_num > num_copies)
>   		return -EINVAL;


