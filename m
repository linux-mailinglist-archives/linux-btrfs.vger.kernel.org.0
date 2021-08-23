Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8173F470C
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 11:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbhHWJBC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 05:01:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:35015 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235781AbhHWJBB (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 05:01:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629709214;
        bh=f7SClvlVYCnY5veCBm9JX39Ny6RdHf89inc0xoOVL9s=;
        h=X-UI-Sender-Class:To:References:From:Subject:Date:In-Reply-To;
        b=l3IZ2ozaqVeXs7w/6EX1EP/VUnQGRTqCIue3jn+nj9Z9sQs5OquuMCBuEmz2D6LTU
         BViPlXEfCtT6ZMLUEEteM4SvI7fWabo3nGWU+bJt7H3CnIjDx2tLgNTaROIHKeTf07
         FcUkZPFAzbSH6Ogi9Zg1L7EnsaVPvleJETXlRUh4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MuDXz-1nBziS41KH-00ucGA; Mon, 23
 Aug 2021 11:00:14 +0200
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1629486429.git.josef@toxicpanda.com>
 <d433af292d5e99ff194bc6362133e64704ecd006.1629486429.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 6/9] btrfs-progs: add the block group item in make_btrfs()
Message-ID: <72de3cea-aee0-a7e4-d585-bf9ea749e53b@gmx.com>
Date:   Mon, 23 Aug 2021 17:00:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <d433af292d5e99ff194bc6362133e64704ecd006.1629486429.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YT2y/hm8rKJZEGG1veG7c5aGwhJ0g/ocEgt4U/12+prVdaUbSZX
 TVeqEuslvPz9eYt8gd/loBpbkKpYFzARO2YgZ9WEVYZzq9ZTWJDkG587Csuwm5ZjyrAb64j
 wwgmo6sB81glY/QCNuX/ZcTkIFsfyve3X8wLa6k2/TQtNDn7oALdWL5K8cKZdqWz5qF27R9
 USWohnkFGF38SmFbtR4jQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZNIT4SO/3v4=:oJF2Z4IGd7tAc71Wsyl5HI
 jXikUutSep7tIKrbSucGGBl7BexbPxQXLHZgubSYj/6w9O8qTlQOnSi7Ys0uyTC1SnaZz71WV
 t2W9JWCm5xMXDQpnpTnQfiJbJKXXRHEd5ykwnW3boOdNrBv+po1RvGPdlQEiExqglciTCAtvZ
 fSN4dgwa8aNBTidG1dJpthZoktQci+Cd8AEPcV0JxaIk+4WOjH0CJQAPAzTRi+81T8VKJnnXt
 ajpcpoO/r15ogh/miBhJ5I7TleDAci33lmBIhKQWGYVUFzYguZDa2s+tKjEdHt3hLcQZ5kkef
 36LZyQTu/MbxO5G4HI/7N4zFo4BpGNaO6355VQHZCvcge50DSCY4sIHML04fBNj20hRE/EUOC
 NgH1n6fAoV6+acx2Ah8jpM/kg9sFfpzHX1n1yymeY1FvnGnC44NT6lSGjHl8pNtenGV2e3MRE
 tD7sF6QDgwfcxz2nB0DcJLVJpr5H/LwRSAMLfvivhQ+FPQjNQVTQMN8hgf/e9W352a0YDMQDj
 SoGe0FZDakS/3UMVmYyIZfRbjv3T8TUYzEuPaeSMlzoxNoOvSV3KbruKCFMyvdvbx6yQz2XUM
 tIa7qqXP+IHMAYYg4DYGdQl0jhVrDEJr/RaW0sBGmrn95AB4KZODeuaOpivs5FNf+Yib6q4ar
 IEU+T81VwoIQaa95rzLLlguc4gIlUW+6MR42i4wim1aCzM8Ya10Jhm4Sx3F9EprJVRumtrjpk
 qb2icHChKgTERYyizFjkA2zhvmHj9EWFlyLUtvtBLdYAVa7pwM+nnJNMZbpmb4o0ZGfkwUWj1
 JrH2rSHuByaJLGnh3GkxzWGSVq6Zn87PlqhKwtLw5tsQgJWv3oVtFxxdaCzwWW8fuJ1ZNGLI2
 g9hA6TepqRVrpSJ7lQYqI5Al1AhqOz4CD2v573SSd3mVw//iuu/PEaSMp9mYZ5tZ15Eolb3Up
 HJgS5DBXNXDCtHpwG6CpjEeD1VDO0I4xIsebHlvMsAag7tl7tnSahwXwmNe5mLLrmIQJrJq48
 FKYzPDFx3uY7YiZNUmgVHYYyCMNmeZ7oKTlLMp1LRAg0hvxts3Hl0TtghWRxm+kIOD8R7Ixej
 PQht9pUqdh9UDeMufROutOfNieS2F402GZv9POSl7g8Op2hhL5a2p8LrQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/21 =E4=B8=8A=E5=8D=883:11, Josef Bacik wrote:
