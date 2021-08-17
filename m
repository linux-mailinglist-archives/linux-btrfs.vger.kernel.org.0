Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6F53EEDA0
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Aug 2021 15:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237594AbhHQNob (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Aug 2021 09:44:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34228 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237385AbhHQNob (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Aug 2021 09:44:31 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 436461FF41;
        Tue, 17 Aug 2021 13:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629207837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o7FCEVzJ3ZdDd7amBYCF5NHXkM52Bw0l/yshk7VxOfc=;
        b=r8i5TpEwhoZTbyG2XL32t0VmSdRU5+7xMWzFevQ8LvdGpF+yygBjN2TP+J+DGK/2+oHeTK
        imZsBn+jXWxLPsOgjJ31C3YXA1u5XUzqa8vtYlcbl+X/oknehffToEMDZZpJ+HqZDkNXqM
        2xG4gulukdMfrYskWX+BmNf7LGF1JX4=
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 159DF132AB;
        Tue, 17 Aug 2021 13:43:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id cF3qAR29G2FFRQAAGKfGzw
        (envelope-from <nborisov@suse.com>); Tue, 17 Aug 2021 13:43:57 +0000
Subject: Re: [PATCH v2 4/4] btrfs: subpage: pack all subpage bitmaps into a
 larger bitmap
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210817093852.48126-1-wqu@suse.com>
 <20210817093852.48126-5-wqu@suse.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <9599db38-cff8-fac5-c6db-ec1d53beeed3@suse.com>
Date:   Tue, 17 Aug 2021 16:43:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210817093852.48126-5-wqu@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 17.08.21 г. 12:38, Qu Wenruo wrote:
> Currently we use u16 bitmap to make 4k sectorsize work for 64K page
> size.
> 
> But this u16 bitmap is not large enough to contain larger page size like
> 128K, nor is space efficient for 16K page size.
> 
> To handle both cases, here we pack all subpage bitmaps into a larger
> bitmap, now btrfs_subpage::bitmaps[] will be the ultimate bitmap for
> subpage usage.
> 
> Each sub-bitmap will has its start bit number recorded in
> btrfs_subpage_info::*_start, and its bitmap length will be recorded in
> btrfs_subpage_info::bitmap_nr_bits.
> 
> All subpage bitmap operations will be converted from using direct u16
> operations to bitmap operations, with above *_start calculated.
> 
> For 64K page size with 4K sectorsize, this should not cause much
> difference.
> 
> While for 16K page size, we will only need 1 unsigned long (u32) to
> store all the bitmaps, which saves quite some space.
> 
> Furthermore, this allows us to support larger page size like 128K and
> 258K.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

<snip>

> +#define GANG_LOOKUP_SIZE	16
>  static struct extent_buffer *get_next_extent_buffer(
>  		struct btrfs_fs_info *fs_info, struct page *page, u64 bytenr)
>  {
> -	struct extent_buffer *gang[BTRFS_SUBPAGE_BITMAP_SIZE];
> +	struct extent_buffer *gang[GANG_LOOKUP_SIZE];
>  	struct extent_buffer *found = NULL;
>  	u64 page_start = page_offset(page);
> -	int ret;
> -	int i;
> +	u64 cur = page_start;
>  
>  	ASSERT(in_range(bytenr, page_start, PAGE_SIZE));
> -	ASSERT(PAGE_SIZE / fs_info->nodesize <= BTRFS_SUBPAGE_BITMAP_SIZE);
>  	lockdep_assert_held(&fs_info->buffer_lock);
>  
> -	ret = radix_tree_gang_lookup(&fs_info->buffer_radix, (void **)gang,
> -			bytenr >> fs_info->sectorsize_bits,
> -			PAGE_SIZE / fs_info->nodesize);
> -	for (i = 0; i < ret; i++) {
> -		/* Already beyond page end */
> -		if (gang[i]->start >= page_start + PAGE_SIZE)
> -			break;
> -		/* Found one */
> -		if (gang[i]->start >= bytenr) {
> -			found = gang[i];
> -			break;
> +	while (cur < page_start + PAGE_SIZE) {
> +		int ret;
> +		int i;
> +
> +		ret = radix_tree_gang_lookup(&fs_info->buffer_radix,
> +				(void **)gang, cur >> fs_info->sectorsize_bits,
> +				min_t(unsigned int, GANG_LOOKUP_SIZE,
> +				      PAGE_SIZE / fs_info->nodesize));
> +		if (ret == 0)
> +			goto out;
> +		for (i = 0; i < ret; i++) {
> +			/* Already beyond page end */
> +			if (gang[i]->start >= page_start + PAGE_SIZE)

nit: this could be rewritten as (in_range(gang[i]->start, page_start,
PAGE_SIZE)

> +				goto out;
> +			/* Found one */
> +			if (gang[i]->start >= bytenr) {
> +				found = gang[i];
> +				goto out;
> +			}
>  		}
> +		cur = gang[ret - 1]->start + gang[ret - 1]->len;
>  	}
> +out:
>  	return found;
>  }
>  

<snip>
