Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9BB216D8
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 12:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfEQKPR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 May 2019 06:15:17 -0400
Received: from syrinx.knorrie.org ([82.94.188.77]:35574 "EHLO
        syrinx.knorrie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfEQKPR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 May 2019 06:15:17 -0400
X-Greylist: delayed 548 seconds by postgrey-1.27 at vger.kernel.org; Fri, 17 May 2019 06:15:15 EDT
Received: from [IPv6:2001:980:4a41:fb::12] (unknown [IPv6:2001:980:4a41:fb::12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by syrinx.knorrie.org (Postfix) with ESMTPSA id AA42C45F7458B;
        Fri, 17 May 2019 12:06:06 +0200 (CEST)
Subject: Re: [PATCH 06/15] btrfs: use raid_attr table in calc_stripe_length
 for nparity
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1558085801.git.dsterba@suse.com>
 <a4a37111b3166662450059a35eb9998cf8f9677b.1558085801.git.dsterba@suse.com>
From:   Hans van Kranenburg <hans@knorrie.org>
Message-ID: <318e980a-8b63-f425-804d-4d87a9d13d34@knorrie.org>
Date:   Fri, 17 May 2019 12:06:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a4a37111b3166662450059a35eb9998cf8f9677b.1558085801.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

Great cleanup series!

On 5/17/19 11:43 AM, David Sterba wrote:
> The table is already used for ncopies, replace open coding of stripes
> with the raid_attr value.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  fs/btrfs/volumes.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 995a15a816f2..743ed1f0b2a6 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -6652,19 +6652,14 @@ static u64 calc_stripe_length(u64 type, u64 chunk_len, int num_stripes)
>  {
>  	int index = btrfs_bg_flags_to_raid_index(type);
>  	int ncopies = btrfs_raid_array[index].ncopies;
> +	int nparity = btrfs_raid_array[index].nparity;
>  	int data_stripes;
>  
> -	switch (type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
> -	case BTRFS_BLOCK_GROUP_RAID5:
> -		data_stripes = num_stripes - 1;
> -		break;
> -	case BTRFS_BLOCK_GROUP_RAID6:
> -		data_stripes = num_stripes - 2;
> -		break;
> -	default:
> +	if (nparity)
> +		data_stripes = num_stripes - nparity;
> +	else
>  		data_stripes = num_stripes / ncopies;
> -		break;
> -	}

A few lines earlier in that file we have this:

        /*
         * this will have to be fixed for RAID1 and RAID10 over
         * more drives
         */
        data_stripes = (num_stripes - nparity) / ncopies;

1) I changed the calculation in b50836edf9 and did it in one statement,
I see you use and extra if here. Which one do you prefer and why?

2) Back then I wanted to get rid of that comment, because I don't
understand it. "this will have to be fixed" does not tell me what should
be fixed, so I left it there. Maybe now is the time? Do you know what
this comment/warning means and if it can be removed? I mean, even with
raid1c3 the calculation would be correct. There's no parity and three
copies.

> +
>  	return div_u64(chunk_len, data_stripes);
>  }
>  
> 

Hans
