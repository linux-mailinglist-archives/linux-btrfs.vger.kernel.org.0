Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B6B4277C4
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Oct 2021 08:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhJIGgA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Oct 2021 02:36:00 -0400
Received: from out20-2.mail.aliyun.com ([115.124.20.2]:36435 "EHLO
        out20-2.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbhJIGf7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Oct 2021 02:35:59 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0158113-0.000148085-0.984041;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.LWDnziu_1633761240;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.LWDnziu_1633761240)
          by smtp.aliyun-inc.com(10.147.41.137);
          Sat, 09 Oct 2021 14:34:01 +0800
Date:   Sat, 09 Oct 2021 14:34:03 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     Josef Bacik <josef@toxicpanda.com>, wqu@suse.com
Subject: Re: [PATCH 1/9] btrfs-progs: use an associative array for init mkfs blocks
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
In-Reply-To: <9e4cd53b74631be7c4bf78653de2d931d53dce3c.1629486429.git.josef@toxicpanda.com>
References: <cover.1629486429.git.josef@toxicpanda.com> <9e4cd53b74631be7c4bf78653de2d931d53dce3c.1629486429.git.josef@toxicpanda.com>
Message-Id: <20211009143403.5A1F.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, Josef Bacik, Qu Wenruo

This patchset will make a patch from Qu Wenruo will no longer work as
expected.

 From:    Qu Wenruo <wqu@suse.com>
 To:      linux-btrfs@vger.kernel.org
 Cc:      Chris Murphy <lists@colorremedies.com>
 Date:    Sat, 31 Jul 2021 15:42:40 +0800
 Subject: [PATCH] btrfs-progs: mkfs: set super_cache_generation to 0 if we're using free space tree

  # mkfs.btrfs -R free-space-tree test.img
  # btrfs inspect-internal dump-super test.img | grep cache_generation

0 is expected, but -1 is returned since this patchset.

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2021/10/09

