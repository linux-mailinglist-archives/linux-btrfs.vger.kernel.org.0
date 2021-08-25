Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09B683F74A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Aug 2021 13:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240231AbhHYL7e (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 25 Aug 2021 07:59:34 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:44800 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239257AbhHYL7d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 25 Aug 2021 07:59:33 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8C6D622175;
        Wed, 25 Aug 2021 11:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629892727;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cDD5QvtuBVZB5uy+lxVEKl5IokHjuTiOSPMuPEhm5nw=;
        b=PYd7oNcsMPf+I+7VHYpdmlzeAc0dWPWiuH8u8QdTzUhCU/cfwjPNPq1f9BnnpqmN3LYiJ0
        eyti323Kc18AfX9TVkyqHH8Yf7WIBIBgTKzCvg02UNK5l1zKYLSrmu8EQ/94BBWmkRaODW
        jwN4dO9CLjn4/UOuyHsgxK0qIkUsg6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629892727;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cDD5QvtuBVZB5uy+lxVEKl5IokHjuTiOSPMuPEhm5nw=;
        b=jIzerVyLu9sjhmBNsrBUgx5je/g7+6BehCyjuHS85wTteE0zkWB3+NqM8vceNhquJhgW1a
        b3rveKLlTdazlXAg==
Received: from ds.suse.cz (ds.suse.cz [10.100.12.205])
        by relay2.suse.de (Postfix) with ESMTP id 81EBDA3B89;
        Wed, 25 Aug 2021 11:58:47 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id D2B89DAA71; Wed, 25 Aug 2021 13:55:59 +0200 (CEST)
Date:   Wed, 25 Aug 2021 13:55:59 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] Revert "btrfs: compression: don't try to compress if we
 don't have enough pages"
Message-ID: <20210825115559.GG3379@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20210825054142.11579-1-wqu@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825054142.11579-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 25, 2021 at 01:41:42PM +0800, Qu Wenruo wrote:
> This reverts commit f2165627319ffd33a6217275e5690b1ab5c45763.

At this point the revert is the simplest way to restore the inline
extent compression so that's what I'll probably do. However.
> 
> [BUG]
> It's no longer possible to create compressed inline extent after commit
> f2165627319f ("btrfs: compression: don't try to compress if we don't
> have enough pages").
> 
> [CAUSE]
> For compression code, there are several possible reasons we have a range
> that needs to be compressed while it's no more than one page.
> 
> - Compressed inline write
>   The data is always smaller than one sector.

The missing logic was for the true inline extent. The patch was supposed
to skip compression for single pages other than inline extents, due to
efficiency. So I wonder if we want to do that or just don't bother as
it's probably a negligible amount of wasted time.
> 
> - Compressed subpage write
>   For the incoming subpage compressed write support, we require page
>   alignment of the delalloc range.
>   And for 64K page size, we can compress just one page into smaller
>   sectors.

Oh so the logic would have to be updated to distinguish sectors and
pages, but to simplify the code for subpage compression support it would
be easier to revert it and start from there.
