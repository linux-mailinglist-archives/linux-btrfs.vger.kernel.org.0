Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A3957A858
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Jul 2022 22:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbiGSUih (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Jul 2022 16:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236199AbiGSUig (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Jul 2022 16:38:36 -0400
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F6E52E55
        for <linux-btrfs@vger.kernel.org>; Tue, 19 Jul 2022 13:38:35 -0700 (PDT)
Received: from authenticated-user (box.fidei.email [71.19.144.250])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by box.fidei.email (Postfix) with ESMTPSA id 0A87980425;
        Tue, 19 Jul 2022 16:38:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
        t=1658263115; bh=srN8Ms5mYn3tOHv2GHGTbh9Gj1P1BD25sQAsDntBBjQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BEIkpQ1qDt/Qp9m+MbcPnvUkxQeJutnB+ap/xICT8dvShfQPlGmO7oUMBRHkOtSWa
         lhDe1/9MXUdl+sW9/XUbQDlmYfRUWWzKwJFhbNcwmJVUck/jMczBoA+/n1GNQvfUWP
         K733tH+yr4PrNS/AGQy/lhRw7OeF0U/fyuBW+qWzCNfKFsv6Z+sz7vo6OcLuAbieg3
         QENNkkgZAAYOSzH8P9xp7tezlfW/WjHDX0pLaA5Q/mJwAX+ypHzAN7jfIyV8TSNSJF
         prHMcoimQaj98b3I1Lo46PF5BQEKpJXNSZC7TITY8l4I2mUHTN9uwVsOc6hO43k8NQ
         vgj4Sv8M2RUJg==
Message-ID: <c88649d5-dc14-6278-26fa-1821a8caed50@dorminy.me>
Date:   Tue, 19 Jul 2022 16:38:33 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/4] btrfs: output human readable space info flag
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1658207325.git.wqu@suse.com>
 <79cbc7064028a2f214a60abbb702f0d174b630a5.1658207325.git.wqu@suse.com>
From:   Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <79cbc7064028a2f214a60abbb702f0d174b630a5.1658207325.git.wqu@suse.com>
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
> For btrfs_space_info, its flags has only 4 possible values:
> - BTRFS_BLOCK_GROUP_SYSTEM
> - BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA
> - BTRFS_BLOCK_GROUP_METADATA
> - BTRFS_BLOCK_GROUP_DATA
> 
> Thus do debuggers a favor by output a human readable flags in
> __btrfs_dump_space_info().
> 
> Now the summary line of __btrfs_dump_space_info() looks like:
> 
>   BTRFS info (device dm-1: state A): space_info META has 251494400 free, is not full
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>   fs/btrfs/space-info.c | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 62d25112310d..36b466525318 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -450,14 +450,29 @@ do {									\
>   	spin_unlock(&__rsv->lock);					\
>   } while (0)
>   
> +static const char *space_info_flag_to_str(struct btrfs_space_info *space_info)
> +{
> +	if (space_info->flags == BTRFS_BLOCK_GROUP_SYSTEM)
> +		return "SYS";
> +
> +	/* Handle mixed data+metadata first. */
> +	if (space_info->flags == (BTRFS_BLOCK_GROUP_METADATA |
> +				  BTRFS_BLOCK_GROUP_DATA))
> +		return "DATA+META";
> +	if (space_info->flags == BTRFS_BLOCK_GROUP_DATA)
> +		return "DATA";
> +	return "META";
> +}

I think this would be more elegant as a switch statement; and would 
prefer the default to be "UNKNOWN" just in case there were a flag 
bitflip.   +
>   static void __btrfs_dump_space_info(struct btrfs_fs_info *fs_info,
>   				    struct btrfs_space_info *info)
>   {
> +	const char *flag_str = space_info_flag_to_str(info);
>   	lockdep_assert_held(&info->lock);
>   
>   	/* The free space could be negative in case of overcommit */
> -	btrfs_info(fs_info, "space_info %llu has %lld free, is %sfull",
> -		   info->flags,
> +	btrfs_info(fs_info, "space_info %s has %lld free, is %sfull",
> +		   flag_str,
>   		   (s64)(info->total_bytes - btrfs_space_info_used(info, true)),
>   		   info->full ? "" : "not ");
>   	btrfs_info(fs_info,
