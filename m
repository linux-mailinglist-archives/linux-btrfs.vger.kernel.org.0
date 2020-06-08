Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 418281F1BAB
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jun 2020 17:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbgFHPGX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 Jun 2020 11:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730033AbgFHPGX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 Jun 2020 11:06:23 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02095C08C5C2
        for <linux-btrfs@vger.kernel.org>; Mon,  8 Jun 2020 08:06:23 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id k22so14882013qtm.6
        for <linux-btrfs@vger.kernel.org>; Mon, 08 Jun 2020 08:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=e5xSqwcL6fzoc2Ebcr54E2gpjW48PeYXkVtkSvEKcxU=;
        b=WHT05ePHBCvlsp3X0IA8bqJBq3ZqxiCB5HfMV4UH3I63/9MgAh+LMOMRbg3oze5J6/
         uATAyDz3BgY0Yk4K1BuTx29ozx/1rzuugrstJvyxTkj4gFE9XpgfCH7yzFAhjApk/PvG
         VCMb6f8bEfKRxnhLrEx1xWA8BZnuL9ohwpxs3uYieD1BB+Qf5cAeUJxZ7ZWyDFoorc96
         +7DIR2+8umOl1+KwYFhkxCX4yImZj03lDiZUDr4HTbte/y1o/KwiDC7DDf1om9SHLvnp
         Vdfq4ydsVqvSqcIE2GJRsSv0Ai7J74oC2E21PbLxxHh+6876k2jy8lFEtkpqrK0Uxs+Z
         3TBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e5xSqwcL6fzoc2Ebcr54E2gpjW48PeYXkVtkSvEKcxU=;
        b=cEHLR0D3C1XxdctOx19ts7wIQlcnWwtScSKw/b3ijbRsPcM8hnkaYlzVkbjHWb8iSm
         RcJy5u4+r7BPq/PX9eXwfL5LFDCSZcrZJPtB4VJdC5RReKjJhQCesPGXr6l9++FXKiYm
         uClu6daLBeEmCwMK8yS5mOO2F0aU9wQv9cQaheviPuXzrIo/MspkoW+jzZ5nN6QbBWy2
         nKWYDPi306Ct5SGskDzOIwy9AJ2SSF2NeKs1rBGyQ2WjTPmJxp7W1rmECwhkGAmDbgmz
         ENud2QQUEn9HbRPhYp8iOS1On12VJKUZemLJGox+QXEGyNZXgLDfej4vkZ0GDR3gZVfR
         QYtQ==
X-Gm-Message-State: AOAM531ITWOq/jIcOJeuQSFhmZRAl5BZaUx68Zy9Vgbx78MB+KJJo+Ev
        oPFd8nV2hjLh1j2ecvy3nKPehYGaq+DZ4Q==
X-Google-Smtp-Source: ABdhPJwK/VIQwsUKYEYPnuJJSo9t+BxSunBOsQTcFiLoV1dAII2MNcPwJo1k78sqTJ5nsxsc8ngypg==
X-Received: by 2002:ac8:4d4c:: with SMTP id x12mr24593122qtv.39.1591628781511;
        Mon, 08 Jun 2020 08:06:21 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::10a4? ([2620:10d:c091:480::1:ae5a])
        by smtp.gmail.com with ESMTPSA id a1sm7073369qkn.87.2020.06.08.08.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2020 08:06:20 -0700 (PDT)