> Currently we build a bare-bones file system in make_btrfs(), and then we
> load it up and fill in the rest of the file system after the fact.  One
> thing we omit in make_btrfs() is the block group item for the temporary
> system chunk we allocate, because we just add it after we've opened the
> file system.
>
> However I want to be able to generate the free space tree at
> make_btrfs() time, because extent tree v2 will not have an extent tree
> that has every block allocated in the system.  In order to do this I
> need to make sure that the free space tree entries are added on block
> group creation, which is annoying if we have to add this chunk after
> I've created a free space tree.
>
> So make future work simpler by simply adding our block group item at
> make_btrfs() time, this way I can do the right things with the free
> space tree in the generic make block group code without needing a
> special case for our temporary system chunk.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   mkfs/common.c | 31 +++++++++++++++++++++++++++++++
>   mkfs/main.c   |  9 ++-------
>   2 files changed, 33 insertions(+), 7 deletions(-)
>
> diff --git a/mkfs/common.c b/mkfs/common.c
> index 9263965e..cba97687 100644
> --- a/mkfs/common.c
> +++ b/mkfs/common.c
> @@ -190,6 +190,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg=
)
>   	u64 num_bytes;
>   	u64 system_group_offset =3D BTRFS_BLOCK_RESERVED_1M_FOR_SUPER;
>   	u64 system_group_size =3D BTRFS_MKFS_SYSTEM_GROUP_SIZE;
> +	bool add_block_group =3D true;
>
>   	if ((cfg->features & BTRFS_FEATURE_INCOMPAT_ZONED)) {
>   		system_group_offset =3D cfg->zone_size * BTRFS_NR_SB_LOG_ZONES;
> @@ -283,6 +284,36 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cf=
g)
>   		if (blk =3D=3D MKFS_SUPER_BLOCK)
>   			continue;
>
> +		/* Add the block group item for our temporary chunk. */
> +		if (cfg->blocks[blk] > system_group_offset &&
> +		    add_block_group) {

This makes the block group item always be the first item.

But for skinny metadata, METADATA_ITEM is smaller than BLOCK_GROUP_ITEM,
meaning it should be before BLOCK_GROUP_ITEM.

Won't this cause the extent tree has a bad key order?


BTW, if we get rid of the superblock in cfg->blocks[], we don't need to
check against system_group_offset.

Thanks,
Qu
> +			struct btrfs_block_group_item *bg_item;
> +
> +			add_block_group =3D false;
> +
> +			itemoff -=3D sizeof(*bg_item);
> +			btrfs_set_disk_key_objectid(&disk_key,
> +						    system_group_offset);
> +			btrfs_set_disk_key_offset(&disk_key,
> +						  system_group_size);
> +			btrfs_set_disk_key_type(&disk_key,
> +						BTRFS_BLOCK_GROUP_ITEM_KEY);
> +			btrfs_set_item_key(buf, &disk_key, nritems);
> +			btrfs_set_item_offset(buf, btrfs_item_nr(nritems),
> +					      itemoff);
> +			btrfs_set_item_size(buf, btrfs_item_nr(nritems),
> +					    sizeof(*bg_item));
> +
> +			bg_item =3D btrfs_item_ptr(buf, nritems,
> +						 struct btrfs_block_group_item);
> +			btrfs_set_block_group_used(buf, bg_item, total_used);
> +			btrfs_set_block_group_flags(buf, bg_item,
> +						    BTRFS_BLOCK_GROUP_SYSTEM);
> +			btrfs_set_block_group_chunk_objectid(buf, bg_item,
> +					BTRFS_FIRST_CHUNK_TREE_OBJECTID);
> +			nritems++;
> +		}
> +
>   		item_size =3D sizeof(struct btrfs_extent_item);
>   		if (!skinny_metadata)
>   			item_size +=3D sizeof(struct btrfs_tree_block_info);
> diff --git a/mkfs/main.c b/mkfs/main.c
> index eab93eb3..ea53e9c7 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -67,7 +67,6 @@ static int create_metadata_block_groups(struct btrfs_r=
oot *root, int mixed,
>   	struct btrfs_trans_handle *trans;
>   	struct btrfs_space_info *sinfo;
>   	u64 flags =3D BTRFS_BLOCK_GROUP_METADATA;
> -	u64 bytes_used;
>   	u64 chunk_start =3D 0;
>   	u64 chunk_size =3D 0;
>   	u64 system_group_offset =3D BTRFS_BLOCK_RESERVED_1M_FOR_SUPER;
> @@ -90,16 +89,12 @@ static int create_metadata_block_groups(struct btrfs=
_root *root, int mixed,
>
>   	trans =3D btrfs_start_transaction(root, 1);
>   	BUG_ON(IS_ERR(trans));
> -	bytes_used =3D btrfs_super_bytes_used(fs_info->super_copy);
>
>   	root->fs_info->system_allocs =3D 1;
>   	/*
> -	 * First temporary system chunk must match the chunk layout
> -	 * created in make_btrfs().
> +	 * We already created the block group item for our temporary system
> +	 * chunk in make_btrfs(), so account for the size here.
>   	 */
> -	ret =3D btrfs_make_block_group(trans, fs_info, bytes_used,
> -				     BTRFS_BLOCK_GROUP_SYSTEM,
> -				     system_group_offset, system_group_size);
>   	allocation->system +=3D system_group_size;
>   	if (ret)
>   		return ret;
>
