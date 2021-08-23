Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5C03F46C1
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 10:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbhHWInP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 04:43:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:49323 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235387AbhHWInO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 04:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629708148;
        bh=xVeHjxohcOHHfH4oKAy0c1eYlNXBhY6Vgo/byAM6WA0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=GvjgAoiw0v2sgLaF/rJvksTw+xFFImhChgVJBYDlOGvOWYa5oLPFHAGlPqJ4J+N6+
         1lh98rYtZAC/fyIchn4+jMXduHFdI+cf7Sxabil+t0XLHrcTZXDBO6TOzKA4lX56lH
         9JAr4xg4KGqsvcmOhQvlyDTlbvhGfI1TKcicZ4D0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MTzay-1mQIiH1hRq-00R2tz; Mon, 23
 Aug 2021 10:42:28 +0200
Subject: Re: [PATCH 1/9] btrfs-progs: use an associative array for init mkfs
 blocks
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1629486429.git.josef@toxicpanda.com>
 <9e4cd53b74631be7c4bf78653de2d931d53dce3c.1629486429.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <ffdac968-e865-2435-484d-9ebd763603e5@gmx.com>
Date:   Mon, 23 Aug 2021 16:42:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <9e4cd53b74631be7c4bf78653de2d931d53dce3c.1629486429.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sP4R+5j+uI3eikbS3uIYoelS3qhdHVGLlFyxgfm/0S3QiulVi4X
 +OKVJCNUrGPLqgaeCEws+uuK6QCjsaPc1i2Sr0b4zie3HdgbOIWoNIWdtZ7sfhE0bKYmdiB
 FSeN7gQth36VfAyUaZhw+x6se+zzAbLz4IFAy762SE+6yBKqz/UiHtGj891/qqc0hSTfPlJ
 UpuRI594h9DgjNn+VgdSQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0KIfgkvENjA=:FKKaZvpcY4I9YxWPNYL0EE
 7dBwAOGoLC/kwP3MdzQZoTT2V4J+qTXYwxx0EGCfF5oREHJTQ7Q5H1KvChjln7ZfbQsFXt9bz
 Lcyzr1LAvffmxoPHAIza4N3NcrT6DVvXN1vOm+mCzMdK6Ye5AyN9G34Glx0WOwMjR79+uwCF4
 OAlNEog3UcCeCs2CA0K3+CCyvgTXMdtK0eOM/zQ4jMch7o87PsC6vyou+fwR0/VDpaFrmSED8
 QLhfO0MISTEj6cbpC7g9kQI0iv0C8lCskGqWH/r6J5zbUsUBeJDQB2r/okdOFILH7JynllDDP
 Y6ZyV8W0g4EVEcDEfMhlWPfpyO0roy7HwFEJICCPS3VPHZzxINPOO+cGCluafJcweHWQGAnCq
 MDPPXmYYXZq4Hfl6t2qugmpLE/9cFiwjXXs4zkjh6O+biAP06VuCD64M2zryOaTR0jFGSxMOR
 CAmZ7Dt1NLpq7V0BDG5rsZM8T0SiWIDPESKUt8EUlXojt6P1tIzs81GFHM/e08Yh+c3lCVnWo
 aUnJfN7Gkk7icIEVX3ywxJX5tK+DZqf+12o/q6oe+j6VtMXyvZqoO5+8QTiclmuq16jO0CRCm
 Zc13kZCW23mwFi+s2OZdhj11FuyliAm7Fg6m+NFf24blGI3KhLv+/eL2NcPCJseS8ApNvhD8g
 PNMaBI2nnXHoEJp9L53+Y0jMEjWozAhgP0ii94RwSXiI4Noco8r1C5eQneBbXien785eaFUEt
 H4KzMf13SOHGE3b7d7GAeJbU50pQIhWRwbs0F4Eqzd+l4AHU1fFYPQeSFRTUQoZAmJIUcfrT+
 7iI6ixGyYIDFvRegcxVkK05UC0JkRau6LQuv+KJA1JdgRMT7Kzli3TnxHSXWx4d2SU8Tec2+0
 kpPM+68vaD8qEGbvw1fd3capo0IyL5/BMGTVEnTTY1N79B+6Kyx9f/WhGcWiEVxC9FjwJY0jn
 doZ2T9/vjNOZ4uwNlD2gRu9FA8IWAFUTXq0ZQLQB6B6q6CFRAA1OFVUdDMC4Kdt5I/XdhD+i4
 3HzlgoOi7Po6SJZxqOrtPnpNKCdtrcaJYg4O6fYlqzJUVsJCwj+PVIq1Qug+kkBTG4Rdc6Y7I
 Dm3SDMgnfW8f3S3rlLcKTdwa5iPAxgtMfj//6C5Mdnr9qg5UWfF7fRasQ==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/21 =E4=B8=8A=E5=8D=883:11, Josef Bacik wrote:
