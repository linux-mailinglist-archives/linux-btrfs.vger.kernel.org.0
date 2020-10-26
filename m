Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 186BD298F2C
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Oct 2020 15:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780906AbgJZOXv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Oct 2020 10:23:51 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:36554 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780868AbgJZOXu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Oct 2020 10:23:50 -0400
Received: by mail-qv1-f66.google.com with SMTP id ev17so4332097qvb.3
        for <linux-btrfs@vger.kernel.org>; Mon, 26 Oct 2020 07:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=wy34SlNQmnW0GYI9FLt1xggZpUiHBQh8bsMWozD9LjQ=;
        b=QYqR4TTRYgoiQL8NUJe28/F/ulcbpbSUyrHt98c1HyXwZVYfAHy2vyo7qT30BeGqz4
         T5vcaQ/eWPw0enZXNLPgTZLQZyQwCvE9hYeCGe1oGuSpkSqT7S1zAjk4sfseHUq6vDeg
         Jz0fhPseUiOEReBTyWI1zMXXEck87k+8teGw9SOw8casKO6KBW7AYG76F96vRG0Oh6md
         29Tk7nhhDR8cDqrQMT7hx0+EY8KmO7NXVbhYsGgUqatNtb7PvtMn7Ta8iFdwJTFYFlPv
         XJKVI8F87bKEUUt8atkuIZFAJe3qSZ/QIhwga3sWdxZtYdDt5Oi8br/HBmteqflRr2BL
         dJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wy34SlNQmnW0GYI9FLt1xggZpUiHBQh8bsMWozD9LjQ=;
        b=iZLR8h47jromEIeFMzz6bPZxtFL/tNb4GXcURlI65Tf7+lztyWTwj/mgCcZSsGCuEN
         KzeQ3QIOGltDR8NIUM2GHVLmHDDxFdRoBlXD2uEFkm7vojF8ZAPlJ/1ng5YvK76YQjgu
         4N2Vpa9sUzeANKP9yitSTHMF6a3jSzdIprVsdwQbqRYgo9K08qYHMFVAdgV/S3HIru2w
         6RImWp37aa3hBTjfS+b7wooA198MbFVbLR9Kn1bxJGoCS3rrxuk3U8KUBlyVRJyGU7ME
         liKgzNcqX9r1n1xRUfxWWd0PmfgWePxa+ABzYSTSwem2KVuRXvXE6usnpC5B8R9mA7Qv
         z4qQ==
X-Gm-Message-State: AOAM531NCnPKypKyQavLQ+s9OpSEyM/fHlrfSVEtGasgyV2ZjcsnAqW/
        YbHn4vkBekclryvDSN6uIdl1AdC7OvpGAFFp
X-Google-Smtp-Source: ABdhPJzYv1RGBrxToq0BFfKw8VVAp1mOC1EMXJx2dVmxP90W/M1eoUzCDE39FXNQKL4PldO/BUROag==
X-Received: by 2002:a0c:e387:: with SMTP id a7mr13890661qvl.21.1603722228430;
        Mon, 26 Oct 2020 07:23:48 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o193sm6641743qke.12.2020.10.26.07.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2020 07:23:47 -0700 (PDT)
Subject: Re: [PATCH 3/8] btrfs: scrub: use flexible array for
 scrub_page::csums
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20201026071115.57225-1-wqu@suse.com>
 <20201026071115.57225-4-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <84c00b03-c2f7-7e97-4275-a217e24e8ad8@toxicpanda.com>
Date:   Mon, 26 Oct 2020 10:23:47 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201026071115.57225-4-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/26/20 3:11 AM, Qu Wenruo wrote:
> There are several factors affecting how many checksum bytes are needed
> for one scrub_page:
> 
> - Sector size and page size
>    For subpage case, one page can contain several sectors, thus the csum
>    size will differ.
> 
> - Checksum size
>    Since btrfs supports different csum size now, which can vary from 4
>    bytes for CRC32 to 32 bytes for SHA256.
> 
> So instead of using fixed BTRFS_CSUM_SIZE, now use flexible array for
> scrub_page::csums, and determine the size at scrub_page allocation time.
> 
> This does not only provide the basis for later subpage scrub support,
> but also reduce the memory usage for default btrfs on x86_64.
> As the default CRC32 only uses 4 bytes, thus we can save 28 bytes for
> each scrub page.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/scrub.c | 41 ++++++++++++++++++++++++++++++-----------
>   1 file changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 3cb51d1f061f..321d6d457942 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -76,9 +76,14 @@ struct scrub_page {
>   		unsigned int	have_csum:1;
>   		unsigned int	io_error:1;
>   	};
> -	u8			csum[BTRFS_CSUM_SIZE];
> -
>   	struct scrub_recover	*recover;
> +
> +	/*
> +	 * The csums size for the page is deteremined by page size,
> +	 * sector size and csum size.
> +	 * Thus the length has to be determined at runtime.
> +	 */
> +	u8			csums[];
>   };
>   
>   struct scrub_bio {
> @@ -207,6 +212,19 @@ struct full_stripe_lock {
>   	struct mutex mutex;
>   };
>   
> +static struct scrub_page *alloc_scrub_page(struct scrub_ctx *sctx, gfp_t mask)
> +{
> +	u32 sectorsize = sctx->fs_info->sectorsize;
> +	size_t size;
> +
> +	/* No support for multi-page sector size yet */
> +	ASSERT(PAGE_SIZE >= sectorsize && IS_ALIGNED(PAGE_SIZE, sectorsize));

Check patch complains about this

WARNING: Comparisons should place the constant on the right side of the test
#32: FILE: fs/btrfs/scrub.c:221:
+       ASSERT(PAGE_SIZE >= sectorsize && IS_ALIGNED(PAGE_SIZE, sectorsize));


Once you fix that you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
