Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3779F3B0CC0
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jun 2021 20:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbhFVSWx (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Jun 2021 14:22:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:35662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229612AbhFVSWx (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Jun 2021 14:22:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8849F6128E
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Jun 2021 18:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624386037;
        bh=ya3jJQwoox6wDL93xYGWMvMcGan2v5r9KknlocXmbtc=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=hBrzJQjBNPltm0aYYe6v8g6Ped/pjfXrWjhbqtoAC+IjVvtdF3FjCrUTPOI6nqX+l
         +AvA1YFR0ywm4Hg/e8HQNB1kybl0/uu9Ava0TbSM/yUlngsfdj48slC0G/aZl6ifvD
         98UgYCDDB/TEDXKFHsjnvOieBj7X5I24RU4cgGt5U1Bv45aBsxZRhXN3/ckhgfzcM7
         btvGdgNlKq5ytZvN5BdJeAyvfiVtu0YPPOiDi8hWq82t5oJbf/M7JR2imwauoUOEEw
         qgbGgK3NTt209F/SdMyF2Wkq9qgP2RgSAZ6xVamdAjKt44PjpaHRdPqsh2BeeqVq7L
         dR3llq26W3HzA==
Received: by mail-qv1-f47.google.com with SMTP id r19so14598qvw.5
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Jun 2021 11:20:37 -0700 (PDT)
X-Gm-Message-State: AOAM5330O6bb/HtA3TWo70Uh7Ejl9LlG1cfuN3YxV1PJnQa9bZDPnPTM
        H2pNBA/jSqw7TPEXirT6C2H0mc7ntiyp/edgZ8M=
X-Google-Smtp-Source: ABdhPJz6DME6/FrXUfq2PRp5AwDWQrNoaVlrl6sbMkIcCQUYLM++RjDin6PlrIThOZME2UflaJczHHxIf6kAyIGOsDk=
X-Received: by 2002:a05:6214:174a:: with SMTP id dc10mr107196qvb.62.1624386036728;
 Tue, 22 Jun 2021 11:20:36 -0700 (PDT)
MIME-Version: 1.0
References: <b8b7b585ec8b7b2924fd5995951a0d16d2e394d7.1624369954.git.fdmanana@suse.com>
 <20210622175811.GK28158@twin.jikos.cz>
In-Reply-To: <20210622175811.GK28158@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 22 Jun 2021 19:20:25 +0100
X-Gmail-Original-Message-ID: <CAL3q7H6tx3XG9a4=nCLyv+GG8uLJ40qLzqzUWaxTLwhqOhZSKg@mail.gmail.com>
Message-ID: <CAL3q7H6tx3XG9a4=nCLyv+GG8uLJ40qLzqzUWaxTLwhqOhZSKg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: fix deadlock with concurrent chunk allocations
 involving system chunks
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 22, 2021 at 7:01 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Tue, Jun 22, 2021 at 02:54:10PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > When a task attempting to allocate a new chunk verifies that there is not
> > currently enough free space in the system space_info and there is another
> > task that allocated a new system chunk but it did not finish yet the
> > creation of the respective block group, it waits for that other task to
> > finish creating the block group. This is to avoid exhaustion of the system
> > chunk array in the superblock, which is limited, when we have a thundering
> > herd of tasks allocating new chunks. This problem was described and fixed
> > by commit eafa4fd0ad0607 ("btrfs: fix exhaustion of the system chunk array
> > due to concurrent allocations").
> >
> > However there are two very similar scenarios where this can lead to a
> > deadlock:
> >
> > 1) Task B allocated a new system chunk and task A is waiting on task B
> >    to finish creation of the respective system block group. However before
> >    task B ends its transaction handle and finishes the creation of the
> >    system block group, it attempts to allocate another chunk (like a data
> >    chunk for an fallocate operation for a very large range). Task B will
> >    be unable to progress and allocate the new chunk, because task A set
> >    space_info->chunk_alloc to 1 and therefore it loops at
> >    btrfs_chunk_alloc() waiting for task A to finish its chunk allocation
> >    and set space_info->chunk_alloc to 0, but task A is waiting on task B
> >    to finish creation of the new system block group, therefore resulting
> >    in a deadlock;
> >
> > 2) Task B allocated a new system chunk and task A is waiting on task B to
> >    finish creation of the respective system block group. By the time that
> >    task B enter the final phase of block group allocation, which happens
> >    at btrfs_create_pending_block_groups(), when it modifies the extent
> >    tree, the device tree or the chunk tree to insert the items for some
> >    new block group, it needs to allocate a new chunk, so it ends up at
> >    btrfs_chunk_alloc() and keeps looping there because task A has set
> >    space_info->chunk_alloc to 1, but task A is waiting for task B to
> >    finish creation of the new system block group and release the reserved
> >    system space, therefore resulting in a deadlock.
> >
> > In short, the problem is if a task B needs to allocate a new chunk after
> > it previously allocated a new system chunk and if another task A is
> > currently waiting for task B to complete the allocation of the new system
> > chunk.
> >
> > Fix this by making a task that previously allocated a new system chunk to
> > not loop at btrfs_chunk_alloc() and proceed if there is another task that
> > is waiting for it.
> >
> > Reported-by: Naohiro Aota <naohiro.aota@wdc.com>
> > Link: https://lore.kernel.org/linux-btrfs/20210621015922.ewgbffxuawia7liz@naota-xeon/
> > Fixes: eafa4fd0ad0607 ("btrfs: fix exhaustion of the system chunk array due to concurrent allocations")
>
> So this is a regression in 5.13-rc, the final release is most likely the
> upcoming Sunday. This fixes a deadlock so that's an error that could be
> considered urgent.
>
> Option 1 is to let Aota test it for a day or two (adding it to our other
> branches for testing as well) and then I'll send a pull request on
> Friday at the latest.
>
> Option 2 is to put it to pull request branch with a stable tag, so it
> would propagate to 5.13.1 in three weeks from now.
>
> I'd prefer option 1 for release completeness sake but if there are
> doubts or tests show otherwise, we can always do 2.

Either way is fine for me. I didn't even notice before that it was in
5.13-rcs, I was thinking about 5.12 on top of my head.

The issue is probably easier for Aota to trigger on zoned filesystems,
I suppose it triggers more chunk allocations than non-zoned
filesystems due to the zoned device constraints.

Thanks.
