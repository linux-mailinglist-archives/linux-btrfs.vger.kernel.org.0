Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61EB1428495
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Oct 2021 03:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhJKB0X (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 10 Oct 2021 21:26:23 -0400
Received: from mout.gmx.net ([212.227.15.18]:39619 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231390AbhJKB0W (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 10 Oct 2021 21:26:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1633915459;
        bh=8WvbfDoE9HD9HOrzK7ZbmHRizYNN0MzRm7OSwQIPlHY=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=lQ0WHcG3Nc6+HP86/UmpE7vhOA7iY8NiZAIqVIutm6v8xg0gM4MIdzfSyOXUZtUhT
         egMXZVTD1G+RrFGnrVOvQ2GjQAnUpJXtba5N0Lv1LLvNRpXqwE/2LROTbaK7tBwT5a
         2VyeQo/mMehOJk9skBJFU4FH5hM9Kf3ewfkMg6U0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MvsIv-1mrYBR1rjL-00sxZQ; Mon, 11
 Oct 2021 03:24:19 +0200
Message-ID: <2b4bb831-f2d8-8e21-9545-bf317a59a266@gmx.com>
Date:   Mon, 11 Oct 2021 09:24:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1629749291.git.josef@toxicpanda.com>
 <99b0c0bd527103c7c5ade8215d33542f75db8e36.1629749291.git.josef@toxicpanda.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH v2 09/10] btrfs-progs: mkfs: generate free space tree at
 make_btrfs() time
In-Reply-To: <99b0c0bd527103c7c5ade8215d33542f75db8e36.1629749291.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mYOx9nQFA+PHCEHJJQ82gKdTbAb74f/hEfDWR9B2n8VphjQGR9A
 1+kHVo8zfXsvVCLIzQCzZskwi6jr25vQiNXPJ3H61C6O6yK04Hrnc7ahPTANSB2bRll3D/X
 gSrx7H8WaeU6xwAPViICO/VAl2y07N2Y0ud57cWiBqGLhpqFGE2301YDrY3E9a3zT9lUyyB
 QAVl1NSWT//VVteZ/nmtQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:wBe+xZu4dnY=:rGPpB0TzbHpccUE2FKXr2r
 B0iD05io/tqiNgvFEdSj/CLNJcfB1VFlREgpRgXqeNMddkjao1s3trBi2rfuI/Go+0JIhCm36
 ZcnUPHS6XXbg32aOL7fjfTUKHjC4rvsse4FZ4S3zSjXLSd2P6NnM0NoWTSna9YLjMrP0aXMZ4
 0VZiIvPfnO5e6LkuoqXztW3hdTmXavNTkxjMI1Gt1IIrrgHRR+H6fLibAiCfcOy88KFT1TN/L
 slbIrgn+AKqqKoUk3ViBiPx+Q53IlSB24bJU9oOH7AEPMIoVbn4dayxt4zxS3FjGCX8+iR1X1
 BkJDJOS1oLZw39gFoRPAqDo6o00A7bSkZVPUDexmRlPJWK9A7VAnXVNzdQ/392eKc/aALHwfM
 Gb8LiAr4s5p1z4IdE81u0UIonyVuZ6a1NoTkFRIPkQNCf9LJTmYRgvVeY2fFjL5Lj0/RsgIJd
 3GapyPla0xMQXavyAbOPhYcwzuCeFaIGnhDofkyzEsPyA6FH8+jUN1NQ7k5TwBQAEgqtMCXUL
 EmInU5k3g2F5YyatUk7Pt6f1Jw9riIjYik2G+ZcZZwHH5rHu+VlS/ur7JYNHceAI9bq2VNz8K
 Ltn8Ar6HA8vFFQx/ZcKzoLKsRx+6pjXXRxxlJkynt2IBY4PGeX3siAuAUUDmkaznXL6VZONZu
 /ob/l7tTCRKsLqSRkhUJIgSyoDqAGnC1iAPbAYdTHzkQbiI8fVq+sztCWRnYcgYYIayZbO/8B
 mVaUIpFNKNVJYeMaqvp7QlIz4rEgfw/KT2/V52MAm8yyaRekgzG5AIVmRo3tTRJ9aHHLzXF4K
 6hDkFZfyt6RNftKLmjjtzrc/swENwqBSPZPJlNGWNBOLN/gtutoMQG2iSiOx71mFOvPYtplKV
 pVcFbBXMplzWunlXDQIUWE7WsaU+3KtfVbj2erRfAex/ivbdn2if4USFrUqGELadWX7DaCUHa
 hUmKKGC3U7mmbcTlcq0UsRdLwpfaexbueulvxMKA/ZfTdTRvlW/srihpCXjUgryC0sfSQ4ZnL
 /3OsU8NKz7sy55c/tiytUVIFWAi/8+POcQP7ivLCHEbxNBEJNjFa17t1/yK3tFVFy7f6PQkEm
 IA6gxweGYV8zGk=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/8/24 04:14, Josef Bacik wrote:
> With extent-tree-v2 we won't be able to cache block groups based on the
> extent tree, so we need to have a valid free space tree before we open
> the temporary file system to finish setting the file system up.  Set up
> the basic free space entries for our temporary system chunk if we have
> the free space tree enabled and stop generating the tree after the fact.
>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Just to note a new regression exposed recently.

This patch is making mkfs.btrfs to leave some SINGLE metadata left
uncleaned, if "-R free-space-tree -d DUP" is specified.

"-d DUP" part is needed just to make data profile to be non-SINGLE, and
is required to reproduce the bug.

Before this patch:
  # mkfs.btrfs -f -R free-space-tree -d DUP /dev/test/test
  # btrfs ins dump-tree -t chunk /dev/test/test | grep "type METADATA"
    length 268435456 owner 2 stripe_len 65536 type METADATA|DUP

After this patch:
  # mkfs.btrfs -f -R free-space-tree -d DUP /dev/test/test
  # btrfs ins dump-tree -t chunk /dev/test/test | grep "type METADATA"
    length 8388608 owner 2 stripe_len 65536 type METADATA
    length 268435456 owner 2 stripe_len 65536 type METADATA|DUP

It is not a big deal, as kernel can automatically remove it, but with
recent btrfs-progs update, it can cause extra warning:

   $ sudo btrfs fi df /mnt/btrfs/
   Data, DUP: total=3D1.00GiB, used=3D0.00B
   System, DUP: total=3D8.00MiB, used=3D16.00KiB
   Metadata, DUP: total=3D256.00MiB, used=3D176.00KiB
   Metadata, single: total=3D8.00MiB, used=3D0.00B
   GlobalReserve, single: total=3D3.25MiB, used=3D0.00B
   WARNING: Multiple block group profiles detected, see 'man btrfs(5)'.
   WARNING:   Metadata: single, dup


The root cause is the timing of free space cache creation, it's still
created when the initial temporary fs is created.

Thus it's using SINGLE metadata.

Although we later migrated to the new metadata profile, by somehow the
empty metadata chunk is not properly cleared at mkfs time.

I'll investigate on why cleanup_temp_chunks() is not working properly
for this new case.

Thanks,
Qu
> ---
>   mkfs/common.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   mkfs/common.h |  9 +++++++
>   mkfs/main.c   | 13 +++-------
>   3 files changed, 82 insertions(+), 9 deletions(-)
>
> diff --git a/mkfs/common.c b/mkfs/common.c
> index 9b5f96e3..631e6d43 100644
> --- a/mkfs/common.c
> +++ b/mkfs/common.c
> @@ -37,6 +37,7 @@ static u64 reference_root_table[] =3D {
>   	[MKFS_DEV_TREE]		=3D	BTRFS_DEV_TREE_OBJECTID,
>   	[MKFS_FS_TREE]		=3D	BTRFS_FS_TREE_OBJECTID,
>   	[MKFS_CSUM_TREE]	=3D	BTRFS_CSUM_TREE_OBJECTID,
> +	[MKFS_FREE_SPACE_TREE]	=3D	BTRFS_FREE_SPACE_TREE_OBJECTID,
>   };
>
>   static int btrfs_write_empty_tree(int fd, struct btrfs_mkfs_config *cf=
g,
> @@ -139,6 +140,55 @@ static int btrfs_create_tree_root(int fd, struct bt=
rfs_mkfs_config *cfg,
>   	return ret;
>   }
>
> +static int create_free_space_tree(int fd, struct btrfs_mkfs_config *cfg=
,
> +				  struct extent_buffer *buf, u64 group_start,
> +				  u64 group_size, u64 free_start)
> +{
> +	struct btrfs_free_space_info *info;
> +	struct btrfs_disk_key disk_key;
> +	enum btrfs_mkfs_block blk;
> +	int itemoff =3D __BTRFS_LEAF_DATA_SIZE(cfg->nodesize);
> +	int nritems =3D 0;
> +	int i =3D 0;
> +	int ret;
> +
> +	memset(buf->data + sizeof(struct btrfs_header), 0,
> +	       cfg->nodesize - sizeof(struct btrfs_header));
> +	itemoff -=3D sizeof(*info);
> +
> +	btrfs_set_disk_key_objectid(&disk_key, group_start);
> +	btrfs_set_disk_key_offset(&disk_key, group_size);
> +	btrfs_set_disk_key_type(&disk_key, BTRFS_FREE_SPACE_INFO_KEY);
> +	btrfs_set_item_key(buf, &disk_key, nritems);
> +	btrfs_set_item_offset(buf, btrfs_item_nr(nritems), itemoff);
> +	btrfs_set_item_size(buf, btrfs_item_nr(nritems), sizeof(*info));
> +
> +	info =3D btrfs_item_ptr(buf, nritems, struct btrfs_free_space_info);
> +	btrfs_set_free_space_extent_count(buf, info, 1);
> +	btrfs_set_free_space_flags(buf, info, 0);
> +
> +	nritems++;
> +	btrfs_set_disk_key_objectid(&disk_key, free_start);
> +	btrfs_set_disk_key_offset(&disk_key, group_start + group_size -
> +				  free_start);
> +	btrfs_set_disk_key_type(&disk_key, BTRFS_FREE_SPACE_EXTENT_KEY);
> +	btrfs_set_item_key(buf, &disk_key, nritems);
> +	btrfs_set_item_offset(buf, btrfs_item_nr(nritems), itemoff);
> +	btrfs_set_item_size(buf, btrfs_item_nr(nritems), 0);
> +
> +	nritems++;
> +	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_FREE_SPACE_TREE]);
> +	btrfs_set_header_owner(buf, BTRFS_FREE_SPACE_TREE_OBJECTID);
> +	btrfs_set_header_nritems(buf, nritems);
> +	csum_tree_block_size(buf, btrfs_csum_type_size(cfg->csum_type), 0,
> +			     cfg->csum_type);
> +	ret =3D pwrite(fd, buf->data, cfg->nodesize,
> +		     cfg->blocks[MKFS_FREE_SPACE_TREE]);
> +	if (ret !=3D cfg->nodesize)
> +		return ret < 0 ? -errno : -EIO;
> +	return 0;
> +}
> +
>   /*
>    * @fs_uuid - if NULL, generates a UUID, returns back the new filesyst=
em UUID
>    *
> @@ -189,6 +239,12 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cf=
g)
>   	u64 system_group_offset =3D BTRFS_BLOCK_RESERVED_1M_FOR_SUPER;
>   	u64 system_group_size =3D BTRFS_MKFS_SYSTEM_GROUP_SIZE;
>   	bool add_block_group =3D true;
> +	bool free_space_tree =3D !!(cfg->runtime_features &
> +				  BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE);
> +
> +	/* Don't include the free space tree in the blocks to process. */
> +	if (!free_space_tree)
> +		blocks_nr--;
>
>   	if ((cfg->features & BTRFS_FEATURE_INCOMPAT_ZONED)) {
>   		system_group_offset =3D cfg->zone_size * BTRFS_NR_SB_LOG_ZONES;
> @@ -248,6 +304,11 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cf=
g)
>   	else
>   		btrfs_set_super_cache_generation(&super, -1);
>   	btrfs_set_super_incompat_flags(&super, cfg->features);
> +	if (free_space_tree) {
> +		u64 ro_flags =3D BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE |
> +			BTRFS_FEATURE_COMPAT_RO_FREE_SPACE_TREE_VALID;
> +		btrfs_set_super_compat_ro_flags(&super, ro_flags);
> +	}
>   	if (cfg->label)
>   		__strncpy_null(super.label, cfg->label, BTRFS_LABEL_SIZE - 1);
>
> @@ -513,6 +574,14 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cf=
g)
>   	if (ret)
>   		goto out;
>
> +	if (free_space_tree) {
> +		ret =3D create_free_space_tree(fd, cfg, buf, system_group_offset,
> +					     system_group_size,
> +					     system_group_offset + total_used);
> +		if (ret)
> +			goto out;
> +	}
> +
>   	/* and write out the super block */
>   	memset(buf->data, 0, BTRFS_SUPER_INFO_SIZE);
>   	memcpy(buf->data, &super, sizeof(super));
> diff --git a/mkfs/common.h b/mkfs/common.h
> index f2d28057..f31b4ae4 100644
> --- a/mkfs/common.h
> +++ b/mkfs/common.h
> @@ -51,6 +51,7 @@ enum btrfs_mkfs_block {
>   	MKFS_DEV_TREE,
>   	MKFS_FS_TREE,
>   	MKFS_CSUM_TREE,
> +	MKFS_FREE_SPACE_TREE,
>   	MKFS_BLOCK_COUNT
>   };
>
> @@ -61,6 +62,12 @@ static const enum btrfs_mkfs_block extent_tree_v1_blo=
cks[] =3D {
>   	MKFS_DEV_TREE,
>   	MKFS_FS_TREE,
>   	MKFS_CSUM_TREE,
> +
> +	/*
> +	 * Since the free space tree is optional with v1 it must always be las=
t
> +	 * in this array.
> +	 */
> +	MKFS_FREE_SPACE_TREE,
>   };
>
>   struct btrfs_mkfs_config {
> @@ -72,6 +79,8 @@ struct btrfs_mkfs_config {
>   	u32 stripesize;
>   	/* Bitfield of incompat features, BTRFS_FEATURE_INCOMPAT_* */
>   	u64 features;
> +	/* Bitfield of BTRFS_RUNTIME_FEATURE_* */
> +	u64 runtime_features;
>   	/* Size of the filesystem in bytes */
>   	u64 num_bytes;
>   	/* checksum algorithm to use */
> diff --git a/mkfs/main.c b/mkfs/main.c
> index ea53e9c7..edfded1f 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -137,7 +137,6 @@ static int create_metadata_block_groups(struct btrfs=
_root *root, int mixed,
>
>   	root->fs_info->system_allocs =3D 0;
>   	ret =3D btrfs_commit_transaction(trans, root);
> -
>   err:
>   	return ret;
>   }
> @@ -254,7 +253,9 @@ static int recow_roots(struct btrfs_trans_handle *tr=
ans,
>   	ret =3D __recow_root(trans, info->csum_root);
>   	if (ret)
>   		return ret;
> -
> +	ret =3D __recow_root(trans, info->free_space_root);
> +	if (ret)
> +		return ret;
>   	return 0;
>   }
>
> @@ -1366,6 +1367,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>   	mkfs_cfg.sectorsize =3D sectorsize;
>   	mkfs_cfg.stripesize =3D stripesize;
>   	mkfs_cfg.features =3D features;
> +	mkfs_cfg.runtime_features =3D runtime_features;
>   	mkfs_cfg.csum_type =3D csum_type;
>   	mkfs_cfg.zone_size =3D zone_size(file);
>
> @@ -1529,13 +1531,6 @@ raid_groups:
>   			goto out;
>   		}
>   	}
> -	if (runtime_features & BTRFS_RUNTIME_FEATURE_FREE_SPACE_TREE) {
> -		ret =3D btrfs_create_free_space_tree(fs_info);
> -		if (ret < 0) {
> -			error("failed to create free space tree: %d (%m)", ret);
> -			goto out;
> -		}
> -	}
>   	if (verbose) {
>   		char features_buf[64];
>
>
