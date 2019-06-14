Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD2D945F30
	for <lists+linux-btrfs@lfdr.de>; Fri, 14 Jun 2019 15:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbfFNNtA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 14 Jun 2019 09:49:00 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35371 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbfFNNs7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 14 Jun 2019 09:48:59 -0400
Received: by mail-qt1-f193.google.com with SMTP id d23so2519549qto.2
        for <linux-btrfs@vger.kernel.org>; Fri, 14 Jun 2019 06:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3vLfyiqRUkXZUsAV0iIyqHmGnWOma05/FT7nB53fGO4=;
        b=X5T/IQ42Rw/TYJOtDwczmS/r4/vXC6WSn5Sbjg+XQgW4XuBh5Ug4oluDQlImwQLSX+
         MS4m1CETGtD1o+Iqc1JKAbn1egr9P1BRpmzHODTWItUKIKJmqGdKGOaYUYMmYKq4FY46
         BtK0kPxbUPNajiyd6oH6quYiYVsFlJt9OjHdSrTJzziw4oE3Xqtug3LI42YtW+bMh7dj
         gFzgJU/JPW3A5XDZ06Ll3utuN8CKlnZy8yFoxA3xs2adLn1TJkqroF2iUM1lWb+Eghwz
         r1ZN5Hl6ubobMhI7WwKRKDalIHZ3J12RheT28lJ8T1zWAwgV/rv2L4AhcZrLg6VQpWZf
         0Mrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3vLfyiqRUkXZUsAV0iIyqHmGnWOma05/FT7nB53fGO4=;
        b=ZZN3b0EavqSEaKhqqS6e/P2Z5F7JyR/2s1Zo2TJIP5WnHT0QHAILTxDgPR3WrbXf9P
         Ux8E/Ura7jLMei/BdGEKyF7jXEGUtwo2922gFKqi5QcxfW0OaN6/VIAt1/v+zZIjwetc
         830A4ihBYAqqfqfEfHT+kkYC+uJwRE+GLYGntt/vnc24cirbYpB7nF8x9S7hn/lFQZQn
         1ea/qWh9tIvZgxzXgACNPEB1guiBZyctPCaDPQD4kHlYGkIjG8ASIt7uPrEyC7fSQ/99
         RiEb2p2M475Q4eOEBCw5XrQvs0Vkz3U7GyCW7u73IVi+llHW0vYv0dzkVBcmeDxBufu7
         0VXA==
X-Gm-Message-State: APjAAAUzsGjw/9VlSZ+MUCE2nkIuRVpVW1VGfa9/SghEmGWPCVh36uFA
        pevabExfKGxhMPkUbtTEIXl1sA==
X-Google-Smtp-Source: APXvYqxXpZ8x6G9q3jVBsULkNrXCbgEf+i5HLKC/qRz+XuuUrdKpecvnVK3M5VtWu0Lwi5MSEjw9+g==
X-Received: by 2002:ac8:2c33:: with SMTP id d48mr82416237qta.40.1560520138294;
        Fri, 14 Jun 2019 06:48:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::a658])
        by smtp.gmail.com with ESMTPSA id 41sm2004456qtp.32.2019.06.14.06.48.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 06:48:58 -0700 (PDT)
Date:   Fri, 14 Jun 2019 09:48:56 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     dsterba@suse.com, clm@fb.com, josef@toxicpanda.com,
        axboe@kernel.dk, jack@suse.cz, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 6/8] Btrfs: only associate the locked page with one
 async_cow struct
Message-ID: <20190614134856.jnjw4p3lfcqhrmmj@MacBook-Pro-91.local>
References: <20190614003350.1178444-1-tj@kernel.org>
 <20190614003350.1178444-7-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614003350.1178444-7-tj@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 13, 2019 at 05:33:48PM -0700, Tejun Heo wrote:
