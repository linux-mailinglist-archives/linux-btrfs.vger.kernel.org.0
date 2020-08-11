Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CF1241FF4
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 20:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgHKSu1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 14:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgHKSu0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 14:50:26 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FA5C06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 11:50:26 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n129so6956594qkd.6
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 11:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EeiLjo5uPY07ONbuMiAQmSu356MqxnrDRhDe87wnJlk=;
        b=vMoabIWHmuzev9stDZI26wTHGumBj57BWLJhC9KssRk5uwh8uQVoHy4C4BFz8ErDZ9
         3wKCHVqi/mfL5GtanK33S1taCZdEVSku0/QWvk4ZCgRxYPJ9vsykXpMjal3IqBkp6ID4
         hOyOHpsrnp+bxCNppPRlGJQ9C50sNyHCVGbgWss2kWx9JmKN6Y9EsaXNQE/5b+hK+zzh
         8Y54HK5vUc+FicMcEcXidqc1lKQD4OEvDRki337mgdde3tncZ0QF/30LzNaGe9f33wiC
         2MDwUIVLb6tL0TXE72H3iuRc7WKXqND9TmdePPmb5QLjXz0yJy7kX5ygC8zLnEbESaEF
         afPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EeiLjo5uPY07ONbuMiAQmSu356MqxnrDRhDe87wnJlk=;
        b=CwEsgM2IdWV+T03dVHL9C4SnZzxAVzIjTVmmYogunWQlKm4OgJYpCioOYjNlrJo6F4
         TR7Ydpc6yy6Br9nP+zMHRn1f0cGlOucIdRz+4Z9m3ahsd0juVywndn0B+nWL/6pAQTrS
         KWzHhPz3VSAgLb6JlSDusdLSUtlJOz2ZM79xAgxVGX7rF/6jxngPldtvaAq2/My+++RE
         pHQoebQH5hjn6fuMpqqBb5kxYc3pNGsvdUvlOXwCydJ+0ynP2RxuhlaIJzrKGfmw2qBu
         BFcYHl2wR6hCVtfj5n8CA4a/V2KdA41gvlaapgATsmVN68xcPF8UoydALyyIdkCA4R6G
         4zPA==
X-Gm-Message-State: AOAM530JOJRAsuBFAGWBslg7oyORKiolwYWnE1xRny6HLrR4eroBClju
        opqm8LQixQQSfIDaaC73U3o3iKxO029t6w==
X-Google-Smtp-Source: ABdhPJyPdKrZcHnVIAW/tdEU+y+8jiSBMkxLm73kNO2aoRGKmr4tfOaiDMnN5vhM56fFeI6Qj0wqFA==
X-Received: by 2002:a05:620a:12c7:: with SMTP id e7mr2395540qkl.433.1597171825813;
        Tue, 11 Aug 2020 11:50:25 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id s30sm20695650qtc.87.2020.08.11.11.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 11:50:25 -0700 (PDT)
Subject: Re: [PATCH v3 4/5] btrfs: extent-tree: Kill the BUG_ON() in
 insert_inline_extent_backref()
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
References: <20200809120919.85271-1-wqu@suse.com>
 <20200809120919.85271-5-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <205aa33a-f512-2b94-3066-a05169541d9d@toxicpanda.com>
Date:   Tue, 11 Aug 2020 14:50:24 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200809120919.85271-5-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/9/20 8:09 AM, Qu Wenruo wrote:
> [BUG]
> With crafted image, btrfs can panic at insert_inline_extent_backref():
>    kernel BUG at fs/btrfs/extent-tree.c:1857!
>    invalid opcode: 0000 [#1] SMP PTI
>    CPU: 0 PID: 1117 Comm: btrfs-transacti Not tainted 5.0.0-rc8+ #9
>    RIP: 0010:insert_inline_extent_backref+0xcc/0xe0
>    Code: 45 20 49 8b 7e 50 49 89 d8 4c 8b 4d 10 48 8b 55 c8 4c 89 e1 41 57 4c 89 ee 50 ff 75 18 e8 cc bf ff ff 31 c0 48 83 c4 18 eb b2 <0f> 0b e8 9d df bd ff 0f 1f 00 66 2e 0f 1f 84 00 00 00 00 00 66 66
>    RSP: 0018:ffffac4dc1287be8 EFLAGS: 00010293
>    RAX: 0000000000000000 RBX: 0000000000000007 RCX: 0000000000000001
>    RDX: 0000000000001000 RSI: 0000000000000000 RDI: 0000000000000000
>    RBP: ffffac4dc1287c28 R08: ffffac4dc1287ab8 R09: ffffac4dc1287ac0
>    R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>    R13: ffff8febef88a540 R14: ffff8febeaa7bc30 R15: 0000000000000000
>    FS: 0000000000000000(0000) GS:ffff8febf7a00000(0000) knlGS:0000000000000000
>    CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: 00007f663ace94c0 CR3: 0000000235698006 CR4: 00000000000206f0
>    Call Trace:
>    ? _cond_resched+0x1a/0x50
>    __btrfs_inc_extent_ref.isra.64+0x7e/0x240
>    ? btrfs_merge_delayed_refs+0xa5/0x330
>    __btrfs_run_delayed_refs+0x653/0x1120
>    btrfs_run_delayed_refs+0xdb/0x1b0
>    btrfs_commit_transaction+0x52/0x950
>    ? start_transaction+0x94/0x450
>    transaction_kthread+0x163/0x190
>    kthread+0x105/0x140
>    ? btrfs_cleanup_transaction+0x560/0x560
>    ? kthread_destroy_worker+0x50/0x50
>    ret_from_fork+0x35/0x40
>    Modules linked in:
>    ---[ end trace 2ad8b3de903cf825 ]---
> 
> [CAUSE]
> Due to extent tree corruption (still valid by itself, but bad cross ref),
> we can allocate an extent which is still in extent tree.
> The offending tree block of that case is from csum tree.
> The newly allocated tree block is also for csum tree.
> 
> Then we will try to insert an tree block ref for the existing tree block
> ref.
> 
> For btrfs tree extent item, a tree block can never be shared directly by
> the same tree twice.
> We have such BUG_ON() to prevent such problem, but BUG_ON() is
> definitely not good enough.
> 
> [FIX]
> Replace that BUG_ON() with proper error message and leaf dump for debug
> build.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=202829
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Reviewed-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
