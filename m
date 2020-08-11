Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6CE241FFA
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 20:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbgHKSxv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 14:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgHKSxv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 14:53:51 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBE6C06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 11:53:51 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id t23so10244763qto.3
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 11:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6zlBrYZygRKrTkvnhJiwdLTfgdqrAmRm+MbVWBUFn38=;
        b=W9BgBgSOiRBlDdS7Tp9ILvVHGIvbKB7reKWLYs2KzxfJfuRfnY6YIkrJkEQuO7Itkk
         /PUj9YqRGlyAR3L1F5dnTeSK0dJTDUzgtCZ3NXdsdKtzfIkcGS6++ufBH+1DB4fFggL4
         7O1hyS198nuKK1v3EQmxzMC0cbFq+UEPBkoPZpBauJChAJ1c9H8bexCCv1ZEms1kX3nD
         4H9gXVEGmKPxy0ComWXiDjebZrOjsMfaXduaCC1YUoHEYbZOr3o1/KfTrRXdGzlvd3Y9
         0yxwYQXp8zLJyEsSBxzV1cqardU5TU/uqIcpJfVpSZ+Tp2rsOcKwdrIAxTBhC6HgQGs6
         q5dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6zlBrYZygRKrTkvnhJiwdLTfgdqrAmRm+MbVWBUFn38=;
        b=a/uXVVUTXFHQEhIL2TEcXdELSp1EyCCdniCX9q7nb4eXW1DcJbpiE5HW4sytTywSGV
         W9bGa7mmKGWfnFqwPt1zU/bz+hF/8wmRH2+HEoexv9Agjz/7m5obymO3OcjITAnml+N9
         VkQ6EV9ZVJqvbn2nRrzF8S1ZDf3dMb87b5pv/t08C8xWmPXM4i0dgTnPOneXI1LHr0DC
         6zqPqGQ54d6nojyalALX34JUp8nNPCfBgJForhSmZZuZ7A5hnbgFu3+ujjXU5hPVyx93
         VSp2B6MbBYsbi1pvGXG63gcLYD9W8EbaOERYODcrFFzx398V8n7OyBMhHpzmQfnaH9MK
         Z9GQ==
X-Gm-Message-State: AOAM5338wpOo2NGLIABPLQrLAH9gmH+tWJp6gqljIRPkllumqPyinumd
        4qN4ZmROlcLp2vxfgtShiRDyaQ==
X-Google-Smtp-Source: ABdhPJx5DA8BK3xEgIOf2mMLcrJOWgo2UHT0fZ21GnmyhoGnFAQwhrXkWoWsVTJkqoPiEsdECp3gbA==
X-Received: by 2002:ac8:6647:: with SMTP id j7mr2510941qtp.335.1597172030335;
        Tue, 11 Aug 2020 11:53:50 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 142sm18175140qki.130.2020.08.11.11.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 11:53:49 -0700 (PDT)
Subject: Re: [PATCH v3 5/5] btrfs: ctree: Checking key orders before merged
 tree blocks
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
References: <20200809120919.85271-1-wqu@suse.com>
 <20200809120919.85271-6-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <ff8fc934-2fc1-91af-84f0-ea50382fe6e2@toxicpanda.com>