Subject: Re: [PATCH 2/2] Btrfs: fix bytes_may_use underflow when running
 balance and scrub in parallel
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <20200608123305.26404-1-fdmanana@kernel.org>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <97f7a008-3b6e-97c3-a4f1-99fa01f18c2d@toxicpanda.com>
Date:   Mon, 8 Jun 2020 11:06:19 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200608123305.26404-1-fdmanana@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/8/20 8:33 AM, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When balance and scrub are running in parallel it is possible to end up
> with an underflow of the bytes_may_use counter of the data space_info
> object, which triggers a warning like the following:
> 
>     [134243.793196] BTRFS info (device sdc): relocating block group 1104150528 flags data
>     [134243.806891] ------------[ cut here ]------------
>     [134243.807561] WARNING: CPU: 1 PID: 26884 at fs/btrfs/space-info.h:125 btrfs_add_reserved_bytes+0x1da/0x280 [btrfs]
>     [134243.808819] Modules linked in: btrfs blake2b_generic xor (...)
>     [134243.815779] CPU: 1 PID: 26884 Comm: kworker/u8:8 Tainted: G        W         5.6.0-rc7-btrfs-next-58 #5
>     [134243.816944] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
>     [134243.818389] Workqueue: writeback wb_workfn (flush-btrfs-108483)
>     [134243.819186] RIP: 0010:btrfs_add_reserved_bytes+0x1da/0x280 [btrfs]
>     [134243.819963] Code: 0b f2 85 (...)
>     [134243.822271] RSP: 0018:ffffa4160aae7510 EFLAGS: 00010287
>     [134243.822929] RAX: 000000000000c000 RBX: ffff96159a8c1000 RCX: 0000000000000000
>     [134243.823816] RDX: 0000000000008000 RSI: 0000000000000000 RDI: ffff96158067a810
>     [134243.824742] RBP: ffff96158067a800 R08: 0000000000000001 R09: 0000000000000000
>     [134243.825636] R10: ffff961501432a40 R11: 0000000000000000 R12: 000000000000c000
>     [134243.826532] R13: 0000000000000001 R14: ffffffffffff4000 R15: ffff96158067a810
>     [134243.827432] FS:  0000000000000000(0000) GS:ffff9615baa00000(0000) knlGS:0000000000000000
>     [134243.828451] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     [134243.829184] CR2: 000055bd7e414000 CR3: 00000001077be004 CR4: 00000000003606e0
>     [134243.830083] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>     [134243.830975] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>     [134243.831867] Call Trace:
>     [134243.832211]  find_free_extent+0x4a0/0x16c0 [btrfs]
>     [134243.832846]  btrfs_reserve_extent+0x91/0x180 [btrfs]
>     [134243.833487]  cow_file_range+0x12d/0x490 [btrfs]
>     [134243.834080]  fallback_to_cow+0x82/0x1b0 [btrfs]
>     [134243.834689]  ? release_extent_buffer+0x121/0x170 [btrfs]
>     [134243.835370]  run_delalloc_nocow+0x33f/0xa30 [btrfs]
>     [134243.836032]  btrfs_run_delalloc_range+0x1ea/0x6d0 [btrfs]
>     [134243.836725]  ? find_lock_delalloc_range+0x221/0x250 [btrfs]
>     [134243.837450]  writepage_delalloc+0xe8/0x150 [btrfs]
>     [134243.838059]  __extent_writepage+0xe8/0x4c0 [btrfs]
>     [134243.838674]  extent_write_cache_pages+0x237/0x530 [btrfs]
>     [134243.839364]  extent_writepages+0x44/0xa0 [btrfs]
>     [134243.839946]  do_writepages+0x23/0x80
>     [134243.840401]  __writeback_single_inode+0x59/0x700
>     [134243.841006]  writeback_sb_inodes+0x267/0x5f0
>     [134243.841548]  __writeback_inodes_wb+0x87/0xe0
>     [134243.842091]  wb_writeback+0x382/0x590
>     [134243.842574]  ? wb_workfn+0x4a2/0x6c0
>     [134243.843030]  wb_workfn+0x4a2/0x6c0
>     [134243.843468]  process_one_work+0x26d/0x6a0
>     [134243.843978]  worker_thread+0x4f/0x3e0
>     [134243.844452]  ? process_one_work+0x6a0/0x6a0
>     [134243.844981]  kthread+0x103/0x140
>     [134243.845400]  ? kthread_create_worker_on_cpu+0x70/0x70
>     [134243.846030]  ret_from_fork+0x3a/0x50
>     [134243.846494] irq event stamp: 0
>     [134243.846892] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
>     [134243.847682] hardirqs last disabled at (0): [<ffffffffb2abdedf>] copy_process+0x74f/0x2020
>     [134243.848687] softirqs last  enabled at (0): [<ffffffffb2abdedf>] copy_process+0x74f/0x2020
>     [134243.849913] softirqs last disabled at (0): [<0000000000000000>] 0x0
>     [134243.850698] ---[ end trace bd7c03622e0b0a96 ]---
>     [134243.851335] ------------[ cut here ]------------
> 
> When relocating a data block group, for each extent allocated in the
> block group we preallocate another extent with the same size for the
> data relocation inode (we do it at prealloc_file_extent_cluster()).
> We reserve space by calling btrfs_check_data_free_space(), which ends
> up incrementing the data space_info's bytes_may_use counter, and
> then call btrfs_prealloc_file_range() to allocate the extent, which
> always decrements the bytes_may_use counter by the same amount.
> 
> The expectation is that writeback of the data relocation inode always
> follows a NOCOW path, by writing into the preallocated extents. However,
> when starting writeback we might end up falling back into the COW path,
> because the block group that contains the preallocated extent was turned
> into RO mode by a scrub running in parallel. The COW path then calls the
> extent allocator which ends up calling btrfs_add_reserved_bytes(), and
> this function decrements the bytes_may_use counter of the data space_info
> object by an amount corresponding to the size of the allocated extent,
> despite we haven't previously incremented it. When the counter currently
> has a value smaller then the allocated extent we reset the counter to 0
> and emit a warning, otherwise we just decrement it and slowly mess up
> with this counter which is crucial for space reservation, the end result
> can be granting reserved space to tasks when there isn't really enough
> free space, and having the tasks fail later in critical places where
> error handling consists of a transaction abort or hitting a BUG_ON().
> 
> Fix this by making sure that if we fallback to the COW path for a data
> relocation inode, we increment the bytes_may_use counter of the data
> space_info object. The COW path will then decrement it at
> btrfs_add_reserved_bytes() on success or through its error handling part
> by a call to extent_clear_unlock_delalloc() (which ends up calling
> btrfs_clear_delalloc_extent() that does the decrement operation) in case
> of an error.
> 
> Test case btrfs/061 from fstests could sporadically trigger this.
> 
> CC: stable@vger.kernel.org # 4.4+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
