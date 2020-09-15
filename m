Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D4D26ACC3
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Sep 2020 20:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgIOS7D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Sep 2020 14:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727870AbgIOROf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Sep 2020 13:14:35 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E72C061351
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Sep 2020 10:13:44 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id v123so4991750qkd.9
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Sep 2020 10:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bxtUcWgwjk6d+Vyf4IeL1p3XTo2R7i++ELRnxJVt1+Y=;
        b=g15QBih4o52qKnXVi+Uj2e1jVpWIhCN4SNm6zS6n5jdI2nk5ZCrBFMvlTazsNyaIVj
         WKJfqY8IYwehXALmDMICz4EFeydq4S3LkYcu+Su3OBO01oPcQW19XBpB0ccblpAXPA/Q
         RDwHr4311xVrreHJxcbz36Rd7kk9+qhMjJsYAbKqMNAjYU8eBFQe6dldiNFr2Xr0Jlwn
         dfLe35lgqi2eTjVgKRewG0pQ/YnJ1LxEMGpcEpa4AR8ooiy5nLcDa07W2kdYKAVdv+Iy
         TKd40qK5i66h2Ie2vwW8eGikv1jlq66B8PxXUxw3MHnc3ljxlldix1i8odsfiE8UkQ84
         0hQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bxtUcWgwjk6d+Vyf4IeL1p3XTo2R7i++ELRnxJVt1+Y=;
        b=hRqlPiencCwwrpJIQhjI48PBGrqMAhp3DEq0EeC2APzV+nrWuYZHuemZ0iFshutepk
         lG26gt/vHKl97A/R9BHCNiprvqiROfr/l0Wqv8bRV/0/nA6UMpLxI2JwNH57EBaEvwCG
         Komc/LQuOp9Sw+li27rPJvP6AhTyYaV3nOi5CefkUTuOviHSe2C3L/YpY95NZAZuVntt
         DV70Zpq6VPQz3RaPeR9rRk4nioAYThNQT0wgc3MosAnw1KOuDG+gRbd8Relxm4Xegi4E
         ZUVEoKFDHricvKumWnBAMB7qeB4+RKUJNa0pj/68e+7XMRvQg20SxRSDTCFwoTeca1tt
         RK2w==
X-Gm-Message-State: AOAM531TADogZXvzoIoUSzi7myFy8zd1q4JmTHqQtJU/mXrA2/ltyllD
        W2/X6vy/zMEAZ+NMuJM+5yzE0w==
X-Google-Smtp-Source: ABdhPJxv92q0KblBf7qVvodOqRKmaeOE3oidlfGODEqN921jWgAvSb9rsCD7l7smF1tCrv2W7NBRvA==
X-Received: by 2002:a37:4e45:: with SMTP id c66mr19191454qkb.36.1600190021980;
        Tue, 15 Sep 2020 10:13:41 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::1069? ([2620:10d:c091:480::1:5472])
        by smtp.gmail.com with ESMTPSA id b190sm12007124qkd.45.2020.09.15.10.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2020 10:13:41 -0700 (PDT)
