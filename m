Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630673D1722
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jul 2021 21:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239446AbhGUSuB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 21 Jul 2021 14:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239021AbhGUSuB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 21 Jul 2021 14:50:01 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3221FC061575
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jul 2021 12:30:36 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id v14so2654379qtc.8
        for <linux-btrfs@vger.kernel.org>; Wed, 21 Jul 2021 12:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Wax8crnkdnGgZDawvYDdDg1hUO9z01XE55ycTLTsWs0=;
        b=vdrZCoWJi45lAkZxskhISz7oF08gbpHnHA12LfRDPNvqrDMY+63OrupjDUw/Sjv16f
         umbQOrW/OzMIIA+f+WWla91BicKi39PVVdwrd85dP9Y2vuF3g/I/eZdCdyAQop7Kxgta
         JDdlwlWRDtcfIShJZ4h5I31DEW06MEAL0tDAHiWJVjxiMHN6RIIEtf+S0Fheg4A5O736
         vnv76SQHaEI6jHPyNjNKaMAzCn32SXqCD+kf6u+3tRtkVGFgFFtmJYBmn3UTG3vut9Gi
         8bqpjclPolryIv6z9lJ/kutdTN3vXxYhl57N3+uTwBKgmo72j+7oXJPEMLKPROjz0MGa
         rlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wax8crnkdnGgZDawvYDdDg1hUO9z01XE55ycTLTsWs0=;
        b=CFs/rxz0sBupxWVcYjdqCRBjn3bo6JkyxZahy7cpy4/fdCnkPQj58qcrGjHfRVOF1b
         N4uhigcgfiSn9S8wVEMAcJwFAmfwTqraUqxny2sI3DVCSBdPLIxHp68i0IYT17ws4V2t
         /1rVjXERcJVCSRBqjyr20645v8yLbwVLADZN/8djBR7nDU9Ft7sQOKy6qUQIiRSyL9uT
         dDR8NysJ4pRopFDHyLZau9j3nlRgLeLUAmjGbLYZRoV1HxCbji5cK8jhX/uv2EL+jP/2
         MyinAttfYIrqXE67z5PkbjDqn+norJkkYV/bhqm7DVVgxlx5v/7H8hVqWEh5iCPPgAp4
         4X6w==
X-Gm-Message-State: AOAM533Jd8o1pCp6HWqGS4rYeBDppa+QnqkWlgBa83vjcNCGc93LMudM
        MecTQa+wJknoZSr4Ub58asvg5GSVIbcE0WEC
X-Google-Smtp-Source: ABdhPJxsmVeydnk9W8ghzgYXRiLJPh55cZBkINfvUXZlRSCTUgEbkWKrUcQYM9lgYcOyHl8uc2j0fQ==
X-Received: by 2002:ac8:7fc2:: with SMTP id b2mr20207584qtk.59.1626895834898;
        Wed, 21 Jul 2021 12:30:34 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11e8::1223? ([2620:10d:c091:480::1:9441])
        by smtp.gmail.com with ESMTPSA id o17sm3726555qko.100.2021.07.21.12.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jul 2021 12:30:34 -0700 (PDT)
Subject: Re: [PATCH] btrfs: make __extent_writepage() not return error if the
 page is marked error
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <20210720114548.322356-1-wqu@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <e50266bf-db30-9387-9b1a-f3d042d5230a@toxicpanda.com>
Date:   Wed, 21 Jul 2021 15:30:31 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210720114548.322356-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/20/21 7:45 AM, Qu Wenruo wrote:
> [BUG]
> When running btrfs/160 in a loop for subpage with experimental
> compression support, it has a high chance to crash (~20%):
> 
>   BTRFS critical (device dm-7): panic in __btrfs_add_ordered_extent:238: inconsistency in ordered tree at offset 0 (errno=-17 Object already exists)
>   ------------[ cut here ]------------
>   kernel BUG at fs/btrfs/ordered-data.c:238!
>   Internal error: Oops - BUG: 0 [#1] SMP
>   pc : __btrfs_add_ordered_extent+0x550/0x670 [btrfs]
>   lr : __btrfs_add_ordered_extent+0x550/0x670 [btrfs]
>   Call trace:
>    __btrfs_add_ordered_extent+0x550/0x670 [btrfs]
>    btrfs_add_ordered_extent+0x2c/0x50 [btrfs]
>    run_delalloc_nocow+0x81c/0x8fc [btrfs]
>    btrfs_run_delalloc_range+0xa4/0x390 [btrfs]
>    writepage_delalloc+0xc0/0x1ac [btrfs]
>    __extent_writepage+0xf4/0x370 [btrfs]
>    extent_write_cache_pages+0x288/0x4f4 [btrfs]
>    extent_writepages+0x58/0xe0 [btrfs]
>    btrfs_writepages+0x1c/0x30 [btrfs]
>    do_writepages+0x60/0x110
>    __filemap_fdatawrite_range+0x108/0x170
>    filemap_fdatawrite_range+0x20/0x30
>    btrfs_fdatawrite_range+0x34/0x4dc [btrfs]
>    __btrfs_write_out_cache+0x34c/0x480 [btrfs]
>    btrfs_write_out_cache+0x144/0x220 [btrfs]
>    btrfs_start_dirty_block_groups+0x3ac/0x6b0 [btrfs]
>    btrfs_commit_transaction+0xd0/0xbb4 [btrfs]
>    btrfs_sync_fs+0x64/0x1cc [btrfs]
>    sync_fs_one_sb+0x3c/0x50
>    iterate_supers+0xcc/0x1d4
>    ksys_sync+0x6c/0xd0
>    __arm64_sys_sync+0x1c/0x30
>    invoke_syscall+0x50/0x120
>    el0_svc_common.constprop.0+0x4c/0xd4
>    do_el0_svc+0x30/0x9c
>    el0_svc+0x2c/0x54
>    el0_sync_handler+0x1a8/0x1b0
>    el0_sync+0x198/0x1c0
>   ---[ end trace 336f67369ae6e0af ]---
> 
> [CAUSE]
> For subpage case, we can have multiple sectors inside a page, this makes
> it possible for __extent_writepage() to have part of its page submitted
> before returning.
> 
> In btrfs/160, we are using dm-dust to emulate write error, this means
> for certain pages, we could have everything running fine, but at the end
> of __extent_writepage(), one of the submitted bios fails due to dm-dust.
> 
> Then the page is marked Error, and we change @ret from 0 to -EIO.
> 
> This makes the caller extent_write_cache_pages() to error out, without
> submitting the remaining pages.
> 
> Furthermore, since we're erroring out for free space cache, it doesn't
> really care about the error and will update the inode and retry the
> writeback.
> 
> Then we re-run the delalloc range, and will try to insert the same
> delalloc range while previous delalloc range is still hanging there,
> triggering the above error.

This seems like the real bug.  We should do the proper cleanup for the range in 
this case, not ignore errors during writeback.  Thanks,

Josef
