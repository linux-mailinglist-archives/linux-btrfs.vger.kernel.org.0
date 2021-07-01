Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F32C3B9860
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jul 2021 23:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbhGAV6T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jul 2021 17:58:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhGAV6S (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Jul 2021 17:58:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 803FA61410;
        Thu,  1 Jul 2021 21:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625176547;
        bh=J2pnPixnxsQv3DGjaK8vxbyjUZeAoadH4MR1n52LoKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mW7XU+BMNMVA0CQP9AZ7DdFKUdRmW1U+KWD56eN4cRCxe3KNhpUIbSjTEgbXnZaGn
         m2kNCxmoPpRu6jTkd9as2AU0/Xou8jJfZVqeVcN6F/URSYjJwfDT2YP65aTH2bd4l2
         eQo2O+ZQpwbBbP8ij/dsd1Pc9GLZTlEzvtDI+O7gLCm4wYJMuVSFaF+UKX/hpuhUSi
         usC5J9qBN7dDyoZ4/xBVCurFDRSA5jGkA/fopRawEE0qx7wIDHHBU8hM5sFJ4Oc1HM
         HhfVpop1bVixo0hDV2kNPlr5uhz2yKUfBY76UE+nnX9rmPA5oCqvYLR3LkYP3DifN3
         FfgbxYWHxRH0A==
Date:   Thu, 1 Jul 2021 16:57:40 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add special case to setget helpers for 64k pages
Message-ID: <20210701215740.GA12099@embeddedor>
References: <20210701160039.12518-1-dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210701160039.12518-1-dsterba@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 01, 2021 at 06:00:39PM +0200, David Sterba wrote:
> On 64K pages the size of the extent_buffer::pages array is 1 and
> compilation with -Warray-bounds warns due to
> 
>   kaddr = page_address(eb->pages[idx + 1]);
> 
> when reading byte range crossing page boundary.
> 
> This does never actually overflow the array because on 64K because all
> the data fit in one page and bounds are checked by check_setget_bounds.
> 
> To fix the reported overflow and warning add a copy of the non-crossing
> read/write code and put it behind a condition that's evaluated at
> compile time. That way only one implementation remains due to dead code
> elimination.

Any chance we can use a flexible-array in struct extent_buffer instead,
so all the warnings are removed?

Something like this:

diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 62027f551b44..b82e8b694a3b 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -94,11 +94,11 @@ struct extent_buffer {

        struct rw_semaphore lock;

-       struct page *pages[INLINE_EXTENT_BUFFER_PAGES];
        struct list_head release_list;
 #ifdef CONFIG_BTRFS_DEBUG
        struct list_head leak_list;
 #endif
+       struct page *pages[];
 };

 /*

which is actually what is needed in this case to silence the
array-bounds warnings: the replacement of the one-element array
with a flexible-array member[1] in struct extent_buffer.

--
Gustavo

[1] https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays

> 
> Link: https://lore.kernel.org/lkml/20210623083901.1d49d19d@canb.auug.org.au/
> CC: Gustavo A. R. Silva <gustavoars@kernel.org>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/struct-funcs.c | 66 +++++++++++++++++++++++++----------------
>  1 file changed, 41 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/btrfs/struct-funcs.c b/fs/btrfs/struct-funcs.c
> index 8260f8bb3ff0..51204b280da8 100644
> --- a/fs/btrfs/struct-funcs.c
> +++ b/fs/btrfs/struct-funcs.c
> @@ -73,14 +73,18 @@ u##bits btrfs_get_token_##bits(struct btrfs_map_token *token,		\
>  	}								\
>  	token->kaddr = page_address(token->eb->pages[idx]);		\
>  	token->offset = idx << PAGE_SHIFT;				\
> -	if (oip + size <= PAGE_SIZE)					\
> +	if (INLINE_EXTENT_BUFFER_PAGES == 1) {				\
>  		return get_unaligned_le##bits(token->kaddr + oip);	\
> +	} else {							\
> +		if (oip + size <= PAGE_SIZE)				\
> +			return get_unaligned_le##bits(token->kaddr + oip); \
>  									\
> -	memcpy(lebytes, token->kaddr + oip, part);			\
> -	token->kaddr = page_address(token->eb->pages[idx + 1]);		\
> -	token->offset = (idx + 1) << PAGE_SHIFT;			\
> -	memcpy(lebytes + part, token->kaddr, size - part);		\
> -	return get_unaligned_le##bits(lebytes);				\
> +		memcpy(lebytes, token->kaddr + oip, part);		\
> +		token->kaddr = page_address(token->eb->pages[idx + 1]);	\
> +		token->offset = (idx + 1) << PAGE_SHIFT;		\
> +		memcpy(lebytes + part, token->kaddr, size - part);	\
> +		return get_unaligned_le##bits(lebytes);			\
> +	}								\
>  }									\
>  u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
>  			 const void *ptr, unsigned long off)		\
> @@ -94,13 +98,17 @@ u##bits btrfs_get_##bits(const struct extent_buffer *eb,		\
>  	u8 lebytes[sizeof(u##bits)];					\
>  									\
>  	ASSERT(check_setget_bounds(eb, ptr, off, size));		\
> -	if (oip + size <= PAGE_SIZE)					\
> +	if (INLINE_EXTENT_BUFFER_PAGES == 1) {				\
>  		return get_unaligned_le##bits(kaddr + oip);		\
> +	} else {							\
> +		if (oip + size <= PAGE_SIZE)				\
> +			return get_unaligned_le##bits(kaddr + oip);	\
>  									\
> -	memcpy(lebytes, kaddr + oip, part);				\
> -	kaddr = page_address(eb->pages[idx + 1]);			\
> -	memcpy(lebytes + part, kaddr, size - part);			\
> -	return get_unaligned_le##bits(lebytes);				\
> +		memcpy(lebytes, kaddr + oip, part);			\
> +		kaddr = page_address(eb->pages[idx + 1]);		\
> +		memcpy(lebytes + part, kaddr, size - part);		\
> +		return get_unaligned_le##bits(lebytes);			\
> +	}								\
>  }									\
>  void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
>  			    const void *ptr, unsigned long off,		\
> @@ -124,15 +132,19 @@ void btrfs_set_token_##bits(struct btrfs_map_token *token,		\
>  	}								\
>  	token->kaddr = page_address(token->eb->pages[idx]);		\
>  	token->offset = idx << PAGE_SHIFT;				\
> -	if (oip + size <= PAGE_SIZE) {					\
> +	if (INLINE_EXTENT_BUFFER_PAGES == 1) {				\
>  		put_unaligned_le##bits(val, token->kaddr + oip);	\
> -		return;							\
> +	} else {							\
> +		if (oip + size <= PAGE_SIZE) {				\
> +			put_unaligned_le##bits(val, token->kaddr + oip); \
> +			return;						\
> +		}							\
> +		put_unaligned_le##bits(val, lebytes);			\
> +		memcpy(token->kaddr + oip, lebytes, part);		\
> +		token->kaddr = page_address(token->eb->pages[idx + 1]);	\
> +		token->offset = (idx + 1) << PAGE_SHIFT;		\
> +		memcpy(token->kaddr, lebytes + part, size - part);	\
>  	}								\
> -	put_unaligned_le##bits(val, lebytes);				\
> -	memcpy(token->kaddr + oip, lebytes, part);			\
> -	token->kaddr = page_address(token->eb->pages[idx + 1]);		\
> -	token->offset = (idx + 1) << PAGE_SHIFT;			\
> -	memcpy(token->kaddr, lebytes + part, size - part);		\
>  }									\
>  void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
>  		      unsigned long off, u##bits val)			\
> @@ -146,15 +158,19 @@ void btrfs_set_##bits(const struct extent_buffer *eb, void *ptr,	\
>  	u8 lebytes[sizeof(u##bits)];					\
>  									\
>  	ASSERT(check_setget_bounds(eb, ptr, off, size));		\
> -	if (oip + size <= PAGE_SIZE) {					\
> +	if (INLINE_EXTENT_BUFFER_PAGES == 1) {				\
>  		put_unaligned_le##bits(val, kaddr + oip);		\
> -		return;							\
> -	}								\
> +	} else {							\
> +		if (oip + size <= PAGE_SIZE) {				\
> +			put_unaligned_le##bits(val, kaddr + oip);	\
> +			return;						\
> +		}							\
>  									\
> -	put_unaligned_le##bits(val, lebytes);				\
> -	memcpy(kaddr + oip, lebytes, part);				\
> -	kaddr = page_address(eb->pages[idx + 1]);			\
> -	memcpy(kaddr, lebytes + part, size - part);			\
> +		put_unaligned_le##bits(val, lebytes);			\
> +		memcpy(kaddr + oip, lebytes, part);			\
> +		kaddr = page_address(eb->pages[idx + 1]);		\
> +		memcpy(kaddr, lebytes + part, size - part);		\
> +	}								\
>  }
>  
>  DEFINE_BTRFS_SETGET_BITS(8)
> -- 
> 2.31.1
> 
