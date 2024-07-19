Return-Path: <linux-btrfs+bounces-6623-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8060937DD7
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Jul 2024 00:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE82CB214FF
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jul 2024 22:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9BC14884F;
	Fri, 19 Jul 2024 22:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="c4iWgcut"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B360137E
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jul 2024 22:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721428121; cv=none; b=sRgXwzDXaw1QDhex4wiXGkfaGzZZ1zXMPMQiGP4I2zWHZFwCAjdxaJu8KTg3RKS6U9oe4Be9TcERIfcNPXJ6qrOaA9Oef+rXOFuebZD/PI0CpgQ1Hwlh2paQ8RZOVavT7WFbuc9lYmFBMeP5zIe5vgiqJdqZWWLMmfu7DgsxtVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721428121; c=relaxed/simple;
	bh=pCR1AoATXF6H6DWTBhje6mwIRuVlD2yVUGFiQ7Lj+Hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r1Oz9HAdg1xBp+zWFSGZSZ/qDc8u+zxSNgEVqsh21yPN06dgY5guYk/ccvtFP33Io5ZsMXohhxOntvagF3nmWhSwOzkWBQLgil8qdlSI3OrQPBdsXgJqnq8AZjM8W2A4FL+X86nlUV7ZN6pkF7WVuf8JW+Cb/0e+AW4fTr7NjHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=c4iWgcut; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1721428113; x=1722032913; i=quwenruo.btrfs@gmx.com;
	bh=zUxfg1eK3ljDqUFLzoO7SylnKKMxY6auYfhbTAK2Ld0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=c4iWgcutKjU90V16H9B6DlgPLLxcUCF25CXrIRvjAI6mzM7i0NWWcpiqF3DzbgKO
	 w1NvB2jMO+kc9PJDL39lzn2vRJrRjGPvhgBej+Q+XxwMGmvQuTmFociBDaAPFXMFy
	 gc0WquE/Ivne4N2LI/kgs9BD320grA8iVv/RImej/WqikIQC5cmIWHWB8HHIRKNZU
	 ee1NzUlctxxT1a/vL9ZjFs3hiJjbOHKNuU9M7mvX2P1BY35UaDg/p0i6p8VY/UavJ
	 2qeOoLz9oAb8+74tisMc+4BQEBEM94pjKNAbx+Z1I2k8F8MRa7nfscISsiilKPGQd
	 1DOResXyC4fIfKPoNw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N49lJ-1sMAiG0WxN-00w5xS; Sat, 20
 Jul 2024 00:28:33 +0200
Message-ID: <cbe0935a-7f38-4c13-ad39-3cbe2fbdc13e@gmx.com>
Date: Sat, 20 Jul 2024 07:58:30 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs-progs: set subvol uuids when converting
To: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
References: <20240719150343.3992904-1-maharmstone@fb.com>
 <20240719150343.3992904-2-maharmstone@fb.com>
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
In-Reply-To: <20240719150343.3992904-2-maharmstone@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TBRTLJw3HoXzy+6I3Oc0+hOEyrF614QtvcgLhldks1p8ocAmDg4
 +4Q+1ePW4TiashHJ1bw4BIiklDKAhJs9cy3OF2yKKYKhZ6ScWPujL48Kj/uRvUc2nPH78XG
 r+SqI0YQGEYmUdbW7/OnZfidySnhRHN79vWMiel4ikQhV+j+EHBtlA0A5XT5DoSO9qUqAnl
 DhaUuBsaTaPjfHDXkjC+Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZY06cNwVLZ0=;yYwk478eb5JFoQj/4ZHcjWCW3Cj
 RlyEg/gaqHStgtB8+gT8msOU9WMtyScHk2ecTy4eFJJ545WS7onrIe090EgC8rx4CrJjVsfmg
 JAgAZP3yskTGaxQnL2PSgQfcg/y+ZWXIyban1GL5Mvgy3BvrfgWKu8SpwjpMRFjUIzF/a2Y1K
 af1+X4jw9rV+t8EDfx57YEUSSVv3YWdOQ6NK7o0cuiE0cwAto0RB5h1HNhENi+mtk/4Vro4EV
 3STcdwrKtMFTfFsEZmvYhehVR7EnIova9qsKGzgr2HV0HcYJjS5kgmXXEBXM0R2M3Z4fgjYrm
 ihlBKaZKAW2xaFjLqMs46p2c911on4XQtUsdtbM1f+iAEF2sWwIIy/ceglZJD3VV86BFyWVKE
 nVKJye1fGSh3omJd+LM94h9KMHDrFWyMYVZfMgD12rmLS6ACiMhJlnveHUMTurRHOt9tMxNRJ
 RXyX9JIHGNk06l6IieRLhBMq+GzzDS1fZESJI8kFGt5LDGSAvSqgUBwLGXp9kPaIamAjw9IWj
 X20eXHo6kaPuZxFY5xeUn1aY0gX0QRpDz1RLr4HMfc3Z3oYsbWTyJ531WHroNN+y8Ma8T7v+O
 73hMAdBgPkEG/JhyQ28ot5lEAnOBRyXgeLrea/8W+5JCInlCCyz87lJUNsCSd1VGI4ge/rfJu
 49bwzqGTTXFH24XLWpBKNMIVlD3VAYFaqIKn5DUjDSnBbOOAhwT8g8oaMeFrLwLhxZUatKF7D
 xA65mV/lqZaEt5xBfKO8zxh6HV4m/S4/5dtoOiUg+5MdM/bnlRJF2VXfTdvxAMNI69N4tY4Xn
 CSNVxgQlgB/tfzT6Urn2hYCA==