> Extent tree v2 will not create an extent tree or csum tree initially,
> and it will create a block group tree.  To handle this we want to rework
> the initial mkfs step to take an array of the blocks we want to create
> and use the array to keep track of which blocks we need to create.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  mkfs/common.c | 56 ++++++++++++++++++++++++++++++++-------------------
>  mkfs/common.h | 10 +++++++++
>  2 files changed, 45 insertions(+), 21 deletions(-)
> 
> diff --git a/mkfs/common.c b/mkfs/common.c
> index 2c041224..e9ff529a 100644
> --- a/mkfs/common.c
> +++ b/mkfs/common.c
> @@ -31,16 +31,18 @@
>  #include "mkfs/common.h"
>  
>  static u64 reference_root_table[] = {
> -	[1] =	BTRFS_ROOT_TREE_OBJECTID,
> -	[2] =	BTRFS_EXTENT_TREE_OBJECTID,
> -	[3] =	BTRFS_CHUNK_TREE_OBJECTID,
> -	[4] =	BTRFS_DEV_TREE_OBJECTID,
> -	[5] =	BTRFS_FS_TREE_OBJECTID,
> -	[6] =	BTRFS_CSUM_TREE_OBJECTID,
> +	[MKFS_ROOT_TREE]	=	BTRFS_ROOT_TREE_OBJECTID,
> +	[MKFS_EXTENT_TREE]	=	BTRFS_EXTENT_TREE_OBJECTID,
> +	[MKFS_CHUNK_TREE]	=	BTRFS_CHUNK_TREE_OBJECTID,
> +	[MKFS_DEV_TREE]		=	BTRFS_DEV_TREE_OBJECTID,
> +	[MKFS_FS_TREE]		=	BTRFS_FS_TREE_OBJECTID,
> +	[MKFS_CSUM_TREE]	=	BTRFS_CSUM_TREE_OBJECTID,
>  };
>  
>  static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
> -			struct extent_buffer *buf)
> +				  struct extent_buffer *buf,
> +				  const enum btrfs_mkfs_block *blocks,
> +				  int blocks_nr)
>  {
>  	struct btrfs_root_item root_item;
>  	struct btrfs_inode_item *inode_item;
> @@ -49,6 +51,7 @@ static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
>  	u32 itemoff;
>  	int ret = 0;
>  	int blk;
> +	int i;
>  	u8 uuid[BTRFS_UUID_SIZE];
>  
>  	memset(buf->data + sizeof(struct btrfs_header), 0,
> @@ -71,7 +74,8 @@ static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
>  	btrfs_set_disk_key_offset(&disk_key, 0);
>  	itemoff = __BTRFS_LEAF_DATA_SIZE(cfg->nodesize) - sizeof(root_item);
>  
> -	for (blk = 0; blk < MKFS_BLOCK_COUNT; blk++) {
> +	for (i = 0; i < blocks_nr; i++) {
> +		blk = blocks[i];
>  		if (blk == MKFS_SUPER_BLOCK || blk == MKFS_ROOT_TREE
>  		    || blk == MKFS_CHUNK_TREE)
>  			continue;
> @@ -145,10 +149,13 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
>  	struct btrfs_chunk *chunk;
>  	struct btrfs_dev_item *dev_item;
>  	struct btrfs_dev_extent *dev_extent;
> +	const enum btrfs_mkfs_block *blocks = extent_tree_v1_blocks;
>  	u8 chunk_tree_uuid[BTRFS_UUID_SIZE];
>  	u8 *ptr;
>  	int i;
>  	int ret;
> +	int blocks_nr = ARRAY_SIZE(extent_tree_v1_blocks);
> +	int blk;
>  	u32 itemoff;
>  	u32 nritems = 0;
>  	u64 first_free;
> @@ -195,8 +202,11 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
>  	uuid_generate(chunk_tree_uuid);
>  
>  	cfg->blocks[MKFS_SUPER_BLOCK] = BTRFS_SUPER_INFO_OFFSET;
> -	for (i = 1; i < MKFS_BLOCK_COUNT; i++) {
> -		cfg->blocks[i] = system_group_offset + cfg->nodesize * (i - 1);
> +	for (i = 0; i < blocks_nr; i++) {
> +		blk = blocks[i];
> +		if (blk == MKFS_SUPER_BLOCK)
> +			continue;
> +		cfg->blocks[blk] = system_group_offset + cfg->nodesize * i;
>  	}
>  
>  	btrfs_set_super_bytenr(&super, cfg->blocks[MKFS_SUPER_BLOCK]);
> @@ -236,7 +246,7 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
>  			    btrfs_header_chunk_tree_uuid(buf),
>  			    BTRFS_UUID_SIZE);
>  
> -	ret = btrfs_create_tree_root(fd, cfg, buf);
> +	ret = btrfs_create_tree_root(fd, cfg, buf, blocks, blocks_nr);
>  	if (ret < 0)
>  		goto out;
>  
> @@ -245,30 +255,34 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
>  		cfg->nodesize - sizeof(struct btrfs_header));
>  	nritems = 0;
>  	itemoff = __BTRFS_LEAF_DATA_SIZE(cfg->nodesize);
> -	for (i = 1; i < MKFS_BLOCK_COUNT; i++) {
> +	for (i = 0; i < blocks_nr; i++) {
> +		blk = blocks[i];
> +		if (blk == MKFS_SUPER_BLOCK)
> +			continue;
> +
>  		item_size = sizeof(struct btrfs_extent_item);
>  		if (!skinny_metadata)
>  			item_size += sizeof(struct btrfs_tree_block_info);
>  
> -		if (cfg->blocks[i] < first_free) {
> +		if (cfg->blocks[blk] < first_free) {
>  			error("block[%d] below first free: %llu < %llu",
> -					i, (unsigned long long)cfg->blocks[i],
> +					i, (unsigned long long)cfg->blocks[blk],
>  					(unsigned long long)first_free);
>  			ret = -EINVAL;
>  			goto out;
>  		}
> -		if (cfg->blocks[i] < cfg->blocks[i - 1]) {
> +		if (cfg->blocks[blk] < cfg->blocks[blocks[i - 1]]) {
>  			error("blocks %d and %d in reverse order: %llu < %llu",
> -				i, i - 1,
> -				(unsigned long long)cfg->blocks[i],
> -				(unsigned long long)cfg->blocks[i - 1]);
> +				blk, blocks[i - 1],
> +				(unsigned long long)cfg->blocks[blk],
> +				(unsigned long long)cfg->blocks[blocks[i - 1]]);
>  			ret = -EINVAL;
>  			goto out;
>  		}
>  
>  		/* create extent item */
>  		itemoff -= item_size;
> -		btrfs_set_disk_key_objectid(&disk_key, cfg->blocks[i]);
> +		btrfs_set_disk_key_objectid(&disk_key, cfg->blocks[blk]);
>  		if (skinny_metadata) {
>  			btrfs_set_disk_key_type(&disk_key,
>  						BTRFS_METADATA_ITEM_KEY);
> @@ -292,8 +306,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
>  		nritems++;
>  
>  		/* create extent ref */
> -		ref_root = reference_root_table[i];
> -		btrfs_set_disk_key_objectid(&disk_key, cfg->blocks[i]);
> +		ref_root = reference_root_table[blk];
> +		btrfs_set_disk_key_objectid(&disk_key, cfg->blocks[blk]);
>  		btrfs_set_disk_key_offset(&disk_key, ref_root);
>  		btrfs_set_disk_key_type(&disk_key, BTRFS_TREE_BLOCK_REF_KEY);
>  		btrfs_set_item_key(buf, &disk_key, nritems);
> diff --git a/mkfs/common.h b/mkfs/common.h
> index ea87c3ca..378da6bd 100644
> --- a/mkfs/common.h
> +++ b/mkfs/common.h
> @@ -55,6 +55,16 @@ enum btrfs_mkfs_block {
>  	MKFS_BLOCK_COUNT
>  };
>  
> +static const enum btrfs_mkfs_block extent_tree_v1_blocks[] = {
> +	MKFS_SUPER_BLOCK,
> +	MKFS_ROOT_TREE,
> +	MKFS_EXTENT_TREE,
> +	MKFS_CHUNK_TREE,
> +	MKFS_DEV_TREE,
> +	MKFS_FS_TREE,
> +	MKFS_CSUM_TREE,
> +};
> +
>  struct btrfs_mkfs_config {
>  	/* Label of the new filesystem */
>  	const char *label;
> -- 
> 2.26.3


