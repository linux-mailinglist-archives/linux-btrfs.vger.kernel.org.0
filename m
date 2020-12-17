Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27232DD499
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Dec 2020 16:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgLQPvd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Dec 2020 10:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbgLQPvd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Dec 2020 10:51:33 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C364C061794
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 07:50:53 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id i67so19233244qkf.11
        for <linux-btrfs@vger.kernel.org>; Thu, 17 Dec 2020 07:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=th9s1BtzLO/gjBqNPEHQoc1rgBIX8eeGElKOK8Ld0vI=;
        b=oknEam83w4m6AeDQxMhyLKbyF9EAErirpSMSQZkIesPrj74n7/LAj2Uib3olUvdo/w
         YSl7p5opr0SWq8iNClqL8GWEmN9/pL6VE7IXWM0xTe81VM9oO9BO0aiPAI5R2W6EvDJN
         Cj48ojTYGS5aIb2f1hQmeYf5tOpsvYtHUSz6xF1/FsYIwp//Q3KRAEa8biZEaZynDOLo
         p4vdNEFg6ajOusFZnDI+6dbOPzwH98xmPUHhc+/CIVIWfcVCiYO/xQQQJK0WA1g1RyJJ
         ILLRW45hr9zxi5Cx0H/ZadLmmDApmYa10h49Vszv+xDjTogYooXCb3d5PfmhweaacMqA
         IZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=th9s1BtzLO/gjBqNPEHQoc1rgBIX8eeGElKOK8Ld0vI=;
        b=tnI2Apdpwk1h0JqXG6GGIjpOxU7vKPJzKJ0hTpBSUztjNFV6B13Th/3A2SCehlONe5
         pKmggWwFfyZXQ3B0AdnxJ6cPAekT4gHYyzFKrpu8lPjql5uAKGuGnmnYoH6Ty7DYRzVo
         VSXdB9knoDEUYdNjl8a3GmXr6epCUUGlBg2uo6Qncb+O9swD4byMompgw3IZmaDswLlG
         wcBIQ7y9Ppk7u0i93H8DrepvHGlFdd4BJb/kJnYURdemDZh93buQwrw/HibE0ILkgZhH
         dA2ubkGmt7IT4URD4njs6jF4v8ropvkVUYwHLQT7i1ig3qxLfUdbiXobo5Lv1tVcEGMf
         30JQ==
X-Gm-Message-State: AOAM533F0kw2U2djVvj/5kGpBH6VKrYpP1mBIpaAMzcmvLxMWLBsC5hF
        bcvVOc7/GuSu28DrDdT2tqjXCdfseE8c3gsr
X-Google-Smtp-Source: ABdhPJzPrH1iIKOUbPCTkfbA6jFtglPg4C9jtpiUiquyiGzQzhlIOhbPAkEYqfqcucJahK3TbZA2PQ==
X-Received: by 2002:a37:6358:: with SMTP id x85mr51041016qkb.68.1608220252264;
        Thu, 17 Dec 2020 07:50:52 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id z78sm3709590qkb.0.2020.12.17.07.50.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Dec 2020 07:50:51 -0800 (PST)
Subject: Re: [PATCH v2 04/18] btrfs: extent_io: introduce a helper to grab an
 existing extent buffer from a page
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20201210063905.75727-1-wqu@suse.com>
 <20201210063905.75727-5-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <aa3e6c04-551b-0729-17f9-516736e63596@toxicpanda.com>
Date:   Thu, 17 Dec 2020 10:50:49 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201210063905.75727-5-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/10/20 1:38 AM, Qu Wenruo wrote:
> This patch will extract the code to grab an extent buffer from a page
> into a helper, grab_extent_buffer_from_page().
> 
> This reduces one indent level, and provides the work place for later
> expansion for subapge support.
> 
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/extent_io.c | 52 +++++++++++++++++++++++++++-----------------
>   1 file changed, 32 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 612fe60b367e..6350c2687c7e 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -5251,6 +5251,32 @@ struct extent_buffer *alloc_test_extent_buffer(struct btrfs_fs_info *fs_info,
>   }
>   #endif
>   
> +static struct extent_buffer *grab_extent_buffer_from_page(struct page *page)
> +{
> +	struct extent_buffer *exists;
> +
> +	/* Page not yet attached to an extent buffer */
> +	if (!PagePrivate(page))
> +		return NULL;
> +
> +	/*
> +	 * We could have already allocated an eb for this page
> +	 * and attached one so lets see if we can get a ref on
> +	 * the existing eb, and if we can we know it's good and
> +	 * we can just return that one, else we know we can just
> +	 * overwrite page->private.
> +	 */
> +	exists = (struct extent_buffer *)page->private;
> +	if (atomic_inc_not_zero(&exists->refs)) {
> +		mark_extent_buffer_accessed(exists, page);
> +		return exists;
> +	}
> +
> +	WARN_ON(PageDirty(page));
> +	detach_page_private(page);
> +	return NULL;
> +}
> +
>   struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>   					  u64 start, u64 owner_root, int level)
>   {
> @@ -5296,26 +5322,12 @@ struct extent_buffer *alloc_extent_buffer(struct btrfs_fs_info *fs_info,
>   		}
>   
>   		spin_lock(&mapping->private_lock);
> -		if (PagePrivate(p)) {
> -			/*
> -			 * We could have already allocated an eb for this page
> -			 * and attached one so lets see if we can get a ref on
> -			 * the existing eb, and if we can we know it's good and
> -			 * we can just return that one, else we know we can just
> -			 * overwrite page->private.
> -			 */
> -			exists = (struct extent_buffer *)p->private;
> -			if (atomic_inc_not_zero(&exists->refs)) {
> -				spin_unlock(&mapping->private_lock);
> -				unlock_page(p);
> -				put_page(p);
> -				mark_extent_buffer_accessed(exists, p);
> -				goto free_eb;
> -			}
> -			exists = NULL;
> -
> -			WARN_ON(PageDirty(p));
> -			detach_page_private(p);
> +		exists = grab_extent_buffer_from_page(p);
> +		if (exists) {
> +			spin_unlock(&mapping->private_lock);
> +			unlock_page(p);
> +			put_page(p);

Put the mark_extent_buffer_accessed() here.  Thanks,

Josef
