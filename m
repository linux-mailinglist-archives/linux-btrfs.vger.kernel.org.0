Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E22A3A6661
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Jun 2021 14:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbhFNMUE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Jun 2021 08:20:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35394 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbhFNMUD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Jun 2021 08:20:03 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 21A362196B;
        Mon, 14 Jun 2021 12:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623673080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wz6JCTZijdu3k500jXcdJqeCE15aNyOLh3q9Emh+A0Q=;
        b=iKfb+HgM3uWpK5HqhqtxxyALNaOlXTqG+MeRS4Y+vcKWURGdBA5+MVqRzCfhbCu7qXAAF9
        y5Mtd6RNXqudxE6WNDy2ZuIeptgLBoDjwjMrlaUFa7VK2l78ySLVeVlft5p25VJrQLf+aK
        p0mauB1xtFZc1/hoMpkQ2WJNc+ql3Kw=
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id D941C118DD;
        Mon, 14 Jun 2021 12:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1623673080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wz6JCTZijdu3k500jXcdJqeCE15aNyOLh3q9Emh+A0Q=;
        b=iKfb+HgM3uWpK5HqhqtxxyALNaOlXTqG+MeRS4Y+vcKWURGdBA5+MVqRzCfhbCu7qXAAF9
        y5Mtd6RNXqudxE6WNDy2ZuIeptgLBoDjwjMrlaUFa7VK2l78ySLVeVlft5p25VJrQLf+aK
        p0mauB1xtFZc1/hoMpkQ2WJNc+ql3Kw=
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id HtcXMvdIx2C0LwAALh3uQQ
        (envelope-from <nborisov@suse.com>); Mon, 14 Jun 2021 12:17:59 +0000
Subject: Re: [PATCH 1/3] btrfs: rip out may_commit_transaction
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1623421213.git.josef@toxicpanda.com>
 <65fd69e8e230d0d61e70ebade4d6cfe355d3b436.1623421213.git.josef@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Message-ID: <722a8ca7-08c6-e949-c314-04819eeca779@suse.com>
Date:   Mon, 14 Jun 2021 15:17:59 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <65fd69e8e230d0d61e70ebade4d6cfe355d3b436.1623421213.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 11.06.21 г. 17:23, Josef Bacik wrote:
> may_commit_transaction was introduced before the ticketing
> infrastructure existed.  There was a problem where we'd legitimately be
> out of space, but every reservation would trigger a transaction commit
> and then fail.  Thus if you had 1000 things trying to make a
> reservation, they'd all do the flushing loop and thus commit the
> transaction 1000 times before they'd get their ENOSPC.
> 
> This helper was introduced to short circuit this, if there wasn't space
> that could be reclaimed by committing the transaction then simply ENOSPC
> out.  This made true ENOSPC tests much faster as we didn't waste a bunch
> of time.
> 
> However many of our bugs over the years have been from cases where we
> didn't account for some space that would be reclaimed by committing a
> transaction.  The delayed refs rsv space, delayed rsv, many pinned bytes
> miscalculations, etc.  And in the meantime the original problem has been
> solved with ticketing.  We no longer will commit the transaction 1000
> times.  Instead we'll get 1000 waiters, we will go through the flushing
> mechanisms, and if there's no progress after 2 loops we ENOSPC everybody
> out.  The ticketing infrastructure gives us a deterministic way to see
> if we're making progress or not, thus we avoid a lot of extra work.
> 
> So simplify this step by simply unconditionally committing the
> transaction.  This removes what is arguably our most common source of
> early ENOSPC bugs and will allow us to drastically simplify many of the
> things we track because we simply won't need them with this stuff gone.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  fs/btrfs/ctree.h             |   1 -
>  fs/btrfs/space-info.c        | 155 +++--------------------------------
>  include/trace/events/btrfs.h |   3 +-
>  3 files changed, 14 insertions(+), 145 deletions(-)
> 
<snip>

> @@ -1238,31 +1128,12 @@ static void btrfs_preempt_reclaim_metadata_space(struct work_struct *work)
>   *   If we are freeing inodes, we want to make sure all delayed iputs have
>   *   completed, because they could have been on an inode with i_nlink == 0, and
>   *   thus have been truncated and freed up space.  But again this space is not
> - *   immediately re-usable, it comes in the form of a delayed ref, which must be
> - *   run and then the transaction must be committed.
> - *
> - * FLUSH_DELAYED_REFS
> - *   The above two cases generate delayed refs that will affect
> - *   ->total_bytes_pinned.  However this counter can be inconsistent with
> - *   reality if there are outstanding delayed refs.  This is because we adjust
> - *   the counter based solely on the current set of delayed refs and disregard
> - *   any on-disk state which might include more refs.  So for example, if we
> - *   have an extent with 2 references, but we only drop 1, we'll see that there
> - *   is a negative delayed ref count for the extent and assume that the space
> - *   will be freed, and thus increase ->total_bytes_pinned.
> - *
> - *   Running the delayed refs gives us the actual real view of what will be
> - *   freed at the transaction commit time.  This stage will not actually free
> - *   space for us, it just makes sure that may_commit_transaction() has all of
> - *   the information it needs to make the right decision.
> + *   immediately re-usable, it will be pinned, which will be reclaimed by
> + *   committing the transaction.

So you remove the explanation about FLUSH_DELAYED_REFS, yet it's
retained as a distinct state in data flush. So perhaps it should also be
removed from data_flush_state, given that transaction commit, by
definition, runs delayed refs so we don't need it as a discrete step
during data flush ? If I'm wrong then this state requires an updated
rationale.

>   *
>   * COMMIT_TRANS
> - *   This is where we reclaim all of the pinned space generated by the previous
> - *   two stages.  We will not commit the transaction if we don't think we're
> - *   likely to satisfy our request, which means if our current free space +
> - *   total_bytes_pinned < reservation we will not commit.  This is why the
> - *   previous states are actually important, to make sure we know for sure
> - *   whether committing the transaction will allow us to make progress.
> + *   This is where we reclaim all of the pinned space generated by running
> + *   delayed iputs.
>   *
>   * ALLOC_CHUNK_FORCE
>   *   For data we start with alloc chunk force, however we could have been full

<snip>
