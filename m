Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B626528009F
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Oct 2020 15:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732380AbgJAN75 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Oct 2020 09:59:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:56478 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732169AbgJAN75 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 1 Oct 2020 09:59:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601560795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=HaxNX6Tg9u7vhDHnrEhLCs4vrVA/3FYV0lf8NnGT20o=;
        b=AcNCeFzZiDm6pClJIjG+d3xwOVbg8eoCtadQZ9U/+LIkqh7edg5Mkbjt3rK4PC+tOzIc97
        GpSJG4GCcuCcsUo+wb2C9glXI9LQjhYHBdgNxI/n+eYSq8Oc3mytZ2KG2CNZZLi5rzvE3x
        2vLJLjOnC938wAxwG0Kp9LLDMLnGtas=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 74325B1DA;
        Thu,  1 Oct 2020 13:59:55 +0000 (UTC)
Subject: Re: [PATCH 5/9] btrfs: rework btrfs_calc_reclaim_metadata_size
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1601495426.git.josef@toxicpanda.com>
 <bc6b0eeceacb2b444acf1ff74673471e2dfd2bb9.1601495426.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <812450cb-e21f-83ac-27b3-803000d7b5d5@suse.com>
Date:   Thu, 1 Oct 2020 16:59:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <bc6b0eeceacb2b444acf1ff74673471e2dfd2bb9.1601495426.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 30.09.20 г. 23:01 ч., Josef Bacik wrote:
<snip>
>  
> @@ -800,6 +777,7 @@ static inline int need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
>  					  u64 used)
>  {
>  	u64 thresh = div_factor_fine(space_info->total_bytes, 98);
> +	u64 to_reclaim, expected;
>  
>  	/* If we're just plain full then async reclaim just slows us down. */
>  	if ((space_info->bytes_used + space_info->bytes_reserved) >= thresh)
> @@ -812,7 +790,25 @@ static inline int need_preemptive_reclaim(struct btrfs_fs_info *fs_info,
>  	if (space_info->reclaim_size)
>  		return 0;
>  
> -	if (!btrfs_calc_reclaim_metadata_size(fs_info, space_info))
> +	to_reclaim = min_t(u64, num_online_cpus() * SZ_1M, SZ_16M);
> +	if (btrfs_can_overcommit(fs_info, space_info, to_reclaim,
> +				 BTRFS_RESERVE_FLUSH_ALL))
> +		return 0;
> +
> +	used = btrfs_space_info_used(space_info, true);
> +	if (btrfs_can_overcommit(fs_info, space_info, SZ_1M,
> +				 BTRFS_RESERVE_FLUSH_ALL))
> +		expected = div_factor_fine(space_info->total_bytes, 95);
> +	else
> +		expected = div_factor_fine(space_info->total_bytes, 90);

I think this should be just:

expected = div_factor_fine(space_info->total_bytes, 90);

Because before this check we tried to overcommit between 1 and 16m
(depending on the online CPU's) and we failed. So there is no reason to
think that :

btrfs_can_overcommit(fs_info, space_info, SZ_1M, BTRFS_RESERVE_FLUSH_ALL)

would succeed. So you can simplify the logic by eliminating the 2nd
check for btrfs_can_overcommit

> +
> +	if (used > expected)
> +		to_reclaim = used - expected;
> +	else
> +		to_reclaim = 0;
> +	to_reclaim = min(to_reclaim, space_info->bytes_may_use +
> +				     space_info->bytes_reserved);
> +	if (!to_reclaim)
>  		return 0;
>  
>  	return (used >= thresh && !btrfs_fs_closing(fs_info) &&
> 

nit: Not directly related to your patch but since you are moving the
code does it make sense to keep the fs_closing and STATE_REMOUNTING
checks around?