Subject: Re: [PATCH] btrfs: fix overflow when copying corrupt csums
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        syzbot+e864a35d361e1d4e29a5@syzkaller.appspotmail.com
References: <20200915144931.24555-1-johannes.thumshirn@wdc.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <1764dd1e-50c5-0962-b76f-4ee88df6931a@toxicpanda.com>
Date:   Tue, 15 Sep 2020 13:13:39 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200915144931.24555-1-johannes.thumshirn@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/15/20 10:49 AM, Johannes Thumshirn wrote:
> Syzkaller reported a buffer overflow in btree_readpage_end_io_hook() when
> loop mounting a crafted image:
> 
> detected buffer overflow in memcpy
> ------------[ cut here ]------------
> kernel BUG at lib/string.c:1129!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 1 PID: 26 Comm: kworker/u4:2 Not tainted 5.9.0-rc4-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: btrfs-endio-meta btrfs_work_helper
> RIP: 0010:fortify_panic+0xf/0x20 lib/string.c:1129
> Code: 89 c7 48 89 74 24 08 48 89 04 24 e8 ab 39 00 fe 48 8b 74 24 08 48 8b 04 24 eb d5 48 89 fe 48 c7 c7 40 22 97 88 e8 b0 8c a9 fd <0f> 0b cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 41 57 41 56 41
> RSP: 0018:ffffc90000e27980 EFLAGS: 00010286
> RAX: 0000000000000022 RBX: ffff8880a80dca64 RCX: 0000000000000000
> RDX: ffff8880a90860c0 RSI: ffffffff815dba07 RDI: fffff520001c4f22
> RBP: ffff8880a80dca00 R08: 0000000000000022 R09: ffff8880ae7318e7
> R10: 0000000000000000 R11: 0000000000077578 R12: 00000000ffffff6e
> R13: 0000000000000008 R14: ffffc90000e27a40 R15: 1ffff920001c4f3c
> FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000557335f440d0 CR3: 000000009647d000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   memcpy include/linux/string.h:405 [inline]
>   btree_readpage_end_io_hook.cold+0x206/0x221 fs/btrfs/disk-io.c:642
>   end_bio_extent_readpage+0x4de/0x10c0 fs/btrfs/extent_io.c:2854
>   bio_endio+0x3cf/0x7f0 block/bio.c:1449
>   end_workqueue_fn+0x114/0x170 fs/btrfs/disk-io.c:1695
>   btrfs_work_helper+0x221/0xe20 fs/btrfs/async-thread.c:318
>   process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
>   worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
>   kthread+0x3b5/0x4a0 kernel/kthread.c:292
>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
> Modules linked in:
> ---[ end trace b68924293169feef ]---
> RIP: 0010:fortify_panic+0xf/0x20 lib/string.c:1129
> Code: 89 c7 48 89 74 24 08 48 89 04 24 e8 ab 39 00 fe 48 8b 74 24 08 48 8b 04 24 eb d5 48 89 fe 48 c7 c7 40 22 97 88 e8 b0 8c a9 fd <0f> 0b cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc 41 57 41 56 41
> RSP: 0018:ffffc90000e27980 EFLAGS: 00010286
> RAX: 0000000000000022 RBX: ffff8880a80dca64 RCX: 0000000000000000
> RDX: ffff8880a90860c0 RSI: ffffffff815dba07 RDI: fffff520001c4f22
> RBP: ffff8880a80dca00 R08: 0000000000000022 R09: ffff8880ae7318e7
> R10: 0000000000000000 R11: 0000000000077578 R12: 00000000ffffff6e
> R13: 0000000000000008 R14: ffffc90000e27a40 R15: 1ffff920001c4f3c
> FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f95b7c4d008 CR3: 000000009647d000 CR4: 00000000001506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
> The overflow happens, because in btree_readpage_end_io_hook() we assume that
> we have found a 4 byte checksum instead of the real possible 32 bytes we
> have for the checksums.
> 
> With the fix applied:
> 
> BTRFS: device fsid 815caf9a-dc43-4d2a-ac54-764b8333d765 devid 1 transid 5 /dev/loop0 scanned by syz-repro (214)
> BTRFS info (device loop0): disk space caching is enabled
> BTRFS info (device loop0): has skinny extents
> BTRFS warning (device loop0): loop0 checksum verify failed on 1052672 wanted fc35c0f9 found 4b0bbc71 level 0
> BTRFS error (device loop0): failed to read chunk root
> BTRFS error (device loop0): open_ctree failed
> 
> Fixes: d5178578bcd4 ("btrfs: directly call into crypto framework for checksumming")
> Reported-by: syzbot+e864a35d361e1d4e29a5@syzkaller.appspotmail.com
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
