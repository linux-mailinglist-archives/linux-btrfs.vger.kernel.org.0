Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665EC798A07
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 Sep 2023 17:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbjIHPcZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 Sep 2023 11:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244669AbjIHPcX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 Sep 2023 11:32:23 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4314B1FDB
        for <linux-btrfs@vger.kernel.org>; Fri,  8 Sep 2023 08:32:07 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-76dbe786527so120869785a.2
        for <linux-btrfs@vger.kernel.org>; Fri, 08 Sep 2023 08:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1694187126; x=1694791926; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QlczVJtEpALJcR8kwP52Xo5Ell6gXUAhN7NPIkbg6Tw=;
        b=AHKA0ZdSmG8aE6IikIqeJdnCKXK/ljl9yH6dI8hFGZ/FmSaq/Ojoq4ndH2YIYVXk7d
         8cwGn69PuyIOFBE2qrlSBPwcGWAPcqD/c32FqWbAN1qZOFU0txPG+yim3tNjAM1ArmqQ
         xDADnDbNHxkr3sPfEUW4aPhC/hdmg/vZrf4f0rHsqt2fY7x9Fugwhk19NmauxhUh89Zo
         7r9QQwucbdKI6iM5SGLxaaIBjtEcR9YTLA9woZ072bAlJJEJVXZEqc6ADLN10fmwqp0x
         FjaNXv2BxwB5oHM4CkkT2FadMDuFokMP9uXooGjzLsh3ICg0xfyEDAxGMzZmxuQzPb1X
         alDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694187126; x=1694791926;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlczVJtEpALJcR8kwP52Xo5Ell6gXUAhN7NPIkbg6Tw=;
        b=VYGOyXFaRqXpp6Z/HWulO1ZnW7ArHfrynODFVE1nlVvBA2fUYl2KMG/Y93t/mY7bUD
         WjrluuxhodpVy04gILHYuUrFqf0kyhLChlyOMcaCbGA4Umc91qNLOZDqbXj4zRGdlQNY
         XnuwpjAWGhjE7FP1LqJIUOvwQDoNLUfSGKQpMNbOas8M2XosdIdjmW/JqNzHn3qSrGw2
         UUvsMtLcoJMTjTYUbEh4DlpExzm5GgDLSZzpeoFBG40NzinfuVGfxXXHOIqaoJuQDs6Z
         oincwsGExp6yDdARnidQECbOHRavJjJaSe0+p42INMF6nu+9aWnA5a3x8/2Yn2NLWs11
         gekg==
X-Gm-Message-State: AOJu0YwNwNu9ALoMggypomCuh2e4rsaTubqI6vDgH2ABTkxAm0VDyyMf
        YrwiDQvVcVNhmL4Ljzt/ypjb2w==
X-Google-Smtp-Source: AGHT+IGc2c2ywd4RxKKK0vD/pQVrtYpca8qfFiWbG4Ydk+VaQsBD/RhdE1a2zKWAS6sOp61Bo2KECw==
X-Received: by 2002:a05:620a:4444:b0:76d:acd1:4449 with SMTP id w4-20020a05620a444400b0076dacd14449mr3512616qkp.1.1694187126269;
        Fri, 08 Sep 2023 08:32:06 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id fu22-20020a05622a5d9600b004054b435f8csm672791qtb.65.2023.09.08.08.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 08:32:05 -0700 (PDT)
Date:   Fri, 8 Sep 2023 11:32:05 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 21/21] btrfs: always reserve space for delayed refs when
 starting transaction
