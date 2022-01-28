Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07EFB4A033A
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jan 2022 22:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351215AbiA1VzW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jan 2022 16:55:22 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54054 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbiA1VzW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jan 2022 16:55:22 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id C39972113D;
        Fri, 28 Jan 2022 21:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643406920;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hrqbwVNEpkhbJ+yZLLUSLud7bgOAu3xvsobvzGxY76M=;
        b=bWk6C/urkv778LRaEPhTu7QxLTHJi+3d/NxD1JLdMJXKfI5mo38P5bZgJD9jL240yJyDhV
        rbBZbZQZYJ/aog+gGStCTNt/0hCxXiDhoTuPL/cRKEAKbBokh6JnYlBvY84wayRLmAlGLH
        ZvJm1Mc0u3A98UtXzWg2yA8rQrDcnhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643406920;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hrqbwVNEpkhbJ+yZLLUSLud7bgOAu3xvsobvzGxY76M=;
        b=WF98r0ljo+HV/hDpYZj4+vdC6qpGA9Pg8X18hFvC+lpWc661i2eVCMQD0M4hms0d1A0sj7
        DSe5vGd9NWG9wuBQ==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id BA9F4A3B88;
        Fri, 28 Jan 2022 21:55:20 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id AE44DDA7A9; Fri, 28 Jan 2022 22:54:38 +0100 (CET)
Date:   Fri, 28 Jan 2022 22:54:38 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 0/3] btrfs: fixes for defrag_check_next_extent()
Message-ID: <20220128215438.GJ14046@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <cover.1643354254.git.wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1643354254.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 28, 2022 at 03:21:19PM +0800, Qu Wenruo wrote:
> That function is reused between older kernels (v5.15) and the refactored
> defrag code (v5.16+).
> 
> However that function has one long existing bugs affecting defrag to
> handle preallocated range.
> 
> And it can not handle compressed extent well neither.
> 
> Finally there is an ambiguous check which doesn't make much sense by
> itself, and can be related by enhanced extent capacity check.
> 
> This series will fix all the 3 problem mentioned above.
> 
> Changelog:
> v2:
> - Use @extent_thresh from caller to replace the harded coded threshold
>   Now caller has full control over the extent threshold value.
> 
> - Remove the old ambiguous check based on physical address
>   The original check is too specific, only reject extents which are
>   physically adjacent, AND too large.
>   Since we have correct size check now, and the physically adjacent check
>   is not always a win.
>   So remove the old check completely.
> 
> v3:
> - Split the @extent_thresh and physicall adjacent check into other
>   patches
> 
> - Simplify the comment 
> 
> v4:
> - Fix the @em usage which should be @next.
>   As it will fail the submitted test case.
> 
> Qu Wenruo (3):
>   btrfs: defrag: don't try to merge regular extents with preallocated
>     extents
>   btrfs: defrag: don't defrag extents which is already at its max
>     capacity
>   btrfs: defrag: remove an ambiguous condition for rejection

Added as topic branch to for-next, thanks.
