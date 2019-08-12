Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D547389BE6
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2019 12:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfHLKvE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Aug 2019 06:51:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:34660 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727847AbfHLKvE (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Aug 2019 06:51:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D608EAFE1
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Aug 2019 10:51:02 +0000 (UTC)
Subject: Re: [RFC PATCH 12/17] btrfs-progs: pass checksum type to
 btrfs_csum_data()
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <cover.1564046812.git.jthumshirn@suse.de>
 <cover.1564046812.git.jthumshirn@suse.de>
 <e1ca8b3c89c7a07143928ba29a5eb7494fc60b53.1564046972.git.jthumshirn@suse.de>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <25578854-fd24-8427-f89d-761e972762a5@suse.com>
Date:   Mon, 12 Aug 2019 13:51:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e1ca8b3c89c7a07143928ba29a5eb7494fc60b53.1564046972.git.jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 25.07.19 г. 12:33 ч., Johannes Thumshirn wrote:

So patches 12/13 have identical titles, different contents and
absolutely no commit messages :( . How about no... Squash 13 into 12 and
put a commit explaining your change. And by the way the patch's title
doesn't correspond to the content of the patches - you also change
btrfs_checksum_final to take a csum_type


Something as straightforward as the below example should suffice:

"In preparation to supporting new checksum algorithm pass the checksum
type to btrfs_csum_data/btrfs_csum_final, this allows us to encapsulate
any differences in processing into the respective functions".

> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  check/main.c                |  6 ++++--
>  cmds/inspect-dump-super.c   |  8 ++++----
>  cmds/rescue-chunk-recover.c | 10 ++++++----
>  convert/common.c            |  5 +++--
>  disk-io.c                   | 39 +++++++++++++++++++++++++++------------
>  disk-io.h                   |  4 ++--
>  file-item.c                 |  7 +++++--
>  free-space-cache.c          |  2 +-
>  image/main.c                |  2 +-
>  9 files changed, 53 insertions(+), 30 deletions(-)
> 
> diff --git a/check/main.c b/check/main.c
> index 92a7e40c1ebf..eabe328b6800 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -5581,6 +5581,7 @@ static int check_extent_csums(struct btrfs_root *root, u64 bytenr,
>  	struct btrfs_fs_info *fs_info = root->fs_info;
>  	u64 offset = 0;
>  	u16 csum_size = btrfs_super_csum_size(fs_info->super_copy);
> +	u16 csum_type = btrfs_super_csum_type(fs_info->super_copy);
>  	char *data;
>  	unsigned long csum_offset;
>  	u32 csum;
> @@ -5621,9 +5622,10 @@ static int check_extent_csums(struct btrfs_root *root, u64 bytenr,
>  				csum = ~(u32)0;
>  				tmp = offset + data_checked;
>  
> -				csum = btrfs_csum_data((char *)data + tmp,
> +				csum = btrfs_csum_data(csum_type,
> +						       (char *)data + tmp,
>  						(u8 *)&csum, fs_info->sectorsize);
> -				btrfs_csum_final(csum, (u8 *)&csum);
> +				btrfs_csum_final(csum_type, csum, (u8 *)&csum);
>  
>  				csum_offset = leaf_offset +
>  					 tmp / fs_info->sectorsize * csum_size;
> diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
> index 96ad3deca3d8..40019a6670ef 100644
> --- a/cmds/inspect-dump-super.c
> +++ b/cmds/inspect-dump-super.c
> @@ -35,15 +35,15 @@
>  #include "kernel-lib/crc32c.h"
>  #include "common/help.h"
>  
> -static int check_csum_sblock(void *sb, int csum_size)
> +static int check_csum_sblock(void *sb, int csum_size, u16 csum_type)
>  {
>  	u8 result[BTRFS_CSUM_SIZE];
>  	u32 crc = ~(u32)0;
>  
> -	crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE,
> +	crc = btrfs_csum_data(csum_type, (char *)sb + BTRFS_CSUM_SIZE,
>  				(u8 *)&crc,
>  				BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
> -	btrfs_csum_final(crc, result);
> +	btrfs_csum_final(csum_type, crc, result);
>  
>  	return !memcmp(sb, &result, csum_size);
>  }
> @@ -348,7 +348,7 @@ static void dump_superblock(struct btrfs_super_block *sb, int full)
>  	if (csum_type != BTRFS_CSUM_TYPE_CRC32 ||
>  	    csum_size != btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32])
>  		printf(" [UNKNOWN CSUM TYPE OR SIZE]");
> -	else if (check_csum_sblock(sb, csum_size))
> +	else if (check_csum_sblock(sb, csum_size, csum_type))
>  		printf(" [match]");
>  	else
>  		printf(" [DON'T MATCH]");
> diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
> index 0fddb5dd8ead..cddae471f50c 100644
> --- a/cmds/rescue-chunk-recover.c
> +++ b/cmds/rescue-chunk-recover.c
> @@ -1887,7 +1887,8 @@ static u64 calc_data_offset(struct btrfs_key *key,
>  	return dev_offset + data_offset;
>  }
>  
> -static int check_one_csum(int fd, u64 start, u32 len, u32 tree_csum)
> +static int check_one_csum(int fd, u64 start, u32 len, u32 tree_csum,
> +			  u16 csum_type)
>  {
>  	char *data;
>  	int ret = 0;
> @@ -1902,8 +1903,8 @@ static int check_one_csum(int fd, u64 start, u32 len, u32 tree_csum)
>  		goto out;
>  	}
>  	ret = 0;
> -	csum_result = btrfs_csum_data(data, (u8 *)&csum_result, len);
> -	btrfs_csum_final(csum_result, (u8 *)&csum_result);
> +	csum_result = btrfs_csum_data(csum_type, data, (u8 *)&csum_result, len);
> +	btrfs_csum_final(csum_type, csum_result, (u8 *)&csum_result);
>  	if (csum_result != tree_csum)
>  		ret = 1;
>  out:
> @@ -2102,7 +2103,8 @@ next_csum:
>  						  devext->objectid, 1));
>  
>  		ret = check_one_csum(dev->fd, data_offset, blocksize,
> -				     tree_csum);
> +				     tree_csum,
> +				     btrfs_super_csum_type(root->fs_info->super_copy));
>  		if (ret < 0)
>  			goto fail_out;
>  		else if (ret > 0)
> diff --git a/convert/common.c b/convert/common.c
> index ab8e6b9f4749..894a6ee0ba90 100644
> --- a/convert/common.c
> +++ b/convert/common.c
> @@ -63,12 +63,13 @@ static inline int write_temp_super(int fd, struct btrfs_super_block *sb,
>                                    u64 sb_bytenr)
>  {
>         u32 crc = ~(u32)0;
> +       u16 csum_type = btrfs_super_csum_type(sb);
>         int ret;
>  
> -       crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE,
> +       crc = btrfs_csum_data(csum_type, (char *)sb + BTRFS_CSUM_SIZE,
>  			     (u8 *)&crc,
>                               BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
> -       btrfs_csum_final(crc, &sb->csum[0]);
> +       btrfs_csum_final(csum_type, crc, &sb->csum[0]);
>         ret = pwrite(fd, sb, BTRFS_SUPER_INFO_SIZE, sb_bytenr);
>         if (ret < BTRFS_SUPER_INFO_SIZE)
>                 ret = (ret < 0 ? -errno : -EIO);
> diff --git a/disk-io.c b/disk-io.c
> index a0c37c569d58..7e538969c57a 100644
> --- a/disk-io.c
> +++ b/disk-io.c
> @@ -138,14 +138,26 @@ static void print_tree_block_error(struct btrfs_fs_info *fs_info,
>  	}
>  }
>  
> -u32 btrfs_csum_data(char *data, u8 *seed, size_t len)
> +u32 btrfs_csum_data(u16 csum_type, char *data, u8 *seed, size_t len)
>  {
> -	return crc32c(*(u32*)seed, data, len);
> +	switch (csum_type) {
> +	case BTRFS_CSUM_TYPE_CRC32:
> +		return crc32c(*(u32*)seed, data, len);
> +	default: /* Not reached */
> +		return ~(u32)0;
> +	}
> +
>  }
>  
> -void btrfs_csum_final(u32 crc, u8 *result)
> +void btrfs_csum_final(u16 csum_type, u32 crc, u8 *result)
>  {
> -	put_unaligned_le32(~crc, result);
> +	switch (csum_type) {
> +	case BTRFS_CSUM_TYPE_CRC32:
> +		put_unaligned_le32(~crc, result);
> +		break;
> +	default: /* Not reached */
> +		break;
> +	}
>  }
>  
>  static int __csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
> @@ -156,8 +168,9 @@ static int __csum_tree_block_size(struct extent_buffer *buf, u16 csum_size,
>  	u32 crc = ~(u32)0;
>  
>  	len = buf->len - BTRFS_CSUM_SIZE;
> -	crc = btrfs_csum_data(buf->data + BTRFS_CSUM_SIZE, (u8 *)&crc, len);
> -	btrfs_csum_final(crc, result);
> +	crc = btrfs_csum_data(csum_type, buf->data + BTRFS_CSUM_SIZE,
> +			      (u8 *)&crc, len);
> +	btrfs_csum_final(csum_type, crc, result);
>  
>  	if (verify) {
>  		if (memcmp_extent_buffer(buf, result, 0, csum_size)) {
> @@ -1376,9 +1389,10 @@ int btrfs_check_super(struct btrfs_super_block *sb, unsigned sbflags)
>  	csum_size = btrfs_csum_sizes[csum_type];
>  
>  	crc = ~(u32)0;
> -	crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE, (u8 *)&crc,
> +	crc = btrfs_csum_data(csum_type,(char *)sb + BTRFS_CSUM_SIZE,
> +			      (u8 *)&crc,
>  			      BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
> -	btrfs_csum_final(crc, result);
> +	btrfs_csum_final(csum_type, crc, result);
>  
>  	if (memcmp(result, sb->csum, csum_size)) {
>  		error("superblock checksum mismatch");
> @@ -1616,6 +1630,7 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
>  	u64 bytenr;
>  	u32 crc;
>  	int i, ret;
> +	u16 csum_type = btrfs_super_csum_type(sb);
>  
>  	/*
>  	 * We need to write super block after all metadata written.
> @@ -1631,9 +1646,9 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
>  	if (fs_info->super_bytenr != BTRFS_SUPER_INFO_OFFSET) {
>  		btrfs_set_super_bytenr(sb, fs_info->super_bytenr);
>  		crc = ~(u32)0;
> -		crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE, (u8 *)&crc,
> +		crc = btrfs_csum_data(csum_type, (char *)sb + BTRFS_CSUM_SIZE, (u8 *)&crc,
>  				      BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
> -		btrfs_csum_final(crc, &sb->csum[0]);
> +		btrfs_csum_final(csum_type, crc, &sb->csum[0]);
>  
>  		/*
>  		 * super_copy is BTRFS_SUPER_INFO_SIZE bytes and is
> @@ -1667,9 +1682,9 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
>  		btrfs_set_super_bytenr(sb, bytenr);
>  
>  		crc = ~(u32)0;
> -		crc = btrfs_csum_data((char *)sb + BTRFS_CSUM_SIZE, (u8 *)&crc,
> +		crc = btrfs_csum_data(csum_type, (char *)sb + BTRFS_CSUM_SIZE, (u8 *)&crc,
>  				      BTRFS_SUPER_INFO_SIZE - BTRFS_CSUM_SIZE);
> -		btrfs_csum_final(crc, &sb->csum[0]);
> +		btrfs_csum_final(csum_type, crc, &sb->csum[0]);
>  
>  		/*
>  		 * super_copy is BTRFS_SUPER_INFO_SIZE bytes and is
> diff --git a/disk-io.h b/disk-io.h
> index 92c87f28f8b2..4b5e9ea86385 100644
> --- a/disk-io.h
> +++ b/disk-io.h
> @@ -186,8 +186,8 @@ int btrfs_free_fs_root(struct btrfs_root *root);
>  void btrfs_mark_buffer_dirty(struct extent_buffer *buf);
>  int btrfs_buffer_uptodate(struct extent_buffer *buf, u64 parent_transid);
>  int btrfs_set_buffer_uptodate(struct extent_buffer *buf);
> -u32 btrfs_csum_data(char *data, u8 *seed, size_t len);
> -void btrfs_csum_final(u32 crc, u8 *result);
> +u32 btrfs_csum_data(u16 csum_type, char *data, u8 *seed, size_t len);
> +void btrfs_csum_final(u16 csum_type, u32 crc, u8 *result);
>  
>  int btrfs_open_device(struct btrfs_device *dev);
>  int csum_tree_block_size(struct extent_buffer *buf, u16 csum_sectorsize,
> diff --git a/file-item.c b/file-item.c
> index 5f6548e9a74f..78fdcecd0bab 100644
> --- a/file-item.c
> +++ b/file-item.c
> @@ -202,6 +202,9 @@ int btrfs_csum_file_block(struct btrfs_trans_handle *trans,
>  	u16 csum_size =
>  		btrfs_super_csum_size(root->fs_info->super_copy);
>  
> +	u16 csum_type =
> +		btrfs_super_csum_type(root->fs_info->super_copy);
> +
>  	path = btrfs_alloc_path();
>  	if (!path)
>  		return -ENOMEM;
> @@ -312,8 +315,8 @@ csum:
>  	item = (struct btrfs_csum_item *)((unsigned char *)item +
>  					  csum_offset * csum_size);
>  found:
> -	csum_result = btrfs_csum_data(data, (u8 *)&csum_result, len);
> -	btrfs_csum_final(csum_result, (u8 *)&csum_result);
> +	csum_result = btrfs_csum_data(csum_type, data, (u8 *)&csum_result, len);
> +	btrfs_csum_final(csum_type, csum_result, (u8 *)&csum_result);
>  	if (csum_result == 0) {
>  		printk("csum result is 0 for block %llu\n",
>  		       (unsigned long long)bytenr);
> diff --git a/free-space-cache.c b/free-space-cache.c
> index e872eb6a00db..8a57f86dc650 100644
> --- a/free-space-cache.c
> +++ b/free-space-cache.c
> @@ -213,7 +213,7 @@ static int io_ctl_check_crc(struct io_ctl *io_ctl, int index)
>  	io_ctl_map_page(io_ctl, 0);
>  	crc = crc32c(crc, io_ctl->orig + offset,
>  			io_ctl->root->fs_info->sectorsize - offset);
> -	btrfs_csum_final(crc, (u8 *)&crc);
> +	put_unaligned_le32(~crc, (u8 *)&crc);
>  	if (val != crc) {
>  		printk("btrfs: csum mismatch on free space cache\n");
>  		io_ctl_unmap_page(io_ctl);
> diff --git a/image/main.c b/image/main.c
> index 28ef1609b5ff..0c8ffede56f5 100644
> --- a/image/main.c
> +++ b/image/main.c
> @@ -124,7 +124,7 @@ static void csum_block(u8 *buf, size_t len)
>  	u8 result[btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32]];
>  	u32 crc = ~(u32)0;
>  	crc = crc32c(crc, buf + BTRFS_CSUM_SIZE, len - BTRFS_CSUM_SIZE);
> -	btrfs_csum_final(crc, result);
> +	put_unaligned_le32(~crc, result);
>  	memcpy(buf, result, btrfs_csum_sizes[BTRFS_CSUM_TYPE_CRC32]);
>  }
>  
> 
