Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494342A9675
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Nov 2020 13:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgKFMv6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Nov 2020 07:51:58 -0500
Received: from mx2.suse.de ([195.135.220.15]:33706 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726757AbgKFMv6 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 6 Nov 2020 07:51:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604667116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=ahvMiva3wO5sQyfgh8V5SiMQoNE7VEFY0/GlN29QTFI=;
        b=ZqAg/Ctlcq61EcDYVpgDoiSuQ52EZP6OmoFmatQlfVM6FSzx0nrxvVtCpKIgAUPgYu130T
        wRJiDhifp6hlAo/UPBFwPH7jNDADOibsoCQjs5t60V8cH7Qtf6SINlvExHYiHiZ4EOiG3D
        nuVQ9eDr/h3TFJj22y83LDKHOikTFyk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 56B01AB8F;
        Fri,  6 Nov 2020 12:51:56 +0000 (UTC)
Subject: Re: [PATCH 19/32] btrfs: handle sectorsize < PAGE_SIZE case for
 extent buffer accessors
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Goldwyn Rodrigues <rgoldwyn@suse.com>
References: <20201103133108.148112-1-wqu@suse.com>
 <20201103133108.148112-20-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d8eec47a-69c9-5173-1efb-0e7106068d70@suse.com>
Date:   Fri, 6 Nov 2020 14:51:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201103133108.148112-20-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3.11.20 г. 15:30 ч., Qu Wenruo wrote:
> To support sectorsize < PAGE_SIZE case, we need to take extra care for
> extent buffer accessors.
> 
> Since sectorsize is smaller than PAGE_SIZE, one page can contain
> multiple tree blocks, we must use eb->start to determine the real offset
> to read/write for extent buffer accessors.
> 
> This patch introduces two helpers to do these:
> - get_eb_page_index()
>   This is to calculate the index to access extent_buffer::pages.
>   It's just a simple wrapper around "start >> PAGE_SHIFT".
> 
>   For sectorsize == PAGE_SIZE case, nothing is changed.
>   For sectorsize < PAGE_SIZE case, we always get index as 0, and
>   the existing page shift works also fine.
> 
> - get_eb_page_offset()
>   This is to calculate the offset to access extent_buffer::pages.

nit: This is the same sentence as for get_eb_page_index, I think you
mean this calculates the offset in the page to start reading from.

>   This needs to take extent_buffer::start into consideration.
> 
>   For sectorsize == PAGE_SIZE case, extent_buffer::start is always
>   aligned to PAGE_SIZE, thus adding extent_buffer::start to
>   offset_in_page() won't change the result.
>   For sectorsize < PAGE_SIZE case, adding extent_buffer::start gives
>   us the correct offset to access.
> 
> This patch will touch the following parts to cover all extent buffer
> accessors:
> 
> - BTRFS_SETGET_HEADER_FUNCS()
> - read_extent_buffer()
> - read_extent_buffer_to_user()
> - memcmp_extent_buffer()
> - write_extent_buffer_chunk_tree_uuid()
> - write_extent_buffer_fsid()
> - write_extent_buffer()
> - memzero_extent_buffer()
> - copy_extent_buffer_full()
> - copy_extent_buffer()
> - memcpy_extent_buffer()
> - memmove_extent_buffer()
> - btrfs_get_token_##bits()
> - btrfs_get_##bits()
> - btrfs_set_token_##bits()
> - btrfs_set_##bits()
> - generic_bin_search()
> 

<snip>

> @@ -3314,6 +3315,39 @@ static inline void assertfail(const char *expr, const char* file, int line) { }
>  #define ASSERT(expr)	(void)(expr)
>  #endif
>  
> +/*
> + * Get the correct offset inside the page of extent buffer.
> + *
> + * Will handle both sectorsize == PAGE_SIZE and sectorsize < PAGE_SIZE cases.
> + *
> + * @eb:		The target extent buffer
> + * @start:	The offset inside the extent buffer
> + */
> +static inline size_t get_eb_page_offset(const struct extent_buffer *eb,
> +					unsigned long offset_in_eb)

nit: Rename to offset, you already pass an extent buffer so it's natural
that the offset pertain to this eb.

> +{
> +	/*
> +	 * For sectorsize == PAGE_SIZE case, eb->start will always be aligned
> +	 * to PAGE_SIZE, thus adding it won't cause any difference.
> +	 *
> +	 * For sectorsize < PAGE_SIZE, we must only read the data belongs to
> +	 * the eb, thus we have to take the eb->start into consideration.
> +	 */
> +	return offset_in_page(offset_in_eb + eb->start);
> +}
> +
> +static inline unsigned long get_eb_page_index(unsigned long offset_in_eb)

nit: Rename to offset since "in_eb" doesn't bring any value just makes
the variable's name somewhat awkward.
> +{
> +	/*
> +	 * For sectorsize == PAGE_SIZE case, plain >> PAGE_SHIFT is enough.
> +	 *
> +	 * For sectorsize < PAGE_SIZE case, we only support 64K PAGE_SIZE,
> +	 * and has ensured all tree blocks are contained in one page, thus
> +	 * we always get index == 0.
> +	 */
> +	return offset_in_eb >> PAGE_SHIFT;
> +}
> +
>  /*
>   * Use that for functions that are conditionally exported for sanity tests but
>   * otherwise static

<snip>

> @@ -5873,10 +5873,22 @@ void copy_extent_buffer_full(const struct extent_buffer *dst,
>  
>  	ASSERT(dst->len == src->len);
>  
> -	num_pages = num_extent_pages(dst);
> -	for (i = 0; i < num_pages; i++)
> -		copy_page(page_address(dst->pages[i]),
> -				page_address(src->pages[i]));
> +	if (dst->fs_info->sectorsize == PAGE_SIZE) {
> +		num_pages = num_extent_pages(dst);
> +		for (i = 0; i < num_pages; i++)
> +			copy_page(page_address(dst->pages[i]),
> +				  page_address(src->pages[i]));
> +	} else {
> +		unsigned long src_index = get_eb_page_index(0);
> +		unsigned long dst_index = get_eb_page_index(0);

nit: unsigned long src_index = 0, dst_index = 0; and remove the ASSERT()
below

> +		size_t src_offset = get_eb_page_offset(src, 0);
> +		size_t dst_offset = get_eb_page_offset(dst, 0);
> +
> +		ASSERT(src_index == 0 && dst_index == 0);
> +		memcpy(page_address(dst->pages[dst_index]) + dst_offset,
> +		       page_address(src->pages[src_index]) + src_offset,
> +		       src->len);
> +	}
>  }

<snip>
