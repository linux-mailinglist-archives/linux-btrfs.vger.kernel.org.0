Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798E344E8D8
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Nov 2021 15:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbhKLOcV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Nov 2021 09:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbhKLOcR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Nov 2021 09:32:17 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173E7C06127A
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Nov 2021 06:29:27 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id t83so6817137qke.8
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Nov 2021 06:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=js+eO7e6Ors63adwX4is2m/gBzZjMrm1jOkjQWk2q2Q=;
        b=NxTq+FuqiBxdwcFMUJL0nLXYP34sk7mriNmffiY/tLhINRCa20ROjoIj2IIrZlgR+W
         GjVKJdLCrmG8ppK3bsxgWRQ5IIO9+/ksLoYuctXxT2zmctJwXVy/JGWMkpUkHrJlz1Ko
         PvV8090BTXPQtLJeP9KkCcSAi4bGDL5qkElAKKaIwW5D2uwHLQFfQv8qDpaYVXM5csNs
         iVak8uByicotu/JdzTZYjZ31i8GAVyAHCcVweSJIcxK3YGpadeGwtPELOQJiR42kjeP1
         DpuXLTGIZaNTG3HuWEHE7cEfiIoytp1pbUKu/khLVFdnZrMVnF3LcPQ/nHFVIi40t6yz
         u6Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=js+eO7e6Ors63adwX4is2m/gBzZjMrm1jOkjQWk2q2Q=;
        b=SUhsNC/DSuwQB4s2cCbgHzqF6lDRrcvKYMjVzLB+EVgRPz5OxVa2aaT6DBuwX0Vy2U
         Sszr8yUtnZSva6SobKe1n2fBmjKDkr/vzjpik9P8MGY3czGYoMuD+NqYUeuRywqzzVia
         ZVPcMyrtRlgKIV6z/GXaLZQ7G7GP5fZxYGoLGzm/It9Zizos2Ps029zsXSKTegM5tHbg
         uRKI3gRd+gEXaQVy3pXkk6Xpnbr5FI7GM1IZNGozPGPH2P2TPXrYhTmkZq9gtMPCDYrr
         AXQ2R0P9M0WWf9bg33ipV8Qod5bKy2NG2iMnpu3vo6yuj6UFB8ODurA/Dn1peNlKp/tR
         lYEQ==
X-Gm-Message-State: AOAM5306tXlcniHdY556yV6EuUTcffcPNQKs3FrNtLRzB65/IRmMFgG/
        z3LA+xslc7dTTRgoeQtIZLI6nA==
X-Google-Smtp-Source: ABdhPJwulV3UGhGC73oRsVlQceiYILmLj9Lh10TsIyLJL4+oXo49SdKKShCl0An1UjA4P+vTb6t2Pw==
X-Received: by 2002:a37:8946:: with SMTP id l67mr12935920qkd.519.1636727366077;
        Fri, 12 Nov 2021 06:29:26 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id l2sm3190445qtk.41.2021.11.12.06.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 06:29:25 -0800 (PST)
Date:   Fri, 12 Nov 2021 09:29:24 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org, Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH v2] btrfs: fix a out-of-boundary access for
 copy_compressed_data_to_page()
Message-ID: <YY56RGjmRFVDvaT4@localhost.localdomain>
References: <20211112044730.25161-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211112044730.25161-1-wqu@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Nov 12, 2021 at 12:47:30PM +0800, Qu Wenruo wrote:
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
> parameter (for the number of compressed pages), but also an input
> parameter, as the upper limit of compressed pages we can utilize.
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
> Reviewed-by: Omar Sandoval <osandov@fb.com>
> 

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
