Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 861911A121
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 May 2019 18:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfEJQQp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 May 2019 12:16:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:47324 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727271AbfEJQQp (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 May 2019 12:16:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1A25FAC11
        for <linux-btrfs@vger.kernel.org>; Fri, 10 May 2019 16:16:44 +0000 (UTC)
Subject: Re: [PATCH 02/17] btrfs: resurrect btrfs_crc32c()
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
Cc:     Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
References: <20190510111547.15310-1-jthumshirn@suse.de>
 <20190510111547.15310-3-jthumshirn@suse.de>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2d455d14-7b18-e96e-7978-05725efb84bb@suse.com>
Date:   Fri, 10 May 2019 19:16:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190510111547.15310-3-jthumshirn@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 10.05.19 г. 14:15 ч., Johannes Thumshirn wrote:
> Commit 9678c54388b6 ("btrfs: Remove custom crc32c init code") removed the
> btrfs_crc32c() function, because it was a duplicate of the crc32c() library
> function we already have in the kernel.
> 
> Resurrect it as a shim wrapper over crc32c() to make following
> transformations of the checksumming code in btrfs easier.
> 
> Also provide a btrfs_crc32_final() to ease following transformations.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>

Mechanical patch so :

Reviewed-by: Nikolay Borisov <nborisov@suse.com>

> ---
>  fs/btrfs/ctree.h       | 12 ++++++++++++
>  fs/btrfs/extent-tree.c |  6 +++---
>  fs/btrfs/send.c        |  2 +-
>  3 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index b81c331b28fa..d85541f13f65 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -19,6 +19,7 @@
>  #include <linux/kobject.h>
>  #include <trace/events/btrfs.h>
>  #include <asm/kmap_types.h>
> +#include <asm/unaligned.h>
>  #include <linux/pagemap.h>
>  #include <linux/btrfs.h>
>  #include <linux/btrfs_tree.h>
> @@ -2642,6 +2643,17 @@ BTRFS_SETGET_STACK_FUNCS(stack_dev_replace_cursor_right,
>  	((unsigned long)(BTRFS_LEAF_DATA_OFFSET + \
>  	btrfs_item_offset_nr(leaf, slot)))
>  
> +
> +static inline u32 btrfs_crc32c(u32 crc, const void *address, unsigned length)
> +{
> +	return crc32c(crc, address, length);
> +}
> +
> +static inline void btrfs_crc32c_final(u32 crc, u8 *result)
> +{
> +	put_unaligned_le32(~crc, result);
> +}
> +
>  static inline u64 btrfs_name_hash(const char *name, int len)
>  {
>         return crc32c((u32)~1, name, len);
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index f79e477a378e..06a30f2cd2e0 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -1119,11 +1119,11 @@ static u64 hash_extent_data_ref(u64 root_objectid, u64 owner, u64 offset)
>  	__le64 lenum;
>  
>  	lenum = cpu_to_le64(root_objectid);
> -	high_crc = crc32c(high_crc, &lenum, sizeof(lenum));
> +	high_crc = btrfs_crc32c(high_crc, &lenum, sizeof(lenum));
>  	lenum = cpu_to_le64(owner);
> -	low_crc = crc32c(low_crc, &lenum, sizeof(lenum));
> +	low_crc = btrfs_crc32c(low_crc, &lenum, sizeof(lenum));
>  	lenum = cpu_to_le64(offset);
> -	low_crc = crc32c(low_crc, &lenum, sizeof(lenum));
> +	low_crc = btrfs_crc32c(low_crc, &lenum, sizeof(lenum));
>  
>  	return ((u64)high_crc << 31) ^ (u64)low_crc;
>  }
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index dd38dfe174df..c029ca6d5eba 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -686,7 +686,7 @@ static int send_cmd(struct send_ctx *sctx)
>  	hdr->len = cpu_to_le32(sctx->send_size - sizeof(*hdr));
>  	hdr->crc = 0;
>  
> -	crc = crc32c(0, (unsigned char *)sctx->send_buf, sctx->send_size);
> +	crc = btrfs_crc32c(0, (unsigned char *)sctx->send_buf, sctx->send_size);
>  	hdr->crc = cpu_to_le32(crc);
>  
>  	ret = write_buf(sctx->send_filp, sctx->send_buf, sctx->send_size,
> 
