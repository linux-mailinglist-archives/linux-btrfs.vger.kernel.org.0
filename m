Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F9C3A9327
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Jun 2021 08:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbhFPGxf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Jun 2021 02:53:35 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58966 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbhFPGxe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Jun 2021 02:53:34 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DA2E5219C5;
        Wed, 16 Jun 2021 06:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623826287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x5CFTSiI/9tBv1dqqwLCB87cJcpzOBdPJAuXjfCOyXQ=;
        b=fjMl/XQLZofO6p3XVTz4b9YdzMfzTWQyM4zELCizP1VlUk1CcT+hSf2yMYqI1GQBCvmdp+
        lRGLxek6AY6ag3KhuTsfSfbkg7klOFCsE5a/AflIuGc8ZdHAh/0lC5BVge8M6tqcPwKRV5
        90yM8cEXbaF4T8Y4lGQr/3DdN6+B8Zk=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 9CAE4118DD;
        Wed, 16 Jun 2021 06:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623826287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x5CFTSiI/9tBv1dqqwLCB87cJcpzOBdPJAuXjfCOyXQ=;
        b=fjMl/XQLZofO6p3XVTz4b9YdzMfzTWQyM4zELCizP1VlUk1CcT+hSf2yMYqI1GQBCvmdp+
        lRGLxek6AY6ag3KhuTsfSfbkg7klOFCsE5a/AflIuGc8ZdHAh/0lC5BVge8M6tqcPwKRV5
        90yM8cEXbaF4T8Y4lGQr/3DdN6+B8Zk=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id nY1RI2+fyWBGUQAALh3uQQ
        (envelope-from <nborisov@suse.com>); Wed, 16 Jun 2021 06:51:27 +0000
Subject: Re: [RFC PATCH 08/31] btrfs: btrfs_em_to_iomap () to convert em to
 iomap
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <cover.1623567940.git.rgoldwyn@suse.com>
 <87e85bcd1f50533b3a18c09cff5bd88cc3c6f923.1623567940.git.rgoldwyn@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <1096d7a1-4b7e-58f4-19b3-064034bff7e9@suse.com>
Date:   Wed, 16 Jun 2021 09:51:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87e85bcd1f50533b3a18c09cff5bd88cc3c6f923.1623567940.git.rgoldwyn@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 13.06.21 г. 16:39, Goldwyn Rodrigues wrote:
> From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> btrfs_em_to_iomap() converts and extent map into passed argument struct
> iomap. It makes sure the information is set close to sectorsize block.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> ---
>  fs/btrfs/ctree.h |  2 ++
>  fs/btrfs/file.c  | 22 ++++++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index c9256f862085..d4567c7a93cb 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -3267,6 +3267,8 @@ int btrfs_fdatawrite_range(struct inode *inode, loff_t start, loff_t end);
>  int btrfs_check_nocow_lock(struct btrfs_inode *inode, loff_t pos,
>  			   size_t *write_bytes);
>  void btrfs_check_nocow_unlock(struct btrfs_inode *inode);
> +void btrfs_em_to_iomap(struct inode *inode, struct extent_map *em,
> +		struct iomap *iomap, loff_t pos);
>  
>  /* tree-defrag.c */
>  int btrfs_defrag_leaves(struct btrfs_trans_handle *trans,
> diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
> index e7d33c8177a0..cb9471e7224a 100644
> --- a/fs/btrfs/file.c
> +++ b/fs/btrfs/file.c
> @@ -1570,6 +1570,28 @@ static int btrfs_write_check(struct kiocb *iocb, struct iov_iter *from,
>  	return 0;
>  }
>  
> +void btrfs_em_to_iomap(struct inode *inode,
> +		struct extent_map *em, struct iomap *iomap,
> +		loff_t sector_pos)
> +{
> +	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> +	loff_t diff = sector_pos - em->start;
> +
> +	if (em->block_start == EXTENT_MAP_HOLE) {
> +		iomap->addr = IOMAP_NULL_ADDR;
> +		iomap->type = IOMAP_HOLE;
> +	} else if (em->block_start == EXTENT_MAP_INLINE) {
> +		iomap->addr = IOMAP_NULL_ADDR;
> +		iomap->type = IOMAP_INLINE;
> +	} else {
> +		iomap->addr = em->block_start + diff;
> +		iomap->type = IOMAP_MAPPED;
> +	}
> +	iomap->offset = em->start + diff;

This is really iomap->offset = sector_pos i.e no need to perform the
addition.

> +	iomap->bdev = fs_info->fs_devices->latest_bdev;
> +	iomap->length = em->len - diff;
> +}
> +
>  static noinline ssize_t btrfs_buffered_write(struct kiocb *iocb,
>  					       struct iov_iter *i)
>  {
> 
