Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04264241C7B
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Aug 2020 16:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgHKOfe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 10:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728740AbgHKOfe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 10:35:34 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F93CC06174A
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 07:35:34 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id n129so6150889qkd.6
        for <linux-btrfs@vger.kernel.org>; Tue, 11 Aug 2020 07:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r0cmsWZ9MYKa59ZlE1zsTkIiW8+3KEoGQg9TSQwQeA4=;
        b=e6kIV+bEkGeMBsy4a/o1hEXmSpjO0ssl5yq6A31jlGDQYvR6dUfyHF7u3Gc4drCk5/
         zcf0deDvSSEyMc6Gfx/8hz+z12tzOtT619M0/umjNZd+6HIYTFlWBoMWcYOIUbzlO3Zr
         S5Oj06bkaPC5jhWcYIuMtJb/mr/owje51weNjHSRzL9XXWDzt0Isbrw5R/MSKFcWWXv6
         ltaxydG0UTGZEmQw6yqR1U5PiqZ2aObhsJftyvuAu5RXyM7GeTtVgYpLUugBb/tFNJLC
         9iUYTu6OHJCo5hatE19Z9iqQLSzdW9kM330RYiU3H/MTHHOGasNhDczDj3CeqAa1HBdb
         +xqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r0cmsWZ9MYKa59ZlE1zsTkIiW8+3KEoGQg9TSQwQeA4=;
        b=t5086LqEwoF67SoYQGaj0sruku+Gl4ZVSnQAMLO0KP2SbXkBsm/mKZYI11pJfnoACL
         rUqgVS2v6yYDGRr1RY17qwNJnUsCRiAE7lO6fzY1/yFeWfOiPMIgFPjwT3YuEDu42BBw
         XJB8p+V2jXDsvRgA8ZnB8oSf59MBodzheGgTe/XspJOwUBUVUZkcIJSPahayOWU4TmKX
         il870AeEm3BTkf6UbNWZZospn6XMszQEtJ2AYJO6pyviQzaFrwFkLlZj4irromLh0lxG
         9Wudxi7yVZCJ3zXbpV5jyiXaoQxX5ASEWy1LmLVTyAeMLsvGOtK3kwk5B/9XJSfLzgzK
         Odtg==
X-Gm-Message-State: AOAM531/dw12XhWlQL43okZ8O1lil2eH5rokyw5wXPJ7VkWvVRZgr0u0
        5n2dpvFOX6qDibRo9OpsvAol6CvE89XW1A==
X-Google-Smtp-Source: ABdhPJxj8tNIMSYa2O7KgbK2u8f9pkQAG6/B9ta5YoP9oPoNMBlXquNqptfpryclVk/b1x0Yb0J5UQ==
X-Received: by 2002:a05:620a:2236:: with SMTP id n22mr1383825qkh.127.1597156533355;
        Tue, 11 Aug 2020 07:35:33 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id i68sm16354635qkb.58.2020.08.11.07.35.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 07:35:32 -0700 (PDT)
Subject: Re: [PATCH 01/17] btrfs: drop path before adding new uuid tree entry
To:     fdmanana@gmail.com
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
References: <20200810154242.782802-1-josef@toxicpanda.com>
 <20200810154242.782802-2-josef@toxicpanda.com>
 <CAL3q7H6=9nz-srTGqJF6oVdikP8BXMJGGQQSgAjyrt+Nyw8eLg@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <773a77b8-27f5-429c-75c5-33c34d1bdcf0@toxicpanda.com>