Message-ID: <20230908153205.GV1977092@perftesting>
References: <cover.1694174371.git.fdmanana@suse.com>
 <c243a7580fbaed93db3d3c3911b0a217199580ef.1694174371.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c243a7580fbaed93db3d3c3911b0a217199580ef.1694174371.git.fdmanana@suse.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 08, 2023 at 01:09:23PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When starting a transaction (or joining an existing one with
> btrfs_start_transaction()), we reserve space for the number of items we
> want to insert in a btree, but we don't do it for the delayed refs we
> will generate while using the transaction to modify (COW) extent buffers
> in a btree or allocate new extent buffers. Basically how it works:
> 
> 1) When we start a transaction we reserve space for the number of items
>    the caller wants to be inserted/modified/deleted in a btree. This space
>    goes to the transaction block reserve;
> 
> 2) If the delayed refs block reserve is not full, its size is greater
>    than the amount of its reserved space, and the flush method is
>    BTRFS_RESERVE_FLUSH_ALL, then we attempt to reserve more space for
>    it corresponding to the number of items the caller wants to
>    insert/modify/delete in a btree;
> 
> 3) The size of the delayed refs block reserve is increased when a task
>    creates delayed refs after COWing an extent buffer, allocating a new
>    one or deleting (freeing) an extent buffer. This happens after the
>    the task started or joined a transaction, whenever it calls
>    btrfs_update_delayed_refs_rsv();
> 
> 4) The delayed refs block reserve is then refilled by anyone calling
>    btrfs_delayed_refs_rsv_refill(), either during unlink/truncate
>    operations or when someone else calls btrfs_start_transaction() with
>    a 0 number of items and flush method BTRFS_RESERVE_FLUSH_ALL;
> 
> 5) As a task COWs or allocates extent buffers, it consumes space from the
>    transaction block reserve. When the task releases its transaction
>    handle (btrfs_end_transaction()) or it attempts to commit the
>    transaction, it releases any remaining space in the transaction block
>    reserve that it did not use, as not all space may have been used (due
>    to pessimistic space calculation) by calling btrfs_block_rsv_release()
>    which will try to add that unused space to the delayed refs block
>    reserve (if its current size is greater than its reserved space).
>    That transferred space may not be enough to completely fulfill the
>    delayed refs block reserve.
> 
>    Plus we have some tasks that will attempt do modify as many leaves
>    as they can before getting -ENOSPC (and then reserving more space and
>    retrying), such as hole punching and extent cloning which call
>    btrfs_replace_file_extents(). Such tasks can generate therefore a
>    high number of delayed refs, for both metadata and data (we can't
>    know in advance how many file extent items we will find in a range
>    and therefore how many delayed refs for dropping references on data
>    extents we will generate);
> 
> 6) If a transaction starts its commit before the delayeds refs block
>    reserve is refilled, for example by the transaction kthread or by
>    someone who called btrfs_join_transaction() before starting the
>    commit, then when running delayed references if we don't have enough
>    reserved space in the delayed refs block reserve, we will consume
>    space from the global block reserve.
> 
> Now this doesn't make a lot of sense because:
> 
> 1) We should reserve space for delayed references when starting the
>    transaction, since we have no guarantees the delayed refs block
>    reserve will be refilled;
> 
> 2) If no refill happens then we will consume from the global block reserve
>    when running delayed refs during the transaction commit;
> 
> 3) If we have a bunch of tasks calling btrfs_start_transaction() with a
>    number of items greater than zero and at the time the delayed refs
>    reserve is full, then we don't reserve any space at
>    btrfs_start_transaction() for the delayed refs that will be generated
>    by a task, and we can therefore end up using a lot of space from the
>    global reserve when running the delayed refs during a transaction
>    commit;
> 
> 4) There are also other operations that result in bumping the size of the
>    delayed refs reserve, such as creating and deleting block groups, as
>    well as the need to update a block group item because we allocated or
>    freed an extent from the respective block group;
> 
> 5) If we have a significant gap betweent the delayed refs reserve's size
>    and its reserved space, two very bad things may happen:
> 
>    1) The reserved space of the global reserve may not be enough and we
>       fail the transaction commit with -ENOSPC when running delayed refs;
> 
>    2) If the available space in the global reserve is enough it may result
>       in nearly exhausting it. If the fs has no more unallocated device
>       space for allocating a new block group and all the available space
>       in existing metadata block groups is not far from the global
>       reserve's size before we started the transaction commit, we may end
>       up in a situation where after the transaction commit we have too
>       little available metadata space, and any future transaction commit
>       will fail with -ENOSPC, because although we were able to reserve
>       space to start the transaction, we were not able to commit it, as
>       running delayed refs generates some more delayed refs (to update the
>       extent tree for example) - this includes not even being able to
>       commit a transaction that was started with the goal of unlinking a
>       file, removing an empty data block group or doing reclaim/balance,
>       so there's no way to release metadata space.
> 
>       In the worst case the next time we mount the filesystem we may
>       also fail with -ENOSPC due to failure to commit a transaction to
>       cleanup orphan inodes. This later case was reported and hit by
>       someone running a SLE (SUSE Linux Enterprise) distribution for
>       example - where the fs had no more unallocated space that could be
>       used to allocate a new metadata block group, and the available
>       metadata space was about 1.5M, not enough to commit a transaction
>       to cleanup an orphan inode (or do relocation of data block groups
>       that were far from being full).
> 
> So improve on this situation by always reserving space for delayed refs
> when calling start_transaction(), and if the flush method is
> BTRFS_RESERVE_FLUSH_ALL, also try to refill the delayeds refs block
> reserve if it's not full. The space reserved for the delayed refs is added
> to a local block reserve that is part of the transaction handle, and when
> a task updates the delayed refs block reserve size, after creating a
> delayed ref, the space is transferred from that local reserve to the
> global delayed refs reserve (fs_info->delayed_refs_rsv). In case the
> local reserve does not have enough space, which may happen for tasks
> that generate a variable and potentially large number of delayed refs
> (such as the hole punching and extent cloning cases mentioned before),
> we transfer any available space and then rely on the current behaviour
> of hoping some other task refills the delayed refs reserve or fallback
> to the global block reserve.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
