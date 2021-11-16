Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE1D4537C6
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Nov 2021 17:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbhKPQlv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Nov 2021 11:41:51 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:51530 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbhKPQlv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Nov 2021 11:41:51 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1DA6C1FD33;
        Tue, 16 Nov 2021 16:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637080733;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9V4Scp2VY1Xg4OAB05gefIEP8eteTuvcuI+w2w9k+FM=;
        b=lTmssLL1Uq0aabWCvZFNmdWoZpN537kSBo1cWZCUa3o3Npx/a36MimyWhvHDkW/YABE00N
        9ulXB2fQMvh6Bl64Qhg+fTZVBLgL4FBvm8yqRa9fnzCudbx4EZ4km2UifCeT1AW8XvkSm3
        PyrRfre27c0wa9kbnoOB4KmilLjClTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637080733;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9V4Scp2VY1Xg4OAB05gefIEP8eteTuvcuI+w2w9k+FM=;
        b=UKutfpIMz7rCZCapkX/pKYeMoAImktllryy+FHw3fb255HvVMcb+dH2Sk57tl39wMgKqmH
        6kwE5wWruyOTxeBw==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id EC98DA3B84;
        Tue, 16 Nov 2021 16:38:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 8180CDA799; Tue, 16 Nov 2021 17:38:49 +0100 (CET)
Date:   Tue, 16 Nov 2021 17:38:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 0/7] Use global rsv stealing for evict and clean
 things up
Message-ID: <20211116163849.GT28560@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <cover.1636470628.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1636470628.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Nov 09, 2021 at 10:12:00AM -0500, Josef Bacik wrote:
> v2->v3:
> - Nikolay suggested an additional cleanup, which lead to multiple other cleanups
>   and small fixes.
> 
> v1->v2:
> - Reworked the stealing logic to be inside of the priority metadata loop, since
>   that's the part we care about.
> - Renamed the helper to see if we can steal to can_steal.
> - Added Nikolay's reviewed-by's.
> 
> --- Original email ---
> 
> Hello,
> 
> While trying to remove direct access of fs_info->extent_root I noticed we were
> passing root into btrfs_reserve_metadata_bytes() for the sole purpose of
> stealing from the global reserve if we were doing orphan cleanup.  This isn't
> really necessary anymore, but I needed to clean up a few things
> 
> 1) We have global reserve stealing logic in the flushing code now that does the
>    proper ordering already.  We just hadn't converted evict to this yet, so I've
>    done that.
> 2) Since we already do the global reserve stealing as a part of the reservation
>    process we don't need the extra check to steal from the global reserve if we
>    fail to make our reservation during orphan cleanup.
> 3) Since we no longer need this logic we don't need the orphan_cleanup_state bit
>    in the root so we can remove that.
> 4) Finally with all of this removed we don't have a need for root in
>    btrfs_reserve_metadata_bytes(), so change it to fs_info and change it's main
>    callers as well.
> 
> With that we've got more consistent global reserve stealing handling in evict,
> and I've cleaned up the reservation path so I no longer have to worry about a
> couple of places where we were doing
> btrfs_reserve_metadata_bytes(root->extent_root).  Thanks,
> 
> Josef Bacik (7):
>   btrfs: handle priority ticket failures in their respective helpers
>   btrfs: check for priority ticket granting before flushing
>   btrfs: check ticket->steal in steal_from_global_block_rsv
>   btrfs: make BTRFS_RESERVE_FLUSH_EVICT use the global rsv stealing code
>   btrfs: remove global rsv stealing logic for orphan cleanup
>   btrfs: get rid of root->orphan_cleanup_state
>   btrfs: change root to fs_info for btrfs_reserve_metadata_bytes

Moved from topic branch to misc-next, thanks.
