Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 569E445AE1B
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Nov 2021 22:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238848AbhKWVSH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Nov 2021 16:18:07 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:38552 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbhKWVSE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Nov 2021 16:18:04 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4FDD91FD29;
        Tue, 23 Nov 2021 21:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637702095;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GHp6q//Q87eyDS52GkM/17NU3C4yc/9u2AlvyYnVrCA=;
        b=mag85DelrhUJi0aoDpuEaJqizjfvoSRg+nkeaRHjV/ExYkoKio7ma7is3Dm3KjRQH8gEPI
        /l/BSktNx5bAtbwOCKFa3hxSnAAo7gUkLkKaCMjKabuLTomYHt86kGNCKSu0JjQwAx2YTc
        Bd9UKRPhfnuEv9WK91EkqJucyJoHUmo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637702095;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GHp6q//Q87eyDS52GkM/17NU3C4yc/9u2AlvyYnVrCA=;
        b=mkRavRvrmciafsmeTbfbaQF8HiLIq0fMBJdhD5O8mxH9PUArk4sfGEtE7b9IuHxCvT7RGQ
        wkNbQildOnmTwZAA==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 4A85DA3B83;
        Tue, 23 Nov 2021 21:14:55 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D7970DA735; Tue, 23 Nov 2021 22:14:47 +0100 (CET)
Date:   Tue, 23 Nov 2021 22:14:47 +0100
From:   David Sterba <dsterba@suse.cz>
To:     fdmanana@kernel.org
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: make send work with concurrent block group
 relocation
Message-ID: <20211123211447.GT28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, fdmanana@kernel.org,
        linux-btrfs@vger.kernel.org
References: <5d89b416ce3cf1ee64a9f0f11a8fc5bab337ad22.1637582320.git.fdmanana@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d89b416ce3cf1ee64a9f0f11a8fc5bab337ad22.1637582320.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Nov 22, 2021 at 12:03:38PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We don't allow send and balance/relocation to run in parallel in order
> to prevent send failing or silently producing some bad stream. This is
> because while send is using an extent (specially metadata) or about to
> read a metadata extent and expecting it belongs to a specific parent
> node, relocation can run, the transaction used for the relocation is
> committed and the extent gets reallocated while send is still using the
> extent, so it ends up with a different content than expected. This can
> result in just failing to read a metadata extent due to failure of the
> validation checks (parent transid, level, etc), failure to find a
> backreference for a data extent, and other unexpected failures. Besides
> reallocation, there's also a similar problem of an extent getting
> discarded when it's unpinned after the transaction used for block group
> relocation is committed.
> 
> The restriction between balance and send was added in commit 9e967495e0e0
> ("Btrfs: prevent send failures and crashes due to concurrent relocation"),
> kernel 5.3, while the more general restriction between send and relocation
> was added in commit 1cea5cf0e664 ("btrfs: ensure relocation never runs
> while we have send operations running"), kernel 5.14.
> 
> Both send and relocation can be very long running operations. Relocation
> because it has to do a lot of IO and expensive backreference lookups in
> case there are many snapshots, and send due to read IO when operating on
> very large trees. This makes it inconvenient for users and tools to deal
> with scheduling both operations.
> 
> For zoned filesystem we also have automatic block group relocation, so
> send can fail with -EAGAIN when users least expect it or send can end up
> delaying the block group relocation for too long. In the future we might
> also get the automatic block group relocation for non zoned filesystems.
> 
> This change makes it possible for send and relocation to run in parallel.
> This is achieved the following way:
> 
> 1) For all tree searches, send acquires a read lock on the commit root
>    semaphore;
> 
> 2) After each tree search, and before releasing the commit root semaphore,
>    the leaf is cloned and placed in the search path (struct btrfs_path);
> 
> 3) After releasing the commit root semaphore, the changed_cb() callback
>    is invoked, which operates on the leaf and writes commands to the pipe
>    (or file in case send/receive is not used with a pipe). It's important
>    here to not hold a lock on the commit root semaphore, because if we did
>    we could deadlock when sending and receiving to the same filesystem
>    using a pipe - the send task blocks on the pipe because it's full, the
>    receive task, which is the only consumer of the pipe, triggers a
>    transaction commit when attempting to create a subvolume or reserve
>    space for a write operation for example, but the transaction commit
>    blocks trying to write lock the commit root semaphore, resulting in a
>    deadlock;
> 
> 4) Before moving to the next key, or advancing to the next change in case
>    of an incremental send, check if a transaction used for relocation was
>    committed (or is about to finish its commit). If so, release the search
>    path(s) and restart the search, to where we were before, so that we
>    don't operate on stale extent buffers. The search restarts are always
>    possible because both the send and parent roots are RO, and no one can
>    add, remove of update keys (change their offset) in RO trees - the
>    only exception is deduplication, but that is still not allowed to run
>    in parallel with send;
> 
> 5) Periodically check if there is contention on the commit root semaphore,
>    which means there is a transaction commit trying to write lock it, and
>    release the semaphore and reschedule if there is contention, so as to
>    avoid causing any significant delays to transaction commits.
> 
> This leaves some room for optimizations for send to have less path
> releases and re searching the trees when there's relocation running, but
> for now it's kept simple as it performs quite well (on very large trees
> with resulting send streams in the order of a few hundred gigabytes).
> 
> Test case btrfs/187, from fstests, stresses relocation, send and
> deduplication attempting to run in parallel, but without verifying if send
> succeeds and if it produces correct streams. A new test case will be added
> that exercises relocation happening in parallel with send and then checks
> that send succeeds and the resulting streams are correct.
> 
> A final note is that for now this still leaves the mutual exclusion
> between send operations and deduplication on files belonging to a root
> used by send operations. A solution for that will be slightly more complex
> but it will eventually be built on top of this change.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

This is great, thanks, added to misc-next.