Date:   Tue, 11 Aug 2020 10:35:31 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAL3q7H6=9nz-srTGqJF6oVdikP8BXMJGGQQSgAjyrt+Nyw8eLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/10/20 12:28 PM, Filipe Manana wrote:
> On Mon, Aug 10, 2020 at 4:44 PM Josef Bacik <josef@toxicpanda.com> wrote:
>>
>> With the conversion to the rwsemaphore I got the following lockdep splat
>>
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 5.8.0-rc7-00167-g0d7ba0c5b375-dirty #925 Not tainted
>> ------------------------------------------------------
>> btrfs-uuid/7955 is trying to acquire lock:
>> ffff88bfbafec0f8 (btrfs-root-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x39/0x180
>>
>> but task is already holding lock:
>> ffff88bfbafef2a8 (btrfs-uuid-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x39/0x180
>>
>> which lock already depends on the new lock.
>>
>> the existing dependency chain (in reverse order) is:
>>
>> -> #1 (btrfs-uuid-00){++++}-{3:3}:
>>         down_read_nested+0x3e/0x140
>>         __btrfs_tree_read_lock+0x39/0x180
>>         __btrfs_read_lock_root_node+0x3a/0x50
>>         btrfs_search_slot+0x4bd/0x990
>>         btrfs_uuid_tree_add+0x89/0x2d0
>>         btrfs_uuid_scan_kthread+0x330/0x390
>>         kthread+0x133/0x150
>>         ret_from_fork+0x1f/0x30
>>
>> -> #0 (btrfs-root-00){++++}-{3:3}:
>>         __lock_acquire+0x1272/0x2310
>>         lock_acquire+0x9e/0x360
>>         down_read_nested+0x3e/0x140
>>         __btrfs_tree_read_lock+0x39/0x180
>>         __btrfs_read_lock_root_node+0x3a/0x50
>>         btrfs_search_slot+0x4bd/0x990
>>         btrfs_find_root+0x45/0x1b0
>>         btrfs_read_tree_root+0x61/0x100
>>         btrfs_get_root_ref.part.50+0x143/0x630
>>         btrfs_uuid_tree_iterate+0x207/0x314
>>         btrfs_uuid_rescan_kthread+0x12/0x50
>>         kthread+0x133/0x150
>>         ret_from_fork+0x1f/0x30
>>
>> other info that might help us debug this:
>>
>>   Possible unsafe locking scenario:
>>
>>         CPU0                    CPU1
>>         ----                    ----
>>    lock(btrfs-uuid-00);
>>                                 lock(btrfs-root-00);
>>                                 lock(btrfs-uuid-00);
>>    lock(btrfs-root-00);
>>
>>   *** DEADLOCK ***
>>
>> 1 lock held by btrfs-uuid/7955:
>>   #0: ffff88bfbafef2a8 (btrfs-uuid-00){++++}-{3:3}, at: __btrfs_tree_read_lock+0x39/0x180
>>
>> stack backtrace:
>> CPU: 73 PID: 7955 Comm: btrfs-uuid Kdump: loaded Not tainted 5.8.0-rc7-00167-g0d7ba0c5b375-dirty #925
>> Hardware name: Quanta Tioga Pass Single Side 01-0030993006/Tioga Pass Single Side, BIOS F08_3A18 12/20/2018
>> Call Trace:
>>   dump_stack+0x78/0xa0
>>   check_noncircular+0x165/0x180
>>   __lock_acquire+0x1272/0x2310
>>   lock_acquire+0x9e/0x360
>>   ? __btrfs_tree_read_lock+0x39/0x180
>>   ? btrfs_root_node+0x1c/0x1d0
>>   down_read_nested+0x3e/0x140
>>   ? __btrfs_tree_read_lock+0x39/0x180
>>   __btrfs_tree_read_lock+0x39/0x180
>>   __btrfs_read_lock_root_node+0x3a/0x50
>>   btrfs_search_slot+0x4bd/0x990
>>   btrfs_find_root+0x45/0x1b0
>>   btrfs_read_tree_root+0x61/0x100
>>   btrfs_get_root_ref.part.50+0x143/0x630
>>   btrfs_uuid_tree_iterate+0x207/0x314
>>   ? btree_readpage+0x20/0x20
>>   btrfs_uuid_rescan_kthread+0x12/0x50
>>   kthread+0x133/0x150
>>   ? kthread_create_on_node+0x60/0x60
>>   ret_from_fork+0x1f/0x30
>>
>> This problem exists because we have two different rescan threads,
>> btrfs_uuid_scan_kthread which creates the uuid tree, and
>> btrfs_uuid_tree_iterate that goes through and updates or deletes any out
>> of date roots.  The problem is they both do things in different order.
>> btrfs_uuid_scan_kthread() reads the tree_root, and then inserts entries
>> into the uuid_root.  btrfs_uuid_tree_iterate() scans the uuid_root, but
>> then does a btrfs_get_fs_root() which can read from the tree_root.
> 
> Ok, the get_fs_root() is through  btrfs_check_uuid_tree_entry().
> 
>>
>> It's actually easy enough to not be holding the path in
>> btrfs_uuid_scan_kthread() when we add a uuid entry, as we already drop
>> it further down and re-start the search when we loop.  So simply move
>> the path release before we add our entry to the uuid tree.
>>
>> This also fixes a problem where we're holding a path open after we do
>> btrfs_end_transaction(), which has it's own problems.
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/volumes.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index d7670e2a9f39..3ac44dad58bb 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -4462,6 +4462,7 @@ int btrfs_uuid_scan_kthread(void *data)
>>                          goto skip;
>>                  }
>>   update_tree:
>> +               btrfs_release_path(path);
> 
> We can actually do the release right after reading from the eb, so we
> avoid 3 path releases in different places.
> The end result would be:
> 
> https://pastebin.com/2gH54HBw
> 
> Either way, it looks good to me.

We need it at the skip: spot because we'll go straight to skip in some cases and 
not release the path, and then deadlock.  Fun things I discovered in testing ;).

Josef
