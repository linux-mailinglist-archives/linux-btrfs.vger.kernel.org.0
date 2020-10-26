Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F00298F8E
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Oct 2020 15:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781772AbgJZOkM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 10:40:12 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:42553 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781722AbgJZOjU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 10:39:20 -0400
Received: by mail-qt1-f193.google.com with SMTP id h12so1754508qtc.9
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 07:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=aDLAXs1R2XfMTgGH0DF76QVMEKjC7YCAohI2+p5k5uE=;
        b=LbyC6pVmoQdkLU/At+45zAUCtRLRBdL1hjdvxf6PYNh3lrZCO/aug6Y0pC8aCqoIBG
         9UPdrpY4UKQN48eglYgv4gtmUf5FM8skQ8ltkh013RQAwDpAejwQJeHTAtTj7Q6TkUNT
         bAXHLBZh9BTRj9feU2PaHv2wrbE4DDAGF3O4OSYa/KkuGN5eui9Kttgr7VjvjHrl2+d/
         zxkZHAIG8fSxIgdtjFXbZ7zNh1lPm69b0xTuRyR1GdCjLbMGgJPVQ8uSAK2MMmNOqWX1
         014ALjk6VszneCPq/IDnICjxe4iCLCwPNJVcQRv02rCELkOixsyAs2oJxgJsIrRDpYwU
         xwIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aDLAXs1R2XfMTgGH0DF76QVMEKjC7YCAohI2+p5k5uE=;
        b=cbQ3khqXz2dzIydErYuZOBBLU887Z6ZPaYr+3LdSLKl5EReSFMSjf1es2KnX6W7olI
         ErmYpSaEr3WZEzxVOUtsqcER9NVDLNEMPldblAs1XKS28CCp0RNv9UJGOkLUn/3+EPzv
         ZMQyVcC4EXhDtprCN9xZiOe1/9c3UcofKxXBDBjHQKOL+3QIiXoDQ28n39DnYGybkdIq
         VKm6/yY+gsUsr/MhsblMogDDRulrZK0uUS5fNZ4zwuVItm0jtKL9nZc8RIK+2vWGkX7i
         8oy/tADu8QgPLNLee3DzieEkC6i01QqQJulb3kEdi8TDbMVHgU9KIxTz8T/pgQ0cAXT1
         Q/uQ==
X-Gm-Message-State: AOAM531DCihOWxKPMtL4tyc1gmIEjcE8LglarWzRVVG3TCPG86NIHj+W
        Yi7zn7BKBwUlM2STH3XWeR8rFaM+rhoLK0Ob
X-Google-Smtp-Source: ABdhPJxlbSOoK6l8csJsEEu7h+n4eokuMsU0wPzifDOJ2MrF5r4f7rOdL5WQpi96m1MbFKRtumQbvA==
X-Received: by 2002:ac8:4b79:: with SMTP id g25mr12350878qts.19.1603723158746;
        Mon, 26 Oct 2020 07:39:18 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d7sm6649205qkg.29.2020.10.26.07.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 07:39:17 -0700 (PDT)
Subject: Re: [PATCH 4/8] btrfs: scrub: refactor scrub_find_csum()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201026071115.57225-1-wqu@suse.com>
 <20201026071115.57225-5-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <33649c3a-e4f2-724c-dedf-8583991efaf3@toxicpanda.com>
Date:   Mon, 26 Oct 2020 10:39:16 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201026071115.57225-5-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/26/20 3:11 AM, Qu Wenruo wrote:
> Function scrub_find_csum() is to locate the csum for bytenr @logical
> from sctx->csum_list.
> 
> However it lacks a lot of comments to explaining things like how the
> csum_list is organized and why we need to drop csum range which is
> before us.
> 
> Refactor the function by:
> - Add more comment explaining the behavior
> - Add comment explaining why we need to drop the csum range
> - Put the csum copy in the main loop
>    This is mostly for the incoming patches to make scrub_find_csum() able
>    to find multiple checksums.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/scrub.c | 70 +++++++++++++++++++++++++++++++++++-------------
>   1 file changed, 51 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 321d6d457942..0d078393f986 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2386,37 +2386,69 @@ static void scrub_block_complete(struct scrub_block *sblock)
>   	}
>   }
>   
> +static void drop_csum_range(struct scrub_ctx *sctx,
> +			    struct btrfs_ordered_sum *sum)
> +{
> +	u32 sectorsize = sctx->fs_info->sectorsize;
> +
> +	sctx->stat.csum_discards += sum->len / sectorsize;
> +	list_del(&sum->list);
> +	kfree(sum);
> +}
> +
> +/*
> + * Find the desired csum for range [@logical, @logical + sectorsize), and
> + * store the csum into @csum.
> + *
> + * The search source is sctx->csum_list, which is a pre-populated list
> + * storing bytenr ordered csum ranges.
> + * We're reponsible to cleanup any range that is before @logical.
> + *
> + * Return 0 if there is no csum for the range.
> + * Return 1 if there is csum for the range and copied to @csum.
> + */
>   static int scrub_find_csum(struct scrub_ctx *sctx, u64 logical, u8 *csum)
>   {
> -	struct btrfs_ordered_sum *sum = NULL;
> -	unsigned long index;
> -	unsigned long num_sectors;
> +	u32 sectorsize = sctx->fs_info->sectorsize;
> +	u32 csum_size = sctx->csum_size;
> +	bool found = false;
>   
>   	while (!list_empty(&sctx->csum_list)) {
> +		struct btrfs_ordered_sum *sum = NULL;
> +		unsigned long index;
> +		unsigned long num_sectors;
> +
>   		sum = list_first_entry(&sctx->csum_list,
>   				       struct btrfs_ordered_sum, list);
> +		/* The current csum range is beyond our range, no csum found */
>   		if (sum->bytenr > logical)
> -			return 0;
> -		if (sum->bytenr + sum->len > logical)
>   			break;
>   
> -		++sctx->stat.csum_discards;
> -		list_del(&sum->list);
> -		kfree(sum);
> -		sum = NULL;
> -	}
> -	if (!sum)
> -		return 0;
> +		/*
> +		 * The current sum is before our bytenr, since scrub is
> +		 * always done in bytenr order, the csum will never be used
> +		 * anymore, clean it up so that later calls won't bother the
> +		 * range, and continue search the next range.
> +		 */
> +		if (sum->bytenr + sum->len <= logical) {
> +			drop_csum_range(sctx, sum);
> +			continue;
> +		}
>   
> -	index = div_u64(logical - sum->bytenr, sctx->fs_info->sectorsize);
> -	ASSERT(index < UINT_MAX);
> +		/* Now the csum range covers our bytenr, copy the csum */
> +		found = true;
> +		index = div_u64(logical - sum->bytenr, sectorsize);
> +		num_sectors = sum->len / sectorsize;
>   
> -	num_sectors = sum->len / sctx->fs_info->sectorsize;
> -	memcpy(csum, sum->sums + index * sctx->csum_size, sctx->csum_size);
> -	if (index == num_sectors - 1) {
> -		list_del(&sum->list);
> -		kfree(sum);
> +		memcpy(csum, sum->sums + index * csum_size, csum_size);
> +
> +		/* Cleanup the range if we're at the end of the csum range */
> +		if (index == num_sectors - 1)
> +			drop_csum_range(sctx, sum);
> +		break;
>   	}
> +	if (!found)
> +		return 0;
>   	return 1;
>   }

If it's just a bool we're returning, change this to

static bool scrub_find_csum()

and do

return found.

Thanks,

Josef