> Extent tree v2 will not create an extent tree or csum tree initially,
> and it will create a block group tree.  To handle this we want to rework
> the initial mkfs step to take an array of the blocks we want to create
> and use the array to keep track of which blocks we need to create.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>   mkfs/common.c | 56 ++++++++++++++++++++++++++++++++-------------------
>   mkfs/common.h | 10 +++++++++
>   2 files changed, 45 insertions(+), 21 deletions(-)
>
> diff --git a/mkfs/common.c b/mkfs/common.c
> index 2c041224..e9ff529a 100644
> --- a/mkfs/common.c
> +++ b/mkfs/common.c
> @@ -31,16 +31,18 @@
>   #include "mkfs/common.h"
>
>   static u64 reference_root_table[] =3D {
> -	[1] =3D	BTRFS_ROOT_TREE_OBJECTID,
> -	[2] =3D	BTRFS_EXTENT_TREE_OBJECTID,
> -	[3] =3D	BTRFS_CHUNK_TREE_OBJECTID,
> -	[4] =3D	BTRFS_DEV_TREE_OBJECTID,
> -	[5] =3D	BTRFS_FS_TREE_OBJECTID,
> -	[6] =3D	BTRFS_CSUM_TREE_OBJECTID,
> +	[MKFS_ROOT_TREE]	=3D	BTRFS_ROOT_TREE_OBJECTID,
> +	[MKFS_EXTENT_TREE]	=3D	BTRFS_EXTENT_TREE_OBJECTID,
> +	[MKFS_CHUNK_TREE]	=3D	BTRFS_CHUNK_TREE_OBJECTID,
> +	[MKFS_DEV_TREE]		=3D	BTRFS_DEV_TREE_OBJECTID,
> +	[MKFS_FS_TREE]		=3D	BTRFS_FS_TREE_OBJECTID,
> +	[MKFS_CSUM_TREE]	=3D	BTRFS_CSUM_TREE_OBJECTID,
>   };

Can we use a bitmap for these combinations?

So that we just need one parameter to indicate what trees we want.