=E5=9C=A8 2024/7/20 00:33, Mark Harmstone =E5=86=99=E9=81=93:
> Currently when using btrfs-convert, neither the main subvolume nor the
> image subvolume get uuids assigned, nor is the uuid tree created.
>
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
>   common/root-tree-utils.c | 29 +++++++++++++++++++++++++++++
>   common/root-tree-utils.h |  1 +
>   convert/common.c         | 14 +++++++++-----
>   convert/main.c           |  8 +++++++-
>   mkfs/main.c              | 29 -----------------------------
>   5 files changed, 46 insertions(+), 35 deletions(-)
>
> diff --git a/common/root-tree-utils.c b/common/root-tree-utils.c
> index f9343304..9495178c 100644
> --- a/common/root-tree-utils.c
> +++ b/common/root-tree-utils.c
> @@ -59,6 +59,35 @@ error:
>   	return ret;
>   }
>
> +int create_uuid_tree(struct btrfs_trans_handle *trans)
> +{
> +	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> +	struct btrfs_root *root;
> +	struct btrfs_key key =3D {
> +		.objectid =3D BTRFS_UUID_TREE_OBJECTID,
> +		.type =3D BTRFS_ROOT_ITEM_KEY,
> +	};
> +	int ret =3D 0;
> +
> +	UASSERT(fs_info->uuid_root =3D=3D NULL);
> +	root =3D btrfs_create_tree(trans, &key);
> +	if (IS_ERR(root)) {
> +		ret =3D PTR_ERR(root);
> +		goto out;
> +	}
> +
> +	add_root_to_dirty_list(root);
> +	fs_info->uuid_root =3D root;
> +	ret =3D btrfs_uuid_tree_add(trans, fs_info->fs_root->root_item.uuid,
> +				  BTRFS_UUID_KEY_SUBVOL,
> +				  fs_info->fs_root->root_key.objectid);
> +	if (ret < 0)
> +		btrfs_abort_transaction(trans, ret);
> +
> +out:
> +	return ret;
> +}
> +
>   int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8=
 type,
>   			u64 subvol_id_cpu)
>   {
> diff --git a/common/root-tree-utils.h b/common/root-tree-utils.h
> index 78731dd5..aec1849b 100644
> --- a/common/root-tree-utils.h
> +++ b/common/root-tree-utils.h
> @@ -29,5 +29,6 @@ int btrfs_link_subvolume(struct btrfs_trans_handle *tr=
ans,
>   			 int namelen, struct btrfs_root *subvol);
>   int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8=
 type,
>   			u64 subvol_id_cpu);
> +int create_uuid_tree(struct btrfs_trans_handle *trans);
>
>   #endif
> diff --git a/convert/common.c b/convert/common.c
> index b093fdb5..667f38a4 100644
> --- a/convert/common.c
> +++ b/convert/common.c
> @@ -190,7 +190,7 @@ static int setup_temp_extent_buffer(struct extent_bu=
ffer *buf,
>   static void insert_temp_root_item(struct extent_buffer *buf,
>   				  struct btrfs_mkfs_config *cfg,
>   				  int *slot, u32 *itemoff, u64 objectid,
> -				  u64 bytenr)
> +				  u64 bytenr, bool set_uuid)

Considering this is really a temporary root item, I believe we can skip
it the UUID step for now.
(Only one of the 4 callers are passing true for it).


I'm wondering if a kernel like uuid tree generation would be more
concentrated and easier to implement.

E.g. after the fs is fully converted, generate the uuid tree then update
the UUID for the involved subvolumes.

