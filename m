Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E1244E0F9
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Nov 2021 05:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhKLETz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 23:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhKLETz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 23:19:55 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE101C061766
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Nov 2021 20:17:04 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id j63so3601929qkd.2
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Nov 2021 20:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9PkQqvKLLPVUjck24kkYqSOLxPnP0iGlTSL3c4NXxDk=;
        b=xXPfWISUPXI8gjo15mbuGS1EKFaoKkr3rPMwkjWiLMjxbn4PEQJ3U8u86RYEZ1Xjc3
         2BywW9xgb9wUqtrNOr6TiJCnvFAzqepvbgW8ucQFRiNwCjXuEsZ4XZiJ8p4ecT5ULAk7
         X5XiiYYdkzuFzLJriHSG43W92P9vLn6ni2MeYrYXLmyVgIH5Cj8keBkc9E9fdlQtlGvR
         9V2GESxpbbkX1OSdLrILi8nAnCMSXecV5P2W4+KX7BInNE+h46vq7DAFtzta0bFvvQmg
         07A5qLl9A76bufj44qoTSocSNAR5KjzlhLpTh84xpkEXNavYE6C+Kk5XVLGd0dvxTAp6
         +fvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9PkQqvKLLPVUjck24kkYqSOLxPnP0iGlTSL3c4NXxDk=;
        b=SgWvUPb4vdgqtPSAW6TCVzTGyiVw7herieZl7yJcrM/iSPLbJIy22br+zcBQ/V7F9P
         L2UV5w7n5pWzxaaqdsQKlHn4yAr6ai8QK1+C2TkXVlmKBXi3sHeIQDI3pYCV2YTK7CzD
         85jorg3XAtnQZsV8zsCfEHvcHJb5tpmeT6Pd0CHrx8PSPHi4LHI1ftZ5qJp+2UTbmN7s
         WvPgrV/oKUIGuXalL6/g8FeshedqkyiM0tJLkPIrTWFhgficF6OyM0RTHmbJ/ZifLYEY
         Rl+5q8sH+yCsaxlBo0DsELAg8oFlQDbWuMJbvYwPjCs4a6gxM10/uYT8fcuyXJhiuNPo
         4x7A==
X-Gm-Message-State: AOAM531zwNc5V5HqDrMMjE5YwKrO3OaEpwjVy6R8H/KGNefZgRy3EFnN
        6XDDlVG6h2OBIPY9EbbET9IlLg==
X-Google-Smtp-Source: ABdhPJzeqGxfjn+cqecBCdH2YN0uvJGIaY0RGjWbNOqF6nPJ6q/4qQZ610zOePBNOccWJuw9dzSimg==
X-Received: by 2002:a05:620a:2589:: with SMTP id x9mr10339128qko.454.1636690622582;
        Thu, 11 Nov 2021 20:17:02 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id v4sm2325597qkp.118.2021.11.11.20.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 20:17:02 -0800 (PST)
Date:   Thu, 11 Nov 2021 23:17:00 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH] btrfs: fix a out-of-boundary access for
 copy_compressed_data_to_page()
Message-ID: <YY3qvDNC6S/YVrkZ@localhost.localdomain>
References: <20211112022253.20576-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112022253.20576-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 12, 2021 at 10:22:53AM +0800, Qu Wenruo wrote:
> [BUG]
> The following script can cause btrfs to crash:
> 
>  mount -o compress-force=lzo $DEV /mnt
>  dd if=/dev/urandom of=/mnt/foo bs=4k count=1
>  sync
> 
> The calltrace looks like this:
> 
>  general protection fault, probably for non-canonical address 0xe04b37fccce3b000: 0000 [#1] PREEMPT SMP NOPTI
>  CPU: 5 PID: 164 Comm: kworker/u20:3 Not tainted 5.15.0-rc7-custom+ #4
>  Workqueue: btrfs-delalloc btrfs_work_helper [btrfs]
>  RIP: 0010:__memcpy+0x12/0x20
>  Call Trace:
>   lzo_compress_pages+0x236/0x540 [btrfs]
>   btrfs_compress_pages+0xaa/0xf0 [btrfs]
>   compress_file_range+0x431/0x8e0 [btrfs]
>   async_cow_start+0x12/0x30 [btrfs]
>   btrfs_work_helper+0xf6/0x3e0 [btrfs]
>   process_one_work+0x294/0x5d0
>   worker_thread+0x55/0x3c0
>   kthread+0x140/0x170
>   ret_from_fork+0x22/0x30
>  ---[ end trace 63c3c0f131e61982 ]---
> 
> [CAUSE]
> In lzo_compress_pages(), parameter @out_pages is not only an output
> parameter (for the compressed pages), but also an input parameter, for
> the maximum amount of pages we can utilize.
> 
> In commit d4088803f511 ("btrfs: subpage: make lzo_compress_pages()
> compatible"), the refactor doesn't take @out_pages as an input, thus
> completely ignoring the limit.
> 
> And for compress-force case, we could hit incompressible data that
> compressed size would go beyond the page limit, and cause above crash.
> 
> [FIX]
> Save @out_pages as @max_nr_page, and pass it to lzo_compress_pages(),
> and check if we're beyond the limit before accessing the pages.
> 
> Reported-by: Omar Sandoval <osandov@fb.com>
> Fixes: d4088803f511 ("btrfs: subpage: make lzo_compress_pages() compatible")
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/lzo.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/lzo.c b/fs/btrfs/lzo.c
> index 00cffc183ec0..f410ceabcdbd 100644
> --- a/fs/btrfs/lzo.c
> +++ b/fs/btrfs/lzo.c
> @@ -125,6 +125,7 @@ static inline size_t read_compress_length(const char *buf)
>  static int copy_compressed_data_to_page(char *compressed_data,
>  					size_t compressed_size,
>  					struct page **out_pages,
> +					unsigned long max_nr_page,

If you want to do const down below you should use const here probably?  Thanks,

Josef
