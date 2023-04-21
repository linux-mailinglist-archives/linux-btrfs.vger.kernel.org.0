Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083636EA534
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Apr 2023 09:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjDUHtM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Apr 2023 03:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjDUHtL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Apr 2023 03:49:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010B82D67
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Apr 2023 00:49:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70B6C60F05
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Apr 2023 07:49:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D49C433D2;
        Fri, 21 Apr 2023 07:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682063348;
        bh=PxwxxrrfSlH0AoqjzeZLzDUFg32hvy44mYXTtT3MZxc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mJaloJcPzA09nFaL+180wKQOAfZn5wdxZmx+b0PctNZd79YFntropc63BSvX9YwcL
         HobtS1tSdEDm9q+3C8N0xB9r1jjFf2cSvz0ntD08vQ1tWl0fucdvokIraq7y1Voomk
         5hfQXnPiGsW3tjnqJzYhqBiY/C7pkPy/Yq0dHF5tstaZZz1+yxsjHwdWSiiCPU481f
         gEIGVw3wPVBfU/eWVIQZbKt4Bel4tjHUGJMi6uqYq5+tyIZkz2sY0MpnnbElr+E6zG
         JlY4Jnk1Yge1FwRI8hvDTBlhi/O5PRXcMZR2680RPcbkZvkif2G9IqHB5K9uEHMjyN
         wA+5U21o3Ng/Q==
Message-ID: <19c1d144-3d37-0dc7-3b01-feafb135d1e7@kernel.org>
Date:   Fri, 21 Apr 2023 16:49:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] btrfs: export bitmap_test_range_all_{set,zero}
To:     Naohiro Aota <naota@elisp.net>, linux-btrfs@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>
References: <bab3ffe3255379a63b07c4c11ea1a52e1a904f68.1682062222.git.naohiro.aota@wdc.com>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <bab3ffe3255379a63b07c4c11ea1a52e1a904f68.1682062222.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/21/23 16:31, Naohiro Aota wrote:
> From: Naohiro Aota <naohiro.aota@wdc.com>
> 
> bitmap_test_range_all_{set,zero} defined in subpage.c are useful for other
> components. Move them to misc.h and use them in zoned.c. Also, as
> find_next{,_zero}_bit take/return "unsigned long" instead of "unsigned
> int", convert the type to "unsigned long".
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/misc.h    | 22 ++++++++++++++++++++++
>  fs/btrfs/subpage.c | 22 ----------------------
>  fs/btrfs/zoned.c   | 12 ++++++------
>  3 files changed, 28 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
> index 768583a440e1..6f574c291342 100644
> --- a/fs/btrfs/misc.h
> +++ b/fs/btrfs/misc.h
> @@ -143,4 +143,26 @@ static inline struct rb_node *rb_simple_insert(struct rb_root *root, u64 bytenr,
>  	return NULL;
>  }
>  
> +static inline bool bitmap_test_range_all_set(unsigned long *addr, unsigned long start,

Long line.

> +					     unsigned long nbits)
> +{
> +	unsigned long found_zero;
> +
> +	found_zero = find_next_zero_bit(addr, start + nbits, start);
> +	if (found_zero == start + nbits)
> +		return true;
> +	return false;

Why not:

	return find_next_zero_bit(addr, start + nbits, start) == start + nbits;

Simpler...

> +}
> +
> +static inline bool bitmap_test_range_all_zero(unsigned long *addr, unsigned long start,

Long line.

> +					      unsigned long nbits)
> +{
> +	unsigned long found_set;
> +
> +	found_set = find_next_bit(addr, start + nbits, start);
> +	if (found_set == start + nbits)
> +		return true;
> +	return false;

	return find_next_bit(addr, start + nbits, start) == start + nbits;

> +}
> +
>  #endif
> diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
> index dd46b978ac2c..045117ca0ddc 100644
> --- a/fs/btrfs/subpage.c
> +++ b/fs/btrfs/subpage.c
> @@ -367,28 +367,6 @@ void btrfs_page_end_writer_lock(const struct btrfs_fs_info *fs_info,
>  		unlock_page(page);
>  }
>  
> -static bool bitmap_test_range_all_set(unsigned long *addr, unsigned int start,
> -				      unsigned int nbits)
> -{
> -	unsigned int found_zero;
> -
> -	found_zero = find_next_zero_bit(addr, start + nbits, start);
> -	if (found_zero == start + nbits)
> -		return true;
> -	return false;
> -}
> -
> -static bool bitmap_test_range_all_zero(unsigned long *addr, unsigned int start,
> -				       unsigned int nbits)
> -{
> -	unsigned int found_set;
> -
> -	found_set = find_next_bit(addr, start + nbits, start);
> -	if (found_set == start + nbits)
> -		return true;
> -	return false;
> -}
> -
>  #define subpage_calc_start_bit(fs_info, page, name, start, len)		\
>  ({									\
>  	unsigned int start_bit;						\
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index d51057608fc3..858a59d39b38 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -1058,7 +1058,7 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
>  
>  		/* Check if zones in the region are all empty */
>  		if (btrfs_dev_is_sequential(device, pos) &&
> -		    find_next_zero_bit(zinfo->empty_zones, end, begin) != end) {
> +		    bitmap_test_range_all_set(zinfo->empty_zones, begin, nzones)) {
>  			pos += zinfo->zone_size;
>  			continue;
>  		}
> @@ -1157,23 +1157,23 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
>  	struct btrfs_zoned_device_info *zinfo = device->zone_info;
>  	const u8 shift = zinfo->zone_size_shift;
>  	unsigned long begin = start >> shift;
> -	unsigned long end = (start + size) >> shift;
> +	unsigned long nbits = size >> shift;
>  	u64 pos;
>  	int ret;
>  
>  	ASSERT(IS_ALIGNED(start, zinfo->zone_size));
>  	ASSERT(IS_ALIGNED(size, zinfo->zone_size));
>  
> -	if (end > zinfo->nr_zones)
> +	if (begin + nbits > zinfo->nr_zones)
>  		return -ERANGE;
>  
>  	/* All the zones are conventional */
> -	if (find_next_bit(zinfo->seq_zones, end, begin) == end)
> +	if (bitmap_test_range_all_zero(zinfo->seq_zones, begin, nbits))
>  		return 0;
>  
>  	/* All the zones are sequential and empty */
> -	if (find_next_zero_bit(zinfo->seq_zones, end, begin) == end &&
> -	    find_next_zero_bit(zinfo->empty_zones, end, begin) == end)
> +	if (bitmap_test_range_all_set(zinfo->seq_zones, begin, nbits) &&
> +	    bitmap_test_range_all_set(zinfo->seq_zones, begin, nbits))
>  		return 0;
>  
>  	for (pos = start; pos < start + size; pos += zinfo->zone_size) {

