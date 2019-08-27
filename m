Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFA3D9E85E
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 14:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbfH0Mvj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 08:51:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:37300 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbfH0Mvj (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 08:51:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 60834B61F
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 12:51:37 +0000 (UTC)
Subject: Re: [PATCH v2 03/11] btrfs-progs: add checksum type to checksumming
 functions
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190826114853.14860-1-jthumshirn@suse.de>
 <20190826114853.14860-4-jthumshirn@suse.de>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <371af60f-f90b-e57c-bed1-426754af7b6c@suse.com>
Date:   Tue, 27 Aug 2019 15:51:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826114853.14860-4-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 26.08.19 г. 14:48 ч., Johannes Thumshirn wrote:
> Add the checksum type to csum_tree_block_size(), __csum_tree_block_size()
> and verify_tree_block_csum_silent().
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

This just propagates args with no functional changes so:

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>  btrfs-corrupt-block.c       |  3 ++-
>  cmds/rescue-chunk-recover.c |  3 ++-
>  convert/common.c            |  3 ++-
>  convert/main.c              |  3 ++-
>  disk-io.c                   | 21 ++++++++++++---------
>  disk-io.h                   |  5 +++--
>  mkfs/common.c               | 21 ++++++++++++++-------
>  7 files changed, 37 insertions(+), 22 deletions(-)
> 
> diff --git a/btrfs-corrupt-block.c b/btrfs-corrupt-block.c
> index bbef0c02e5d1..1dde9594bdcc 100644
> --- a/btrfs-corrupt-block.c
> +++ b/btrfs-corrupt-block.c
> @@ -158,7 +158,8 @@ static void corrupt_keys(struct btrfs_trans_handle *trans,
>  	if (!trans) {
>  		u16 csum_size =
>  			btrfs_super_csum_size(fs_info->super_copy);
> -		csum_tree_block_size(eb, csum_size, 0);
> +		u16 csum_type = btrfs_super_csum_type(fs_info->super_copy);
> +		csum_tree_block_size(eb, csum_size, 0, csum_type);
>  		write_extent_to_disk(eb);
>  	}
>  }
> diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
> index 308731ea5ea6..1a368310d895 100644
> --- a/cmds/rescue-chunk-recover.c
> +++ b/cmds/rescue-chunk-recover.c
> @@ -768,7 +768,8 @@ static int scan_one_device(void *dev_scan_struct)
>  			continue;
>  		}
>  
> -		if (verify_tree_block_csum_silent(buf, rc->csum_size)) {
> +		if (verify_tree_block_csum_silent(buf, rc->csum_size,
> +						  rc->csum_type)) {
>  			bytenr += rc->sectorsize;
>  			continue;
>  		}
> diff --git a/convert/common.c b/convert/common.c
> index af4f8d372299..ba69e132677e 100644
> --- a/convert/common.c
> +++ b/convert/common.c
> @@ -222,7 +222,8 @@ static inline int write_temp_extent_buffer(int fd, struct extent_buffer *buf,
>  {
>  	int ret;
>  
> -	csum_tree_block_size(buf, btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32], 0);
> +	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
> +			     cfg->csum_type);
>  
>  	/* Temporary extent buffer is always mapped 1:1 on disk */
>  	ret = pwrite(fd, buf->data, buf->len, bytenr);
> diff --git a/convert/main.c b/convert/main.c
> index 9711874bd137..5e6b12431f59 100644
> --- a/convert/main.c
> +++ b/convert/main.c
> @@ -1058,7 +1058,8 @@ static int migrate_super_block(int fd, u64 old_bytenr)
>  	BUG_ON(btrfs_super_bytenr(super) != old_bytenr);
>  	btrfs_set_super_bytenr(super, BTRFS_SUPER_INFO_OFFSET);
>  
> -	csum_tree_block_size(buf, btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32], 0);
> +	csum_tree_block_size(buf, btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32], 0,
> +			     btrfs_super_csum_type(super));
>  	ret = pwrite(fd, buf->data, BTRFS_SUPER_INFO_SIZE,
>  		BTRFS_SUPER_INFO_OFFSET);
>  	if (ret != BTRFS_SUPER_INFO_SIZE)
> diff --git a/disk-io.c b/disk-io.c
> index be44eead5cef..9cb475bc6262 100644
> --- a/disk-io.c
> +++ b/disk-io.c
> @@ -149,7 +149,7 @@ void btrfs_csum_final(u32 crc, u8 *result)
>  }
>  
>  static int __csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
> -				  int verify, int silent)
> +				  int verify, int silent, u16 csum_type)
>  {
>  	u8 result[BTRFS_CSUM_SIZE];
>  	u32 len;
> @@ -174,24 +174,27 @@ static int __csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
>  	return 0;
>  }
>  
> -int csum_tree_block_size(struct extent_buffer *buf, u16 csum_size, int verify)
> +int csum_tree_block_size(struct extent_buffer *buf, u16 csum_size, int verify,
> +			 u16 csum_type)
>  {
> -	return __csum_tree_block_size(buf, csum_size, verify, 0);
> +	return __csum_tree_block_size(buf, csum_size, verify, 0, csum_type);
>  }
>  
> -int verify_tree_block_csum_silent(struct extent_buffer *buf, u16 csum_size)
> +int verify_tree_block_csum_silent(struct extent_buffer *buf, u16 csum_size,
> +				  u16 csum_type)
>  {
> -	return __csum_tree_block_size(buf, csum_size, 1, 1);
> +	return __csum_tree_block_size(buf, csum_size, 1, 1, csum_type);
>  }
>  
>  int csum_tree_block(struct btrfs_fs_info *fs_info,
>  		    struct extent_buffer *buf, int verify)
>  {
> -	u16 csum_size =
> -		btrfs_super_csum_size(fs_info->super_copy);
> +	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
> +	u16 csum_type = btrfs_super_csum_type(fs_info->super_copy);
> +
>  	if (verify && fs_info->suppress_check_block_errors)
> -		return verify_tree_block_csum_silent(buf, csum_size);
> -	return csum_tree_block_size(buf, csum_size, verify);
> +		return verify_tree_block_csum_silent(buf, csum_size, csum_type);
> +	return csum_tree_block_size(buf, csum_size, verify, csum_type);
>  }
>  
>  struct extent_buffer *btrfs_find_tree_block(struct btrfs_fs_info *fs_info,
> diff --git a/disk-io.h b/disk-io.h
> index 7b5c3806ba98..394997ad72cb 100644
> --- a/disk-io.h
> +++ b/disk-io.h
> @@ -191,8 +191,9 @@ void btrfs_csum_final(u32 crc, u8 *result);
>  
>  int btrfs_open_device(struct btrfs_device *dev);
>  int csum_tree_block_size(struct extent_buffer *buf, u16 csum_sectorsize,
> -			 int verify);
> -int verify_tree_block_csum_silent(struct extent_buffer *buf, u16 csum_size);
> +			 int verify, u16 csum_type);
> +int verify_tree_block_csum_silent(struct extent_buffer *buf, u16 csum_size,
> +				  u16 csum_type);
>  int btrfs_read_buffer(struct extent_buffer *buf, u64 parent_transid);
>  int write_tree_block(struct btrfs_trans_handle *trans,
>  		     struct btrfs_fs_info *fs_info,
> diff --git a/mkfs/common.c b/mkfs/common.c
> index b6e549b19272..9762391a8d2b 100644
> --- a/mkfs/common.c
> +++ b/mkfs/common.c
> @@ -101,7 +101,8 @@ static int btrfs_create_tree_root(int fd, struct btrfs_mkfs_config *cfg,
>  	}
>  
>  	/* generate checksum */
> -	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0);
> +	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
> +			     cfg->csum_type);
>  
>  	/* write back root tree */
>  	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_ROOT_TREE]);
> @@ -292,7 +293,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
>  	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_EXTENT_TREE]);
>  	btrfs_set_header_owner(buf, BTRFS_EXTENT_TREE_OBJECTID);
>  	btrfs_set_header_nritems(buf, nritems);
> -	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0);
> +	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
> +			     cfg->csum_type);
>  	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_EXTENT_TREE]);
>  	if (ret != cfg->nodesize) {
>  		ret = (ret < 0 ? -errno : -EIO);
> @@ -380,7 +382,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
>  	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_CHUNK_TREE]);
>  	btrfs_set_header_owner(buf, BTRFS_CHUNK_TREE_OBJECTID);
>  	btrfs_set_header_nritems(buf, nritems);
> -	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0);
> +	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
> +			     cfg->csum_type);
>  	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_CHUNK_TREE]);
>  	if (ret != cfg->nodesize) {
>  		ret = (ret < 0 ? -errno : -EIO);
> @@ -420,7 +423,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
>  	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_DEV_TREE]);
>  	btrfs_set_header_owner(buf, BTRFS_DEV_TREE_OBJECTID);
>  	btrfs_set_header_nritems(buf, nritems);
> -	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0);
> +	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
> +			     cfg->csum_type);
>  	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_DEV_TREE]);
>  	if (ret != cfg->nodesize) {
>  		ret = (ret < 0 ? -errno : -EIO);
> @@ -433,7 +437,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
>  	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_FS_TREE]);
>  	btrfs_set_header_owner(buf, BTRFS_FS_TREE_OBJECTID);
>  	btrfs_set_header_nritems(buf, 0);
> -	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0);
> +	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
> +			     cfg->csum_type);
>  	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_FS_TREE]);
>  	if (ret != cfg->nodesize) {
>  		ret = (ret < 0 ? -errno : -EIO);
> @@ -445,7 +450,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
>  	btrfs_set_header_bytenr(buf, cfg->blocks[MKFS_CSUM_TREE]);
>  	btrfs_set_header_owner(buf, BTRFS_CSUM_TREE_OBJECTID);
>  	btrfs_set_header_nritems(buf, 0);
> -	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0);
> +	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
> +			     cfg->csum_type);
>  	ret = pwrite(fd, buf->data, cfg->nodesize, cfg->blocks[MKFS_CSUM_TREE]);
>  	if (ret != cfg->nodesize) {
>  		ret = (ret < 0 ? -errno : -EIO);
> @@ -456,7 +462,8 @@ int make_btrfs(int fd, struct btrfs_mkfs_config *cfg)
>  	memset(buf->data, 0, BTRFS_SUPER_INFO_SIZE);
>  	memcpy(buf->data, &super, sizeof(super));
>  	buf->len = BTRFS_SUPER_INFO_SIZE;
> -	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0);
> +	csum_tree_block_size(buf, btrfs_csum_sizes[cfg->csum_type], 0,
> +			     cfg->csum_type);
>  	ret = pwrite(fd, buf->data, BTRFS_SUPER_INFO_SIZE,
>  			cfg->blocks[MKFS_SUPER_BLOCK]);
>  	if (ret != BTRFS_SUPER_INFO_SIZE) {
> 