> From: Chris Mason <clm@fb.com>
> 
> The btrfs writepages function collects a large range of pages flagged
> for delayed allocation, and then sends them down through the COW code
> for processing.  When compression is on, we allocate one async_cow
> structure for every 512K, and then run those pages through the
> compression code for IO submission.
> 
> writepages starts all of this off with a single page, locked by
> the original call to extent_write_cache_pages(), and it's important to
> keep track of this page because it has already been through
> clear_page_dirty_for_io().
> 
> The btrfs async_cow struct has a pointer to the locked_page, and when
> we're redirtying the page because compression had to fallback to
> uncompressed IO, we use page->index to decide if a given async_cow
> struct really owns that page.
> 
> But, this is racey.  If a given delalloc range is broken up into two
> async_cows (cow_A and cow_B), we can end up with something like this:
> 
> compress_file_range(cowA)
> submit_compress_extents(cowA)
> submit compressed bios(cowA)
> put_page(locked_page)
> 
> 				compress_file_range(cowB)
> 				...
> 
> The end result is that cowA is completed and cleaned up before cowB even
> starts processing.  This means we can free locked_page() and reuse it
> elsewhere.  If we get really lucky, it'll have the same page->index in
> its new home as it did before.
> 
> While we're processing cowB, we might decide we need to fall back to
> uncompressed IO, and so compress_file_range() will call
> __set_page_dirty_nobufers() on cowB->locked_page.
> 
> Without cgroups in use, this creates as a phantom dirty page, which
> isn't great but isn't the end of the world.  With cgroups in use, we
> might crash in the accounting code because page->mapping->i_wb isn't
> set.
> 
> [ 8308.523110] BUG: unable to handle kernel NULL pointer dereference at 00000000000000d0
> [ 8308.531084] IP: percpu_counter_add_batch+0x11/0x70
> [ 8308.538371] PGD 66534e067 P4D 66534e067 PUD 66534f067 PMD 0
> [ 8308.541750] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC
> [ 8308.551948] CPU: 16 PID: 2172 Comm: rm Not tainted
> [ 8308.566883] RIP: 0010:percpu_counter_add_batch+0x11/0x70
> [ 8308.567891] RSP: 0018:ffffc9000a97bbe0 EFLAGS: 00010286
> [ 8308.568986] RAX: 0000000000000005 RBX: 0000000000000090 RCX: 0000000000026115
> [ 8308.570734] RDX: 0000000000000030 RSI: ffffffffffffffff RDI: 0000000000000090
> [ 8308.572543] RBP: 0000000000000000 R08: fffffffffffffff5 R09: 0000000000000000
> [ 8308.573856] R10: 00000000000260c0 R11: ffff881037fc26c0 R12: ffffffffffffffff
> [ 8308.580099] R13: ffff880fe4111548 R14: ffffc9000a97bc90 R15: 0000000000000001
> [ 8308.582520] FS:  00007f5503ced480(0000) GS:ffff880ff7200000(0000) knlGS:0000000000000000
> [ 8308.585440] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 8308.587951] CR2: 00000000000000d0 CR3: 00000001e0459005 CR4: 0000000000360ee0
> [ 8308.590707] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 8308.592865] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 8308.594469] Call Trace:
> [ 8308.595149]  account_page_cleaned+0x15b/0x1f0
> [ 8308.596340]  __cancel_dirty_page+0x146/0x200
> [ 8308.599395]  truncate_cleanup_page+0x92/0xb0
> [ 8308.600480]  truncate_inode_pages_range+0x202/0x7d0
> [ 8308.617392]  btrfs_evict_inode+0x92/0x5a0
> [ 8308.619108]  evict+0xc1/0x190
> [ 8308.620023]  do_unlinkat+0x176/0x280
> [ 8308.621202]  do_syscall_64+0x63/0x1a0
> [ 8308.623451]  entry_SYSCALL_64_after_hwframe+0x42/0xb7
> 
> The fix here is to make asyc_cow->locked_page NULL everywhere but the
> one async_cow struct that's allowed to do things to the locked page.
> 
> Signed-off-by: Chris Mason <clm@fb.com>
> Fixes: 771ed689d2cd ("Btrfs: Optimize compressed writeback and reads")
> ---

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