>
>   static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cf=
g,
> -			struct extent_buffer *buf)
> +				  struct extent_buffer *buf,
> +				  const enum btrfs_mkfs_block *blocks,
> +				  int blocks_nr)
>   {
>   	struct btrfs_root_item root_item;
>   	struct btrfs_inode_item *inode_item;
> @@ -49,6 +51,7 @@ static int btrfs_create_tree_root(int fd, struct btrfs=
_mkfs_config *cfg,
>   	u32 itemoff;
>   	int ret =3D 0;
>   	int blk;
> +	int i;
>   	u8 uuid[BTRFS_UUID_SIZE];
>
>   	memset(buf->data + sizeof(struct btrfs_header), 0,
> @@ -71,7 +74,8 @@ static int btrfs_create_tree_root(int fd, struct btrfs=
_mkfs_config *cfg,
>   	btrfs_set_disk_key_offset(&disk_key, 0);
>   	itemoff =3D __BTRFS_LEAF_DATA_SIZE(cfg->nodesize) - sizeof(root_item)=
;
>
> -	for (blk =3D 0; blk < MKFS_BLOCK_COUNT; blk++) {
> +	for (i =3D 0; i < blocks_nr; i++) {
> +		blk =3D blocks[i];
>   		if (blk =3D=3D MKFS_SUPER_BLOCK || blk =3D=3D MKFS_ROOT_TREE
>   		    || blk =3D=3D MKFS_CHUNK_TREE)
>   			continue;
> @@ -145,10 +149,13 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *c=
fg)
>   	struct btrfs_chunk *chunk;
>   	struct btrfs_dev_item *dev_item;
>   	struct btrfs_dev_extent *dev_extent;
> +	const enum btrfs_mkfs_block *blocks =3D extent_tree_v1_blocks;
>   	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
>   	u8 *ptr;
>   	int i;
>   	int ret;
> +	int blocks_nr =3D ARRAY_SIZE(extent_tree_v1_blocks);
> +	int blk;
>   	u32 itemoff;
>   	u32 nritems =3D 0;
>   	u64 first_free;
> @@ -195,8 +202,11 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cf=
g)
>   	uuid_generate(chunk_tree_uuid);
>
>   	cfg->blocks[MKFS_SUPER_BLOCK] =3D BTRFS_SUPER_INFO_OFFSET;
> -	for (i =3D 1; i < MKFS_BLOCK_COUNT; i++) {
> -		cfg->blocks[i] =3D system_group_offset + cfg->nodesize * (i - 1);
> +	for (i =3D 0; i < blocks_nr; i++) {
> +		blk =3D blocks[i];
> +		if (blk =3D=3D MKFS_SUPER_BLOCK)
> +			continue;
> +		cfg->blocks[blk] =3D system_group_offset + cfg->nodesize * i;
>   	}
>
>   	btrfs_set_super_bytenr(&super, cfg->blocks[MKFS_SUPER_BLOCK]);
> @@ -236,7 +246,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg=
)
>   			    btrfs_header_chunk_tree_uuid(buf),
>   			    BTRFS_UUID_SIZE);
>
> -	ret =3D btrfs_create_tree_root(fd, cfg, buf);
> +	ret =3D btrfs_create_tree_root(fd, cfg, buf, blocks, blocks_nr);
>   	if (ret < 0)
>   		goto out;
>
> @@ -245,30 +255,34 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *c=
fg)
>   		cfg->nodesize - sizeof(struct btrfs_header));
>   	nritems =3D 0;
>   	itemoff =3D __BTRFS_LEAF_DATA_SIZE(cfg->nodesize);
> -	for (i =3D 1; i < MKFS_BLOCK_COUNT; i++) {
> +	for (i =3D 0; i < blocks_nr; i++) {
> +		blk =3D blocks[i];
> +		if (blk =3D=3D MKFS_SUPER_BLOCK)
> +			continue;
> +
>   		item_size =3D sizeof(struct btrfs_extent_item);
>   		if (!skinny_metadata)
>   			item_size +=3D sizeof(struct btrfs_tree_block_info);
>
> -		if (cfg->blocks[i] < first_free) {
> +		if (cfg->blocks[blk] < first_free) {
>   			error("block[%d] below first free: %llu < %llu",
> -					i, (unsigned long long)cfg->blocks[i],
> +					i, (unsigned long long)cfg->blocks[blk],
>   					(unsigned long long)first_free);
>   			ret =3D -EINVAL;
>   			goto out;
>   		}
> -		if (cfg->blocks[i] < cfg->blocks[i - 1]) {
> +		if (cfg->blocks[blk] < cfg->blocks[blocks[i - 1]]) {
>   			error("blocks %d and %d in reverse order: %llu < %llu",
> -				i, i - 1,
> -				(unsigned long long)cfg->blocks[i],
> -				(unsigned long long)cfg->blocks[i - 1]);
> +				blk, blocks[i - 1],
> +				(unsigned long long)cfg->blocks[blk],
> +				(unsigned long long)cfg->blocks[blocks[i - 1]]);
>   			ret =3D -EINVAL;
>   			goto out;
>   		}
>
>   		/* create extent item */
>   		itemoff -=3D item_size;
> -		btrfs_set_disk_key_objectid(&disk_key, cfg->blocks[i]);
> +		btrfs_set_disk_key_objectid(&disk_key, cfg->blocks[blk]);
>   		if (skinny_metadata) {
>   			btrfs_set_disk_key_type(&disk_key,
>   						BTRFS_METADATA_ITEM_KEY);
> @@ -292,8 +306,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg=
)
>   		nritems++;
>
>   		/* create extent ref */
> -		ref_root =3D reference_root_table[i];
> -		btrfs_set_disk_key_objectid(&disk_key, cfg->blocks[i]);
> +		ref_root =3D reference_root_table[blk];
> +		btrfs_set_disk_key_objectid(&disk_key, cfg->blocks[blk]);
>   		btrfs_set_disk_key_offset(&disk_key, ref_root);
>   		btrfs_set_disk_key_type(&disk_key, BTRFS_TREE_BLOCK_REF_KEY);
>   		btrfs_set_item_key(buf, &disk_key, nritems);
> diff --git a/mkfs/common.h b/mkfs/common.h
> index ea87c3ca..378da6bd 100644
> --- a/mkfs/common.h
> +++ b/mkfs/common.h
> @@ -55,6 +55,16 @@ enum btrfs_mkfs_block {
>   	MKFS_BLOCK_COUNT
>   };
>
> +static const enum btrfs_mkfs_block extent_tree_v1_blocks[] =3D {
> +	MKFS_SUPER_BLOCK,

Do we really need this special enum for superblock?

It's always in the fixed offset on-disk.

Despite it looks like a good cleanup.

Thanks,
Qu
> +	MKFS_ROOT_TREE,
> +	MKFS_EXTENT_TREE,
> +	MKFS_CHUNK_TREE,
> +	MKFS_DEV_TREE,
> +	MKFS_FS_TREE,
> +	MKFS_CSUM_TREE,
> +};
> +
>   struct btrfs_mkfs_config {
>   	/* Label of the new filesystem */
>   	const char *label;
>
