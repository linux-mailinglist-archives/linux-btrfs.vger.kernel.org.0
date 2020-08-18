Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33DCA2489D9
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Aug 2020 17:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgHRP2b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Aug 2020 11:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbgHRP23 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Aug 2020 11:28:29 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29552C061389
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Aug 2020 08:28:29 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 2so18566846qkf.10
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Aug 2020 08:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=w/V9e/RzjpWXQF4QsNQwHsfSAZ/rzAOz3dnOrTdo2IU=;
        b=bdU4EJfRJVIdfU0aeQPPDfwMqHgIZgcgw2LemDWCnCmLb2s4AUwzEDYdoRf9S1QI3r
         CS31y6RC3UX9yRn7lA6x2u0Yirl2SoQ/FG6ZYnS0cTG2ApcRTyQPvglk0mSx7ePn0OjG
         vlQZIB+4P98c+k/AnEu/l3F3SQ+wZdON9o9Bx2HdWSVIlySmGDl/P7ik6qZ6hYw+8iV7
         kW3xXgoUcAFjrE3MJEkCqkQA5iAzBMsRrF3ko5C/es+/P6oXBjMgJH/O7kDgGT/iqeAl
         McbzwYARsA6qoFz6oP7ikOjf6JK1gb7qmkuuRmah8SqUdNOKqUeAXbzo7wUx1IKBh6TO
         5d0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w/V9e/RzjpWXQF4QsNQwHsfSAZ/rzAOz3dnOrTdo2IU=;
        b=n3fcpjAy9iv0h46ntVAIRBGUoYKKvyR0LYS7ISqm2y2OFQEy/yEuD+6/0qjYZP8FWG
         +ExnLw+RVMr0NahzWqoO9Z8RYNiCU18xvsNhRCE308xuFfRHqk1TQ6MVphxTatTeYaiX
         FInpwspyFfOzmkac7YsFeSxmXRBTcJ+WUsRHwIMQi9ENatz773zxThm9xB1UJ9wAxohK
         3l96cUua7N3JfO7TiyFXarxtscz+XJiRw5zFnQHyRzNnY7SKdAczQ5VkirZUB63XLakY
         TYXL6W28FBNJcQes2q0HGL/imQsp3G6HOyE4xyAlX4AR0hcOL9rbln8skMJQDHK5kCCb
         rRiQ==
X-Gm-Message-State: AOAM530Qn4nYGGRGsmTIab/3SCODCUI4Km7bH79/5m1zlBsO3c3rHGS7
        IPJ+avOGvquVCzngRgyAGOf1g6iOCUo0H4XP
X-Google-Smtp-Source: ABdhPJxT+7ppxzZ8m/UL2yj+GYnk+fVmqc8boc1GbX02TkHEUNdagYCn0m0HCbkwqQxuZk8tinDJUg==
X-Received: by 2002:a37:714:: with SMTP id 20mr18198507qkh.367.1597764508029;
        Tue, 18 Aug 2020 08:28:28 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::1055? ([2620:10d:c091:480::1:66f8])
        by smtp.gmail.com with ESMTPSA id d143sm20451161qkc.59.2020.08.18.08.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 08:28:27 -0700 (PDT)
