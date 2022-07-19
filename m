Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6BE57A8AF
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 22:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237796AbiGSU4F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jul 2022 16:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234727AbiGSU4E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 16:56:04 -0400
Received: from box.fidei.email (box.fidei.email [IPv6:2605:2700:0:2:a800:ff:feba:dc44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECAC474D0
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 13:56:03 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 28AEF80411;
        Tue, 19 Jul 2022 16:56:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1658264163; bh=z82U1/j5uE184J5LSD0GcBL9IxW68m+UXrDpCWGARxg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Us6YkVv0n4BXCNP0tZUhubfhTIFRqbfqUH1kGa06GHSwpXIabo601B8KYAVY7yu9Y
         pdGQtxeGvY8plBpWFuXohp66giKgURYZ0ntIb16/+UxIOuixqkm1oUq4j8rh1LWp/f
         tUlCPs2dLTaexqVpj0hf3DkEGCkte0PK35VIZ1Yevnd9whb8CDmJvg05u5qbG6pHHI
         el5ZRhTfID5a6+Uzbj8g8NVTWAF+Vow34xjKIhYxUIxmJvw4YMW/2fue0g5MyELLU3
         X9o/jgfnb2D+ATkuu0imXOVeZivvSXgCj+qP+DIYRt2wLgX8zyqIe2YTauiihUmpTV
         ej114IeE8nk4Q==
Message-ID: <a5321725-1667-fd6f-2bfd-8ddb7b78d038@dorminy.me>
Date:   Tue, 19 Jul 2022 16:56:00 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/4] btrfs: make __btrfs_dump_space_info() output
 better formatted
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1658207325.git.wqu@suse.com>
 <dc40ddc78b7173d757065dcdde910bcf593d3a5c.1658207325.git.wqu@suse.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <dc40ddc78b7173d757065dcdde910bcf593d3a5c.1658207325.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 7/19/22 01:11, Qu Wenruo wrote:
> The format change includes:
> 
> - Output each bytes_* in a separate line
> 
> - All bytes_* output starts at the same vertical position
>    Do human a favor reading the numbers
> 
> - Skip zone specific numbers if zone is not enabled
> 
> Now one example of __btrfs_dump_space_info() looks like this for its
> bytes_* members.
> 
>   BTRFS info (device dm-1: state A): space_info META has 251494400 free, is not full
>   BTRFS info (device dm-1: state A):   total:         268435456
>   BTRFS info (device dm-1: state A):   used:          376832
>   BTRFS info (device dm-1: state A):   pinned:        229376
>   BTRFS info (device dm-1: state A):   reserved:      0
>   BTRFS info (device dm-1: state A):   may_use:       16269312
>   BTRFS info (device dm-1: state A):   read_only:     65536
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/space-info.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 36b466525318..623fa0488545 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -475,11 +475,15 @@ static void __btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
>   		   flag_str,
>   		   (s64)(info->total_bytes - btrfs_space_info_used(info, true)),
>   		   info->full ? "" : "not ");
> -	btrfs_info(fs_info,
> -		"space_info total=%llu, used=%llu, pinned=%llu, reserved=%llu, may_use=%llu, readonly=%llu zone_unusable=%llu",
> -		info->total_bytes, info->bytes_used, info->bytes_pinned,
> -		info->bytes_reserved, info->bytes_may_use,
> -		info->bytes_readonly, info->bytes_zone_unusable);
> +	btrfs_info(fs_info, "  total:         %llu", info->total_bytes);
> +	btrfs_info(fs_info, "  used:          %llu", info->bytes_used);
> +	btrfs_info(fs_info, "  pinned:        %llu", info->bytes_pinned);
> +	btrfs_info(fs_info, "  reserved:      %llu", info->bytes_reserved);
> +	btrfs_info(fs_info, "  may_use:       %llu", info->bytes_may_use);
> +	btrfs_info(fs_info, "  read_only:     %llu", info->bytes_readonly);
> +	if (btrfs_is_zoned(fs_info))
> +		btrfs_info(fs_info,
> +			    "  zone_unusable: %llu", info->bytes_zone_unusable);

I'm (perhaps needlessly) worried about splitting this up into six/seven 
messages, because of the ratelimiting rolled into btrfs_printk. The 
ratelimit is 100 messages per 5 * HZ, and it seems like it would be 
unfortunate if it kicked in during the middle of this dump and prevented 
later info from being dumped.

Maybe we should add a btrfs_dump_printk() helper that doesn't have a 
ratelimit built in, for exceptional cases like this where we really, 
really don't want anything ratelimited?


>   
>   	DUMP_BLOCK_RSV(fs_info, global_block_rsv);
>   	DUMP_BLOCK_RSV(fs_info, trans_block_rsv);


