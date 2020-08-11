Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63397242003
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 20:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgHKS5v (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 14:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgHKS5v (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 14:57:51 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD5DC06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 11:57:51 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e5so10249705qth.5
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 11:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+jSjoQE3Skv/8LtjokMdK38esqqQRCGlXKR/ThOkq0g=;
        b=mcutOqsaB3KP/vCRm6MQ2lG7bLqilDUp4aKBr7SR20U8sVG3hp8oM9dwA6Z/oq4oMA
         eFiKjehS+0OrzuBrx0NvfFZEx7SX3zYwvTTfe+pWw5wH1K8f4CsY9k45w7+Q1DBZ+zYy
         2okVDPnDoVPrDLRii2gy/T8bO2H3PnR7KMLGxohf18LPT4vwAtXrnjlFNff10afzQsRl
         VXs08Q1MfCsumvpFzceUd7j/+aGmKPwzPE8fh5dOBIbhAA7G6dOJNsOL9fec75Y3JXtD
         aCMSIsE5+RMpMQwJz6iwyU7EML2mTPhYpaxJW/W9Ff0nV8eiEi+Oa+jQl+PZyih35mxz
         vj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+jSjoQE3Skv/8LtjokMdK38esqqQRCGlXKR/ThOkq0g=;
        b=OHOAQczg4sZwvqPR3HqnVN6u4VWuMKjuZKfMkBGMBqvTS769146azEO8PBmFawGVbA
         2+3Uz6DK3uaeggGeVDLeoX74ZrwSF7FznVj8v2P/FGaaptEUjFGmMCtqrUpZO87QahPx
         xJ+AvPNE5Nro7wiSozTmbew/ujbvvGhUii+F/B/pdCEPNwQIwymcNEhciVSXyC6H4bt5
         Wh+WC3ve/YZ2PxlYQXqv8nvhkv5VqtMLkSogF75Rqjzm+KjwODjqfRmpIdD+bUBYzSLu
         IMwU4c9c3nAzkJvUOWhEf0rhcN1dAW9uLwWAvqWOZ3zOp610ixfClD8FkWSa/D7oGO/e
         Q4Og==
X-Gm-Message-State: AOAM531pf1QiaU0yzmR83BOh9rDBLYWE/snLY9TyVz0wpBp5ZdOKVfY4
        QkZC4gXxdPEdI/cjATBkLq6O2LcAzC6TtA==
X-Google-Smtp-Source: ABdhPJykB8XX/uIeSRW8mjCIsa3EzrBW2PoiYngdf6m8BIRKU84yOk9Rre2oMsSY8cz6WdqJT6SJrQ==
X-Received: by 2002:ac8:72cc:: with SMTP id o12mr2559383qtp.27.1597172269965;
        Tue, 11 Aug 2020 11:57:49 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 8sm16875607qkh.77.2020.08.11.11.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 11:57:49 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] btrfs: prevent NULL pointer dereference in
 compress_file_range() when btrfs_compress_pages() hits default case
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20200804072548.34001-1-wqu@suse.com>
 <20200804072548.34001-2-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <f0975777-0f51-58ea-6476-f7d34666204d@toxicpanda.com>
Date:   Tue, 11 Aug 2020 14:57:48 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200804072548.34001-2-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/4/20 3:25 AM, Qu Wenruo wrote:
> [BUG]
> When running btrfs/071 with inode_need_compress() removed from
> compress_file_range(), we got the following crash:
> 
>    BUG: kernel NULL pointer dereference, address: 0000000000000018
>    #PF: supervisor read access in kernel mode
>    #PF: error_code(0x0000) - not-present page
>    Workqueue: btrfs-delalloc btrfs_work_helper [btrfs]
>    RIP: 0010:compress_file_range+0x476/0x7b0 [btrfs]
>    Call Trace:
>     ? submit_compressed_extents+0x450/0x450 [btrfs]
>     async_cow_start+0x16/0x40 [btrfs]
>     btrfs_work_helper+0xf2/0x3e0 [btrfs]
>     process_one_work+0x278/0x5e0
>     worker_thread+0x55/0x400
>     ? process_one_work+0x5e0/0x5e0
>     kthread+0x168/0x190
>     ? kthread_create_worker_on_cpu+0x70/0x70
>     ret_from_fork+0x22/0x30
>    ---[ end trace 65faf4eae941fa7d ]---
> 
> This is already after the patch "btrfs: inode: fix NULL pointer
> dereference if inode doesn't need compression."
> 
> [CAUSE]
> @pages is firstly created by kcalloc() in compress_file_extent():
>                  pages = kcalloc(nr_pages, sizeof(struct page *), GFP_NOFS);
> 
> Then passed to btrfs_compress_pages() to be utilized there:
> 
>                  ret = btrfs_compress_pages(...
>                                             pages,
>                                             &nr_pages,
>                                             ...);
> 
> btrfs_compress_pages() will initial each pages as output, in
> zlib_compress_pages() we have:
> 
>                          pages[nr_pages] = out_page;
>                          nr_pages++;
> 
> Normally this is completely fine, but there is a special case which
> is in btrfs_compress_pages() itself:
>          switch (type) {
>          default:
>                  return -E2BIG;
>          }
> 
> In this case, we didn't modify @pages nor @out_pages, leaving them
> untouched, then when we cleanup pages, the we can hit NULL pointer
> dereference again:
> 
>          if (pages) {
>                  for (i = 0; i < nr_pages; i++) {
>                          WARN_ON(pages[i]->mapping);
>                          put_page(pages[i]);
>                  }
>          ...
>          }
> 
> Since pages[i] are all initialized to zero, and btrfs_compress_pages()
> doesn't change them at all, accessing pages[i]->mapping would lead to
> NULL pointer dereference.
> 
> This is not possible for current kernel, as we check
> inode_need_compress() before doing pages allocation.
> But if we're going to remove that inode_need_compress() in
> compress_file_extent(), then it's going to be a problem.
> 
> [FIX]
> When btrfs_compress_pages() hits its default case, modify @out_pages to
> 0 to prevent such problem from happening.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