Subject: Re: [PATCH] btrfs: fix space cache memory leak after transaction
 abort
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200814100409.633527-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <fbad9fe8-8972-4418-9a3e-53efc03fba86@toxicpanda.com>
Date:   Tue, 18 Aug 2020 11:28:25 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200814100409.633527-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/14/20 6:04 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If a transaction aborts it can cause a memory leak of the pages array of
> a block group's io_ctl structure. The following steps explain how that can
> happen:
> 
> 1) Transaction N is committing, currently in state TRANS_STATE_UNBLOCKED
>     and it's about to start writing out dirty extent buffers;
> 
> 2) Transaction N + 1 already started and another task, task A, just called
>     btrfs_commit_transaction() on it;
> 
> 3) Block group B was dirtied (extents allocated from it) by transaction
>     N + 1, so when task A calls btrfs_start_dirty_block_groups(), at the
>     very beginning of the transaction commit, it starts writeback for the
>     block group's space cache by calling btrfs_write_out_cache(), which
>     allocates the pages array for the block group's io_ctl with a call to
>     io_ctl_init(). Block group A is added to the io_list of transaction
>     N + 1 by btrfs_start_dirty_block_groups();
> 
> 4) While transaction N's commit is writing out the extent buffers, it gets
>     an IO error and aborts transaction N, also setting the file system to
>     RO mode;
> 
> 5) Task A has already returned from btrfs_start_dirty_block_groups(), is at
>     btrfs_commit_transaction() and has set transaction N + 1 state to
>     TRANS_STATE_COMMIT_START. Immediately after that it checks that the
>     filesystem was turned to RO mode, due to transaction N's abort, and
>     jumps to the "cleanup_transaction" label. After that we end up at
>     btrfs_cleanup_one_transaction() which calls btrfs_cleanup_dirty_bgs().
>     That helper finds block group B in the transaction's io_list but it
>     never releases the pages array of the block group's io_ctl, resulting in
>     a memory leak.
> 
> In fact at the point when we are at btrfs_cleanup_dirty_bgs(), the pages
> array points to pages that were already released by us at
> __btrfs_write_out_cache() through the call to io_ctl_drop_pages(). We end
> up freeing the pages array only after waiting for the ordered extent to
> complete through btrfs_wait_cache_io(), which calls io_ctl_free() to do
> that. But in the transaction abort case we don't wait for the space cache's
> ordered extent to complete through a call to btrfs_wait_cache_io(), so
> that's why we end up with a memory leak - we wait for the ordered extent
> to complete indirectly by shutting down the work queues and waiting for
> any jobs in them to complete before returning from close_ctree().
> 
> We can solve the leak simply by freeing the pages array right after
> releasing the pages (with the call to io_ctl_drop_pages()) at
> __btrfs_write_out_cache(), since we will never use it anymore after that
> and the pages array points to already released pages at that point, which
> is currently not a problem since no one will use it after that, but not a
> good practice anyway since it can easily lead to use-after-free issues.
> 
> So fix this by freeing the pages array right after releasing the pages at
> __btrfs_write_out_cache().
> 
> This issue can often be reproduced with test case generic/475 from fstests
> and kmemleak can detect it and reports it with the following trace:
> 
> unreferenced object 0xffff9bbf009fa600 (size 512):
>    comm "fsstress", pid 38807, jiffies 4298504428 (age 22.028s)
>    hex dump (first 32 bytes):
>      00 a0 7c 4d 3d ed ff ff 40 a0 7c 4d 3d ed ff ff  ..|M=...@.|M=...
>      80 a0 7c 4d 3d ed ff ff c0 a0 7c 4d 3d ed ff ff  ..|M=.....|M=...
>    backtrace:
>      [<00000000f4b5cfe2>] __kmalloc+0x1a8/0x3e0
>      [<0000000028665e7f>] io_ctl_init+0xa7/0x120 [btrfs]
>      [<00000000a1f95b2d>] __btrfs_write_out_cache+0x86/0x4a0 [btrfs]
>      [<00000000207ea1b0>] btrfs_write_out_cache+0x7f/0xf0 [btrfs]
>      [<00000000af21f534>] btrfs_start_dirty_block_groups+0x27b/0x580 [btrfs]
>      [<00000000c3c23d44>] btrfs_commit_transaction+0xa6f/0xe70 [btrfs]
>      [<000000009588930c>] create_subvol+0x581/0x9a0 [btrfs]
>      [<000000009ef2fd7f>] btrfs_mksubvol+0x3fb/0x4a0 [btrfs]
>      [<00000000474e5187>] __btrfs_ioctl_snap_create+0x119/0x1a0 [btrfs]
>      [<00000000708ee349>] btrfs_ioctl_snap_create_v2+0xb0/0xf0 [btrfs]
>      [<00000000ea60106f>] btrfs_ioctl+0x12c/0x3130 [btrfs]
>      [<000000005c923d6d>] __x64_sys_ioctl+0x83/0xb0
>      [<0000000043ace2c9>] do_syscall_64+0x33/0x80
>      [<00000000904efbce>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