Thanks,
Qu
>   {
>   	struct btrfs_root_item root_item;
>   	struct btrfs_inode_item *inode_item;
> @@ -210,6 +210,9 @@ static void insert_temp_root_item(struct extent_buff=
er *buf,
>   	btrfs_set_root_generation(&root_item, 1);
>   	btrfs_set_root_bytenr(&root_item, bytenr);
>
> +	if (set_uuid)
> +		uuid_generate(root_item.uuid);
> +
>   	memset(&disk_key, 0, sizeof(disk_key));
>   	btrfs_set_disk_key_type(&disk_key, BTRFS_ROOT_ITEM_KEY);
>   	btrfs_set_disk_key_objectid(&disk_key, objectid);
> @@ -281,13 +284,14 @@ static int setup_temp_root_tree(int fd, struct btr=
fs_mkfs_config *cfg,
>   		goto out;
>
>   	insert_temp_root_item(buf, cfg, &slot, &itemoff,
> -			      BTRFS_EXTENT_TREE_OBJECTID, extent_bytenr);
> +			      BTRFS_EXTENT_TREE_OBJECTID, extent_bytenr,
> +			      false);
>   	insert_temp_root_item(buf, cfg, &slot, &itemoff,
> -			      BTRFS_DEV_TREE_OBJECTID, dev_bytenr);
> +			      BTRFS_DEV_TREE_OBJECTID, dev_bytenr, false);
>   	insert_temp_root_item(buf, cfg, &slot, &itemoff,
> -			      BTRFS_FS_TREE_OBJECTID, fs_bytenr);
> +			      BTRFS_FS_TREE_OBJECTID, fs_bytenr, true);
>   	insert_temp_root_item(buf, cfg, &slot, &itemoff,
> -			      BTRFS_CSUM_TREE_OBJECTID, csum_bytenr);
> +			      BTRFS_CSUM_TREE_OBJECTID, csum_bytenr, false);
>
>   	ret =3D write_temp_extent_buffer(fd, buf, root_bytenr, cfg);
>   out:
> diff --git a/convert/main.c b/convert/main.c
> index c863ce91..8cfd9407 100644
> --- a/convert/main.c
> +++ b/convert/main.c
> @@ -1021,8 +1021,14 @@ static int init_btrfs(struct btrfs_mkfs_config *c=
fg, struct btrfs_root *root,
>   	btrfs_set_root_dirid(&fs_info->fs_root->root_item,
>   			     BTRFS_FIRST_FREE_OBJECTID);
>
> +	ret =3D create_uuid_tree(trans);
> +	if (ret) {
> +		error("failed to create uuid tree: %d", ret);
> +		goto err;
> +	}
> +
>   	/* subvol for fs image file */
> -	ret =3D btrfs_make_subvolume(trans, CONV_IMAGE_SUBVOL_OBJECTID, false)=
;
> +	ret =3D btrfs_make_subvolume(trans, CONV_IMAGE_SUBVOL_OBJECTID, true);
>   	if (ret < 0) {
>   		error("failed to create subvolume image root: %d", ret);
>   		goto err;
> diff --git a/mkfs/main.c b/mkfs/main.c
> index 0bdb414a..a69aa24b 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -735,35 +735,6 @@ static void update_chunk_allocation(struct btrfs_fs=
_info *fs_info,
>   	}
>   }
>
> -static int create_uuid_tree(struct btrfs_trans_handle *trans)
> -{
> -	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> -	struct btrfs_root *root;
> -	struct btrfs_key key =3D {
> -		.objectid =3D BTRFS_UUID_TREE_OBJECTID,
> -		.type =3D BTRFS_ROOT_ITEM_KEY,
> -	};
> -	int ret =3D 0;
> -
> -	UASSERT(fs_info->uuid_root =3D=3D NULL);
> -	root =3D btrfs_create_tree(trans, &key);
> -	if (IS_ERR(root)) {
> -		ret =3D PTR_ERR(root);
> -		goto out;
> -	}
> -
> -	add_root_to_dirty_list(root);
> -	fs_info->uuid_root =3D root;
> -	ret =3D btrfs_uuid_tree_add(trans, fs_info->fs_root->root_item.uuid,
> -				  BTRFS_UUID_KEY_SUBVOL,
> -				  fs_info->fs_root->root_key.objectid);
> -	if (ret < 0)
> -		btrfs_abort_transaction(trans, ret);
> -
> -out:
> -	return ret;
> -}
> -
>   static int create_global_root(struct btrfs_trans_handle *trans, u64 ob=
jectid,
>   			      int root_id)
>   {

