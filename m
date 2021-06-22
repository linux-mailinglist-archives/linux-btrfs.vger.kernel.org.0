Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8762A3B0C37
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jun 2021 20:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbhFVSEA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Jun 2021 14:04:00 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60334 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbhFVSDU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Jun 2021 14:03:20 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3B5921FD5D;
        Tue, 22 Jun 2021 18:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1624384863;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wIxQs7H3NM027B9JyNqlDmY2Rla17whyStH5yc9bAK4=;
        b=rCIHt8ijEh6WlAI7JIwCO3OoWOs05S1E8VEuAL7i5xtmC9EHyXgXlgIGvHSl2gw8Al0j7+
        U2hr0ri/jDwMtnuJewI2dOAFqTeNSajmTI+vn4aN2rjgbNrvcUlMDyy2fpKcWqGjryfBjz
        /eMh7XbnTUZwIRCM5jTK5ee/PLpLYjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1624384863;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wIxQs7H3NM027B9JyNqlDmY2Rla17whyStH5yc9bAK4=;
        b=O3niNkyDzvlB/MrQFBeh4gguOMhL3BRR7NO5AzlT24O+CCfKYi2bGraEidRB50OWgGwbOv
        wuHOTJ9CSdKIjWDQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id D2307A3B96;
        Tue, 22 Jun 2021 18:01:02 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 01399DA77B; Tue, 22 Jun 2021 19:58:11 +0200 (CEST)
Date:   Tue, 22 Jun 2021 19:58:11 +0200
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org, naohiro.aota@wdc.com,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: fix deadlock with concurrent chunk allocations
 involving system chunks
Message-ID: <20210622175811.GK28158@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org, naohiro.aota@wdc.com,
        Filipe Manana <fdmanana@suse.com>
References: <b8b7b585ec8b7b2924fd5995951a0d16d2e394d7.1624369954.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8b7b585ec8b7b2924fd5995951a0d16d2e394d7.1624369954.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 22, 2021 at 02:54:10PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When a task attempting to allocate a new chunk verifies that there is not
> currently enough free space in the system space_info and there is another
> task that allocated a new system chunk but it did not finish yet the
> creation of the respective block group, it waits for that other task to
> finish creating the block group. This is to avoid exhaustion of the system
> chunk array in the superblock, which is limited, when we have a thundering
> herd of tasks allocating new chunks. This problem was described and fixed
> by commit eafa4fd0ad0607 ("btrfs: fix exhaustion of the system chunk array
> due to concurrent allocations").
> 
> However there are two very similar scenarios where this can lead to a
> deadlock:
> 
> 1) Task B allocated a new system chunk and task A is waiting on task B
>    to finish creation of the respective system block group. However before
>    task B ends its transaction handle and finishes the creation of the
>    system block group, it attempts to allocate another chunk (like a data
>    chunk for an fallocate operation for a very large range). Task B will
>    be unable to progress and allocate the new chunk, because task A set
>    space_info->chunk_alloc to 1 and therefore it loops at
>    btrfs_chunk_alloc() waiting for task A to finish its chunk allocation
>    and set space_info->chunk_alloc to 0, but task A is waiting on task B
>    to finish creation of the new system block group, therefore resulting
>    in a deadlock;
> 
> 2) Task B allocated a new system chunk and task A is waiting on task B to
>    finish creation of the respective system block group. By the time that
>    task B enter the final phase of block group allocation, which happens
>    at btrfs_create_pending_block_groups(), when it modifies the extent
>    tree, the device tree or the chunk tree to insert the items for some
>    new block group, it needs to allocate a new chunk, so it ends up at
>    btrfs_chunk_alloc() and keeps looping there because task A has set
>    space_info->chunk_alloc to 1, but task A is waiting for task B to
>    finish creation of the new system block group and release the reserved
>    system space, therefore resulting in a deadlock.
> 
> In short, the problem is if a task B needs to allocate a new chunk after
> it previously allocated a new system chunk and if another task A is
> currently waiting for task B to complete the allocation of the new system
> chunk.
> 
> Fix this by making a task that previously allocated a new system chunk to
> not loop at btrfs_chunk_alloc() and proceed if there is another task that
> is waiting for it.
> 
> Reported-by: Naohiro Aota <naohiro.aota@wdc.com>
> Link: https://lore.kernel.org/linux-btrfs/20210621015922.ewgbffxuawia7liz@naota-xeon/
> Fixes: eafa4fd0ad0607 ("btrfs: fix exhaustion of the system chunk array due to concurrent allocations")

So this is a regression in 5.13-rc, the final release is most likely the
upcoming Sunday. This fixes a deadlock so that's an error that could be
considered urgent.

Option 1 is to let Aota test it for a day or two (adding it to our other
branches for testing as well) and then I'll send a pull request on
Friday at the latest.

Option 2 is to put it to pull request branch with a stable tag, so it
would propagate to 5.13.1 in three weeks from now.

I'd prefer option 1 for release completeness sake but if there are
doubts or tests show otherwise, we can always do 2.
