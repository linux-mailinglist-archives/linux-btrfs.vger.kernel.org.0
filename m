Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE0379E863
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2019 14:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbfH0MwP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 27 Aug 2019 08:52:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:37582 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726278AbfH0MwO (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 27 Aug 2019 08:52:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EA628B03C
        for <linux-btrfs@vger.kernel.org>; Tue, 27 Aug 2019 12:52:12 +0000 (UTC)
Subject: Re: [PATCH v2 04/11] btrfs-progs: don't assume checksums are always 4
 bytes
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190826114853.14860-1-jthumshirn@suse.de>
 <20190826114853.14860-5-jthumshirn@suse.de>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <57508091-accc-f726-f298-0f25b9759eb8@suse.com>
Date:   Tue, 27 Aug 2019 15:52:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190826114853.14860-5-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 26.08.19 г. 14:48 ч., Johannes Thumshirn wrote:
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>  btrfs-sb-mod.c              |  9 ++++++---
>  check/main.c                |  2 +-
>  cmds/inspect-dump-super.c   |  3 ++-
>  cmds/rescue-chunk-recover.c |  2 +-
>  convert/common.c            |  3 ++-
>  disk-io.c                   | 12 ++++++------
>  disk-io.h                   |  2 +-
>  file-item.c                 |  2 +-
>  8 files changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/btrfs-sb-mod.c b/btrfs-sb-mod.c
> index 16a26f772494..932c2a0432ef 100644
> --- a/btrfs-sb-mod.c
> +++ b/btrfs-sb-mod.c
> @@ -37,7 +37,8 @@ static int check_csum_superblock(void *sb)
>  	u32 crc = ~(u32)0;
>  
>  	crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE,
> -				crc, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
> +				(u8 *)&crc,
> +				BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
>  	btrfs_csum_final(crc, result);
>  
>  	return !memcmp(sb, &result, csum_size);
> @@ -50,10 +51,12 @@ static void update_block_csum(void *block, int is_sb)
>  	u32 crc = ~(u32)0;
>  
>  	if (is_sb) {
> -		crc = btrfs_csum_data((char *)block + BTRFS_CSUM_SIZE, crc,
> +		crc = btrfs_csum_data((char *)block + BTRFS_CSUM_SIZE,
> +				      (u8 *)&crc,
>  				BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
>  	} else {
> -		crc = btrfs_csum_data((char *)block + BTRFS_CSUM_SIZE, crc,
> +		crc = btrfs_csum_data((char *)block + BTRFS_CSUM_SIZE,
> +				      (u8 *)&crc,
>  				BLOCKSIZE - BTRFS_CSUM_SIZE);
>  	}
>  	btrfs_csum_final(crc, result);
> diff --git a/check/main.c b/check/main.c
> index 8b340e5e7894..50498ad86dca 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -5622,7 +5622,7 @@ static int check_extent_csums(struct btrfs_root *root, u64 bytenr,
>  				tmp = offset + data_checked;
>  
>  				csum = btrfs_csum_data((char *)data + tmp,
> -						csum, fs_info->sectorsize);
> +						(u8 *)&csum, fs_info->sectorsize);
>  				btrfs_csum_final(csum, (u8 *)&csum);
>  
>  				csum_offset = leaf_offset +
> diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
> index 65fb3506eac6..96ad3deca3d8 100644
> --- a/cmds/inspect-dump-super.c
> +++ b/cmds/inspect-dump-super.c
> @@ -41,7 +41,8 @@ static int check_csum_sblock(void *sb, int csum_size)
>  	u32 crc = ~(u32)0;
>  
>  	crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE,
> -				crc, BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
> +				(u8 *)&crc,
> +				BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
>  	btrfs_csum_final(crc, result);
>  
>  	return !memcmp(sb, &result, csum_size);
> diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
> index 1a368310d895..0fddb5dd8ead 100644
> --- a/cmds/rescue-chunk-recover.c
> +++ b/cmds/rescue-chunk-recover.c
> @@ -1902,7 +1902,7 @@ static int check_one_csum(int fd, u64 start, u32 len, u32 tree_csum)
>  		goto out;
>  	}
>  	ret = 0;
> -	csum_result = btrfs_csum_data(data, csum_result, len);
> +	csum_result = btrfs_csum_data(data, (u8 *)&csum_result, len);
>  	btrfs_csum_final(csum_result, (u8 *)&csum_result);
>  	if (csum_result != tree_csum)
>  		ret = 1;
> diff --git a/convert/common.c b/convert/common.c
> index ba69e132677e..c3702dc403ed 100644
> --- a/convert/common.c
> +++ b/convert/common.c
> @@ -65,7 +65,8 @@ static inline int write_temp_super(int fd, struct btrfs_super_block *sb,
>         u32 crc = ~(u32)0;
>         int ret;
>  
> -       crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE, crc,
> +       crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE,
> +			     (u8 *)&crc,
>                               BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
>         btrfs_csum_final(crc, &sb->csum[0]);
>         ret = pwrite(fd, sb, BTRFS_SUPER_INFO_SIZE, sb_bytenr);
> diff --git a/disk-io.c b/disk-io.c
> index 9cb475bc6262..a0c37c569d58 100644
> --- a/disk-io.c
> +++ b/disk-io.c
> @@ -138,9 +138,9 @@ static void print_tree_block_error(struct btrfs_fs_info *fs_info,
>  	}
>  }
>  
> -u32 btrfs_csum_data(char *data, u32 seed, size_t len)
> +u32 btrfs_csum_data(char *data, u8 *seed, size_t len)
>  {
> -	return crc32c(seed, data, len);
> +	return crc32c(*(u32*)seed, data, len);
>  }
>  
>  void btrfs_csum_final(u32 crc, u8 *result)
> @@ -156,7 +156,7 @@ static int __csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
>  	u32 crc = ~(u32)0;
>  
>  	len = buf->len - BTRFS_CSUM_SIZE;
> -	crc = crc32c(crc, buf->data + BTRFS_CSUM_SIZE, len);
> +	crc = btrfs_csum_data(buf->data + BTRFS_CSUM_SIZE, (u8 *)&crc, len);
>  	btrfs_csum_final(crc, result);
>  
>  	if (verify) {
> @@ -1376,7 +1376,7 @@ int btrfs_check_super(struct btrfs_super_block *sb, unsigned sbflags)
>  	csum_size = btrfs_csum_sizes[csum_type];
>  
>  	crc = ~(u32)0;
> -	crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE, crc,
> +	crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE, (u8 *)&crc,
>  			      BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
>  	btrfs_csum_final(crc, result);
>  
> @@ -1631,7 +1631,7 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
>  	if (fs_info->super_bytenr != BTRFS_SUPER_INFO_OFFSET) {
>  		btrfs_set_super_bytenr(sb, fs_info->super_bytenr);
>  		crc = ~(u32)0;
> -		crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE, crc,
> +		crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE, (u8 *)&crc,
>  				      BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
>  		btrfs_csum_final(crc, &sb->csum[0]);
>  
> @@ -1667,7 +1667,7 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
>  		btrfs_set_super_bytenr(sb, bytenr);
>  
>  		crc = ~(u32)0;
> -		crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE, crc,
> +		crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE, (u8 *)&crc,
>  				      BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
>  		btrfs_csum_final(crc, &sb->csum[0]);
>  
> diff --git a/disk-io.h b/disk-io.h
> index 394997ad72cb..92c87f28f8b2 100644
> --- a/disk-io.h
> +++ b/disk-io.h
> @@ -186,7 +186,7 @@ int btrfs_free_fs_root(struct btrfs_root *root);
>  void btrfs_mark_buffer_dirty(struct extent_buffer *buf);
>  int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid);
>  int btrfs_set_buffer_uptodate(struct extent_buffer *buf);
> -u32 btrfs_csum_data(char *data, u32 seed, size_t len);
> +u32 btrfs_csum_data(char *data, u8 *seed, size_t len);
>  void btrfs_csum_final(u32 crc, u8 *result);
>  
>  int btrfs_open_device(struct btrfs_device *dev);
> diff --git a/file-item.c b/file-item.c
> index 3bf48c68913d..5f6548e9a74f 100644
> --- a/file-item.c
> +++ b/file-item.c
> @@ -312,7 +312,7 @@ csum:
>  	item = (struct btrfs_csum_item *)((unsigned char *)item +
>  					  csum_offset * csum_size);
>  found:
> -	csum_result = btrfs_csum_data(data, csum_result, len);
> +	csum_result = btrfs_csum_data(data, (u8 *)&csum_result, len);
>  	btrfs_csum_final(csum_result, (u8 *)&csum_result);
>  	if (csum_result == 0) {
>  		printk("csum result is 0 for block %llu\n",
> 