Date:   Tue, 11 Aug 2020 14:53:48 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200809120919.85271-6-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/9/20 8:09 AM, Qu Wenruo wrote:
> [BUG]
> With crafted image, btrfs can panic at btrfs_del_csums().
>    kernel BUG at fs/btrfs/ctree.c:3188!
>    invalid opcode: 0000 [#1] SMP PTI
>    CPU: 0 PID: 1156 Comm: btrfs-transacti Not tainted 5.0.0-rc8+ #9
>    RIP: 0010:btrfs_set_item_key_safe+0x16c/0x180
>    Code: b7 48 8d 7d bf 4c 89 fe 48 89 45 c8 0f b6 45 b6 88 45 c7 48 8b 45 ae 48 89 45 bf e8 ce f2 ff ff 85 c0 0f 8f 48 ff ff ff 0f 0b <0f> 0b e8 dd 8d be ff 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 66 66
>    RSP: 0018:ffff976141257ab8 EFLAGS: 00010202
>    RAX: 0000000000000001 RBX: ffff898a6b890930 RCX: 0000000004b70000
>    RDX: 0000000000000000 RSI: ffff976141257bae RDI: ffff976141257acf
>    RBP: ffff976141257b10 R08: 0000000000001000 R09: ffff9761412579a8
>    R10: 0000000000000000 R11: 0000000000000000 R12: ffff976141257abe
>    R13: 0000000000000003 R14: ffff898a6a8be578 R15: ffff976141257bae
>    FS: 0000000000000000(0000) GS:ffff898a77a00000(0000) knlGS:0000000000000000
>    CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: 00007f779d9cd624 CR3: 000000022b2b4006 CR4: 00000000000206f0
>    Call Trace:
>    truncate_one_csum+0xac/0xf0
>    btrfs_del_csums+0x24f/0x3a0
>    __btrfs_free_extent.isra.72+0x5a7/0xbe0
>    __btrfs_run_delayed_refs+0x539/0x1120
>    btrfs_run_delayed_refs+0xdb/0x1b0
>    btrfs_commit_transaction+0x52/0x950
>    ? start_transaction+0x94/0x450
>    transaction_kthread+0x163/0x190
>    kthread+0x105/0x140
>    ? btrfs_cleanup_transaction+0x560/0x560
>    ? kthread_destroy_worker+0x50/0x50
>    ret_from_fork+0x35/0x40
>    Modules linked in:
>    ---[ end trace 93bf9db00e6c374e ]---
> 
> [CAUSE]
> This crafted image has a very tricky key order corruption:
> 
>    checksum tree key (CSUM_TREE ROOT_ITEM 0)
>    node 29741056 level 1 items 14 free 107 generation 19 owner CSUM_TREE
>            ...
>            key (EXTENT_CSUM EXTENT_CSUM 73785344) block 29757440 gen 19
>            key (EXTENT_CSUM EXTENT_CSUM 77594624) block 29753344 gen 19
>            ...
> 
>    leaf 29757440 items 5 free space 150 generation 19 owner CSUM_TREE
>            item 0 key (EXTENT_CSUM EXTENT_CSUM 73785344) itemoff 2323 itemsize 1672
>                    range start 73785344 end 75497472 length 1712128
>            item 1 key (EXTENT_CSUM EXTENT_CSUM 75497472) itemoff 2319 itemsize 4
>                    range start 75497472 end 75501568 length 4096
>            item 2 key (EXTENT_CSUM EXTENT_CSUM 75501568) itemoff 579 itemsize 1740
>                    range start 75501568 end 77283328 length 1781760
>            item 3 key (EXTENT_CSUM EXTENT_CSUM 77283328) itemoff 575 itemsize 4
>                    range start 77283328 end 77287424 length 4096
>            item 4 key (EXTENT_CSUM EXTENT_CSUM 4120596480) itemoff 275 itemsize 300 <<<
>                    range start 4120596480 end 4120903680 length 307200
>    leaf 29753344 items 3 free space 1936 generation 19 owner CSUM_TREE
>            item 0 key (18446744073457893366 EXTENT_CSUM 77594624) itemoff 2323 itemsize 1672
>                    range start 77594624 end 79306752 length 1712128
>            ...
> 
> Note the item 4 key of leaf 29757440, which is obviously too large, and
> even larger than the first key of the next leaf.
> 
> However it still follows the key order in that tree block, thus tree
> checker is unable to detect it at read time, since tree checker can only
> work inside a leaf, thus such complex corruption can't be rejected in
> advance.
> 
> [FIX]
> The next timing to detect such problem is at tree block merge time,
> which is in push_node_left(), balance_node_right(), push_leaf_left() and
> push_leaf_right().
> 
> Now we check if the key order of the right most key of the left node is
> larger than the left most key of the right node.
> 
> By this we don't need to call the full tree-check, while still keeps the
> key order correct as key order in each node is already checked by tree
> checker thus we only need to check the above two slots.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=202833
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
