Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A6744E123
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Nov 2021 05:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbhKLE3n (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 23:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhKLE3n (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 23:29:43 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E96C061766
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Nov 2021 20:26:53 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id u17so7410874plg.9
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Nov 2021 20:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+fFPD8uOCbWH2ZUyqNRziJC+rbJrrR2gF9pxR11C66U=;
        b=Re2RDHdaOqydCEZW6+p9xdGhxfE64q/1CUZmYPjsFqVL30Pm6O80m5P1XqEH8+zDra
         01huHsj6qzqiF+MqVb26u2k2KMYl6VqG05RZei+RlNSUDY4KT8LC9u3F29wHt/NL21wP
         M1OBFyGjBQi26D9eXiMMrxjxRtEqEkvWW1lm1gKpADpZv/CJm8fvbflnSnjm55FFGhox
         +nwVKBX6TF9A5UIgtDrhJw7ZYY2SDUfQxFQMeliTdd8QsFi9lVYxUepO97IT2dQ+85jm
         fKIRUGz6Z2Dqcj3Pi8TsXE4XZmgtxq9QMUVga04utV50h9KO4Hqr1+LU+/rTGnFBN53N
         NV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+fFPD8uOCbWH2ZUyqNRziJC+rbJrrR2gF9pxR11C66U=;
        b=jsOp6Qj4b91QfGxn36nyP4CUziGGA3RGBKVauTp5eRylElL/9G00fo6Yb7c4zK052P
         w8A/+AwAkZAaah5dsLoaZzMw5k3lUfRft9AL3c58u5Bb1jjypLN0ZYYRXU9iQPLUC4nX
         MXjSyKEsspEVn9nEzevd8HQWpaWlO/9O4mB3PGSzxRemb96GO2Pi5BR/bqbGotnMy/oU
         Pu4+MlLnUMslz/XA/qAom8KSoi/xeY/ICHt3Cqr5Bdq1BOsHi3xaTBvR/O1EaJf+cqMo
         E9Nc2B6Yue7REPvfvuCBcGTzICOzsDHngd5+1owChHVqLwvSNkr0OSwbc9fd11vuvm2j
         0VsA==
X-Gm-Message-State: AOAM532Z3Pt5pkCDE6615P5Whrz9LgE2cqmhKO68FMlvXowqarL+lhlB
        ii56DXqO9gZ2dbyH2tcyiR6h6w==
X-Google-Smtp-Source: ABdhPJycpinosXmKtRo/Ml7pMpUYV/yno24RmUPC655ywHRggNK2O3ZrayZLt760A29VnOdYGjNd2g==
X-Received: by 2002:a17:90b:1947:: with SMTP id nk7mr14531280pjb.227.1636691212739;
        Thu, 11 Nov 2021 20:26:52 -0800 (PST)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:aa3b])
        by smtp.gmail.com with ESMTPSA id s30sm4697524pfg.17.2021.11.11.20.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 20:26:52 -0800 (PST)
Date:   Thu, 11 Nov 2021 20:26:51 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH] btrfs: fix a out-of-boundary access for
 copy_compressed_data_to_page()
Message-ID: <YY3tC8HBOApvh4mK@relinquished.localdomain>
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

This fixed the issue for me, and it looks correct.

Reviewed-by: Omar Sandoval <osandov@fb.com>
